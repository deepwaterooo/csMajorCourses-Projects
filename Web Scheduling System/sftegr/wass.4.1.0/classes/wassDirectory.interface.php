<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This file defines the interface required to support authentication and identification in wass.
 
*/

interface wassDirect {


	/* Define functions that must be implemented */
	
	/*
	This function returns a netid that has a given attribute value.
	*/
	static function getNetid($attribute, $value);
	
	/*
	This function checks to see if the user is currently authenticated, and, if not,
	redirects the user to the authenticator, saving the target location for later redirect back
	from the authenticator.
	*/
	static function authenticate($redirlocation='');

	
	/* 
	This function validates a netid/password combination, and returns true (if valid) 
	or false (if not). 
	*/
	static function idCheck($netid,$password);
	
	/* 
	This function validates a netid, and returns true (if it exists in the directory) 
	or false (if not). 
	*/
	static function useridCheck($netid);
	
	/* 
	This function returns an email address, or null if not found 
	*/
	static function getEmail($netid);
	
	/* 
	This function returns an office location, or null if not found 
	*/
	static function getOffice($netid);
	
	
	/* 
	This function returns a telephone number, or null if not found 
	*/
	static function getPhone($netid);
	
	/* 
	This function returns a name, or null if not found 
	*/
	static function getName($netid);
		
	/*
	This function determines if a netid ahs a given attribute value.
	*/
	static function hasValue($netid,$attribute,$value);
	
}
?>