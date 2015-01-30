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
		header('Location: apps.page.php');
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
	header('Location: apps.page.php');
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
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID . ' (Release ' . wassRelease::RELEASE . ')';?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";
document.sUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";

function init() {
document.focusbutton = "btnSubmit";
}
function setEnterFocus(inElID) {
//alert("setting:" + inElID);
	document.focusbutton = inElID;
}
document.onkeypress = EnterKeySearch;
function EnterKeySearch(e) {
	if (!e) var e = window.event;
	if (CheckForEnterKey(e)) {
		//if the user has focus in the email text field, enter should activate the 2nd login button
		var el = GetElement(document.focusbutton);
//	alert(document.focusbutton);
		el.click();
	}
	return true;
}
</script>

</head>

<body onload="init();">
<form id="frmLogin" name="frmLogin" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="login" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="Welcome" />
<input type="hidden" id="helptopic" name="helptopic" value="start" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassParms::CONTACTNAME;?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassParms::CONTACTEMAIL;?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassParms::CONTACTPHONE;?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassParms::INSFNAME;?>" />

<input type="hidden" id="hidSubmit" name="hidSubmit" value="submitted" />

<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/header.js"></script>
<script type="text/javascript" language="javascript" src="js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content" style="background-image:url(images/calendar_wordBKGD.jpg); background-repeat:no-repeat;">
<table cellspacing="0" cellpadding="0" class="loginTable">
	<tr>
		<td align="left" valign="top">
			<div id="loginImage"><img src="images/calendarPrinceton.jpg" alt="image of calendar" /></div>
		</td>
		<td align="left" valign="top">
			
		<!-- CONTENT GOES HERE -->
<div class="welcomeInfo">This system lets you schedule appointments over the Web.</div>
			<div style="width:400px; padding:20px 0px 20px 20px;">
			<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm" style="width:725px;"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	
						
                    
                        <h1>Log In</h1>
						<?php if (wassParms::AUTHTYPE == wassParms::AUTHLDAP || wassParms::AUTHTYPE == wassParms::AUTHAD || wassParms::AUTHTYPE == wassParms::AUTHLOCAL) { ?>
							<span class="small2">If you are a member of the <?php echo wassParms::INSNAME;?> community and have a valid 
							<a href="<?php echo wassParms::HELPNETID;?>" target="_blank"><?php echo wassParms::NETID;?></a>, enter 
							it along with your <a href="<?php echo wassParms::HELPPASS;?>" target="_blank"><?php echo wassParms::PASSNAME;?></a>.</span>								
						<fieldset>
							<div>
								<label for="txtUserID"><?php echo wassParms::NETID;?>:</label> 
									<input type="text" name="txtUserID" id="txtUserID" tabindex="1">
							</div>		
							<div>
								<label for="txtPassword"><?php echo wassParms::PASSNAME;?>:</label>
									<input type="password" name="txtPassword" id="txtPassword" tabindex="2">
							</div>
						</fieldset>	
					<?php }
					else  { ?>
						<span class="small2">If you are a member of the <?php echo wassParms::INSNAME;?> community and have a valid <a href="<?php echo wassParms::HELPNETID;?>" target="_blank"><?php echo wassParms::NETID;?></a> and <a href="<?php echo wassParms::HELPPASS;?>" target="_blank"><?php echo wassParms::PASSNAME;?></a>,
							click the Log In button below.
						</span>	
						<br /><br /><br />
					<?php } ?>			
  					<div style="float:right; margin:-15px 60px 0px 0px; _margin:-15px 20px 0px 0px;"><input type="submit" id="btnSubmit" name="btnSubmit" class="buttonPrimary" value="Log In" tabindex="3"></div>
			</div>
					
			<!-- END CONTENT -->
		</td>
	</tr>
</table>
</div>
<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->
<div id="footnote">NOTE: If you keep getting returned to this page, it is likely that you 
   have turned off cookies support in your browser.  This system requires cookies to be turned on.</div>
</form>
</body>
</html>
<!--                   End of HTML Code                       -->
<?php
?>