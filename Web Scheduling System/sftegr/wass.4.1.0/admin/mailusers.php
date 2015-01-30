<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This script allows an administrator to send email to various subsets of WASS users (including all users). 
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

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';

/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}


/* If we are invoking ourselves to process the form. */
if ($_POST['submit'] == 'SEND'  || $_POST['submit'] == 'COUNT') {

		/* Open the database */
		wassSQL::openDB();

		/* Send the emails */
	    $headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $_POST["replyto"] . "\r\n" . "Errors-To: " .  wassParms::SYSMAIL . "\r\n";
		$message = stripslashes($_POST["text"]);
		$subject = stripslashes($_POST["subject"]);
		
		$recipients = array();
		$calown = 0; $calman = 0; $calby = 0; $calwith = 0;
		
		/* Get calendar owner emails */
		if (isset($_POST['ownerman']) || isset($_POST['ownernoman'])) {
			/* Get list of all calendars */
			$cals = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassCalendar');
			while ($cal = wassSQL::doFetch($cals)) {
				/* Get list of managers, if any */
				$managers = wassManager::arrayActiveManagers($cal['calendarid']);
				/* Now select based on form settings */
				if ((isset($_POST['ownerman']) && count($managers) != 0) || (isset($_POST['ownernoman']) && count($managers) == 0)) {
					if ($cal['email'] && !in_array($cal['email'], $recipients)) {
						$recipients[] = $cal['email'];
						$calown++;
					}
				}
			}	
		}
			
		/* Get managers */
		if (isset($_POST['man'])) {
			$mans = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager');
			while ($man = wassSQL::doFetch($mans)) {
				if ($man['managerid']) {
					$manemail = wassDirectory::getEmail($man['managerid']);
					if ($manemail && !in_array($manemail, $recipients)) {
						$recipients[] = $manemail;
						$calman++;
					}
				}
			}	
		}		
		
		/* Get people with appointments */		

		$datenow = getdate();
		$today = wassSQL::sqlDate($datenow["mon"] . "/" . $datenow["mday"] . '/' . $datenow["year"]);
		
		if (isset($_POST['by']) || isset($_POST['with'])) {
			$apps = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE (date >= "' . $today . '")');
			while ($app = wassSQL::doFetch($apps)) {
				if (isset($_POST['by'])) {
					if ($app['email'] && !in_array($app['email'],$recipients)) {
						$recipients[] = $app['email'];
						$calby++;
					}
				}
				if (isset($_POST['with'])) {
					$cal = wassCalendar::find($app['calendarid']);
					if ($cal) {
						$calemail = $cal['email'];
						if ($calemail && !in_array($calemail,$recipients)) {
							$recipients[] = $calemail;
							$calwith++;
						}
					}
				}
			}
		}

		/* Now send out the email */
		if ($_POST['submit'] == 'SEND') {
			foreach ($recipients as $recipient) {
				mail($recipient,$subject,$message,$headers);
			}
			$wouldbe = '';
		}
		else
			$wouldbe = ' would be ';
		

		echo "Email " . $wouldbe . "sent to:<br /> $calown Calendar owners, $calman Calendar managers, $calby Appointment makers, $calwith Appointment holders.";
			
		exit();
}

if ($_POST['submit'] == 'EXIT') {
	echo 'Bye.';
	exit;
}



/* We can send email to any of the following mutually-exclusive groups (or combination of groups; select all groups to send to everyone; no-one gets more than one copy of the email): 
	1. Calendar owners who do not have managers.
	2. Calendar owners who do have managers.
	3. Calendar managers.
	4. Students who have expired appointments.
	5. Students who have active appointments.
*/


		
/* 
Prompt for email fields.
*/
?>
<html>
<head>
<title>Mail WASS Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link href="../pages/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body >
<h3 align="right"><em><?php echo wassParms::SYSID;?></em>&nbsp;</h3>
<h1 align="center">Mail WASS Users</h1>
<blockquote>
  <p align="left"> Select the email reipients (TO field), enter a SUBJECT, enter a REPLY-TO email address, enter the
    TEXT of the email, then press SEND.  Click EXIT to cancel sending.</p>
</blockquote>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="POST" name="MailUsers" id="MailUsers">

<blockquote>
  <p>TO (Check one or more boxes.  Note:  no individual will receive more than one copy of the email, even if they match multiple check boxes.):<br />
    &nbsp;&nbsp;
    <input type="checkbox" name="ownernoman"/>
    Owners of calendars that do NOT have a manager.<br />
    &nbsp;&nbsp;
    <input type="checkbox" name="ownerman"/>
    Owners of calendars that DO have a manager.<br />
    &nbsp;&nbsp;
    <input type="checkbox" name="man"/>
    Calendar managers.<br />
    &nbsp;&nbsp;
    <input type="checkbox" name="by"/>
    People who have made appointments for today or any future day.<br />
    &nbsp;&nbsp;
    <input type="checkbox" name="with"/>
    People with whom appointments have been made for today or any future day.<br />
  </p>
  <p>SUBJECT: 
    <input name="subject" type="text" id="subject" size="100">
  </p>
  <p>REPLY-TO: 
    <input name="replyto" type="text" id="replyto" size="100">
  </p>
  <p>TEXT:</p>
  <p name="text" cols="80" rows="20">
    <textarea name="text" cols="80" rows="20"></textarea>
  </p>
  <p>
    <input type="hidden" name="secret" value="<?php echo wassParms::PASS;?>" />
  </p>
</blockquote>
<DIV align="center">
  <blockquote>
    <p>
     <input type="submit" name="submit" value="COUNT">
      &nbsp;&nbsp;&nbsp;
      <input type="submit" name="submit" value="SEND">
      &nbsp;&nbsp;&nbsp;
        <input type=submit name="submit" value="EXIT">
    </p>
  </blockquote>
</DIV>
<blockquote>
  <p>
    </p>
</blockquote>
</form>
</body>
</html>