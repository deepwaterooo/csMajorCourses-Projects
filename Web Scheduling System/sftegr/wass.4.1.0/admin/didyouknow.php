<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*
This script allows an administrator to add/edit/remove did-you-know entries.  These entries show up on various WASS pages (manage calendars, calendar setup).
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


/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();

/* Init error/inform messages */
$infmsg = '';  


/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}

/* Get resource for all entries */
$entries = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow ORDER BY didyouknowid');
/* Compute how many entries we have */
$entry_count = wassSQL::num_rows($entries);

/* If no entries, clear current entry id and entry array */
if ($entry_count == 0) {
	$entry = '';
	$current = 0;
	$_SESSION['current'] = 0;	
}
else {
	/* If we have entries, try to read in the current one. */
	$current = $_SESSION['current'];
	$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow where didyouknowid=' . wassSQL::sqlSafe($current)));
	/* If we can't read thqat one in, reset to the first one */
	if (!$entry) {
		$entry = wassSQL::doFetch($entries);
		$current = $entry['didyouknowid'];
		$_SESSION['current'] = $current;
	}

}


/* For remove, delete the entry, then do a next */
if ($_POST['submit'] == 'Remove') {
	/* If no current, issue an error message */
	if (!$current)
		$infmsg .= 'No current entry to remove. ';
	else {
		$ret = wassSQL::doQuery('DELETE FROM ' .wassParms::DATABASE . '.wassDidYouKnow WHERE didyouknowid=' . $current . ' LIMIT 1');
		if ($ret) {
			$infmsg .= 'Entry removed. ';
			$entry_count--;
			/* Go to the next entry */
			$_POST['submit'] = 'Next';
		}
		else 
			$infmsg .= 'Entry not removed: ' . wassSQL::error() . ' ';
	}
}
	
/* For Next, scroll to the next entry.  */
if ($_POST['submit'] == 'Next') {
  if ($entry_count == 0) {
  	$infmsg .= 'No entries to display. ';
	$entry = '';
  }
  else { 
	$first = ''; $entry = '';
	$entries = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow ORDER BY didyouknowid');
	while ($entry = wassSQL::doFetch($entries)) {
		if (!$first) 
		  $first = $entry;
		if ($entry['didyouknowid'] > $current) 
			break;
	}
	
	/* If at end, make first entry the current one */
	if (!$entry) { 
		$entry = $first;
		if ($entry_count == 1)
			$infmsg .= 'Only 1 entry to display. ';
		else
			$infmsg .= 'Wrapped back to first entry. ';
	}
		
	/* Save new current */
	if ($entry) 
		$current = $entry['didyouknowid'];
	else
	  $current = 0;
	  
	$_SESSION['current'] = $current;
	
  }
}

/* For edit, write out the updated values */
if ($_POST['submit'] == 'Edit') {
	/* If adding, go do that */
	if (!$current)
		$_POST['submit'] = 'Add';
	
	else {
	  if (!(trim($_POST['header'])) || !(trim($_POST['details'])))
		  $infmsg .= 'Entry must have a header and some details. ';
	  else {
		/* Update the entry */	  
		$ret = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassDidYouKnow SET ' .
				'`release`=' . wassSQL::sqlSafe(trim($_POST['release'])) . ',' .
				'`topics`=' . wassSQL::sqlSafe(trim($_POST['topics'])) . ',' .
				'`header`=' . wassSQL::sqlSafe(trim($_POST['header'])) . ',' .
				'`details`=' . wassSQL::sqlSafe(trim($_POST['details'])) . 
				' WHERE didyouknowid= ' . $current . ' LIMIT 1');
		
		if ($ret) {
			$infmsg .= 'Entry updated. ';
			/* re-read the entry */
			$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow where didyouknowid=' . wassSQL::sqlSafe($current)));
		}
		else
			$infmsg .= 'Entry not updated: ' . wassSQL::error() . ' ';
	  }
	}
}
		

/* For Add, add the entry */
if ($_POST['submit'] == 'Add') {
	
	if (!(trim($_POST['header'])) || !(trim($_POST['details'])))
		$infmsg .= 'Entry must have a header and some details. ';
	else {
	  /* Add the entry */
	  $ret = wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassDidYouKnow (`dateadded`,`release`,`topics`,`header`,`details`) VALUES (' .
			   wassSQL::sqlSafe(trim(date('Y-m-d'))) . ',' .
			   wassSQL::sqlSafe(trim($_POST['release'])) . ',' .
			   wassSQL::sqlSafe(trim($_POST['topics'])) . ',' .
			   wassSQL::sqlSafe(trim($_POST['header'])) . ',' .
			   wassSQL::sqlSafe(trim($_POST['details'])) . ')');
	  
	  if ($ret) {
		  $infmsg .= 'Entry added.  To add another entry, overlay the displayed fields with the new values, then click <em>Add</em>. ';
		  $current = wassSQL::insert_id();
		  $_SESSION['current'] = $current;
		  $entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassDidYouKnow WHERE didyouknowid=' . $current));
		  $entry_count++;
	  }
	  else
		  $infmsg .= 'Entry not added: ' . wassSQL::error() . ' ';
	}
	  
}

/* For exit, exit */
if ($_POST['submit'] == 'Exit') {
	echo 'Bye.';
	exit;
}





/* We can send email to any of the following mutually-exclusive groups (or combination of groups; select all groups to send to everyone; no-one gets more than one copy of the email): 
	1. Calendar owners who do not have managers.
	2. Calendar owners who do have managers.
	3. Calendar managers.
	4. Students who have expired appointments.
	5. Students who have active appointments.
*/


?>
<html>
<head>
<title>Manage Did-You-Know Entries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body >
<h3 align="right"><em><?php echo wassParms::SYSID;?></em>&nbsp;</h3>
<h1 align="center">Add/Edit/Remove Did-You-Know Entries</h1>

  <p> This form allows you to add, edit and remove did-you-know entries from the wassDidYouKnow table. These entries are displayed on various WASS pages as a way to inform users about features of which they may not be aware.</p>
  <p>Existing entries are displayed below. You can cycle through the entries by clicking the <em>Next</em> button.  You can make changes to the displayed entry by editing the entry fields and clicking the <em>Edit</em> button.  You can remove the displayed entry by clicking the <em>Remove</em> button. You can create a new entry entry by filling in the fields (overlay what is currently displayed) and clicking the <em>Add</em> button.  You can exit by clicking the <em>Exit</em> button.</p>



<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="POST" name="didyouknow" id="didyouknow">
<DIV >
  <p>
  <h3>Entries: <?php echo $entry_count;?></h3>
  <?php
if (!$infmsg) $infmsg = '&nbsp;';  ?>
	<div id="error" ><?php echo '<strong>>>>' . $infmsg . '<<<</strong>';?><br>
			  </div>
<?php ?>	
  </p>
  <p>Header: &nbsp;&nbsp;Enter the short (one-line) header text to display as a tag for this entry (you can include simple HTML, such as bold or italic):<br />
    <input name="header" type="text" id="header" size="100" value="<?php if ($entry) echo wassUtil::safeHTML($entry['header']);?>">
  </p>
  <p>Release: &nbsp;&nbsp;If this entry applies to a feature only available starting with a certain release, enter that release number.  If it applies to all releases, enter 0 (zero).  Releases must be of the form 'n.n.n' (where each n is an integer, and you can have as many n's as you like):<br />
    <input name="release" type="text" id="release" size="100" value="<?php if ($entry) echo wassUtil::safeHTML($entry['release']);?>">
  </p>
    <p>Topics: &nbsp;&nbsp;Optionally, enter a comma-seperated list of topic names to which this entry applies (single words).<br />
    <input name="topics" type="text" id="topics" size="150" value="<?php if ($entry) echo wassUtil::safeHTML($entry['topics']);?>">
  </p>
  <p>Enter the entry Details: &nbsp;&nbsp;You may include simple html (bold, italic).</p>
  <p name="details" cols="80" rows="20">
    <textarea name="details" cols="80" rows="20"><?php if ($entry) echo wassUtil::safeHTML($entry['details']);?></textarea>
  </p>
  <p>
    <input type="hidden" name="secret" value="<?php echo wassParms::PASS;?>" />
  </p>
</DIV>
<DIV align="center">  
    <p>
     <input type="submit" name="submit" value="Next">
      &nbsp;&nbsp;&nbsp;
      <input type="submit" name="submit" value="Edit">
      &nbsp;&nbsp;&nbsp;
        <input type=submit name="submit" value="Remove">
      &nbsp;&nbsp;&nbsp;
        <input type=submit name="submit" value="Add">
      &nbsp;&nbsp;&nbsp;
        <input type=submit name="submit" value="Exit">

    </p>
  
</DIV>


</form>
</body>
</html>