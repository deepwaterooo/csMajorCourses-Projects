<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page appears when a user wants to sync a recurring block to see whether the user wants to sync
		just this instance or the entire series.
 
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
<script type="text/javascript" language="javascript" src="js/calendaractions.js"></script>
<script type="text/javascript" language="javascript">
function doSubmit() {
	var blkID = GetElement("block_id").value;
	var elRecurtype = document.getElementsByName("radSyncWhat");
	var recurtype = "once";
	if (elRecurtype[1].checked == true)
		recurtype = "all";
	
	//open the edit window
	window.opener.doIcalBlock(blkID,recurtype,true);
	
	//close this window
	self.close();
	
}
</script>
</head>

<body>
<div id="windowTitle">Sync Block to Local Calendar</div>

<div id="formdividerShort"></div>


<!-- RECURRING FORM -->
<form id="frmSync" name="frmSync" action="#" method="post" class="window" >
<input type="hidden" id="block_id" name="block_id" value="<?php echo $_REQUEST['block_id'];?>" />

<fieldset id="window">

<div class="cr">
<p>What do you want to synchronize?:</p>
<label><input name="radSyncWhat" tabindex="1" type="radio" value="once" checked="checked"> Only this instance</label>
<label style="_margin-left:183px;"><input name="radSyncWhat" tabindex="2" type="radio" value="multiple"> The entire series</label>
</div>


<div class="buttonsShort" style="margin-top:15px;">
<input type="button" id="btnSubmit" name="btnSubmit" class="button1" value="Go" tabindex="3" onclick="doSubmit();">
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