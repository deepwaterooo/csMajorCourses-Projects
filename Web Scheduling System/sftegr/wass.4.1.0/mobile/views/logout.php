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

/* Save type of user */
$usertype = $_SESSION['authtype'];

/* Clear our authentication variables */
	
$_SESSION['authenticated'] = '';
$_SESSION['authtype'] = '';
$_SESSION['authid'] = '';
	
/* Logout of CAS if needed */
if ((wassParms::AUTHTYPE == wassParms::AUTHCAS)  && ($usertype != 'guest')) {
		
	/* Flag that we just logged out */
	$_SESSION['caslogout'] = true;
	
}

/* Redirect to the welcome page */
//header('Location: login.php');
//exit();

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Log Out</title>
<link type="text/css" rel="stylesheet" href="css/jquery.mobile.structure-1.1.0-rc.1.css" />
<link type="text/css" rel="stylesheet" href="css/wass-theme.css" />
<link type="text/css" rel="stylesheet" href="css/custom.css" />

<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script> 
<script type="text/javascript" language="javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
</head>

<body>

<div data-role="page" id="logout">

	<div data-role="header" data-backbtn="false">
       	<div class="borderbottom marginall">
            <img src="../images/clock.gif" alt="WASS" border="0" height="32" width="32" class="floatleft icon"/>
        	<h2><?php echo wassParms::SYSID; ?><br><span style="font-style: italic;">(Release <?php echo wassRelease::RELEASE; ?>)</span></h2>
        </div>
   	</div><!-- /header -->
	<div data-role="content">	
		<h1 id="pagetitle" class="clear">Log Out</h1>      
		<form id="login" method="post" action="#" data-ajax="false">  
        <p>Thank you for using <?php echo wassParms::SYSID; ?>.</p>
        <p>Click <a href="makeappt.php" data-ajax="false">here</a> to restart.</p>
        </form>
	</div>
</div>
</body>
</html>
