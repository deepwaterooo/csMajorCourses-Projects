<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class implements some class (static) methods that are useful for dealing with iCal.
 
*/

class wassIcal {


	/* 
	This function generates an iCal stream for creating an appointment. 
	*/
	static function addApp($app,$block,$target='manager') {
	
		/* Compute start/end date/time */
		$dates = gmdate('Ymd',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
		$datee = gmdate('Ymd',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
		$tstart = gmdate('His',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
		$tend = gmdate('His',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
	
		/* Get the calendar */
		$cal = new wassCalendar('load',array('calendarid'=>$app->calendarid));
	
	
		/* Now build an iCalendar stream for the appointment */
		$ret = wassParms::ICALHEADER;
		$ret .= "METHOD:PUBLISH\r\n";
		$ret .= "BEGIN:VEVENT\r\n";
		$ret .= 'ORGANIZER:MAILTO:' . $app->email . "\r\n";
		$ret .= "DTSTART:" . $dates . "T" . $tstart . "Z\r\n";
		$ret .= "DTEND:" . $datee . "T" .  $tend . "Z\r\n"; 
		$ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
		$ret .= "UID:" . $app->uid . "\r\n";
		$ret .= "CATEGORIES:APPOINTMENT\r\n";
		if ($target == 'owner')
			$ret .= "SUMMARY:Appointment with " .  $app->name . " (" . $app->email . ").\r\n";
		elseif ($target == 'student')
			$ret .= "SUMMARY:Appointment with " . $cal->name .  " (" . $cal->email . ").\r\n";
		else
			$ret .= "SUMMARY:Appointment for " . $app->name . " with " . $cal->name . "\r\n";
		$ret .= "LOCATION:" . self::nlIcal($block->location) . "\r\n"; 
		$ret .= "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" . self::nlIcal($app->purpose) . "\r\n";
		$ret .= "CLASS:PUBLIC\r\n";
		$ret .= "SEQUENCE:" . $app->sequence . "\r\n";
		$ret .= "END:VEVENT\r\n"; 
		$ret .= wassParms::ICALTRAILER;
	
		/* Return the icalendar stream */
		return $ret;

	
	
	}
	
	
	/* 
	This function generates an Ical stream for deleting an appointment. 
	*/
	static function delApp($uid,$date,$tstart,$tend,$email,$sequence) {
	
		/* Now build an iCalendar stream for the appointment */
		$ret = wassParms::ICALHEADER;
		$ret .= "METHOD:CANCEL\r\n";
		$ret .= "BEGIN:VEVENT\r\n";
		$ret .= "SEQUENCE:" . $sequence+1 . "\r\n";
		$ret .= "STATUS:CANCELLED\r\n";
		$ret .= 'ORGANIZER:MAILTO:' . $email . "\r\n";
		$ret .= "DTSTART:" . $date . "T" . $tstart . "Z\r\n";
		$ret .= "DTEND:" . $date . "T" .  $tend . "Z\r\n"; 
		$ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
		$ret .= "UID:" . $uid . "\r\n";
		$ret .= "END:VEVENT\r\n"; 
		$ret .= wassParms::ICALTRAILER;
		
		/* Return the icalendar stream */
		return $ret;
	
	}

	/* 
	This function formats a block as an iCal stream 
	*/ 
	static function addBlock($bk) {

		$dates = gmdate('Ymd',mktime(substr($bk->starttime,0,2),substr($bk->starttime,3,2),0,substr($bk->date,5,2),substr($bk->date,8,2),substr($bk->date,0,4)));
		$datee = gmdate('Ymd',mktime(substr($bk->endtime,0,2),substr($bk->endtime,3,2),0,substr($bk->date,5,2),substr($bk->date,8,2),substr($bk->date,0,4)));
		$tstart = gmdate('His',mktime(substr($bk->starttime,0,2),substr($bk->starttime,3,2),0,substr($bk->date,5,2),substr($bk->date,8,2),substr($bk->date,0,4)));
		$tend = gmdate('His',mktime(substr($bk->endtime,0,2),substr($bk->endtime,3,2),0,substr($bk->date,5,2),substr($bk->date,8,2),substr($bk->date,0,4)));
	
		$ret = "BEGIN:VEVENT\r\n";
		$ret .= 'ORGANIZER:MAILTO:' . $bk->email . "\r\n";
		$ret .= "DTSTART:" . $dates . "T" . $tstart . "Z\r\n";
		$ret .= "DTEND:" . $datee . "T" .  $tend . "Z\r\n"; 
		$ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
		if ($bk->uid)
			$ret .= "UID:" . $bk->uid . "\r\n";
		else
			$ret .= "UID:" . $bk->blockid . 'block@' .  $_SERVER['REQUEST_URI'] . "\r\n";
		$ret .= "CATEGORIES:OFFICEHOURS\r\n";
		if ($bk->title)
			$ret .= "SUMMARY:" . $bk->title .  "\r\n";
		else 
			$ret .= "SUMMARY:" . wassParms::NAME . "\r\n";
		$ret .= "LOCATION:" .  self::nlIcal($bk->location) . "\r\n"; 
		if ($bk->description)
			$ret .= "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" . $bk->description . "\r\n";
		else
			$ret .= "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:Office Hours Block\r\n";
		$ret .= "CLASS:PUBLIC\r\n";
		$ret .= "SEQUENCE:" . $bk->sequence . "\r\n";
		$ret .= "END:VEVENT\r\n"; 

		return $ret;

	} 
	
	/*
	This function returns an entire calendar (all appointments and all blocks) as an iCal stream.
	*/
	static function allCalendar($calendarid) {
		/* Get the calendar */
		$cal = new wassCalendar('load',array('calendarid'=>$calendarid));
		
		/* Get list of all blocks sorted by date/time */
		$allblocks = wassBlock::listOrderedBlocks(array(array('calendarid,=,AND',$calendarid)),'ORDER BY date, starttime');
		
		/* Init the iCal stream. */
		$ret = wassParms::ICALHEADER;
		
		
		/* Start by adding all of the scheduled blocks and appointments */
		
		$ret .= "METHOD:PUBLISH\r\n";
		
		
		/* Go through all of the blocks */
		foreach ($allblocks as $block) {
			/* Add the block */
			$ret .= self::addBlock($block);	
			/* Get all of the appoinments for that block */
			$apps = wassAppointment::listMatchingAppointments(array('blockid'=>$block->blockid));
			/* Add the appointments */
			foreach ($apps as $app) {
			 /* Compute start/end date/time */
			  $dates = gmdate('Ymd',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			  $datee = gmdate('Ymd',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			  $tstart = gmdate('His',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			  $tend = gmdate('His',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			  $ret .= "BEGIN:VEVENT\r\n";
			  $ret .= 'ORGANIZER:MAILTO:' . $app->email . "\r\n";
			  $ret .= "DTSTART:" . $dates . "T" . $tstart . "Z\r\n";
			  $ret .= "DTEND:" . $datee . "T" .  $tend . "Z\r\n"; 
			  $ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
			  if ($app->uid)
			  	$ret .= "UID:" . $app->uid . "\r\n";
			  else
			    $ret .= "UID:" . $app->appointmentid . 'app@' .  $_SERVER['REQUEST_URI'] . "\r\n";	  
			  $ret .= "CATEGORIES:APPOINTMENT\r\n";
			  $ret .= "SUMMARY:Appointment with " .  $app->name . " (" . $app->email . ").\r\n";
			  $ret .= "LOCATION:" .  self::nlIcal($block->location) . "\r\n"; 
			  $ret .= "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" .  self::nlIcal($app->purpose) . "\r\n";
			  $ret .= "CLASS:PUBLIC\r\n";
			  $ret .= "SEQUENCE:" . $app->sequence . "\r\n";
			  $ret .= "END:VEVENT\r\n"; 

			}
			
		}
		
		/* End of the scheduled events and appointments. */
		$ret .= wassParms::ICALTRAILER;
		
		/* Now try to say something about deleted blocks and cancelled appointments 
		$deleted = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDeleted WHERE calendarid=' . $calendarid);
		$needheader = true;
		if ($deleted) {
			while ($del = wassSQL::doFetch($deleted)) {
				if ($needheader) {
					$ret .= wassParms::ICALHEADER;
					$ret .= "METHOD:CANCEL\r\n";
					$needheader = false;
				}
				$ret .= "BEGIN:VEVENT\r\n";
				$ret .= "UID:" . $del['uid'] . "\r\n";
				$sequence = $del['sequence']+1;
				$ret .= "SEQUENCE:" . $sequence . "\r\n"; 
				$ret .= "STATUS:CANCELLED\r\n";
				$ret .= "DTSTART:" . $del['dtstart'] . "\r\n";
				$ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
				$ret .= "END:VEVENT\r\n";		
			}
		}

		if (!$needheader)
			$ret .= wassParms::ICALTRAILER;
		*/
		
		/* Log the request */
		$last = wassPrefs::getPref($cal->userid,'getCal');
		if ($last) {
			list($lt, $rest) = explode(',',$last);
			$last = $rest . ', ';
		}
		else 
			$last = '';
		wassPrefs::savePref($cal->userid,'getCal',$last . date('m/d/Y H:i'));
		
		return $ret;		
	
	}

	/*
	This function returns aa list of appopintments from the specified date/time for the specified user.	
	*/
	
	static function listApps($userid,$startdate,$enddate,$starttime,$endtime) {
		
		/* Bulld the select criteria */
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE (userid=' . wassSQL::sqlSafe($userid) . ' OR blockid in (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid=' . wassSQL::sqlSafe($userid) . '))';
		
		if ($startdate) 
			$select .= ' AND startdate >=' . wassSQL:: sqlSafe($startdate);

		if ($enddate) 
			$select .= ' AND enddate <=' . wassSQL:: sqlSafe($enddate);

		if ($starttime)
			$select .= ' AND starttime >=' . wassSQL:: sqlSafe($starttime);


		if ($endtime)
			$select .= ' AND endtime <=' . wassSQL:: sqlSafe($endtime);
			
		$select .= ' ORDER by date, starttime';

		
		/* Now get the wasslist of appointments */
		$apps = new wassList($select,'Appointment');
		
	 	/* Init the iCal stream. */
		$ret = wassParms::ICALHEADER;
		$ret .= "METHOD:PUBLISH\r\n";
		
		/* Now add in all of the appointments to the iCal stream */
		foreach ($apps as $app) {
			
			/* Read in the block */
			$block = new wassBlock('load',array("blockid"=>$app->blockid));
			
			/* If the userid owns the app, then display the block owner info. (the "with" user), else display the app owner info (the "for" user). */
			if ($userid == $app->userid)
				$show = $block;
			else
				$show = $app;
			
			/* Compute start/end date/time */
			 $dates = gmdate('Ymd',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			 $datee = gmdate('Ymd',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			 $tstart = gmdate('His',mktime(substr($app->starttime,0,2),substr($app->starttime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			 $tend = gmdate('His',mktime(substr($app->endtime,0,2),substr($app->endtime,3,2),0,substr($app->date,5,2),substr($app->date,8,2),substr($app->date,0,4)));
			 $ret .= "BEGIN:VEVENT\r\n";
			 $ret .= 'ORGANIZER:MAILTO:' . $show->email . "\r\n";
			 $ret .= "DTSTART:" . $dates . "T" . $tstart . "Z\r\n";
			 $ret .= "DTEND:" . $datee . "T" .  $tend . "Z\r\n"; 
			 $ret .= "DTSTAMP:" . gmdate('Ymd\THis') . "Z\r\n";
			 
			 if ($app->uid) 
				$ret .= "UID:" . $app->uid . "\r\n";
			 else
			    $ret .= "UID:" . $app->appointmentid . 'app@' .  $_SERVER['REQUEST_URI'] . "\r\n";	  
			 $ret .= "CATEGORIES:APPOINTMENT\r\n";
			 $ret .= "SUMMARY:Appointment with " .  $show->name  . " (" . $show->email . ")\r\n";
			 $ret .= "LOCATION:" .  self::nlIcal($block->location) . "\r\n"; 
			 $ret .= "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" .  self::nlIcal($app->purpose) . "\r\n";
			 $ret .= "CLASS:PUBLIC\r\n";
			 $ret .= "SEQUENCE:" . $app->sequence . "\r\n";
			 $ret .= "END:VEVENT\r\n"; 
		}

		
		/* End of the scheduled appointments. */
		$ret .= wassParms::ICALTRAILER;
		
		/* Return the results */
		return $ret;

	}
	
	/*
	This method returns an ICAL stream to a web browser.
	*/
	static function returnICAL($ical, $method="PUBLISH",$filename='') {
		srand(time());
		if (!$filename) {
			$random = rand(1,10000);
			$filename = "v" . $random . ".ics"; 
		}     
		header("Content-Type: text/calendar;method=$method");
		header("Cache-Control: private");
		header("Content-Disposition: inline;filename=$filename"); 
		echo self::foldICAL($ical);
	}
	
	/*
	This function folds lines for icalendar streams and returns the folded lines.
	*/
	static function foldICAL($input) {
		/* Init output */
		$output = '';
		/* Split lines into an array of CRLF-seperated strings */
		$lines = explode("\r\n",$input);
		/* Fold lines at 72 characters */
		foreach ($lines as $line) {
			while (strlen($line) > 75) {
				/* Don't split at a '\n' divider */
				if (substr($line,74,2) == '\n')
					$splitat = 74;
				else
					$splitat = 75;
				$before = substr($line,0,$splitat);
				$line = substr($line,$splitat);
				$output .= $before . "\r\n" . " ";
			}
			if (strlen($line) > 0)
				$output .= $line;
			$output .= "\r\n";
		}
		return $output;
	}
	
	/*
	This function converts CRLF or LF text into \n as required for iCal text fields.
	*/
	static function nlIcal($input) {
		/* First translate CRLF into '\n' */
		$output = str_replace("\r\n",'\n',$input);
		/* Next, translate bare LF into '\n' */
		$output = str_replace("\n",'\n',$output);
		/* Finally, translate any bare CR into '\n' */
		return str_replace("\r",'\n',$output);
	}
		
		


}
?>