<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page generates a list of appointments for the user (after checking authentication) with the option to add an appointment. 
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

/* Make sure we are running under SSL (if required) 
wassUtil::CheckSSL();
*/

/* Start session support */
session_start();

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';


/* If not authenticated, send back to authenticate */
if (!$_SESSION['authenticated']) {
	/* Save re-direct information */
	$_SESSION['redirurl'] = 'apps.page.php';
	/* Send user back for authentication */
	header("Location: mlogin.page.php");
	exit();
}


/* Get a list of all of the user's apps */
$userid = trim($_SESSION['authid']);

$apps = new wassList('SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE (userid=' . wassSQL::sqlSafe($userid) . ' OR blockid in (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid=' . wassSQL::sqlSafe($userid) . ')) AND date >=' . wassSQL::sqlSafe(date('Y-m-d')),'Appointment');


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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo wassParms::SYSID;?></title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link rel="stylesheet" href="css/mobile.css" type="text/css" media="Screen" />
<link rel="stylesheet" href="css/mobile.css" type="text/css" media="handheld" />

<script type="text/javascript" language="javascript">
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.sUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";
</script>

</head>
<body>
<form id="frmAppts" name="frmAppts" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post">
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="Your Appointments" />

<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/header.js"></script>
<script type="text/javascript" language="javascript" src="js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content">

<div id="appointmentlist">
<ul>
<?php 
/* If no appointments */
if (!$apps->entries()) {?>
	<li>No pending appointments</li>
<?php
}
else {
	foreach ($apps as $app) {
    	/* Read in the block */
        $block = new wassBlock('load',array('blockid'=>$app->blockid));
		/* Determine who the appointment is with */
		if ($app->userid == $userid)
			$with = $block;
		else
			$with = $app;
		?>
    	<li><?php 
			echo '<span class="listdate">' . wassUtil::usDate($app->date) . '</span>&nbsp;&nbsp;';
			echo '<span class="listtime">' . wassUtil::ampm($app->starttime) . '-' . wassUtil::ampm($app->endtime) . '</span><br>';
			echo '<span class="listname">' . $with->name . '</span>&nbsp;'
				. ' <span class="listpersoninfo">(' . '<a href="mailto:' . $app->email . '">' . $with->userid . '</a>';
			if ($with->phone) echo ' &nbsp;' . $with->phone;
			echo ') </span><br>';
			echo '<span class="listlocation">' . $block->location . '</span><br>';
			if ($app->purpose) echo '<span class="listpurpose"><b>Purpose</b>:' . $app->purpose . '</span>';
			?>
         </li><?php		
	}
}?>
</ul>
</div>
    	
</div>
</form>
</body>
</html>
<!--                   End of HTML Code                       -->
<?php

?>