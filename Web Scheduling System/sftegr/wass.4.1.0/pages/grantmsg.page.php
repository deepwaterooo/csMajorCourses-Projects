<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page appears when a user wants to allow/deny manager status to a person via the grant page, to confirm and get notification details.
 
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
$errmsg = '';  $infmsg = '';


/* Extract passed variables */
$ismember = $_REQUEST['ismember'];
$subtype = $_REQUEST['subtype'];
$owner_id = $_REQUEST['owner_id'];
$user_id = $_REQUEST['user_id'];

/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {







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
function doSubmit() {
	var isNotifyOwner = GetElement("chkNotifyOwner").checked;
	var isNotifyManager = GetElement("chkNotifyManager").checked;
	
	var userID = GetElement("user_id").value;
	var submissionType = GetElement("subtype").value;
	
	//submit on the grant page
	if (submissionType == "Deny")
		window.opener.submitForDeny(userID,isNotifyOwner,isNotifyManager);
	else if (submissionType == "Allow")
		window.opener.submitForAllow(userID,isNotifyOwner,isNotifyManager);
	else if (submissionType == "Update") 
		window.opener.submitForUpdate(userID,isNotifyOwner,isNotifyManager);
	else
		window.opener.submitForAdd(userID,isNotifyOwner,isNotifyManager);
	
	//close this window
	self.close();
	
}
</script>
</head>

<body>
<div id="windowTitle">Confirm <?php echo $_REQUEST['subtype'];?> <?php echo ($ismember)? 'Member':'Manager';?></div>

<div id="formdividerShort"></div>

<form id="frmConfirm" name="frmConfirm" action="#" method="post" class="window" >
<input type="hidden" id="ismember" name="ismember" value="<?php echo $ismember;?>" />
<input type="hidden" id="user_id" name="user_id" value="<?php echo $user_id;?>" />
<input type="hidden" id="owner_id" name="owner_id" value="<?php echo $owner_id;?>" />
<input type="hidden" id="subtype" name="subtype" value="<?php echo $subtype;?>" />

<fieldset id="window">

<div class="cr">
<p style="float:none;width:300px;">Send an email confirming this status change to the</p>
<label style="margin:5px 0px 0px 40px;"><input type="checkbox" id="chkNotifyOwner" name="chkNotifyOwner" value="owner" <?php if (($owner_id != $_SESSION['authid']) && ($subtype != 'Update')) echo ' checked=" checked"';?>> 
Calendar Owner</label>
<br>
<label style="margin:0px 0px 5px 40px;"><input type="checkbox" id="chkNotifyManager" name="chkNotifyManager" value="manager" <?php if (($user_id != $_SESSION['authid']) && ($subtype != 'Update')) echo ' checked=" checked"';?>> 
Calendar <?php echo ($ismember)? 'Member':'Manager';?> (<?php echo $user_id;?>)</label>
</div>

<div class="buttonsShort" style="margin-top:15px;">
<input type="button" id="btnSubmit" name="btnSubmit" class="button1" value="Continue" tabindex="3" onclick="doSubmit();">
</div>
<div id="close" style="margin-top:5px;"><a href="#" onclick="self.close();">Close Window</a></div>

</fieldset>
</form>
</body>

</html>


<!--                   End of HTML Code                       -->
<?php

?>