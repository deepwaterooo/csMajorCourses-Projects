<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        Describe this page.
 
*/


/* Handle loading of classes. */
function __autoload($class) {	/* Set path to wassParms and wassLocal */
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



/* Start session support */
session_start();

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';

/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}


/* Create form action variable */
$editFormAction = $_SERVER['SCRIPT_NAME'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . $_SERVER['QUERY_STRING'];
}


/* Determine the last date currently in the calendar */
$lastdate = wassSQL::doFetch(wassSQL::doQuery('SELECT `date` FROM ' . wassParms::DATABASE . '.wassAcCal ORDER BY  `date` DESC LIMIT 1'));
$lastdate = wassUtil::usDate($lastdate['date']);


/* 
1) Determine if we are being called to exit, to set the year, to process form data, or just to display the calendar.
*/
$action = "display";
if (isset($_POST['submit'])) {
	if ($_POST['submit'] == "exit") {
		die('bye');
	}
	elseif ($_POST['submit'] == "setyear") {
		header("Location: " . $_SERVER['SCRIPT_NAME'] . "?secret=" . wassParms::$PASS . "&year=" . $_POST["year"]);
		exit();
	}
	else {
		$action = "process";
	}
}

/*
2) Determine desired year, from form data or using current year.
*/


if (isset($_REQUEST['year'])) {
	$yearchar = trim($_REQUEST['year']);
}
else {
	$date = getdate();
	$yearchar = $date["year"];
}

$yearint = (int) $yearchar;
/* Compute value of year as a Unix timestamp */
$yearunix = mktime(3,0,0,1,1,$yearint,0);
$dayinseconds = 60*60*24;

/* 
3) If being called to process form, store the form data.

*/
if ($action == "process") {
	$message = '<em>The specified calendar data has been succesfully saved.</em><br />';
	$further = "further ";
	/* Save data out to the database */
		
	$newday = $yearunix - $dayinseconds;  /* Start at last day of previous year */
	for ($dayi = 1; $dayi <= 366; $dayi++) {  /* Leap years have 366 days */
		$newday += $dayinseconds;         /* Move to the next day of the year */
		$thisday = "day" . (int) $dayi;   /* Compute form variable name */
		if (isset($_POST["$thisday"])){         /* If form data available */
			$dayval = $_POST["$thisday"];       /* Get day type */
			$newdate = getdate($newday);     	/* Get the new date as an array */
			$monthofyear = $newdate["mon"];    	/* Get the month as a number */
			if (strlen($monthofyear) == 1) $monthofyear = "0" . $monthofyear; /* Make it 2 chars long */
			$dayofmonth = $newdate["mday"];    /* Get the month day as a number */
			if (strlen($dayofmonth) == 1) $dayofmonth = "0" . $dayofmonth; /* Make it 2 chars long */
			$datechar = $yearchar . '-' . $monthofyear . "-" . $dayofmonth;  /* Format the date */
			
			/* See if we already have an entry for the given date */
			$oldentry = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAcCal WHERE date=' . wassSQL::sqlSafe($datechar) . ';'));
			if ($oldentry) {
				/* If so, update it if necessary */
				if ($oldentry['daytypes'] != $dayval) {
					$result = wassSQL::doQuery('UPDATE ' . wassParms::DATABASE . '.wassAcCal SET daytypes=' . wassSQL::sqlSafe($dayval)  . ' WHERE date=' .  wassSQL::sqlSafe($datechar) . ';'); 
					if (!$result) die(wassSQL::error());
				}
			}
			/* If no old entry */
			else {
				/* Add an entry */
				$result = wassSQL::doQuery('INSERT INTO ' . wassParms::DATABASE . '.wassAcCal (date, daytypes) VALUES (' . wassSQL::sqlSafe($datechar) . ',' . wassSQL::sqlSafe($dayval) . ');');
				if (!$result) die(wassSQL::error()); 
			}
		}
	}		
}
else {
	$message = "";
	$further = "";
}
?>

<html>
<head>
<title>Set Calendar Day Types</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<link href="../pages/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body >
<h3 align="right"><em><?php echo wassParms::SYSID;?></em>&nbsp;</h3>
<h1 align="center">Set Calendar Day-Types for the year <?php echo $yearchar; ?></h1>
<?php if ($message <> "") echo "<p>$message</p>";?>
<blockquote>
  <p>Use this form to make any <?php echo $further ?>changes to the day-types
    for each day for the year . If you do not want to make any <?php echo $further ?>changes,
    click on any of the <em>Exit </em>buttons.
    Otherwise, make your changes and click on any of the <em>Submit </em>buttons.</p>
  <p>To make a change to a day-type, find the relevant day on the calendar, then
    check a day-type for that day. You may make changes to as many
    days as you like prior to clicking on the <em>Submit </em>button.</p>
	<p>To change the year, enter it as a four-digit number in the box below, then click <em>Reset Year</em></p>
	<p>&nbsp;</p>
	<p>The last entered date in the calendar is: <?php echo $lastdate ?></p>
</blockquote>
<p>&nbsp; </p>
<p>&nbsp;</p>

<form name="MakeCalendar" id="MakeCalendar" method="post" action="<?php echo $editFormAction; ?>">
<input type="text" name="year" value="<?php echo $yearchar;?>" /> 
<input type="submit" name="setyear" value="Reset Year" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<input type="submit" name="submit" value="submit" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
<input type="submit" name="submit" value="exit" />
<p></p>


<?php
/* 4) Create the calendar display from the calendar table, 
	setting the day types from any information existing in the calendar table. 
*/


/* Cycle through days of the year, setting up the form fields */
$curmonth = "";
$newmonth = "";
$newday = $yearunix - $dayinseconds;  /* Start at last day of previous year */

/* Put daytypes into an array */
$daytypes = explode(',',wassParms::DAYTYPES);

/* Associate a color with each daytype */
$daycolors = explode(',',wassParms::DAYCOLORS);

for ($i = 1; $i <= 366; $i++) {		  /* Leap years have 366 days */
	$newday += $dayinseconds;          /* Move to the next day of the year */
	$newdate = getdate($newday);       /* Get the new date as an array */
	if ($newdate['year'] <> $yearchar) break;  /* Get out if day=366 and not a leap year */
	$newmonth = $newdate["month"];     /* Get the month as a character string */
	$monthofyear = $newdate["mon"];    /* Get the month as a number */
	if (strlen($monthofyear) == 1) $monthofyear = "0" . $monthofyear; /* Make it 2 chars long */
	$dayofweek = $newdate["weekday"];  /* Get the day of week as a character string */
	$dayofmonth = $newdate["mday"];    /* Get the month as a number */
	if (strlen($dayofmonth) == 1) $dayofmonth = "0" . $dayofmonth; /* Make it 2 chars long */
	$datechar = $yearchar . '-' . $monthofyear . "-" . $dayofmonth;  /* Format the date */
	
    /* Read any data available about this date */
	$datetype = wassAcCal::daytype($datechar);
	$datecolor = $daycolors[array_search($datetype,$daytypes)];
	
	if ($newmonth != $curmonth) {      /* If it is a new month */
		if ($curmonth != "") {              /* If not first month, end previous table */
			echo "</table><br />\r\n";
			echo '<p align="center"><input type="submit" name="submit" value="submit" />' . "\r\n";  
			echo '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' . "\r\n";       
			echo '<input type="submit" name="submit" value="exit" /><br \><br \>' . "\r\n"; 
		}
		$curmonth = $newmonth;
	
		echo '<table align="center" border><tr><th align="center" colspan="7">';
		echo $curmonth . ' ' . $yearchar . '</th></tr>' . "\r\n" . '<tr align="center"><th width="14%">Su</th>' ."\r\n";
        echo '<th width="14%">Mo</th><th width="14%">Tu</th><th width="14%">We</th>';
		echo '<th width="14%">Th</th><th width="14%">Fr</th><th width="14%">Sa</th></tr>';
		echo "\r\n" . '<tr align="left">' . "\r\n";
		for ($day = 0;  $day < (int) $newdate["wday"]; $day++) {  /* If month does not start on Sunday */	
			echo '<td>&nbsp;</td>' . "\r\n";                                  /* Skip non-days */
		}
	}
	echo "\r\n<td";
	echo ' bgcolor="' . $datecolor . '">';
	echo $dayofmonth . "<br />\r\n";
	
	
	/* Display daytypes as checkboxes */
	for ($ai = 0; $ai < count($daytypes); $ai++) {
		echo '<input type=radio name="day' . (int) $i . '" value="' . $daytypes[$ai] . '"';
		if ($daytypes[$ai] == $datetype) 
			echo ' checked="checked"';
		echo '>' .  $daytypes[$ai] . "<br />\r\n";
	}
	echo "</td>\r\n";
	if ($dayofweek == "Saturday")  { /* If last day of the week */
		echo  '</tr>' . "\r\n\r\n" . '<tr align="left">'; /* Skip to the next row */
	}
}
echo '</table>';

?>
<p>&nbsp;</p>
<p align="center">
<input type="submit" name="submit" value="submit" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
<input type="submit" name="submit" value="exit" />
</p>

</form>
</body>
</html>
