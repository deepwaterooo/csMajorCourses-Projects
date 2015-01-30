<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class describes a schedulable asset, such as a room or piece of equipment.
 
*/

class wassAsset {

	/* Properties */
	public $assetid;		/* Database id of the Asset */
	public $calendarid;     /* Database id of the wassCalendar record */
	public $name;  			/* Name of the asset */
	public $description;    /* Description of the asset */
	public $location;       /* (Usual) location of the asset */
	public $phone;      	/* Contact telephone number */
	public $email;			/* Contact email */
	
	
	
	/* Static (class) methods */
	
	/* Look up an asset in the database and return its values as an associative array */
	static function find($assetid) {
			
		/* Find the entry */
		if (!$entry = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAsset WHERE assetid=' . wassSQL::sqlSafe($assetid)))
			return false;
	
		/* Get the entry into an associative array (there can only be 1). */
		$result = wassSQL::doFetch($entry);

		/* Return the result */
		return $result;
	
	}
	
	/* This function returns an array of userids of people who manage a given asset, or NULL if none. */
	static function arrayAssetManagerids($assetid) {
		
		/* Init return in case no managers */
		$managers = '';
		/* Get all of the manager ids for this asset */
		$allmanagers = wassSQ::doQuery('SELECT managerid FROM ' . wassParms::DATABASE . '.wassAssMan WHERE assetid=' . wassSQL::sqlSafe($assetid));
		/* Loop through the entries and build the result array */
		while ($manager = wassSQL::doFetch($allmanagers)) 
			$managers[] = $manager['managerid'];
		/* All done */
		return $managers;
				
	}
	
	/* This function returns an array of assetids of assets managed by a given manager, or NULL if none. */
	static function arrayManagerAssetids($managerid) {
		
		/* Init return in case no managers */
		$assets = '';
		/* Get all of the manager ids for this asset */
		$allassets = wassSQ::doQuery('SELECT assetid FROM ' . wassParms::DATABASE . '.wassAssMan WHERE managerid=' . wassSQL::sqlSafe($managerid));
		/* Loop through the entries and build the result array */
		while ($asset = wassSQL::doFetch($allassets)) 
			$assets[] = $asset['assetid'];
		/* All done */
		return $assets;
				
	}
	
	
	/* This function returns an array of assetids of assets for a given calendar, or NULL if none. */
	static function arrayCalendarAssetids($calendarid) {
		
		/* Init return in case no calendars */
		$calendars = '';
		/* Get all of the manager ids for this asset */
		$allcalendars = wassSQ::doQuery('SELECT assetid FROM ' . wassParms::DATABASE . '.wassAsset WHERE calendarid=' . wassSQL::sqlSafe($calendarid));
		/* Loop through the entries and build the result array */
		while ($asset = wassSQL::doFetch($allcalendars)) 
			$calendars[] = $asset['assetid'];
		/* All done */
		return $calendars;
				
	}
	
	
	
	
	/*  Object Methods */
	

	/* We have two constructors, one for a new asset, one for an
	   existing asset.  In the former case, we create an entry in the
	   database asset table, assign an id, and fill in the values as
	   specified in the construction call.  In the latter case, we look up the
	   values in the database asset table, and fill in the values as
	   per that table entry.  In either case, we end up with a filed-in
	   asset object.
	*/
	
	function __construct($source,$data) {
		/* $source tells us whether to 'load', 'update' or 'create' an asset.
		   $data is an associative array of elements used when we need to create/update 
		   an asset; for 'load', it contains just the assetid. */
		   
		/* Start by trimming all of the passed values */
		foreach ($data as $key=>$value) {
			$ndata[$key] = trim($value);
		}
		
		/* For load and update, find the asset and load up the values from
		   the database. */		
		if (($source == 'load') || ($source == 'update')) {
			/* If the object doesn't exist, blow up. */
			if (!$values = wassAsset::find($ndata['assetid']))
				throw new Exception('Asset id ' . $ndata['assetid'] . ' does not exist',14);
			/* Load the database data into the object. */
			wassUtil::loadObject($this,$values);
		}

		/* Set defaults for unspecified values */
		if ($source == 'create') {
			/* Look up the owning calendar to fill in defaults */
			$cal = wassCalendar::find($ndata['calendarid']);
			if (!$ndata['phone'])
				$ndata['phone'] = $cal['phone'];
			if (!$ndata['email'])
				$ndata['email'] = $cal['email'];
			if (!$ndata['location'])
				$ndata['location'] = $cal['location'];
	
		}
		
		/* For update, disallow resetting of calendarid */
		if ($source == 'update') {
			if (($ndata['calendarid']) && ($ndata['calendarid'] != $this->calendarid)) 
				throw new Exception('Cannot assign asset to a new calendar',15);
		}
		
		
		/* For update and create, load up the values and validate the asset. */
		if (($source == 'update') || ($source == 'create')) {
			wassUtil::loadObject($this,$ndata);
			if ($errors = $this->validate()) 
				throw new Exception($errors,15);
		}

			
	}		


	
	/*
	This function writes the asset data out to the database.
	The argument specifies whether this is a new asset or not.  
	*/
	
	function save($type) {

		/* If creating an entry, build the variable and value lists */
		if ($type == 'create') {
	 		$varlist = ''; $vallist = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify an assetid */
				if ($key != 'assetid') {
					if ($varlist)
						$varlist .= ',';
					$varlist .= '`'.$key.'`';
					if ($vallist)
						$vallist .= ',';
					$vallist .= wassSQL::sqlSafe($value);
				}	
			}
			$sql = 'INSERT INTO ' . wassParms::DATABASE . '.wassAsset (' . $varlist . ') VALUES (' . $vallist . ')';
		}
		/* Else create the update list */
		else {
			$sql = '';
			foreach ($this as $key=>$value)  {
				/* Don't specify an assetid */
				if ($key != 'assetid') {
				  if ($sql)
					  $sql .= ', ';
				  $sql .= '`'.$key.'`' . '=' . wassSQL::sqlSafe($value);
				}
			}	
			$sql = 'UPDATE ' . wassParms::DATABASE . '.wassAsset SET ' . $sql . ' WHERE assetid=' . $this->assetid;	
		}
		
		/* Now do the update (and blow up if we can't) */
		if (!wassSQL::doQuery($sql))
 				throw new Exception('Error in SQL ' . $sql . ':' . wassSQL::error(),16);
				
		/* If saving a new asset, save the id. */
		If ($type != 'update')
			/* Save the asset id. */
			$this->assetid = wassSQL::insert_id(); 
		
			
		return $this->assetid;
		
	}
				
	function validate() {
	
		/* Validate asset data, pass back error string if any errors. */
		$errors = '';

		/* Read in the calendar */
		if (!($calendar = wassCalendar::find($this->calendarid)))
				$errors .= 'Invalid calendarid: ' . $this->calendarid . '; ';


		/* A name must be specified */
		if (!$this->name)
			$errors .= 'An asset name must be specified; ' ;
		else {
			/* Asset name must be unique for this calendar */
			$already = new wassList(wassSQL::buildSelect('wassAsset',array('calendarid'=>$this->calendarid,'name'=>$this->name)),'wassAsset');
			if ($already && is_object($already))
				if ($already->entries())
					$errors .= 'Name "' . $this-name . '" is already in use for another asset in this calendar; ';
			
		}
			
		

		return $errors;
	
	}


	/* Delete an asset */
	function delete() {

		/* Delete the asset record. */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassAsset WHERE assetid=' . $this->assetid . ' LIMIT 1');	
			
		/* Delete all link table entries.  */
		wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassAssMan WHERE assetid=' . $this->assetid);	
		
		
	}
	
	
	/* This function returns an array of userids (as an array) of people who manage this asset, or NULL if none. */
	static function arrayMyManagers() {		
		return self::arrayManagers($this->assetid);				
	}
			
	
}
?>