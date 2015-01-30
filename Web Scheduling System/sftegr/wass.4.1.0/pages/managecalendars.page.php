<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page shows a listing of all calendars managed by a user.  The user can select one or multiple calendars to view.

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

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate();

/* Init error/inform message */
$errmsg = ''; $infmsg = '';

/*
Get a list of all of the calendars owned or managed by the authenticated user.
*/
if ($_SESSION['authtype'] != 'guest')
	$calendars = wassCalendar::wlistAllCalendars($_SESSION['authid']);
else
	$calendars = array();


/* Now extract the owned calendars and the managed calendars and membered calendars */
$owned = array();
$managed = array();
$membered = array();
foreach ($calendars as $cal) {
	if (is_object($cal)) {
		if (strtoupper($cal->userid) == strtoupper($_SESSION['authid'])) 
			$owned[] = $cal;
		elseif ($cal->group)
			$membered[] = $cal;
		else
			$managed[] = $cal;
	}
}


Header('Cache-Control: no-cache');
Header('Pragma: no-cache');


/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

/* No submit on this form. */

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
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
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
<?php foreach ($calendars as $cal) {
	if (is_object($cal)) { ?>
WASSCalendar.G_ARRCALENDARS.push(new WASSCalendar(<?php echo $cal->calendarid; ?>,"<?php echo $cal->userid; ?>","<?php echo wassUtil::safeHTML($cal->name); ?>","<?php echo wassUtil::safeHTML($cal->title); ?>",<?php echo wassUtil::safeHTML($cal->group); ?>,"<?php echo wassUtil::safeHTML(wassManager::listActiveManagers($cal->calendarid)); ?>"));
<?php }
	} ?>

function goToCalViews()
{
	var calcount = updateCalCount();
	//console.log( "parms=" + parms );
//	console.log( document.forms[0].action );
	if ( calcount == 0 )
		alert( 'Please indicate a calendar by clicking "select all" or selecting calendar(s). ' );
	else
		document.forms[0].submit();
}

function updateCalCount() {
	var calcount = 0;
	var parms = "";
	/*var chkMy = GetElement("chkMyCal");
	if (chkMy != null && chkMy.checked) {
		calcount++;
		parms += "?cal_id=" + chkMy.value;
	}*/
	var chkMy = document.getElementsByName("chkMyCal");
	for (var i=0; i < chkMy.length; i++) {
		if (chkMy[i].checked) {
			calcount++;
			if (parms == "") parms += "?cal_id=";
			else parms += ",";
			parms += chkMy[i].value;
		}
	}

	var chkManaged = document.getElementsByName("chkManagedCal");
	for (var i=0; i < chkManaged.length; i++) {
		if (chkManaged[i].checked) {
			calcount++;
			if (parms == "") parms += "?cal_id=";
			else parms += ",";
			parms += chkManaged[i].value;
		}
	}

	//alert( "calcount=" + calcount );
	//alert( "parms=" + parms );

	if (calcount < 1) {
		setItemDisplay("viewcalendar","off");
		setItemDisplay("calendarsetup","off");
	} else {
		setItemDisplay("viewcalendar","on",parms);
		if (calcount == 1)
			setItemDisplay("calendarsetup","on",parms);
		else
			setItemDisplay("calendarsetup","off");
	}

	return calcount;
}

//KDC, 1-13-2010.  Need init now for DYK.
function init() {
	updateCalCount();
	ajax_getDidYouKnow();
}
</script>
</head>

<body onload="initAjax();init();">
<form id="frmManage" name="frmManage" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="managecalendars" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="Manage Calendars" />
<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />
<input type="hidden" id="helptopic" name="helptopic" value="manage" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassParms::CONTACTNAME;?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassParms::CONTACTEMAIL;?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassParms::CONTACTPHONE;?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassParms::INSFNAME;?>" />

<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<input type="hidden" id="hidDYKHeader" name="hidDYKHeader" value="" />
<input type="hidden" id="hidDYKDetails" name="hidDYKDetails" value="" />

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
			<div id="divList">
<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>
			<span class="small">To view more than 1 calendar, check boxes and click "View Calendars." To view a single calendar, click on the title.</span>
			<div class="sectionBox">
            <div class="headingLarge">You own the following calendars:</div>
			<table width="745" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="30"></td>
					<td width="219"><strong>Calendar Title</strong></td>
					<td width="135"><strong>Owner Name</strong></td>
					<td width="175"><strong>Owner E-mail</strong></td>
					<td width="180"><strong>Manager(s)/Member(s)</strong></td>
					<td width="6"><strong>Group?</strong></td>
				</tr>

				<?php foreach ($owned as $cal) {?> <tr><td colspan="6"><div id="dividerLong"></div></td></tr>
				<tr>
					<td><input type="checkbox" id="chkMyCal" name="chkMyCal" value="<?php echo $cal->calendarid;?>" onclick="updateCalCount();" /></td>
					<td><a href="viewcalendar.page.php?cal_id=<?php echo $cal->calendarid;?>"><?php echo wassUtil::safeHTML($cal->title);?></a></td>
					<td><?php echo wassUtil::safeHTML($cal->name);?></td>
					<td><a href="mailto:<?php echo wassUtil::safeHTML($cal->email);?>"><?php echo wassUtil::safeHTML($cal->email);?></a></td>
					<td><?php echo str_replace(",",", ",$cal->listActiveManagers());?></td>
					<td><?php if ($cal->group) echo "Yes"; else echo "No";?></td>
				</tr>
				
				
				<?php
				}?>
				</table>
              </div>
                
				<?php
				if (count($managed)) {?>
					<div class="sectionBox2">
                    <div class="headingLarge">You are managing the following calendar(s):</div>
                    <table width="" cellspacing="0" cellpadding="0" border="0">
                    	<tr>
							<td width="30"></td>
							<td width="219"><strong>Calendar Title</strong></td>
							<td width="135"><strong>Owner Name</strong></td>
							<td width="175"><strong>Owner E-mail</strong></td>
							<td width="186"><strong>Manager(s)</strong></td>
						</tr>
						<tr>
						<td colspan="5"><div id="dividerLong"></div></td>
						</tr>
					<!-- Commented out the Select All check box 
                    <tr>
						<td><input type="checkbox" id="chkManagedCal_All" name="chkManagedCal_All" value="" onclick="SelectAllChk('chkManagedCal',this.checked); updateCalCount();" /></td>
						<td>select all</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>--><?php
					foreach ($managed as $cal) {?>
						<tr>
							<td><input type="checkbox" id="chkManagedCal" name="chkManagedCal" value="<?php echo $cal->calendarid;?>" onclick="updateCalCount();" /></td>
							<td><a href="viewcalendar.page.php?cal_id=<?php echo $cal->calendarid;?>"><?php echo wassUtil::safeHTML($cal->title);?></a></td>
							<td><?php echo wassUtil::safeHTML($cal->name);?></td>
							<td><a href="mailto:<?php echo wassUtil::safeHTML($cal->email);?>"><?php echo wassUtil::safeHTML($cal->email);?></a></td>
							<td><?php echo str_replace(",",", ",$cal->listActiveManagers());?></td>
						</tr><?php
					}?>
				    </table><?php
				}?>
            	</div>

				<?php
				if (count($membered)) {?>
					<div class="sectionBox3">
                    <div class="headingLarge">You are a member of the following calendar(s):</div>
                    <table width="" cellspacing="0" cellpadding="0" border="0">
                    	<tr>
							<td width="30"></td>
							<td width="219"><strong>Calendar Title</strong></td>
							<td width="135"><strong>Owner Name</strong></td>
							<td width="175"><strong>Owner E-mail</strong></td>
							<td width="186"><strong>Member(s)</strong></td>
						</tr>
						<tr>
						<td colspan="5"><div id="dividerLong"></div></td>
						</tr>
					<!-- Commented out the Select All check box 
                    <tr>
						<td><input type="checkbox" id="chkManagedCal_All" name="chkManagedCal_All" value="" onclick="SelectAllChk('chkManagedCal',this.checked); updateCalCount();" /></td>
						<td>select all</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>--><?php
					foreach ($membered as $cal) {?>
						<tr>
							<td><input type="checkbox" id="chkManagedCal" name="chkManagedCal" value="<?php echo $cal->calendarid;?>" onclick="updateCalCount();" /></td>
							<td><a href="viewcalendar.page.php?cal_id=<?php echo $cal->calendarid;?>"><?php echo wassUtil::safeHTML($cal->title);?></a></td>
							<td><?php echo wassUtil::safeHTML($cal->name);?></td>
							<td><a href="mailto:<?php echo wassUtil::safeHTML($cal->email);?>"><?php echo wassUtil::safeHTML($cal->email);?></a></td>
							<td><?php echo str_replace(",",", ",$cal->listActiveManagers());?></td>
						</tr><?php
					}?>
				    </table><?php
				}?>
            </div>


			</div>
			<br>
			<div class="buttonplain"> Apply to Manage Another Calendar
				<input type="button" id="btnApply" name="btnApply" value="Apply" tabindex="25" class="button1" onclick="OpenWin('apply.page.php',830,730);">
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
<?php

?>
