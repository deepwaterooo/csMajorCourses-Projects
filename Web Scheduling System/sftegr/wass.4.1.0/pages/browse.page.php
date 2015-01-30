<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows users who are searching for a calendar browse by user name, user ID, or calendar title.
 
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

/* Save passed listtype */
$listtype = $_REQUEST['listtype'];
/* Make the text pretty */
$showlisttype = '';
if ($listtype == 'name') $showlisttype = 'Name';
else if ($listtype == 'userid') $showlisttype = wassParms::NETID;
else if ($listtype == 'title') $showlisttype = 'Title';
else if ($listtype == 'grptitle') $showlisttype = 'Group';

/* Save passed return field */
$fld = $_REQUEST['fld'];

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

function closeAndRefreshOpener() {
	self.close();
}
function selectValue(inVal) {
	var el = window.opener.document.getElementById("<?php echo $fld;?>");
	el.value = inVal;
	var srch = window.opener.document.getElementById("btnSubmit");
	srch.click();
	self.close();

}
function init() {
	ajax_listCalendars("<?php echo $listtype;?>");
}
//overwrite ajax function 
function show_listCalendars(arrCals) {
	var arrAlphabet = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");

	var par = GetElement("divValues");
	par.innerHTML = ""; //KDC 2-26-2009, added to remove "loading..." message

	var tblNode = document.createElement("TABLE");
	tblNode.cellSpacing = "0";
	tblNode.cellPadding = "0";
	tblNode.border = "0";
	par.appendChild(tblNode);

	var tblBody = document.createElement("TBODY");
	tblNode.appendChild(tblBody);

	var sHTML = "";
	
	//display the letter grouping for the calendars, assume calendars are in alphabetical order
	var isNewFirstLetter = true;
	var oldc = "";
	
	for (var i=0; i < arrCals.length; i++) {
		var c = (arrCals[i].charAt(0)).toLowerCase(); //get first letter of first value
		if (c == oldc) 
			isNewFirstLetter = false;
		else {
			isNewFirstLetter = true;
			oldc = c;
			trRow = document.createElement("TR");
			tblBody.appendChild(trRow);
			tdCol = document.createElement("TD");
			tdCol.colspan = 2;
			tdCol.innerHTML = "<div id='formdividerShort'></div>";
			trRow.appendChild(tdCol);			
		}
		
		trRow = document.createElement("TR");
		tblBody.appendChild(trRow);
			
		tdCol = document.createElement("TD");
		tdCol.className = "alphaLetter";
		if (isNewFirstLetter) {
			tdCol.innerHTML = c.toUpperCase();
		} else {
			tdCol.innerHTML = "&nbsp;";
		}
		trRow.appendChild(tdCol);
		
		tdCol = document.createElement("TD");
		
		var divHolder = document.createElement("DIV");
		divHolder.className = "valueHolder";
		sHTML = '<a href="#" onclick="selectValue(\'' + escapeSingle(arrCals[i]) + '\');" class="valueLink">' + arrCals[i] + '</a><br>';
		divHolder.innerHTML = sHTML;
		
		tdCol.appendChild(divHolder);
		trRow.appendChild(tdCol);	
	}
}
</script>
</head>

<!-- *** PHP *** -->
<!-- if successful sending of email, output: -->
<?php 
if ($action == "done") {?>
	<body onload="closeAndRefreshOpener();"><?php
}
else {?>
	<body onload="initAjax();init();"><?php
}?>
<form id="frmBrowse" name="frmBrowse" action="#" method="post" >
<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<div id="windowTitle">Browse by <?php echo $showlisttype;?></div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<div id="divValues" style="padding:0px 25px 10px 25px;width:290px;">
Loading...
</div>

<div id="formdividerShort"></div>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</form>

</body>
</html>


<!--                   End of HTML Code                       -->
<?php

?>