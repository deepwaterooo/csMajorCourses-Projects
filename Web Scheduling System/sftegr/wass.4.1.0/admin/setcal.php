<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This script creates saves/removes/edits an event in an iCal calendar.
 
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

 
/* Start session support */
session_start();



/* Grab the main arguments */
getmainargs();


/* A request  and a userid are required for all functions */

if (!$request || !$userid)
	die('1 A request and userid must be included in all calls to setcal.');

	


/* Handle the arguments */
if ($request == 'remove') {
	/* Read in the entry */	
	if (!$entryid)
		die('1 You must supply an entryid to remove an entry.');
	$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (entryid=' . wassSQL::sqlSafe($entryid) . ');'));
	if (!$entry)
		die(wassUtil::safeHTML('1 Entry with entryid=' . $entryid . ' not found'));
	/* Read in the file entry, and make sure the user owns it and has the rights */
	$calendarid = $entry['icalendarid'];
	$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (icalendarid=' . wassSQL::sqlSafe($calendarid) . ')');
		
	if ($filesq)
		$file = wassSQL::doFetch($filesq);
	else
		die(wassUtil::safeHTML('1 Unable to find a file with calendarid=' . $calendarid . '.'));
	/* Make sure user has access to this file */
	if (($file['secret'] != $secret) || ($file['userid'] != $userid)  || !$file['secret'])
		die('1 You do not have access to this file.');
		
	/* Remove the entry */
	$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalentry SET deleted=1 WHERE entryid=' . wassSQL::sqlSafe($entryid) . ' LIMIT 1;');
	if ($result) {
			/* Update the event count */
			$events = $file['events'] - 1;
			wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET events=' . $events . ' WHERE  (icalendarid=' .  wassSQL::sqlSafe($calendarid) . ');');
			die('0 Event removed');
		}
		else
			die('1 Event not removed: Error executing: ' . 'UPDATE ' . wassParms::DATABASE . '.wassIcalentry SET deleted=1 WHERE entryid=' . wassSQL::sqlSafe($entryid) . ' LIMIT 1;' . wassSQL::error());
}


if ($request == 'update') {
	/* Init the arguments from the existing entry */	
	if (!$entryid)
		die('1 You must supply an entryid to update an entry.');
	$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (entryid=' . wassSQL::sqlSafe($entryid) . ');'));
	if (!$entry)
		die(wassUtil::safeHTML('1 Entry with entryid=' . $entryid . ' not found'));
	
	$calendarid = $entry['icalendarid'];
    $datestart = wassUtil::usDate($entry['datestart']);
	$timestart = substr($entry['timestart'],0,5);
	$dateend = wassUtil::usDate($entry['dateend']);
	$timeend = substr($entry['timeend'],0,5);
	$event = $entry['event'];
	$description = $entry['description'];
	$location = $entry['location'];	

	if (array_key_exists('datestart',$_REQUEST))
		$datestart = trim($_REQUEST['datestart']);
	if (array_key_exists('timestart',$_REQUEST))
		$timestart = trim($_REQUEST['timestart']);
	if (array_key_exists('dateend',$_REQUEST))
		$dateend = trim($_REQUEST['dateend']);
	if (array_key_exists('timeend',$_REQUEST))
		$timeend = trim($_REQUEST['timeend']);
	if (array_key_exists('event',$_REQUEST))
		$event = trim($_REQUEST['event']);
	if (array_key_exists('description',$_REQUEST))
		$description = trim($_REQUEST['description']);
	if (array_key_exists('location',$_REQUEST))
		$location = trim($_REQUEST['location']);		
	if (array_key_exists('calendarid',$_REQUEST))
		$calendarid = trim($_REQUEST['calendarid']);		
}


elseif ($request == 'add')  {
	/* Read the arguments */
	getargs();
	if (!$calendarid)
		die('1 You must supply a calendarid to add an event.');
}
else
	die('1 request must be set to either add, remove or update.');
	


/* Now execute the add or update */

/* Get the file entry */ 
$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (icalendarid=' . wassSQL::sqlSafe($calendarid) . ')');
	
if ($filesq)
	$file = wassSQL::doFetch($filesq);
else
	die(wassUtil::safeHTML('1 Unable to find a file with calendarid=' . $calendarid . '.'));

/* Make sure user has access to this file */
if (($file['secret'] != $secret) || ($file['userid'] != $userid) || !$file['secret'])
	die('1 You do not have access to this file.');


/* Validate the data */
$infmsg = '1 ';
if (!$event)
	$infmsg .= 'You must supply an event name. ';
else
	$sqlevent = $event;
$sqldescription = $description;
$sqllocation = $location;
if (!$datestart)
	$infmsg .= 'You must supply a start date. ';
if (!wassUtil::isDateValid($datestart))
	$infmsg .= 'Start date must be in mm/dd/yyyy format. ';
else
	$sqldatestart = wassSQL::sqlDate($datestart);
if ($dateend) {
	if (!wassUtil::isDateValid($dateend))
		$infmsg .= 'End date must be in mm/dd/yyyy format. ';
	else
		$sqldateend = wassSQL::sqlDate($dateend);
}
else
	$sqldateend = '';
if ($timestart) {
	if (!($sqltimestart = wassUtil::checkTime($timestart)))
		$infmsg .= 'Start time must be in hh:mm format (use 24-hour notation). ';
}
else
	$sqltimestart = '';
if ($timeend) {
	if (!($sqltimeend = wassUtil::checkTime($timeend)))
		$infmsg .= 'End time must be in hh:mm format (use 24-hour notation). ';	
}
else
	$sqltimeend = '';
	
/* Make sure end time is greater than start time */
if ($sqldateend) {
	if (!$sqltimeend)
		$ttimeend = '00:00';
	else 
		$ttimeend = $sqltimeend;
	if (!$sqltimestart)
		$ttimestart = '00:00';
	else 
		$ttimestart = $sqltimestart;
		
	$start = mktime(substr($ttimestart,0,2),substr($ttimestart,3,2),0,substr($sqldatestart,5,2),substr($sqldatestart,8,2),substr($sqldatestart,0,4));		
	$end = mktime(substr($ttimeend,0,2),substr($ttimeend,3,2),0,substr($sqldateend,5,2),substr($sqldateend,8,2),substr($sqldateend,0,4));		
	
	if ($start > $end)
		$infmsg .= 'Starting date/time must not be after ending date/time. ';
	
}

/* Make sure enough dates/starts were specified */
if ($sqltimestart) {
	if (!$sqltimeend)
		$infmsg .= 'If you specify a start time, then you also need to specify an end time.';
	
}

if ($sqldateend && $sqltimeend) {
	if (!$sqltimestart)	
		$infmsg .= 'If you specify an end date and time, then you also need to specify a start time.';
}
	
/* If an error, let the user know */
if ($infmsg != '1 ')
	die(wassUtil::safeHTML($infmsg));
	
/* Now do the add or update */
if ($request == 'add') {
	$req = 'added';
	/* Build the add query */
	$query = 'INSERT INTO ' . wassParms::DATABASE . '.wassIcalentry (' .
		  'icalendarid,' .
		  'summary,' .
		  'datestart';
		  if ($sqldescription) $query .= ',description';
		  if ($sqllocation) $query .= ',location';
		  if ($sqltimestart) $query .= ',timestart';				
		  if ($sqldateend) $query .= ',dateend';
		  if ($sqltimeend) $query .= ',timeend';
		  $query .= ',dtstamp,
		  uid
		  ) VALUES (' . 
		  $calendarid . ',' . 	
		  wassSQL::sqlSafe($sqlevent) . ',' . 
		  wassSQL::sqlSafe($sqldatestart); 
		  if ($sqldescription) $query .= ',' . wassSQL::sqlSafe($sqldescription);
		  if ($sqllocation) $query .= ',' . wassSQL::sqlSafe($sqllocation);
		  if ($sqltimestart) $query .= ',' . wassSQL::sqlSafe($sqltimestart); 
		  if ($sqldateend) $query .= ',' . wassSQL::sqlSafe($sqldateend);
		  if ($sqltimeend) $query .= ',' . wassSQL::sqlSafe($sqltimeend);
		  $query .= ',' . wassSQL::sqlSafe(gmdate('Ymd\THis') . "Z") . ',' . 
		  wassSQL::sqlSafe(date('Ymd\THis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI']) . 
		  ');';
}
else {
	$req = 'updated';
	$query  = 'UPDATE ' . wassParms::DATABASE . '.wassIcalentry SET summary=' . wassSQL::sqlSafe($sqlevent) . ', ' .
					  'datestart=' . wassSQL::sqlSafe($sqldatestart)  . ',' .
					  'dtstamp=' . wassSQL::sqlSafe(gmdate('Ymd\THis') . "Z");
		  if ($sqldescription)
			  $query .= ', description=' .  wassSQL::sqlSafe($sqldescription);
		  else
			  $query .= ", description=''";
		  if ($sqllocation)
			  $query .= ', location=' .  wassSQL::sqlSafe($sqllocation);
		  else
			  $query .= ",location=''";
		  if ($sqltimestart)
			  $query .= ',timestart=' .  wassSQL::sqlSafe($sqltimestart);
		  else
			  $query .= ",timestart=NULL";						
		  if ($sqldateend)
			  $query .= ',dateend=' .  wassSQL::sqlSafe($sqldateend);
		  else
			  $query .= ",dateend=NULL";
		  if ($sqltimeend)
			  $query .= ',timeend=' .  wassSQL::sqlSafe($sqltimeend);
		  else
			  $query .= ",timeend=NULL";
			  
		  $query .= ' WHERE (entryid=' . wassSQL::sqlSafe($entryid) . ');';	
}

/* Execute the add or update */
$result = wassSQL::doQuery($query);

/* Let the user know what happened */
if ($result) {			
  if ($request == 'add') {	 
  	$eid = wassSQL::insert_id();
  	/* Update the event count */	  
  	$events = $file['events'] + 1;
 	wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET events=' . $events . ' WHERE  (icalendarid=' . $calendarid . ');');
  	/* All done */
  	die('0 Event ' . $eid . ' added.');
  }
  else
  	die('0 Event updated');
}
else
	die('1 Event not ' . $req . ' Error executing: ' .  $query . ';' . wassSQL::error());	

	
/* All done (/

/* This function sets the main script arguments */
function getmainargs() {
	global $calendarid, $request, $secret, $userid, $entryid;
	
	$calendarid = trim($_REQUEST['calendarid']);
	$request = trim($_REQUEST['request']);
	$secret = trim($_REQUEST['secret']);
	$userid = trim($_REQUEST['userid']);
	$entryid = trim($_REQUEST['entryid']);
	
	return;
}


/* This function sets the functional script arguments */
function getargs() {
	global $datestart, $timestart, $dateend, $timeend, $event, $description, $location;
	
	$datestart = trim($_REQUEST['datestart']);
	$timestart = trim($_REQUEST['timestart']);
	$dateend = trim($_REQUEST['dateend']);
	$timeend = trim($_REQUEST['timeend']);
	$event = trim($_REQUEST['event']);
	$description = trim($_REQUEST['description']);
	$location = trim($_REQUEST['location']);	
	
	return;
}
?>
