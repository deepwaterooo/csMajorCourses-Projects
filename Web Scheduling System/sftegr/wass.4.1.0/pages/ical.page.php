<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

/* 

The wassIcal.output.php script returns icalendar-formatted streams with information about various wass objects.  For example, it can return an icalendar stream with information about an appointment. It is typically invoked as:

https://serverurl/wasshome/ical/wassIcal.output.php?action=getapp&appid=543712
	   
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
	$action='GETCAL';
	
	
/* Extract the target */
$target =  trim($_REQUEST['target']);
	
/* Now select on the action argument */
switch($action) {

	case 'GETAPP':
		/* Return an iCalendar stream with information on an appointment */
		$appid = trim($_REQUEST['appid']);
		if (!$appid)
			wassUtil::Error(31,array('appid'),'HTMLFORMAT,DIE');
		
		/* Load the appointment */
		try {
			$app = new wassAppointment('load',array('appointmentid'=>$appid));
		} catch (Exception $error) {
			wassUtil::Error(14,array('Unable to locate specified appointment.'),'HTMLFORMAT,DIE');
		}
	
		/* See if user is authorized to 'get' the appointment */
		if (!$app->isViewable($_SESSION['authtype'],$_SESSION['authid']))
			wassUtil::Error(22,array('user','appointment'),'HTMLFORMAT,DIE');
	
		/* Get the owning calendar */
		$cal = new wassCalendar('load',array('calendarid'=>$app->calendarid));
		/* Get the owning block */
		$block = new wassBlock('load',array('blockid'=>$app->blockid));
	
	
		/* Now build an iCalendar stream for the appointment */
		$ret = wassIcal::addApp($app,$block,$target);
	
		/* Return the icalendar stream */
		wassIcal::returnICAL($ret,"PUBLISH",'OfficeHours.ics');
		
		break;
		
	case 'DELAPP':

		/* Return an iCalendar CANCEL stream. */
		$uid = trim(urldecode($_REQUEST['uid']));
		$date = trim(urldecode($_REQUEST['date']));  /* yyyymmdd */
		$ltime = trim(urldecode($_REQUEST['tstart'])); /* hhmmss in local time */
		$dates = gmdate('Ymd',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4)));  /* date in GMT */
		$tstart = gmdate('His',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4))); /* hhmmss in UTC */
		$ltime = trim(urldecode($_REQUEST['tend'])); /* hhmmss */
		$tend = gmdate('His',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4))); /* hhmmss in UTC */	
		$email = trim(urldecode($_REQUEST['email']));
		$sequence =  trim(urldecode($_REQUEST['sequenxe']));
		/* Now build an iCalendar stream for the appointment */
		$ret = wassIcal::delApp($uid,$dates,$tstart,$tend,$email,$sequence);
	
		/* Return the icalendar stream */
		wassIcal::returnICAL($ret,'PUBLISH','OfficeHours.ics');
		
		break;
	
	
	case 'MAILAPP':
		
		/* Return email with an iCalendar stream with information on an appointment */
		$appid = trim($_REQUEST['appid']);
		if (!$appid)
			wassUtil::Error(31,array('appid'),'HTMLFORMAT,DIE');
		
		
		$toid = trim(urldecode($_REQUEST['toid']));
		if (!$toid)
			wassUtil::Error(31,array('toid'),'HTMLFORMAT,DIE');
		
		
		/* Load the appointment */
		try {
			$app = new wassAppointment('load',array('appointmentid'=>$appid));
		} catch (Exception $error) {
			wassUtil::Error(14,array('Unable to locate specified appointment.'),'HTMLFORMAT,DIE');
		}
	
		/* See if user is authorized to 'get' the appointment */
		if (!$app->isViewable($_SESSION['authtype'],$_SESSION['authid']))
			wassUtil::Error(22,array('user','appointment'),'HTMLFORMAT,DIE');
	
		/* Get the owning calendar */
		$cal = new wassCalendar('load',array('calendarid'=>$app->calendarid));
		/* Get the owning block */
		$block = new wassBlock('load',array('blockid'=>$app->blockid));
	
		/* Now build an iCalendar stream for the appointment */
		$icalstream = wassIcal::addApp($app,$block,$target);

		/* Now build the email headers. */
		$icalheaders = "MIME-Version: 1.0\r\nFrom: " .  wassParms::FROMMAIL . "\r\nReply-To: " . wassParms::SYSMAIL  . "\r\nErrors-To: " . wassParms::SYSMAIL . "\r\nContent-Type: text/calendar; method=REQUEST\r\nContent-Transfer-Encoding: 7bit";
		
		/* Send the email */
		mail($toid,'New Appointment',$icalstream,$icalheaders);
				
		echo 'Email has been sent';
		
		break;
		
	
	case 'MAILDEL':

		/* Return an iCalendar CANCEL email. */
		$uid = trim(urldecode($_REQUEST['uid']));
		$date = trim(urldecode($_REQUEST['date']));  /* yyyymmdd */
		$ltime = trim(urldecode($_REQUEST['tstart'])); /* hhmmss in local time */
		$tstart = gmdate('His',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4))); /* hhmmss in UTC */
		$dates = gmdate('Ymd',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4)));  /* date in GMT */
		$ltime = trim(urldecode($_REQUEST['tend'])); /* hhmmss */
		$tend = gmdate('His',mktime(substr($ltime,0,2),substr($ltime,2,2),0,substr($date,4,2),substr($date,6,2),substr($date,0,4)));   /* hhmmss in UTC */	
		$email = trim(urldecode($_REQUEST['email']));
		$sequence = trim(urldecode($_REQUEST['sequence']));
		$toid = trim(urldecode($_REQUEST['toid']));
			
		/* Now build an iCalendar stream for the appointment */
		$icalstream = wassIcal::delApp($uid,$dates,$tstart,$tend,$email,$sequence);

		/* Now build the email headers. */
		$icalheaders = "MIME-Version: 1.0\r\nFrom: " .  wassParms::FROMMAIL . "\r\nReply-To: " . wassParms::SYSMAIL  . "\r\nErrors-To: " . wassParms::SYSMAIL . "\r\nContent-Type: text/calendar; method=REQUEST\r\nContent-Transfer-Encoding: 7bit";
		
		/* Send the email */
		mail($toid,'Delete Appointment',$icalstream,$icalheaders);
		
				
		echo 'Email has been sent';
		
		break;

		

	case 'GETBLOCK':
		/* Return an iCalendar stream with information on a block */
		
		
		/* Get the block id */	
		$blockid = trim($_REQUEST['blockid']);
		if (!$blockid)
			wassUtil::Error(31,array('blockid'),'HTMLFORMAT,DIE');
		
		
		$recurrence = trim($_REQUEST['recurrence']);
		if (!$recurrence)
			$recurrence = 'all';
		
		/* Load the block */
		try {
			$block = new wassBlock('load',array('blockid'=>$blockid));
		} catch (Exception $error) {
			wassUtil::Error(14,array('Unable to locate specified block.'),'HTMLFORMAT,DIE');
		}
	
		/* See if user is authorized to 'get' the block */
		if (!$block->isViewable($_SESSION['authtype'],$_SESSION['authid']))
			wassUtil::Error(22,array('user','block'),'HTMLFORMAT,DIE');

		/* Start the iCal stream */
		$ret = wassParms::ICALHEADER;
		$ret .= "METHOD:PUBLISH\r\n";
		
		/* Now add the block(s) as ical streams */
		if ((!$block->seriesid) || ($recurrence != 'all'))
			/* If single block */
			$ret .= wassIcal::addBlock($block);
		else {
			/* First, build a list of all of the blocks */
			$blocks = new wassList(wassSQL::buildSelect('wassBlock',array('seriesid'=>$block->seriesid)),'Block');
		
			/* Now add each block as an ical stream */
			foreach ($blocks as $block) {
				if (is_object($block)) 
					$ret .= wassIcal::addBlock($block);
			}
		}
		
		$ret .= wassParms::ICALTRAILER;
				
		/* Return the icalendar stream */
		wassIcal::returnICAL($ret,'PUBLISH','OfficeHours.ics');
		
		break;

	case 'GETCAL':
		/* Return an iCalendar stream with information on an entire calendar */
		
		
		/* Get the block id */	
		$calid = trim($_REQUEST['calid']);
		if (!$calid)
			wassUtil::Error(31,array('calid'),'HTMLFORMAT,DIE');
		
		/* Load the calendar */
		try {
			$cal = new wassCalendar('load',array('calendarid'=>$calid));
		} catch (Exception $error) {
			wassUtil::Error(14,array('Unable to locate specified calendar.'),'HTMLFORMAT,DIE');
		}
	
		/* See if user is authorized to 'get' the block */
		if (!$cal->isViewable($_SESSION['authtype'],$_SESSION['authid']))
			wassUtil::Error(22,array('user','calendar'),'HTMLFORMAT,DIE');

				
		/* Return the icalendar stream */
		wassIcal::returnICAL(wassIcal::allCalendar($calid),'PUBLISH','OfficeHours.ics');
		
		break;
		
	case 'LISTAPPS':
		/* Return an icalendar stream of appointments for a user */
		
		/* Get the args */
		$userid = $_SESSION['authid'];
		$startdate = trim($_REQUEST['startdate']);
		$enddate = trim($_REQUEST['enddate']);
		$starttime = trim($_REQUEST['starttime']);
		$endtime = trim($_REQUEST['endtime']);
		
		
		/* Return appointment list to the user */
		wassIcal::returnICAL(wassIcal::listApps($userid,$startdate,$enddate,$starttime,$endtime),'PUBLISH','OfficeHours.ics');
	    
		break;
										
	
	default:
		wassUtil::Error(8,array($action),'HTMLFORMAT,DIE');
		break;


 
}


exit(); 

?>