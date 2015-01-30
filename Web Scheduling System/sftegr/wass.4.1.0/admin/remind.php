<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

 
/*

This script sends email reminders to people who have made, or are the targets of, appointments.  It is intended that this script be invoked through an automated process that runs every evening.  It sends reminders out for appointments on the following day, unless invoked with a date argument, in which case it sends out reminders for appointments scheduled on the specified date. 
 
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
 
/* See if argument passed from the command line */
if ($_SERVER['argc'] > 1) {
	list($secret,$pass) = explode("=",$_SERVER['argv'][1]);
	if (strtoupper($secret) == 'SECRET') 
		$_REQUEST['secret'] = $pass;
	elseif ($pass == '')
		$_REQUEST['secret'] = $secret;		
} 

/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}

	 
/* If date passed as argument, use that. */
if (isset($_REQUEST["date"]))
	$date = $_REQUEST["date"];
/* If not passed date, use tomorrow. */
else {
	$tomorrow = mktime() + (60*60*24); /* Next day as Unix timestamp */
	$fulldate = getdate($tomorrow);    /* Convert to date format */
	$date = $fulldate['mon'] . '/' . $fulldate['mday'] . '/' . $fulldate['year'];
}

 
/* Compute tomorrow's date (or passed date) in SQL format */
$sqldate = wassSQL::sqlDate($date);

/* See if we are supposed to ignore the "reminded" flag */
if (isset($_REQUEST["ignore_reminded"]))
	$request = array('date'=>$sqldate,'available'=>1);
else
	$request = array('date'=>$sqldate,'available'=>1,'reminded'=>0);	
 
 
/* Find all available appopintments for tomorrow (or specified date) */	  
$apps = wassAppointment::listMatchingAppointments($request);
	

/* Init appointment counters */
$remindpt=0;  $remindst=0;  $remindmt=0;

/* Go through apps, send email reminders. */

foreach ($apps as $app) { 				
	/* Set up useful subject line */
	$block = wassBlock::find($app->blockid);
	$subject = 'Appointment reminder: ' . $app->name . ' with ' . $block['name'] . ' at ' . wassUtil::AmPm($app->starttime) . ' on ' . date('D',mktime(2,0,0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4))) . ' ' . substr($app->date,5,2) . '/' . substr($app->date,8,2) . '/' . substr($app->date,0,4);
							
	/* Send out notice and get back count of notices sent */
	$sentout = $app->notify('The following appointment is scheduled:<br /><br/>',$subject,'','remind',''); 
	/* Parse out the counts */
	list($remindp, $reminds, $remindm) = explode(',',$sentout);
	/* Accumulate */
	$remindpt += $remindp;  $remindst += $reminds;  $remindmt += $remindm;
	/* Set reminded flag */
	$app->reminded = 1;
	$app->save('reminded');
	
}

 
/* Send summary information to administrator */
$omsg = "<html><head></head><body>Statistics from remind.php:<br />\r\n";
if ($remindst == 0)   
	$omsg .= "No student reminders to send.<br />";
elseif ($remindst == 1)
	$omsg .= "1 student reminder sent.<br />";
else
	$omsg .=  "$remindst student reminders sent.<br />";	
$omsg .= "\r\n";
 
if ($remindpt == 0)   
	$omsg .= "No faculty reminders to send.<br />";
elseif ($remindpt == 1)
	$omsg .= "1 faculty reminder sent.<br />";
else
	$omsg .=  "$remindpt faculty reminders sent.<br />";

	
if ($remindmt == 0)   
	$omsg .= "No manager reminders to send.<br />";
elseif ($remindmt == 1)
	$omsg .= "1 manager reminder sent.<br />";
else
	$omsg .=  "$remindmt manager reminders sent.<br />";

$omsg .= "</body></html>";

/* Let administrator know results */
$headers = "Content-type: text/html\r\n";
if (wassParms::MAILREM) 
	mail(wassParms::SYSMAIL, 'Output of remind.php', $omsg, $headers);  

/* All done */ 

exit();
	
	
