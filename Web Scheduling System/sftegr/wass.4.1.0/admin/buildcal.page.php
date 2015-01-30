<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page allows an administrator to create a calendar for someone else (or for themselves).
 
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


/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}

$_SESSION['authenticated'] = true;
$_SESSION['authtype'] = 'user';
if ($_REQUEST['userid'])
	$_SESSION['authid'] = $_REQUEST['userid'];
else
	$_SESSION['authid'] = wassParms::USER;

/* Init error/inform message text */
$errmsg = ''; $infmsg = '';


/* If we got a calendar id, load the calendar */
$cal = '';


/* 
If calendar exists, load it up, else create a new one
*/

try {
	$cal = new wassCalendar('load',array('userid'=>$_SESSION['authid']));
	$cal_id = $cal->id;
	$exist = true;
} catch (Exception $err) {
	try {
		$cal = new wassCalendar('create', array('userid'=>$_SESSION['authid']));
		$exist = false;
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
}
	
/* Init URL field */
$url = '';


/*
Handle a request to 'save' a calendar.
*/
if (!$errmsg && $_POST['btnSubmit']) {
	
	/* Copy form values into an array */
	$newvals['userid'] = wassUtil::slashstrip(trim($_REQUEST['txtUserid']));
	$newvals['title'] = wassUtil::slashstrip(trim($_REQUEST['txtTitle']));
	$newvals['description'] =  wassUtil::slashstrip(trim($_REQUEST['txtDesc']));
	$newvals['appmsg'] =  wassUtil::slashstrip(trim($_REQUEST['txtAppText']));
	$newvals['name'] = $_REQUEST['txtOwner'];
	$newvals['phone'] = $_REQUEST['txtPhone'];
	$newvals['email'] = $_REQUEST['txtEmail'];
	$newvals['location'] =  wassUtil::slashstrip($_REQUEST['txtLocation']);
	if ($_REQUEST['radManage'] == 'true')
		$newvals['managers'] = trim($_REQUEST['txtMgrUserID']);
	else
		$newvals['managers'] = '';
	$newvals['notify'] = ($_REQUEST['chkNotifyMe'] == 'me') ? 1 : 0;
	$newvals['notifyman'] = ($_REQUEST['chkNotifyMgrs'] == 'manager') ? 1 : 0;
	$newvals['remind'] = ($_REQUEST['chkRemind'] == 'remind') ? 1 : 0;
	$newvals['remindman'] = ($_REQUEST['chkRemindMan'] == 'remind') ? 1 : 0;
	$newvals['viewaccess'] = $_REQUEST['selViewBlockRestr'];
	$newvals['makeaccess'] = $_REQUEST['selMakeApptRestr'];
	$newvals['viewulist'] = implode(',',$_REQUEST['selViewBlocksUserIDList']);
	$newvals['viewclist'] = implode(',',$_REQUEST['selViewBlocksCourseIDList']);
	$newvals['makeulist'] = implode(',',$_REQUEST['selMakeApptUserIDList']);
	$newvals['makeclist'] = implode(',',$_REQUEST['selMakeApptCourseIDList']);
	
	
	/* Save list of current managers, if any */
	$oldmanagers = array();
	if ($cal_id)
		$oldmanagers = explode(',',$cal->managers);
	
	
	
	/* Append the calendarid for an existing calendar:*/
	if ($cal_id)
		$newvals['calendarid'] = $cal->calendarid;
	/* Try to update the calendar */
	try {
		if ($cal_id)
			$cal = new wassCalendar('update',$newvals);
		else
			$cal = new wassCalendar('create',$newvals);
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
	
	/* Save the new calendar or any changes to an old calendar */
	if (!$errmsg) {
		if (!$cal_id) {
			try {
				$cal_id = $cal->save('create');
				/* Notify sysadmin */
				if (wassParms::MAILCAL) {
					mail(wassParms::SYSMAIL,'Calendar created for ' . $cal->userid . ' (' . $cal->name . ')','','From: ' . wassParms::FROMMAIL . "\r\n" );
				}
				$infmsg = "Calendar created.";
				$_SESSION['cal_id'] = $cal_id;
				$_SESSION['owner'] = true;
				if (strtoupper($_SESSION['authid']) == strtoupper($cal->userid))
					$_SESSION['ucal_id'] = $cal_id;
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}
		}
		else {
			try {
				$cal_id = $cal->save('update');
				$infmsg = "Calendar updated.";
				$_SESSION['cal_id'] = $cal_id;
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}			
		}
		
		/* Notify manangers if they have been added or removed */
		if (!$errmsg) {
			
			
			/* Set up msg headers */
			$headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $cal->email . "\r\n" . "Errors-To: " . wassParms::SYSMAIL . "\r\n";	
		
			
			$newmanagers = explode(',',$cal->managers);
			
			/* Notify new managers */
			foreach ($newmanagers as $manager) {
				if (!in_array($manager,$oldmanagers)) {
					mail(wassDirectory::getEmail($manager),'Change calendar in manager status','You have been added as a manager for the calendar of ' . $cal->userid  . ' (' . $cal->name . ')' . "\r\n\r\n--" . wassParms::SYSID,$headers);
				}
			}
			/* Notify removed managers */
			foreach ($oldmanagers as $manager) {
				if (!in_array($manager,$newmanagers)) {
					mail(wassDirectory::getEmail($manager),'Change in calendar manager status','You have been removed as a manager for the calendar of ' . $cal->userid  . ' (' . $cal->name . ')'  . "\r\n\r\n--" . wassParms::SYSID,$headers);			
				}
			}
			
			/* Reset the ismanager status for logged-in user */
			if (wassManager::listManagedids($_SESSION['authid']))
					$_SESSION['ismanager'] = true;	
				else
					$_SESSION['ismanager'] = false;			
			
		}
		
	}
}
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
<script type="text/javascript" language="javascript" src="../pages/js/global.js"></script>
<script type="text/javascript" language="javascript" src="../pages/js/ajax.js"></script>
<script type="text/javascript" language="javascript" src="../pages/js/wasscalendar.js"></script>
<link href="../pages/css/styles.css" rel="stylesheet" type="text/css" />
<link href="../pages/css/print.css" rel="stylesheet" type="text/css"  media="print" />


<script type="text/javascript" language="javascript">	
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.sUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";

// KDC, 8-6-2008. Set up javascript calendars
<?php 
/*
Get a list of all of the calendars owned or managed by the authenticated user.
*/
if ($_SESSION['authtype'] != 'guest')
	$wasscalendars = wassCalendar::wlistAllCalendars($_SESSION['authid']);
else
	$wasscalendars = array();
foreach ($wasscalendars as $wasscal) {
	if (is_object($wasscal)) { ?>
WASSCalendar.G_ARRCALENDARS.push(new WASSCalendar(<?php echo $wasscal->calendarid; ?>,"<?php echo $wasscal->userid; ?>","<?php echo wassUtil::safeHTML($wasscal->name); ?>","<?php echo wassUtil::safeHTML($wasscal->title); ?>",false,"<?php echo wassUtil::safeHTML($wasscal->managers); ?>"));
<?php }
	} ?>

function init() {
	//Set up the Managed section, based on the radio values
	var elMgds = document.getElementsByName("radManage");
	if (elMgds != null) {
		if (elMgds[1].checked == true) {
			ShowManagedFields('show');
		} else {
			ShowManagedFields('hide');
		}
	}
	
	//Set up advanced options section
	ShowHideSection('divAdvancedOptions','hide','linkShowAdv','linkHideAdv','showhide');
	onchangeAdvBlocks();
	onchangeAdvAppts();
	
	//KDC, 9/3/2008. Add Users and Courses to lists in Advanced section
<?php 
	if ($cal->viewaccess == 'restricted') {
		$vulistarr = array();
		if ($cal->viewulist) $vulistarr = explode(",",$cal->viewulist);
		for ($i = 0; $i < sizeof($vulistarr); $i++) { ?>
	AddValueToList("<?php echo $vulistarr[$i] ?>","selViewBlocksUserIDList[]");
	<?php } 
		$vclistarr = array();
		if ($cal->viewclist) $vclistarr = explode(",",$cal->viewclist);
		for ($i = 0; $i < sizeof($vclistarr); $i++) { ?>
	AddValueToList("<?php echo $vclistarr[$i] ?>","selViewBlocksCourseIDList[]");
	<?php } 
	}

	if ($cal->makeaccess == 'restricted') {
		$mulistarr = array();
		if ($cal->makeulist) $mulistarr = explode(",",$cal->makeulist);
		for ($i = 0; $i < sizeof($mulistarr); $i++) { ?>
	AddValueToList("<?php echo $mulistarr[$i] ?>","selMakeApptUserIDList[]");
	<?php } 
		$mclistarr = array();
		if ($cal->makeclist) $mclistarr = explode(",",$cal->makeclist);
		for ($i = 0; $i < sizeof($mclistarr); $i++) { ?>
	AddValueToList("<?php echo $mclistarr[$i] ?>","selMakeApptCourseIDList[]");
	<?php } 
	} ?>

	var elFirst = GetElement("txtTitle");
	if (elFirst != null)
		elFirst.focus();
}

function ShowManagedFields(inShowHide) {
	if (inShowHide == "show") {
		ShowHideElement('divManageEmail','show');
		//GetElement("lblNotifyMgrs").className = "mandatr";
		//GetElement("chkNotifyMgrs").disabled = false;
	} else if (inShowHide == "hide") {
		ShowHideElement('divManageEmail','hide');	
		//GetElement("lblNotifyMgrs").className = "mandatr inactivefield";
		//GetElement("chkNotifyMgrs").disabled = true;
	}
}

function resetAuth() {
	ResetList("selViewBlocksUserIDList[]");
	ResetList("selViewBlocksCourseIDList[]");
	ResetList("selMakeApptUserIDList[]");
	ResetList("selMakeApptCourseIDList[]");
		
	var sel = GetElement("selViewBlockRestr");
	sel.selectedIndex = 0;
	sel = GetElement("selMakeApptRestr");
	sel.selectedIndex = 0;
	onchangeAdvBlocks();
	onchangeAdvAppts();
}

var g_sTextID = "";
var g_sListID = "";
function doValidateUser(inTextID,inListID) {
	g_sTextID = inTextID;
	g_sListID = inListID;
	var arrUsers = new Array();
	var sUser = GetElement(g_sTextID).value;
	if (sUser != "") arrUsers.push(sUser);
	ajax_validateUsers(arrUsers);
}
/* overwrite ajax show function */
function show_validateUsers(arrValidUsers) {
	if (arrValidUsers.length == 0)
		alert("Invalid User");
	else
		AddItemToList(g_sTextID,g_sListID);
	GetElement(g_sTextID).select();
}
function doValidateCourse(inTextID,inListID) {
	g_sTextID = inTextID;
	g_sListID = inListID;
	var arrCourses = new Array();
	var sCourse = GetElement(g_sTextID).value;
	if (sCourse != "") arrCourses.push(sCourse);
	ajax_validateCourses(arrCourses);
}
/* overwrite ajax show function */
function show_validateCourses(arrValidCourses) {
alert("showing");
	if (arrValidCourses.length == 0)
		alert("Invalid Course");
	else
		AddItemToList(g_sTextID,g_sListID);
	GetElement(g_sTextID).select();
}

function validateForm() {
	//Check for required fields
	var strReqdMsg = "Please enter the following required information: \n";
	var strReqdFields = "";
	//Calendar Title
	if (isBlankField("txtTitle"))
		strReqdFields = addToMessage(strReqdFields,"Calendar Title");
	//Calendar Owner's Name
	if (isBlankField("txtOwner"))
		strReqdFields = addToMessage(strReqdFields,"Calendar Owner's Name");
	//Email
	if (isBlankField("txtEmail"))
		strReqdFields = addToMessage(strReqdFields,"Email");
	//Manager User ID (if managed)
	var elRad = document.getElementsByName("radManage");
	if (elRad != null) {
		if (elRad[1].checked == true) {
			if (isBlankField("txtMgrUserID"))
				strReqdFields = addToMessage(strReqdFields,"Manager <?php echo wassParms::NETID;?>");
		}
	}
	//Show the message
	if (trim(strReqdFields) != "") {
		alert(strReqdMsg + strReqdFields);
		return false;
	}
	
	//Validate field format? (phone, email, etc.)
	
	//KDC, 9/3/2008. To select the list items so that they get posted.
	SelectEntireList("selViewBlocksUserIDList[]");
	SelectEntireList("selViewBlocksCourseIDList[]");
	SelectEntireList("selMakeApptUserIDList[]");
	SelectEntireList("selMakeApptCourseIDList[]");
		
	return true;
}
</script>
</head>

<body onload="init();initAjax();">
<form id="frmCalSetup" name="frmCalSetup" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="calendarsetup" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="<?php if ($exist) echo 'Build Calendar'; else echo 'Edit Existing Calendar';?>" />
<input type="hidden" id="hidUserCalendarID" name="hidUserCalendarID" value="<?php echo $cal_id;?>" />
<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />


<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $cal_id;?>" />

<input type="hidden" id="helptopic" name="helptopic" value="basic" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTNAME);?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTEMAIL);?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTPHONE);?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassUtil::safeHTML(wassParms::INSFNAME);?>" />
<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />


<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="../pages/js/header.js"></script>
<script type="text/javascript" language="javascript" src="../pages/js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content">
<table cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" class="menuTD">
		<!-- MAIN MENU - BEGIN -->
		
		<!-- MAIN MENU - END -->
	</td>
    <td align="left" valign="top">
		<div id="contentDivider">

			<fieldset>
<?php
if ($errmsg) { ?>
	<div id="error" style="width:530px;_width:560px;"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm" style="width:530px;_width:560px;"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>			  
	
<div>
<label id="lblUserid" for="txtUserid" class="mandat" title="The userid of the calendar owner.">Calendar Userid:*</label>
<input type="text" id="txtUserid" name="txtUserid" tabindex="1" value="<?php echo wassUtil::safeHTML($cal->userid);?>" size="20">
</div>

<br>    
    
    
<div>
<label id="lblTitle" for="txtTitle" class="mandat" title="The title of your Calendar.">Calendar Title:*</label>
<input type="text" id="txtTitle" name="txtTitle" tabindex="1" value="<?php echo wassUtil::safeHTML($cal->title);?>" size="50">
</div>

<br>

<div>
<label id="lblOwner" for="txtOwner" class="mandat" title="The name of the Calendar Owner.">Calendar Owner's Name:*</label>
<input type="text" id="txtOwner" name="txtOwner" tabindex="2" value="<?php echo wassUtil::safeHTML($cal->name);?>" size="35">
</div>

<br>

<div>
<label id="lblPhone" for="txtPhone" title="The telephone number of the Calendar owner.">Telephone:</label>
<input type="text" id="txtPhone" name="txtPhone" tabindex="3" value="<?php echo wassUtil::safeHTML($cal->phone);?>" size="12">
</div>

<br>

<div>
<label id="lblEmail" for="txtEmail" class="mandat" title="The e-mail address of the Calendar owner.">E-mail:*</label>
<input type="text" id="txtEmail" name="txtEmail" tabindex="4" value="<?php echo wassUtil::safeHTML($cal->email);?>">
</div>

<br>

<div>
<label id="lblDesc" for="txtDesc" title="A description of the purpose of the Calendar.">Description:</label>
<textarea id="txtDesc" name="txtDesc" tabindex="5" rows="2" cols="35"><?php echo wassUtil::safeHTML($cal->description);?></textarea>
</div>

<br>

<div>
<label id="lblLocation" for="txtLocation" title="Where the appointments take place. This can change on an individual block basis.">Location:</label>
<input type="text" id="txtLocation" name="txtLocation" tabindex="6" value="<?php echo wassUtil::safeHTML($cal->location);?>">
</div>

<br>

<div>
<label id="lblRemind" for="chkRemind" title="If checked, the calendar owner will be sent a reminder email of any appointments (default).">Remind Calendar Owner:</label>
<input type="checkbox" id="chkRemind" name="chkRemind" tabindex="7" value="remind" <?php if ($cal->remind) echo ' checked="checked"';?>>
</div>

<br>

<div>
<label id="lblRemindMan" for="chkRemindMan" title="If checked, the calendar managers will be sent a reminder email of any appointments (default).">Remind Calendar Managers:</label>
<input type="checkbox" id="chkRemindMan" name="chkRemindMan" tabindex="8" value="remind" <?php if ($cal->remindman) echo ' checked="checked"';?>>
</div>

<br>


<div>
<label id="lblAppText" for="txtAppText" title="Text to include in appointment notifications and reminders.">Text for appointment emails:</label>
<textarea id="txtAppText" name="txtAppText" tabindex="9" rows="3" cols="35"><?php echo wassUtil::safeHTML($cal->appmsg);?></textarea>
</div>

<br>


<div id="formdividerSub"></div>

<div class="cr" title="If you allow someone else to manage your calendar, select Yes. Then enter their <?php echo wassParms::NETID;?> below.">
<p id="pManagedLabel" title="If you allow someone else to manage your calendar, select Yes. Then enter their <?php echo wassParms::NETID;?> below.">Managed:</p>
<label><input type="radio" name="radManage" tabindex="10" onclick="ShowManagedFields('hide');" value="false" <?php if (!$cal->managers) echo 'checked="checked"'?>> No</label>
<label style="_margin-left:183px;"><input type="radio" name="radManage" tabindex="11" onclick="ShowManagedFields('show');" value="true"  <?php if ($cal->managers) echo 'checked="checked"'?>> Yes</label>
</div>

<br>
<div id="divManageEmail" class="hiddenfield">
<label id="lblMgrUserID" for="txtMgrUserID" class="mandat" title="A <?php echo wassParms::NETID;?> is usually the name before the @ in their e-mail address."><?php echo wassParms::NETID;?>:*</label>
<input type="text" id="txtMgrUserID" name="txtMgrUserID" tabindex="12" value="<?php echo wassUtil::safeHTML($cal->managers);?>">&nbsp;Separate multiple <?php echo wassParms::NETID;?>'s with commas.
</div>

<br>
<div id="formdividerSub"></div>

<div class="cr">
<p id="pNotifyWhoLabel" title="If you check the box(s) an e-mail notification will be sent.">Notification:</p>
<label title="An e-mail will be sent to you."><input type="checkbox" id="chkNotifyMe" name="chkNotifyMe" tabindex="13" value="me" <?php if ($cal->notify) echo ' checked="checked"';?>> Calendar Owner</label>
<label class="mandatr" style="_margin-left:183px;" id="lblNotifyMgrs" title="An e-mail will be sent to your manager(s)."><input type="checkbox" id="chkNotifyMgrs" name="chkNotifyMgrs" tabindex="14" value="manager" <?php if ($cal->notifyman) echo ' checked="checked"';?>> Calendar Manager(s)</label>
</div>

<div id="formdividerSub"></div>


<div id="formURLArea">
<?php if ($url) {?>

<label id="lblURL" title="The URL people use to make an appointment on this calendar.">Calendar URL:</label>
<b style="margin-left:10px;"}><?php echo $url?></b>
<p class="descriptionText">Post this URL on a website, bookmark it, or include in an e-mail. Users, after logging in, will be brought directly to this calendar to make appointments.</p>

<?php 
}?>
</div>




<div id="formdivider" style="margin-bottom:5px;"></div>
	<span class="labelLarge">Advanced Options:</span><a href="#" id="linkHideAdv" class="showhide_off" tabindex="15" onclick="ShowHideSection('divAdvancedOptions','hide','linkShowAdv','linkHideAdv','showhide'); return false;">Hide</a><a href="#" id="linkShowAdv" class="showhide_on" tabindex="16" onclick="ShowHideSection('divAdvancedOptions','show','linkShowAdv','linkHideAdv','showhide'); return false;">Show</a>

<br>

<div id="divAdvancedOptions">

<div>
<input type="hidden" id="hidLimitedDomain" name="hidLimitedDomain" value="<?php echo wassUtil::safeHTML(wassParms::INSNAME);?>" />
<label for="selViewBlockRestr" title="Select who you will allow to view the Calendar.">View Calendar:</label>
<select id="selViewBlockRestr" name="selViewBlockRestr" tabindex="17" onchange="onchangeAdvBlocks();">
<option value="open" <?php if ($cal->viewaccess == 'open') echo 'selected="selected"';?>>Open</option>
<option value="limited" <?php if ($cal->viewaccess == 'limited') echo 'selected="selected"';?>>Limited</option>
<option value="restricted" <?php if ($cal->viewaccess == 'restricted') echo 'selected="selected"';?>>Restricted</option>
<option value="private" <?php if ($cal->viewaccess == 'private') echo 'selected="selected"';?>>Private</option>
</select>&nbsp;<div id="divViewBlockRestrDesc" style="display:inline;"></div>
</div>

<div id="divViewBlockRestr" class="authorized">
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter <?php echo wassParms::NETID;?></p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksUserID" name="txtViewBlocksUserID" value="" tabindex="18"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtViewBlocksUserID','selViewBlocksUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksUserIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksUserIDList[]" name="selViewBlocksUserIDList[]" class="listBox" size="4" multiple tabindex="19" >
			<option></option>
		</select></td>
  </tr>
</table>

<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course name</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksCourseID" name="txtViewBlocksCourseID" value="" tabindex="20"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtViewBlocksCourseID','selViewBlocksCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksCourseIDList[]" name="selViewBlocksCourseIDList[]" class="listBox" size="4" multiple tabindex="21" >
			<option></option>
		</select></td>
  </tr>
</table>
</div>

<div id="formdividerSub"></div>
<br>

<div>
<label for="selMakeApptRestr" title="Select who you will allow to make appointments on the Calendar.">Make Appointments:</label>
<select id="selMakeApptRestr" name="selMakeApptRestr" tabindex="22" onchange="onchangeAdvAppts();">
<option value="open" <?php if ($cal->makeaccess == 'open') echo 'selected="selected"';?>>Open</option>
<option value="limited" <?php if ($cal->makeaccess == 'limited') echo 'selected="selected"';?>>Limited</option>
<option value="restricted" <?php if ($cal->makeaccess == 'restricted') echo 'selected="selected"';?>>Restricted</option>
<option value="private" <?php if ($cal->makeaccess == 'private') echo 'selected="selected"';?>>Private</option>
</select>&nbsp;<div id="divMakeApptRestrDesc" style="display:inline;">stuff</div>
</div>

<div id="divMakeApptRestr" class="authorized">
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter <?php echo wassParms::NETID;?></p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptUserID" name="txtMakeApptUserID" value="" tabindex="23"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtMakeApptUserID','selMakeApptUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptUserIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptUserIDList[]" name="selMakeApptUserIDList[]" class="listBox" size="4" multiple tabindex="24" >
			<option></option>
		</select></td>
  </tr>
</table>

<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course name</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptCourseID" name="txtMakeApptCourseID" value="" tabindex="25"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtMakeApptCourseID','selMakeApptCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptCourseIDList[]" name="selMakeApptCourseIDList[]" class="listBox" size="4" multiple tabindex="26" >
			<option></option>
		</select></td>
  </tr>
</table>
</div>

</div>

<div class="mandatNote">
<label class="mandat" title="Required information is indicated by an asterisk."> Required*</label>
</div>

<br>

<div class="buttons">
<input type="reset" id="btnReset" name="btnReset" value="Clear Form" tabindex="27" class="button1" onclick="resetAuth();">
<input type="submit" id="btnSubmit" name="btnSubmit" value="Save" tabindex="28" class="button1" onclick="return validateForm();">
</div>


			</fieldset>

		  </div>
		</td>
	</tr>
</table>


<!-- *** PHP *** -->
<!-- Remove appears only if calendar exists, not if this is the first time creating -->
<!-- also, put the calendar id for cal_id= below -->
<?php if ($cal_id) {?>
	<div id="removeCalendar"><strong>Remove Calendar</strong><br>
	  Remove this calendar from the system and cancel any appointments associated with it.<br><br> 
		<input type="button" id="btnRemoveCalendar" name="btnRemoveCalendar" value="Remove" tabindex="29" class="button2" onclick="OpenWin('removecal.page.php?cal_id=<?php echo $cal->calendarid;?>',500,300);"><br><br>
	</div>
    
    <div id="grantCalendar"><strong>Calendar's Manager(s)</strong><br>
      If you want someone else to manage your calendar or remove them as your calendar's manager, click Go and follow the instructions.<br><br> 
        <input type="button" id="btnGrant" name="btnGrant" value="Go" tabindex="30" class="button2" onclick="OpenWin('grant.page.php?cal_id=' + GetElement('cal_id').value,500,520);"><br><br>
	</div><?php 
}?>


<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->


</form>
</body>
</html>

<!--                   End of HTML Code                       -->
<?php

?>
