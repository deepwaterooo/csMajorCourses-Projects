<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page appears when a user wants to edit a recurring block to see whether the user wants to edit
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
	
}

/* Make sure we are up and running; if not, terminate with an error message. */
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
	var calID = GetElement("cal_id").value;
	var dt = GetElement("date").value;
	var st = GetElement("starttime").value;
	var et = GetElement("endtime").value;
	var elRecurtype = document.getElementsByName("radEditWhat");
	var recurtype = "instance";
	if (elRecurtype[1].checked == true)
		recurtype = "multiple";
	else if (elRecurtype[2].checked == true)
		recurtype = "fromdate";
	
	//open the edit window
	window.opener.openEditBlock(calID,blkID,recurtype,dt,st,et,true);
	
	//close this window
	self.close();
	
}
</script>
</head>

<body>
<div id="windowTitle">Select Block Type</div>

<div id="formdividerShort"></div>


<!-- RECURRING FORM -->
<form id="frmEdit" name="frmEdit" action="#" method="post" class="window" >
<input type="hidden" id="block_id" name="block_id" value="<?php echo $_REQUEST['block_id'];?>" />
<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $_REQUEST['cal_id'];?>" />
<input type="hidden" id="date" name="date" value="<?php echo $_REQUEST['date'];?>" />
<input type="hidden" id="starttime" name="starttime" value="<?php echo $_REQUEST['starttime'];?>" />
<input type="hidden" id="endtime" name="endtime" value="<?php echo $_REQUEST['endtime'];?>" />

<fieldset id="window">

<div class="cr">
<p>What do you want to edit?:</p>
<label><input name="radEditWhat" tabindex="1" type="radio" value="once" checked="checked"> Only this instance</label>
<label style="_margin-left:183px;"><input name="radEditWhat" tabindex="2" type="radio" value="multiple"> The entire series</label>
<label style="_margin-left:0px;"><input name="radEditWhat" tabindex="3" type="radio" value="fromdate"> The series from <?php echo wassUtil::safeHTML($_REQUEST['date']);?> forward</label>
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