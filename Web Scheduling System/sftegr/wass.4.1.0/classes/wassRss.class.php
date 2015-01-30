<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class implements some class (static) methods that are useful for generating with Rss feeds.
 
*/

class wassRss {



	/*
	This function returns a list of appopintments from the specified date/time for the specified user as an RSS stream.	
	*/
	
	static function listApps($userid,$startdate,$enddate,$starttime,$endtime) {
		
		/* Bulld the select criteria */
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE (userid=' . wassSQL::sqlSafe($userid) . ' OR blockid in (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid=' . wassSQL::sqlSafe($userid) . '))';
		
		if ($startdate) 
			$select .= ' AND date >=' . wassSQL::sqlSafe($startdate);

		if ($enddate) 
			$select .= ' AND date <=' . wassSQL::sqlSafe($enddate);

		if ($starttime)
			$select .= ' AND starttime >=' . wassSQL::sqlSafe($starttime);


		if ($endtime)
			$select .= ' AND endtime <=' . wassSQL::sqlSafe($endtime);
			
		$select .= ' ORDER by date, starttime';


		/* Now get the wasslist of appointments */
		$apps = new wassList($select,'Appointment');
		
		/* Init the Rss stream. */
		$ret = '<?xml version="1.0"?>';
		$ret .= '<rss version="2.0">';
		$ret .= '<channel>';
		$ret .= '<title>' . wassParms::SYSID . '</title>';
		$ret .= '<link>https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/makeappt.page.php</link>';
		$ret .= '<description>Pending Appointments</description>';
		
		
		/* Now add in all of the appointments to the iCal stream */
		foreach ($apps as $app) {
			
			/* Read in the block */
			$block = new wassBlock('load',array("blockid"=>$app->blockid));
			
			/* If the userid owns the app, then display the block owner info. (the "with" user), else display the app owner info (the "for" user). */
			if ($userid == $app->userid)
				$show = $block;
			else
				$show = $app;
			
			/* Add the item */
			 $ret .= '<item>';
			 $ret .= '<title>' . $show->name . ' (' . $show->userid . ') at ' . wassUtil::AmPm($app->starttime) . ' on ' . date('D',mktime(2,0,0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4))) . ', ' . substr($app->date,5,2) . '/' . substr($app->date,8,2) . '/' . substr($app->date,0,4) . '</title>';
			 $ret .= '<link>https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/apptinfo.page.php?appt_id='. $app->appointmentid . '</link>';
			 $ret .= '<description>Location: ' . $block->location . '; Purpose: ' . $app->purpose . '</description>'; 
			 $ret .= '</item>';
		}

		/* Add in a "Make Appointment' item */
		$ret .= '<item>';
		$ret .= '<title>Make an Appointment</title>';
		$ret .= '<link>https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/makeappt.page.php</link>';
		$ret .= '<description>Make/Cancel Appointments</description>';
		$ret .= '</item>';
		
		/* End of the scheduled appointments. */
		$ret .= '</channel>';
		$ret .= '</rss></xml>';
		
		/* Return the results */
		return $ret;

	}


	/*
	This function returns all of the blocks in a calendar as an Rss stream.
	*/
	
	static function listBlocks($calendarid,$startdate='') {
		
		/* Get the calendar */
		$cal = new wassCalendar('load', array('calendarid'=>$calendarid));
		
		/* Get the list of matching blocks */
		$blocks= new wassList('SELECT * FROM ' . wassParms::DATABASE . '.wassBlock WHERE calendarid = ' . wassSQL::sqlSafe($calendarid) . ' ORDER by `date` DESC, starttime DESC','Block');
		
		/* Output the RSS header */
		$out = '<?xml version="1.0" encoding="ISO-8859-1"?><rss version="2.0" xmlns:gd="http://schemas.google.com/g/2005">';
		
		/* Add in the calendar info */
		$out .=  '<channel>' .
  					'<title>'.$cal->title.'</title>' .
  					'<link>'. 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/viewcalendar.page.php?cal_id='.$calendarid.'&amp;view=month';
		if ($startdate)
			$out .= '&amp;st_dt='.$startdate;
					
		$out .= 	'</link>' .
  					'<description>'.$cal->description.'</description>';
 				

		/* Add in the block data */
		foreach ($blocks as $block) {
			
			$out .= '<item>' .
					'<title>'.$block->title.'</title>' .
					'<link>'. 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/viewcalendar.page.php?block_id='. $block->blockid.'</link>' .
					'<guid>'.$block->blockid.'</guid>' .
					'<description>'.$block->description.'</description>' .
					'<pubDate>'.date(DATE_RSS,mktime(substr($block->starttime,0,2),substr($block->starttime,3,2),'00',substr($block->date,5,2),substr($block->date,8,2),substr($block->date,0,4))).'</pubDate>' .
					'<gd:where valuestring="'.$block->location.'"/>' .
					'<gd:when startTime="'.$block->date.' '.$block->starttime.'" endTime="'.$block->date.' '.$block->endtime.'"/>' .
					'</item>';			
						
		}
		
		/* End the stream */
		$out .= '</channel></rss>';
		
		/* Return the stream */
		return $out;
			
	}

}
?>