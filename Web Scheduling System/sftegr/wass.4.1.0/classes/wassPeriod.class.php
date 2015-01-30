<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class describes a recurring period of time on a calendar.
 
*/

class wassPeriod {

 	/* Properties */
	public $periodid;		/* Database id of the wassPeriod record */
	public $seriesid;      	/* Database id of the wassSeries record */
	public $starttime;      /* Starting time of period */
	public $endtime;		/* Ending time of period */
	public $dayofweek;	    /* Day of week of period (for weekly periods) */
	public $dayofmonth;     /* Day of month of period (for monthly periods) */
	public $weekofmonth;  	/* Week of month of period (for monthly periods) */


	/* Static (class) methods */
	
		
	/* 
	Look up a period in the database and return its values as an associative array.
	*/
	static function find($id) {
		/* Get a database handle. */
		if (!wassSQL::openDB())
			return false;
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassPeriod WHERE periodid=' . wassSQL::sqlSafe($id)))
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);

		/* Return the result */
		return $result;
	
	}
		
	
	/* Locate all periods that meet the designated criteria, and return the php resource, or NULL.  */
	static function select($arr) {
		/* Issue the select call and return the results */
		return wassSQL::selectDB('wassPeriod',$arr);
				
	}

	
	
	/* Return a list of periods that meet the specified criteria */
	static function listMatchingPeriods($criteria) {
		return new wassList(wassSQL::buildSelect('wassPeriod',$criteria),'Period');
	}
		
	/*  Obect Methods */
	
	/* We have two constructors, one for a new period, one for an
	   existing period.  In the former case, we create an entry in the
	   database period table, assign an id, and fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database period table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   period object.
	*/
	
	function __construct($source,$data,$fromdate='') {
		
		/* $source tells us whether to 'load', 'update' or 'create a period.
		   $data is an associative array of elements used when we need to create/update 
		   a period; for 'load', it contains just the periodid. */
		   
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
		
		
		/* For load and update, find the period and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassPeriod::find($ndata['periodid']))
				throw new Exception('Period id ' . $ndata['periodid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* Set defaults for unspecified values */
		if ($source == 'create') {
			/* No defaults ... everything must be specified */
		}
		
		/* For update, disallow certain changes */
		if ($source == 'update') {
			$errmsg = $this->updateCheck($ndata,$fromdate);
			if ($errmsg)
				throw new Exception($errmsg,20);
		}
		
		
		/* For update and create, load up the values and validate the period. */
		if (($source == 'update') || ($source == 'create')) {
			wassUtil::loadObject($this,$ndata);
			if ($errors = $this->validate()) throw new Exception($errors,20);
		}

	}		
	
	/*
	This function writes the period data out to the database.  
	The argument specifies whether this is a new period or not, and, if not, whether the update applies to all blocks or only blocks from a given date.
	*/
	function save($type,$fromdate='') {

		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify a periodid */
				if ($key != 'periodid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= $key;
					if ($vallist)
						$vallist .= ',';
					$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sql = 'INSERT INTO ' . wassParms::DATABASE . '.wassPeriod (' . $varlist . ') VALUES (' . $vallist . ')';
		}
		/* Else create the update list */
		else {
			$sql = ''; $sqlb = ''; $blockvars = get_class_vars(wassBlock);
			foreach ($this as $key=>$value)  {
				if ($sql)
					$sql .= ', ';
				$sql .= $key . '=' . wassSQL::sqlSafe($value);	
				/* Block list must only contain block field values */
				if (array_key_exists($key,$blockvars)) {
					if ($sqlb)
						$sqlb .= ', ';
					$sqlb .= $key . '=' . wassSQL::sqlSafe($value);	
				}
			}
			$sqlblock =  'UPDATE ' . wassParms::DATABASE . '.wassBlock SET ' . $sqlb . ' WHERE periodid=' . $this->periodid;
			if ($fromdate)
				$sqlblock .= ' AND date >=' . wassSQL::sqlSafe($fromdate);
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassPeriod SET ' . $sql . ' WHERE periodid=' . $this->periodid;	
		}
		
		/* Now do the update (and blow up if we can't) */
		if (!wassSQL::doQuery($sql))
 				throw new Exception('Error in SQL ' . $sql . ':' .wassSQL::error(),16);
				
		/* Get the (new) id and return it */
		if ($type == 'create')
			$this->periodid = wassSQL::insert_id();
			
		/* Now update all of the blocks */
		if ($type == 'update')
			if (!wassSQL::doQuery($sqlblock))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16);	
	
		return $this->periodid;
	}


	/*
	This function validates data passed to create or update a period.
	*/				
	function validate($series) {
	
		/* Validate passed data, pass back error string if any errors. */
		$errors = '';
		
		/* Read in the series object, if none passed */
		if (!$series) {
			try {
				$series = new wassSeries('load',array('seriesid'=>$this->seriesid));
			} catch (Exception $error ) {
				$errors .= 'Invalid seriesid: ' . $error->getMessage() . ';';
			}
		}

		/* starttime and endtime */		
		if (!wassUtil::checkTime($this->starttime)) 
			$errors .= 'Invalid start time: ' . $this->starttime;
		if (!wassUtil::checkTime($this->endtime))
			$errors .= 'Invalid end time: ' . $this->endtime;
		if (($elapsed = wassUtil::elapsedTime($this->starttime,$this->endtime) <= 0))
 			$errors .= 'End time must be >= start time;';
			
			
		/* Terminate if we couldn't find the series. */
		if (!$series)
			return $errors;


		/* dayofweek */
		if (($series->every == 'weekly') || ($series->every == 'otherweekly') || ($series->every == 'monthlyweek')) {
			if (!$this->dayofweek)
				$errors .= 'dayofweek must be specified for ' . $series->every . ';';
			else {
				$dayofweek = strtoupper($this->dayofweek);
				if ($dayofweek != 'SUNDAY' && 
				    $dayofweek != 'MONDAY' && 
				    $dayofweek != 'TUESDAY' && 
					$dayofweek != 'WEDNESDAY' && 
					$dayofweek != 'THURSDAY' && 
					$dayofweek != 'FRIDAY' && 
					$dayofweek != 'SATURDAY')
						$errors .= 'Invalid dayofweek value: ' . $this->dayofweek . ';';
			}
		}
	
		/* dayofmonth */		
		if ($series->every == 'monthlyday') {
			if (!$this->dayofmonth)
				$errors .= 'dayofmonth must be specified for ' . $series->every . ';';
			else {
				if (!is_numeric($this->dayofmonth))
					$errors .= 'dayofmonth must be a number;';
				elseif ($this->dayofmonth > 31)
					$errors .= 'dayofmonth must be <= 31;';
			}
		}
		
		
		/* weekofmonth */
		if ($series->every == 'monthlyweek') {
			if (!$this->weekofmonth)
				$errors .= 'weekofmonth must be specified for ' . $series->every . ';';
			else {
				if (!is_numeric($this->weekofmonth))
					$errors .= 'weekofmonth must be a number;';
				elseif ($this->weekofmonth > 4)
					$errors .= 'weekofmonth must be <= 4;';
			}
		}
		return $errors;	
	} 
	
	

	/*
	This function chercks to see if proposed changes to the period violate any business rules.
	 */
	function updateCheck($ndata,$fromdate='') {
		if (array_key_exists('seriesid',$ndata) && ($ndata['seriesid'] != $this->seriesid)) 
			return 'Cannot assign period to a new series';				
		if (array_key_exists('dayofweek',$ndata) && ($ndata['dayofweek'] != $this->dayofweek)) 
			return 'Cannot change weekday of a recurring block';
		if (array_key_exists('dayofmonth',$ndata) && ($ndata['dayofmonth'] != $this->dayofmonth)) 
			return 'Cannot change month day of a recurring block';
		if (array_key_exists('weekofmonth',$ndata) && ($ndata['weekofmonth'] != $this->weekofmonth)) 
			return 'Cannot change week of a recurring block';
			
		/* 
		Make sure proposed changes do not disrupt any blocks.
		*/
		
		/* Init error tracker */
		$errmsg = '';
		/* Build list of blocks */
		if ($fromdate)
			$blist = array('periodid,=,AND'=>$this->periodid, 'date,>=,AND'=>$fromdate);
		else
			$blist = array('periodid'=>$this->periodid);
		$blocks = new wassList(wassSQL::buildSelect('wassBlock',$blist),'Block');
		/* Test applying the updates to the blocks, and catch any errors */
		foreach ($blocks as $block) {
			if ($errmsg = $block->updateCheck($ndata))
				break;		
				
		}
		return $errmsg;
	}
		

	
	
	/*
	This function determines if specified user owns the period's calendar.
	*/
	function isOwner($usertype, $authid) {
	
		/* Load the series. */
		try {
			if (!$series = new wassSeries('load', array('seriesid'=>$this->seriesid)))
				return false;;
		} catch (Exception $error) {
			return false;
		}
	
		return $series->isOwner($usertype, $authid);
	
	}

}
?>