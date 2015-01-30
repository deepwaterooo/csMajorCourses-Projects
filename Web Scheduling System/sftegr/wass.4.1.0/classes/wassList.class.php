<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class implements a list (collection) of objects (results).  It generates the
objects on the fly from a SQL query result. 
 
*/

class wassList implements Iterator {


	/* Properties */
	protected $query;		/* The SQL query. */
	protected $type;        /* Type of list */
	protected $resource;    /* The PHP resource returned by the query. */
	protected $result; 	    /* The current row data (as an object). */
	protected $row;		  	/* The current row number. */
	protected $valid;       /* Whether we have any more data to give back. */
	protected $rows;        /* Total number of rows in the results (resource). */
	protected $temp;        /* Temporary variable to hold results */

	/* The object methods */


	/* Save the query. */
	public function __construct($query, $type) {
		/* Build the query as per the passed array of key/value pairs. */
		$this->query = $query;
		$this->type = $type;
		$this->resource = false;
		$this->result = false;
		$this->row = 0;
		$this->valid = false;
		$this->rows = 0;
		$this->temp = '';
	}

	/* Release the resource */
	public function __destruct() {	
		/* Release the resource (if any). */
		if ($this->resource != false)
			wassSQL::freeQuery($this->resource);
	}

	/* Start at the beginning */
	public function rewind() {
		/* Reset everything */
		$this->result = false;
		$this->row = 0;
		$this->valid = false;
		$this->rows = 0;
		$this->temp = '';
			
		/* Release result (if we already have one) */
		if ($this->resource)
			wassSQL::freeQuery($this->resource);
				
		$this->resource = false;
	
		/* Open the database */
		if (wassSQL::openDB()) {
			/* Perform the query */
			if ($this->resource = wassSQL::doQuery($this->query)) {
				if ($this->temp = wassSQL::doFetch($this->resource)) {
					try {
						switch($this->type) {
							case 'Appointment':
								$this->result = new wassAppointment('load',$this->temp); 
								break;
							case 'Block':
								$this->result = new wassBlock('load',$this->temp); 
								break;
							case 'Calendar':
								$this->result = new wassCalendar('load',$this->temp); 
								break;
							case 'Series':
								$this->result = new wassSeries('load',$this->temp); 
								break;
							case 'Period':
								$this->result = new wassPeriod('load',$this->temp); 
								break;	
							case 'Manager':
								$this->result = new wassManager($this->temp); 
								break;
							case 'Asset':
								$this->result = new wassAsset('load',$this->temp); 
								break;
							case 'DidYouKnow':
								$this->result = new wassDidYouKnow($this->temp); 
								break;		
						}
					} catch (Exception $error) {
					/* If an error, set result to false */
						$this->result = false;
					}
				}
				if ($this->result) {
					$this->valid = true;
					$this->rows = wassSQL::num_rows($this->resource);
					$this->row = 0;
				}
			}
			else {
				$this->result = false;
				$this->valid = false;
				$this->rows = 0;
				$this->row = 0;
			}
		}
		/* Return unable status */
		else {
			$this->resource = false;
			$this->valid = false;
			$this->row = 0;
			$this->rows = 0;
		}
 	}
	
	/* Move to the next item */
	public function next() {
		/* Increment row pointer */
		$this->row++;				

		/* If more, get next result */
		if ($this->valid()) {
			if ($this->temp = wassSQL::doFetch($this->resource)) {
				try {
					switch($this->type) {
						case 'Block':
							$this->result = new wassBlock('load',$this->temp); 
							break;
						case 'Calendar':
							$this->result = new wassCalendar('load',$this->temp); 
							break;
						case 'Series':
							$this->result = new wassSeries('load',$this->temp); 
							break;
						case 'Period':
							$this->result = new wassPeriod('load',$this->temp); 
							break;	
						case 'Appointment':
							$this->result = new wassAppointment('load',$this->temp); 
							break;
						case 'Manager':
							$this->result = new wassManager($this->temp); 
							break;
						case 'Asset':
							$this->result = new wassAsset('load',$this->temp); 
							break;	
						case 'DidYouKnow':
							$this->result = new wassDidYouKnow($this->temp); 
							break;		
					}				
				} catch (Exception $error) {
					/* If an error, set result to false */
					$this->result = false;
				}
			}
		}
	}	

	/* Any more data to get? */
	public function valid() {
		/* Are there any rows at all? */
		if (!$this->rows)
			return false;
		/* Are there additional items left in the the results resource */
		return (($this->row < $this->rows)? true : false);	
	}

	/* Return current row number */
	public function key() {
		return $this->row;
	}
	
	
	/* Return current row result (array) */
	public function current() {
		return $this->result;
	}
	
	/* Return total count of rows */
	public function entries() {
		$this->rewind();
		return $this->rows;
	}

	
}
?>