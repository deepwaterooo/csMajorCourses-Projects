<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This class describes a recurring appointment block (a series).  
*/

class wassSeries {
 
 
 	/* Properties */
	public $seriesid;		/* Database id of the wassSeries record */
	public $calendarid;     /* Database id of the wassCalendar record */
	public $title;			/* Title */
	public $description;	/* Description */
	public $userid;         /* Userid */
	public $name;  			/* Name of user */
	public $phone; 			/* Phone number of user */
	public $email;			/* Email of user */
	public $location;		/* Office location */
	public $startdate;		/* Starting date of series */
	public $enddate;		/* Ending date of series (null if none) */
	public $every;          /* Recurrence frequency */
	public $daytypes;       /* Academic calendar day types, comma seperated list */
	public $slotted;		/* Is block broken up into slots by default? */
	public $slotsize; 		/* If slotted, default slot size in minutes */
	public $maxapps;		/* Maximum appointments per block */
	public $maxper;         /* Maximum appointments per person */
	public $deadline;       /* Default deadline for scheduling app. in minutes */
	public $candeadline;    /* Deadline for cancelling appointments, in minutes */
	public $opening;		/* When block becomes available for scheduling, in minutes */
	public $notify;			/* Default for sending email notifications */
	public $notifyman;		/* Default for sending email notifications to manager*/
	public $available;		/* Is series viewable? */
	public $makeaccess;		/* Default appointment make restrictions */
	public $viewaccess;		/* Default block view restrictions */
	public $makeulist;		/* Default block make user list */
	public $makeclist;		/* Default block make course list */
	public $viewulist;		/* Default block view user list */
	public $viewclist;		/* Default block view course list */
	public $remind;			/* Default for sending appointment reminders */
	public $remindman;		/* Send appointment reminders to managers? */	
	public $appmsg;         /* Text to be included in notification and reminder emails */
	public $showappinfo;    /* Set to 1 if everyone sees appointment details */
	public $purreq;  	/* This series requires that appointment purposes be specified */

/* Static (class) methods */
	
		
	/* Look up a series in the database and return its values as an associative array */
	static function find($id) {
		/* Get a database handle. */
		if (!wassSQL::openDB())
			return false;
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassSeries WHERE seriesid=' . wassSQL::sqlSafe($id)))
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);
		/* Free up the query */
		wassSQL::freeQuery($entry);	
		/* Return the result */
		return $result;
	
	}

	
	/* Locate all series that meet the designated criteria, and return the php resource, or NULL.  */
	static function select($arr) {
		/* Issue the select call and return the results */
		return wassSQL::selectDB('wassSeries',$arr);
				
	}
 		
	/*  Obect Methods */
	
	/* We have two constructors, one for a new series, one for an
	   existing series.  In the former case, we create an entry in the
	   database series table, assign an id, and fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database series table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   series object.
	*/
	
	function __construct($source,$data,$fromdate='') {
		/* $source tells us whether to 'load', 'update' or 'create a series.
		   $data is an associative array of elements used when we need to create/update 
		   a series; for 'load', it contains just the seriesid. */
		
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
		
		/* For load and update, find the series and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassSeries::find($ndata['seriesid']))
				throw new Exception('Series id ' . $ndata['seriesid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* For create, set defaults for unspecified values */
		if ($source == 'create') {
			/* Defaults are inherited first from the parent calendar */
			
			/* Get all of the calendar values */
			$calendar = wassCalendar::find($ndata['calendarid']);
			/* Get a list of all of the series properties */
			$properties = get_object_vars($this);

			/* Copy certain unspecified values from the calendar */
			foreach ($calendar as $key=>$value) {
				if (array_key_exists($key,$properties))
					if (!array_key_exists($key,$ndata)) 
						if (($key != 'title') && ($key != 'description'))
							$ndata[$key] = $value;
			}	
						
			/* Set directory defaults */
			if ($ndata['name'] == '')
				$ndata['name'] = wassDirectory::getName($ndata['userid']);
			if ($ndata['phone'] == '')
				$ndata['phone'] = wassDirectory::getPhone($ndata['userid']);
			if ($ndata['email'] == '')
				$ndata['email'] = wassDirectory::getEmail($ndata['userid']);
			if ($ndata['location'] == '')
				$ndata['location'] = wassDirectory::getOffice($ndata['userid']);

			/* Now set any remaining unspecified values to the defaults or the owning
			   calendar values. */
			if ($ndata['makeaccess'] == '')	
				$ndata['makeaccess'] = 'limited';
			if ($ndata['viewaccess'] == '')		
				$ndata['viewaccess'] = 'limited';
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
			if 	($ndata['every'] == '')
				$ndata['every'] = 'weekly';
			if 	(!array_key_exists('maxapps',$ndata))
				$ndata['maxapps'] = 0;
			if 	(!array_key_exists('maxper',$ndata))
				$ndata['maxper'] = 0;
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
			if ($ndata['daytypes'] == '')
				$ndata['daytypes'] = wassParms::DEFAULTDAYTYPES;
		}
		
		/* For update, make sure we are not resetting fields that cannot be reset.  */
		if ($source == 'update') {
			$errmsg = $this->updateCheck($ndata,$fromdate);
			if ($errmsg)
				throw new Exception($errmsg,20);
	
		}
			
		/* For update and create, load up the passed values and validate the series. */
		if (($source == 'update') || ($source == 'create')) {
			wassUtil::loadObject($this,$ndata);
			if ($errors = $this->validate()) 
				throw new Exception($errors,20);
		}

	}		


	/*
	This function writes the series data out to the database.  
	The arguments specifies whether this is a new series or not, and, if not, whether the update applies to all blocks or only blocks from a given date.
	*/
	
	function save($type,$fromdate='') {

		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify a seriesid */
				if ($key != 'seriesid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= '`'.$key.'`';
					if ($vallist)
						$vallist .= ',';
					$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sqls = 'INSERT INTO ' . wassParms::DATABASE . '.wassSeries (' . $varlist . ') VALUES (' . $vallist . ')';
			$sqlb = '';

		}
		/* Else create the update list */
		else {
			$updates = '';
			$updateb = '';
			/* We need a list of the variables in a block */
			$blockvars = array_keys(get_class_vars(wassBlock));
			
			foreach ($this as $key=>$value)  {
				/* Add change to series update string */
				if ($updates) $updates .= ', ';
				$updates .= '`'.$key.'`' . '=' . wassSQL::sqlSafe($value);	
				/* If this is a block var, change it as well */
				if (in_array($key,$blockvars)) {
					if ($updateb) $updateb .= ', ';
					$updateb .= $key . '=' . wassSQL::sqlSafe($value);					
				}
			}
			$sqls = 'UPDATE ' . wassParms::DATABASE . '.wassSeries SET ' . $updates . ' WHERE seriesid=' . $this->seriesid;
			$sqlb = 'UPDATE ' . wassParms::DATABASE . '.wassBlock SET ' . $updateb . ' WHERE seriesid=' . $this->seriesid;
			if ($fromdate)
				$sqlb .= ' AND date >=' . wassSQL::sqlSafe($fromdate);
		}
		
		/* Now do the update (and blow up if we can't) */
		if ($sqls) {if (!wassSQL::doQuery($sqls))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16); }
		if ($sqlb) {if (!wassSQL::doQuery($sqlb))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16); }



		/* Save the (new) series id */	
		if ($type == 'create')
			$this->seriesid = wassSQL::insert_id();
	
		return $this->seriesid;
		
	}
	
	/*
	This function validates the property values of a series.
	*/
	function validate() {
	
		/* Validate passed data, pass back error string if any errors. */
		$errors = '';

		/* userid */
		if (!$this->userid)
			$errors .= 'userid required; ';
			
		/* Read in the calendar */
		if (!($calendar = wassCalendar::find($this->calendarid)))
				$errors .= 'Invalid calendarid: ' . $this->calendarid . ';';
		
		/* userid */
		if (!$calendar['group']) {
			if ($this->userid != $calendar['userid'])
				$errors .= 'Series userid (' . $this->userid .') must match calendar userid (' . $calendar['userid'] . ');';
		}
		else {
			if (($this->userid != $calendar['userid']) && !wassManager::isManager($calendar['calendarid'],$this->userid,''))
				$errors .= 'Series userid (' . $this->userid .') must match calendar userid (' . $calendar['userid'] . ' or a calendar member userid);';
		}


		/* startdate and enddate */		
			
		if (!wassUtil::isDateValid($this->startdate)) 
			$errors .= 'Invalid start date: ' . $this->startdate;
		if (!wassUtil::isDateValid($this->enddate)) 
			$errors .= 'Invalid end date: ' . $this->enddate;
		$compare = wassUtil::compareDates($this->enddate,$this->startdate);
		if ($compare != '<' && $compare != '=')
			$errors .= 'End date must be >= start date;';

		/* every */
		if (($this->every != 'daily') && 
			($this->every != 'dailyweekdays') &&
			($this->every != 'weekly') &&
			($this->every != 'otherweekly') &&
			($this->every != 'monthlyday') &&
			($this->every != 'monthlyweekday'))
				$errors .= 'Invalid every value: ' . $this->every . ';';		

		/* daytypes */
		$daytypes = explode(',',$this->daytypes);
		if (!$daytypes)
			$daytypes = explode(',',wassParms::DEFAULTDAYTYPES);
		$alltypes = explode(',',wassParms::DAYTYPES);
		
		if (!is_array($alltypes))
			$alltypes = array(wassParms::DAYTYPES);
		foreach ($daytypes as $day) {
			if (!wassUtil::in_array_ci($day,$alltypes))
				$errors .= 'Invalid daytype value: ' . $day . ';';
		}

		/* slotted */
		if (!wassUtil::checkBool($this->slotted)) {
			$errors .= 'Invalid slotted value: ' . $this->slotted . ';';
			$slotted = false;
		}
		else
			$slotted = $this->slotted;
				
		/* slotsize */
		if (!is_numeric($this->slotsize)) {
				$errors .= 'Invalid value for slotsize: ' . $this->slotsize . ';';
		}
		if ($slotted && !($this->slotsize))
				$errors .= 'Value must be specified for slotsize for slotted blocks;';
		
		/* maxapps */
		if (!is_numeric($this->maxapps))
			$errors .= 'maxapps must be an integer;';

		/* maxper */
		if (!is_numeric($this->maxper))
			$errors .= 'maxper must be an integer;';

		/* deadline */
		if (!is_numeric($this->deadline))
			$errors .= 'deadline must be an integer;';
		if (!is_numeric($this->candeadline))
			$errors .= 'candeadline must be an integer;';
		if (!is_numeric($this->opening))
			$errors .= 'opening must be an integer;';

		/* notify, notifyman, available */

		if (!wassUtil::checkBool($this->notify))
			$errors .= 'notify must be a boolean;';
		if (!wassUtil::checkBool($this->notifyman))
			$errors .= 'notifyman must be a boolean;';
		if (!wassUtil::checkBool($this->available))
			$errors .= 'available must be a boolean;';
			
		/* remind, remindman, showappinfo, purreq */
		if (!wassUtil::checkBool($this->remind))
			$errors .= 'remind must be a boolean;';
		if (!wassUtil::checkBool($this->remindman))
			$errors .= 'remindman must be a boolean;';
		if (!wassUtil::checkBool($this->showappinfo))
			$errors .= 'showappinfo must be a boolean;';
		if (!wassUtil::checkBool($this->purreq))
			$errors .= 'purreq must be a boolean;';
																
		/* makeaccess, viewaccess */
		if (($this->makeaccess != 'open') && ($this->makeaccess != 'limited') && ($this->makeaccess != 'restricted') && ($this->makeaccess != 'private'))
			$errors .= 'Invalid makeaccess value: ' . $this->makeaccess . ';';		
		
		if (($this->viewaccess != 'open') && ($this->viewaccess != 'limited') && ($this->viewaccess != 'restricted') && ($this->viewaccess != 'private'))
			$errors .= 'Invalid viewaccess value: ' . $this->viewaccess . ';';		

		/* makeulist, makeclist, viewulist, viewclist */


		/* remind */
		if (!wassUtil::checkBool($this->remind))
			$errors .= 'remind must be a boolean;';

	
		return $errors;
	
	}


	/*
	This function chercks to see if proposed changes to the series violate any business rules.
	 */
	function updateCheck($ndata,$fromdate='') {
		if (array_key_exists('calendarid',$ndata) && ($ndata['calendarid'] != $this->calendarid)) 
			return 'Cannot assign series to a new calendar';
		if (array_key_exists('userid',$ndata) && ($ndata['userid'] != $this->userid)) 
			return 'Cannot assign series to a new user';
		if (array_key_exists('every',$ndata) && ($ndata['every'] != $this->every)) 
			return 'Cannot change recurrence type of a series';
		if (array_key_exists('startdate',$ndata) && ($ndata['startdate'] != $this->startdate)) 
			return 'Cannot change starting date of a series';
		if (array_key_exists('enddate',$ndata) && ($ndata['enddate'] != $this->enddate)) 
			return 'Cannot change ending date of a series';			
		if (array_key_exists('daytypes',$ndata) && ($ndata['daytypes'] != $this->daytypes)) 
			return 'Cannot change day types of a series';
	
		/* 
		Make sure proposed changes do not disrupt any periods.
		*/
		
		/* Init error tracker */
		$errmsg = '';
		/* Build list of periods */
		if ($fromdate)
			$plist = array('seriesid,=,AND'=>$this->seriesid,'date,>=,AND'=>$fromdate);
		else
			$plist = array('seriesid'=>$this->seriesid);
		/* Build list of periods */
		$periods = new wassList(wassSQL::buildSelect('wassPeriod',$plist),'Period');
		/* Test applying the updates to the blocks, and catch any errors */
		foreach ($periods as $period) {
			if ($errmsg = $period->updateCheck($ndata,$fromdate))
				break;		
				
		}
		return $errmsg;
	}
			

	/*
	This function deletes the SQL entry for the current series, and also
	deletes all blocks and periods associated with the series, and cancels all appointments
	associatred with those blocks. 
	*/
	function delete ($canceltext) {

		/* First, build a list of all of the blocks */
		$blocks = new wassList(wassSQL::buildSelect('wassBlock',array('seriesid'=>$this->seriesid)),'Block');
		
		/* Now delete each block (this will cancel the appointments) */
		foreach ($blocks as $block) {
			if (is_object($block)) $block->delete($canceltext);
		}
			
		/* Now delete all of the period blocks */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassPeriod WHERE seriesid=' . $this->seriesid);		
			
		/* Delete this series */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassSeries WHERE seriesid=' . $this->seriesid . ' LIMIT 1');		

	}
	
	
	/*
	This function builds a set of blocks from a series block and a period
	block.
	*/
	function buildBlocks($period) {
	
		
		/* 
		The series block contains the start and end dates and the 
		recurrence frequency.  The period block contains the start and end times, 
		and the types of days on which the blocks occur.
		*/
		
		/* Init block counter */
		$blockcount = 0;
		
		/* 
		The first step is to build a comprehensive list of dates on which the
		blocks will occur, from startdate to enddate.
		*/ 
		
		$startunix = mktime(3,0,0,substr($this->startdate,5,2),substr($this->startdate,8,2),substr($this->startdate,0,4));  /* Make it 3am to avoid leap-second problems */
		$endunix = mktime(3,0,0,substr($this->enddate,5,2),substr($this->enddate,8,2),substr($this->enddate,0,4));  /* Make it 3am to avoid leap-second problems */		
		$startweekday = date('l',$startunix);
		$startmonthday = date('d',$startunix);
		
		/* Get list of acceptable daytypes */
		$daytypes = explode(',',$this->daytypes);
		/* if none, use defaults */
		if (!$daytypes)
			$daytypes = explode(',',wassParms::DEFAULTDAYTYPES);
	
		/* Init array of good dates */
		$usedates = array();
	
		/* Init error trackers */
		$errmsg = '';
	
		/* Loop from start date to end date */
		for ($currunix = $startunix; $currunix <= $endunix; $currunix += (60*60*24)) {
		
			/* Get date and dayofweek info. for current date */
			$currdate = date('Y-m-d',$currunix);
			$currweekday = date('l',$currunix);
			$currmonthday = date('d',$currunix);
			
			/* The first check is to see if this day is of the right daytype. */
			if (wassUtil::in_array_ci(wassAcCal::dayType($currdate),$daytypes)) {
				/* Now select on recurrence type */
				switch($this->every) {
					/* For 'daily', no more checks needed */
					case 'daily':
						$usedates[] = $currdate;
						break;
						
					/* for dayliweekdays, check not saturday/sunday */
					case 'dailyweekdays':
						if (strtoupper($currweekday) != 'SUNDAY' &&
						    strtoupper($currweekday) != 'SATURDAY')
							$usedates[] = $currdate;
						break;
					
					/* If weekly, make sure day of week same as starting day of week */		
					case 'weekly':
						if (strtoupper($currweekday) == strtoupper($period->dayofweek)) {
							$usedates[] = $currdate;
							/* Skip most of the rest of the week */
							$currunix += (60*60*24*5);
						}
						break;
							
					
					/* If every other week, day of week must match starting day of week. */
					case 'otherweekly':
						if (strtoupper($currweekday) == strtoupper($period->dayofweek)) {
							$usedates[] = $currdate;
							/* Skip two weeks */
							$currunix += (60*60*24*13);
						}
						break;
	
					/* If a specific day of the month, check the day of the month */		
					case 'monthlyday':
						if ($currmonthday == $period->dayofmonth) {
							$usedates[] = $currdate;
							/* Skip most of the rest of the month */
							$currunix += (60*60*24*26);
						}
						break;

					/* If a weekday on a specific week of the month */						
					case 'monthlyweekday':
						if (strtoupper($currweekday) == strtoupper($period->dayofweek)) {
							/* We need to compute the cardinality of this day. */
							$currmonthweek = (($currmonthday-($currmonthday%7))/7) + 1;
							if ($currmonthweek == $period->weekofmonth) {
								$usedates[] = $currdate;
								/* Skip most of the rest of the month */
								$currunix += (60*60*24*19);
							}
						}
						break;
				}
			}
		}
			
		/*
		Now that we have the dates, we iterate through the dates
		and build the blocks.
		*/
		foreach ($usedates as $date) {
			try {
				$block = new wassBlock('create',array(
						'periodid'=>$period->periodid,
						'seriesid'=>$this->seriesid,
						'calendarid'=>$this->calendarid,
						'title'=>$this->title,
						'description'=>$this->description,
						'userid'=>$this->userid,
						'name'=>$this->name,
						'phone'=>$this->phone,
						'email'=>$this->email,
						'location'=>$this->location,
						'starttime'=>$period->starttime,
						'endtime'=>$period->endtime,
						'slotted'=>$this->slotted,
						'slotsize'=>$this->slotsize,
						'maxapps'=>$this->maxapps,
						'maxper'=>$this->maxper,
						'deadline'=>$this->deadline,
						'candeadline'=>$this->candeadline,
						'opening'=>$this->opening,
						'date'=>$date,
						'notify'=>$this->notify,
						'notifyman'=>$this->notifyman,
						'available'=>$this->available,
						'makeaccess'=>$this->makeaccess,
						'viewaccess'=>$this->viewaccess,
						'makeulist'=>$this->makeulist,
						'makeclist'=>$this->makeclist,
						'viewulist'=>$this->viewulist,
						'viewclist'=>$this->viewclist,
						'remind'=>$this->remind,
						'recurrence'=>'multiple'));
			} catch (Exception $error) {
				/* Save error message. */						
				$errmsg = wassUtil::Error($error->getCode(),$error->getMessage(),'FORMAT');
			}		
			/* Now save the block */		
			if (!$errmsg) {
				try {
					$blockid = $block->save('create');
					$blockcount++;
					unset($block);
				} catch (Exception $errors) {
					/* Save error message. */						
					$errmsg = wassUtil::Error($errors->getCode(),$errors->getMessage(),'FORMAT');
				}
			}
			
			/* Quit if we encountered an error */
			if ($errmsg)
				break;
				
		}
			
		/*
		All done.
		*/
		if (!$errmsg)
			$errmsg = $blockcount;	
		return $errmsg;
						
	}
	
	
	/*
	This function determines if specified user owns the series' calendar.
	*/
	function isOwner($usertype, $authid) {
	
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