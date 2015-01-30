<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This class describes a calendar.  Calendars point to blocks of available time,
which in turn point to appointments.  Each user of the system has one calendar.
*/

class wassCalendar {
 
 
 	/* Properties */
	public $calendarid;		/* Database id */
	public $title;			/* Title */
	public $description;	/* Description */
	public $userid;			/* Userid of user */
	public $name;  			/* Name of user */
	public $phone; 			/* Phone number of user */
	public $email;			/* Email of user */
	public $managers;       /* List of comma-separated manager ids (if any):  DEPRECATED */
	public $location;		/* Office location */
	public $notify;			/* Default for sending email notifications */
	public $notifyman;		/* Default for sending email notifications to manager */
	public $available;		/* Is calendar viewable */
	public $makeaccess;		/* Default appointment make restrictions */
	public $viewaccess;		/* Default calendar view restrictions */
	public $makeulist;		/* Default appointment make user list */
	public $makeclist;		/* Default appointment make course list */
	public $viewulist;		/* Default calendar view user list */
	public $viewclist;		/* Default calendar view course list */
	public $remind;         /* Default for sending appointment reminders to calendar owner */
	public $remindman;      /* Default for sending appointment reminders to calendar managers */
	public $appmsg;         /* Default text to be included in notification and reminder emails */
	public $showappinfo;    /* Set to 1 if everyone sees appointment details */
	public $group;          /* This is a group calendar */
	public $purreq;  		/* This calendar requires that appointment purposes be specified */
	public $overlapok;  	/* Allow blocks on this calendar to overlap blocks on other calendars */
	
	
	/* Static (class) methods */
	
		
	/* 
	Look up a calendar from its id in the database and return its values as an associative array.
	*/
	static function find($id) {
		/* Get a database handle. */
		if (!wassSQL::openDB()) 
			return false;
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassCalendar WHERE calendarid=' . wassSQL::sqlSafe($id))) 
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);

		/* Free up the query */
		wassSQL::freeQuery($entry);	

		/* Return the result */
		return $result;
	
	}


	/* 
	Locate all calendars that meet the designated criteria and return the php resource, or NULL.  
	*/
	static function select($arr) {
		/* Issue the select call and return the results */
		return wassSQL::selectDB('wassCalendar',$arr);
				
	}
	

	/*
	This function returns a wasslist of calendars owned or managed or membered by the specified user.
	*/
	static function wlistAllCalendars($userid) {
		/* Get array of calendarids of calendars managed by this user. */
		$managedids = wassManager::arrayManagedids($userid);
		/* Get array of calendarids of calendars owned by this user */
		$ownedids = self::arrayOwnedCalendarids($userid);
		/* Merge the arrays */
		$allids = array_merge($managedids,$ownedids );
		
		
		/* Now build a select string */
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassCalendar WHERE (';
		$needor = false;
		foreach ($allids as $id) {
			if ($needor)
				$select .= ' OR ';
			$select .= 'calendarid=' . $id;
			$needor = true;
		}
		$select .= ')';
		
		/* Now return the list of calendars */
		return new wassList($select,'Calendar');

	}
 
	/*
	This function returns a wasslist of calendars actively managed by the specified userid.
	*/
	static function wlistManagedCalendars($userid) {
		/* Get list of calendarids of calendars managed by this user. */
		$managedids = wassManager::arrayManagedids($userid);

		/* Now build a select string */
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassCalendar WHERE (';
		$needor = false;
		foreach ($managedids as $id) {
			if ($needor)
				$select .= ' OR ';
			$select .= 'calendarid=' . $id;
			$needor = true;
		}
		$select .= ')';

		/* Now return the list of calendars */
		return new wassList($select,'Calendar');
	}
	
	/*
	This function returns a wasslist of calendars owned by the specified user.
	*/
	static function wlistOwnedCalendars($userid) {
		/* Return the list of calendars */
		return new wassList('SELECT * FROM ' . wassParms::DATABASE . '.wassCalendar WHERE (userid =' . wassSQL::sqlSafe($userid) . ')','Calendar');
	}
 
 
 
 	/*
	This function returns an array of calendarids of calendars owned by the specified user.
	*/
	static function arrayOwnedCalendarids($userid) {
		return self::arrayCalendarField('calendarid','WHERE userid=' . wassSQL::sqlSafe($userid));
	}
	
 
 	/*
	This function returns a list of titles of calendars owned by the specified user.
	*/
	static function arrayOwnedCalendartitles($userid) {
		return self::arrayCalendarField('title','WHERE userid=' . wassSQL::sqlSafe($userid));
	}	
		
	
	/* 
	This function returns a list of calendars meeting the specified selection criteria.
	*/
	static function wlistMatchingCalendars($criteria,$orderby='ORDER BY userid') {
		/* Build the list and return it in the specified order. */
		return new wassList(wassSQL::buildSelect('wassCalendar',$criteria,$orderby),'Calendar');
	}		
 
 
	/*
	This function returns an array of values drawn from all, or subset, of calendars.
	*/
	static function arrayCalendarField($field,$where='') {
		/* Do the query */
		$values =  wassSQL::doQuery('SELECT DISTINCT ' . $field . ' FROM ' . wassParms::DATABASE . '.wassCalendar ' . $where . ' ORDER BY ' . $field . ' ASC');	
		/* Build return array */
		$ret = array();
		while ($value = wassSQL::doFetch($values)) {
			$ret[] = $value[$field];
		}			
		return $ret;
	}


	/*  Obect Methods */
	
	/* We have two constructors, one for a new calendar, one for an
	   existing calendar.  In the former case, we create an entry in the
	   database calendar table, assign an id, and fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database calendar table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   calendar object.
	*/
	
	function __construct($source,$data) {
		/* $source tells us whether to 'load', 'update' or 'create' a calendar
		   $data is an associative array of elements used when we need to create/update 
		   a calendar; for 'load', it contains just the calendarid. */
		   

		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}

		
		/* For load and update, find the calendar and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassCalendar::find($ndata['calendarid']))
				throw new Exception('Calendar id ' . $ndata['calendarid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* Set defaults for unspecified values */
		if ($source == 'create') {
			if (!$ndata['makeaccess'])	
				$ndata['makeaccess'] = 'limited';
			if (!$ndata['viewaccess'])	
				$ndata['viewaccess'] = 'limited';
			if (!$ndata['name'])
				$ndata['name'] = wassDirectory::getName($ndata['userid']);
			if (!$ndata['phone'])
				$ndata['phone'] = wassDirectory::getPhone($ndata['userid']);
			if (!$ndata['email'])
				$ndata['email'] = wassDirectory::getEmail($ndata['userid']);
			if (!$ndata['location'])
				$ndata['location'] = wassDirectory::getOffice($ndata['userid']);
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
			if 	(!array_key_exists('group',$ndata))
				$ndata['group'] = 0;		
			if 	(!array_key_exists('available',$ndata))
				$ndata['available'] = 1;
			if 	(!array_key_exists('purreq',$ndata))
				$ndata['purreq'] = 0;
		}
		
		/* For update, disallow certain changes*/
		if ($source == 'update') {
			/* Anything goes */
		}
		
		
		/* For update and create, load up the values and validate the calendar. */
		if (($source == 'update') || ($source == 'create')) {
			wassUtil::loadObject($this,$ndata);
			if ($errors = $this->validate($source)) 
				throw new Exception($errors,20);
		}
	
	}


	/*
	This function writes the calendar data out to the database.  
	The one argument specifies whether this is a new calendar or not.
	NOTE: Updates to the calendar are NOT passed on to all of the blocks and
	series in the calendar (unlike changes to a series).
	*/
	
	function save($type) {
		/* Reject template title */
		if ($this->title == '*** Replace this with a Calendar title ***')
			throw new Exception('Invalid Calendar title',14);	
		
		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify a calendarid */
				if ($key != 'calendarid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= '`'.$key.'`';
					if ($vallist)
						$vallist .= ',';
					$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sql = 'INSERT INTO ' . wassParms::DATABASE . '.wassCalendar (' . $varlist . ') VALUES (' . $vallist . ')';
		}
		/* Else create the update list */
		else {
			$sql = '';
			foreach ($this as $key=>$value)  {
				if ($key != 'calendarid') {
					if ($sql)
						$sql .= ', ';
					$sql .= '`'.$key.'`' . '=' . wassSQL::sqlSafe($value);	
				}
			}
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassCalendar SET ' . $sql . ' WHERE calendarid=' . $this->calendarid;	
		}
		
		/* Now do the update (and blow up if we can't) */
		if (!wassSQL::doQuery($sql))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16);	
			
		/* Get the (new) id. */
		if ($type == 'create')
			$this->calendarid = wassSQL::insert_id();
			
		return $this->calendarid;
	}

	
	
	/* 
	List all views (slot sizes) that are valid for this calendar on this day. 
	*/
	function listViews($date) {
		/* Extract sorted list of available views */	
		$allviews = explode(' ',wassParms::ALLVIEWS);
		sort($allviews,SORT_NUMERIC);
		
		/* Initialize list of invalid views */
		$invalidviews = array();
		
		/* Select all of the blocks for this calendar on this date */
		$blocks = wassBlock::select(array('calendarid' => $this->calendarid, 'date' => $date));
		
		/* 
		For each block, see which of the array elements will divide the starting and ending times and slotsize evenly, and remove those that dont. 
		*/
		while ($block = wassSQL::doFetch($blocks)) {
			reset($allviews);
			foreach ($allviews as $view) {
				/* Convert start and end times to total minutes */
				$st = (substr($block['starttime'],0,2) * 60) + (substr($block['starttime'],3,2));
				$et = (substr($block['endtime'],0,2) * 60) + (substr($block['endtime'],3,2));
				/* Does the view divide the start and end time and slot size? */
				if ((($st%$view != 0) || ($et%$view != 0)) || (($block['slotted']) && ($block['slotsize']%$view != 0))) {
					/* No, invalid */
					$invalidviews[] = $view;
				}
				/* Is view bigger than the block? */
				if ($view > ($et-$st))
					$invalidviews[] = $view;
				/* Is the view bigger than the slotsize */
				if (($block['slotted']) && ($view > $block['slotsize'])) {
					/* Yes, invalid */
					$invalidviews[] = $view;
				}		
			}			
		}	

		/* Now generate the final list of valid views */
		$ret = '';
		reset($allviews);
		foreach ($allviews as $view) {
			if (!in_array($view,$invalidviews))
				$ret .= ' ' . (string) $view;
		}
		$ret = trim($ret);
		/* Always return at least the first (shortest) view */
		if ($ret == '') 
			$ret = (string) $allviews[0];		
	
		return $ret;	
		
 	}

	/* 
	List best for this calendar on this day. 
	*/
	function bestView($date) {
		
		/* Select all of the blocks for this calendar on this date */
		$blocks = wassBlock::select(array('calendarid' => $this->calendarid, 'date' => $date, 'slotted' => 1));
		
		/* If there are any slotted  blocks, return largest valid view value */
		if (wassSQL::num_rows($blocks)) {
			$validviews = explode(' ',$this->listViews($date));
			return $validviews[count($validviews)-1];
		}
		else
			return wassParms::DEFVIEW;	
 	}

		
	/*
	This function validates the property values of a calendar.
	*/
	function validate($source) {
	
		/* Validate passed data, pass back error string if any errors. */
		$errors = '';

		/* userid */
		if (!$this->userid)
			$errors .= 'userid required; ';

		/* title */
		$titles = self::arrayOwnedCalendartitles($this->userid);
		if ($source == 'create') {
		  if (!$this->title) {
		  	  $name = wassDirectory::getName($this->userid);
			  if (!$name) $name = $this->userid;
			  $tcount = count($titles);
			  if ($tcount > 0)
				 $this->title = 'Calendar (' . $tcount + 1 . ')  for ' . $name;
			  else   
				  $this->title = 'Calendar for ' . $name;
		  }
		  else {
		  	foreach ($titles as $title) {
			  	if (strtoupper(trim($this->title)) == strtoupper(trim($title))) {
			  		$errors .= 'title "'.$this->title.'" already in use; ';
					break;
				}
			  }
		  }
			
		}
		else {
			if (!$this->title)
				$errors .= 'title cannot be blank';
			else {
				$allcals = self::wListOwnedCalendars($this->userid);
				foreach ($allcals as $cal) {
					if ($cal->calendarid != $this->calendarid) {
						if (strtoupper(trim($this->title)) == strtoupper(trim($cal->title))) {
			  				$errors .= 'title "'.$this->title.'" already in use; ';
							break;
						}
					}
				}
			}	
		}
	
		/* notify, notifyman, available */

		if (!wassUtil::checkBool($this->notify))
			$errors .= 'notify must be a boolean; ';
		if (!wassUtil::checkBool($this->notifyman))
			$errors .= 'notifyman must be a boolean; ';
		if (!wassUtil::checkBool($this->available))
			$errors .= 'available must be a boolean; ';
			
		/* remind, remindman, showappinfo, group, purreq */
		if (!wassUtil::checkBool($this->remind))
			$errors .= 'remind must be a boolean;';
		if (!wassUtil::checkBool($this->remindman))
			$errors .= 'remindman must be a boolean;';
		if (!wassUtil::checkBool($this->showappinfo))
			$errors .= 'showappinfo must be a boolean;';
		if (!wassUtil::checkBool($this->group))
			$errors .= 'group must be a boolean;';
		if (!wassUtil::checkBool($this->purreq))
			$errors .= 'purreq must be a boolean;';
			
		/* makeaccess, viewaccess */
		if (($this->makeaccess != 'open') && ($this->makeaccess != 'limited') && ($this->makeaccess != 'restricted') && ($this->makeaccess != 'private'))
			$errors .= 'Invalid makeaccess value: ' . $this->makeaccess . '; ';		
		
		if (($this->viewaccess != 'open') && ($this->viewaccess != 'limited') && ($this->viewaccess != 'restricted') && ($this->viewaccess != 'private'))
			$errors .= 'Invalid viewaccess value: ' . $this->viewaccess . '; ';		
		
		
		return $errors;
	
	}

	/*
	This function deletes the SQL entry for the current calendar, and also
	deletes all series and blocks associated with the calendar (this will cancel
	all appointments). 
	*/
	function delete($canceltext) {
		/* First, build a list of all of the series. */
		$series = new wassList(wassSQL::buildSelect('wassSeries',array('calendarid'=>$this->calendarid)),'Series');
		
		/* Now delete each series (this will cancel the appointments) */
		foreach ($series as $serie) 
			if (is_object($serie)) $serie->delete($canceltext);
			
		/* Next, build a list of all of the blocks. */
		$blocks = new wassList(wassSQL::buildSelect('wassBlock',array('calendarid'=>$this->calendarid)),'Block');
		
		/* Now delete each block (this will cancel the appointments) */
		foreach ($blocks as $block) 
			if (is_object($block)) $block->delete($canceltext);
			
		/* Delete all wassManager entries for this calendar */	
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassManager WHERE (calendarid=' . wassSQL::sqlSafe($this->calendarid) . ')');		
								
		/* Delete this calendar */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassCalendar WHERE calendarid=' . $this->calendarid . ' LIMIT 1');		

		/* Delete all record of "deleted" entries 
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassDeleted WHERE calendarid=' . $this->calendarid . ';');
		*/
	}
	
	/*
	This function determines if a specified user can view the calendar.
	*/
	function isViewable($usertype, $userid) {
	
		/* First, if userid is owner or manager, then viewable */
		if ($usertype != 'guest') {
			if ($this->isOwnerOrManager($usertype,$userid))
				return true;
		}
		
		/* If not available, then not viewable */
		if (!$this->available)
			return false;
			
		/* If user is on the persona non-grata list for this calendar, then do not allow them access at all */
		if (wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassNonGrata WHERE ((calendarid=' . $this->calendarid . ' OR calendarid=0) AND authid=' . wassSQL::sqlSafe($userid) . ');')))
			return false;
		
		/* Select on view access type */
		switch($this->viewaccess) {
		
			/* For open calendar, anyone can view it */
			case 'open':
				return true;
		
			/* For private calendar, must be owner or manager (we already tested for that) */
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
				elseif (in_array($userid,explode(',',$this->viewulist)))
					return true;
				else
					return wassUtil::IsUserInCourse(explode(',',$this->viewclist),$userid);	
				break;
						
		}
	
	}

	/*
	This function determines if a specified userid owns or manages this calendar.
	*/
	function isOwnerOrManager($usertype, $userid) {
		/* If a guest, return false */
		if ($usertype == 'guest')
			return false;
		/* if not owner or manager, return false */
		if (strtoupper(trim($this->userid)) != strtoupper(trim($userid))) {
			if (!($this->isManager($userid)))
				return false;
		}
		return true;
	}


	/*
	This function determines if a specified userid owns this calendar.
	*/
	function isOwner($usertype, $userid) {
		/* If a guest, return false */
		if ($usertype == 'guest')
			return false;
		/* if not owner return false */
		if (strtoupper(trim($this->userid)) == strtoupper(trim($userid))) 
			return true;
		else
			return false;
	}
	
	/*
	This function determines if a specified user can delete this calendar.
	*/
	function canDelete($usertype, $userid) {
		if ($this->group)
			return $this->isOwner($usertype, $userid);
		else
			return $this->isOwnerOrManager($usertype, $userid);
			
	}

	/*
	This function determines if a specified userid manages this calendar.
	*/
	function isManager($userid) {
		return wassManager::isManager($this->calendarid,$userid);
	}
	
	/*
	This function adds a manager to the manager list for this calendar. 
	*/
	function addManager($managerid,$source,$notify,$remind,$password='') {
		return wassManager::addManager($this->calendarid,$managerid,$source,$notify,$remind,$password);	
	}
	
	
	/*
	This function removes a manager from the manager list for this calendar.
	*/
	function removeManager($managerid,$source) {
		return wassManager::removeManager($this->calendarid,$managerid,$source);	
	}
	
	
	/*
	This function updates a manager from the manager list for this calendar.
	*/
	function updateManager($managerid,$source,$notify,$remind) {
		return wassManager::updateManager($this->calendarid,$managerid,$source,$notify,$remind);	
	}
	
			
	/*
	This function returns a list of all active managers of this calendar.
	*/
	function listActiveManagers() {
		return wassManager::listActiveManagers($this->calendarid);	
	}
	
	/* 
	This function returns calendar header information in xml format.
	*/
	function getHeaderInfo() {
		return  '<calendarid>' . $this->calendarid . '</calendarid>' .
				'<title>' . wassUtil::safeXml($this->title) . '</title>' .
				'<description>' . wassUtil::safeXml($this->description) . '</description>' .
				'<owner>' .
					'<userid>' . wassUtil::safeXml($this->userid) . '</userid>' .
					'<name>' . wassUtil::safeXml($this->name) . '</name>' .
					'<phone>' . wassUtil::safeXml($this->phone) . '</phone>' .
					'<email>' . wassUtil::safeXml($this->email) . '</email>' .
					'<office>' . wassUtil::safeXml($this->office) . '</office>' .
				'</owner>';	
	}


		
}

?>
