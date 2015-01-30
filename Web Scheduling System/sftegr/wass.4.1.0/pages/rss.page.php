<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

/* 

This script returns an RSS 2.0 formatted stream of pending appointments for a specified user or blocks for a specified calendar.

https://serverurl/wasshome/pages/rss.page.php?authid=userid
	   
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

/* Authentication:  we treat the user initiating the request as authenticated. */
$_SESSION['authtype'] = 'user';
$_SESSION['authid'] = trim($_REQUEST['authid']);

/* Extract the GET (or POST) action arguments. */
if (!$action = strtoupper(trim($_REQUEST['action'])))
	$action='LISTAPPS';
	
 
	
/* Now select on the action argument */
switch($action) {
	
	case 'LISTAPPS':
		/* Return an icalendar stream of pending appointments for a user */
		
		/* Get the args */
		$userid = $_SESSION['authid'];
		$startdate = trim($_REQUEST['startdate']);
		$enddate = trim($_REQUEST['enddate']);
		$starttime = trim($_REQUEST['starttime']);
		$endtime = trim($_REQUEST['endtime']);
		
		if (!$startdate)
			$startdate = date('Y-m-d');
		
		/* Get the appointment list */
		$ret = wassRss::listApps($userid,$startdate,$enddate,$starttime,$endtime);
		
		/* Return the list as an Rss feed */
		
		header("Content-Type: application/rss+xml");
		echo $ret;
		
		break;
	
	case 'LISTBLOCKS':
		/* Return an icalendar stream of blocks for a calendar */
		
		/* Get the args */
		$calendarid = trim($_REQUEST['calid']);
		$startdate = trim($_REQUEST['startdate']);

		
		/* Return nothing if calid not specified */
		if ($calendarid) 
			/* Get the blocks list in RSS format */
			$ret = wassRss::listBlocks($calendarid,$startdate);
		
		/* Return the list as an Rss feed */
		
		header("Content-Type: application/rss+xml");
		echo $ret;
		
		break;
									
	
	default:
		wassUtil::Error(8,array($action),'HTMLFORMAT,DIE');
		break;


 
}


exit(); 

?>