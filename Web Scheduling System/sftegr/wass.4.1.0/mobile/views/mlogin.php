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
		  $auth = phpCAS::forceAuthentication();
		  $userid = phpCAS::getUser();
		  doLogin($userid);	

}


Header('Cache-Control: no-cache');
Header('Pragma: no-cache');

/* If we got here just after a CAS logout, let the user know */
if ($_SESSION['caslogout']) {
	$infmsg = 'Although your current session has been terminated, you are still logged in to ' . wassParms::CASname . ', meaning that you can access ' .   wassParms::CASname . ' -enabled services (including this system) without having to re-enter your ' . wassParms::NETID . ' and ' . wassParms::PASSNAME . '. If you are finished using all ' . wassParms::CASname . ' enabled services you may <a style="font-size:14px; font-weight: bold; margin:0; color:#3366CC; text-decoration:underline" href="' . $_SERVER['PHP_SELF'] . '?doCASlogout=1">Logout of ' . wassParms::CASname . '</a>, so that further access to any ' . wassParms::CASname . ' enabled services will require that you re-enter your ' . wassParms::NETID . ' and ' . wassParms::PASSNAME . '.';
	$_SESSION['caslogout'] = false;
}



/*
Handle a form submission.
*/

/* User may just press ENTER:  if so, pretend he/she clicked $_POST['btnSubmit']. */
if (!$_POST['btnSubmit']  && ($_POST['hidSubmit'] == 'submitted')) 
		$_POST['btnSubmit'] = true;

if (!$errmsg && $_POST['btnSubmit']) {
	/* See if userid/password submitted */
	$userid = wassUtil::slashstrip(trim($_REQUEST['txtUserID']));
	$password = wassUtil::slashstrip(trim($_REQUEST['txtPassword']));
	
	if (!$userid || !$password) 
		$errmsg = 'You must enter a ' . wassParms::NETID . ' and a Password.';
	elseif (!wassDirectory::idCheck($userid,$password))
		$errmsg = 'Invalid ' . wassParms::NETID . '/Password combination.';

	if (!$errmsg )
		doLogin($userid);
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


/*
Now display the page.
*/

/* First, check for repeated calls */
if ($_SESSION['inlogin']) {
	/* mail(wassParms::SYSMAIL,'Repeated entry into WASS login', date('Y-m-d G:i:s') . ': ' .  $msg . "\r\n"  . print_r(debug_backtrace(),true) . "\r\n" . "\r\n"); */
}
else
	$_SESSION['inlogin'] = true;

?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo wassParms::SYSID;?></title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<link type="text/css" rel="stylesheet" href="css/jquery.mobile.structure-1.1.0-rc.1.css" />
<link type="text/css" rel="stylesheet" href="css/wass-theme.css" />
<link type="text/css" rel="stylesheet" href="css/custom.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script> 
<script type="text/javascript" language="javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>

<?php 
//$pagenav = 'makeappt'; /*for setting the "selected" page navigation */
include "_header.php"; ?>
<script type="text/javascript" language="javascript" src="loginview.js"></script>
<script type="text/javascript">
   	$(document).ready(function() {
		loginview.setPageVars();
		//controller.loadLoginViewData();
	}); 	
</script>                                                               
</head>

<body>

<div data-role="page" id="login">

	<div data-role="header" data-backbtn="false">
       	<div class="borderbottom marginall">
            <img src="../images/clock.gif" alt="WASP" border="0" height="32" width="32" class="floatleft icon"/>
        	<h2>Web Appointment Scheduling Program<br><span style="font-style: italic;">(Release 1.0.0)</span></h2>
        </div>
   	</div><!-- /header -->
	<div data-role="content">	
        <!--<a href="help.php" rel="external"><img src="../images/help.jpg" alt="help" border="0" class="helpicon"/></a>-->
		<h1 id="pagetitle" class="clear">Title</h1>      
		<form id="login" method="post" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" data-ajax="false">       
			<input type="hidden" id="hidSubmit" name="hidSubmit" value="submitted" />
            <div id="divCASLogin">
                <h2 class="clear"><?php echo wassParms::INSNAME;?> Community Members</h2>
                <div class="instructions">Click the Log In button to enter a valid <?php echo wassParms::NETID;?> and <?php echo wassParms::PASSNAME;?>.</div>
                <div id="divSubmit" data-role="fieldcontain">    
                    <input type="submit" id="btnSubmit" value="Log In" data-inline="true" data-ajax="false" />
                </div>
            </div>
            
            <div id="divGuestLogin">
                <h2 class="clear">Guests</h2>
                <div class="instructions">Enter your e-mail address and click the Guest Log In button.</div>
    
                <div id="divEmail" data-role="fieldcontain">
                    <label id="lblEmail" for="txtEmail" class="ui-hidden-accessible">E-mail:</label>
                    <input type="text" name="txtEmail" id="txtEmail" placeholder="e-mail address" />
                </div> 
                <div id="divSubmit" data-role="fieldcontain">    
                    <input type="button" id="btnGuest" value="Guest Log In" data-inline="true" data-ajax="false" />
                </div>
            </div>
    	</form>
	</div><!-- /content -->

	<?php include('_footer.php'); ?>
    
    <script type="text/javascript"> 
		$("#btnCAS").click(function(e) {
			//controller.addAppt(gAppt);
			return false;
		});	
		$("#btnGuest").click(function(e) {
			controller.loginGuest($("#txtEmail").val());
			return false;
		});	
    </script>                                                               

</div><!-- /page -->

</body>
</html>
