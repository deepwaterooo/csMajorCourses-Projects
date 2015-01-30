<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This (static) class implements the preference save/get functions.  
Preferences are used to save settings particular to a user.
 
*/


/* Make sure SQL class is included */
require_once('wassSQL.class.php');

class wassPrefs {


	/*
	This function saves a user preference.
	*/
	static function savePref($userid,$key,$value,$class='user') {
	
		/* See if preference exists */
		$curval = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE  . '.wassPrefs WHERE  (`userid`=' . wassSQL::sqlSafe($userid) . ' AND `key`=' . wassSQL::sqlSafe($key) . ' AND `class`=' . wassSQL::sqlSafe($class) . ')')); 
		
		/* Update or add, depending on whether preference already exists or not */
		if ($curval) {
			$sqlret = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE  . '.wassPrefs SET `value`=' . wassSQL::sqlSafe($value) . '  WHERE (`userid`=' . wassSQL::sqlSafe($userid) . ' AND `key`=' . wassSQL::sqlSafe($key) . ' AND `class`=' . wassSQL::sqlSafe($class) . ')');
		}
		else {
			$sqlret = wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassPrefs (`userid`,`key`,`value`,`class`) VALUES (' . wassSQL::sqlSafe($userid) . ',' . wassSQL::sqlSafe($key) . ',' . wassSQL::sqlSafe($value) . ',' . wassSQL::sqlSafe($class) .')');
			if ($sqlret)
				return 1;
			else
				return 0;
		}
		
		return 0;
	
	}

	
	
	/*
	This function returns a user preference.
	*/
	static function getPref($userid,$key,$class='user') {
	
		/* Set default for return value */
		$value = '';
		
		/* Get */
		$sqlret = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE  . '.wassPrefs WHERE (`userid`=' . wassSQL::sqlSafe($userid) . ' AND `key`=' . wassSQL::sqlSafe($key) . ' AND `class`=' . wassSQL::sqlSafe($class)  . ')');
		if ($sqlret) {
			$valarray = wassSQL::doFetch($sqlret);
			if ($valarray)
				$value = $valarray['value'];
		}
		
		return $value;	
	}
	
	
	/*
	This function returns all preferences for a given user.
	*/
	static function getAllUserPrefs($userid) {

		/* Set default return value */
		$valarray = '';
		
		/* Set class */
		$class = 'user';
		
		/* Get all preferences */
		$sqlret = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE  . '.wassPrefs WHERE (`userid`=' . wassSQL::sqlSafe($userid) . ' AND `class`=' . wassSQL::sqlSafe($class) . ')');
		if ($sqlret)
			$valarray = wassSQL::doFetch($sqlret);
		
		/* Return all of the preferences (if any). */	
		return $valarray;
		
	}

}
?>