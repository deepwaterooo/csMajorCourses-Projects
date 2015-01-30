<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This page presents FAQ text.
 
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
	
}/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Start session support */
session_start();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Web Appointment Scheduling System - FAQ</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/print.css" media="print" />

</head>

<body onload="init();">
<form id="frmMain" name="frmMain" action="" method="post">

<div id="smallWindowIcon"><img src="images/logo.jpg" alt="logo" width="52" height="45"/></div>
<div id="smallWindowTitle">Frequently Asked Questions</div>

<div style="margin:10px 60px 10px 0px; text-align:right;"><a href="javascript:print();"><img src="images/print.gif" alt="print" border="0" class="icon" /></a></div>

<?php
include_once('faq.htm');
?>

</form>
<br><br>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</body>
</html>
