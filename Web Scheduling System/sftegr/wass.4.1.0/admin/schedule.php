<?php
/* 
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This script is intended to run "continuously".  It wakes up every minute and checks to see if any events have been scheduled 
		for the current minute, and, if so, executes them, then goes back to sleep.
 
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
	
}/* Init error/inform messages */
$errmsg = '';  $infmsg = '';

/* Init stop flag */
$dostop = false;


/* Record our startup */

$update = wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassEvent (`whendone`,`whathappened`) VALUES (' . wassSQL::sqlSafe(date('Y-m-d H:i:s')) . ', "STARTUP")'); 

/* Get the "next" event in the event queue (if any). */ 

while (1) {
	/* Make sure we are up and running; if not, terminate. */
	wassUtil::OnOff();
	
	/* Get "next" event in the event queue */
	$now = date('Y-m-d H:i:s'); 
	$nextevents = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassEvent WHERE ' .
	             '`when` >=' . wassSQL::sqlSafe($now) . ' ORDER BY `when`;');
	
	while ($nextevent = wassSQL::doFetch($nextevents)) {
		/* Convert start time of next event into count of seconds since epoch */
		$timestamp = mktime(substr($nextevent['when'],11,2),substr($nextevent['when'],14,2),substr($nextevent['when'],17,2),substr($nextevent['when'],5,2),substr($nextevent['when'],8,2),substr($nextevent['when'],0,4));
		/* If within a minute, do it */
		if (abs($timestamp - mktime()) < 60) {
			/* Execute the event */
			$result = dowhat($nextevent['what']); 
			/* Record the result */	
		  	$update = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassEvent SET `whendone`=' . wassSQL::sqlSafe(date('Y-m-d H:i:s')) . ', `whathappened`=' . wassSQL::sqlSafe(substr($result,0,255)) . ' WHERE `eventid`=' . wassSQL::sqlSafe($nextevent['eventid']) . ';'); 	
			/* STOP if requested */
			if ($dostop)
				exit();		
		}
	}
	/* Go to sleep for a minute */
	sleep(60);
}

function dowhat($what) {
	global $dostop;
	/* Execute the requested event (invoke the specified URL) */
	if ($what == 'STOP') {
		$dostop = true;
		return 'STOPPED';
	}
	if (substr($what,0,4) == 'URL=') {
		$url = substr($what,4);
		if ($url)
			return file_get_contents($url);	
	}
	
	if (substr($what,0,5) == 'MAIL=') {
		list($to,$subject,$body) = explode(';',substr($what,5));
		if (mail($to,$subject,$body))
			return 'Mail sent to: ' . $to . ' subject: ' . $subject;
		else 
			return 'Failed sending mail to: ' . $to . ' subject: ' . $subject;	
	}
	
	return '';
}
?>