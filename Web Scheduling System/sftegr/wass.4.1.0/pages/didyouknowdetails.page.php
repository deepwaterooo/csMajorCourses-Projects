<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page shows users details about a "Did You Know" entry.
 
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
	
}/* Clear error/inform message */
$errmsg = ''; $infmsg = ''; $action = '';


/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();

/* If not authenticated (or if a guest), send back for authentication */
wassDirectory::authenticate();

/* Save passed did you know id */
$dykid = $_REQUEST['dykid'];

/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

}
/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><?php echo wassParms::SYSID;?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;

function init() {
	drawDYKDetails();
}
function writeDYKToPage(sHdr,sDtls) {
	GetElement("divDYKHeader").innerHTML = sHdr;
	GetElement("divText").innerHTML = sDtls;
}
function drawDYKDetails() {
	var sHdr = window.opener.GetElement("hidDYKHeader").value;
	var sDtls = window.opener.GetElement("hidDYKDetails").value;
	writeDYKToPage(sHdr,sDtls);
}
//overwrite ajax function
function show_getDidYouKnow(inDYKID,inDYKHeader,inDYKDetails) {
	writeDYKToPage(inDYKHeader,inDYKDetails);
}
</script>
</head>

<!-- *** PHP *** -->
<body onload="initAjax();init();">
<form id="frmDYK" name="frmDYK" action="#" method="post" >
<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<div id="windowTitle">Did You Know?</div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<div id="divDYKHeader" class="extrainfoContentDetails"></div>

<div id="divText" style="padding:0px 25px 10px 25px;width:290px;">
Loading...
</div>

<div class="extrainfoNavDetails"><a href="#" onclick="ajax_getDidYouKnow();">Next ></a></div>

<div id="formdividerShort"></div>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</form>

</body>
</html>


<!--                   End of HTML Code                       -->
<?php

?>