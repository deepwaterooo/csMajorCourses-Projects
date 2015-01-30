<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This class describes an appointment.  
*/

class wassAppointment {
 
 
 	/* Properties */
	public $appointmentid;	/* Database id of the wassAppointment appointment */
	public $blockid;      	/* Database id of the wassBlock record */
	public $calendarid;     /* Database id of the wassCalendar record */
	public $date;			/* Date */
	public $name;  			/* Name of user */
	public $email;			/* Email of user */
	public $textemail;	    /* Text msg email address of user */
	public $phone; 			/* Phone number of user */
	public $userid;			/* Userid of user */
	public $starttime;		/* Starting time appointment (24 hh:mm) */
	public $endtime;        /* End time of appointment  (24 hh:mm) */
	public $purpose;		/* Purpose of appointment */
	public $remind; 		/* Send reminder? */
	public $reminded; 		/* Sent reminder? */
	public $notes;         	/* Text about the appointment */
	public $uid;            /* Ical UID */
	public $whenmade;       /* date/time appointment was made */
	public $madeby;			/* Userid/email of user making the appointment */
	public $available;      /* 1 for standard appointment, 0 for dummy appointment (slot holder) */
	public $sequence;       /* Update counter for generating iCal files */
	
	
	/* Constants */
	const NONOTIFICATION = 'DO NOT SEND CANCELLATION NOTIFICATION(S)';
	
	
	/* Static (class) methods */
	
		
	/* Look up an appointment in the database and return its values as an associative array */
	static function find($id) {
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE appointmentid=' . wassSQL::sqlSafe($id)))
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);

		/* Return the result */
		return $result;
	
	}
		
	
	/* Locate all appointments that meet the designated criteria, and return the php resource, or NULL.  */
	static function select($arr) {
		/* Issue the select call and return the results */
		return wassSQL::selectDB('wassAppointment',$arr);
				
	}

	
	/* Return a list of appointments that meet the specified criteria */
	static function listMatchingAppointments($criteria,$orderby='ORDER BY date') {
		return new wassList(wassSQL::buildSelect('wassAppointment',$criteria,$orderby),'Appointment');
	}
	 
	 
	/* Return a list of matching appointments that meet criteria which may include multiple instances of the same parameter. */
	static function listOrderedAppointments($criteria,$orderby) {
		return new wassList(wassSQL::buildOrderedSelect('wassAppointment',$criteria,$orderby),'Appointment');
	}		
	
	/*  Object Methods */
	
	/* We have two constructors, one for a new appointment, one for an
	   existing appointment.  In the former case, we create an entry in the
	   database appointment table, assign an id, and fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database appointment table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   appointment object.
	*/
	
	function __construct($source,$data) {
		/* $source tells us whether to 'load', 'update' or 'create an appointment.
		   $data is an associative array of elements used when we need to create/update 
		   an appointment; for 'load', it contains just the appointmentid. */
		   
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
		
		/* For load and update, find the appointment and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassAppointment::find($ndata['appointmentid']))
				throw new Exception('Appointment id ' . $ndata['appointmentid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* Set defaults for unspecified values */
		if ($source == 'create') {
			if ($ndata['userid']) {
			  if (!$ndata['name'])
				  $ndata['name'] = wassDirectory::getName($ndata['userid']);
			  if (!$ndata['phone'])
				  $ndata['phone'] = wassDirectory::getPhone($ndata['userid']);
			  if (!$ndata['email'])
				  $ndata['email'] = wassDirectory::getEmail($ndata['userid']);
			}
			if 	(!array_key_exists('remind',$ndata))
				$ndata['remind'] = 1;
			if 	(!array_key_exists('available',$ndata))
				$ndata['available'] = 1;
			if 	(!$ndata['uid'])
				$ndata['uid'] = date('Ymd\TGis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI'];
		}
		
		/* For update, disallow resetting of calendarid or blockid */
		if ($source == 'update') {
			if (($ndata['calendarid']) && ($ndata['calendarid'] != $this->calendarid)) 
				throw new Exception('Cannot assign appointment to a new calendar',15);
			if (($ndata['blockid']) && ($ndata['blockid'] != $this->blockid)) 
				throw new Exception('Cannot assign appointment to a new block',15);
		}
		
		
		/* For update and create, load up the values and validate the appointment. */
		if (($source == 'update') || ($source == 'create')) {
			wassUtil::loadObject($this,$ndata);
			if ($errors = $this->validate()) 
				throw new Exception($errors,15);
		}

			
	}		


	
	/*
	This function writes the appointment data out to the database and sends out notifications.  
	The first argument specifies whether this is a new appointment or not.  If this is not a new appointment
	(an appointment is being edited), the second argument contains the values of the old appointment.
	*/
	
	function save($type,$curapp='') {
		
		/* Read in the block oibject */
		$block = new wassBlock('load',array('blockid'=>$this->blockid));	
		
			
		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify an appointmentid */
				if ($key != 'appointmentid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= '`'.$key.'`';
					if ($vallist)
						$vallist .= ',';
					if ($key == 'whenmade')
						$vallist .= wassSQL::sqlSafe(date('Y-m-d H:i:s'));
					else
						$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sql = 'INSERT INTO ' . wassParms::DATABASE . '.wassAppointment (' . $varlist . ') VALUES (' . $vallist . ')';
		}
		/* Else if just setting the reminded flag, create a short update string */
		elseif ($type == 'reminded') 
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassAppointment SET reminded=1 WHERE appointmentid=' . $this->appointmentid;
		/* Else create the update list */
		else {
			$sql = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify an appointmentid */
				if ($key != 'appointmentid') {
				  if ($sql)
					  $sql .= ', ';
				  $sql .= '`'.$key.'`' . '=' . wassSQL::sqlSafe($value);
				}
			}
			/* We also need to increment the sequence number */
			if ($sql)
				$sql .= ', ';
			$sql .= 'sequence = sequence+1';			
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassAppointment SET ' . $sql . ' WHERE appointmentid=' . $this->appointmentid;	
		}
		
		/* Now do the update (and blow up if we can't) */
		if (!wassSQL::doQuery($sql))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16);
				
		/* If saving a new appointment, save the id. */
		If ($type == 'create') {
			/* Save the appointment id. */
			$this->appointmentid = wassSQL::insert_id(); 
			
			/* Record user's latest appointment */
			if ($this->userid)
				wassPrefs::savePref($this->userid,'lastappmade',date('Y-m-d H:i:s'),'user');
			else
				wassPrefs::savePref($this->email,'lastappmade',date('Y-m-d H:i:s'),'guest');
	
			
			/* Set up useful subject line */
			$subject = 'Appointment scheduled: ' . $this->name . ' with ' . $block->name . ' at ' . wassUtil::AmPm($this->starttime) . ' on ' . date('D',mktime(2,0,0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4))) . ', ' . substr($this->date,5,2) . '/' . substr($this->date,8,2) . '/' . substr($this->date,0,4);
						
			/* Send out notification email */
			if ($this->available)
				$this->notify('The following appointment has been scheduled:',$subject,$block,'add','');

		}
		/* If editing an appointment, send out change notification */
		elseif ($type != 'reminded') {
			
			$subject = 'Appointment changed: ' . $this->name . ' with ' . $block->name . ' at ' . wassUtil::AmPm($this->starttime) . ' on ' . date('D',mktime(2,0,0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4))) . ' ' . substr($this->date,5,2) . '/' . substr($this->date,8,2) . '/' . substr($this->date,0,4);
						
			/* Send out notification email */
			if ($this->available)
				$this->notify('The following appointment has been changed:',$subject,$block,'change',$curapp);	
			
		}
			
		return $this->appointmentid;
	}
				
	function validate() {
	
		/* Validate appointment data, pass back error string if any errors. */
		$errors = '';

		/* Read in the calendar */
		if (!($calendar = wassCalendar::find($this->calendarid)))
				$errors .= 'Invalid calendarid: ' . $this->calendarid . ';';

		/* Read in the block */
		if (!($block = wassBlock::find($this->blockid)))
				$errors .= 'Invalid blockid: ' . $this->blockid . ';';

		/* starttime and endtime */		
		if (!wassUtil::checkTime($this->starttime)) 
			$errors .= 'Invalid start time: ' . $this->starttime . ';';
		if (!wassUtil::checkTime($this->endtime)) 
			$errors .= 'Invalid end time: ' . $this->endtime . ';';
		if (($elapsed = wassUtil::elapsedTime($this->starttime,$this->endtime) <= 0))
 			$errors .= 'End time must be >= start time;';
			
		/* Make sure app startime and endtimes are within block boundary */	
		if ($block) {
			if (wassUtil::timeToMin($this->starttime) < wassUtil::timeToMin($block['starttime']))
				$errors .= 'Appointment start time (' . $this->starttime . ') must be >= block start time (' . 
							$block['starttime'] . ');';
			if (wassUtil::timeToMin($this->endtime) > wassUtil::timeToMin($block['endtime']))
				$errors .= 'Appointment end time (' . $this->endtime . ') must be <= block end time (' . $block['endtime'] . ');';
		}
		
		/* date */
		if (!wassUtil::isDateValid($this->date))
			$errors .= 'Invalid date: ' . $this->date . ';';
			
		/* remind */
		if (!wassUtil::checkBool($this->remind))
			$errors .= 'remind must be a boolean;';
	
		/* available */
		if (!wassUtil::checkBool($this->available))
			$errors .= 'available must be a boolean;';
		
		return $errors;
	
	}


	/* Cancel an appointment */
	function delete($canceltext,$block=0) {
		/* If block not passed, read it in */
		if (!$block)
			$block = new wassBlock('load',array('blockid'=>$this->blockid));
		
		/* Save the deleted appointment data for later delivery as an Ical CANCEL */
		
		/* First, compute the DTSTART 
		$dtstart = gmdate('Ymd\THis\Z',mktime(substr($this->starttime,0,2),substr($this->starttime,3,2),0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4)));
		*/
		/* Now write out the deleted appointment data 
		wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassDeleted (calendarid,sequence,uid,dtstart) VALUES (' . wassSQL::sqlSafe($this->calendarid) . ',' .  wassSQL::sqlSafe($this->sequence + 1) . ',' .   wassSQL::sqlSafe($this->uid) . ',' . wassSQL::sqlSafe($dtstart) . ');');  */
		
		/* Delete the appointment record. */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassAppointment WHERE appointmentid=' . $this->appointmentid . ' LIMIT 1');	
			
		/* Set up useful subject line */
		$subject = 'Appointment cancelled: ' . $this->name . ' with ' . $block->name . ' at ' . wassUtil::AmPm($this->starttime) . ' on ' . date('D',mktime(2,0,0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4))) . ', ' .  substr($this->date,5,2) . '/' . substr($this->date,8,2) . '/' . substr($this->date,0,4);
							
			
		/* Send out cancellation email */
		if (($canceltext != self::NONOTIFICATION) && ($this->available))
			$this->notify('The following appointment has been cancelled: ' . $canceltext . '<br /><br/>',$subject,$block,'delete','');

	}
	
	
	/*
	Send out notifications about an appointment.
	*/
	function notify($msghead,$subject,$block,$type,$curapp) {
		
		/* Initialize email counters */
		$sc = 0; $pc = 0;  $mc = 0;	
		
		
		/* If no block passed, read it in */
		if (!$block)
			$block = new wassBlock('load',array('blockid'=>$this->blockid));	
		
		/* If appointment is in the past, don't send out any notifications. */
		if (wassUtil::beforeToday($this->date))
			return '0,0,0';
		
		
		/* If today but before now, don't notify */	
		if (wassUtil::isToday($this->date)) {
			$starthour = substr($this->starttime,0,2);
			$startmin = substr($this->starttime,3,2);
			$currhour = date('H');
			$currmin = date('i');
			if ($currhour > $starthour)
				return '0,0,0';
			elseif ($currhour == $starthour)
				if ($currmin > $startmin)
					return '0,0,0';
		}
			
		/* Figure out what, if anything, has changed (if editing) */
		if ($curapp) {
			if ($this->name != $curapp->name) $cname = '  ** Changed **';
			if ($this->email != $curapp->email) $cemail = '  ** Changed **';
			if ($this->phone != $curapp->phone) $cphone = '  ** Changed **';
			if (substr($this->starttime,0,5) != substr($curapp->starttime,0,5)) $cstarttime = '  ** Changed **';
			if (substr($this->endtime,0,5) != substr($curapp->endtime,0,5)) $cendtime = '  ** Changed **';
			if ($this->purpose != $curapp->purpose) $cpurpose = '  ** Changed **';
		}
		else {
			$cname='';$cemail='';$cphone='';$cstarttime='';$cendtime='';$cpurpose='';
		}
			
		
		/* Set up msg headers */
		$headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $block->email . "\r\n" . "Content-type: text/html\r\n" . "Errors-To: " . wassParms::SYSMAIL . "\r\n";	
		
		/* If prof wants notice, send it */
		$sentprof = '';
		if (($type == "remind" && $block->remind) || ($type != "remind" && $block->notify)) {
			/* Add in appointment info. */
			if ($curapp)
				$msg = $msghead . '<br /><br /><i>Changed From</i>:<br /><br />' . $curapp->appHTML($block,'changefrom','owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose) . '<br /><br /><i>Changed To</i>:<br /><br />' . $this->appHTML($block,'changeto','owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			else 
				$msg = $msghead . '<br /><br />' . $this->appHTML($block,$type,'owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			$bemail = $block->email; if (!$bemail) $bemail = wassDirectory::getEmail($block->userid);
			mail($bemail,$subject,str_replace('XXX___XXX',urlencode($bemail),$msg), $headers); 
			$pc++;
			$sentprof = $block->userid;
		}
		
			
		/* If students wants notice, send it */
		if (($type == "remind" && $this->remind) || ($type != "remind")) {
			/* Add in appointment info. */
			if ($curapp)
				$msg = $msghead . '<br /><br /><i>Changed From</i>:<br /><br />' . $curapp->appHTML($block,'changefrom','student',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose) . '<br /><br /><i>Changed To</i>:<br /><br />' . $this->appHTML($block,'changeto','owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			else 
				$msg = $msghead . '<br /><br />' . $this->appHTML($block,$type,'student',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			$semail = $this->email; if (!$semail) $semail = wassDirectory::getEmail($this->userid);
			mail($semail,$subject,str_replace('XXX___XXX',urlencode($semail),$msg), $headers); 
			/* If user requested a text message, send email to the user's text email address */
			if ($this->textemail)
				mail($this->textemail,"",$subject, $headers);
				//mail($this->textemail,$subject,str_replace('XXX___XXX',urlencode($semail),$msg), $headers);
			$sc++;
		}
			
		/* If managers want notice, send them out, unless already sent. */
		if (($type == "remind" && $block->remindman) || ($type != "remind" && $block->notifyman)) {
			/* Add in appointment info. */
			if ($curapp)
				$msg = $msghead . '<br /><br /><i>Changed From</i>:<br /><br />' . $curapp->appHTML($block,'changefrom','owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose) . '<br /><br /><i>Changed To</i>:<br /><br />' . $this->appHTML($block,'changeto','manager',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			else 
				$msg = $msghead . '<br /><br />' . $this->appHTML($block,$type,'manager',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose);
			/* Get list of managers */
			$managers = wassManager::wlistActiveManagers($this->calendarid);					 			
		  	/* Send to each manager on the list */
		  	foreach ($managers as $manager) {
				if ((($type == "remind" && $manager->remind) || ($type != "remind" && $manager->notify)) && ($sentprof != $manager->managerid) && ($manager->managerid != '')) {
					mail(wassDirectory::getEmail($manager->managerid),$subject,str_replace('XXX___XXX',urlencode(wassDirectory::getEmail($manager->managerid)),$msg), $headers);

					$mc++;
				}
			}
		}
		
		return "$pc,$sc,$mc"; 
					
	}
	
	
	/* Render appointment information into text */
	function appText($block,$target='owner') {
		
		$ret  = 'Appointment with: ' . $block->userid . "\r\n" .
		        '            name: ' . $block->name . "\r\n" .
				'          e-mail: ' . $block->email . "\r\n" .
				'       Telephone: ' . $block->phone . "\r\n" .
				'        location: ' . $block->location . "\r\n" .
				"\r\n";
		if ($this->userid) $ret .= 
				'Appointment  for: ' . $this->userid . "\r\n" .
				'            name: ' . $this->name . "\r\n";
		else $ret .=
				'Appointment  for: ' . $this->name . "\r\n";
		$ret .= '          e-mail: ' . $this->email . "\r\n" .
				'       Telephone: ' . $this->phone . "\r\n" .
				"\r\n" .
				'Date            : ' . substr($this->date,5,2) . '/' . substr($this->date,8,2) . '/' . substr($this->date,0,4) . 
				'Start time      : ' . wassUtil::AmPm($this->starttime) . "\r\n" .
				'End time        : ' . wassUtil::AmPm($this->endtime) . "\r\n" .
				"\r\n" .
				'Purpose         : ' . stripslashes($this->purpose) . "\r\n";	
		
		/* Include optional text */
		if ($block->appmsg)
			$ret .= 'Note            : The calendar owner has provided the following text.' . "\r\n" . stripslashes($block->appmsg) . "\r\n";	
				
								
		return wordwrap($message, 70, "\r\n");
	
	}
	 
	/* Render appointment information into html. */
	function appHTML($block, $type, $target='owner',$cname,$cemail,$cphone,$cstarttime,$cendtime,$cpurpose) {
		
		$ret = '<table>';
		$ret  .= '<tr><td>Appointment with:</td><td>' . $block->userid . '</td><td>&nbsp;</td></tr>' .
		         '<tr><td>Name:</td><td>' . $block->name . '</td><td>&nbsp;</td></tr>';
		if ($block->email)
			$ret .= '<tr><td>E-mail:</td><td><a href="mailto:' . $block->email . '">' .  $block->email . '</a></td><td>&nbsp;</td></tr>';
		$ret .= '<tr><td>Telephone:</td><td>' . $block->phone . '</td><td>&nbsp;</td></tr>' .
				'<tr><td>Location:</td><td>' . $block->location . '</td><td>&nbsp;</td></tr>' .
				'<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>';
		if ($this->userid) {
				$ret .= '<tr><td>Appointment for:</td><td>' . $this->userid . '</td><td>&nbsp;</td></tr>' . '<tr><td>Name:</td><td>' . $this->name . '</td><td>' ;
				if ($type == 'changeto') $ret .= $cname;
				$ret .= '&nbsp;</td></tr>';
		}
		else {
			$ret .= '<tr><td>Appointment for:</td><td>' . $this->name . '</td><td>';
			if ($type == 'changeto') $ret .= $cname;
			$ret .= '&nbsp;</td></tr>';
		}
		if ($this->email) {
			$ret .= '<tr><td>E-mail:</td><td><a href="mailto:' . $this->email . '">' . $this->email . '</a></td><td>';
			if ($type == 'changeto') $ret .= $cemail;
			$ret .= '&nbsp;</td></tr>';
		}
		$ret .= '<tr><td>Telephone:</td><td>' . $this->phone . '</td><td>';
		if ($type == 'changeto') $ret .= $cphone;
		$ret .= '&nbsp;</td></tr>' .
				'<tr><td>Date:</td><td>' . date('D',mktime(2,0,0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4))) . ', ' . substr($this->date,5,2) . '/' . substr($this->date,8,2) . '/' . substr($this->date,0,4) . '</td><td>&nbsp;</td></tr>';
		$ret .= '<tr><td>Start time:</td><td>' . wassUtil::AmPm($this->starttime) . '</td><td>';
		if ($type == 'changeto') $ret .= $cstarttime;
		$ret .= '&nbsp;</td></tr>';
		$ret .=	'<tr><td>End time:</td><td>' . wassUtil::AmPm($this->endtime) . '</td><td>';
		if ($type == 'changeto') $ret .= $cendtime;
		$ret .= '&nbsp;</td></tr>';
		if ($this->purpose) {
		  $ret .=	'<tr><td>Purpose:</td><td>' . stripslashes($this->purpose) . '</td><td>';
		  if ($type == 'changeto') $ret .= $cpurpose;
		  $ret .= '&nbsp;</td></tr>';	
		}
								
		$ret .= '</table>' . "\r\n";	
		
		/* Include optional text */
		$appmsg = trim($block->appmsg);
		if ($appmsg && ($type !='changefrom'))
			$ret .= '<br />The calendar owner has provided the following text: ' . stripslashes($block->appmsg) . '<br /><br />';
				
		/* Now append icalendar link. */
		
		if ($type == 'add' || $type == 'changeto') {
			
			$ret .= '<br /><br />' . 'You can view/make/edit/delete appointments on a mobile device  using the following URL:<br />' .
			'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] .  '/m';
						
			if ($type == 'add')
				$ret .= '<br /><br /><br /><p>' . 'If you would like to add this appointment to your local calendar, you have three options:';
			else
				$ret .= '<br /><br /><br /><p>' . 'If you would like to add or update this appointment on
				your local calendar, you have three options:';
				
			/* We need to determine whether to point to the student or professor calendar for the subscription.  */
			 
			 if ($target == 'student')
			 	$authid = $this->userid;
			else
				$authid = $block->userid;
				
			
			$ret .= '<ul><li>' . 'If you use a local calendaring application that supports internet calendar "subscription" (e.g., iCal on a Mac or Outlook on a PC), then you can subscribe your local calendaring application to the internet calendar at the following URL:<br />' .
			'<a href="'. 'webcal://' . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/ical.page.php?action=LISTAPPS&authid=' . $authid . '">webcal://' . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/ical.page.php?action=LISTAPPS&authid=' . $authid . '</a><br />This should cause your local calendaring appplication to automatically download all appointments you make.  You only need to do this once.';	
				
			$ret .= '</li><li>' . 'If you use a desktop calendaring program (such as Outlook or iCal or Entourage) and you wish to add this appointment to your local calendar, click <a href="' . 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/ical.page.php?action=GETAPP&appid=' . $this->appointmentid . '&authid=' . $this->userid . '&target=' . $target .'">here</a>.  This should cause your calendaring application to open, and the appointment to be added to your local calendar.';
			
			$ret .= '</li><li>' . 'If you use a browser-based desktop calendaring program (such as Gmail or Outlook Web Access), and you wish to add this appointment to your local calendar, click <a href="' . 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/ical.page.php?action=MAILAPP&appid=' . $this->appointmentid . '&authid=' . $this->userid . '&target=' . $target . '&toid=XXX___XXX' . '">here</a>.  This will cause an email to be sent to you which, when opened, will add the appointment to your local calendar.</li></ul></p>';	
		}
		elseif ($type == 'delete') {
			$ret .= '<br /><br /><br /><p>' . 'If you added this appointment to your local calendar using the email or link you initially received from the system, and you would like to remove the appointment from your local calendar, do one of the following:';
			
			$ret .= '<ul><li> If you use a desktop calendaring program (such as Outlook or iCal or Entourage), click <a href="' . 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/ical.page.php?action=DELAPP&uid=' . urlencode($this->uid) . '&date='  . urlencode(substr($this->date,0,4) . substr($this->date,5,2) . substr($this->date,8,2)) . '&sequence=' . urlencode($this->sequence) . '&tstart=' . urlencode(substr($this->starttime,0,2) . substr($this->starttime,3,2) . "00") . '&tend=' . urlencode(substr($this->endtime,0,2) . substr($this->endtime,3,2) . "00") . '&email=' . urlencode($this->email) .  '">here</a>.  This should cause your calendaring application to open, and the appointment to be deleted from your local calendar.';
			
			$ret .= '</li><li>' . 'If you use a browser-based calendaring program (such as Gmail or Outlook Web Access), click <a href="' . 'https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/../pages/ical.page.php?action=MAILDEL&uid=' . urlencode($this->uid) . '&date='  . urlencode(substr($this->date,0,4) . substr($this->date,5,2) . substr($this->date,8,2)) . '&tstart=' . urlencode(substr($this->starttime,0,2) . substr($this->starttime,3,2) . "00") .  '&sequence=' . urlencode($this->sequence) . '&tend=' . urlencode(substr($this->endtime,0,2) . substr($this->endtime,3,2) . "00") . '&email=' . urlencode($this->email) . '&toid=XXX___XXX' . '">here</a> to have a special email sent to you which, when opened, will delete the appointment from your local calendar.</li></ul></p>';		
		}
									
		return wordwrap($ret, 70, "\r\n");
	
	}

	/*
	This function determines if specified user owns the appointment (owns the
	appointment or owns/manages the block).
	*/
	function isOwner($usertype, $authid) {
		/* Not owner if no credentials */
		if (!$authid)
			return false;
	
		/* If userid/email matches, then owner */
		if ($usertype != 'guest') {
			if (trim(strtoupper($authid)) == trim(strtoupper($this->userid)))
				return true;
		}
		elseif ($authid && !$this->userid) {
			if (trim(strtoupper($authid)) == trim(strtoupper($this->email)))
				return true;	
		}
		
		/* If user owns the block, then they own this appointment. */
		try {
			if (!$block = new wassBlock('load', array('blockid'=>$this->blockid)))
				return false;;
		} catch (Exception $error) {
			return false;
		}
	
		return $block->isOwner($usertype, $authid);
	
	}	
	
	/*
	This function determines if a specified user can view this appointment,
	*/
	function isViewable($usertype, $authid) {
 	
		/* First, if user is owner, then viewable. */
		if ($this->isOwner($usertype, $authid))
			return true;
		

		/* If owning block is viewable by this user, then so is appointment. */
		try {
			if (!$block = new wassBlock('load', array('blockid'=>$this->blockid)))
				return false;;
		} catch (Exception $error) {
			return false;
		}
	
		return $block->isViewable($usertype, $authid);		

	} 

	/*
	This function returns an XML stream of appointment property values.
	*/
	function xmlStream() {
		return 
			$this->xmltag('appointmentid') .
			$this->xmltag('starttime') .
			$this->xmltag('date') .
			$this->xmltag('endtime') .
			'<apptmaker>' .
				$this->xmltag('userid') .
				$this->xmltag('name') .
				$this->xmltag('phone') .
				$this->xmltag('email') .
				$this->xmltag('office') .
				'</apptmaker>' .
			$this->xmltag('blockid') .
			$this->xmltag('calendarid') .
			$this->xmltag('purpose') .
			$this->xmltag('remind') .
			$this->xmltag('textemail') .
			$this->xmltag('whenmade') .
			$this->xmltag('madeby') .
			$this->xmltag('available') .
			$this->xmltag('uid') .
			$this->xmltag('sequence');
	}

	/*
	This function returns an XML stream of appointment header property values.
	*/
	function xmlHeaderStream() {
		return 
			$this->xmltag('appointmentid') .
			$this->xmltag('date') .
			$this->xmltag('starttime') .
			$this->xmltag('endtime') .
			'<apptmaker>' .
				$this->xmltag('userid') .
				$this->xmltag('name') .
				$this->xmltag('phone') .
				$this->xmltag('email') .
				$this->xmltag('office') .
				'</apptmaker>' .
			$this->xmltag('blockid') .
			$this->xmltag('calendarid');
	}

		
	/* 
	This function returns an xml tag with the specified property name and value 
	*/
	private function xmltag($property) {
		return '<'.$property.'>'.wassUtil::safeXml($this->{$property}).'</'.$property.'>';		
	}
	
}
?>