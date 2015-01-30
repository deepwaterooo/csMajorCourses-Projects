<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class associates managers with the calendars they manage.
 
*/

class wassManager {

	/* Properties */
	public $userid;         /* Userid of person whose calendar is being managed */
	public $calendarid;		/* Calendarid of calendar being managed. */
	public $managerid;		/* Userid of manager. */
	public $source;      	/* Source of entry ('user' or 'admin' or 'pending'). */
	public $notify;         /* Manager wants notifications */
	public $remind;         /* Manager wants reminders */
 
	/* Static (class) methods */
	
	/*
	This function determines if the specified user manages the specified calendar.
	*/
	static function isManager($calendarid,$managerid,$source='') {
		/* Set up WHERE clause as per arguments */
		
		$where = '(calendarid=' . wassSQL::sqlSafe($calendarid) . ' AND managerid=' . wassSQL::sqlSafe($managerid);
		if ($source)
			$where .= ' AND source=' . wassSQL::sqlSafe($source);
		$where .= ')';
		
		$result = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE ' . $where));
		
		if ($result)
			return true;
		else
			return false;
				
	}
	
	
	/*
	This function adds or updates an entry in the wassManager table.
	*/
	static function addManager($calendarid,$managerid,$source,$notify,$remind,$password='') {
		/* Remove any leading/trailing blanks */
		$manager=trim($managerid);
		
		/* Sanity check */
		if (($calendarid == "") || ($manager == ""))
			return 'Invalid values passed to addManager';
		
		/* Do not allow an owner to manage their own calendar */
		$cal = wassCalendar::find($calendarid);
		if ($manager == $cal['userid'])
			return 'A user cannot manage one of their own calendars';
		
		/* See if there is an entry already  */
		$managers = self::arrayAllManagers($calendarid);
		/* If in the array already */
		if (in_array($manager,$managers)) {
			/* Update the status (source) */
			wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassManager SET source=' . wassSQL::sqlSafe($source) . ', notify=' . wassSQL::sqlSafe($notify) . ', remind=' .  wassSQL::sqlSafe($remind) .  ' WHERE managerid=' . wassSQL::sqlSafe($manager) . ' AND calendarid=' . wassSQL::sqlSafe($calendarid));
		}
		else {
			/* No, add the entry */
			wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassManager (userid,calendarid,managerid,source,notify,remind,password) VALUES (' . wassSQL::sqlSafe($cal['userid']) . ', ' . wassSQL::sqlSafe($calendarid) . ', ' . wassSQL::sqlSafe($manager) . ', ' . wassSQL::sqlSafe($source) . ', ' . wassSQL::sqlSafe($notify) . ', ' . wassSQL::sqlSafe($remind) . ',' . wassSQL::sqlSafe($password) . ')');
		}
		return '';
	}
	 
	/*
	This function removes managers from the wassManager table as per the arguments.
	*/
	static function removeManager($calendarid,$managerid,$source) {
		/* Set up WHERE clause as per arguments */
		$where = '';
		$needand = false;
		
		if ($calendarid) {
			$where .= ' calendarid=' . wassSQL::sqlSafe($calendarid);
			$needand = true;
		}
		if ($managerid) {
			if ($needand) $where .= ' AND ';
			$where .= ' managerid=' . wassSQL::sqlSafe(trim($managerid));
			$needand = true;
		}		
		if ($source) {
			if ($needand) $where .= ' AND ';
			$where .= ' source=' . wassSQL::sqlSafe($source);
		}
		
		wassSQL::doQuery(
		'DELETE FROM ' . wassParms::DATABASE . '.wassManager WHERE ' . $where 
		);
		
		return '';
	}
	
	/*
	This function updates managers from the wassManager table as per the arguments.
	*/
	static function updateManager($calendarid,$managerid,$source,$notify,$remind) {
		$updated = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassManager SET source=' . wassSQL::sqlSafe($source) . ', notify=' . wassSQL::sqlSafe($notify) . ', remind=' .  wassSQL::sqlSafe($remind) .  ' WHERE managerid=' . wassSQL::sqlSafe($managerid) . ' AND calendarid=' . wassSQL::sqlSafe($calendarid));
		if ($err = wassSQL::error())
			return $err;
		else
			return 0;
	}
	
	
	/*
	This function removes all non-pending managers.
	*/
	static function removeActiveManagers($calendarid) {
		wassSQL::doQuery(
		'DELETE FROM ' . wassParms::DATABASE . '.wassManager WHERE calendarid=' . wassSQL::sqlSafe($calendarid) . ' AND source != "pending"'
		);
	}

	/*
	This function removes all managers.
	*/
	static function removeAllManagers($calendarid) {
		wassSQL::doQuery(
		'DELETE FROM ' . wassParms::DATABASE . '.wassManager WHERE calendarid=' . wassSQL::sqlSafe($calendarid) 
		);
	}
	
	/*
	This function removes a pending manager.
	*/
	static function removePendingManager($calendarid,$managerid) {
		wassSQL::doQuery(
		'DELETE FROM ' . wassParms::DATABASE . '.wassManager WHERE managerid=' . wassSQL::sqlSafe($managerid) . ' AND calendarid=' . wassSQL::sqlSafe($calendarid) . ' AND source = "pending"'
		);
	}
	
	/*
	This function returns an array of all users who manage a given calendar.
	*/
	static function arrayActiveManagers($calendarid) {
		/* Init result array */
		$managers = array();
		/* Get managers from the database */
		$allmanagers = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source!="pending" AND calendarid=' . wassSQL::sqlSafe($calendarid));
		/* Now append the managers to the array */
		while ($manager = wassSQL::doFetch($allmanagers)) {
			if ( $manager['managerid'] != '' )
				$managers[] = $manager['managerid'];
		}
	
		return $managers;	
	}
	
	
	/*
	This function returns a list of all users who manage a given user's calendar.
	*/
	static function listActiveManagers($calendarid) {
		return implode(',',self::arrayActiveManagers($calendarid));
	}
	
	
	/* 
	This function returns a wassList of all active managers.
	*/
	static function wlistActiveManagers($calendarid) {
		return new wassList('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source!="pending" AND calendarid=' . wassSQL::sqlSafe($calendarid),'Manager');
	}
	

	/*
	This function returns an array of all pending managers for a calendar.
	*/
	static function arrayPendingManagers($calendarid) {
		/* Init result array */
		$managers = array();
		/* Get managers from the database */
		$allmanagers = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source="pending" AND calendarid=' . wassSQL::sqlSafe($calendarid));
		/* Now append the managers to the array */
		while ($manager = wassSQL::doFetch($allmanagers)) {
			$managers[] = $manager['managerid'];
		}
	
		return $managers;	
	}

	/*
	This function returns a list of all users who are pending to manage a given user's calendar.
	*/
	static function listPendingManagers($calendarid) {
		return implode(',',self::arrayPendingManagers($calendarid));
	}
	
	
	/* 
	This function returns a wassList of all pending managers.
	*/
	static function wlistPendingManagers($calendarid) {
		return new wassList('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source="pending" AND calendarid=' . wassSQL::sqlSafe($calendarid),'Manager');
	}
	


	/* 
	This function returns a list of all managers for a calendar, regardless of status.
	*/
	static function arrayAllManagers($calendarid) {
		/* Init result array */
		$managers = array();
		/* Get managers from the database */
		$allmanagers = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE calendarid=' . wassSQL::sqlSafe($calendarid));
		/* Now append the managers to the array */
		while ($manager = wassSQL::doFetch($allmanagers)) {
			$managers[] = $manager['managerid'];
		}
	
		return $managers;	
	}	

	/*
	This function returns an array of calendarids of all calendars managed by a given user.
	*/
	static function arrayManagedids($managerid) {
		/* Init result array */
		$calendarids = array();
		/* Get matching entries from the database */
		$allcalendars = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source!="pending" AND managerid=' . wassSQL::sqlSafe($managerid));
		/* Now append the calendar ids to the array */
		while ($calendar = wassSQL::doFetch($allcalendars)) {
			if (!in_array($calendar['calendarid'],$calendarids))
				$calendarids[] = $calendar['calendarid'];
		}
		/* Return the resulting list of calendarids as an array */
		return $calendarids;	
	}

	static function listManagedids($managerid) {
		$calarray = self::arrayManagedids($managerid);
		if (count($calarray) > 0)
			return implode(",",$calarray);
		else
			return '';
	}


	/*
	This function returns a list of all calendarids of all calendars pending being managed by a given user.
	*/
	static function arrayPendingManagedids($managerid) {
		/* Init result array */
		$calendarids = array();
		/* Get matching entires from the database */
		$allcalendars = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE source="pending" AND managerid=' . wassSQL::sqlSafe($managerid));
		/* Now append the calendar ids to the array */
		while ($calendar = wassSQL::doFetch($allcalendars)) {
			if (!in_array($calendar['calendarid'],$calendarids))
				$calendarids[] = $calendar['calendarid'];
		}
		/* Return the resulting list of calendarids as an array */
		return $calendarids;	
	}
	
	
	/* Object Methods */
	
	function __construct($data) {
		/* 
		All manager data is loaded from the database.
		*/
		   
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
		
		/* Load the database data into the object. */
		wassUtil::loadObject($this,$ndata);
	
		/* Set defaults for unspecified values */

	}		


}
?>
