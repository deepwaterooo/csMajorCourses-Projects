<?php
/*
Copyright 2006, 2008, 2012 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/
?>

<?php 
Header('Cache-Control: no-cache');
Header('Pragma: no-cache');

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

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();

/* Start session support */
session_start();

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="ui-mobile">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title><?php echo $pagetitle; ?></title>
<link type="text/css" rel="stylesheet" href="css/jquery.mobile.structure-1.2.0.min.css" media="all" />
<link type="text/css" rel="stylesheet" href="css/wass-theme.css" />
<link type="text/css" rel="stylesheet" href="css/custom.css" />
<link type="text/css" rel="stylesheet" href="css/calendar.css" />
<link type="text/css" rel="stylesheet" href="css/mobiscroll-2.1.custom.min.css" />

<script type="text/javascript" src="../libraries/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="../libraries/jquery.mobile-1.2.0.min.js"></script>

<script type="text/javascript" language="javascript">
var g_sessionid = "<?php echo session_id();?>";
var g_loggedInUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";
var g_ajaxURL = "<?php echo wassParms::AJAXURL; ?>";
var g_schemaRoot = "<?php echo wassParms::AJAXSCHEMAROOT; ?>";
var gParms = new Array();
</script>

<script type="text/javascript" language="javascript" src="../libraries/global.js"></script>
<script type="text/javascript" language="javascript" src="../controllers/controller.js"></script>
<script type="text/javascript" language="javascript" src="../models/user.js"></script>
<script type="text/javascript" language="javascript" src="../models/helperclasses.js"></script>
<script type="text/javascript" language="javascript" src="../models/calendar.js"></script>
<script type="text/javascript" language="javascript" src="../libraries/ajax.js"></script>
<script type="text/javascript" language="javascript" src="../libraries/mobiscroll-2.1.custom.min.js"></script>

<script type="text/javascript" language="javascript">
   	$(document).ready(function() {
		Message.erase();
		controller.getParameter("NETID");
	});
</script>
