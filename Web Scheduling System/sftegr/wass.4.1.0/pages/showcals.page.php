<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This scrip looks up the calendars for a user based on their netid (userid).  If only one calendar is found,
	   it redirects the user to that calendar.  If more than one, it redirects to the make calendar page so that the user
	   can select the calendar they want to see.
 
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

/*
Extract the requested netid.
*/
 
$userid = trim(wassUtil::slashstrip($_REQUEST['userid']));

/* If userid not specified, just redirect to the main page. */
if (!$userid) {
	header('Location: login.page.php');	
	exit();
}

/* Find all of the user's calendars */
$usercals = wassCalendar::wlistOwnedCalendars($userid);

/* If no or multiple calendars, send to makeappt */
if ($usercals->entries() != 1) {
	header('Location: makeappt.page.php?btnSubmit=1&txtNetid='.$userid);	
	exit();		
}

/* If one calendar, send user to that calendar */

foreach ($usercals as $cal) {
	header('Location: viewcalendar.page.php?makeapp=1&cal_id='.$cal->calendarid);
	exit();	
}
?>