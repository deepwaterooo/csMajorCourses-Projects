<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This script allows an administrator to get a list if users who have blocks in the system.
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


/* Get list of apps */
$users = wassSQL::doQuery('SELECT name FROM ' . wassParms::DATABASE . '.wassAppointment WHERE `date`>="2010-09-01";');

$attrtab = array();

echo '<html><head></head><body>';

/* Now list them */

while ($name = wassSQL::doFetch($users)) {
	list($x,$value) = explode(',',$name['name']);
	$value = trim($value);
	if (!$value) 
		$value = 0;
	$sumtab[$value]++;
}

foreach ($sumtab as $value=>$count) {
	echo '<br />' . $value . '=' . $count;
}
	
echo '</body></html>';
?>