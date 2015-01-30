<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page appears when a user changes a value on the calendar setup page in the block defaults area to ask the user whether or not he wants the value to be propagated to all existing blocks (future).
 
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
window.onunload = function() {
	//submit the opener
	window.opener.doSubmit();
}
function doYes() {
	//set the propagate value
	window.opener.GetElement("propagate").value = '1';
	doSubmit();
}
function doNo() {
	//set the propagate value
	window.opener.GetElement("propagate").value = '0';	
	doSubmit();
}
function doSubmit() {
	//submit the opener - will happen on the unload event
	//close this window
	self.close();
}

</script>
</head>

<body>
<div id="windowTitle">Propagate Changes?</div>

<div id="formdividerShort"></div>

<form id="frmPropagate" name="frmPropagate" action="#" method="post" class="window" >
<input type="hidden" id="block_id" name="block_id" value="<?php echo $_REQUEST['block_id'];?>" />

<fieldset id="window">

<div style="padding:0px 15px 0px 15px;">
<p>The changes you have made will be used as default values when you add new blocks to your calendar. Would you also like to propagate these changes to blocks already on your calendar?</p>
<label></label>
</div>

<div class="buttonsShortMulti" style="margin-top:15px;margin-bottom:5px;">
<input type="button" id="btnYes" name="btnYes" class="button1" value="Yes" tabindex="1" onclick="doYes();">
<input type="button" id="brnNo" name="brnNo" class="button1" value="No" tabindex="2" onclick="doNo();">
</div>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</fieldset>

</form>
<!-- END - RECURRING FORM -->
</body>

</html>


<!--                   End of HTML Code                       -->
<?php

?>