<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This script creates an ical-formatted calendar (.ics file) of academic calendar events (all day).
 
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


/* Turn off magic quotes */
set_magic_quotes_runtime(false);
 
/* Start session support */
session_start();

/* If not authenticated, send back to authenticate */
if (!$_SESSION['authenticated'] || ($_SESSION['authtype'] == 'guest')) {
	/* Save re-direct information, if any */
	$_SESSION['redirurl'] = $_SERVER['PHP_SELF'];
	/* Send user back for authentication */
	header("Location: ../pages/login.page.php");
	exit();
}

/* Save the current authenticated userid */
$userid = $_SESSION['authid'];


/* Init inform message */
$infmsg = '';
/* Clear show file contents flag */
$showcontents = false;



/* See if we are working with a file. */
$selected = $_SESSION['selected'];



/* Get list of the user's ical files (if any) */
$fexists = false;  $userfiles = array(); $fid= ''; 
$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (userid=' . wassSQL::sqlSafe($userid) . ');');
if ($filesq) {
	while($file = wassSQL::doFetch($filesq)) {
		$userfiles[] = $file;
		if ($file['filename'] == $selected) {
			$fexists = true;
			$fid = $file['icalendarid'];
		}
	}
	mysql_free_result($filesq);
}

/* If a file was specified, but the user does not own it, die. */
if ($selected && !$fexists)
	die("You do not have access to file: $filename");


/* Handle a form submission. */
if ($_POST['submitted']) {

	/* Extract requested action from $_POST array */
	$keys = array_keys($_POST);
	foreach ($keys as $key) {
		if (substr($key,0,4) == 'Edit')  
			$_POST['Edit'] = $key;
		if (substr($key,0,4) == 'View')
			$_POST['View'] = $key;
		if (substr($key,0,6) == 'Delete')
			$_POST['Delete'] = $key;
		if (substr($key,0,6) == 'Rename')
			$_POST['Rename'] = $key;
		if (substr($key,0,6) == 'Update')
			$_POST['Update'] = $key;		
		if (substr($key,0,6) == 'Remove')
			$_POST['Remove'] = $key;
		if (substr($key,0,8) == 'IcalView')
			$_POST['IcalView'] = $key;			
	}

	/* Show/hide instructions */
	if ($_POST['Insshow'])
		$_SESSION['showinstructions'] = true;
	if ($_POST['Inshide'])
		$_SESSION['showinstructions'] = false;
	

	/* Create new file */
	if ($_POST['Create']) {
		$filename = trim($_POST['newfile']);
		$secret = trim($_POST['secret']);
		if (!$filename)
			$infmsg = 'You must specify a filename to create a new file.';
		if (count(explode(" ", $filename)) > 1)
			$infmsg = 'Filename must be a single word.';
	    foreach ($userfiles as $file) {
			if ($filename == $file['filename'])
				$infmsg = "Filename $filename already in use.";
		}
		rewind($userfiles);
		
		/* If ok, go ahead and create the file */
		if (!$infmsg) {
			/* Make sure filename has an ".ics" ending */
			$test = strtoupper($filename);
			if (strlen($test) < 5)
				$filename .= '.ics';
			elseif (substr($test,strlen($test)-4,4) != '.ICS')
				$filename .= '.ics';	
			/* Now save the data */
			if ($secret)
				$query = 'INSERT INTO ' . wassParms::DATABASE . '.wassIcalendar (userid,filename,created,secret) VALUES (' . wassSQL::sqlSafe($userid) . ',' . wassSQL::sqlSafe($filename) . ',' . wassSQL::sqlSafe(date('Y-m-d H:i:s')) . ',' . wassSQL::sqlSafe($secret) . ');';
			else
				$query = 'INSERT INTO ' . wassParms::DATABASE . '.wassIcalendar (userid,filename,created) VALUES (' . wassSQL::sqlSafe($userid) . ',' . wassSQL::sqlSafe($filename) . ',' . wassSQL::sqlSafe(date('Y-m-d H:i:s')) . ');';
			$result = wassSQL::doQuery($query);
			if (!$result)
				$infmsg = "File $filename not created: Error executing: " . $query . '; ' . wassSQL::error();
			else {
				$infmsg = "File $filename created.";
				$_SESSION['selected'] = $filename;
				$selected = $filename;
			}
		}
		$_SESSION['updating'] = false;
	}
	
	/* Edit the file */
	if ($_POST['Edit']) {
		/* Extract the file identifier */
		$fid = substr($_POST['Edit'],4);
		/* Read in the file record (resource) */
		$filerec = getFile($fid);
		/* Set the filename for the rest of the code */
		$selected = $filerec['filename'];
		$_SESSION['selected'] = $selected;
		$_SESSION['updating'] = false;
	}

 	
	/* Rename a file */
	if ($_POST['Rename']) {
		/* First, determine which file we are updating */
		$fid = substr($_POST['Rename'],6); 
		/* Make sure we have access to this file */
		$filerec = getFile($fid);
		mysql_free_result($filerec);
		/* Get the new name */
		$newname = trim($_POST['filename' . $fid]);
		
		/* Validate */
		if (!$newname)
			$infmsg = 'You must specify a filename to rename a file.';
		if (count(explode(" ", $newname)) > 1)
			$infmsg = 'Filename must be a single word.';
	    foreach ($userfiles as $file) {
			if ($newname == $file['filename'])
				$infmsg = "$newname already in use.";
		}
		rewind($userfiles);	
		
		/* Make sure filename has an ".ics" ending */
		$test = strtoupper($newname);
		if (strlen($test) < 5)
			$newname .= '.ics';
		elseif (substr($test,strlen($test)-4,4) != '.ICS')
			$newname .= '.ics';	
	  
		/* Now update the file */	
		$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET ' . 
				'filename=' . wassSQL::sqlSafe($newname) . 
				'WHERE (icalendarid=' . $fid . ');');
				
		if ($result)
			$infmsg = 'File renamed.';
		else
			$infmsg = 'File not renamed: Error executing: ' . 'UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET ' . 
				'filename=' . wassSQL::sqlSafe($newname) . 
				'WHERE (icalendarid=' . $fid . ');:' . wassSQL::error();
		
		/* Rebuild the tables */
		$fexists = false;  $userfiles = array(); $fid= ''; $farray = array(); $selected = '';
		$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (userid=' . wassSQL::sqlSafe($userid) . ')');
		if ($filesq) {
			while($file = wassSQL::doFetch($filesq)) {
				$userfiles[] = $file;
			}
		}
		mysql_free_result($filesq);
		$_SESSION['updating'] = false;
			   
	}

	if ($_POST['View']) {
		/* Extract the file identifier */
		$fid = substr($_POST['View'],4);
		/* Read in the file record */
		$filerec = getFile($fid);
		$cname = $filerec['filename'];
		
		/* Read in all of the entries */
		$resource = getEntries($fid);
		$contents = buildIcal($resource);
		$_SESSION['updating'] = false;
		
	}

	
	if ($_POST['IcalView']) {
		/* Extract the file identifier */
		$eid = substr($_POST['IcalView'],8);
		
		/* Read in the entry resource */
		$resource = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (deleted=0 AND entryid=' . $eid . ');');
		if (!$resource)
			die("Unable to find entry $eid");
				
		/* Read in the entry */
		$entry = wassSQL::doFetch($resource);
		wassSQL::freeQuery($resource);
		
		/* Read in the file record */
		$filerec = getFile($entry['icalendarid']);
		
		/* Make sure the user owns this entry */
		if ($filerec['userid'] != $_SESSION['authid'])
			die("Fatal error: You do not own entry $eid.");	
		
		/* Save the filename */
		$cname = $filerec['filename'];
		
		/* Build the iCal stream */
		$resource = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (deleted=0 AND entryid=' . $eid . ');');
		$contents = buildIcal($resource);
		$_SESSION['updating'] = false;
		
	}


	if ($_POST['Delete']) {
		/* Extract the file identifier */
		$fid = substr($_POST['Delete'],6);
		/* Read in the file record */
		$filerec = getFile($fid);
		/* First, remove all of the entries */
		$result = wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE icalendarid = ' . $fid . ';');
		/* Now remove the file entry */
		$result = wassSQL::doQuery('DELETE FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE icalendarid = ' . $fid  . ';');
		/* Let the user know */
		$infmsg = "File $filename deleted.";
		/* Rebuild the tables */
		$fexists = false;  $userfiles = array(); $fid= ''; $farray = array(); $selected = '';
		$filesq = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (userid=' . wassSQL::sqlSafe($userid) . ')');
		if ($filesq) {
			while($file = wassSQL::doFetch($filesq)) {
				$userfiles[] = $file;
			}
		}
		mysql_free_result($filesq);
		$_SESSION['updating'] = false;
	}


	if ($_POST['Cancel'] || $_POST['Done']) {
		/* Clear fields */
		$event = "";
		$description = "";
		$location = "";
		$datestart = "";
		$timestart = "";
		$dateend = "";
		$timeend = "";
		
		/* Clear selected file */
		$_SESSION['selected'] = '';
		$selected = '';
		/* Clear editing flag */
		$_SESSION['updating'] = false;
	}	
			

	/* Add data to a stream */
	if ($_POST['Save']) {
		/* Read supplied data */
		$event = trim($_POST['event']);
		$description = $_POST['description'];
		$location = trim($_POST['location']);
		$datestart = trim($_POST['datestart']);
		$timestart = trim($_POST['timestart']);
		$dateend = trim($_POST['dateend']);
		$timeend = trim($_POST['timeend']);
		
		
		/* Validate the data */
		if (!$event)
			$infmsg .= 'You must supply an event name. ';
		else
			$sqlevent = $event;
		$sqldescription = $description;
		$sqllocation = $location;
		if (!$datestart)
			$infmsg .= 'You must supply a start date. ';
		if (!wassUtil::isDateValid($datestart))
			$infmsg .= 'Start date must be in mm/dd/yyyy format. ';
		else
			$sqldatestart = wassSQL::sqlDate($datestart);
		if ($dateend) {
			if (!wassUtil::isDateValid($dateend))
				$infmsg .= 'End date must be in mm/dd/yyyy format. ';
			else
				$sqldateend = wassSQL::sqlDate($dateend);
		}
		else
			$sqldateend = '';
		if ($timestart) {
			if (!($sqltimestart = wassUtil::checkTime($timestart)))
				$infmsg .= 'Start time must be in hh:mm format (use 24-hour notation). ';
		}
		else
			$sqltimestart = '';
		if ($timeend) {
			if (!($sqltimeend = wassUtil::checkTime($timeend)))
				$infmsg .= 'End time must be in hh:mm format (use 24-hour notation). ';	
		}
		else
			$sqltimeend = '';
			
		/* Make sure end time is greater than start time */
		if ($sqldateend) {
			if (!$sqltimeend)
				$ttimeend = '00:00';
			else 
				$ttimeend = $sqltimeend;
			if (!$sqltimestart)
				$ttimestart = '00:00';
			else 
				$ttimestart = $sqltimestart;
				
			$start = mktime(substr($ttimestart,0,2),substr($ttimestart,3,2),0,substr($sqldatestart,5,2),substr($sqldatestart,8,2),substr($sqldatestart,0,4));		
			$end = mktime(substr($ttimeend,0,2),substr($ttimeend,3,2),0,substr($sqldateend,5,2),substr($sqldateend,8,2),substr($sqldateend,0,4));		
			
			if ($start > $end)
				$infmsg .= 'Starting date/time must not be after ending date/time. ';
			
		}
		
		/* Make sure enough dates/starts were specified */
		if ($sqltimestart) {
			if (!$sqltimeend)
				$infmsg .= 'If you specify a start time, then you also need to specify an end time.';
			
		}
		
		if ($sqldateend && $sqltimeend) {
			if (!$sqltimestart)	
				$infmsg .= 'If you specify an end date and time, then you also need to specify a start time.';
		}
			
		/* Write out the data, if ok */
		if (!$infmsg) {
			if ($_SESSION['updating']) {
				$arglist  = 'SET summary=' . wassSQL::sqlSafe($sqlevent) . ', ' .
							'datestart=' . wassSQL::sqlSafe($sqldatestart)  . ',' .
							'dtstamp=' . wassSQL::sqlSafe(gmdate('Ymd\THis') . "Z");
				if ($sqldescription)
					$arglist .= ', description=' .  wassSQL::sqlSafe($sqldescription);
				else
					$arglist .= ", description=''";
				if ($sqllocation)
					$arglist .= ', location=' .  wassSQL::sqlSafe($sqllocation);
				else
					$arglist .= ",location=''";
				if ($sqltimestart)
					$arglist .= ',timestart=' .  wassSQL::sqlSafe($sqltimestart);
				else
					$arglist .= ",timestart=NULL";						
				if ($sqldateend)
					$arglist .= ',dateend=' .  wassSQL::sqlSafe($sqldateend);
				else
					$arglist .= ",dateend=NULL";
				if ($sqltimeend)
					$arglist .= ',timeend=' .  wassSQL::sqlSafe($sqltimeend);
				else
					$arglist .= ",timeend=NULL";
				/* Increment the sequence number */
				$arglist  .= ",sequence=sequence+1";
					
				$arglist .= ' WHERE (entryid=' . wassSQL::sqlSafe($_POST['entryid']) . ');';
			}
			else {
			  $arglist = '(' .
			  'icalendarid,' .
			  'summary,' .
			  'datestart';
			  if ($sqldescription) $arglist .= ',description';
			  if ($sqllocation) $arglist .= ',location';
			  if ($sqltimestart) $arglist .= ',timestart';				
			  if ($sqldateend) $arglist .= ',dateend';
			  if ($sqltimeend) $arglist .= ',timeend';
			  $arglist .= ',dtstamp,uid,sequence) VALUES (' . 
			  $fid . ',' . 	
			  wassSQL::sqlSafe($sqlevent) . ',' . 
			  wassSQL::sqlSafe($sqldatestart); 
			  if ($sqldescription) $arglist .= ',' . wassSQL::sqlSafe($sqldescription);
			  if ($sqllocation) $arglist .= ',' . wassSQL::sqlSafe($sqllocation);
			  if ($sqltimestart) $arglist .= ',' . wassSQL::sqlSafe($sqltimestart); 
			  if ($sqldateend) $arglist .= ',' . wassSQL::sqlSafe($sqldateend);
			  if ($sqltimeend) $arglist .= ',' . wassSQL::sqlSafe($sqltimeend);
			  $arglist .= ',' . wassSQL::sqlSafe(gmdate('Ymd\THis') . "Z") . ',' . 
			  wassSQL::sqlSafe(date('Ymd\THis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI']) . ',' .
			  '0' .
			  ');'; 
			}
			
			if (!$_SESSION['updating']) 
				$result = wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassIcalentry ' . $arglist);
			else 
				$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalentry ' . $arglist);
				
			
			if ($result) {			
				/* Update the event count */
				$fentry = getFile($fid);
				$events = $fentry['events'] + 1;
				wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET events=' . $events . ' WHERE  (icalendarid=' . $fid . ');');
				if ($_SESSION['updating'])
					$infmsg = 'Event updated';
				else
					$infmsg = 'Event added.';
				/* Clear fields */
				$event = "";
				$description = "";
				$location = "";
				$datestart = "";
				$timestart = "";
				$dateend = "";
				$timeend = "";
	
			}
			else
				$infmsg .= 'Event not added: Error executing: ' .  'UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET events=' . $events . ' WHERE  (icalendarid=' . $fid . ');:' . wassSQL::error();
				
			$_SESSION['updating'] = false;																																																																																																																																																										
		
		}
		else {
			if ($_SESSION['updating'])
				$infmsg = 'Event not updated: ' . $infmsg;
			else
				$infmsg = 'Event not added: ' . $infmsg;
				
		}
	}
	


	/* Update an event entry */
	if ($_POST['Update']) {
		/* First, determine which entry we are updating */
		$eid = substr($_POST['Update'],6);
		
		
		/* Make sure user owns this entry */
		$entry = getEntry($eid);
				
		/* Next, extract the current values */
		$event = $entry['summary'];
		$description = $entry['description'];
		$location = $entry['location'];
		$datestart = $entry['datestart'];
		$timestart = $entry['timestart'];
		$dateend = $entry['dateend'];
		$timeend = $entry['timeend'];
		
		/* Remember that we are doing an update */
		$_SESSION['updating'] = true;
		
	}
	
	
	
	if ($_POST['Remove']) {
		$eid = substr($_POST['Remove'],6);
		
		/* Make sure user owns this entry */
		$entry = getEntry($eid);
		
		/* Delete the entry by flagging it as deleted */
		
		$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalentry SET deleted=1 WHERE entryid = ' . $eid  . ' LIMIT 1;');
		/* Let the user know */
		if ($result) {
			$infmsg = 'Event removed.';
			/* Update the event count */
			$fentry = getFile($fid);
			$events = $fentry['events'] - 1;
			wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassIcalendar SET events=' . $events . ' WHERE  (icalendarid=' . $fid . ');');
		}
		else
			$infmsg = 'Event not removed: Error executing: ' . 'UPDATE ' . wassParms::DATABASE . '.wassIcalentry SET deleted=1 WHERE entryid = ' . $eid  . ' LIMIT 1;' . wassSQL::error();
		$_SESSION['updating'] = false;
		
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
<title>Create/Edit iCal file</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
  h2 {margin:0} 
  h3 {margin:0} 
  h4 {margin:0}
  #nomargins {margin:0} 
-->
</style>
<body>
<h1>Create/Edit iCal File</h1>
<?php if ($infmsg) echo "<p><i><b>" . $infmsg . "</b></i></p>";?>
<p>This utility allows you to create, edit and delete iCal files, 
 and makes these files available for access by end users who wish to add 
  events to their local calendaring application.</p>
<form id="makecal" name="makecal" method="post" action="<?php echo $_SERVER['SCRIPT_NAME'];?>">
<input type="hidden" name="submitted" value="submitted" />
<input type="hidden" name="entryid" id="entryid" value="<?php echo $eid;?>" />
<?php
if ($_SESSION['showinstructions']) {?>
<h2>Instructions:</h2>
<h3>Creating a File</h3>
<p>
To create a new (or your first) iCal file, enter a name in the <b>New file:</b> box, then click <i>Create</i>.  You should use a name that relates to the events you will be listing in the file, because local calendaring applications often display that name when they display the events.  The name needs to be a single word (use the underscore character to create multi-word names).</p>
<h3>Selecting a File</h3>
The <b>Files:</b> table below lists all of your iCal files (if any).
<p>To edit an existing file (e.g., add entries, delete entries, or modify entries), locate the file in the <b>Files:</b> table, then click on the corresponding  <i>Edit</i> link.  The entries (if any) for the file will be displayed in the <b>Events:</b> table.  If you want to see the contents of a file in iCal format, locate the file in the <b>Files:</b> table, then click on the corresponding <i>View</i> link.  If you previously created a file and want to delete it, or you have made some mistakes and want to restart, locate the file in the <b>Files:</b> table, then click on the corresponding <i>Delete</i> link. [WARNING: Deleted files cannot be recovered, and you will not be prompted for confirmation.]</p>
<h3>Renaming a File</h3>
<p>If you want to rename a file, locate the file in the <b>Files:</b> table, edit the name, then click on the corresponding <i>Rename</i> link. Renaming a file does not change the URL associated with the file; however, the file will appear to be a new calendar to anyone accessing the file, including people who have previously accesed it (so you should not rename a file once you have advertised it's URL).</p>
<h3>Editing a File</h3>
<p>
To add an event to the file, fill in the <b>New Event:</b> fields, then click <i>Save</i>. Keep entering event data in the <b>New Event:</b> fields and pressing <i>Save</i> until you have entered all of your events (you can add new events later by editing the file).
To view, update or remove an existing event, locate the event in the <b>Events:</b> table, then click the corresponding button. If you click <i>Update</i>, the event data will be displayed in the same fields as are used for entering a new event; you can then modify the entry and click <i>Save</i> to save your changes, or <i>Cancel</i> to leave the entry as is.
Once you are done editing the file, click the <i>Done</i> button.  This will cause the <b>Files:</b> table to be re-displayed, and you may select another file for editing (or create a new file, or leave this application).
</p>
<h3>Making a File Available</h3>
<p>Once you have created a file and entered your events, you can advertise the URL associated with the file, or any individual event, using the URLs listed in the <b>Files:</b>  and <b>Events:</b> tables.  Anyone invoking these URLs will get back the contents of the file or event, in iCal format.  The file URLs are displayedin two forms, one starting with 'http', the other with 'webcal'. The standard 'http:' prefix will cause most calendaring applications to download the file and its events once.  If you want the user to be able to "subscribe" to the calendar, you can either use the URL that starts with 'webcal://', or provide instructionson how various calendaring applications can subscribe to calendars using a 'http' URL. .  Not all calendaring applications accept the 'webcal://' URL prefix (e.g., Outlook 2003, Entourage), so you will have to decide how much information you want to provide.  If your calendar is static (you will not be adding events), then use 'http://' as a prefx. You can click on the displayed URLs to see how your browser handles them.</p>
<hl />
<input type="submit" name="Inshide" id="Inshide" value="Hide Full Instructions" /> 
<?php
} else {?>
<input type="submit" name="Insshow" id="Insshow" value="Show Full Instructions" /> 

<?php
}?>
<br /><br />
<?php if (!$selected) {?>
To create a new (or your first) iCal file, enter a name in the <b>New File Name:</b> box below, then click <i>Create</i>.
<table id="nomargins" border="1">
	<tr>
		<td><b>New File Name:</b></td>
		<td><input type="text" size="50" name="newfile" id="newfile"  /></td>
		<td>(Note: a ".ics" extension will be added to the end of the file name.)</td>
	</tr>
    <tr>
    	<td>Programmatic Password:</td>
        <td><input type="text" size="20" name="secret" id="secret"  /></td>
        <td>If you want a program to be able to update this file, enter a password (the program will need to supply this password). Leave blank if you will be updating the file through this web page.</td>
    </tr>
</table>
<input type="submit" name="Create" id="Create" value="Create" />
<br />
 <?php }
/* Display all of the user's files */
if (count($userfiles) && !$selected) {?>
<br />
<h2>Files:</h2> 
Your iCal files are listed below.  To edit, delete, or view (in iCal format) a file, locate it in the table and click the corresponding button. To rename a file, locate it, type in the new name in the <i>Filename box</i> , then click the corresponding <i>Rename</i> button.
<table id="nomargins" border="1">
	 <tr>
	 	<td>Filename</td>
		<td>Created</td>
		<td>Last Modified</td>
		<td>Last Access</td>
		<td>Events</td>
		<td>Accesses</td>
		<td>URL</td>
        <td>Program Password</td>
		<td>Action</td>
	</tr>
	 <?php
	 rewind($userfiles);
	 foreach ($userfiles as $file) {?>
	<tr>
		<td><input type="text" name="filename<?php echo $file['icalendarid'];?>" value="<?php echo wassUtil::safeHTML(substr($file['filename'],0,-4));?>" size="15" /></td>
		<td><?php echo wassUtil::usDate($file['created']);?></td>
		<td><?php if (!$file['updated']) echo "Never";
				      else echo wassUtil::usDate($file['updated']);?></td>
		<td><?php if (!$file['lastaccess']) echo "Never";
			          else echo wassUtil::usDate($file['lastaccess']);?></td>
		<td><?php echo $file['events'];?></td>
		<td><?php echo $file['usage'];?></td>
		<td><a href="<?php echo 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']) . '/retcal.php?id=' . $file['icalendarid'];?>">
        			<?php echo 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']) . '/retcal.php?id=' . $file['icalendarid'];?>
                    </a><br />
            <a href="<?php echo 'webcal://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']) . '/retcal.php?id=' . $file['icalendarid'];?>">
        			<?php echo 'webcal://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']) . '/retcal.php?id=' . $file['icalendarid'];?>
          </a>	
  		</td>
        <td><?php echo wassUtil::safeHTML($file['secret']);?></td>
        <td><input type="submit" name="Edit<?php echo $file['icalendarid'];?>" id="Edit" value="Edit" />&nbsp;&nbsp;
           <input type="submit" name="View<?php echo $file['icalendarid'];?>" id="View" value="View" />&nbsp;&nbsp; 
           <input type="submit" name="Delete<?php echo $file['icalendarid'];?>" id="Delete" value="Delete" />&nbsp;&nbsp;
           <input type="submit" name="Rename<?php echo $file['icalendarid'];?>" id="Rename" value="Rename" /></td>
	 </tr><br /><br /><?php
	}?>
  </table><?php
}

/* Display file contents, if requested */
if ($contents) {?>
	<br />
    <h2>Contents of File: <?php echo wassUtil::safeHTML($cname);?></h2>
    <hr />
    <pre><?php echo wassUtil::safeHTML(wassIcal::foldICAL($contents));?></pre>
 	<hr />
    <br />
<?php 
}


if ($selected) {?>
<p>&nbsp;</p>
<?php if (!$_SESSION['updating']) {?>
To add an event, fill in the fields below, then click <i>Save</i>.  Click <i>Done</i> when you are done entering events.
<h2>New Event for <?php echo wassUtil::safeHTML($selected)?>:&nbsp; &nbsp;&nbsp; &nbsp;<input type="submit" name="Done" id="Done" value="Done" /></h2><br /> 
<?php }
else {?>
To update the event, edit the fields below, then click <i>Save</i>.  Click <i>Cancel</i> to leave the event as is.
<h2>Edit Event in <?php echo wassUtil::safeHTML($selected)?>:&nbsp; &nbsp;&nbsp; &nbsp;<input type="submit" name="Cancel" id="Cancel" value="Cancel" /></h2><br /> 		
<?php 
}?>
<table id="nomargins" border="1">
	<tr>
		<td>Event Name:</td>
		<td><input type="text" name="event" id="event"  size="80" value="<?php echo wassUtil::safeHTML($event);?>" /></td>
	</tr>
	<tr>
		<td>Event Description (Leave blank if none):</td>
		<td><textarea cols="80" rows="4" name="description" id="description"  ><?php echo wassUtil::safeHTML($description);?></textarea></td>
	</tr>
	<tr>
		<td>Event Location (leave blank if none):</td>
		<td><input type="text" size="80" name="location" id="location"  value="<?php echo wassUtil::safeHTML($location);?>"  /></td>
	</tr>	
	<tr>
		<td>Start Date (mm/dd/yyyy):</td>
		<td><input type="text" size="11" name="datestart" id="datestart"  value="<?php if ($datestart) echo wassUtil::usDate($datestart);?>"  /></td>
	</tr>
	<tr>
		<td>Start Time (hh:mm, in 24-hour notation; leave blank if all-day event):</td>
		<td><input type="text" size="10" name="timestart" id="timestart"   value="<?php if ($timestart) echo $timestart;?>" /></td>
	</tr>
	<tr>
		<td>End Date (mm/dd/yyyy; leave blank if same as Start Date):</td>
		<td><input type="text" size="11" name="dateend" id="dateend"  value="<?php if ($dateend) echo wassUtil::usDate($dateend);?>"  /></td>
	</tr>
	<tr>
		<td>End Time (hh:mm, in 24-hour notation; leave blank if all-day event):</td>
		<td><input type="text" size="10" name="timeend" id="timeend"  value="<?php if ($timeend) echo $timeend;?>" /></td>
	</tr>
</table>
<input type="submit" name="Save" id="Save" value="Save"  /> &nbsp; &nbsp;
<?php if (!$_SESSION['updating']) {?>
	<input type="submit" name="Done" id="Done" value="Done" /><?php 
} 
else {?>
	<input type="submit" name="Cancel" id="Cancel" value="Cancel" />
<?php }?>

<p>&nbsp;&nbsp;</p>
<h2>Events: </h2>
<?php
/* Show entries, if any, else show that there are no entries */
$fentry = getFile($fid);
if (!$fentry['events'])
	echo 'None';
else { ?>
To update, view or remove an entry, locate it in the table, 
then click the corresponding button.
<table id="nomargins" border="1">
	<tr>
		<td>Name</td>
		<td width="20">Description</td>
		<td>Location</td>
		<td>Date Start</td>
		<td>Time Start</td>
		<td>Date End</td>
		<td>Time End</td>
        <td>URL</td>
		<td>Action</td>
	</tr> 
<?php
 /* Display all of the events (if any) */
$entries = getEntries($fid);
while ($entry = wassSQL::doFetch($entries)) {?>
	<tr>
		<td><?php echo wassUtil::safeHTML($entry['summary']);?></td>
		<td><?php echo wassUtil::safeHTML($entry['description']);?></td>
		<td><?php echo wassUtil::safeHTML($entry['location']);?></td>
		<td><?php echo  wassUtil::usDate($entry['datestart']);?></td>
		<td><?php if ($entry['timestart']) echo wassUtil::AmPm($entry['timestart']); else echo 'All Day';?></td>
		<td><?php if ($entry['dateend']) echo wassUtil::usDate($entry['dateend']); else echo wassUtil::usDate($entry['datestart']);?></td>
		<td><?php if ($entry['timeend']) echo wassUtil::AmPm($entry['timeend']); else echo 'All Day';?></td>
        <td><?php echo 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']) . '/retcal.php?eid=' . $entry['entryid'];?></td>
		<td><input type="submit" name="Update<?php echo $entry['entryid'];?>" id="Update" value="Update" />&nbsp; &nbsp;
        	<input type="submit" name="IcalView<?php echo $entry['entryid'];?>" id="View" value="View" />&nbsp; &nbsp;
			<input type="submit" name="Remove<?php echo $entry['entryid'];?>" id="Remove" value="Remove" /></td>
	</tr><?php	 
 		}?>
</table><?php
	}
}
?>
</form>
</body>
</html>
<!--                   End of HTML Code                       -->
<?php
/* Functions */

/* 
This function locates a file from an id number and makes sure the user is authorized to access it. 
	Arguments: the id number of the file record.
	Returns: the file record.
*/
function getFile($fid) {
	/* Return nothing if null argument */
	if (!$fid)
		return '';		
	/* Get the file record resource */
	$filerec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (icalendarid=' . $fid . ');'));
	if (!$filerec)
		die('Fatal error: File ' . $fid . ' does not exist.');
	if ($filerec['userid'] != $_SESSION['authid'])
		die('Fatal error: You do not have access to this file ' . $fid . '.');
	return $filerec;
}

/* 
This function locates a file from a name. 
	Arguments: the name of the file.
	Returns: the file record.
*/
function getName($fname) {
	/* Return nothing if null argument */
	if (!$fname)
		return '';		
	/* Get the file record */
	$filerec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (userid=' . wassSQL::sqlSafe($_SESSION['authid']) . ' AND filename = ' . wassSQL::sqlSafe($fname) . ');'));
	if (!$filerec)
		die('Fatal error: File ' . $fid . ' does not exist.');
	return $filerec;
}


/* This function reads all of the entries for a file into a resource.  
    Arguments:  The icalendarid of the file.
	Returns: A MySQL resource with all of the file entries (if any).
*/
function getEntries($fid) {
	/* Return nothing if null argument */
	if (!$fid)
		return '';	
	/* Return the file entries */
	return wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (deleted=0 AND icalendarid=' . $fid . ') ORDER by datestart, timestart;');
}


/* This function reads in an entry and makes sure the user owns it.
		Arguments: the id of the entry.
		Returns: the entry.
*/
function getEntry($eid) {
	/* Read in the entry */
	$entry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalentry WHERE (deleted=0 AND entryid=' . $eid . ');'));
	if (!$entry)
		die("Fata error: Entry $eid not found.");
	/* Read in the file record for the entry */
	
	$filerec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassIcalendar WHERE (icalendarid=' . $entry['icalendarid'] . ');'));
	if ($filerec['userid'] != $_SESSION['authid'])
		die("Fata error: You do not own entry $eid.");	
	return $entry;
}

/* This function reads through a MySQL resource of file entries and builds a complete iCal stream.
	Arguments: The resource that points to the file entries.
	Returns: A complete iCal stream.
*/
function buildIcal($resource) {
	
  /* Nothing in, nothing back */
  if (!$resource)
	  return '';

  /* Start from the top */
  rewind($resource);
  
  /* Build the stream */
  
  /* Start with the header information */
  $ical = "BEGIN:VCALENDAR\r\nPRODID:-//Princeton University Calendar\r\nVERSION:2.0\r\nMETHOD:PUBLISH\r\n";
  
  /* Now add in the events */
 while ($event = wassSQL::doFetch($resource)) {
	  
		  /* Convert the date/times to UTF */
		  list($ms,$ds,$ys,$j) = explode('/',wassUtil::usDate(trim($event['datestart']))); 
		  if (trim($event['dateend'])) 
			  list($me,$de,$ye,$j) = explode('/',wassUtil::usDate(trim($event['dateend'])));
		  else
			  list($me,$de,$ye,$j) = explode('/',wassUtil::usDate(trim($event['datestart'])));
				  
		  if (trim($event['timestart']))
			  list($sh,$sm,$j) = explode(':',trim($event['timestart']));
		  else 
			  $sh = '';
			  
		  if ($sh)
			  $dtstart = 'DTSTART:' . gmdate('Ymd\THis\Z',mktime($sh,$sm,0,$ms,$ds,$ys));
		  else
			  $dtstart = 'DTSTART;VALUE=DATE:' . gmdate('Ymd',mktime(0,0,0,$ms,$ds,$ys)); 
		  
	  
			  
		  if (trim($event['timeend']))
			  list($eh,$em,$j) = explode(':',trim($event['timeend']));
		  else
			  $eh = '';
			  
		  if ($eh) 
			  $dtend =  'DTEND:' . gmdate('Ymd\THis\Z',mktime($eh,$em,0,$me,$de,$ye));
		  else
			  $dtend = 'DTEND;VALUE=DATE:' . gmdate('Ymd',mktime(0,0,0,$me,$de,$ye));;
  
		  if (!$event['timeend'] && !$event['dateend'])
			  $dtend = '';
	  
	  
	  
		  $ical .= "BEGIN:VEVENT\r\n";
		  $ical .= "DTSTAMP:" . $event['dtstamp'] . "\r\n";
		  $ical .= "UID:" . $event['uid'] . "\r\n";
		  $ical .= $dtstart . "\r\n";
		  if ($dtend)
			  $ical .= $dtend . "\r\n";
		  if ($event['location'])
			  $ical .= "LOCATION:" . wassIcal::nlIcal($event['location']) . "\r\n";
		  $ical .= "SUMMARY:" . wassIcal::nlIcal($event['summary']) . "\r\n";
		  if ($event['description'])
			  $ical .= "DESCRIPTION:" . wassIcal::nlIcal($event['description']) . "\r\n";
		  $ical .= "SEQUENCE:" . $event['sequence'] . "\r\n";
		  $ical .= "CLASS:PUBLIC\r\n";
		  $ical .= "END:VEVENT\r\n";
  }
  /* Add trailer */
  $ical .= "END:VCALENDAR\r\n";
  
  /* Send it back */
  return $ical;
	  
}
?>