<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This script creates an ical-formatted calendar (.ics file) of academic calendar events (all day).
 
*/


/* The id of the academic calendar */
$ACCALID = 40;

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

/* See what format is requested */
$fmt = 'ical'; // default
if (isset($_REQUEST['fmt']))
	$fmt = $_REQUEST['fmt'];
elseif (isset($_REQUEST['format']))
	$fmt = $_REQUEST['format'];

/* Init output string as per requested format */
if ($fmt == 'ical')
	$out = "BEGIN:VCALENDAR\r\nPRODID:-//Princeton University Calendar\r\nVERSION:2.0\r\nMETHOD:PUBLISH\r\n";  
elseif ($fmt == 'xml')
	$out = '<?xml version="1.0" encoding="ISO-8859-1"?><data>';	
else
	die ("Unrecognized format (fmt): $fmt");
	

/* Grab the argument */
$id = trim($_REQUEST['id']);
$eid= trim($_REQUEST['eid']);
if (!$id && !$eid)
	die('No id or eid argument passed to retcal.php');

/* Convert request for academic calendar to the right calendar id */
if (strtoupper($id) == 'ACCAL')
	$id = $ACCALID;

/* SPECIAL CASE:  if id=daytypes, then return all of the academic daytypes from the WASS academic calendar */
if (strtoupper($id) == 'DAYTYPES' || strtoupper($id) == 'ALLDAYS') {
	
	/* Get current date */
	$today = date('Y-m-d');	
	/* Read in all of the daytypes, starting with today, ordered by date */
	$days = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAcCal WHERE `date` >= "' . $today .'" ORDER BY `date`');
		
	/* Loop through the dates, adding each as an all-day event */
	while ($day = wassSQL::doFetch($days)) {
		/* Skip repeated dates */
		if ($lastday != $day['date']) {			
		  	/* Add the event */
		  	if ($fmt == 'ical') {
			  /* Convert the date to UTF */
		  	  list($ms,$ds,$ys,$j) = explode('/',wassUtil::usDate(trim($day['date']))); 
		 	  $start =  gmdate('Ymd\THis\Z',mktime(0,0,0,$ms,$ds,$ys));
			  $out .= "BEGIN:VEVENT\r\n";
			  $out .= "DTSTAMP:" . gmdate("Ymd\THis") . "Z\r\n";
			  $out .= "UID:" . date('Ymd\TGis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI'] . "\r\n";
			  // $out .= "DTSTART:" . $start . "\r\n";
			  $out .= 'DTSTART;VALUE=DATE:' . $ys . sprintf('%02u%02u',$ms,$ds) . "\r\n"; 
			  // $out .= 'DTEND;VALUE=DATE:' . $ys . sprintf('%02u%02u',$ms,$ds) . "\r\n";
			  $out .= "SUMMARY:" . wassIcal::nlIcal($day['daytypes']) . "\r\n";
			  $out .= "CLASS:PUBLIC\r\n";
			  $out .= "END:VEVENT\r\n";
		  	}
		  	else {
				$out .= '<event>';
				$out .= tag("title",htmlentities($day['daytypes']));
				$out .= tag('date',$day['date']);
				$out .= '</event>';		  	
		 	}
			$lastday = $day['date'];
		}
	}
	
	
	/* All done if DAYTYPES */
	if (strtoupper($id) == 'DAYTYPES') {
		if ($fmt == 'ical') 
			/* Return the stream */
			wassIcal::returnICAL($out . "END:VCALENDAR\r\n",'PUBLISH','DayTypes');
		else {
			header("Content-Type: text/xml");
			/* Echo the stream */
			echo $out . '</data>';
		}
		exit();
	}
	
	/* Else, continue by adding the academic calendar */
	$id = $ACCALID;
	
}



/* If an entry request, locate the file */
if ($eid) {
	$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (entryid=' . wassSQL::sqlSafe($eid) . ')'));
	if (!$entry)
		die('Unable to find entry ' . $eid);
	$id = $entry['icalendarid'];
}
	
/* Get the file entry */ 
$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (icalendarid=' . wassSQL::sqlSafe($id) . ')');
	
if ($filesq)
	$file = wassSQL::doFetch($filesq);
else
	$file = '';
	
if (!$file)
	die('Unable to find a file with id=' . $id);

	
/* Update the file counters */
$file['lastaccess'] = date('Y-m-d His');
$file['usage'] += 1;

$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET lastaccess=' . wassSQL::sqlSafe($file['lastaccess']) . ', usage=' . wassSQL::sqlSafe($file['usage']) . ' WHERE icalendarid=' . wassSQL::sqlSafe($id));

/* Now read in the events */
if ($eid)
	$events = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (entryid=' . wassSQL::sqlSafe($eid) . ')');
else
	$events = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (icalendarid=' . wassSQL::sqlSafe($id) . ')');



/* Now return the events as an iCal or xml stream */
if ($fmt == 'ical') {
	/* Build and return the ical stream */
	wassIcal::returnICAL($out . buildIcal($events) . "END:VCALENDAR\r\n",'PUBLISH',$file['filename']);
}
else {
	header("Content-Type: text/xml");
	echo $out . buildxml($events);		
}

/* All done */
exit();




/* This function reads through a MySQL resource of file entries and builds a complete xml stream.
	Arguments: The resource that points to the file entries.
	Returns: A complete xml stream.
*/
function buildxml($resource) {
	
  /* Nothing in, nothing back */
  if (!$resource)
	  return '';

  /* Start from the top */
  rewind($resource);
  
  
  /*Init return string */
  $xml = '';
  
  /* Now add in the events */
  while ($event = wassSQL::doFetch($resource)) {
	$xml .= '<event>';
	/* Make sure we cancel, if event has been deleted */
	if ($event['deleted'])
		$xml .= tag('status','cancelled');
	$xml .= tag("title",htmlentities($event['summary']));
	if ($event['description'])
		$xml .= tag("description", htmlentities($event['description']));
	$xml .= tag('date',$event['datestart']);
	$xml .= '</event>';		 
  }
  
  return $xml . '</data>';

}
  
  


/* This function reads through a MySQL resource of file entries and builds a complete iCal stream.
	Arguments: The resource that points to the file entries.
	Returns: A complete iCal stream.
*/
function buildIcal($resource) {
	
   
  /* Nothing in, nothing back */
  if (!$resource)
	  return '';

  /* Start from the top */
  rewind($resource);
  
  
  /*Init the return string */
  $ical = '';
   
  /* Now add in the events */
  while ($event = wassSQL::doFetch($resource)) {
	  
		  /* Convert the date/times to UTF */
		  list($ms,$ds,$ys,$j) = explode('/',wassUtil::usDate(trim($event['datestart']))); 
		  if (trim($event['dateend'])) 
			  list($me,$de,$ye,$j) = explode('/',wassUtil::usDate(trim($event['dateend'])));
		  else
			  list($me,$de,$ye,$j) = explode('/',wassUtil::usDate(trim($event['datestart'])));
				  
		  if (trim($event['timestart']))
			  list($sh,$sm,$j) = explode(':',trim($event['timestart']));
		  else 
			  $sh = '';
			  
		  if ($sh)
			  $dtstart = 'DTSTART:' . gmdate('Ymd\THis\Z',mktime($sh,$sm,0,$ms,$ds,$ys));
		  else
			  $dtstart = 'DTSTART;VALUE=DATE:' .  $ys . sprintf('%02u%02u',$ms,$ds); 
		  
	  
			  
		  if (trim($event['timeend']))
			  list($eh,$em,$j) = explode(':',trim($event['timeend']));
		  else
			  $eh = '';
			  
		  if ($eh) 
			  $dtend =  'DTEND:' . gmdate('Ymd\THis\Z',mktime($eh,$em,0,$me,$de,$ye));
		  else
			  $dtend = 'DTEND;VALUE=DATE:'  . $ye . sprintf('%02u%02u',$me,$de);
  
		  if (!$event['timeend'] && !$event['dateend'])
			  $dtend = '';
	  
	  
	  
		  $ical .= "BEGIN:VEVENT\r\n";
		  
		  /* Make sure we cancel, if event has been deleted */
		  if ($event['deleted'])
		  	$ical .= "STATUS:CANCELLED" . "\r\n";
		  $ical .= "DTSTAMP:" . $event['dtstamp'] . "\r\n";
		  $ical .= "UID:" . $event['uid'] . "\r\n";
		  $ical .= $dtstart . "\r\n";
		  if ($dtend)
			  $ical .= $dtend . "\r\n";
		  if ($event['location'])
			  $ical .= "LOCATION:" . wassIcal::nlIcal($event['location']) . "\r\n";
		  $ical .= "SUMMARY:" . wassIcal::nlIcal($event['summary']) . "\r\n";
		  if ($event['description'])
			  $ical .= "DESCRIPTION:" . wassIcal::nlIcal($event['description']) . "\r\n";
		  $ical .= "SEQUENCE:" . $event['sequence'] . "\r\n";
		  $ical .= "CLASS:PUBLIC\r\n";
		  $ical .= "END:VEVENT\r\n";
    }

  
  /* Send it back */
  return $ical;
	  
}

/* This fuinction returns an xml tag with the specified name and value */
function tag($name,$value) {
	return '<'.$name.'>'.$value.'</'.$name.'>';		
}


?>
