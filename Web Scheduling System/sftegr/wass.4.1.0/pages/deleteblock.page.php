<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows users to delete a block or a series.
		Notable GET (and POST) Arguments:
			- block_id: the block to be deleted.
 
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

/* Save the (passed) block_id and numappts */
$blockid = $_REQUEST['block_id'];
$numappts = $_REQUEST['numappts'];

/* Assume no errors */
$action = ''; $errmsg = ''; $infmsg = '';

/* Assume no block or series */
$block = '';
$series = '';

/* Read in the block (and series, if a recurring block) */
if ($blockid) {
	try {
		$block = new wassBlock('load',array('blockid'=>$blockid));
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
	/* Read in the series (if any ) */
	if (is_object($block)) {
		if ($block->recurrence == 'multiple') {
			try {
				$series = new wassSeries('load',array('seriesid'=>$block->seriesid));
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}
		}
	}
}


/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {
	if (!$errmsg ) {
	/* Delete the block or series, as requested */
		if ($series && ($_REQUEST['radDeleteWhat'] == "all")) {
			/* Make sure user is authrized */
			if (!$series->isOwner($_SESSION['authtype'],$_SESSION['authid']))
				$errmsg = 'You are not authorized to delete these blocks.';
			else {	
				$series->delete(wassUtil::slashstrip($_REQUEST['txtMsg']));
				$infmsg = "All blocks deleted";
				$action = "deleted";
			}
		}
		elseif ($block) {
			if (!$block->isOwner($_SESSION['authtype'],$_SESSION['authid']))
				$errmsg = 'You are not authorized to delete this blocks.';
			else {	
				$block->delete(wassUtil::slashstrip($_REQUEST['txtMsg']));
				$infmsg = "Block deleted";
				$action = "deleted";
			}
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
<title><?php echo wassParms::SYSID;?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;

function closeAndRefreshOpener() {
	window.opener.reloadPage();
	self.close();
}

function showHideEmail() {
	var chk = GetElement("chkNoEmail");
	var showhide = "show";
	var elText = GetElement("txtMsg");
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

<?php 
if ($action == 'deleted') {?>
<body onload="closeAndRefreshOpener();"><?php
} else {?>
<body>
<?php } ?>
<div id="windowTitle">Delete Block </div>

<div id="formdividerShort"></div>


<form id="frmDeleteBlock" name="frmDeleteBlock" action="deleteblock.page.php" method="post">
<input type="hidden" id="hidNumAppts" name="hidNumAppts" value="<?php echo $numappts;?>" />
<div style="margin: 0px 15px 0px 15px; _margin: 0px 20px 0px 20px;">
<fieldset id="window">

			<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<!-- *** PHP *** -->
<!-- if this is a recurring block -->
<?php if ($series) {?>
<div class="cr">
<p>What do you want to delete?:</p>
<label><input type="radio" name="radDeleteWhat" tabindex="1" value="only" checked> Only this instance</label>
<label style="_margin-left:183px;"><input type="radio" name="radDeleteWhat" value="all" tabindex="2"> The entire series</label>
</div>
<?php 
}?>
<!-- end -->

<div style="padding: 5px 0px 5px 15px; width: 450px;">
<?php if (!$series && $numappts == 0) { ?>
<p>Are you sure you want to delete the block(s)?</p>
<?php } elseif ($numappts > 0) { ?>
<p>Are you sure you want to delete the block(s) and notify anyone with an appointment?</p>
<?php } ?>

</div>

<?php if ($numappts > 0) { ?>
<div id="divEmailMsg" style="padding: 5px 0px 10px 5px;">
<label for="txtMsg" >Enter message here:</label>
<textarea cols="35" id="txtMsg" name="txtMsg" rows="2" tabindex="3" >Your appointment has been cancelled.</textarea>
</div>
<input type="checkbox" name="chkNoEmail" id="chkNoEmail" tabindex="4" style="margin-left:200px;" onclick="showHideEmail();" /> <?php echo wassAppointment::NONOTIFICATION;?><br /></fieldset>
<?php } ?>

<div class="buttonsShort" style="margin-top:10px;">
<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="Delete" tabindex="5">
<input type="hidden" name="block_id" value="<?php echo $blockid;?>" />
</div>


</fieldset>
</div>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</form>
<!-- END - RECURRING FORM -->
</body>

</html>


<!--                   End of HTML Code                       -->
<?php

?>
