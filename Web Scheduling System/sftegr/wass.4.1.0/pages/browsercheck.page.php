<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page checks the user's browser for required technologies

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

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();


/* Start session support */
session_start();


/* Init error/inform message */
$errmsg = ''; $infmsg = '';


Header('Cache-Control: no-cache');
Header('Pragma: no-cache');

/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo wassParms::SYSID;?></title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>

Checking Browser...

<noscript>
ERROR:<BR />WASS requires JavaScript and Cookies to function properly.  Please enable JavaScript and Cookies on your browser, then click:<br />
<form id="frmLogin" name="frmLogin" action="<?php echo $_SERVER['SCRIPT_NAME'];?> method="post" >
<input type="submit" id="btnTryAgain" name="btnTryAgain" class="button1" value="Try Again">
</form>
</noscript>

<script type="text/javascript" language="javascript">
window.location = "login.page.php";
</script>

NOTE: If you keep getting returned to this page, it is likely that you
have turned off cookies support in your browser.  WASS requires this support to function properly.


</body>
</html>
<!--                   End of HTML Code                       -->
<?php
?>