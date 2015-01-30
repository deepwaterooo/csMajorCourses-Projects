<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows calendar owners and managers to search for appointments.  
		Different fields and layouts appear for owners and managers. 
		Notable POST Arguments:
			- hidDeleteApptID: the appointment ID of the appointment that should be deleted before display
			- hidExport: whether or not the user clicked the export button (csv file)
 
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


/* Set defaults values for the search */
$ssh = 12;
$ssm = 0;
$sam = 'AM';
$eeh = 11;
$eem = 55;
$eam = 'PM';
$savestart = date('n/j/Y');
$savend = '';
$savepurpose = '';

/* Init error/inform message */
$errmsg = ''; $infmsg = '';

/* Array to hold the search results to output to a csv file */
$searchresults = array();
	

/* Check for whether hidDeleteApptID has a value. If so, delete that appointment and display page normally.  Do NOT set hidDeleteApptID to any value. */
if ($_REQUEST['hidDeleteApptID'] > 0) {
	$appid = trim($_REQUEST['hidDeleteApptID']);
	/* Load up the appointment */
	try {
		$appobject = new wassAppointment('load',array('appointmentid'=>$appid));
		/* User must own/manage the calendar or own the appointment */
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
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
}


/*
Handle a form submission.
*/

if (isset($_POST['btnSubmit']) || ($_REQUEST['hidDeleteApptID'] != 0) || ($_REQUEST['hidExport'] != 0)) {
	/* We need to search for appointments matching the specified search criteria. */
	
	/* If a manager, save selected user */
	$selecteduser = '';
	if ($_SESSION['ismanager']) {
		if (isset($_REQUEST['selUserID']))
			$selecteduser = $_REQUEST['selUserID'];
	}
	
	/* Init the selection array */
	$criteria = array();
	
	
	/* For guests, only search for their appointments */
	if ($_SESSION['authtype'] == 'guest')
		$criteria[] = array('email',trim($_SESSION['authid']));
	/* For users, have to include appointments made with them */
	else {
		
		$parenstarted = false;
		/* We want to include the user's own appointments (ones made by/for the authorized
			user), but, if a manager, only when they select their own calendar. */
		if ((!$selecteduser)  || ($selecteduser == $_SESSION['authid'])) {
			$criteria[] = array('userid,=,OR,(',trim($_SESSION['authid']));
			$parenstarted = true;
		}
		
		/* Get list of calendars owned or managed by this user */
		$list = wassCalendar::wlistAllCalendars($_SESSION['authid']);
		/* Build OR string */
		foreach ($list as $cal) {
			if ($selecteduser != '' && $selecteduser != $cal->userid) {
				continue;
			}
			if ($parenstarted)
				$criteria[] = array('calendarid,=,OR',$cal->calendarid);
			else {
				$criteria[] = array('calendarid,=,OR,(',$cal->calendarid);
				$parenstarted = true;
			}		
		}
		
		/* Reset last criteria to use an AND connector and to close the paren */
		$last = count($criteria) - 1;
		list($key,$comp,$conn) = explode(',',$criteria[$last][0]);
		if ($parenstarted && $last > 0) {
			$criteria[$last][0] = "$key,$comp,AND,)";
			$parenstarted = false;
		}
		else
			$criteria[$last][0] = "$key,$comp,AND";
	
	}	
				
	/* Now go through the filled in fields */

	if ($savestart = trim(wassUtil::slashstrip($_REQUEST['txtStartDate']))) {
		if (!wassUtil::isDateValid($savestart))
			$errmsg.= 'Invalid start date: ' . $savestart . '; ';
		else 
			$criteria[] = array('date,>=,AND',wassSQL::sqlDate($savestart));
	}

	if ($saveend = trim(wassUtil::slashstrip($_REQUEST['txtEndDate']))) {
		if (!wassUtil::isDateValid($saveend))
			$errmsg .= 'Invalid end date: ' . $saveend . '; ';
		else
			$criteria[] = array('date,<=,AND',wassSQL::sqlDate($saveend));
	}

	if ($_REQUEST['strHour']) {
		$sh = (int) trim(wassUtil::slashstrip($_REQUEST['strHour']));
		$ssh = $sh;
		$sam = trim(wassUtil::slashstrip($_REQUEST['strAMPM']));
		if ($sam == 'PM') {
			if ($sh != 12) 
				$sh += 12;
		}
		if ($sam == 'AM') {
			if ($sh == 12)
				$sh = 0;
		}
		$sm = (int) trim(wassUtil::slashstrip($_REQUEST['strMinute']));
		$ssm = $sm;
		$starttime = sprintf("%02u:%02u",$sh,$sm);
		$criteria[] = array('starttime,>=,AND',$starttime);
	}
	
	if ($_REQUEST['endHour']) {
		$eh = (int) trim(wassUtil::slashstrip($_REQUEST['endHour']));
		$eeh = $eh;
		$eam = trim(wassUtil::slashstrip($_REQUEST['endAMPM']));
		if ($eam == 'PM') {
			if ($eh != 12)
				$eh += 12;
		}
		if ($eam == 'AM') {
			if ($eh == 12)
				$eh = 0;
		}		
		$em = (int) trim(wassUtil::slashstrip($_REQUEST['endMinute']));
		$eem = $em;
		$endtime = sprintf("%02u:%02u",$eh,$em);
		if ($eh < sh || ($eh == $sh && $em <= $sm))
			$errmsg .= 'End time must be > start time; ';
		$criteria[] = array('endtime,<=,AND',$endtime);
		}
	
	if ($savepurpose = trim(wassUtil::slashstrip($_REQUEST['txtPurpose'])))
		$criteria[] = array('purpose,LIKE,AND','%' . $savepurpose . '%"');
	
	if ($savename = trim(wassUtil::slashstrip($_REQUEST['txtName'])))
		$criteria[] = array('name,LIKE,AND', '%' . $savename . '%');
	
	if ($saveuserid = trim(wassUtil::slashstrip($_REQUEST['txtUserID'])))
		$criteria[] = array('userid,=,AND',$saveuserid);
	
	/*	
	if ($savewithname = trim(wassUtil::slashstrip($_REQUEST['txtNameWith'])))
		$criteria[] = array('name,LIKE,AND', '%' . $savewithname . '%');
	
	if ($savewithuserid = trim(wassUtil::slashstrip($_REQUEST['txtUserWith'])))
		$criteria[] = array('userid,=,AND',$savewithuserid);	
	*/	
		
	/* Show the search string */
	/*$infmsg = wassSQL::buildOrderedSelect('wassAppointment',$criteria);*/
	
	/* if no errors: */
	if (!$errmsg) {
		/* Now get list of matching appointments */
		$apps = wassAppointment::listOrderedAppointments($criteria,'ORDER BY date,starttime');
		/* Save viewable matching appointments in an array. */
		$appsarray = array();
		foreach ($apps as $app) {
			if (is_object($app)) 
				if ($app->isViewable($_SESSION['authtype'],$_SESSION['authid']))
					$appsarray[] = $app;
		}
		
		/* If none, set error message */
		if (!count($appsarray))
			$errmsg = 'No appointments found.';
			
		/* KDC 3/15/2012, Export to CSV */
		if ($_REQUEST['hidExport'] != 0 && !isset($_POST['btnSubmit']) ) {
			foreach ($appsarray as $appt) {
				$searchresult = array();
				$block = new wassBlock('load',array('blockid'=>$appt->blockid));
				$searchresult['ApptWith'] = $block->name;
				$searchresult['Block'] = $block->title;
				$searchresult['Location'] = $block->location;
				$searchresult['Date'] = wassUtil::usDate($appt->date);
				$searchresult['StartTime'] = $appt->starttime;
				$searchresult['EndTime'] = $appt->endtime;
				$searchresult['ApptFor'] = $appt->name;
				$searchresult['ApptForEmail'] = $appt->email;
				$searchresult['ApptForTxtMsgEmail'] = $appt->textemail;
				$searchresult['ApptForPhone'] = $appt->phone;
				$searchresult['Purpose'] = $appt->purpose;
				$searchresult['WhenMade'] = $appt->whenmade;
				$searchresults[] = $searchresult;
			}
			wassUtil::writecsvfile($searchresults);
		}
	}

}
/*
Now display the page.
*/
if ($_REQUEST['hidExport'] == 0) {
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
	var elFirst = GetElement("txtStartDate");
	if (elFirst != null)
		elFirst.focus();
}
function reloadPage() {
	//window.location.href = unescape(window.location.pathname) + "?btnSubmit=";
	GetElement("hidDeleteApptID").value = "-1";
	GetElement("hidExport").value = 0; //false
	submitForm();
}
function exporttocsv() {
	GetElement("hidExport").value = 1;
	submitForm();	
}
</script>

<style type="text/css" media="print">
#menu, fieldset {
display:none;
}
#content #results table {
display:block;
}
</style>

</head>

<body onload="init();">
<form id="frmSearchAppts" name="frmSearchAppts" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="searchappts" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="Search Appointments" />
<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />

<input type="hidden" id="hidUCal_id" name="hidUCal_id" value="<?php echo $_SESSION['ucal_id'];?>" />

<input type="hidden" id="hidDeleteApptID" name="hidDeleteApptID" value="0" />
<input type="hidden" id="hidExport" name="hidExport" value="0" />
<input type="hidden" id="helptopic" name="helptopic" value="search" />

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
			
<fieldset>
<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	
<span class="labelTitle">Fill in one or more fields (to restrict the search), then click on <em>Search</em>. </span>
<div>
<label for="txtStartDate" title="Begin searching on this date.">Start:</label>
<input type="text" id="txtStartDate" name="txtStartDate" tabindex="1" size="12" value="<?php echo wassUtil::safeHTML($savestart);?>">&nbsp;<img id="imgStartDate" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtStartDate',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="2" class="imgbutton" />
<label for="txtStartTime" title="Search for appointments starting at this time." class="mandat removed">Start Time:</label>
<label for="strHour" class="mandat removed">Hour:</label>
<select name="strHour" id="strHour" tabindex="3">
<option <?php if ($ssh == 1) echo 'selected="yes"';?> value="1">1</option>
<option <?php if ($ssh == 2) echo 'selected="yes"';?> value="2">2</option>
<option <?php if ($ssh == 3) echo 'selected="yes"';?> value="3">3</option>
<option <?php if ($ssh == 4) echo 'selected="yes"';?> value="4">4</option>
<option <?php if ($ssh == 5) echo 'selected="yes"';?> value="5">5</option>
<option <?php if ($ssh == 6) echo 'selected="yes"';?> value="6">6</option>
<option <?php if ($ssh == 7) echo 'selected="yes"';?> value="7">7</option>
<option <?php if ($ssh == 8) echo 'selected="yes"';?> value="8">8</option>
<option <?php if ($ssh == 9) echo 'selected="yes"';?> value="9">9</option>
<option <?php if ($ssh == 10) echo 'selected="yes"';?> value="10">10</option>
<option <?php if ($ssh == 11) echo 'selected="yes"';?> value="11">11</option>
<option <?php if ($ssh == 12) echo 'selected="yes"';?> value="12">12</option>
</select> :
<label for="strMinute" class="mandat removed">Minutes:</label>
<select name="strMinute" id="strMinute" tabindex="4">
<option <?php if ($ssm == 0) echo 'selected="yes"';?> value="00">00</option>
<option <?php if ($ssm == 5) echo 'selected="yes"';?> value="05">05</option>
<option <?php if ($ssm == 10) echo 'selected="yes"';?> value="10">10</option>
<option <?php if ($ssm == 15) echo 'selected="yes"';?> value="15">15</option>
<option <?php if ($ssm == 20) echo 'selected="yes"';?> value="20">20</option>
<option <?php if ($ssm == 25) echo 'selected="yes"';?> value="25">25</option>
<option <?php if ($ssm == 30) echo 'selected="yes"';?> value="30">30</option>
<option <?php if ($ssm == 35) echo 'selected="yes"';?> value="35">35</option>
<option <?php if ($ssm == 40) echo 'selected="yes"';?> value="40">40</option>
<option <?php if ($ssm == 45) echo 'selected="yes"';?> value="45">45</option>
<option <?php if ($ssm == 50) echo 'selected="yes"';?> value="50">50</option>
<option <?php if ($ssm == 55) echo 'selected="yes"';?> value="55">55</option>
</select>
<label for="strAMPM" class="mandat removed">AM/PM:</label>
<select name="strAMPM" id="strAMPM" tabindex="5">
<option <?php if ($sam == 'AM') echo 'selected="yes"';?> value="AM">AM</option>
<option <?php if ($sam == 'PM') echo 'selected="yes"';?> value="PM">PM</option>
</select>
</div>

<div>
<label for="txtEndDate" title="End searching on this date.">End:</label>
<input type="text" id="txtEndDate" name="txtEndDate" tabindex="6" size="12" value="<?php echo wassUtil::safeHTML($saveend);?>">&nbsp;<img id="imgEndDate" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtEndDate',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="7" class="imgbutton" />
<label for="txtEndTime" title="Search for appointments ending at this time." class="mandat removed">End Time:</label>
<label for="endHour" class="mandat removed">Hour:</label>
<select name="endHour" id="endHour" tabindex="8">
<option <?php if ($eeh == 1) echo 'selected="yes"';?> value="1">1</option>
<option <?php if ($eeh == 2) echo 'selected="yes"';?> value="2">2</option>
<option <?php if ($eeh == 3) echo 'selected="yes"';?> value="3">3</option>
<option <?php if ($eeh == 4) echo 'selected="yes"';?> value="4">4</option>
<option <?php if ($eeh == 5) echo 'selected="yes"';?> value="5">5</option>
<option <?php if ($eeh == 6) echo 'selected="yes"';?> value="6">6</option>
<option <?php if ($eeh == 7) echo 'selected="yes"';?> value="7">7</option>
<option <?php if ($eeh == 8) echo 'selected="yes"';?> value="8">8</option>
<option <?php if ($eeh == 9) echo 'selected="yes"';?> value="9">9</option>
<option <?php if ($eeh == 10) echo 'selected="yes"';?> value="10">10</option>
<option <?php if ($eeh == 11) echo 'selected="yes"';?> value="11">11</option>
<option <?php if ($eeh == 12) echo 'selected="yes"';?> value="12">12</option></select> :
<label for="endMinute" class="mandat removed">Minutes:</label>
<select name="endMinute" id="endMinute" tabindex="9">
<option <?php if ($eem == 0) echo 'selected="yes"';?> value="00">00</option>
<option <?php if (eem == 5) echo 'selected="yes"';?> value="05">05</option>
<option <?php if ($eem == 10) echo 'selected="yes"';?> value="10">10</option>
<option <?php if ($eem == 15) echo 'selected="yes"';?> value="15">15</option>
<option <?php if ($eem == 20) echo 'selected="yes"';?> value="20">20</option>
<option <?php if ($eem == 25) echo 'selected="yes"';?> value="25">25</option>
<option <?php if ($eem == 30) echo 'selected="yes"';?> value="30">30</option>
<option <?php if ($eem == 35) echo 'selected="yes"';?> value="35">35</option>
<option <?php if ($eem == 40) echo 'selected="yes"';?> value="40">40</option>
<option <?php if ($eem == 45) echo 'selected="yes"';?> value="45">45</option>
<option <?php if ($eem == 50) echo 'selected="yes"';?> value="50">50</option>
<option <?php if ($eem == 55) echo 'selected="yes"';?> value="55">55</option>
</select>
<label for="endAMPM" class="mandat removed">AM/PM:</label>
<select name="endAMPM" id="endAMPM" tabindex="10">
<option <?php if ($eam == 'AM') echo 'selected="yes"';?> value="AM">AM</option>
<option <?php if ($eam == 'PM') echo 'selected="yes"';?> value="PM">PM</option>
</select>
</div>

<!-- if a manager, output the following -->
<?php if ($_SESSION['ismanager']) {
	/* Get list of calendars owned/managed by the user */
	$callist = wassCalendar::wlistAllCalendars($_SESSION['authid']);
	if ($callist->entries()) {?>
		<div>
		<label for="selUserID" >Calendar Owner:</label>
		<select name="selUserID" id="selUserID" tabindex="11">
			<option value="">All Calendars</option>
		<?php
		$allready = array();
		foreach ($callist as $cal) {
			if (!in_array($cal->userid,$allready)) {?>
			<option value="<?php echo wassUtil::safeHTML($cal->userid);?>" <?php if ($selecteduser == $cal->userid) echo 'selected="selected"';?>><?php if ($cal->name) echo wassUtil::safeHTML($cal->name) . ' (' . $cal->userid . ')'; else echo wassUtil::safeHTML($cal->userid);?></option><?php
				$allready[] = $cal->userid;
			}
		}?>
		</select>
	</div>
	<br /><?php
	}
}?>

<div>
<label for="txtUserID" title="Search for the person who made the appointment.">Appointment By:</label> 
<input type="text" id="txtUserID" name="txtUserID" tabindex="12" size="12" 
value="<?php echo wassUtil::safeHTML($saveuserid);?>"> enter <?php echo wassParms::NETID;?>
&nbsp;&nbsp;&nbsp;&nbsp; OR
<input type="text" id="txtName" name="txtName" tabindex="13" size="35" 
value="<?php echo wassUtil::safeHTML($savename);?>"> enter name
</div>

<br>
<!--
<div>
<label for="txtUserWith" title="Search for the person with whom the appointment was made.">Appointment With:</label> 
<input type="text" id="txtUserWith" name="txtUserWith" tabindex="14" size="12" 
value="<?php echo wassUtil::safeHTML($savewithuserid);?>"> enter <?php echo wassParms::NETID;?>
&nbsp;&nbsp;&nbsp;&nbsp; OR
<input type="text" id="txtNameWith" name="txtNameWith" tabindex="13" size="35" 
value="<?php echo wassUtil::safeHTML($savewithname);?>"> enter name
</div>

<br>
-->

<!-- end -->
<div>
<label for="txtPurpose" title="Search the appointment purpose.">Purpose:</label>
<input type="text" id="txtPurpose" name="txtPurpose" tabindex="14" size="45" 
value="<?php echo wassUtil::safeHTML($savepurpose);?>">
</div>

<br>
<div class="buttons">
	<input id="btnSubmit" name="btnSubmit" class="button1" value="Search" tabindex="15" type="submit">
</div>
</fieldset>

<?php
if (isset($_REQUEST['btnSubmit']) || ($_REQUEST['hidDeleteApptID'] != 0) || ($_REQUEST['hidExport'] != 0)) {?>
	<?php
	if (!$errmsg) {?>	

	<div style="width:750px;"><div class="headingLarge" style="margin:-10px 0px 0px 10px;_margin-top:0px;">Results:
    <div class="CalHeadPrint"><a href="javascript:print();"><img src="images/print.gif" alt="print" title="Print Results" border="0" class="icon" /></a></div>
        <div class="CalHeadExport"><a href="#" onclick="exporttocsv();" alt="export to csv" title="Export to CSV">Export</a></div>
	</div>
    <br />
	<!--<input type="checkbox" id="chkShowAll" name="chkShowAll" value="" onclick="submitForm();" <?php if (isset($_REQUEST['chkShowAll'])) echo 'checked="yes"';?>/> 
	<span class="small">Show All (past and upcoming)</span>--> </div>
		<div id="results">
		<table width="745" cellspacing="0" cellpadding="0">
		  <tr>
			<td></td>
			<td><strong>Appointment With</strong></td>
			<td><strong>Date</strong></td>
			<td><strong>Start Time</strong></td>
			<td><strong>End Time</strong></td>
			<td><strong>Appointment For</strong></td>
			<td></td>
		  </tr>
		  <tr>
			<td colspan="7"><div id="dividerLong"></div></td>
		  </tr>
			<!-- *** PHP *** -->
			<?php foreach ($appsarray as $app) {?>
				<tr>	
					<td><a href="#" onclick="showApptInfo(<?php echo $app->appointmentid;?>);return false;"><img src="images/information.gif" alt="Appointment Information" border="0" /></a></td>
					<td><a href="viewcalendar.page.php?cal_id=<?php echo $app->calendarid;?>" style="text-decoration:underline;">
						<?php 
						/* Read in the block */
						$block = new wassBlock('load',array('blockid'=>$app->blockid));
						if ($block->name) echo wassUtil::safeHTML($block->name); 
							else echo wassUtil::safeHTML($block->userid);
						/* echo ' ' . '<a href="mailto:' . $cal->email . '">' .  $cal->email . '</a> ' .  $cal->phone; */
						?>
						</a></td>
					<td><?php echo wassUtil::usDate($app->date);?></td>
					<td><?php echo $app->starttime;?></td>
					<td><?php echo $app->endtime;?></td>
					<td><?php if ($app->name) { echo wassUtil::safeHTML($app->name) . ' '; } else { echo wassUtil::safeHTML($app->userid) . ' '; }?><a href="mailto:<?php echo wassUtil::safeHTML($app->email);?>"><?php echo wassUtil::safeHTML($app->email);?></a><?php echo ' ' . wassUtil::safeHTML($app->phone);?></td>
					<?php 
					if (!wassUtil::beforeNow($app->date,$app->starttime)) {?>
						<td><a href="#" onclick="cancelAppt(<?php echo $app->appointmentid;?>);return false;"><img src="images/cancel.gif" alt="Cancel Appointment" width="16" height="16" border="0" /></a></td><?php
					}
					else {?>
						<td><a href="#" onclick="deletePastAppt(<?php echo $app->appointmentid;?>);return false;"><img src="images/cancel.gif" alt="Delete Appointment" width="16" height="16" border="0" /></a></td><?php
					}?>
				</tr><?php
			}?>
		</table>
		</div><?php
	}
			
}
?>

</div>
</td>
</tr>
</table>

</div>

</form>
<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->
</body>
</html>


<!--                   End of HTML Code                       -->
<?php
}
?>
