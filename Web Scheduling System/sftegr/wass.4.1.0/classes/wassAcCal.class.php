<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class describes the academic calendar. 
 
*/

class wassAcCal {

 	/* Properties */
	public $accalid;		/* MySQL id of record. */
	public $date;			/* The date. */
	public $daytypes;      	/* The type of day for this date. */
 
	/* Static (class) methods */
	
		
	/* Look up a date and return it's daytype. */
	static function daytype($date) {
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAcCal WHERE date=' . wassSQL::sqlSafe($date)))
			return wassParms::DEFAULTDAYTYPES;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);
		/* Free up the query */
		wassSQL::freeQuery($entry);	
		/* Return the result */   
		if (in_array($result['daytypes'],explode(',',wassParms::DAYTYPES)))
			return $result['daytypes'];
		else
			return wassParms::DEFAULTDAYTYPES;
	
	}
		

}
?>