<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows users to search for a calendar or calendars, 
		and then go to that calendar to make an appointment.
 
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
	
}


/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();

/* If not authenticated, send user back to authenticate. */ 
wassDirectory::authenticate($_SERVER['REQUEST_URI']);

/* Assume no errors */
$errmsg = ''; $infmsg = '';


/* Get list of calendars owned/managed by the user */
$calOwned = ''; $calManaged = ''; $usercals = ''; $calcount = 0;
if ($_SESSION['authtype'] != 'guest') {
	/* Get all calendars owned or managed or membered by this user */
	$usercals = wassCalendar::wlistAllCalendars($_SESSION['authid']);	
	/* Go through them and separate the owned from the managed */
	foreach ($usercals as $cal) {
		$calcount++;
		if (strtoupper($cal->userid) == strtoupper($_SESSION['authid'])) {
			$calOwned = $cal;
			$mycalendarid = $cal->calendarid;
		}
		else
			$calManaged[] = $cal;
	}
	/* rewind($usercals); */
}


/*
Handle a form submission.
*/

/* Have we been posted? */	
if ($_REQUEST['btnSubmit']) {
	/* Build listist string based on user input. */
	if ($_REQUEST['txtNetid']) {
		$loadarg = array('userid'=>trim(wassUtil::slashstrip($_REQUEST['txtNetid'])));
		$orderby = 'ORDER BY userid';
		$spec = wassParms::NETID;
	}
	elseif ($_REQUEST['txtOwner']) {
		$loadarg = array('name,LIKE'=>'%'. trim(wassUtil::slashstrip($_REQUEST['txtOwner'])) . '%');
		$orderby = 'ORDER BY name';
		$spec = 'name';
	}
	elseif ($_REQUEST['txtCalTitle']) {
		$loadarg = array('title,LIKE'=>'%'. trim(wassUtil::slashstrip($_REQUEST['txtCalTitle'])) . '%');
		$orderby = 'ORDER BY title';
		$spec = 'title';
	}
	else 
		$errmsg = 'You must enter a Name or a ' . wassParms::NETID . ' or a title.';
	
	/* If no errors, build the list */
	if (!$errmsg) {
		$calendars = wassCalendar::wlistMatchingCalendars($loadarg,$orderby);
		if (!is_object($calendars))
			$errmsg = 'No calendar found for the specified ' . $spec;
	}
	
	/* If no errors, build list of viewable calendars */
	if (!$errmsg) {
		$calobjects = array();
		foreach ($calendars as $calendar) {
			if (is_object($calendar)) {
				if ($calendar->isViewable($_SESSION['authtype'],$_SESSION['authid']))
					$calobjects[] = $calendar;
			}
		}
		if (!count($calobjects))
			$errmsg = 'Calendar not available for the specified ' . $spec;
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
<script type="text/javascript" language="javascript" src="js/wasscalendar.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/print.css" rel="stylesheet" type="text/css"  media="print" />


<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";
document.sUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";

// KDC, 8-6-2008. Set up javascript calendars
<?php 
/*
Get a list of all of the calendars owned or managed by the authenticated user.
*/
if ($_SESSION['authtype'] != 'guest')
	$wasscalendars = wassCalendar::wlistAllCalendars($_SESSION['authid']);
else
	$wasscalendars = array();
foreach ($wasscalendars as $wasscal) {
	if (is_object($wasscal)) { ?>
WASSCalendar.G_ARRCALENDARS.push(new WASSCalendar(<?php echo $wasscal->calendarid; ?>,"<?php echo $wasscal->userid; ?>","<?php echo wassUtil::safeHTML($wasscal->name); ?>","<?php echo wassUtil::safeHTML($wasscal->title); ?>",<?php echo wassUtil::safeHTML($wasscal->group); ?>,"<?php echo wassUtil::safeHTML(wassManager::listActiveManagers($wasscal->calendarid)); ?>"));
<?php }
	} ?>

function init() {
	var elFirst = GetElement("txtOwner");
	if (elFirst != null)
		elFirst.focus();
}
function doSubmit() {
	return true;
}
</script>
</head>

<body onload="init();">
<form id="frmMakeAppt" name="frmMakeAppt" action="<?php echo $_SERVER['SCRIPT_NAME'];?>#results" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="makeappt" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="Make an Appointment" />
<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />
<input type="hidden" id="helptopic" name="helptopic" value="makeappoint" />

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


<?php 
if ($calcount) {?>
<div class="sectionBox">
	<div class="headingLarge">Your calendar(s):</div>
	<div id="results">
		<table width="745" cellspacing="0" cellpadding="0">
			<tr>
				<td><strong>Calendar Title</strong></td>
				<td><strong>Make Appointment</strong></td>
				<td><strong>Calendar Owner</strong></td>
				<td><strong>Calendar Description</strong></td>
			</tr>
			<tr>
				<td colspan="4"><div id="dividerLong"></div></td>
			</tr>
			<?php 
			$isfirsttime = true;
			foreach ($usercals as $calobject) {
				if (!$isfirsttime) {?>
				<tr><td colspan="4"><div id="dividerLong"></div></td></tr>
				<?php }?>
				<tr>
					<td class="title"><?php echo wassUtil::safeHTML($calobject->title);?></td>
					<td class="appmt"><a href="viewcalendar.page.php?makeapp=1&cal_id=<?php echo $calobject->calendarid;?>" style="text-decoration:underline;">Make Appointment</a></td>				
					<td class="owner"><?php if ($calobject->name) echo wassUtil::safeHTML($calobject->name); else echo wassUtil::safeHTML($calobject->userid);?></td>
					<td class="desc" title="<?php echo wassUtil::safeHTML($calobject->description);?>"><?php echo wassUtil::safeHTML($calobject->description);?></td>
				</tr><?php
			$isfirsttime = false;
			}?>
		</table>
	</div>
</div><?php 
}
else {
	if (($_SESSION['authtype'] != 'guest') && (!$_REQUEST['btnSubmit']))
		$infmsg = 'If you want to make an appointment with someone, enter their ' . wassParms::NETID . ' or name below, then click "Search".  If you want to create a calendar (so that people can make appointments with you), click "Create My Calendar".   If you want to see your appointments, click "Search Appointments".';
} ?>
<div class="sectionBox2" style="padding-bottom:0px;">
	<div class="headingLarge">Search for a Calendar:</div>
<fieldset>
				<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	
	<span class="labelTitle">Fill in Name, <?php echo wassParms::NETID;?>, or Calendar title, then click Search.</span>
	<div>
		<label for="txtOwner" class="mandat" title="The name of the person or group you wish to make an appointment with.">Calendar Owner's Name:</label>
		<input type="text" name="txtOwner" id="txtOwner" tabindex="1" value="" size="35">
        <a href="#" class="smallLink" onclick="openBrowse('name',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop(),'txtOwner');return false;">browse</a>
	</div>
	<div>
		<label for="txtNetid" title="The name typically found before the @ in their e-mail address.">Calendar Owner's <?php echo wassParms::NETID;?>:</label>
		<input type="text" name="txtNetid" id="txtNetid" tabindex="2" value="" size="35">
        <a href="#" class="smallLink" onclick="openBrowse('userid',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop(),'txtNetid');return false;">browse</a>	</div>
	<div>
		<label for="txtCalTitle" class="mandat" title="The title of the calendar.">Calendar Title:</label>
		<input type="text" name="txtCalTitle" id="txtCalTitle" tabindex="3" value="" size="35">
        <a href="#" class="smallLink" onclick="openBrowse('title',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop(),'txtCalTitle');return false;">browse</a>
	</div>

</fieldset>
</div>
	<div class="buttons">
		<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="Search" tabindex="3" onclick="doSubmit();">
	</div>
<?php 
if ($_REQUEST['btnSubmit']) {?>
	<!-- *** PHP *** -->
	<!-- Show this section if user has searched -->
	<?php
	if (!$errmsg) {?>	
	<div class="sectionBox2">
    <a name="results" id="results"></a>
    <div class="headingLarge">Results:</div>	
	<div id="results">

		<table width="745" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding-right:3px;padding-left:3px;"><strong>Calendar Title</strong></td>
				<td style="padding-right:3px;padding-left:3px;"><strong>Make Appointment</strong></td>
				<td style="padding-right:3px;padding-left:3px;"><strong>Calendar Owner</strong></td>
				<td style="padding-right:3px;padding-left:3px;"><strong>Calendar Description</strong></td>
			</tr>
			<tr>
				<td colspan="4"><div id="dividerLong"></div></td>
			</tr>
		
		<!-- *** PHP *** -->
		<!-- Loop over results and output in this format -->
		<?php 
		$isfirsttime = true;
		foreach ($calobjects as $calobject) {	
            if (!$isfirsttime) {?>
            <tr><td colspan="4"><div id="dividerLong"></div></td></tr>
            <?php }?>
			<tr>
				<td style="padding-right:3px;padding-left:3px;"><?php echo wassUtil::safeHTML($calobject->title);?></td>
				<td style="padding-right:3px;padding-left:3px;"><a href="viewcalendar.page.php?makeapp=1&cal_id=<?php echo $calobject->calendarid;?>">Make Appointment</a></td>
				<td style="padding-right:3px;padding-left:3px;"><?php if ($calobject->name) echo wassUtil::safeHTML($calobject->name); else echo wassUtil::safeHTML($calobject->userid);?></td>
				<td class="desc" style="padding-right:3px;padding-left:3px;" title="<?php echo wassUtil::safeHTML($calobject->description);?>"><?php echo wassUtil::safeHTML($calobject->description);?></td>
				</tr><?php
		$isfirsttime = false;
		}?>
		</table><?php
	}?>
	</div><?php
}?>	
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
<?php

?>
