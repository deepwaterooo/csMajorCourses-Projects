<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This static class implements functions associated with the WASS redirect (tinyurl) facility.
This facilit allows WASS to associate a short URL with a long URL.
 
*/



class wassRedir {

	/* 
	This function returns the database table id of the passed URL.  It first creates the database table entry, if necessary.
	*/
	static function urlid($url) {

		/* See if the url is already in the redirect database table. */
		$urlentry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassRedir WHERE url=' . wassSQL::sqlSafe($url)));
		/* If not, add it to the table */
		if (!($redirid = $urlentry['redirid'])) {
			/* Save the url in the redirect table */
			wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassRedir (url) VALUES(' . wassSQL::sqlSafe($url) . ')');
			$redirid = wassSQL::insert_id();																									 		
		}
		/* Now return the redirect URL */
		return  $redirid;
		
	}
	

}
?>