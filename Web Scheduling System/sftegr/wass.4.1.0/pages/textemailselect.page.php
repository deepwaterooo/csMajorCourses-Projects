<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page is a pop-up for generating a text message e-mail address based on phone number and service provider.
        GET Arguments:
			- fld: the HTML field name where the text message e-mail address will appear on the opening window.
			- txtemail: the text message email address value from the opening window, if any.
 
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

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();


/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

/* This page does not do a form submission. */

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
<title>Generate Text Email</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	margin: 4px;
}
fieldset div:hover span {
	font-size: inherit;
	color: inherit;
	background-color: inherit;
	float: none;
}
fieldset .instructions {
}
</style>
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript">

var txtMsgGateways = new Array();
txtMsgGateways["Alltel"] = "message.Alltel.com";
txtMsgGateways["AT&T"] = "txt.att.net";
txtMsgGateways["Cellular One"] = "mobile.celloneusa.com";
txtMsgGateways["Cingular"] = "cingular.com";
txtMsgGateways["Nextel"] = "messaging.nextel.com";
txtMsgGateways["Sprint"] = "messaging.sprintpcs.com";
txtMsgGateways["T-Mobile"] = "tmomail.net";
txtMsgGateways["Verizon Wireless"] = "vtext.com";

function init() {
	var eml = "<?php echo trim($_REQUEST['txtemail']);?>";
	if (eml != null && eml != "") {
		var arrEml = new Array();
		arrEml = eml.split("@");
		GetElement("txtTextNumber").value = arrEml[0];
		var counter = 0;
		var provider = 0;
		for (var i in txtMsgGateways) {
			if (txtMsgGateways[i] == arrEml[1])
				provider = counter;
			counter++;
		}
		//If provider not found, the user must have entered it manually.  Put it into the text field and show it.
		if (provider == 0) {
			ShowHideElement('divTextEmailManual','show');
			GetElement("txtTextAddress").value = eml;
		}
		else	
			GetElement("selProviders").selectedIndex = provider;
	}
}

var g_txtemail = "";
function doSendToOpener() {
	var win = window.opener;
	if (win != null) {
		win.GetElement("<?php echo trim($_REQUEST['fld']);?>").value = g_txtemail;
		win.GetElement("divTextEmailNumber").innerHTML = g_txtemail;
	}
	self.close();	
}

//This is called by ajax_isEmailValid
function showIsValidEmail(isValid) {
	if (!isValid) {
		alert("Note: This text message email address does not appear to be valid; please check to make sure you have the correct cell phone number and provider SMS gateway.");
	} else {
		doSendToOpener();
	}
}
function validateAddress(inAddr) {
	ajax_isEmailValid(inAddr);
	//continues to showIsValidEmail after ajax return
	return false;
}

function generateTextEmail() {
	//first, check to see if user manually entered the text email address and use this one.
	var txtaddr = GetElement("txtTextAddress").value;
	if (txtaddr != null && txtaddr != "") {
		g_txtemail = txtaddr;
	} else {
		//otherwise, use the provider/cell phone number fields to generate the text email address.
		var nmbr = GetElement("txtTextNumber").value;
		if (nmbr == null || nmbr == "") {
			return false;
		}
		var prvdr = GetElement("selProviders").value;
		nmbr = nmbr.replace(/\D/g, "");
		g_txtemail = nmbr + "@" + txtMsgGateways[prvdr];
	}
	validateAddress(g_txtemail);
}

</script>
</head>

<body onload="init();initAjax();">
<form id="frmTxtEmail" name="frmTxtEmail" action="#" method="post">

<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<div class="instructions">Select your service provider and enter your cell phone number to have a text sent to your phone.</div>

<fieldset class="popup">
<div>
<label for="selProviders" title="Select your cell phone service provider">Service Provider:</label>
<select name="selProviders" id="selProviders">
<script type="text/javascript" language="javascript">
for (var i in txtMsgGateways) {
	document.write("<option value='" + i + "'>" + i + "</option>");
}
</script>
</select>
</div>

<br>

<div>
<label for="txtTextNumber" title="Enter your cell phone number">Cell Number:</label>
<input type="text" id="txtTextNumber" name="txtTextNumber" size="15">
</div>

<br>

<div class="instructions" style="font-style:italic;">If your service provider is not listed, <a href="#" onclick="ShowHideElement('divTextEmailManual','show');">click here</a> to enter your text message e-mail address manually.</div>

<div id="divTextEmailManual" style="display:none;">
<label for="txtTextAddress" title="Enter your text message e-mail address">Txt Msg E-mail:</label>
<input type="text" id="txtTextAddress" name="txtTextAddress" size="30">
<div style="color:red;display:block;margin-left:22px;margin-top:3px;">NOTE: This must be of the form 6095551212@att.net</div>
</div>

<div class="buttonsShort">
<input type="button" id="btnSubmit" name="btnSubmit" class="button1" value="Generate" onclick="generateTextEmail();">
</div>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</fieldset>
</form>
</body>
</html>


<!--                   End of HTML Code                       -->
<?php

?>