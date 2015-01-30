<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

 
This script is used by someone who wants to apply to manage someone else's calendar.  It sends an email to the calendar owner with a link to a separate, hidden page in the system.  When the calendar owner clicks on the link in this email, the resulting page automatically gives the requestor manager status for the owner's calendar. 	

 
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

/* Clear error/inform message */
$errmsg = ''; $infmsg = '';

/* Clear flag that signals completion */
$action = '';

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();

/* If not authenticated (or if a guest), send back for authentication */
wassDirectory::authenticate();

/*
Handle a form submission.
*/

/* Init array of target calendars */
$allcals = array();

/* Assume we haven't found anything yet */
$found = false;

/* Save netid of the manager  (person applying to manage) */
$manager = trim($_SESSION['authid']);     

/* Get list of netids requested */
$manageelist = wassUtil::slashstrip($_REQUEST['txtUserID']);

if ($_POST['btnSubmit'] == 'SEARCH') {
	/* User is asking for a list of calendars */
	
	/* Get list of netids requested */
	$managees = trim(str_replace(array("\r","\n"),array(" "," "),wassUtil::slashstrip($_REQUEST['txtUserID'])));  /* The ones being managed */
	/* Make sure we got some managees */
	if (!$managees)
		$errmsg = 'You must enter a ' . wassParms::NETID . ', or close this window to cancel.';
	else {
	  /* Generate array of all managees */
	  $amanagees = explode(',',$managees);
	  
	  /* Init array of target calendars */
	  $allcals = array();
	  
	  /* Go through the managees */
	  foreach ($amanagees as $managee) {
		  $managee = trim($managee);
			  
		  if (!wassDirectory::useridCheck($managee))
			  $errmsg .= 'Unknown or invalid ' . wassParms::NETID . ' "' . $managee . '"; '  ;
		  elseif ($manager == $managee)
			  $errmsg .= '"'.$manager.'" cannot manage their own calendar(s); ';
		  elseif (!$email = wassDirectory::getEmail($managee))
			  $errmsg .= 'Unable to locate email address for ' . $managee . '; ';
  
		  else {
			  /* Make sure managee actually has a calendar in the system ... if not, build one (template). */
			  $manageecalendars = wassCalendar::wListOwnedCalendars($managee);
			  /* If user has no calendar, build a template calendar */
			  if ($manageecalendars->entries() == 0) {
				  try {
					  $calendar = new wassCalendar('create',array('userid'=>$managee));
					  $calendarid = $calendar->save('create');
					  $allcals[] = clone $calendar;
					  $found = true;
				  } catch (Exception $error) {
					  $errmsg .= $error->getMessage();
				  }
			  }		
			  else {
				  foreach ($manageecalendars as $cal) {
					  $allcals[] = clone $cal;
				  }
				  $found = true;
			  }	
		  }
	  }	
	}
}
elseif ($_POST['btnSubmit'] == 'APPLY') {
	/* Save the optional email text */
	$opttext = trim(wassUtil::slashstrip($_REQUEST['sDesc']));       
		
	/* Get list of target calendarids */
	$keys = array_keys($_POST);
	$calids = array();
	foreach ($keys as $key) {
		if (substr($key,0,3) == 'chk')
			$calids[] = substr($key,3);
	}
				
	/* Now go through and send email request for each calendar */
	$ulist = array();
	foreach ($calids as $calid) {
		/* Read in the calendar */
		$cal = wassCalendar::find($calid); 
		/* Generate the email */
		$from = wassDirectory::getEmail($manager);
		$email = wassDirectory::getEmail($cal['userid']);
		$headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $from . "\r\n" . "Content-type: text/html\r\n" . "Errors-To: " . wassParms::SYSMAIL . "\r\n";	
		$subject = 'Request to ';
		$subject .= ($cal['group'])? 'be a member of':'manage'; 
		$subject .= ' your appointment calendar.';
		$msg = 'User ' . $manager . ' (' . wassDirectory::getName($manager) . ') has requested permission to ';
		$msg .= ($cal['group'])? 'be a member of':'manage';
		$msg .= ' your calendar with title "' . $cal['title'] .'".  To process this request (either allow or deny it), click the link below (or cut and paste the link into the address line of your web browser) and follow the displayed instructions.<br /><br />';
		
		if ($opttext)
			$msg .= 'Note: the requestor has provided the following text: <br /><br />' . wassUtil::safeHTML($opttext) . '<br /><br />';
		
		/* Generate password */
		$randstring = wassUtil::rand_chars(10);
		
		$msg .= '<a href="https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/grantemail.page.php?calendarid=' . $calid . '&manager=' . $manager . '&p=' . $randstring . '">https://' . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . dirname($_SERVER['PHP_SELF']) . '/grantemail.page.php?calendarid=' . $calid . '&manager=' . $manager . '&p=' . $randstring . '</a>' . '<br /><br /> -- ' . wassParms::SYSID;
		mail($email, $subject, $msg, $headers);
		
		/* Now add this user to the manager table (in pending status) */
		$result = wassManager::addManager($calid,trim($manager),"pending",1,1,$randstring);
		
		/* Keep track of added users for infmsg */
		$ulist[] = $cal['userid'] . " (" . $cal['name'] . ")";
		
	}
	/* Build infmsg */

	$infmsg = "A request has been sent to the specified user(s) asking them to grant you ";
	$infmsg .= ($cal['group'])? 'member':'manager';
	$infmsg .= " status.  You may apply to manage another calendar, or close this window if you are done.";
	
}
elseif ($_POST['btnSubmit'] == 'CANCEL') {
		$action = 'done';
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
<title><?php echo wassUtil::safeHTML(wassParms::SYSID);?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;

function closeAndRefreshOpener() {
	self.close();
}
function init() {
	var elFirst = GetElement("txtUserID");
	if (elFirst != null)
		elFirst.focus();
}
function validateForm() {
/*
	var isAnySelected = false;
	var cals = document.getElementsByName("chkManagedCal");
	alert(cals.length);
	for (var i=0; i < cals.length; i++) {
		if (cals[i].checked == "checked")
			isAnySelected = true;
	}
	if (!isAnySelected) {
		alert("Please select a calendar");
		return false;
	}
*/
	return true;
}
</script>
</head>

<!-- *** PHP *** -->
<!-- if successful sending of email, output: -->
<!--
<?php 
if ($action == "done") {?>
	<body onload="closeAndRefreshOpener();"><?php
}
else {?>
	<body onload="init();"><?php
}?>-->
<body onload="init();">

<form id="frmApply" name="frmApply" action="#" method="post">

<div id="windowTitle">Apply to Manage/Join a Calendar</div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error" style="margin-left:20px;"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>			  
	<div id="confirm" style="margin-left:20px;"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>	

<div style="padding: 5px 0px 10px 30px; width: 700px;">
<p class="plain2">Enter the <?php echo wassUtil::safeHTML(wassParms::NETID);?>(s) for the calendar(s) you wish to manage (or, if a group calendar, join), separated by commas, and then click the "SEARCH" button.
</p>
</div>

<div>
    <label for="txtUserID" class="mandat" style="width:150px;" title="A NetID is usually the name before the @ in their e-mail address."><?php echo wassUtil::safeHTML(wassParms::NETID);?>(s):</label>
    <textarea id="txtUserID" name="txtUserID" tabindex="1" rows="2" cols="33"><?php echo $manageelist; ?></textarea>

    <div class="buttonsShort">
    	<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="SEARCH" tabindex="2">
    </div>
</div>

<?php if ($found == true) {?>
	<div class="sectionBox2" style="margin-top:0px;">

	<div class="headingLarge">Results:</div>	
	<div id="results">


	<div style="padding: 15px 15px 10px 30px; width: 700px;">
	<p class="plain2">Click the checkboxes next to the calendars you wish to manage/join, then click the &quot;APPLY&quot; button.  This will cause email to be sent to the calendar owner asking them to grant you manager/member access to their calendar. <br>
	  OPTIONAL: Specify supplemental text to be included in the e-mail request. (If you are applying to manage/join multiple calendars, this same text will be included in each e-mail).	</p>
	</div>
		
	<table width="750" cellspacing="5" cellpadding="5">
	<tr>
		<td width="80"><strong>Select</strong></td>
		<td width="180"><strong>Calendar Title</strong></td>
		<td width="150"><strong>Calendar Owner</strong></td>
		<td width="340"><strong>Calendar Description</strong></td>
	</tr>
	<tr><td colspan="4"><div id="dividerLong"></div></td></tr>

		
	<!-- *** PHP *** -->
	<!-- Loop over results and output in this format -->
	<?php 
	$havechk = false;
	$firstcal = true;

	foreach ($allcals as $cal) {?>
		<tr><?php
		if (!$firstcal) {?>
			<tr><td colspan="4"><div id="dividerLong"></div></td></tr>
			<?php 
		}
		/* If the manager is already managing this calendar or has applied to manage, tell them */
		$pending = wassManager::arrayPendingManagers($cal->calendarid);
		$active = wassManager::arrayActiveManagers($cal->calendarid);
		if (in_array($manager,$pending)) {
			echo '<td><span class="warningText" title="You have already requested ';
			echo ($cal->group)? 'member':'manager';
			echo ' status for this calendar">Pending</span></td>';
		}
		elseif (in_array($manager,$active)) {
			echo '<td><span class="warningText" title="You are already ';
			echo ($cal->group)? 'a member of':'managing';
			echo ' this calendar">Managing</span></yd>';
		}
		else {
			$havechk = true;?>
			<td><input type="checkbox" id="chkManagedCal" name="chk<?php echo $cal->calendarid;?>" value="<?php echo $cal->calendarid;?>"/></td><?php
		}?>
		<td><?php echo wassUtil::safeHTML($cal->title);?></td>
		<td><?php if ($cal->name) echo wassUtil::safeHTML($cal->name); else echo wassUtil::safeHTML($cal->userid);?></td>
		<td class="desc" title="<?php echo wassUtil::safeHTML($cal->description);?>"><?php echo wassUtil::safeHTML($cal->description);?></td>
		</tr><?php
		$firstcal = false;
	}?>
	<tr><td colspan="4"><div id="dividerLong"></div></td></tr>
	</table>
	<?php 
}?>
</div></div>
<?php if (($found == true) && ($havechk == true)) {?>
	<br />
	<label for="sDesc" class="mandat" style="width:150px;" title="You may want to explain why you are requesting to <?php echo ($cal->group)?'be a member of ':'manage ';?>the calendar.">Supplemental Text<br> for e-mail:</label>
	<textarea cols="50" name="sDesc" id="sDesc" rows="2"></textarea>
<?php 
} 

if ($havechk == true) { ?>
	<div class="buttonsShort">
	<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="APPLY" onclick="return validateForm();">
	</div>
<?php 
}
?>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</form>

</body>
</html>


<!--                   End of HTML Code                       -->