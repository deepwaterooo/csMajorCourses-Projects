<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page allows users to set the properties of their calendars.  These properties are used as defaults when creating blocks.
		Users can also remove their calendar entirely or apply to manage someone else's calendar.
		AJAX is incorporated to validate userIDs and courseIDs in the Advanced Options section.
		Notable GET (and POST) arguments:
			- cal_id: the calendar ID of the calendar whose setup page should be shown.  If no cal_id, use the logged-in user.

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


/* Save passed cal_id (if any) */
$cal_id = $_REQUEST['cal_id'];
if (!$cal_id) {
	if (!isset($cal_id))
		$cal_id = $_SESSION['cal_id'];
} else {
	$_SESSION['cal_id'] = $cal_id;
}

 
/* Save if request is to create an additional calendar */
if ($cal_id) {
  if ($_REQUEST['addcal'])
	  $addcal = true;
  else
	  $addcal = false;
}
else 
	$addcal = false;


/* Init error/inform message text */
$errmsg = ''; $infmsg = '';


/* If we got a calendar id, load the calendar */
$cal = false; $futureblocks = 0; 
if ($cal_id) {
	try {
		$cal = new wassCalendar('load',array('calendarid'=>$cal_id));
	} catch (Exception $err) {
		$cal = false;
		$errmsg = $err->getMessage();
		$cal_id = '';
	}
	/* Check authentication */
	if ($cal) {
		if (!$cal->isOwnerOrManager($_SESSION['authtype'],$_SESSION['authid'])) {
			/* We should not be here.  Try to setup user's own calendar, if they have one */
			$mycals = wassCalendar::wlistOwnedCalendars($_SESSION['authid']);
			if ($mycals->entries()) {
				$cal = $mycals->next();
				$cal_id = $cal->calendarid;
				$addcal = false;
			}
			else {
				$cal = false;
				$cal_id = '';
				$addcal = false;
			}
		}
		$_SESSION['cal_id'] = $cal_id;
	}
}
/* Guests cannot create a calendar */
else {
	if ($_SESSION['authtype'] == 'guest') {
		$cal = false;
		$errmsg = 'Guest may not create/edit calendars.';
	}
}

/* If we are adding an additional calendar, save the old one, and make it look like we don't have one */
if (!$errmsg && $addcal && $cal) {
	$oldcal = $cal;
	$cal = '';
	$cal_id = '';
	$pagetitle = 'Calendar Setup';
	$pagesubtitle = 'Creating Additional Calendar for ' . $oldcal->userid . ' (' . $oldcal->name . ')';
}


/*
If user has no calendar at all, or is creating an additional calendar, set defaults for values of a new calendar.
*/
if (!$errmsg && !$cal) {
	try {
		if ($addcal) {
			$cal = new wassCalendar('create', array('userid'=>$oldcal->userid,'title'=>'*** Replace this with a Calendar title ***'));
		}
		else {
			$title = wassUtil::slashstrip(trim($_REQUEST['txtTitle']));
			if (!$title) {
				$name = wassDirectory::getName($_SESSION['authid']);
				if (!$name) $name = $_SESSION['authid'];
				$title = 'Calendar for ' . $name;
			}
			$cal = new wassCalendar('create', array('userid'=>$_SESSION['authid'],'title'=>$title));
			$pagetitle = 'Calendar Setup';
			$pagesubtitle = 'Creating Calendar for ' . $cal->userid . ' (' . $cal->name . ')';
		}
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
}
/* If user has a calendar, see if that calendar has any future blocks scheduled */
else {
	$today = date('Y-m-d');
	$now = date('H:i') . ':00';	
	$blocklist = wassBlock::listMatchingBlocks(array('calendarid'=>$cal->calendarid,
					'date,>,OR'=>$today,
					  'date,=,AND,('=>$today,
					  'starttime,>,AND,)'=>$now));
	$futureblocks = $blocklist->entries();
}

/* Assume no display URLs */
$url = ''; $surl = ''; $rssurl = '';

/* Generate URL for making appointments and for subscribing */
if (!$errmsg && $cal_id) {
	/* Generate display URLs */
	makeURLs($cal);

	$pagetitle = 'Calendar Setup';
	$pagesubtitle = 'Editing Calendar for ' . $cal->userid . ' (' . $cal->name . ')';
}



/*
Handle a request to 'save' or 'create' a calendar.
*/

if (!$errmsg && ($_POST['btnSubmit'] || $_POST['hidSubmitForm'])) {

	/* Copy form values into an array */

	$newvals['title'] = wassUtil::slashstrip(trim($_REQUEST['txtTitle']));
	$newvals['description'] =  wassUtil::slashstrip(trim($_REQUEST['txtDesc']));
	$newvals['appmsg'] =  wassUtil::slashstrip(trim($_REQUEST['txtAppText']));
/*	$newvals['userid'] = $cal->userid;*/
	$newvals['userid'] = $_REQUEST['userid'];
	$newvals['name'] = $_REQUEST['txtOwner'];
	$newvals['phone'] = $_REQUEST['txtPhone'];
	$newvals['email'] = $_REQUEST['txtEmail'];
	$newvals['location'] =  wassUtil::slashstrip($_REQUEST['txtLocation']);
	/* if ($_REQUEST['radManage'] == 'true')
		$newvals['managers'] = trim($_REQUEST['txtMgrUserID']);
	else
		$newvals['managers'] = '';
	*/
	$newvals['notify'] = ($_REQUEST['chkNotifyMe'] == 'me') ? 1 : 0;
	$newvals['notifyman'] = ($_REQUEST['chkNotifyMgrs'] == 'manager') ? 1 : 0;
	$newvals['remind'] = ($_REQUEST['chkRemind'] == 'remind') ? 1 : 0;
	$newvals['remindman'] = ($_REQUEST['chkRemindMan'] == 'remind') ? 1 : 0;
	$newvals['showappinfo'] = ($_REQUEST['chkShowAppInfo'] == 'show') ? 1 : 0;
	/* Ignore group setting if an existing calendar */
	if (!$cal_id)
		$newvals['group'] = ($_REQUEST['chkGroupCal'] == 'groupcal') ? 1 : 0;
	$newvals['viewaccess'] = $_REQUEST['selViewBlockRestr'];
	$newvals['makeaccess'] = $_REQUEST['selMakeApptRestr'];
	$newvals['viewulist'] = @implode(',',$_REQUEST['selViewBlocksUserIDList']);
	$newvals['viewclist'] = @implode(',',$_REQUEST['selViewBlocksCourseIDList']);
	$newvals['makeulist'] = @implode(',',$_REQUEST['selMakeApptUserIDList']);
	$newvals['makeclist'] = @implode(',',$_REQUEST['selMakeApptCourseIDList']);
	$newvals['overlapok'] = ($_REQUEST['chkAllowOverlap'] == 'allowoverlap') ? 1 : 0;

	/* Keep track of any changes we might need to make to existing blocks */
	
	if ($cal_id) {
		/* Init variable to keep track of block changes */
		$setlist = '';
		/* Save changes in SQL update format */
		if ($newvals['title'] != $cal->title) $setlist .= 'title=' . wassSQL::sqlSafe($newvals['title']) . ', ';
		if ($newvals['description'] != $cal->description) $setlist .= 'description=' . wassSQL::sqlSafe($newvals['description']) . ', ';
		if ($newvals['appmsg'] != $cal->appmsg) $setlist .= 'appmsg=' . wassSQL::sqlSafe($newvals['appmsg']) . ', ';
		if ($newvals['userid'] != $cal->userid) $setlist .= 'userid=' . wassSQL::sqlSafe($newvals['userid']) . ', ';
		if ($newvals['name'] != $cal->name) $setlist .= 'name=' . wassSQL::sqlSafe($newvals['name']) . ', ';
		if ($newvals['phone'] != $cal->phone) $setlist .= 'phone=' . wassSQL::sqlSafe($newvals['phone']) . ', ';
		if ($newvals['email'] != $cal->email) $setlist .= 'email=' . wassSQL::sqlSafe($newvals['email']) . ', ';
		if ($newvals['location'] != $cal->location) $setlist .= 'location=' . wassSQL::sqlSafe($newvals['location']) . ', ';
		if ($newvals['notify'] != $cal->notify) $setlist .= 'notify=' . wassSQL::sqlSafe($newvals['notify']) . ', ';
		if ($newvals['notifyman'] != $cal->notifyman) $setlist .= 'notifyman=' . wassSQL::sqlSafe($newvals['notifyman']) . ', ';
		if ($newvals['remind'] != $cal->remind) $setlist .= 'remind=' . wassSQL::sqlSafe($newvals['remind']) . ', ';
		if ($newvals['remindman'] != $cal->remindman) $setlist .= 'remindman=' . wassSQL::sqlSafe($newvals['remindman']) . ', ';
		if ($newvals['showappinfo'] != $cal->showappinfo) $setlist .= 'showappinfo=' . wassSQL::sqlSafe($newvals['showappinfo']) . ', ';
		if ($newvals['viewaccess'] != $cal->viewaccess) $setlist .= 'viewaccess=' . wassSQL::sqlSafe($newvals['viewaccess']) . ', ';
		if ($newvals['makeaccess'] != $cal->makeaccess) $setlist .= 'makeaccess=' . wassSQL::sqlSafe($newvals['makeaccess']) . ', ';
		if ($newvals['viewulist'] != $cal->viewulist) $setlist .= 'viewulist=' . wassSQL::sqlSafe($newvals['viewulist']) . ', ';
		if ($newvals['viewclist'] != $cal->viewclist) $setlist .= 'viewclist=' . wassSQL::sqlSafe($newvals['viewclist']) . ', ';
		if ($newvals['makeulist'] != $cal->makeulist) $setlist .= 'makeulist=' . wassSQL::sqlSafe($newvals['makeulist']) . ', ';
		if ($newvals['makeclist'] != $cal->makeclist) $setlist .= 'makeclist=' . wassSQL::sqlSafe($newvals['makeclist']) . ', ';
		if ($newvals['overlapok'] != $cal->overlapok) $setlist .= 'overlapok=' . (($newvals['overlapok'] == 'allowoverlap') ? 1 : 0) . ', ';
		
		if ($setlist)
			$setlist = substr($setlist,0,-2);	
	}


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
				if ($cal->group)
					$header = 'Group calendar';
				else
					$header = 'Calendar';
					
				$cal_id = $cal->save('create');
				/* Notify sysadmin */
				if (wassParms::MAILCAL) {
					mail(wassParms::SYSMAIL,$header . ' created for ' . $cal->userid . ' (' . $cal->name . ')','','From: ' . wassParms::FROMMAIL . "\r\n" );
				}
				$infmsg = $header . ' created.  To add blocks of available time to your calendar, click on View Calendar, then click on Add Block(s).';
				$_SESSION['cal_id'] = $cal_id;
				$_SESSION['owner'] = true;
				
				if (strtoupper($_SESSION['authid']) == strtoupper($cal->userid)) {
					/* We only set $_SESSION['ucal_id'] if the user has only 1 calendar:
					
					NO:  for now we set to first built calendar. */
					if (count(wassCalendar::arrayOwnedCalendarids($cal->userid)) > 1)
						$_SESSION['ucal_id'] = $cal_id;
					else
						$_SESSION['ucal_id'] = $cal_id;
				}
				else {
					/* User is creating calendar for someone else; make logged in user a manager for the new calendar */
					wassManager::addManager($cal_id,trim($_SESSION['authid']),'user',1,1);
				}
				
				/* Generate display URLs */
				makeURLs($cal);
					
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}
		}
		else {
			try {
				$cal_id = $cal->save('update');
				/* Propagate changes to the blocks */
				
				if ($setlist && $_REQUEST['propagate']) {
					$today = date('Y-m-d');
					$now = date('h:m') . ':00';
					wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassBlock SET ' . $setlist . 
									 ' WHERE (calendarid=' . $cal-> calendarid . ' AND (date >= ' . wassSQL::sqlSafe($today) . ' OR (date=' .  wassSQL::sqlSafe($today) . ' AND starttime>' . wassSQL::sqlSafe($now) . ')));');
					$infmsg = "Calendar and blocks updated.";		
				}
				else 
					$infmsg = "Calendar updated.";
				$_SESSION['cal_id'] = $cal_id;
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}
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
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
<script type="text/javascript" language="javascript" src="js/wasscalendar.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/print.css" rel="stylesheet" type="text/css"  media="print" />


<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";
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
WASSCalendar.G_ARRCALENDARS.push(new WASSCalendar(<?php echo $wasscal->calendarid; ?>,"<?php echo $wasscal->userid; ?>","<?php echo wassUtil::safeHTML($wasscal->name); ?>","<?php echo wassUtil::safeHTML($wasscal->title); ?>",<?php echo wassUtil::safeHTML($wasscal->group); ?>,"<?php echo wassUtil::safeHTML(wassManager::listActiveManagers($wasscal->calendarid)); ?>"));
<?php }
	} ?>

function init() {
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
	
	ajax_getDidYouKnow();

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
	if (arrValidCourses.length == 0)
		alert("Invalid Course");
	else
		AddItemToList(g_sTextID,g_sListID);
	GetElement(g_sTextID).select();
}

function showMessage(inID) {
	if (inID == "chkShowAppInfo") {
		alert("If you check this box, then, by default, anyone viewing your calendar will be able to see the full name, e-mail address and telephone number of everyone who has made an appointment in this calendar.  In other words, there will be no privacy associated with appointments made in this calendar.  If that is what you want, then leave the box checked.  If not, uncheck the box.");
	}
}

//KDC, 2-18-2009. For submitting via javascript
g_isSubmitted = false;

function validateForm() {
//alert("validating form");
		//KDC, 9/3/2008. To select the list items so that they get posted.
		SelectEntireList("selViewBlocksUserIDList[]");
		SelectEntireList("selViewBlocksCourseIDList[]");
		SelectEntireList("selMakeApptUserIDList[]");
		SelectEntireList("selMakeApptCourseIDList[]");

	if (!g_isSubmitted) {
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
		//var elRad = document.getElementsByName("radManage");
		//if (elRad != null && elRad.length > 0) {
		//	if (elRad[1].checked == true) {
		//		if (isBlankField("txtMgrUserID"))
		//			strReqdFields = addToMessage(strReqdFields,"<?php echo ($cal->group)? 'Member':'Manager';?> <?php echo wassParms::NETID;?>");
		//	}
		//}
		//Show the message
		if (trim(strReqdFields) != "") {
			alert(strReqdMsg + strReqdFields);
			return false;
		}
	
		//Validate field format? (phone, email, etc.)
	
		//SERGE, 2/13/2009.  Ask user if changes should be proagated to blocks.
		GetElement("propagate").value='0';
		var isoldcal = GetElement("cal_id").value;
		var futureblocks = GetElement("hidFutureBlocks").value;
		if (isoldcal != '' && futureblocks > 0) {
			//open window to ask about propagate
			OpenWin("propagatemsg.page.php",430,220,"scrollbars=yes,resizeable=yes");
			return false; //open window will submit form via doSubmit() below
		}
		else {
			//doSubmit(); //KDC, 3-2-2010. For AJAX call to validate email, need to submit this way do to asynch.
			yesSubmit();
		}
	}
	else {
//			alert("about to do submit2");
//		doSubmit(); //KDC, 3-2-2010. For AJAX call to validate email, need to submit this way do to asynch.
		yesSubmit();
	}
}
function yesSubmit() {
	GetElement("hidSubmitForm").value = true;
	submitForm();
}
//KDC, 9-23-2010. Validate email address
var isValidating = false;
var isSubmitting = false;
function doSubmitPrep() {
///	console.log("IN SUBMIT PREP");
	validateForm();
}
function validateEmail() {
	doValidateEmail();
}

function doSubmit() {
	g_isSubmitted = true;
	//alert(GetElement("propagate").value);
	//document.frmCalSetup.submit();
	GetElement("btnSubmit").click();
}
</script>
</head>

<body onload="initAjax();init();">
<form id="frmCalSetup" name="frmCalSetup" action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="calendarsetup" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="<?php echo $pagetitle;?>" />
<input type="hidden" id="hidPageSubtitle" name="hidPageSubtitle" value="<?php echo $pagesubtitle;?>" />
<input type="hidden" id="hidFutureBlocks" name="hidFutureBlocks" value="<?php echo $futureblocks;?>" />
<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />

<input type="hidden" id="hidUCal_id" name="hidUCal_id" value="<?php echo $_SESSION['ucal_id'];?>" />

<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $cal_id;?>" />
<input type="hidden" id="userid" name="userid" value="<?php echo $cal->userid;?>" />

<input type="hidden" id="helptopic" name="helptopic" value="basic" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTNAME);?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTEMAIL);?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassUtil::safeHTML(wassParms::CONTACTPHONE);?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassUtil::safeHTML(wassParms::INSFNAME);?>" />
<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />
<input type="hidden" id="propagate" name="propagate" />

<input type="hidden" id="hidDYKHeader" name="hidDYKHeader" value="" />
<input type="hidden" id="hidDYKDetails" name="hidDYKDetails" value="" />

<input type="hidden" id="hidSubmitForm" name="hidSubmitForm" value="false" />

<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/header.js"></script>
<script type="text/javascript" language="javascript" src="js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content">
<table cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" class="menuTD">
		<!-- MAIN MENU - BEGIN -->
		<script type="text/javascript" language="javascript" src="js/mainmenu.js"></script>
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
<div class="formSectionTitle" style="width:550px;">Calendar Settings</div>

<div>
<label id="lblTitle" for="txtTitle" class="mandat" title="The title of your Calendar." >Calendar Title*</label>
<input type="text" id="txtTitle" name="txtTitle" tabindex="1" value="<?php echo wassUtil::safeHTML($cal->title);?>" size="50">
</div>

<br>

<div>
<label for="chkGroupCal" title="See help (?) for group calendars.  You cannot change this setting once the calendar is already created.">Group Calendar: </label>
<?php if ($cal_id == '') { ?>
<input type="checkbox" id="chkGroupCal" name="chkGroupCal" tabindex="2" value="groupcal" <?php if ($cal->group) echo ' checked="checked"'; if ($cal_id != '') echo ' disabled="disabled"';?>>
<?php } else { 
			if ($cal->group) echo '<div style="width:30px;text-align:center;float:left;padding:0px 5px 5px 5px;margin:0px 0px 0px 0px;position:relative;top:0px;"> Yes</div>'; 
			else echo '<div style="width:30px;text-align:center;float:left;padding:0px 5px 5px 5px;margin:0px 0px 0px 0px;position:relative;top:0px;"> No</div>'; ?>
<?php } ?>
<a href="#" onclick='openHelp("groupcal",true);return false;' title='Help' ><img src="images/Q1.gif" alt="Help" border="0" /></a>
</div>

<div>
<label for="chkAllowOverlap" title="Allow blocks on this calendar to overlap blocks with the same owner on another calendar." >Allow Block Overlap On Calendars with Same Owner</label>
<input type="checkbox" id="chkAllowOverlap" name="chkAllowOverlap" tabindex="3" value="allowoverlap" <?php if ($cal->overlapok) echo ' checked="checked"' ?>>
</div>
</fieldset>


<!-- BEGIN URL AREA -->
<div id="URLArea">
<?php if ($url) {?>
<div class="URLTitle">Calendar URL (for Appointment Makers)</div>
<div class="URLHelp"><a href="#" onclick='openHelp("advertise",true);return false;' title='Help'><img src="images/Q1.gif" alt="Help" border="0" /></a></div>
<div class="URLText"><?php echo $url?></div>
<?php
}?>
<br>
<?php if ($surl) {?>
<div class="URLTitle">Subscription URL (for Owners and <?php echo ($cal->group)? 'Members':'Managers';?>)</div>
<div class="URLHelp"><a href="#" onclick='openHelp("subscribe",true);return false;' title='Help' ><img src="images/Q1.gif" alt="Help" border="0" /></a></div>
<div class="URLText"><?php echo $surl?></div>
<?php
}?>
<br>
<?php if ($surl) {?>
<div class="URLTitle">RSS Feed (for Owners and <?php echo ($cal->group)? 'Members':'Managers';?> and Appointment Makers)</div>
<div class="URLHelp"><a href="#" onclick='openHelp("subscriberss",true);return false;' title='Help' ><img src="images/Q1.gif" alt="Help" border="0" /></a></div>
<div class="URLText"><?php echo $rssurl?></div>
<?php
}?>
</div>
<!-- END URL AREA-->


<fieldset>
<div class="formSectionTitle" style="width:550px;">Default Block Settings</div>
<p style="width:540px; color:#666; margin-bottom:15px; margin-top:3px; _padding-left:25px; padding-left:10px;">The settings below will be used as default values when you add new blocks to your calendar. You can override them when you Add/Edit blocks.</p>

<div>
<label id="lblOwner" for="txtOwner" class="mandat" title="The name of the Calendar Owner.">Calendar Owner's Name*</label>
<input type="text" id="txtOwner" name="txtOwner" tabindex="5" value="<?php echo wassUtil::safeHTML($cal->name);?>" size="35">
</div>

<br>

<div>
<label id="lblPhone" for="txtPhone" title="The telephone number of the Calendar owner.">Telephone</label>
<input type="text" id="txtPhone" name="txtPhone" tabindex="6" value="<?php echo wassUtil::safeHTML($cal->phone);?>" size="12">
</div>

<br>

<div>
<label id="lblEmail" for="txtEmail" class="mandat" title="The e-mail address of the Calendar owner.">E-mail*</label>
<input type="text" id="txtEmail" name="txtEmail" tabindex="7"  onblur="validateEmail();" value="<?php echo wassUtil::safeHTML($cal->email);?>">
</div>

<br>

<div>
<label id="lblDesc" for="txtDesc" title="A description of the purpose of the Calendar.">Description</label>
<textarea id="txtDesc" name="txtDesc" tabindex="8" rows="2" cols="35"><?php echo wassUtil::safeHTML($cal->description);?></textarea>
</div>

<br>

<div>
<label id="lblLocation" for="txtLocation" title="Where the appointments take place. This can change on an individual block basis.">Location</label>
<input type="text" id="txtLocation" name="txtLocation" tabindex="9" value="<?php echo wassUtil::safeHTML($cal->location);?>">
</div>

<div id="formdividerSub"></div>

<div>
<label for="chkNotifyMe" title="If checked, the calendar owner will be sent email when an appointment is made or cancelled.">
Notify Calendar Owner</label>
<input type="checkbox" id="chkNotifyMe" name="chkNotifyMe" tabindex="10" value="me" <?php if ($cal->notify) echo ' checked="checked"';?>>
</div>

<br />

<div>
<label for="chkNotifyMgrs" id="lblNotifyMgrs" title="If checked, the calendar <?php echo ($cal->group)? 'members':'managers';?> (if any) will be sent email when an appointment is made or cancelled.">
Notify Calendar <?php echo ($cal->group)? 'Members':'Managers';?></label>
<input type="checkbox" id="chkNotifyMgrs" name="chkNotifyMgrs" tabindex="11" value="manager" <?php if ($cal->notifyman) echo ' checked="checked"';?>>
</div>

<div id="formdividerSub"></div>

<div>
<label id="lblRemind" for="chkRemind" title="If checked, the calendar owner will be sent a reminder email of any appointments (default).">Remind Calendar Owner</label>
<input type="checkbox" id="chkRemind" name="chkRemind" tabindex="12" value="remind" <?php if ($cal->remind) echo ' checked="checked"';?>>
</div>

<br>

<div>
<label id="lblRemindMan" for="chkRemindMan" title="If checked, the calendar <?php echo ($cal->group)? 'members':'managers';?> will be sent a reminder email of any appointments (default).">Remind Calendar <?php echo ($cal->group)? 'Members':'Managers';?></label>
<input type="checkbox" id="chkRemindMan" name="chkRemindMan" tabindex="13" value="remind" <?php if ($cal->remindman) echo ' checked="checked"';?>>
</div>

<div id="formdividerSub"></div>

<div>
<label id="lblAppText" for="txtAppText" title="Text to include in appointment notifications and reminders.">Supplemental Text for appointment e-mail</label>
<textarea id="txtAppText" name="txtAppText" tabindex="15" rows="3" cols="35"><?php echo wassUtil::safeHTML($cal->appmsg);?></textarea>
</div>

<br>


<div id="formdivider" style="margin-bottom:5px;"></div>
	<span class="labelLarge">Access Restrictions:</span><a href="#" id="linkHideAdv" class="showhide_off" tabindex="16" onclick="ShowHideSection('divAdvancedOptions','hide','linkShowAdv','linkHideAdv','showhide'); return false;">Hide</a><a href="#" id="linkShowAdv" class="showhide_on" tabindex="17" onclick="ShowHideSection('divAdvancedOptions','show','linkShowAdv','linkHideAdv','showhide'); return false;">Show</a>
<a href="#" onclick='openHelp("advanced",true);return false;' title='Help' ><img src="images/Q1.gif" alt="Help" border="0" /></a>
<br>

<div id="divAdvancedOptions">

<div>
<input type="hidden" id="hidLimitedDomain" name="hidLimitedDomain" value="<?php echo wassUtil::safeHTML(wassParms::INSNAME);?>" />
<input type="hidden" id="hidNetIDParms" name="hidNetIDParms" value="<?php echo wassParms::NETID;?>" />
<label for="selViewBlockRestr" title="Select who you will allow to view the Calendar.">View Calendar</label>
<select id="selViewBlockRestr" name="selViewBlockRestr" tabindex="18" onchange="onchangeAdvBlocks();">
<option value="open" <?php if ($cal->viewaccess == 'open') echo 'selected="selected"';?>>Open</option>
<option value="limited" <?php if ($cal->viewaccess == 'limited') echo 'selected="selected"';?>>Limited</option>
<?php
/* Only show restricted option is user or course limits are enabled */
if (wassParms::USERLIM || wassParms::COURSELIM) {?>
<option value="restricted" <?php if ($cal->viewaccess == 'restricted') echo 'selected="selected"';?>>Restricted</option>
<?php }?>
<option value="private" <?php if ($cal->viewaccess == 'private') echo 'selected="selected"';?>>Private</option>
</select>&nbsp;<div id="divViewBlockRestrDesc" style="display:inline;"></div>
</div>

<div id="divViewBlockRestr" class="authorized">
<?php
/* Only show user limit box if they are enabled */
if (wassParms::USERLIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter <?php echo wassParms::NETID;?></p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksUserID" name="txtViewBlocksUserID" value="" tabindex="19"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtViewBlocksUserID','selViewBlocksUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksUserIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksUserIDList[]" name="selViewBlocksUserIDList[]" class="listBox" size="4" multiple tabindex="20" >
			<option></option>
		</select></td>
  </tr>
</table>

<?php }

/* Only show course limit box if they are available */
if (wassParms::COURSELIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course name</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksCourseID" name="txtViewBlocksCourseID" value="" tabindex="21"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtViewBlocksCourseID','selViewBlocksCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksCourseIDList[]" name="selViewBlocksCourseIDList[]" class="listBox" size="4" multiple tabindex="22" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }?>
</div>

<div id="formdividerSub"></div>
<br>

<div>
<label for="selMakeApptRestr" title="Select who you will allow to make appointments on the Calendar.">Make Appointments</label>
<select id="selMakeApptRestr" name="selMakeApptRestr" tabindex="23" onchange="onchangeAdvAppts();" onload="onchangeAdvAppts();">
<option value="open" <?php if ($cal->makeaccess == 'open') echo 'selected="selected"';?>>Open</option>
<option value="limited" <?php if ($cal->makeaccess == 'limited') echo 'selected="selected"';?>>Limited</option>
<?php
/* The "restricted" setting only is available if course or user limits are enabled */
if (wassParms::COURSELIM || wassParms::USERLIM) {?>
<option value="restricted" <?php if ($cal->makeaccess == 'restricted') echo 'selected="selected"';?>>Restricted</option>
<?php }?>
<option value="private" <?php if ($cal->makeaccess == 'private') echo 'selected="selected"';?>>Private</option>
</select>&nbsp;<div id="divMakeApptRestrDesc" style="display:inline;">stuff</div>
</div>

<div id="divMakeApptRestr" class="authorized">
<?php
/* Only show user limit box if they are enabled */
if (wassParms::USERLIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter <?php echo wassParms::NETID;?></p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptUserID" name="txtMakeApptUserID" value="" tabindex="24"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtMakeApptUserID','selMakeApptUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptUserIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptUserIDList[]" name="selMakeApptUserIDList[]" class="listBox" size="4" multiple tabindex="25" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }

/* Only show course limit box if they are available */
if (wassParms::COURSELIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course name</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptCourseID" name="txtMakeApptCourseID" value="" tabindex="26"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtMakeApptCourseID','selMakeApptCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptCourseIDList[]" name="selMakeApptCourseIDList[]" class="listBox" size="4" multiple tabindex="27" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }?>
</div>



<div id="formdividerSub"></div>

<div>
<label id="lblShowAppInfo" for="chkShowAppInfo" title="If checked, details about appointments will be shown to all users.">Show Appointment Details</label>
<input type="checkbox" id="chkShowAppInfo" name="chkShowAppInfo" tabindex="14" value="show" <?php if ($cal->showappinfo) echo ' checked="checked"';?>
onclick='if (this.checked) showMessage(this.id);'>
<a href="#" onclick='openHelp("showappinfo",true);return false;' title='Help' ><img src="images/Q1_warning.gif" alt="Help" border="0" /></a>
</div>

</div>



<div class="mandatNote">
<label class="mandat" title="Required information is indicated by an asterisk."> * = Required</label>
</div>

<br>

<div class="buttons">
<input type="reset" id="btnReset" name="btnReset" value="Reset Form" tabindex="28" class="button1" onclick="resetAuth();">
<?php if (!$addcal) {?>
<input type="submit" id="btnSubmit" name="btnSubmit" value="Save" tabindex="29" class="button1" onclick="return checkValidating();"><?php
}
else {?>
<input type="submit" id="btnSubmit" name="btnSubmit" value="Create" tabindex="29" class="button1">
<?php
}?>
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
		<input type="button" id="btnRemoveCalendar" name="btnRemoveCalendar" value="Remove" tabindex="30" class="button2" onclick="OpenWin('removecal.page.php?cal_id=<?php echo $cal->calendarid;?>',500,300);"><br><br>
	</div>

    <div id="grantCalendar"><strong>Calendar's <?php echo ($cal->group)? 'Members':'Managers';?></strong><br>
    If you want to add, remove or update settings for <?php echo ($cal->group)? 'members':'managers';?> of this calendar, click Go and follow the instructions.<br><br>
        <input type="button" id="btnGrant" name="btnGrant" value="Go" tabindex="31" class="button2" onclick="OpenWin('grant.page.php?cal_id=' + GetElement('cal_id').value,690,520,'scrollbars=yes,resizeable=yes');"><br><br>
	</div>
	<?php if (!$addcal) {?>
    <div id="addCalendar"><strong>Create Additional Calendar</strong><br>
      Create an additional calendar for user <?php echo $cal->userid . " (" . $cal->name . ")"?>.<br><br>
        <input type="button" id="btnAddCal" name="btnAddCal" value="Go" tabindex="32" class="button2" onclick="window.location.href = 'calendarsetup.page.php?addcal=1&cal_id=<?php echo $cal->calendarid;?>';"><br><br>
        <?php 
	}?>
	</div><?php
}?>

<!-- Save the addcal status -->
<input type='hidden' name='addcal' value='<?php echo $addcal;?>' />

<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->


</form>
</body>
</html>

<!--                   End of HTML Code                       -->
<?php
function makeURLs($cal) {
	
	/* Global the shared variables */
	global $url, $surl, $rssurl;
	
	/* Isolate the part of our url that precedes the "pages" directory */
	$loc = strpos($_SERVER['SCRIPT_NAME'],'pages/calendarsetup.page.php');
	$path = substr($_SERVER['SCRIPT_NAME'],0,$loc);
	
	/* Save the protocol prefixes needed for the urls */
	if ($_SERVER['HTTPS']) {
		$urlhead = 'https://';
		$surlhead = 'webcal://';
	}
	else {
		$urlhead = 'http://';
		$surlhead = 'webcal://';
	}
	
	/* Generate and save the subscription and view urls, and get back their redirect ids */
	$fullurl = $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/viewcalendar.page.php?makeapp=1&cal_id=' . $cal->calendarid;
	$fullsurl = $surlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/ical.page.php?calid=' . $cal->calendarid . '&authid=' . $_SESSION['authid'];
	$fullrssurl = $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/rss.page.php?action=LISTBLOCKS&calid=' . $cal->calendarid;
	/* Now generate the display URLs ... the tinyurl facility does not work, so go back to full URLs 
	$urlid = wassRedir::urlid($fullurl);
	$surlid = wassredir::urlid($fullsurl);
	
	$url = $urlhead . $_SERVER['SERVER_NAME'] . $path  . $urlid;
	$surl = $surlhead . $_SERVER['SERVER_NAME'] . $path  . $surlid;
	*/
	$url = $fullurl;
	$surl = $fullsurl;	
	$rssurl = $fullrssurl;
	
}
?>