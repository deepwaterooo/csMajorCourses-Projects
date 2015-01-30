<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This class describes a block of available time.
*/

class wassBlock {
 
 
 	/* Properties */
	public $blockid;		/* Database id of the wassBlock block */
	public $periodid;       /* Database id of the wassPeriod record (if any) ... for recurring blocks */
	public $seriesid;      	/* Database id of the wassSeries record (if any) ... for recurring blocks */
	public $calendarid;     /* Database id of the wassCalendar record */
	public $title;			/* Title */
	public $description;	/* Description */
	public $userid;         /* Userid */
	public $name;  			/* Name of user */
	public $phone; 			/* Phone number of user */
	public $email;			/* Email of user */
	public $location;		/* Office location */
	public $starttime;		/* Starting time of block (24 hh:mm) */
	public $endtime;        /* End time of block  (24 hh:mm) */
	public $slotted;		/* Is block broken up into slots? */
	public $slotsize; 		/* If slotted, slot size in minutes */
	public $maxapps;		/* Maximum appointments per block (for unslotted block) */
	public $maxper;         /* Maximum appointments per person (for slotted block) */
	public $deadline;       /* Deadline for scheduling appointments, in minutes */
	public $candeadline;    /* Deadline for cancelling appointments, in minutes */
	public $opening;		/* When block becomes available for scheduling, in minutes */
	public $date;			/* Date */
	public $notify;			/* Send email notifications? */
	public $notifyman;		/* Send email notifications to manager? */					
	public $available;		/* Is block viewable? */
	public $makeaccess;		/* Make restrictions */
	public $viewaccess;		/* View restrictions */
	public $makeulist;		/* Appointment make user list */
	public $makeclist;		/* Appointment make course list */
	public $viewulist;		/* Block view user list */
	public $viewclist;		/* Block view course list */
	public $remind;			/* Send appointment reminders to owner? */
	public $remindman;		/* Send appointment reminders to managers? */	
	public $recurrence;     /* Once or multiple? */
	public $appmsg;         /* Text to be included in notification and reminder emails */
	public $showappinfo;    /* Set to 1 if everyone sees appointment details */
	public $uid;            /* Ical UID */
	public $sequence;       /* Update counter for generating iCal files */
	public $purreq;  		/* This block requires that appointment purposes be specified */
	
	/* Static (class) methods */
	
		
	/* Look up a block in the database and return its values as an associative array */
	static function find($id) {
		/* Get a database handle. */
		if (!wassSQL::openDB())
			return false;
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassBlock WHERE blockid=' . wassSQL::sqlSafe($id)))
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);

		/* Return the result */
		return $result;
	
	}
		
	
	/* Locate all blocks that meet the designated criteria, and return the php resource, or NULL.  */
	static function select($arr) {
		/* Issue the select call and return the results */
		return wassSQL::selectDB('wassBlock',$arr);			
	}
 	
	
	/* Return a list of blocks that meet the specified criteria */
	static function listMatchingBlocks($criteria) {
		return new wassList(wassSQL::buildSelect('wassBlock',$criteria),'Block');
	}
	
	
	/* Return a ordered list of blocks that meet criteria. */
	static function listOrderedBlocks($criteria,$orderby) {
		return new wassList(wassSQL::buildOrderedSelect('wassBlock',$criteria,$orderby),'Block');
	}		
		
	
	
	/*  Obect Methods */
	
	/* We have two constructors, one for a new block, one for an
	   existing block.  In the former case, we fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database block table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   block object.
	*/
	
	function __construct($source,$data) {
		/* $source tells us whether to 'load', 'update' or 'create' a block.
		   $data is an associative array of elements used when we need to create/update a block; for 'load', it contains just the blockid. 
		*/
		
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
	
	
		/* For load and update, find the block and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassBlock::find($ndata['blockid']))
				throw new Exception('Block id ' . $ndata['blockid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* Set defaults for unspecified values */
		if ($source == 'create') {
			/* Defaults are inherited first from the series (if any) or from the calendar (if no series). */			
			if (!$ndata['seriesid'])
				/* Get all of the calendar values */
				$defaults = wassCalendar::find($ndata['calendarid']);
			else
				/* Get all of the series values */
				$defaults = wassSeries::find($ndata['seriesid']);

			/* Get a list of all of the block properties */
			$properties = get_object_vars($this);

	
			/* Copy any unspecified values from the calendar or series */
			foreach ($defaults as $key=>$value) {
				if (array_key_exists($key,$properties))
					if (!array_key_exists($key,$ndata)) {
						$ndata[$key] = $value;
					}
			}	

			/* Set directory defaults for still unspecified values */
			if ($ndata['name'] == '')
				$ndata['name'] = wassDirectory::getName($ndata['userid']);
			if ($ndata['phone'] == '')
				$ndata['phone'] = wassDirectory::getPhone($ndata['userid']);
			if ($ndata['email'] == '')
				$ndata['email'] = wassDirectory::getEmail($ndata['userid']);
			if ($ndata['location'] == '')
				$ndata['location'] = wassDirectory::getOffice($ndata['userid']);
				
			/* Now set any remaining unspecified values to the default. */
			if ($ndata['makeaccess'] == '')	
				$ndata['makeaccess'] = 'limited';
			if ($ndata['viewaccess'] == '')		
				$ndata['viewaccess'] = 'limited';
			if 	(!array_key_exists('maxapps',$ndata))
				$ndata['maxapps'] = 0;
			if 	(!array_key_exists('maxper',$ndata))
				$ndata['maxper'] = 0;
			if 	(!array_key_exists('remind',$ndata))
				$ndata['remind'] = 1;
			if 	(!array_key_exists('remindman',$ndata))
				$ndata['remindman'] = 1;			
			if 	(!array_key_exists('notify',$ndata))
				$ndata['notify'] = 1;
			if 	(!array_key_exists('notifyman',$ndata))
				$ndata['notifyman'] = 1;
			if 	(!array_key_exists('showappinfo',$ndata))
				$ndata['showappinfo'] = 0;
			if 	(!array_key_exists('purreq',$ndata))
				$ndata['purreq'] = 0;
			if 	(!array_key_exists('available',$ndata))
				$ndata['available'] = 1;
			if 	(!array_key_exists('deadline',$ndata))
				$ndata['deadline'] = 0;	
			if 	(!array_key_exists('candeadline',$ndata))
				$ndata['candeadline'] = 0;	
			if 	(!array_key_exists('opening',$ndata))
				$ndata['opening'] = 0;	
			if 	(!array_key_exists('slotted',$ndata))
				$ndata['slotted'] = 0;	
			if 	(!array_key_exists('slotsize',$ndata))
				$ndata['slotsize'] = 0;	
			if 	(!array_key_exists('recurrence',$ndata) ||
				$ndata['recurrence'] == '')
				$ndata['recurrence'] = 'once';	
			if 	(!$ndata['uid'])
				$ndata['uid'] = date('Ymd\TGis') . "-" . rand(1000,1000000) . 'block@' .  $_SERVER['REQUEST_URI'];
			
		}			
	
		/* 
		For update, disallow changes that violate business rules. */
		if ($source == 'update') {
			$errmsg = $this->updateCheck($ndata);
			if ($errmsg)
				throw new Exception($errmsg,17);
		}
		
		
		
		/* For update and create, load up the values and validate the block. */
		if (($source == 'update') || ($source == 'create')) {
	
			wassUtil::loadObject($this,$ndata);
						
			if ($errors = $this->validate()) 
				throw new Exception($errors,17);
									
		}
	}		


	/*
	This function writes the block data out to the database.  
	The one argument specifies whether this is a new block or not.
	*/
	function save($type) {
	
		/*
		Reject attempt to create a block if one already exists for this user at this date/time (on any calendar).
		*/
		if ($type == 'create') {
			$query = 'SELECT * FROM ' . wassParms::DATABASE . '.wassBlock WHERE (' .
				'date = ' . wassSQL::sqlSafe($this->date) . ' AND ' .
				'starttime < ' . wassSQL::sqlSafe($this->endtime) . ' AND ' .
				'endtime > ' . wassSQL::sqlSafe($this->starttime) . ' AND ' .
				'userid = ' . wassSQL::sqlSafe($this->userid);
				
			/* If the calendar allows overlap, we need to exclude all but the owning calendar from the check */
			$calarray = wassCalendar::find($this->calendarid);
			 
			if ($calarray['overlapok'])
				$query .= ' AND calendarid=' . $this->calendarid;
			 
				 	
			$query .= ')';	
			$allready = wassSQL::doQuery($query);		
			
			if ($allready) {
				if (wassSQL::num_rows($allready) > 0) {
					$matchblock = wassSQL::doFetch($allready);
					if ($matchblock['calendarid'] == $this->calendarid)
						$msg = 'Block start/end times conflict with existing block on this calendar.';
					else {
						$matchcal = wassCalendar::find($matchblock['calendarid']);
						$msg = 	'Block start/end times conflict with existing block on calendar with title "' . $matchcal['title'] . '"';
					}
					throw new Exception($msg ,14);
				}
			}
		}
		
		/* Assume no new slots
		$newslots = false;
		*/

		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
			/* Save flag about newly available slots 
			$newslots = true;
			*/
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify a blockid */
				if ($key != 'blockid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= '`'.$key.'`';
					if ($vallist)
						$vallist .= ',';
					$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sql = 'INSERT INTO ' . wassParms::DATABASE . '.wassBlock (' . $varlist . ') VALUES (' . $vallist . ')';
		}
		/* Else create the update list */
		else {
			$sql = '';
			foreach ($this as $key=>$value)  {
				if ($sql)
					$sql .= ', ';
				$sql .= '`'.$key.'`' . '=' . wassSQL::sqlSafe($value);	
			}
			/* We also need to increment the sequence number */
			if ($sql)
				$sql .= ', ';
			$sql .= 'sequence = sequence+1';
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassBlock SET ' . $sql . ' WHERE blockid=' . $this->blockid;	
		}
		
		/* Now do the update (and blow up if we can't) */
		if (!wassSQL::doQuery($sql))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16);
				
		/* Get the (new) id and return it */
		if ($type == 'create')
			$this->blockid = wassSQL::insert_id();
			
	
		return $this->blockid;
	}


	/*
	This function validates data passed to create or update a block.
	*/				
	function validate() {
		/* Validate passed data, pass back error string if any errors. */
		$errors = '';

		/* userid */
		if (!$this->userid)
			$errors .= 'userid required; ';

		/* Read in the calendar */
		if (!($calendar = wassCalendar::find($this->calendarid)))
				$errors .= 'Invalid calendarid: ' . $this->calendarid . '; ';

 		/* Read in the series (if there is one) */
		if ($this->seriesid)
			if (!($series= wassSeries::find($this->seriesid)))
				$errors .= 'Invalid seriesid: ' . $this->seriesid . '; ';
		
		/* userid */
		if (!$calendar['group']) {
			if ($this->userid != $calendar['userid'])
				$errors .= 'Block userid (' . $this->userid .') must match calendar userid (' . $calendar['userid'] . '); ';
		}
		else {
			if (($this->userid != $calendar['userid']) && !wassManager::isManager($calendar['calendarid'],$this->userid,''))
				$errors .= 'Block userid (' . $this->userid .') must match calendar userid (' . $calendar['userid'] . ' or a calendar member userid); ';
		}

		/* starttime and endtime */	
		$blocksize = wassUtil::elapsedTime($this->starttime,$this->endtime);
		
		if (!wassUtil::checkTime($this->starttime)) 
			$errors .= 'Invalid start time: ' . $this->starttime . '; ';
		if (!wassUtil::checkTime($this->endtime))
			$errors .= 'Invalid end time: ' . $this->endtime . '; ';
		if ($blocksize <= 0)
 			$errors .= 'End time must be > start time; ';

		/* date */
		if (!wassUtil::isDateValid($this->date))
			$errors .= 'Invalid date: ' . $this->date . '; ';

		/* slotted */
		if (!wassUtil::checkBool($this->slotted)) {
			$errors .= 'Invalid slotted value: ' . $this->slotted . '; ';
			$slotted = false;
		}
		else
			$slotted = $this->slotted;
				
		/* slotsize */
		if (!is_numeric($this->slotsize)) {
				$errors .= 'Invalid value for slot size: ' . $this->slotsize . '; ';
		}
		if ($slotted && !($this->slotsize))
			$errors .= 'Value must be specified for slot size for slotted blocks; ';
		if ($slotted) {
			if ($blocksize <= $this->slotsize)
				$errors .= 'Slot size must be less than block size.  Specify a slot size of "none" if you want an unslotted block; ';
			if ($blocksize%$this->slotsize)
				$errors .= 'Slot size value must evenly divide the block duration; ';
		}
		
		/* maxapps */
		if (!is_numeric($this->maxapps))
			$errors .= 'maxapps must be an integer; ';

		/* maxper */
		if (!is_numeric($this->maxper))
			$errors .= 'maxper must be an integer; ';

		/* deadline */
		if (!is_numeric($this->deadline))
			$errors .= 'deadline must be an integer; ';
		if (!is_numeric($this->candeadline))
			$errors .= 'candeadline must be an integer; ';
		if (!is_numeric($this->opening))
			$errors .= 'opening must be an integer; ';
			
		/* notify, notifyman, available */

		if (!wassUtil::checkBool($this->notify))
			$errors .= 'notify must be a boolean; ';

		if (!wassUtil::checkBool($this->notifyman))
			$errors .= 'notifyman must be a boolean; ';

		if (!wassUtil::checkBool($this->available))
			$errors .= 'available must be a boolean; ';
													
		/* makeaccess, viewaccess */
		if (($this->makeaccess != 'open') && ($this->makeaccess != 'limited') && ($this->makeaccess != 'restricted') && ($this->makeaccess != 'private'))
			$errors .= 'Invalid makeaccess value: ' . $this->makeaccess . '; ';		
		
		if (($this->viewaccess != 'open') && ($this->viewaccess != 'limited') && ($this->viewaccess != 'restricted') && ($this->viewaccess != 'private'))
			$errors .= 'Invalid viewaccess value: ' . $this->viewaccess . '; ';		

		/* makeulist, makeclist, viewulist, viewclist */


		/* remind, remindman, showappinfo, purreq */
		if (!wassUtil::checkBool($this->remind))
			$errors .= 'remind must be a boolean; ';
		if (!wassUtil::checkBool($this->remindman))
			$errors .= 'remindman must be a boolean; ';
		if (!wassUtil::checkBool($this->showappinfo))
			$errors .= 'showappinfo must be a boolean; ';
		if (!wassUtil::checkBool($this->purreq))
			$errors .= 'purreq must be a boolean;';


 		/* recurrence */
		if (($this->recurrence != 'once') && ($this->recurrence != 'multiple'))
			$errors .= 'Invalid recurrence value: ' . $this->recurrence . '; ';					
		if (($this->recurrence == 'multiple') && (!$this-seriesid))
			$errors .= 'Series id must be specified with recurrence=multiple; ';
			
		
		/* Return any detected errors */
		return $errors;
	
	}


	/*
	This function checks to see if proposed changes to the blocks violate any business rules.
	 */
	function updateCheck($ndata) {
		if (array_key_exists('calendarid',$ndata) && ($ndata['calendarid'] != $this->calendarid)) 
			return 'Cannot assign block to a new calendar';
		if (array_key_exists('seriesid',$ndata) && ($ndata['seriesid'] != $this->seriesid)) 
			return 'Cannot assign block to a new series';
		if (array_key_exists('periodid',$ndata) && ($ndata['periodid'] != $this->periodid)) 
			return 'Cannot assign block to a new period';

			
		/* 
		If any appointments are scheduled, we have to be careful about resetting start time or end time or date or slotsize or slotted status to make sure we don't wipe out any appointments. 
		*/
		if (
		(array_key_exists('starttime',$ndata) && $ndata['starttime'] != $this->starttime) || 
		(array_key_exists('endtime',$ndata) && $ndata['endtime'] != $this->endtime) || 
		(array_key_exists('date',$ndata) && $ndata['date'] != $this->date) || 
		(array_key_exists('slotsize',$ndata) && $ndata['slotsize'] != $this->slotsize) ||
		(array_key_exists('slotted',$ndata) && $ndata['slotted'] != $this->slotted) 
		) {
			if (array_key_exists('starttime',$ndata)) 
				$newstart = wassUtil::timeToMin($ndata['starttime']); 
			else
				$newstart = wassUtil::timeToMin($this->starttime); 
			if (array_key_exists('endtime',$ndata)) 
				$newend = wassUtil::timeToMin($ndata['endtime']); 
			else
				$newend = wassUtil::timeToMin($this->endtime);
			if (array_key_exists('date',$ndata)) 
				$newdate = $ndata['date'];
			else
				$newdate = $this->date; 
			if (array_key_exists('slotsize',$ndata)) 
				$newslotsize = $ndata['slotsize'];
			else
				$newslotsize = $this->slotsize; 
			if (array_key_exists('slotted',$ndata)) 
				$newslotted = $ndata['slotted'];
			else
				$newslotted = $this->slotted; 
				
			/* Build list of all appointments */
			$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid)),'Appointment');
			/* See if proposed changes conflict with any appointments */
			foreach ($apps as $app) {
				$appstart = wassUtil::timeToMin($app->starttime);
				$append = wassUtil::timeToMin($app->endtime);
				$appsize = $append - $appstart;
				if ($newslotted != $this->slotted)
					return 'Change to slotted status conflicts with appointment on ' . wassUtil::usDate($app->date) . ' from ' . wassUtil::AmPm($app->starttime) . ' to ' . wassUtil::AmPm($app->endtime);
				if (($appstart < $newstart) || ($append > $newend))
					return 'Change to block start/end times conflicts with appointment on ' . wassUtil::usDate($app->date) . ' from ' . wassUtil::AmPm($app->starttime) . ' to ' . wassUtil::AmPm($app->endtime);
				if ($app->date != $newdate)
					return 'Change to block date conflicts with appointment on ' . wassUtil::usDate($app->date) . ' from ' . wassUtil::AmPm($app->starttime) . ' to ' . wassUtil::AmPm($app->endtime);	
				if ($this->slotted && (($appsize < $newslotsize) || ($appsize%$newslotsize)))
					return 'Change to block slotsize conflicts with appointment on ' . wassUtil::usDate($app->date) . ' from ' . wassUtil::AmPm($app->starttime) . ' to ' . wassUtil::AmPm($app->endtime);	
			}
		}
		return '';		
	}
	
	/*
	This function deletes the SQL entry for the current block.
	*/
	function delete($canceltext) {
		/* First, cancel any appointments */
		$this->cancelApps($canceltext);
	
		/* Save the deleted block data for later delivery as an Ical CANCEL */
		
		/* First, compute the DTSTART 
		$dtstart = gmdate('Ymd\THis\Z',mktime(substr($this->starttime,0,2),substr($this->starttime,3,2),0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4)));
		*/
		/* Now write out the deleted appointment data 
		wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassDeleted (calendarid,sequence,uid,dtstart) VALUES (' . wassSQL::sqlSafe($this->calendarid) . ',' .  wassSQL::sqlSafe($this->sequence + 1) . ',' .   wassSQL::sqlSafe($this->uid) . ',' . wassSQL::sqlSafe($dtstart) . ');');
		*/
			
		/* Delete this block */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassBlock WHERE blockid=' . $this->blockid . ' LIMIT 1');		

	}

	/*
	This function cancels any appointments for this block, and sends
	email (if necessary).
	*/
	function cancelApps($canceltext) {
		
		/* First, create list of appointments for this block */
		$applist = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid)),'Appointment');
		
		/* Now go through the appointments and cancel them. */
		foreach ($applist as $app) {
			$app->delete($canceltext, $this);
			unset($app);
		}
		unset($applist);	
	}
	

	/*
	This function determines if a specified user can view this block.
	*/
	function isViewable($usertype, $authid) {
 	
		/* First, if user is owner, then viewable. */
		if ($this->isOwner($usertype, $authid))
			return true;

		/* If not available, then not viewable */
		if (!$this->available)
			return false;
		
		/* Select on view access type */
		switch($this->viewaccess) {
		
			/* For open block, anyone can view it */
			case 'open':
				return true;
		
			/* For private block, must be owner or manager (we already tested for that) */
			case 'private':
				return false;
				break;
			
			/* For limited, must have a userid (any userid). */	
			case 'limited':
				if ($usertype != 'guest')
					return true;
				else
					return false;
				break;
			
			/* For restricted access, must be in user list or course list. */
			case 'restricted':	
				if ($usertype == 'guest')
					return false;				
				elseif (in_array($authid,explode(',',$this->viewulist)))
					return true;
				else
					return wassUtil::IsUserInCourse(explode(',',$this->viewclist),$authid);		
				break;
						
		}
	
	}
	

	/*
	This function computes how many (consecutive) appointments a user may make for a block.
	*/
	function makeableApps($usertype,$authid) {
	
		/* First, see if user can make any appointments at all. */
		if (($whynot = $this->isMakeable($usertype,$authid,"","")) != '')
			return 0;
	

		/* If an unslotted block, can only make an appointment if one doesn't already exist. */
		if (!$this->slotted) {
			if ($this->usedSlots($usertype, $authid))
				return 0;
			else
				return 1;
 		}	
		
					
		/* Owners can make as many appointments as are available.  */			
		if ($this->isOwner($usertype,$authid))
			return $this->freeSlots();
		/* Non-owner can make as many as are available minus as many as they have already made. */			
		else {
			if ($this->maxper != 0)
				$avail = min($this->freeSlots(), $this->maxper);
			else
				$avail = $this->freeSlots();
			$avail -= $this->usedSlots($usertype, $authid);
			return max($avail,0);
		}
	
	}
	
	


	/*
	This function computes how many (consecutive) appointments a user may make for a block when editing an appointment.
	*/
	function editableApps($usertype,$authid,$curapp) {
	
		/* First, see if user can make any appointments at all. */
		if (($whynot = $this->isEditable($usertype,$authid,"","",$curapp)) != '')
			return 0;
		
		/* For an unslotted block */
		if (!$this->slotted)  
			/* Since user has an appointment, they can always edit that one (and only 1). */
			return 1;
			
		/* For a slotted block, they can make as many as are available, plus the current one */
		else 
			return min($this->makeableApps($usertype,$authid) + 1,$this->totalSlots());
			
	
	}
	
	
	
	
	
	/*
	This function determines if the specified user can make an appointment.  If so,
	it returns an empty string.  If not, it returns the reason why not.
	*/
	function isMakeable($usertype, $authid, $starttime, $endtime) {

		/* Save ownership status */
		$isOwner = $this->isOwner($usertype,$authid);

		/* Start by computing total number of appointments made, and
		   total made by this user. */
					
		$totalapps = $this->usedSlots('',"");
		$userapps = $this->usedSlots($usertype,$authid);	
		
		
		/* The only case in which an owner/manager cannot make an appointment is if all
			the slots in a slotted block are taken, Determine if that is the case. */
			
		if ($isOwner) {
			if ($this->slotted && (!$this->freeSlots()))
				return 'No appointment slots available';
			return '';	
		}
			
				
		/* Now we know we are not dealing with an owner/manager */	
		
		/* If block unavailable, disallow */
		if (!$this->available)
			return 'Block of time is unavailable';
		
		/* If no appointment slots available, disallow */
		if (!$this->freeSlots())
			return 'All appointment slots already taken.';	
		
		/* If in the past, disallow */
		
		if (wassUtil::beforeToday($this->date))	
			return 'Cannot make appointment in the past.';
	
		/*
		If deadline set, check if it has passed.
		*/
		if ($this->deadline) {
			/* Compute block start time as unix time, and subtract off deadline (in seconds) */
			$bstart = mktime(substr($this->starttime,0,2),substr($this->starttime,3,2),0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4));
			if (mktime() > $bstart)
				return 'Scheduling deadline has passed.';
		}

		/*
		If opening set, make sure it has been reached.
		*/
		if (!$this->opening_reached($this->date,$this->starttime))
			return 'Scheduling opening has not been reached.';
		

		/* 
		If today, check current time against start of block .
		*/
		elseif (wassUtil::isToday($this->date)) {
	
			/* Get current time in minutes */
			$currmin = (date('H') * 60) + (date('i'));	
			/* Compute block end time in minutes */
			$bend = (substr($this->endtime,0,2) * 60) + substr($this->endtime,3,2);
						
			/* Check if endtime of block reached */
			if ($currmin >= $bend) 
				return 'No time left in this block.';
			
		}

		/* Select on make access type */
		switch($this->makeaccess) {
		
			/* For open block, anyone can view it */
			case 'open':
				break;
		
			/* For private block, must be owner or manager (we already tested for that) */
			case 'private':
				return 'Access to this time period is restricted.';
				break;
			
			/* For limited, must have a uerid (any userid). */	
			case 'limited':
				if ($usertype == 'guest')
					return 'Access to this time period is restricted.';
				break;
			
			/* For restricted access, must be in user list or course list. */
			case 'restricted':	
				if ($usertype == 'guest')
					return 'Access to this time period is restricted.';				
				elseif (!(in_array($authid,explode(',',$this->makeulist))) &&
						!(wassUtil::IsUserInCourse(explode(',',$this->makeclist),$authid)))	
						return 'Access to this time period is restricted.';
				break;
										
		}		
				
			
		/* Now see if appointment limits have been exceeded. */	

		/* If slotted block, check for per-user limit being exceeded. */
		if ($this->slotted) {
			if ($this->maxper) {
				if ($userapps >= $this->maxper)
					return 'You have reached the appointment scheduling limit.';
			}
		}
		/* If unslotted, check if appointment limit exceed or if appointment already made. */
		else {
			if ($this->usedSlots($usertype, $authid))
				return 'User ' . $authid . ' already has an appointment for this time period.';
			if ($this->maxapps) {
				if ($totalapps >= $this->maxapps) 
					return 'Maximum number of appointments already scheduled.';				
			}
		}	

		/* If start/end times specified, check if slots are still available. */
		if ($this->slotted) {
			if ($starttime) {
				$startmin = wassUtil::timeToMin($starttime);
				if ($endtime)
					$endmin = wassUtil::timeToMin($endtime);
				else
					$endmin = $startmin + $this->slotsize;
				/* Make sure user does not try to take more slots than they are allowed to take */
				$slotswanted = ($endmin-$startmin)/$this->slotsize;
				if ($this->maxper && !$isOwner)
					if ($slotswanted > $this->maxper)
						return 'You may not take more than ' . $this->maxper . ' appointment slots for this block';						
				/* Make sure slots are not already taken */		
				for ($i=$startmin; $i<$endmin; $i+=$this->slotsize) {
					$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid,'starttime'=>wassUtil::timeToMin($i))),'Appointment');
					if ($apps->entries())
						return 'Appointment slot is already taken.';
					unset($apps);
				}
			}
		}   
		
		
	
	/* All tests have passed. */
	return '';
	

	}

	
	/*
	This function determines if the specified user can edit an appointment.  If so,
	it returns an empty string.  If not, it returns the reason why not.
	*/
	function isEditable($usertype, $authid, $starttime, $endtime, $curapp) {
		
		/* Save ownership status */
		$isOwner = $this->isOwner($usertype,$authid);
		
		/* An owner can always edit an appointment, unless trying to change the start/end times */
		if ($isOwner && !$starttime)
			return '';
		
		
		
		/* Start by computing total number of appointments made, and
		   total made by this user. */
					
		$totalapps = $this->usedSlots('',"");
		$userapps = $this->usedSlots($usertype,$authid);	
		
			
				
		/* Skip access control checks if owner */	
		
		if (!$isOwner) {

		  /* If block unavailable, disallow */
		  if (!$this->available)
			  return 'Block of time is unavailable';
		  
		  
		  /* If in the past, disallow */
		  
		  if (wassUtil::beforeToday($this->date))	
			  return 'Cannot change an appointment in the past.';
	  
		  /*
		  If deadline set, check if it has passed.
		  */
		  if ($this->deadline) {
			  /* Compute block start time as unix time, and subtract off deadline (in seconds) */
			  $bstart = mktime(substr($this->starttime,0,2),substr($this->starttime,3,2),0,substr($this->date,5,2),substr($this->date,8,2),substr($this->date,0,4));
			  if (mktime() > $bstart)
				  return 'Scheduling deadline has passed.';
		  }
  
		  /*
		  If cancellation deadline passed, also disallow.
		  */
		  if ($this->candeadline_reached($this->date,$this->starttime))
		  	return 'Cancellation deadline has passed.';
			
  
		  /* 
		  If today, check current time against start of block .
		  */
		  elseif (wassUtil::isToday($this->date)) {
	  
			  /* Get current time in minutes */
			  $currmin = (date('H') * 60) + (date('i'));	
			  /* Compute block end time in minutes */
			  $bend = (substr($this->endtime,0,2) * 60) + substr($this->endtime,3,2);
						  
			  /* Check if endtime of block reached */
			  if ($currmin >= $bend) 
				  return 'No time left in this block.';
			  
		  }
		}
				
		/* If start/end times specified, check if slots are still available. */
		if ($this->slotted) {
			if ($starttime) {
				/* Compute start and end times requested */
				$startmin = wassUtil::timeToMin($starttime);
				if ($endtime)
					$endmin = wassUtil::timeToMin($endtime);
				else
					$endmin = $startmin + $this->slotsize;
				/* If editing, compute current start and end times */
				if ($curapp) {
					$curstart = wassUtil::timeToMin($curapp->starttime);
					$curend = wassUtil::timeToMin($curapp->endtime);
				}
				/* Make sure user does not try to take more slots than they are allowed to take */
				$slotswanted = ($endmin-$startmin)/$this->slotsize;
				if ($this->maxper && !$isOwner)
					if ($slotswanted > $this->maxper)
						return 'You may not take more than ' . $this->maxper . ' appointment slots for this block';
				/* Make sure user does not try to take an already scheduled slot */
				for ($i=$startmin; $i<$endmin; $i+=$this->slotsize) {
					if ($curapp)
						if ($i >= $curstart && $i <= $curend) 
							continue;
					$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid,'starttime'=>wassUtil::timeToMin($i))),'Appointment');
					if ($apps->entries())
						return 'Appointment slot at ' . wassUtil::timeToMin($i) . ' is already taken.';
					unset($apps);
				}
			}
		}   
		
		
	
	/* All tests have passed. */
	return '';
	

	}
	
	
	/*
	This function computes how many slots are still available for a
	slotted block or an unslotted block with a maximum set.  It returns 1 for
	an unslotted block with no maximum set.
	*/
	function freeSlots() {
		/* Compute how many slots aleady in use, total. */
		$used = $this->usedSlots('','');
		
		/* For an unslotted block */
		if (!$this->slotted) {
			if (!$this->maxapps)
				return 1;
			else
				if ($used >= $this->maxapps)
					return 0;
				else
					return ($this->maxapps - $used); 
		}
		/* For a slotted block, return total slots minus used slots. */
		else 
			return $this->totalSlots() - $used;
	}
	
	
	/*
	This function returns a list of the start times of available slots (in 24-hour hh:mm format).  'Avaliable' means not earlier than current time (minus delay), and greater than opening (if set).
	*/
	function availableSlots($usertype,$authid) {
		/* Make sure opening has been reached */
		if (!$this->opening_reached($this->date,$this->starttime) && !$this->isOwner($usertype,$authid))
			return array();
		
		/* Compute deadline for scheduling an appointment */
		if (wassUtil::isToday($this->date) && !$this->isOwner($usertype,$authid))
			$deadline = (date('G')*60) + date('i') - $this->deadline;
		else
			$deadline = 0;

		/* For an unslotted block, just return start time (unless full, or opening not yet reached) */
		if (!$this->slotted) {
			if ($this->freeSlots()) {

				/* Make sure there's still time to sign up */
				$endmins = wassUtil::timeToMins($this->endtime);
				if ($endmins > $deadline)
					return array($this->starttime);
				else
					return array();
			}
			else
				return array();		
		}
		else {
			/* Build list of all appointments for this block */
			$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid)),'Appointment');
			
			/* Build array of in-use start times (in minutes) */
			$allready = array();
			foreach ($apps as $app) {
				/* 
				An appointment can span multiple slots; we need to make sure that all of the slots are
				   flagged as taken. 
				*/
				for ($i=wassUtil::timeToMin($app->starttime); $i<wassUtil::timeToMin($app->endtime); $i+=$this->slotsize) {
					$allready[] = $i;
				}
			}
			
			/* 
			Go through all possible start times for the block, save any that are not used 
			*/
			$available = array();
			for ($i=wassUtil::timeToMin($this->starttime); $i<wassUtil::timeToMin($this->endtime); $i+=$this->slotsize) {
				/* If not already taken */
				if (!in_array($i,$allready))
					/* If not too late */
					if ($i > $deadline)
						$available[] = wassUtil::minToTime($i);
			}
			return $available;
		}
	}


	/*
	This function returns a list of the start times of editable slots (in 24-hour hh:mm format).  'Editable' means not earlier than current time (minus delay).
	*/
	function editableSlots($usertype,$authid, $curapp) {
		/* Compute deadline for scheduling an appointment */
		if (wassUtil::isToday($this->date) && !$this->isOwner($usertype,$authid))
			$deadline = (date('G')*60) + date('i') - $this->deadline;
		else
			$deadline = 0;

		/* For an unslotted block, just return start time (unless deadline passed) */
		if (!$this->slotted) {
			/* Make sure there's still time to sign up */
			$endmins = wassUtil::timeToMins($this->endtime);
			if ($endmins > $deadline)
				return array($this->starttime);
			else
				return array();	
		}
		else {
			/* Build list of all appointments for this block */
			$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid)),'Appointment');
			
			/* Build array of in-use start times (in minutes), but exclude any for the current appointment */
			$allready = array();
			foreach ($apps as $app) {
				/* 
				An appointment can span multiple slots; we need to make sure that all of the slots are
				   flagged as taken. 
				*/
				$curstart = wassUtil::timeToMin($curapp->starttime);
				$curend = wassUtil::timeToMin($curapp->endtime);
				for ($i=wassUtil::timeToMin($app->starttime); $i<wassUtil::timeToMin($app->endtime); $i+=$this->slotsize) {
					if ($i < $curstart || $i > $curend) 
						$allready[] = $i;
				}
			}
			
			/* 
			Go through all possible start times for the block, save any that are not used 
			*/
			$available = array();
			for ($i=wassUtil::timeToMin($this->starttime); $i<wassUtil::timeToMin($this->endtime); $i+=$this->slotsize) {
				/* If not already taken */
				if (!in_array($i,$allready))
					/* If not too late */
					if ($i > $deadline)
						$available[] = wassUtil::minToTime($i);
			}
			return $available;
		}
	}

	/*
	This function checks to see if a slot is already booked (or a block is full).  This can happen
	if two people are making an appointment at the same time.  The second argument is used if editing an appointment,
	and causes the current appointment's time slots to be ignored.
	*/
	function booked($starttime,$endtime,$curapp) {
		/* Compute start/end time in minutes */
		$startmin = wassUtil::timeToMin($starttime);
		$endmin = wassUtil::timeToMin($endtime);
		
		/* If not slotted, see if at or over booking limit */ 
		if (!$this->slotted) {
			/* If editing an existing app, then we cannot be over the limit */
			if ($curapp)
				return false;
			/* See if maxapps is set and, if so, if it would be exceeded */
			if ($this->maxapps) {
				if ($this->usedSlots("","") >= $this->maxapps) {
					return true;
				}
				else
					return false;
			}
			else 
				return false;
		}
			
		
		/* If slotted, check both total apps and apps for the specified starttime */
		if (!$curapp && ($this->usedSlots('','') >= $this->totalSlots())) {
			return true;
		}
			
		/* See if requested time overlaps other appointments */
		if ($starttime) {
			$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid)),'Appointment');
			if (is_object($apps)) {
				foreach ($apps as $app) {
					/* If there is overlap between existing app and new app */
					if (($startmin < wassUtil::timeToMin($app->endtime)) && ($endmin > wassUtil::timeToMin($app->starttime))) {
						/* If not editing, then we have a conflict */
						if (!$curapp)
							return true;
						/* If editing, conflict if not overlapping oneself. */
						else
							if ($curapp->appointmentid != $app->appointmentid)
								return true;							
					}			
				}
			}
			return false;
		}	
		
		return false;
	}
	

	
	/*
	This function checks to see if slots have been overbooked.  This can happen
	if two people are making an appointment at the same time.
	*/
	function overBooked($starttime) {
		/* If not slotted, see if over booking limit */ 
		if (!$this->slotted) {
			if ($this->maxapps) {
				if ($this->usedSlots("","") > $this->maxapps) {
					return true;
				}
				else
					return false;
			}
			else 
				return false;
		}
			
		
		/* If slotted, check both total apps and apps for the specified starttime */
		if ($this->usedSlots('','') > $this->totalSlots()) {
			return true;
		}
		if ($starttime) {
			$apps = new wassList(wassSQL::buildSelect('wassAppointment',array('blockid'=>$this->blockid,'starttime'=>$starttime.':00')),'Appointment');
			if (is_object($apps)) {
				if (($apps->entries()) > 1) {
					return true;
				}
			}
			return false;
		}		
		return false;
	}
	
	
	
	/*
	This function computes how many appointment slots (or appointments, if
	an unslotted block) have been scheduled.  If given an authid argument, it just counts
	the appointments scheduled for that user.
	*/
	function usedSlots($usertype,$authid) {
	
		/* Build select list based on arguments */
		if (!$usertype)
			$loadarg = array('blockid'=>$this->blockid);
		elseif ($usertype == 'guest')
			$loadarg = array('blockid'=>$this->blockid,'email'=>trim($authid));
		else 
			$loadarg = array('blockid'=>$this->blockid,'userid'=>trim($authid));
			
		/* Get list of all appointments */
		$apps = new wassList(wassSQL::buildSelect('wassAppointment',$loadarg),'Appointment');
		/* Cound up the appointments (or slots, if slotted) */
		$slotcount = 0;
		foreach($apps as $app) {
			if (!$this->slotted)
				$slotcount++;
			else 
				$slotcount += (wassUtil::timeToMin($app->endtime) - wassUtil::timeToMin($app->starttime))/$this->slotsize;
		}
		return $slotcount;
	}
	
	/*
	This function returns the total count of slots for a block.
	*/
	function totalSlots() {
		/* If not slotted, return 0 or maxapps */
		if (!$this->slotted) 
			return $this->maxapps;
		/* Else return count of slots */
		return (wassUtil::timeToMin($this->endtime) - wassUtil::timeToMin($this->starttime))/$this->slotsize;	
	}
	
	
	/*
	This function determines if a cancellation deadline has been reached.
	*/
	function candeadline_reached($appdate,$appstarttime) {
		/* If no deadline set, return false */
		if (!$this->candeadline)
			return false;
		/* Now get current date and time in Unix format */
		$curtime = mktime();
		/* Compute appointment starttime minus deadline (in minutes) */
		$limit = mktime(substr($appstarttime,0,2),substr($appstartime,3,2),0,substr($appdate,5,2),substr($appdate,8,2),substr($appdate,0,4)) - ($this->candeadline * 60);
		/* If limit reached, return true */
		if ($curtime > $limit)
			return true;
		else
			return false;	
	}
	
	/*
	This function determines if an opening has been reached.
	*/
	function opening_reached($date,$time) {
		/* If no opening set, return true */
		if (!$this->opening)
			return true;
		/* Now get current date and time in Unix format */
		$curtime = mktime();
		/* Compute starttime minus opening (in minutes) */
		$limit = mktime(substr($time,0,2),substr($time,3,2),0,substr($date,5,2),substr($date,8,2),substr($date,0,4)) - ($this->opening * 60);
		/* If limit reached, return true */
		if ($curtime >= $limit)
			return true;
		else
			return false;	
	}
	
	
	/*
	This function determines if specified user owns the block, or owns the calendar to which the block belongs.
	*/
	function isOwner($usertype, $authid) {
	
		/* If userid matches, then this is the owner */
		if (($usertype != 'guest') && (strtoupper(trim($authid)) == strtoupper(trim($this->userid))))
			return true;
			
		/* Load the calendar. */
		try {
			if (!$calendar = new wassCalendar('load', array('calendarid'=>$this->calendarid)))
				return false;;
		} catch (Exception $error) {
			return false;
		}
	
		if ($calendar->group)
			return $calendar->isOwner($usertype, $authid);
		else
			return $calendar->isOwnerOrManager($usertype, $authid);
	
	}
	
	
}
?>