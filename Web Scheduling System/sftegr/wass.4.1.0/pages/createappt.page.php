<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page allows users to create appointments.
		Notable GET (and POST) Arguments:
			- block_id: the block in which the appointment will be made.
			- appt_start: the start time for the appointment (as selected by the user).              This will be used as the default in the list of available appointment times.

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

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate();

/* Assume no errors */
$errmsg = ''; $infmsg = '';

/* Save passed arguments, if any */
$blockid = $_REQUEST['block_id'];
$appstart = $_REQUEST['app_start'];
$appid = $_REQUEST['app_id'];

/* Init variables to keep track of what we have done */
$calendar = '';
$block = '';
$action = '';


/* If editing an existing appointment, read it in */
$curapp = ''; 
if ($appid) {
	try {
		$curapp = new wassAppointment('load',array('appointmentid'=>$appid));
		$appstart = $curapp->starttime;
		$append = $curapp->endtime;
		$blockid = $curapp->blockid;
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
		$action = 'failed';
	}	
}

	
/* Read in the block and calendar */
if ($blockid) {
	try {
		$block = new wassBlock('load',array('blockid'=>$blockid));
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
		$action = 'failed';
	}
	/* Read in the calendar (if any ) */
	if ($block) {
		try {
			$calendar = new wassCalendar('load',array('calendarid'=>$block->calendarid));
		} catch (Exception $error) {
			$errmsg = $error->getMessage();
			$action = 'failed';
		}
	}
}


/* Save user status */
$calowner = false;
if (is_object($calendar))
	if ($calendar->isOwnerOrManager($_SESSION['authtype'],$_SESSION['authid']))
		$calowner = true;


/* Extract information about the user */
$remchecked = true;
if ($curapp) {
	$userid = $curapp->userid;
	$email = $curapp->email;
	$textemail = $curapp->textemail;
	$phone = $curapp->phone;
	$name = $curapp->name;	
	$purpose = $curapp->purpose;
	$notes = $curapp->notes;
	$remchecked = $curapp->remind;
}
else {
  if ($calowner) {
	  /* If making an appointment on behalf of someone else, clear the fields */
	  $userid = '';
	  $email = '';
	  $textemail = '';
	  $phone = '';
	  $name = '';
  }
  elseif ($_SESSION['authtype'] == 'guest') {
	  /* If guest, all we know is the email address */
	  $userid = '';
	  $email = $_SESSION['authid'];
	  $phone = '';
	  $name = '';
  }
  else {
  	  /* Set defaults as per the directory */
	  $userid = $_SESSION['authid'];
	  $email = wassDirectory::getEmail($userid);
	  $phone = wassDirectory::getPhone($userid);
	  $name = wassDirectory::getName($userid);
  }
}


/* Compute how many appointments user is allowed to make for this block */
if ($block) {
	if ($curapp)
		$hidAppLimit = $block->editableApps($_SESSION['authtype'], $_SESSION['authid'],$curapp);
	else
		$hidAppLimit = $block->makeableApps($_SESSION['authtype'], $_SESSION['authid']);
}

/*
Handle a form submission.
*/
if (!$errmsg && ($_POST['btnSubmit'] || $_POST['hidSubmitForm'])) {


	/* Init appointment values array */
	$appvals = array();

	/* Save the form data. */
	if (isset($_REQUEST['txtUser'])) {
		$appvals['userid'] = wassUtil::slashstrip(trim($_REQUEST['txtUser']));
		/* Userids can contain '@' signs, so the following code is commented out
		if (strpos($appvals['userid'],'@')) {
			$appvals['email'] = $userid;
			$appvals['userid'] = '';
		}
		*/
	}
	else
		$appvals['userid'] = $userid;

	$appvals['name'] = trim(wassUtil::slashstrip($_REQUEST['txtName']));
	$appvals['email'] = trim(wassUtil::slashstrip($_REQUEST['txtEmail']));
	$appvals['textemail'] = trim(wassUtil::slashstrip($_REQUEST['txtTextEmail']));
	$appvals['phone'] = trim(wassUtil::slashstrip($_REQUEST['txtPhone']));
	$appvals['purpose'] = trim(wassUtil::slashstrip($_REQUEST['txtPurpose']));
	$appvals['notes'] = trim(wassUtil::slashstrip($_REQUEST['txtNotes']));
	if (isset($_REQUEST['chkRemind']))
		$appvals['remind'] = 1;
	else
		$appvals['remind'] = 0;

	/* For now, subsitute ' and ' for & */

	$appvals['purpose'] = str_replace('&',' and ',$appvals['purpose']);
	$appvals['notes'] = str_replace('&',' and ',$appvals['notes']);

	/* Save the selected start time */
	if (!$block->slotted) {
		$appvals['starttime'] = $block->starttime;
		$appvals['endtime'] = $block->endtime;
	}
	/* Compute start/end times from selected values */
	else {
		$appswanted = count($_REQUEST["selTime"]);
		if ($appswanted < 1) {
			$errmsg = "You must select a time.";
		}
		else {
			$firststart = $_REQUEST["selTime"][0];
			if ($firststart == "")
				$errmsg = 'You must select a time.';
			else {
				$prevstart = $firststart;
				$duration = $block->slotsize;
				if ($appswanted > 1) {
					for ($i=1; $i < $appswanted; $i++) {
						$duration += $block->slotsize;
						if (wassUtil::elapsedTime($prevstart,$_REQUEST["selTime"][$i]) > $block->slotsize)
							$errmsg = "If you select multiple time ranges, they must be consecutive.";
						$prevstart = $_REQUEST["selTime"][$i];
					}
				}
			}
		}
		/* We now have the starting time and the duration */
		$appvals['starttime'] = $firststart;
		$appvals['endtime'] = wassUtil::minToTime(wassUtil::timeToMin($firststart) + $duration);

	}
	
	/* If editing, save the current appointmentid for the edited appointment */
	if ($curapp)
		$appvals['appointmentid'] = $curapp->appointmentid;
	
	/* Make sure user is allowed to make or edit an appointment */
	if (!$errmsg) {
		if ($curapp)
			$errmsg = $block->isEditable($_SESSION['authtype'], $_SESSION['authid'],$appvals['starttime'],$appvals['endtime'],$curapp);
		else
			$errmsg = $block->isMakeable($_SESSION['authtype'], $_SESSION['authid'],$appvals['starttime'],$appvals['endtime']);
	}

	if ($errmsg)
		$action = 'failed';
	else {

		/*
		Check the userid/email, as follows:
		if the authenticated user owns/manages the block, then accept any userid/email.
		otherwise, the specified userid or email must match the authenticated user/email.
		*/
		if (!$calowner) {
			/* Authenticated user does not own/manager the calendar */
			/* If userid specified, must match authenticated userid */
			if ($_SESSION['authtype'] == 'guest') {
				if ($appvals['userid'])
					$errmsg = 'Guests may not create appointments for other users.';
				elseif ($appvals['email'] != $_SESSION['authid'])
					$errmsg = 'Specified email address must match login email address.';
				/* Guests must specify a name */
				if (!$appvals['name'])
					$errmsg = 'You must fill in the Name field.';
			}
			else {
				if ($appvals['userid'] != $_SESSION['authid'])
					$errmsg = wassUtil::Error(27,array($_SESSION['authid'],'appointment',$appvals['userid']),'FORMAT');
			}
			/* Fail if required purpose was not specified */
			if ($block->purreq && !$appvals['purpose'])
				$errmsg = 'You must specify a purpose for this appointment.';
		}

		/* Now try to create or edit the appointment */
		if (!$errmsg) {
			/* Create the appointment. */
			try {
				/* If creating a new appointment, fill in unspecified values from the block, then build */
				if (!$curapp) {
				  $appvals['calendarid'] = $block->calendarid;
				  $appvals['blockid'] = $block->blockid;
				  $appvals['date'] = $block->date;
				  /* Add in a UID for iCal purposes */
				  $appvals['uid'] =  date('Ymd\TGis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI'];
				  /* Build the appointment object */
				  $appobject = new wassAppointment('create', $appvals);
				}
				/* If editing, build using existing values */
				else
					$appobject = new wassAppointment('update', $appvals);

			} catch (Exception $error) {
			/* If an error, return error code and message */
				$errmsg = wassUtil::Error($error->getCode(),array($error->getMessage()),'FORMAT');
				$action = 'failed';
			}

			/* Make sure appointment slot is still available */
			if ($block->booked($appobject->starttime,$appobject->endtime,$curapp)) {
				$errmsg = 'The appointment time has just become unavailable.';
				$action = 'failed';
			}
			

			/* Now save the appointment (and capture the appointment id). */
			/* Write out the updated appointment. */
			if (!$errmsg) {
				try {
					if ($curapp)
						$appointmentid = $appobject->save('update',$curapp);
					else
						$appointmentid = $appobject->save('create','');
					$appobject->appointmentid = $appointmentid;
					if ($curapp)
						$infmsg = 'Appointment edited';
					else 
						$infmsg = 'Appointment created';	
					$action = 'created';
				} catch (Exception $error) {
				/* If an error, return error code and message */
					$errmsg = wassUtil::Error($error->getCode(),array($error->getMessage()),'FORMAT');
					$action = 'failed';
				}
			}

			/* Now check for overbooking */
			if (!$errmsg) {
				if ($block->overBooked($appobject->starttime)) {
					$appobject->delete('The appointment time has just become unavailable.');
					$errmsg = 'The appointment time has just become unavailable.';
					$action = 'failed';
				}
			}			
		}
	}
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
<script type="text/javascript" language="javascript" src="js/block.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
function closeAndAlert(inMsg) {
	alert(inMsg);
	self.close();
}
function closeAndRefreshOpener() {
	window.opener.reloadPage();
	self.close();
}

document.isSettingDetails = false;
function doGetUserDetails() {
	var sUser = GetElement("txtUser").value;
	if (sUser != "") {
		document.isSettingDetails = true;
		if (sUser.indexOf("@") != -1) { //user entered an email address
			GetElement("txtEmail").value = safeHTMLJS(sUser);
		} else {
			ajax_getUserDetails(sUser);
		}
	}
}
/* overwrite ajax show function */
function show_getUserDetails(sName,sEmail,sPhone,sOffice) {
	GetElement("txtName").value = safeHTML(sName);
	GetElement("txtEmail").value = safeHTML(sEmail);
	GetElement("txtPhone").value = sPhone;
	setTimeout('resetSettingDetails()',500);
}
function resetSettingDetails() {
	document.isSettingDetails = false;
}

function doValidate()
{
	return validateForm();
}

var txtUserDef = "<?php echo $userid;?>";
var txtNameDef = "<?php echo $name;?>";
var txtEmailDef = "<?php echo $email;?>";

function validateForm()
{
/*	var msg = "";
	var cMsgFieldError = "Please enter the following required information: \n";
	var iflag = false;

	//var blk = Block.GetBlockByID(GetElement("block_id").value);

	var max = (document.forms[0].hidAppLimit.value)*1;
	var sel = GetElement("selTime[]");
	var count=0;
	if ( sel != null )
	{
		for ( var i=0; i<sel.options.length; ++i)
		{
			if ( sel.options[i].selected )
				count++;
		}
	}

	var isFirstFieldError = true;
	if (isBlankField("txtUser"))
	{
		if (isFirstFieldError) {
			msg += cMsgFieldError;
			isFirstFieldError = false;
		}
    	msg += " Netid or E-mail, setting to default \n"; iflag = true;
		GetElement("txtUser").value = safeHTMLJS(txtUserDef);
	}

	if (isBlankField("txtName"))
	{
		if (isFirstFieldError) {
			msg += cMsgFieldError;
			isFirstFieldError = false;
		}
    	msg += " Name, setting to default \n"; iflag = true;
		GetElement("txtName").value = safeHTMLJS(txtNameDef);
	}

	if (isBlankField("txtEmail"))
	{
		if (isFirstFieldError) {
			msg += cMsgFieldError;
			isFirstFieldError = false;
		}
    	msg += " Email, setting to default \n"; iflag = true;
		GetElement("txtEmail").value = safeHTMLJS(txtEmailDef);
	}

	if ( iflag ) alert(msg);

	return !iflag;
*/
	yesSubmit();
}

function init() {
	var elFirst = GetElement("txtUser");
	if (elFirst != null)
		elFirst.focus();
}

function yesSubmit() {
	GetElement("hidSubmitForm").value = true;
	submitForm();
}
//KDC, 9-23-2010. Validate email address
var isValidating = false;
var isSubmitting = false;
function doSubmitPrep() {
	doValidate();
}

function validateEmail() {
	doValidateEmail();
}

</script>
</head>

<?php
if ($action == 'created') {?>
	<body onload="closeAndRefreshOpener();"><?php
}
elseif ($action == 'failed') {?>
	<!--<body onload="closeAndAlert('<?php echo $errmsg;?>');">-->
	<body onload="init();initAjax();"><?php
}
else {?>
	<body onload="init();initAjax();"><?php
}?>

<div id="windowTitle"><?php if ($curapp) echo 'Edit'; else echo 'Make';?> an Appointment </div>

<div id="formdividerShort"></div>


<form id="frmCreateAppt" name="frmCreateAppt" action="createappt.page.php" method="post">
<input type="hidden" name="block_id" value="<?php echo $blockid;?>" />
<input type="hidden" name="app_start" value="<?php echo $appstart;?>" />
<input type="hidden" name="app_id" value="<?php echo $appid;?>" />

<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />
<input type="hidden" id="hidAppLimit" name="hidAppLimit" value="<?php echo $hidAppLimit ?>" />

<input type="hidden" id="hidSubmitForm" name="hidSubmitForm" value="false" />

<?php
if ($errmsg) { ?>
    <div id="error"><?php echo $errmsg;?><br>
    <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>
	<div id="confirm"><?php echo $infmsg;?><br>
    <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>

<fieldset id="window">

<div>
<label>Block Owner:</label>
<p class="plain"><?php if (is_object($block)) if ($block->name) echo wassUtil::safeHTML($block->name); else echo wassUtil::safeHTML($block->userid);?>&nbsp;</p>
</div>
<div>
<label>Block Title:</label>
<p class="plain"><?php if (is_object($block)) echo wassUtil::safeHTML($block->title);?>&nbsp;</p>
</div>
<div>
<label>Date:</label>
<p class="plain"><?php if (is_object($block)) echo wassUtil::safeHTML(wassUtil::longDate($block->date));?>&nbsp;</p>
</div>
<div>
<label>Location:</label>
<p class="plain"><?php if (is_object($block)) echo wassUtil::safeHTML($block->location);?>&nbsp;</p>
</div>

<br>

<!-- *** PHP *** -->
<!-- if this is an unslotted block -->
<?php
if (is_object($block))
	if (!$block->slotted) {?>
		<div>
		<label>Time:</label>
		<p class="plain">Between <?php echo wassUtil::safeHTML(wassUtil::AmPm($block->starttime));?> and <?php echo wassUtil::safeHTML(wassUtil::AmPm($block->endtime));?>&nbsp;</p>
</div>

	<?php
	} else {?>
		<div>
		<label for="selTime" class="mandat">Time:*</label>
		<select name="selTime[]" id="selTime[]" multiple="yes" tabindex="1">
		<?php
		/* We need to determine all of the available slots */
		$available = array();
		if (is_object($block)) {
			if ($curapp)
				$available = $block->editableSlots($_SESSION['authtype'],$_SESSION['authid'],$curapp);
			else
				$available = $block->availableSlots($_SESSION['authtype'],$_SESSION['authid']);
		}
		
		$appstartmin = wassUtil::timeToMin($appstart);
		
		if ($curapp)
			$appendmin = wassUtil::timeToMin($append);
		else
			$appendmin = $appstartmin + $block->slotsize;
		
		foreach ($available as $slot) {
			$slotstartmin = wassUtil::timeToMin($slot);
			?>
			<option value="<?php echo $slot;?>" 
			<?php if (($slotstartmin >= $appstartmin) && ($slotstartmin < $appendmin))  echo 'selected="selected"';?>><?php echo wassUtil::AmPm($slot);?> - <?php echo wassUtil::AmPm(wassUtil::minToTime(wassUtil::timeToMin($slot) + $block->slotsize));?></option><?php
		}?>
		</select>
		</div><?php
	}?>
</fieldset>
<div id="formdividerShort"></div>
<fieldset>

<?php 
if ($_SESSION['authtype'] != 'guest') {?>
<div>
<label for="txtUser" class="mandat"><?php echo wassParms::NETID;?>:*</label>
<input type="text" id="txtUser" name="txtUser" tabindex="2" size="35" value="<?php echo wassUtil::safeHTML($userid);?>" onblur="doGetUserDetails();" onclick="this.select();">
</div>
<!-- end -->
<?php
}?>



<br>

<div>
<label for="txtName" class="mandat"><?php if (!$calowner) echo 'Your ';?>Name:*</label>
<input type="text" id="txtName" name="txtName" tabindex="3" value="<?php echo wassUtil::safeHTML($name);?>" size="35" onclick="this.select();">
</div>

<br>

<div>
<label for="txtPhone">Telephone:</label>
<input type="text" id="txtPhone" name="txtPhone" tabindex="4" value="<?php echo wassUtil::safeHTML($phone);?>" size="12" onclick="this.select();">
</div>

<br>

<div>
<label for="txtPurpose" >Purpose:<?php if ($block->purreq) echo '*';?></label>
<textarea cols="35" id="txtPurpose" name="txtPurpose" rows="2" tabindex="5"><?php echo wassUtil::safeHTML($purpose);?></textarea>
</div>

<br>

<?php if ($calowner && false) {?> 
<div>
<label for="txtNotes" >Notes:</label>
<textarea cols="35" id="txtNotes" name="txtNotes" rows="2" tabindex="6"><?php echo wassUtil::safeHTML($notes);?></textarea>
</div>

<br>
<?php
}?>

<div id="formdividerShort"></div>

<div style="margin:0px 40px 0px 40px; text-align:left;">If checked, a reminder will be sent to the e-mail address provided. To also receive a text message, enter your cell phone number and provider.</div>

<div>
<label id="lblRemind" for="chkRemind" title="If checked, an email notification and reminder is sent.">Remind:</label>
<input type="checkbox" id="chkRemind" name="chkRemind" value="remind" <?php if ($remchecked) echo ' checked="checked"';?> tabindex="7">
</div>

<br>

<div>
<label for="txtEmail" class="mandat" title="Enter one or more e-mail addresses">E-mail(s):*</label>
<input type="text" id="txtEmail" name="txtEmail" onblur="validateEmail();" value="<?php echo wassUtil::safeHTML($email);?>" size="35" onclick="this.select();" tabindex="8">
</div>

<br>

<div>
<label for="txtTextEmail" title="Enter an e-mail address to have a text sent to your phone">Txt msg E-mail:</label>
<div id="divTextEmailNumber" style="display:inline; padding-left:10px; vertical-align:top;"><?php echo wassUtil::safeHTML($textemail);?></div>
<input type="hidden" id="txtTextEmail" name="txtTextEmail" value="<?php echo wassUtil::safeHTML($textemail);?>" size="35">&nbsp;<img id="btnGenerateTextEmail" src="images/edit_appt.gif" title="Generate Text Message Email from Cell Number and Provider" onclick="openTextMsgEmail('txtTextEmail',GetElement('divTextEmailNumber').innerHTML,GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" class="imgbutton" tabindex="10" />
</div>

<br>

<div class="mandatNote">
<label class="mandat"> Required*</label>
</div>

<br>

<div class="buttonsShort">
<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="Save" tabindex="11" onclick="return checkValidating();">
</div>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</fieldset>

</form>

</body>

</html>


<!--                   End of HTML Code                       -->
<?php
?>