<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This (static) class can be used to add code to local user exits for WASS.  

To use this class, copy it to the 'classes' directory, and rename it 'wassLocal.class.php'.
 
*/

 

class wassLocal  {



	/* 
	Define constants for function return values (where more than true/false is needed)
	*/
	
	const DOCONTINUE = '';  /* The default (null) response; means code should continue normally. */
	
	const USERINCOURSE = 1;
	const USERNOTINCOURSE = 2;
	
	const COURSEISVALID = 1;
	const COURSEISNOTVALID = 2;

	/*	
	The "login" user exit is called by the WASS login code AFTER the user has been authenticated.  The one argument is the authenticated user id.
	
	This user exit must return a NULL string to allow the login to continue.  If it returns a non-null string, the login will be aborted, and the string
	will be presented to the user as an error message.
	
	*/
	
	static function login($id) {
		/* This sample code uses the directory class to check an ldap attribute for the user and abort the login if it has a certain value 
		
		// Get 'pustatus' ldap attribute.
		$pustatus = wassDirectory::getlDIR($id, 'pustatus');
		// If pustatus=guest, abort the login with an error message 
		if ($pustatus == 'guest')
			return 'Guests are not allowed to login to ' . wassParms::SYSID;
		
		// Otherwise, allow the login 
		return self::DOCONTINUE;
		
		*/
		
		/* Allow the login to continue normally. */
		return self::DOCONTINUE;
		
	}
	

	/* 
	This function is called to determine is a specified user is enrolled in a specified course. 
	
	Arguments:
		courseid: the identifier of the course.
		userid: the identifier of the user.
		
	Returns:
		CONTINUE if the standard supplied code should be used.
		USERINCOURSE if user is in the course.
		USERNOTINCOURSE if user is not in the course.
		
			
	*/
	static function IsUserInCourse($courseid, $userid) { 
	
		/* Allow code to continue normally. */
		return self::DOCONTINUE;
	
	}
	
	/* 
	This function is called to determine is a specified course is valid (exists). 
	
	Arguments:
		courseid: the identifier of the course.
		 
		
	Returns:
		CONTINUE if the standard supplied code should be used.
		COURSEISVALID if the course exists.
		COURSEISNOTVALID if the course dowas not exist.
		
			
	*/
	static function IsCourseValid($courseid) {

		/* Allow code to continue normally. */
		return self::DOCONTINUE;
		
	}
	
	
	/*
	This function is called to get a user email address from the Directory.
	*/
	static function getEmail($netid) {
		
		/* Allow code to continue normally. */
		return self::DOCONTINUE;
		
	}
	
	/*
	This function is called to get a user office from the Directory.
	*/
	static function getOffice($netid) {
		
		/* Allow code to continue normally. */
		return self::DOCONTINUE;
		
	}
	
	
	/*
	This function is called to get a user phone number from the Directory.
	*/
	static function getPhone($netid) {
		
		/* Allow code to continue normally. */
		return self::DOCONTINUE;
		
	}
		
	
	/*
	This function is called to get a user name from the Directory.
	*/
	static function getName($netid) {
		
		/* Allow code to continue normally. */
		return self::DOCONTINUE;
		
	}
	
	/*
	This function is called to validate a password when the institution is using
	the wassUser local user table.
	*/
	static function checkPassword($netid,$realpassword,$testpassword) {
		
		/* The netid and realpassword values are those read from the wassUser table.
		The testpassword valud is what is being validated.  This exit may need to
		tranform the entered password in various ways before comparing it to the
		password in the wassUser table.
		*/
		
		return ($realpassword == $testpassword);
		
	}
	
	

}
?>