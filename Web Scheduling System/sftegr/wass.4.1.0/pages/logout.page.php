<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page logs out the user and redirects to the welcome page.
 
*/


/* Handle loading of classes. */
function __autoload($class) {
	/* Set path to wassParms and wassLocal */
	if (($class == 'wassParms') || ($class == 'wassLocal'))
		$parmspath = getenv('WASSPARMS');
	if (!$parmspath)
		$parmspath = '../classes/';
		
	/* Now load the class */ 
	if ($class != 'wassLocal')
		require_once($parmspath.$class.'.class.php');
	else
		@include_once($parmspath.$class.'.class.php');
	
}


/* Special case code for CAS */
require_once('../CAS/CAS.php');

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();

/* CAS code:
	phpCAS::logout();
*/

 
/* Start session support */
session_start();

/* Save type of user */
$usertype = $_SESSION['authtype'];


/* Unset all of the session variables
$_SESSION = array();
*/

/* Terminate the session
session_destroy();
*/

/* Clear our authentication variables */
	
$_SESSION['authenticated'] = '';
$_SESSION['authtype'] = '';
$_SESSION['authid'] = '';
	

/* Logout of CAS if needed */
if ((wassParms::AUTHTYPE == wassParms::AUTHCAS)  && ($usertype != 'guest')) {
	
	/* We will NOT do a CAS logout; rather, we simply clear our SESSION variables and start all over. 
	 
	phpCAS::client(wassParms::CASversion,wassParms::CAShost,wassParms::CASport,wassParms::CASuri);
	phpCAS::setNoCasServerValidation();
	phpCAS::logOut('https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/login.page.php'); 
	
	*/
	

	/* Start a new session, and save fact that we have logged out. 
	session_start();
	*/
	
	/* Make sure 
	$_SESSION['authenticated'] = '';
	$_SESSION['authtype'] = '';
	$_SESSION['authid'] = '';
	*/
	
	/* Flag that we just logged out */
	$_SESSION['caslogout'] = true;
	
}

/* Redirect to the welcome page */
header('Location: login.page.php');
exit();

?>