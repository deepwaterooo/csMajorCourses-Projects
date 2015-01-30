<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

/* This routine updates the wassManager table for release 2.0+ */


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



/*  
Handle changes in the wassManager table structure from release 1 to release 2.

If we are upgrading from a release prior to 2 to a release 2+, then the wassManager table will have userids but no calendarids.  We check for that condition here, and,
if encountered, we update the table entries with the correct calendarid.

*/

/* Get a resource of all of the wassManager entries that have a userid bu no calendarid */
$oldentries = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE calendarid=""');
/* Go through all of the entries */
$fixed = array();
while ($oldentry = wassSQL::doFetch($oldentries)) {
	$calwlist = wassCalendar::wlistOwnedCalendars($oldentry['userid']);
	foreach ($calwlist as $cal) {
		$update = wassSQL::doQuery('UPDATE ' .  wassParms::DATABASE . '.wassManager SET calendarid=' . $cal->calendarid . ' WHERE (calendarid="" AND userid=' . wassSQL::sqlSafe($oldentry['userid']) . ')');
		$fixed[] = 'Manager ' . $oldentry['managerid'] . ' for user ' .  $oldentry['userid'] . ' fixed to point to calendar ' . $cal->calendarid . '<br />';
		break;
	}	
}
if ($fixed) {
	echo 'Note: the following manager entries were updated:<br />';
	foreach ($fixed as $fix) {
		echo $fix;
	}
}
else
	echo 'No manager entries needed to be updated.<br />';


?>