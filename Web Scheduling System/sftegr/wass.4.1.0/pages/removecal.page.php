<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows users to remove their calendars, along with all blocks and appointments.
		Notable GET (and POST) arguments:
			- cal_id: the calendar ID of the calendar that should be removed.
 
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

/* Init variables to keep track of calendar deletion and error message */
$calremoved = false;
$errmsg = ''; $infmsg = '';

/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

/* Remove the calendar, and close the window */
	/* Get the calendarid */
	$cal_id = trim($_REQUEST['cal_id']);
	/* Get the cancel appointment text */
	$canceltext = trim(wassUtil::slashstrip($_REQUEST['txtMsg']));
	if ($_REQUEST['chkNoMsg'] == "noremind") 
		$canceltext = wassAppointment::NONOTIFICATION;

	/* If we got a calendarid, remove the calendar */
	if ($cal_id) {
		/* Try to load the calendar */
		try {
			$cal = new wassCalendar('load',array('calendarid'=>$cal_id));
			/* Make sure the authenticated user owns the calendar. */
			if (!$cal->canDelete($_SESSION['authtype'], $_SESSION['authid'])) {
				$errmsg = wassUtil::Error(12,array($_SESSION['authid'],'calendar'),'FORMAT');
			}
			/* Now delete the calendar */
			else {
				$calid = $cal->calendarid;
				$cal->delete($canceltext);
				/* Notify sysadmin*/
				if (wassParms::MAILCAL) {
					mail(wassParms::SYSMAIL,'Calendar deleted for ' . $cal->userid . ' (' . $cal->name . ')','','From: ' . wassParms::FROMMAIL . "\r\n" );
				}
				$calremoved = true;
				$infmsg = 'Calendar deleted.';
				if ($_SESSION['cal_id'] == $calid)
					$_SESSION['cal_id'] = '';
				if ($_SESSION['ucal_id'] == $calid)
					$_SESSION['ucal_id'] = '';
				/* Save whether/not user owns a calendar */
				$calids = wassCalendar::arrayOwnedCalendarids($_SESSION['authid']);
				if (count($calids) == 0)
					$_SESSION['owner'] = false;
			}
		} catch (Exception $error) {
			$errmsg = $error->getMessage();
		}	
	}
	else 
		$errmsg = 'No calendarid passed to removecal.';
}
/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><?php echo wassParms::SYSID;?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;

function closeAndRefreshOpener() {
	window.opener.location.href = "login.page.php";
	self.close();
}
function init() {
	var elFirst = GetElement("txtMsg");
	if (elFirst != null)
		elFirst.focus();
}
</script>
</head>

<!-- *** PHP *** -->
<!-- if successful removal of calendar, output: -->
<?php
if ($calremoved) {?>
	<body onload="closeAndRefreshOpener();"><?php
}
else {?>
	<body onload="init();"><?php
}?>

<div id="windowTitle">Remove Calendar</div>

	
<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	
<div style="padding: 5px 0px 0px 20px; width:450px;">
<p class="plain2">Are you sure you want to remove this calendar from the system and cancel all appointments?</p></div>

<form id="frmRemoveCal" name="frmRemoveCal" action="#" method="post">

<fieldset id="window">
<div>
<label for="txtMsg" style="margin-left:-30px;" title="This message will be e-mailed to anyone who has an existing appointment with you.">Enter message here:</label>
<textarea cols="35" name="txtMsg" id="txtMsg" rows="2" tabindex="1" >Your appointment has been canceled.</textarea> 
<input type='checkbox' id='chkNoMsg' name='chkNoMsg' class="chk" value="noremind"><?php echo wassAppointment::NONOTIFICATION;?></input><br />
</div>

</fieldset>

<div class="buttonsShort">
<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="YES - Remove" tabindex="3">
</div>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</form>
</body>
</html>


<!--                   End of HTML Code                       -->
<?php

?>