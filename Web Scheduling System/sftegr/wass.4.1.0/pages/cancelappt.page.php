<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows a user to cancel a particular appointment.
		GET (and POST) Arguments:
			- appt_id: the appointment ID being canceled
 
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

/* The appointment id is passed as a GET argument */
$appid = $_REQUEST['appt_id'];
/* Whether or not an "unavailable" appointment should be made after canceling is passed as a GET argument */
$islock = $_REQUEST['islock'];

/* Assume we have taken no action */
$action = ''; $infmsg = ''; $errmsg = '';  


/* Make sure we have an appointment id */
if (!$appid) {
	$action = 'failed';
	$errmsg = 'No appointment id';
}
else {
  /* Read in the appointment */
  try {
	  $appobject = new wassAppointment('load',array('appointmentid'=>$appid));
  } catch (Exception $error) {
	  $errmsg = $error->getMessage();
  }
  
  /* Read in the block */
  if (!$errmsg) {
	  try {
	  	$block = new wassBlock('load',array('blockid'=>$appobject->blockid));
 	 } catch (Exception $error) {
	  	$errmsg = $error->getMessage();
 	 }
  }
}


/*
Handle a form submission.
*/
if (!$errmsg && $_POST['btnSubmit']) {

	/* If not owner, reject */
	if (!$appobject->isOwner($_SESSION['authtype'],$_SESSION['authid'])) {
		$action = 'failed';
		$errmsg = 'You are not authorized to delete this appointment.';
	}
	else {
		/* Disallow if not the block owner and a cancellation deadline has been exceeded */
		if (!$block->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
			if ($block->candeadline_reached($appobject->date,$appobject->starttime)) {
				$action = 'failed';
				$errmsg = wassMsg::getMsg(33,array('calendar'));
			}
		}
	}
	if (!$errmsg) {
		$appobject->delete(trim(wassUtil::slashstrip($_REQUEST['sDesc'])));
		$action = 'deleted';
		$infmsg = 'Appointment deleted';
	}	
	
}
else {
	if ($errmsg) $action = 'failed';
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

function closeAndAlert(inMsg) {
	alert(inMsg);
	//self.close();
}
function closeAndRefreshOpener() {
	window.opener.reloadPage();
	self.close();
}
function closeAndRefreshWithUnavailAppt() {
	window.opener.addAppt(<?php echo $appobject->blockid?>,'<?php echo $appobject->date?>','<?php echo $appobject->starttime?>','<?php echo $appobject->endtime?>',0);
	self.close();
}
function showHideEmail() {
	var chk = GetElement("chkNoEmail");
	var showhide = "show";
	var elText = GetElement("sDesc");
	if (chk.checked == true) {
		showhide = "hide";
		elText.value = "<?php echo wassAppointment::NONOTIFICATION;?>";
	}
	else {
		elText.value = "Your appointment has been canceled.";
	}
	ShowHideElement("divEmailMsg",showhide);
}
</script>
</head>

<!-- *** PHP *** -->
<?php 
if ($action == 'deleted') {
	if ($islock == 0 || $islock == '0') { ?>
		<body onload="closeAndRefreshOpener();"><?php
	} else { ?>
   		<body onload="closeAndRefreshWithUnavailAppt();"><?php
	}
}
elseif ($action == 'failed') {?>
	<body onload="closeAndAlert('<?php echo $errmsg;?>');"><?php
}
else {?>
	<body><?php
}?>
<div id="windowTitle">Cancel Appointment </div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<div style="padding: 5px 0px 0px 10px; width:450px;">
<p class="plain">Are you sure you want to cancel this appointment and notify the appointee?</p></div>

<form id="frmCancelAppt" name="frmCancelAppt" action="cancelappt.page.php" method="post">

<fieldset id="window">
<div id="divEmailMsg">
<label for="sDesc" style="margin-left:-30px;">Enter message here:</label>
<textarea cols="35" name="sDesc" id="sDesc" rows="2" tabindex="1" >Your appointment has been canceled.</textarea>
</div>
<?php if (is_object($block) && $block->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {?>
<input type="checkbox" name="chkNoEmail" id="chkNoEmail" tabindex="4" style="margin-left:160px;" onclick="showHideEmail();" /><?php echo wassAppointment::NONOTIFICATION;?><br />
<?php } ?>
</fieldset>

<div class="buttonsShort">
  <input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="YES - Cancel" tabindex="3">
<input type="hidden" name="appt_id" value="<?php echo $appid;?>" />
<input type="hidden" name="islock" value="<?php echo $islock;?>" />
</div>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</form>

</body>
</html>

<!--                   End of HTML Code                       -->
<?php

?>