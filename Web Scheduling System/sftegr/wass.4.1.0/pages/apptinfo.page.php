<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page shows the full appointment information for a given appointment.
 
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

/* *** PHP *** */
// right now, the appointment ID is being passed via GET parameter (appt_id).

/* The appointment id is passed as a GET argument */
$appid = $_REQUEST['appt_id'];


/* Read in the appointment */
$errmsg = ''; $infmsg = '';
try {
	$app = new wassAppointment('load',array('appointmentid'=>$appid));
} catch (Exception $error) {
	$errmsg = $error->getMessage();
}

/* Check to see if user authorized to view this appointment */
if (!$errmsg) {
	if (!$app->isViewable($_SESSION['authtype'],$_SESSION['authid']))
		$errmsg = 'You are not authorized to view this appointment.';
	else {
		/* Read in the block */
		$block = new wassBlock('load',array('blockid'=>$app->blockid));
		/* Read in the calendar */
		$calendar = new wassCalendar('load',array('calendarid'=>$app->calendarid));
		/* Parse the whenmade field */
		list($whendate,$whentime,$j)  = explode(' ',trim($app->whenmade));
		$whenmade = wassUtil::usDate($whendate) . ' ' . $whentime;
		if (substr($whendate,0,4) == "0000")
			$whenmade = '';
		
	}
}
/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {	/* User is cancelling this appointment. */	
	
	/* If no errors detected, delete. */
	if (!$errmsg) {
		/* User must own/manage the calendar or own the appointment */
		if (!$app->isOwner($_SESSION['authtype'],$_SESSION['authid']))
			$errmsg = 'You are not authorized to delete this appointment.';
		else {
			/* Disallow if not the block owner and a cancellation deadline has been exceeded */
			if (!$block->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
	  			if ($blockobject->candeadline_reached($app->date,$app->starttime)) 
		  			$errmsg = wassMsg::getMsg(33,array('calendar'));
			}
		}
		if (!$errmsg) {
			$app->delete("");
			$infmsg = 'Appointment deleted';
		}	
	}		
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
<title><?php echo wassUtil::safeHTML(wassParms::SYSID);?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
function closeAndAlert(inMsg) {
	alert(inMsg);
	self.close();
}
function closeAndRefreshOpener() {
	window.opener.reloadPage();
	self.close();
}
</script>
</head>
<?php
if ($infmsg == 'Appointment deleted') {?>
	<body onload="closeAndRefreshOpener();"><?php
}
else {?>
	<body><?php
}?>

<div id="windowTitle">Appointment Information</div>


<div id="formdividerShort"></div>

<form id="frmApptInfo" name="frmApptInfo" action="apptinfo.page.php" method="post">

<div style="margin: 0px 15px 0px 15px; _margin: 0px 20px 0px 20px;">

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	


<fieldset>
<div>
<label style="cursor:default;">Calendar Owner:</label>
<p class="plain"><?php echo $calendar->name;?>&nbsp;</p>
</div>

<div>
<label style="cursor:default;">Block:</label>
<p class="plain"><?php echo $block->title;?>&nbsp;</p>
</div>
</fieldset>

<fieldset id="">
<div style="background-color:#E6E6E6; border-top: solid #CCCCCC 1px; border-bottom: solid #CCCCCC 1px;">

	
	<div>
	<label class="labelLarge" style="cursor:default;">Appointment With</label>
    <p class="plain">&nbsp; </p>
	</div>

	<div>
	<label style="cursor:default;">Name:</label>
	<p class="plain"><?php echo wassUtil::safeHTML($app->name);?>&nbsp;</p>
	</div>
	
	<div>
	<label style="cursor:default;">Telephone:</label>
	<p class="plain"><?php echo wassUtil::safeHTML($app->phone);?>&nbsp;</p>
	</div>
	
	<div>
	<label style="cursor:default;">E-mail:</label>
	<p class="plain"><?php echo wassUtil::safeHTML($app->email);?>&nbsp;</p>
	</div>

	<div>
	<label style="cursor:default;">Txt msg E-mail:</label>
	<p class="plain"><?php echo wassUtil::safeHTML($app->textemail);?>&nbsp;</p>
	</div>

</div>
</fieldset>

<fieldset id="window">
<div>
<label style="cursor:default;">Date:</label>
<p class="plain"><?php echo wassUtil::safeHTML(wassUtil::usDate($app->date));?>&nbsp;</p>
</div>

<div>
<label style="cursor:default;">Time:</label>
<p class="plain"><?php echo wassUtil::safeHTML(wassUtil::AmPm($app->starttime) . ' - ' . wassUtil::AmPm($app->endtime));?>&nbsp;</p>
</div>

<div>
<label style="cursor:default;">Location:</label>
<p class="plain"><?php echo wassUtil::safeHTML($block->location);?>&nbsp;</p>
</div>

<div>
<label style="cursor:default;">Purpose:</label>
<p class="plain"><?php echo wassUtil::safeHTML($app->purpose);?>&nbsp;</p>
</div>

<?php if ($whenmade) {?>
<div>
<label style="cursor:default;">When made:</label>
<p class="plain"><?php echo wassUtil::safeHTML($whenmade);?>&nbsp;</p>
</div>
<?php }?>
</fieldset>

<div class="buttonsShort">
<!--<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="Cancel & Notify" tabindex="2" style="width:100px;">
<input type="hidden" name="appt_id" value="<?php echo $appid;?>" />--><!--KDC, 3-2-2010. Removed -->
</div>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>


</form>

</body>

</html>


<!--                   End of HTML Code                       -->
<?php

?>