<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page displays all appointments for which the user is currently signed up.
		Notable POST Arguments:
			- hidDeleteApptID: the appointment ID of the appointment that should be deleted before display
			- chkShowAll: when checked, show all past and future appointments. Otherwise, show future only.
*/




/* Handle loading of classes. */
function __autoload($class) {
	/* Set path to wassParms and wassLocal */
	if (($class == 'wassParms') || ($class == 'wassLocal'))
		$parmspath = getenv('WASSPARMS');
	if (!$parmspath)
		$parmspath = '../classes/';
		
	/* Now load the class */ 
	if ($class != 'wassLocal')
		require_once($parmspath.$class.'.class.php');
	else
		@include_once($parmspath.$class.'.class.php');
	
}/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate();

/* Init error/inform messages */
$errmsg = ''; $infmsg = '';

/*
Handle a form submission.
*/
if ($_POST['btnSubmit'] || $_REQUEST['hidDeleteApptID']) {
/* Check for whether hidDeleteApptID has a value. If so, delete that appointment and display page normally.  
Do NOT set hidDeleteApptID to any value. */
	if ($_REQUEST['hidDeleteApptID']) {
		$appid = trim($_REQUEST['hidDeleteApptID']);
		/* Load up the appointment */
		$appobject = new wassAppointment('load',array('appointmentid'=>$appid));
		/* If not owner of appointment/block/calendar, disallow */
		if (!$appobject->isOwner($_SESSION['authtype'],$_SESSION['authid']))
			$errmsg = 'You are not authorized to delete this appointment.';
		else {
			/* Disallow if not the block owner and a cancellation deadline has been exceeded */
			/* Read in the block */
			$block = new wassBlock('load',array('blockid'=>$appobject->blockid));
			if (!$block->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
	  			if ($block->candeadline_reached($appobject->date,$appobject->starttime)) 
		  			$errmsg = wassMsg::getMsg(33,array('calendar'));
			}
		}
		if (!$errmsg) {
			$appobject->delete("");
			$infmsg = 'Appointment deleted';
		}	
	}
}

/*
Look up all of the appointments for the authenticated user.
*/

/* Build select criteria based on authentication credentials. */
$criteria = array();
if ($_SESSION['authtype'] == 'guest') 
	$criteria[] = array('email,=,OR',$_SESSION['authid']);
else
	$criteria[] = array('userid,=,OR',$_SESSION['authid']);

/* We also want to include appointments where the user is being visited */
if ($_SESSION['authtype'] != 'guest') {
	$forapps = wassCalendar::arrayOwnedCalendarids($_SESSION['authid']);
	foreach ($forapps as $appid) {
		$criteria[] = array('calendarid,=,OR',$appid);
	}
}
	
/* Now get a list of all the user's appointments */
$apps = wassAppointment::listOrderedAppointments($criteria,'ORDER BY date, starttime'); 

/* We need to read the appointments into an array, throwing out any that don't meet
the selection criteria (before now). */
$apparray = array();
foreach ($apps as $app) {
	if (is_object($app)) {
		/* If showing all appointments */
		if (isset($_REQUEST['chkShowAll']))
			$apparray[] = $app;
		else {
			/* Else show only if in the future */
			if (!wassUtil::beforeNow($app->date,$app->starttime))
				$apparray[] = $app;
		}
	}
}

/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo wassParms::SYSID;?></title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";

function reloadPage() {
	window.location.href = unescape(window.location.pathname);
}
function submitForm() {
	document.forms[0].submit();
}
function deletePastAppt(inApptID) {
	GetElement("hidDeleteApptID").value = inApptID;
	submitForm();
}
</script>
</head>

<body>
<form id="frmViewAppts" name="frmViewAppts" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidTab" name="hidTab" value="signup" />
<input type="hidden" id="hidPage" name="hidPage" value="viewappts" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="View My Appointments" />
<input type="hidden" id="hidUserID" name="hidUserID" value="<?php if ($_SESSION['authtype'] != '') echo $_SESSION['authid'];?>" />
<input type="hidden" id="hidIsManager" name="hidIsManager" value="<?php echo ($_SESSION['ismanager']) ? 'true' : 'false';?>" />
<input type="hidden" id="hidDeleteApptID" name="hidDeleteApptID" value="" />

<input type="hidden" id="hidUCal_id" name="hidUCal_id" value="<?php echo $_SESSION['ucal_id'];?>" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassParms::CONTACTNAME;?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassParms::CONTACTEMAIL;?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassParms::CONTACTPHONE;?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassParms::INSFNAME;?>" />

<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/header.js"></script>
<script type="text/javascript" language="javascript" src="js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content">
<table cellspacing="0" cellpadding="0">
	<tr>
		<td align="left" valign="top" class="menuTD">
			<!-- MAIN MENU - BEGIN -->
			<script type="text/javascript" language="javascript" src="js/mainmenu.js"></script>
			<!-- MAIN MENU - END -->
		</td>
		<td align="left" valign="top">
			<div id="contentDivider">
			
			<!-- CONTENT GOES HERE -->
			<?php if (!count($apparray)) {?>
				<div id="divList">
					<div id="divNoneSched">You have no appointments scheduled.</div>
				</div><?php
			}
			else {?>
				<div id="divList">

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	
			<div  style="margin-bottom: 20px;"><input type="checkbox" id="chkShowAll" name="chkShowAll" value="" onclick="submitForm();" <?php if (isset($_REQUEST['chkShowAll'])) echo 'checked="yes"';?>/> Show All (past and upcoming)</div>
				
				<table width="745" cellspacing="0" cellpadding="0">
					<tr>
						<td></td>
						<td><strong>Date</strong></td>
						<td><strong>Time</strong></td>
						<td><strong>Location</strong></td>
						<td><strong>Appointment With</strong></td>
						<td><strong>Email</strong></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="7"><div id="dividerLong"></div></td>
					</tr><?php
					foreach ($apparray as $app) {
						/* Need to read in block to get location */
						$block = new wassBlock('load',array('blockid'=>$app->blockid));?>
						<tr>
							<td><a href="#" onclick="showApptInfo(<?php echo $app->appointmentid;?>);return false;"><img src="images/information.png" alt="Appointment Information" border="0" /></a></td>
							<td><?php echo wassUtil::usDate($app->date);?></td>
							<td><?php echo wassUtil::AmPm($app->starttime) . ' - ' . wassUtil::AmPm($app->endtime);?></td>
							<td><?php echo wassUtil::safeHTML($block->location);?></td>
							<td><a href="viewcalendar.page.php?cal_id=<?php echo $app->calendarid;?>"><?php if ($block->name) echo wassUtil::safeHTML($block->name); else echo wassUtil::safeHTML($blocck->userid);?></a></td>
							<td><a href="mailto:<?php echo wassUtil::safeHTML($block->email);?>"><?php echo wassUtil::safeHTML($block->email);?></a></td>
							<!-- *** PHP *** -->
							<!-- if upcoming appointment, output the following -->
							<?php 
							if (!wassUtil::beforeNow($app->date,$app->starttime)) {?>
								<td><a href="#" onclick="cancelAppt(<?php echo $app->appointmentid;?>);"><img src="images/cancel.png" alt="Cancel Appointment" width="16" height="16" border="0" /></a></td><?php
							}
							else {?>
								<td><a href="#" onclick="deletePastAppt(<?php echo $app->appointmentid;?>);"><img src="images/cancel.png" alt="Delete Appointment" width="16" height="16" border="0" /></a></td><?php
							}?>
						</tr><?php
					}
				}?>
			</table>
			</div>
					
			<!-- END CONTENT -->
			
			</div>
		</td>
	</tr>
</table>

</div>

<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->

</form>
</body>
</html>


<!--                   End of HTML Code                       -->