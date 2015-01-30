<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class describes a "did you know" entry.
 
*/

class wassDidYouKnow {

	/* Properties */
	public $didyouknowid;	/* Database id of the entry */
	public $header;         /* Header text  */
	public $details;  		/* Text */
	public $dateadded;      /* Date entry was added */
	public $release;        /* Associated release */
	public $topics;      	/* Comma-seperated list of topics */
	 
	
	
	
	/* Static (class) methods */
	
	/* Look up an entry in the database and return its values as an associative array */
	static function find($didyouknowid) {
			
		/* Find the entry and return it (or false if none) */
		return wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow WHERE didyouknowid=' . wassSQL::sqlSafe($id)));
			
	}
	
	/* This function returns a wassList of all entries that match the specified criteria */
	static function getEntries($dateadded,$release,$topics) {
	 
		/* Our goal is to build a select list that will return the requested entries */
		
		/* Initialize the select string */
		
		$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow WHERE 1=1 ';
		
		/* If date specified, limit to entries >= specified date */
		if ($dateadded) $select .= ' and `date` >= ' . wassSQL::sqlSafe(wassSQL::sqlDate($date));
		
		/* Read in the entries and remember the matching ids */
		$matches = '';
		$entries = wassSQL::doQuery($select);
		while ($entry = wassSQL::doFetch($entries)) {
			$match = true;
			if ($release) {
				if (wassRelease::Compare($release,$entry['release']) == 'GT')
					$match = false;
			}
			else {
				if (wassRelease::CompareToCurrent($entry['release']) == 'GT')
					$match = false;				
			}
			if ($match && $topics) {
				$target_topics = explode(',',$topics);
				$entry_topics  = explode(',',$entry['topics']);
				$match = false;
				foreach ($target_topics as $topic)
					if (in_array($topic, $entry_topics)) {
						$match = true;
						break;
					}
			}
			
			if ($match) $matches[] = $entry['didyouknowid'];
			
		}
		
		/* Now add matching ids to the select statement */
		if ($matches) {
			$select .= ' and (2=3  ';
			foreach ($matches as $match) {
			 	$select .= ' or didyouknowid = ' . $match;
			}
			$select .= ')';	
		}
		
		/* Return in random order */
		$select .= ' ORDER BY RAND()';
		
		/* Now return the wassList */
		return new wassList($select,'DidYouKnow');
	
		
	}
	
	/*  Object Methods */
	
	
	/* Build a didyouknow entry */
	function __construct($data) { 
	
		/* Load the database data into the object. */
		wassUtil::loadObject($this,$data);
	
	
	}

	
	
}
?>