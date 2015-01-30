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

$attr = $_REQUEST['attr'];
if (!$attr)
	$attr = 'title';

/* Get list of active users */
$users = wassSQL::doQuery('SELECT DISTINCT userid FROM ' . wassParms::DATABASE . '.wassBlock WHERE 1;');

$attrtab = array();

/* Now list them */
echo '<html><head></head><body><table border="1"><tr><td>User</td><td>' . $attr . '</td></tr>';
while ($user = wassSQL::doFetch($users)) {
	$value = wassDirectory::getlDIR($user['userid'],$attr);
	echo '<tr><td>' . $user['userid'] . '</td><td>' . $value . '&nbsp;</td></tr>';
	if ($value == '')
		$attrtab['None'][0]++;
	else {
		$attrtab[$value][0]++;	
		if (strpos($value,"Associate Prof") !== false)
			$sumtab['*** Associate Prof'][0]++;
		elseif (strpos($value,"Assistant Prof") !== false)
			$sumtab['*** Assistant Prof'][0]++;
		elseif (strpos($value,"Professor") !== false)
			$sumtab['*** Professor'][0]++;	
		elseif (strpos($value,"Instructor") !== false)
			$sumtab['*** Instructor'][0]++;	
		elseif (strpos($value,"Lecturer") !== false)
			$sumtab['*** Lecturer'][0]++;
		else
			$sumtab['*** Other'][0]++;
	}
}
echo '</table><p>Summary By Class:<br /><table border="1"><tr><td>Value</td><td>Count</td></tr>';
foreach ($sumtab as $name=>$count) {
	echo '<tr><td>' . $name . '</td><td>' . $count[0] . '</td></tr>';
}
echo '</table><p>Summary By ' . $attr . ':<br /><table border="1"><tr><td>Value</td><td>Count</td></tr>';
foreach ($attrtab as $name=>$count) {
	echo '<tr><td>' . $name . '</td><td>' . $count[0] . '</td></tr>';
}
echo '</table></body></html>';
?>