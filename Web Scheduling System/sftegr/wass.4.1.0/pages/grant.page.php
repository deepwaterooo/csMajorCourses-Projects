<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page allows users to grant or deny manager status to others.
		Notable POST Arguments:
			- hidDenyUserID: the user ID of the manager that should be removed before display.
			- hidAllowUserID: the user ID of the manager that should be added before display.
			- hidUpdateUserID: the user ID of the manager that should be updated before display.
			- hidAddUserID: the user ID of the manager who should be added before display.
			- cal_id: calendar id of target calendar.

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

/* If not authenticated (or a guest), send back to authenticate */
wassDirectory::authenticate();

/* Init error/inform messages. */
$errmsg = '';  $infmsg = ''; $action = '';

/* Save userid to be removed as a manager (if any) or allowed (if any) or added as manager (if any) or updated (if any). */
$hidDenyUserID = trim($_REQUEST['hidDenyUserID']);
$hidAllowUserID = trim($_REQUEST['hidAllowUserID']);
$hidUpdateUserID =  trim($_REQUEST['hidUpdateUserID']);
$hidAddUserID =  trim($_REQUEST['txtAddUserID']);
$hidNotifyOwner =  trim($_REQUEST['hidNotifyOwner']);
$hidNotifyManager =  trim($_REQUEST['hidNotifyManager']);

/* Save calendar id */
$cal_id = $_REQUEST['cal_id'];
if (!$cal_id)
	$cal_id = $_SESSION['cal_id'];

/* Get calendar */
if ($cal_id) {
	try {
		$cal = new wassCalendar('load',array('calendarid'=>$cal_id));
	} catch (Exception $error) {
		$errmsg = 'Unable to locate calendar with id ' . $cal_id;
	}
}
else
	$errmsg = 'No calendar id passed to the grant request.';

/* We need to get a wassList of all of the managers, and a list of pending managers, for this calendar */
if (!$errmsg) {
	$managers = wassManager::wlistActiveManagers($cal_id);
	$cmanagers = $managers->entries();
	$pendingmanagers = wassManager::wlistPendingManagers($cal_id);
	$cpendingmanagers = $pendingmanagers->entries();
}


/*
Remember if this is a group calendar.
*/
if ($cal->group) 
	$ismember = 1;
else
	$ismember = 0;

/*
Handle a form submission.
*/

if (!$errmsg && ($hidDenyUserID || $hidAllowUserID || $hidUpdateUserID || $hidAddUserID )) {
	
	/* Build subject line */
	$subject = 'Change in calendar ';
	$subject .= ($cal->group)? 'member':'manager';
	$subject .= ' status.';
	
	$infheader = ($cal->group)? 'Member ':'Manager '; 		 
	
	
	/* If allowing, add a pending manager */
	if ($hidAllowUserID) {
		/* Save notify and reminder flags, if any are set */
		if (array_key_exists('chkNotify_' . $hidAllowUserID,$_POST))
			$notify = 1;
		else
			$notify = 0;
		if (array_key_exists('chkRemind_' . $hidAllowUserID,$_POST))
			$remind = 1;
		else
			$remind = 0;
		
		/* Add the manager */
		$errmsg = wassManager::addManager($cal->calendarid,$hidAllowUserID,'user',$notify,$remind);
		if (!$errmsg) {

			$msg = 'User ' . $hidAllowUserID . ' has been added as a ';
			$msg .= ($cal->group)? 'member':'manager'; 
			$msg .= ' for the calendar with title "' . $cal->title . '" belonging to user ' . $cal->userid . ' (' . $cal->name . ').' . 
			'<br /><br />The calendar may be accessed using the following URL:<br />' .
			'<a href="' . calURL($cal) . '">' . calURL($cal) . '</a>' .
			'<br /><br />Once you access this calendar, you can click the Help button for assistance.' .
			"<br /><br />--" . wassParms::SYSID;    
			$infmsg = $infheader . $hidAllowUserID . ' added.';
			$to = $hidAllowUserID;
			if ($hidAllowUserID == $_SESSION['authid']) $_SESSION['ismanager'] = true;
		}
		$hidAllowUserID = '';
	}
	/* If adding add a new user */
	elseif ($hidAddUserID) {
		/* Make sure manager id is valid */
		if (!wassDirectory::useridCheck($hidAddUserID))
			$errmsg = '"' . $hidAddUserID . '" is not a valid ' . wassParms::NETID;
		/* Make sure not already a manager */
		elseif (wassManager::isManager($cal->calendarid,$hidAddUserID,'user'))
			$errmsg = 'User ' . $hidAddUserID . ' already manages this calendar';
		else {
		  /* Save notify and reminder flags, if any are set */
		  if (array_key_exists('chkNotify',$_POST))
			  $notify = 1;
		  else
			  $notify = 0;
		  if (array_key_exists('chkRemind',$_POST))
			  $remind = 1;
		  else
			  $remind = 0;
		  
		  /* Add the manager */
		  $errmsg = wassManager::addManager($cal->calendarid,$hidAddUserID,'user',$notify,$remind);
		  if (!$errmsg) {
			  $msg = 'User ' . $hidAddUserID . ' has been added as a ';
			  $msg .= ($cal->group)? 'member':'manager'; 
			  $msg .= ' for the calendar with title "' . $cal->title . '" belonging to user ' . $cal->userid . ' (' . $cal->name . ').' . 
			  '<br /><br />The calendar may be accessed using the following URL:<br />' .
			  '<a href="' . calURL($cal) . '">' . calURL($cal) . '</a>' .
			  '<br /><br />Once you access this calendar, you can click the Help button for assistance.' .
			  "<br /><br />--" . wassParms::SYSID;    
			  $infmsg =  $infheader . $hidAddUserID . ' added.';
			  $to = $hidAddUserID;
			  if ($hidAddUserID == $_SESSION['authid']) $_SESSION['ismanager'] = true;
		  }
		}
		$hidAddUserID = '';
	}
	elseif ($hidDenyUserID) {
		/* Renove the manager from the manager table */
		
		$errmsg = wassManager::removeManager($cal->calendarid,$hidDenyUserID,'');
		if (!$errmsg) {
			$msg = 'User ' . $hidDenyUserID . ' has been removed as a ';
			$msg .= ($cal->group)? 'member':'manager'; 
			$msg .= ' for the calendar with title "' . $cal->title . '" belonging to user ' . $cal->userid . ' (' . $cal->name . ').' . "<br />" . wassParms::SYSID;
			$infmsg = $infheader . $hidDenyUserID . ' removed.';
			$to = $hidDenyUserID;
			if ($hidDenyUseriD == $_SESSION['authid']) {
				if (wassManager::listManagedids($_SESSION['authid']))
					$_SESSION['ismanager'] = true;
				else
					$_SESSION['ismanager'] = false;
			}
		}
		$hidDenyUserID = '';
	}
	elseif ($hidUpdateUserID) {
		/* Save notify and reminder flags, if any are set */
		if (array_key_exists('chkNotify_' . $hidUpdateUserID,$_POST))
			$notify = 1;
		else
			$notify = 0;
		if (array_key_exists('chkRemind_' . $hidUpdateUserID,$_POST))
			$remind = 1;
		else
			$remind = 0;
		
		/* Update the settings */
		$errmsg = wassManager::updateManager($cal->calendarid,$hidUpdateUserID,'user',$notify,$remind);
		if (!$errmsg) {
			if ($notify) $nm = 'on'; else $nm = 'off';
			if ($remind) $rm = 'on'; else $rm = 'off';
			$msg = 'The notify and reminder settings of ';
			$msg .= ($cal->group)? 'member ':'manager '; 
			$msg .= $hidUpdateUserID . ' for the calendar with title "' . $cal->title . '" belonging to user ' . $cal->userid . ' (' . $cal->name . ')' . " have been changed as follows: \r\n" .  'notify: ' . $nm . '; remind: ' . $rm . "<br /><br />" . wassParms::SYSID;
			$infmsg = $infheader . $hidUpdateUserID . ' updated.';
			$to = $hidUpdateUserID;
			if ($hidUpdateUseriD == $_SESSION['authid']) {
				if (wassManager::listManagedids($_SESSION['authid']))
					$_SESSION['ismanager'] = true;
				else
					$_SESSION['ismanager'] = false;
			}
		}
		$hidUpdateUserID = '';		
		
	}
	
	
	/* Send email to the manager and owner, if requested  */
	if (!$errmsg) {
		$headers = "From: " . wassParms::FROMMAIL . "\r\n" . "Reply-To: " . $cal->email . "\r\n" . "Content-type: text/html\r\n" . "Errors-To: " . wassParms::SYSMAIL . "\r\n";
		if ($hidNotifyManager == "true")
			mail(wassDirectory::getEmail($to), $subject, $msg, $headers);
		if ($hidNotifyOwner == "true")
			mail(wassDirectory::getEmail($cal->userid), $subject, $msg, $headers);			
	}
	
	/* Refresh the manager lists */
	$managers = wassManager::wlistActiveManagers($cal_id);
	$pendingmanagers = wassManager::wlistPendingManagers($cal_id);
	$cmanagers = $managers->entries();
	$cpendingmanagers = $pendingmanagers->entries();


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
<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;

//KDC, 9-8-2009. For some reason, hitting the enter key was actually submitting.  Added this code to submit it properly.
document.onkeypress = EnterKeySearch;
function EnterKeySearch(e) {
	if (!e) var e = window.event;
	if (CheckForEnterKey(e)) {
		validateForm();
		return false;
	}
	return true;
}

//KDC, 1-26-2009.  Added to set managers list on calendarsetup page
function setOpenerManagers() {
<?php 
	$mgrs = '';
	$isfirst = 1;
 	foreach ($managers as $manager) {
		if (!$isfirst) $mgrs .= ',';
		$mgrs .= wassUtil::safeHTML($manager->managerid);
		$isfirst = 0;
 	} ?>
	var mgrs = "<?php echo $mgrs;?>";
	var elList = window.opener.GetElement("txtMgrUserID");
	elList.value = mgrs;
}

function closeAndRefreshOpener() {
	//window.opener.reloadPage(); //KDC, 1-26-2009. Not needed because of setOpenerManagers()
	self.close();
}
function init() {
	//KDC, 6/4/2009. This list is no longer on the calendar setup page.
	//setOpenerManagers();
	var elFirst = GetElement("txtAddUserID");
	if (elFirst != null)
		elFirst.focus();
}
function validateForm() {
	//Check for required fields
	var strReqdMsg = "Please enter the following required information: \n";
	var strReqdFields = "";
	//User ID
	if (isBlankField("txtAddUserID"))
		strReqdFields = addToMessage(strReqdFields,"Manager <?php echo wassParms::NETID;?>");
	//Show the message
	if (trim(strReqdFields) != "") {
		alert(strReqdMsg + strReqdFields);
		return false;
	}

	var sUserID = GetElement("txtAddUserID").value;
	confirmAdd(sUserID);
}
function confirmDeny(inUserID) {
	OpenWin('grantmsg.page.php?owner_id=' + <?php echo "'" . $cal->userid . "'";?>  + '&ismember=' + <?php echo $ismember;?>  + '&user_id=' + inUserID + '&subtype=Deny',400,230,null,null,null,true);
	//submitForDeny(inUserID,true,true);
}
function submitForDeny(inUserID,inIsNotifyOwner,inIsNotifyManager) {
	GetElement("hidAllowUserID").value = "";
	GetElement("hidDenyUserID").value = safeHTMLJS(inUserID);
	GetElement("hidUpdateUserID").value = "";
	GetElement("hidAddUserID").value = "";
	GetElement("hidNotifyOwner").value = inIsNotifyOwner;
	GetElement("hidNotifyManager").value = inIsNotifyManager;
	submitForm();
}
function confirmAllow(inUserID) {
	OpenWin('grantmsg.page.php?owner_id=' + <?php echo "'" . $cal->userid . "'";?>  + '&ismember=' + <?php echo $ismember;?>  + '&user_id=' + inUserID + '&subtype=Allow',400,230,null,null,null,true);
	//submitForAllow(inUserID,true,true);
}
function submitForAllow(inUserID,inIsNotifyOwner,inIsNotifyManager) {
	GetElement("hidAllowUserID").value = safeHTMLJS(inUserID);
	GetElement("hidDenyUserID").value = "";
	GetElement("hidUpdateUserID").value = "";
	GetElement("hidAddUserID").value = "";
	GetElement("hidNotifyOwner").value = inIsNotifyOwner;
	GetElement("hidNotifyManager").value = inIsNotifyManager;
	submitForm();
}
function confirmUpdate(inUserID) {
	OpenWin('grantmsg.page.php?user_id=' + <?php echo "'" . $cal->userid . "'";?>  + '&ismember=' + <?php echo $ismember;?>  + '&user_id=' + inUserID + '&subtype=Update',400,230,null,null,null,true);
	//submitForUpdate(inUserID,true,true);
}
function submitForUpdate(inUserID,inIsNotifyOwner,inIsNotifyManager) {
	GetElement("hidAllowUserID").value = "";
	GetElement("hidDenyUserID").value = "";
	GetElement("hidUpdateUserID").value = safeHTMLJS(inUserID);
	GetElement("hidAddUserID").value = "";
	GetElement("hidNotifyOwner").value = inIsNotifyOwner;
	GetElement("hidNotifyManager").value = inIsNotifyManager;
	submitForm();
}
function confirmAdd(inUserID) {
	OpenSecondWin('grantmsg.page.php?owner_id=' + <?php echo "'" . $cal->userid . "'";?>  + '&ismember=' + <?php echo $ismember;?>  + '&user_id=' + inUserID + '&subtype=Add',400,230,null,null,null);
	//submitForAdd(inUserID,true,true);
}
function submitForAdd(inUserID,inIsNotifyOwner,inIsNotifyManager) {
	GetElement("hidAllowUserID").value = "";
	GetElement("hidDenyUserID").value = "";
	GetElement("hidUpdateUserID").value = "";
	GetElement("hidAddUserID").value = safeHTMLJS(inUserID);
	GetElement("hidNotifyOwner").value = inIsNotifyOwner;
	GetElement("hidNotifyManager").value = inIsNotifyManager;
	submitForm();
}

//KDC, 9-10-2009. For bringing the confirm window into focus
function focusConfirm() {
	if (document.g_OpenWin2) document.g_OpenWin2.focus();	
}
</script>
</head>
<body onload="init();">
<div id="windowTitle">Your Calendar's <?php echo ($cal->group)? 'Member':'Manager';?>(s)</div>

<div id="formdividerShort"></div>

<?php
if ($errmsg) { ?>
	<div id="error"><?php echo $errmsg;?><br>
			  <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>
	<div id="confirm"><?php echo $infmsg;?><br>
			  <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>

<form id="frmApply" name="frmApply" action="grant.page.php" method="post"">
<input type="hidden" id="hidDenyUserID" name="hidDenyUserID" value="<?php echo $hidDenyUserID;?>" />
<input type="hidden" id="hidAllowUserID" name="hidAllowUserID" value="<?php echo $hidAllowUserID;?>" />
<input type="hidden" id="hidUpdateUserID" name="hidUpdateUserID" value="<?php echo $hidUpdateUserID;?>" />
<input type="hidden" id="hidAddUserID" name="hidAddUserID" value="<?php echo $hidAddUserID;?>" />
<input type="hidden" id="hidNotifyOwner" name="hidNotifyOwner" value="<?php echo $hidNotifyOwner;?>" />
<input type="hidden" id="hidNotifyManager" name="hidNotifyManager" value="<?php echo $hidNotifyManager;?>" />
<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $cal_id;?>" />

<div>
<!-- *** PHP *** -->
<!-- need wassParms for Princeton below -->
<div style="padding: 5px 5px 5px 5px; margin: 0px 20px 10px 20px; width:450px; _width:460px;">
<p class="plain2">
  <br />
  <?php if ($cpendingmanagers) {?>
  To allow <?php echo ($cal->group)? 'member':'manager';?> status for a pending <?php echo ($cal->group)? 'member':'manager';?>, set the notification and reminder flags, then click &quot;Allow&quot;.</p>
<p class="plain2">To deny <?php echo ($cal->group)? 'member':'manager';?> status for a pending <?php echo ($cal->group)? 'member':'manager';?>, click &quot;Deny&quot;.<br /><br />
  <?php }?>
  <?php if ($cmanagers) {?>
  To turn appointment notifications and/or reminders on or off for an active <?php echo ($cal->group)? 'member':'manager';?>, click the corresponding check box(es), then click &quot;Update&quot;.</p>
<p class="plain2">To remove an active <?php echo ($cal->group)? 'member':'manager';?>, click &quot;Remove&quot;.<br />
  <br />
  <?php 
  } ?>
  To allow someone <?php if ($cmanagers) echo "else";?> to <?php echo ($cal->group)? 'be a member of':'manage';?> your calendar, enter their  <?php echo wassParms::NETID;?>, set the notification and reminder flags as you want them, then click "Add".</p>
<p class="plain2">Note: The flags below will determine which <?php echo ($cal->group)? 'members':'managers';?> get appointment notifications and/or reminders.</p>

<div id="results" style="margin:0px 0px 0px 0px;">
		<table width="460" cellspacing="0" cellpadding="0" border="0">
		  <tr>
			<td width="100"><strong><?php echo wassParms::NETID;?></strong></td>
			<td width="100" style="text-align:center;"><strong>Status</strong></td>
			<td width="20"><strong><?php if ($cmanagers || $cpendingmanagers) echo "Name"; else echo "&nbsp;&nbsp;&nbsp;&nbsp;";?></strong></td>
            <td width="80" style="text-align:center;"><strong>Notifications</strong></td>
			<td width="80" style="text-align:center;"><strong>Reminders</strong></td>
			<td width="40"><strong></strong></td>
			<td width="40"><strong></strong></td>
		  </tr>
		  <tr>
			<td colspan="7"><div id="formdividerShort" style="margin: 0px 0px 0px 0px;"></div></td>
		  </tr>
			<?php
		foreach ($pendingmanagers as $manager) {?>
				<tr>
					<td><?php echo wassUtil::safeHTML($manager->managerid);?></td>
					<td>Pending</td>
					<td><?php echo wassUtil::safeHTML(wassDirectory::getName($manager->managerid));?></td>
                    <td style="text-align:center;"><input type="checkbox" id="chkNotify_<?php echo wassUtil::safeHTML($manager->managerid);?>" name="chkNotify_<?php echo wassUtil::safeHTML($manager->managerid);?>" value="notify" <?php if ($manager->notify) echo ' checked="checked"';?>></td>
<td style="text-align:center;"><input type="checkbox" id="chkRemind_<?php echo wassUtil::safeHTML($manager->managerid);?>" name="chkRemind_<?php echo wassUtil::safeHTML($manager->managerid);?>" value="remind" <?php if ($manager->remind) echo ' checked="checked"';?>></td>
					<td><a href="#" onclick="confirmAllow('<?php echo wassUtil::safeHTML($manager->managerid);?>');return false;">Allow</a></td>
					<td><a href="#" onclick="confirmDeny('<?php echo wassUtil::safeHTML($manager->managerid);?>');return false;">Deny</a></td>
               </tr>
        <?php 
		}
		foreach ($managers as $manager) {?>
				<tr>
					<td><?php echo wassUtil::safeHTML($manager->managerid);?></td>
					<td>Active</td>
					<td><?php echo wassUtil::safeHTML(wassDirectory::getName($manager->managerid));?></td>
                    <td style="text-align:center;"><input type="checkbox" id="chkNotify_<?php echo wassUtil::safeHTML($manager->managerid);?>" name="chkNotify_<?php echo wassUtil::safeHTML($manager->managerid);?>" value="notify" <?php if ($manager->notify) echo ' checked="checked"';?>></td>
<td style="text-align:center;"><input type="checkbox" id="chkRemind_<?php echo wassUtil::safeHTML($manager->managerid);?>" name="chkRemind_<?php echo wassUtil::safeHTML($manager->managerid);?>" value="remind" <?php if ($manager->remind) echo ' checked="checked"';?>></td>
                    <td><a href="#" onclick="confirmUpdate('<?php echo wassUtil::safeHTML($manager->managerid);?>');return false;">Update</a></td>		
					<td><a href="#" onclick="confirmDeny('<?php echo wassUtil::safeHTML($manager->managerid);?>');return false;">Remove</a></td>	
          </tr>
		<?php 
		}?>
				<tr>
			<td><input type="text" id="txtAddUserID" name="txtAddUserID" tabindex="1" size="30"></td>
            <td></td>
            <td></td>
            <td style="text-align:center;"><input type="checkbox" id="chkNotify" name="chkNotify" value="notify" checked="checked"></td>
            <td style="text-align:center;"><input type="checkbox" id="chkRemind" name="chkRemind" value="remind" checked="checked"></td>
            <td><a href="#" onclick="validateForm();return false;">Add</a></td>
			<td></td>
               </tr>
		  </tr>
		  <tr>
			<td colspan="7"><div id="formdividerShort" style="margin: 0px 0px 0px 0px;"></div></td>
		  </tr>
	  </table>

</div>
</div>
<div id="close"><a href="#" onclick="closeAndRefreshOpener();">Close Window</a></div>

</form>

</body>
</html>


<!--                   End of HTML Code                       -->
<?php
function calURL($cal) {
	
	/* Save the protocol prefixes needed for the urls */
	if ($_SERVER['HTTPS']) 
		$urlhead = 'https://';
	else 
		$urlhead = 'http://';
		
	 
	return $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/viewcalendar.page.php?makeapp=1&cal_id=' . $cal->calendarid;
	 
	
}
?>