<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows appointment makers to log in on a mobile device.  This page does not support guest login.
 
*/

/* Handle loading of classes. */
function __autoload($class) {
	/* Set path to wassParms and wassLocal */
	if (($class == 'wassParms') || ($class == 'wassLocal'))
		$parmspath = getenv('WASSPARMS');
	if (!$parmspath)
		$parmspath = '../../classes/';
		
	/* Now load the class */ 
	if ($class != 'wassLocal')
		require_once($parmspath.$class.'.class.php');
	else
		@include_once($parmspath.$class.'.class.php');
	
}


/* Special case code for CAS */
require_once('../../CAS/CAS.php');

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();

/* Start session support */
session_start();

/* Init error/inform message */
$errmsg = ''; $infmsg = '';

/* If using CAS, initialize */
if (wassParms::AUTHTYPE == wassParms::AUTHCAS) {
	phpCAS::client(wassParms::CASversion,wassParms::CAShost,wassParms::CASport,wassParms::CASuri);
	phpCAS::setNoCasServerValidation();
	phpCAS::setDebug('casdebug');
	
	/* If we are here to logout of CAS, do it */
	if ($_REQUEST['doCASlogout']) {
		phpCAS::logout();
		header('Location:' . wassParms::CASlogout);
		exit;		
	}
	
	/* If already authenticated, go to the right place */
	if (phpCAS::isAuthenticated()  && !$_SESSION['caslogout']) {
		$userid = phpCAS::getUser();
		doLogin($userid);
	}	
}


/* If we are already logged in with session variables set, just go right to the relevant page. */
if (!$errmsg && $_SESSION['authenticated'] && $_SESSION['authtype']=='user') {
		/* Only one place to go */
		header('Location: makeappt.php');
		exit();
}


/* If we are using CAS, just go to the CAS login */
if (wassParms::AUTHTYPE == wassParms::AUTHCAS && !$_SESSION['caslogout']) {
		  /* force CAS authentication */
		  phpCAS::setDebug('casdebug');
		  $auth = phpCAS::forceAuthentication();
		  $userid = phpCAS::getUser();
		  doLogin($userid);	

}


/* If we got here just after a CAS logout, let the user know */
if ($_SESSION['caslogout']) {
	$infmsg = 'Although your current session has been terminated, you are still logged in to ' . wassParms::CASname . ', meaning that you can access ' .   wassParms::CASname . ' -enabled services (including this system) without having to re-enter your ' . wassParms::NETID . ' and ' . wassParms::PASSNAME . '. If you are finished using all ' . wassParms::CASname . ' enabled services you may <a style="font-size:14px; font-weight: bold; margin:0; color:#3366CC; text-decoration:underline" href="' . $_SERVER['PHP_SELF'] . '?doCASlogout=1">Logout of ' . wassParms::CASname . '</a>, so that further access to any ' . wassParms::CASname . ' enabled services will require that you re-enter your ' . wassParms::NETID . ' and ' . wassParms::PASSNAME . '.';
	$_SESSION['caslogout'] = false;
}


/* Handle login */
function doLogin($id) {
	
	global $errmsg; 
	
	/* Call the local authentication exit, if any */
	if (class_exists('wassLocal')) {
		if (method_exists('wassLocal','login')) {
			if ($errmsg = wassLocal::login($id))
				return;
		}
	}
	
	
	/* Save login credentials */
	$_SESSION['authenticated'] = true;
	$_SESSION['authtype'] = 'user';
	$_SESSION['authid'] = $id;
	$_SESSION['inlogin'] = false;
	
	/* Save whether/not user owns a calendar */
	$calids = wassCalendar::arrayOwnedCalendarids($id);
	if (count($calids)) {
		$_SESSION['owner'] = true;
	}
	else {
		$_SESSION['owner'] = false;
	}
	
	/* Save whether/not user is a manager */
	if (wassManager::listManagedids($id)) {
		$_SESSION['ismanager'] = true;	
	}
	else
		$_SESSION['ismanager'] = false;		


	/* Check for an authentication redirect URL */
	if ($_SESSION['redirurl'] != "") {
		$temp = $_SESSION['redirurl'];
		$_SESSION['redirurl'] = "";
		header('Location: ' . $temp);
		exit();
	}	

	/* Only one place to go */
	header('Location: makeappt.php');
	exit();
}	
?>