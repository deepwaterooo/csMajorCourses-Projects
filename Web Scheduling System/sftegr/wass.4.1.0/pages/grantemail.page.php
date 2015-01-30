<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows users to grant or deny manager status to his/her calendar.
		This page will be accessed via a link in an email for ease of allowing manager status.
		Notable GET (and POST) arguments:
			- calendarid: the calendarid of the calendar for which manager status will be granted. 		
			- manager: the user ID of the person requesting manager status. 		
 
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


/* Init error/inform message */
$errmsg = '';  $infmsg = '';

/* Save passed calendarid and manager userid */
$calendarid = trim($_REQUEST['calendarid']);
$manager = trim($_REQUEST['manager']);
$password = trim($_REQUEST['p']);

if (!$calendarid)
	$errmsg = "No calendar id passed to grantemail.page.php";
elseif (!$manager)
	$errmsg = "No manager id passed to grantemail.page.php";

else {
  /* Get the target user's calendar */
  try {
	  $cal = new wassCalendar('load',array('calendarid'=>$calendarid));
  } catch (Exception $error) {
	  $errmsg = $error->getMessage();
	  $cal = '';
  }
  if (!$cal)
	  $errmsg = 'Unable to locate calendar with id ' . $calendarid;
}

/* Retrieve the "pending" entry and make sure passwords match */
$pending = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager where `source`="pending" and calendarid=' . $calendarid . ' and managerid="' . $manager . '";'));

if (trim($pending['password']) != trim($password)) 
	die('Invalid credentials presented to the manager grant function.');
	

/*
Handle a form submission.
*/
if ((!$errmsg) && ($_POST['btnSubmit'] || $_POST['btnDeny'])) {

	/* Save authenticated status */
	$_SESSION['authenticated'] = true;
	$_SESSION['authtype'] = 'user';
	$_SESSION['authid'] = $cal->userid;
	
	/* Set up subject line */
	$subject = 'Change in calendar ';
	$subject .= ($cal->group)? 'member':'manager'; 
	$subject .= ' status.';
	
	/* If granting access */
	if ($_POST['btnSubmit']) {
		/* Now update the manager entry in the user's calendar */
		
		$errmsg = $cal->addManager($manager,'user',1,1);
		
		if (!$errmsg) {
			 $msg = 'You have been added as a ';
			 $msg .= ($cal->group)? 'member of':'manager for';
			 $msg .= ' the calendar with title "' . $cal->title . '" belonging to user ' . $cal->userid . ' (' . wassDirectory::getName($cal->userid) . ').' . 
			 '<br /><br />The calendar may be accessed using the following URL:<br />' .
			 '<a href="' . calURL($cal) . '">' . calURL($cal) . '</a>' .
			 '<br /><br />Once you access this calendar, you can click the Help button for assistance.' .
			 "<br /><br />--" . wassParms::SYSID;				
			 /* Let the user know */
			 $infmsg = "User " . $manager . ' has been added as a ';
			 $infmsg .= ($cal->group)? 'member of':'manager for ';
			 $infmsg .= ' your calendar with title "' . $cal->title . '" (and a notification has been sent to the user). You may close this window, or go to a different web page.';
		}
	}
	elseif ($_POST['btnDeny']) {
		/* Remove the manager */
		$errmsg = $cal->removeManager($manager,'');
		if (!$errmsg) {				
			$msg = 'Your request to ';
			$msg .= ($cal->group)? 'be a member of':'manage';
			$msg .= ' the calendar of user ' . $cal->userid . ' (' . wassDirectory::getName($cal->userid) . ') with title "' . $cal->title . '" has been denied.' . "<br /><br />" . wassParms::SYSID;					
			/* Let the user know */
			$infmsg = "User " . $manager . ' has not been added as a ';
			$infmsg .= ($cal->group)? 'member of':'manager for';
			$infmsg .= ' your calendar with title "' . $cal->title . '" (and a notification has been sent to the user). You may close this window, or go to a different web page.';
		}
	}
	/* Send email to the manager */
	if (!$errmsg) {
		$headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $cal->email . "\r\n" . "Errors-To: " . wassParms::SYSMAIL . "\r\n" . "Content-type: text/html\r\n" ;	
		mail(wassDirectory::getEmail($manager), $subject, $msg, $headers);
	}
	/* Now cancel authentication */
	$_SESSION['authenticated'] = false;	
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

function init() {
	var elFirst = GetElement("txtUserID");
	if (elFirst != null)
		elFirst.focus();
}
</script>
</head>

<body onload="init();">

<input type="hidden" id="helptopic" name="helptopic" value="start" />
<div id="windowTitle">Allow/Deny Manager Status</div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm" style="margin-left:20px; margin-right:20px; width:auto;"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<div style="padding: 5px 0px 10px 20px; width: 450px;">
	<h2>Allow</h2>
	<p class="plain2">User <?php echo wassUtil::safeHTML($manager);?> (<?php echo wassUtil::safeHTML(wassDirectory::getName($manager));?>) has requested permission to manage your calendar entitled "<?php echo $cal->title;?>". To grant permission, click Allow.  To deny permission, click Deny.</p>

<form id="frmAllow" name="frmAllow" action="grantemail.page.php" method="post">
<div class="buttonsShort">
<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="ALLOW" tabindex="3">
<input type="submit" id="btnDeny" name="btnDeny" class="button1" value="DENY" tabindex="4">
</div>
<h2 style="text-align:right; padding: 10px 20px 10px 0px">Need help?  <a href="#" onclick="openHelp();return false;">Click here.</a></h2>
<h2 style="text-align:right; padding: 10px 20px 10px 0px"><a href="login.page.php"><?php echo wassParms::SYSID;?> Home Page</a> </h2>
<input type="hidden" name="calendarid" value="<?php echo $calendarid;?>" />
<input type="hidden" name="manager" value="<?php echo $manager;?>" />
<input type="hidden" name="p" value="<?php echo $password;?>" />
</form>
</div>
</body>
</html>


<!--                   End of HTML Code                       -->
<?php
function calURL($cal) {
	
	/* Save the protocol prefixes needed for the urls */
	if ($_SERVER['HTTPS']) 
		$urlhead = 'https://';
	else 
		$urlhead = 'http://';
		
	 
	return $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/viewcalendar.page.php?makeapp=1&cal_id=' . $cal->calendarid;
	 
	
}
?>