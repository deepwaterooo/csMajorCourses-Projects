<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page returns a calendar (all blocks and appointments) as an iCal stream.
 
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

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';

/* Get the calendar id. */

if (!($calendarid = $_REQUEST['calendarid']))
	die("No calendarid submitted");
	
/* Get the calendarid */
if (!($cal = new wassCalendar('load',array('calendarid'=>$calendarid))))
	die("Unknow calendard: " . $calendarid);


/* Return the calendar as an ical stream. */
wassIcal::returnICAL(wassIcal::allCalendar($calendarid));

exit();
?>