<?php
/*

Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
			
			Thanks to Rhon Fitzwater of Rider University, who contributed a number of bug fixes.
			
*/


 

/* This script installs/customizes the WASS system, as follows:

The user is greeted and told about requirements for running the system.

The optional Blackboard web service is installed (offline).

The MySDQL database is created (offline).

If requested, the wassParms.class.php  file is built or updated with parameters
appropriate for the institution.

If requested, the SQL tables are built by invoking the maketables.php script.  

If requested, the calendar is created and/or updated by invoking the calendar.php file for the specified year.

The reminder function is set up.

Further customizations are discussed.

The system is invoked.

*/

/* Include utility class */
require_once('../classes/wassUtil.class.php');
/* Includde the SQL class */
require_once('../classes/wassSQL.class.php');	


/* Handle loading of any classes we forget to include. */
function __autoload($class) {
	include_once("../classes/$class.class.php");
}


/* Check for SSL connection. */
if (!$_SERVER['HTTPS'] && !$_REQUEST['nossl']) 
	die('The install.php script must be invoked using https.  If you really want to run this without SSL, append "&nossl=1" to the URL you used to invoke this script.'); 

/* Make sure we have unpacked the files, including the wassParms.template.php file. */

clearstatcache();

if (!file_exists('wassParms.template.php')) 
	die("Unable to find file 'wassParms.template.php'.  It appears that the WASS package has not been correctly
	 downloaded.  Be sure that all of the files are present and accessible to the web server.  Insturctions on downloading 
	 and unpacking the WASS distribution should be available from the download site (file INSTALL.TXT or README.TXT)."	
	 );

/* Figure out where we are */
$path = dirname($_SERVER['SCRIPT_FILENAME']);
	
	
$patha = explode('/',$path);  
$ppath = '';
for ($i=0; $i<(count($patha))-1;$i++) {
	$ppath .= $patha[$i] . '/';
}


/*
Init update message.
*/
$upmsg = '';

/* 
Make sure that the current parameters file, if it exists, contains all of the constants needed for the current version. 
*/

if (file_exists('../classes/wassParms.class.php') && $_REQUEST['submit'] == '') {
	
	/* Read the current file into a string. */
	$curfile = file_get_contents('../classes/wassParms.class.php');
	/* Read the template file into an array */
	$newfile = file('wassParms.template.php',FILE_SKIP_EMPTY_LINES);
	/* Find position of closing brace */
	$bracepos = strripos($curfile,'}');
	/* Save end of file string */
	$eof = substr($curfile,$bracepos);
	/* Strip the brace */
	$curfile = substr($curfile,0,$bracepos);
	/* Init array to keep track of needed changes */
	$add = array();


	/* Go through new file, and save any constants that do not exist in the current file */
	foreach ($newfile as $new) {
		/* If this is a constant declaration */
		if (($pos = strpos($new,'const ')) !== false) {
			/* extract the constant assignment */
			$assign = trim(substr($new,$pos+6));
			/* Split out the constant */
			list($constant,$junk) = explode(' ',$assign);
			$constant = trim($constant);
			/* If constant not in current file, save it */
			if (strpos($curfile, ' ' . $constant) === false) {
				if ($prevline) {
					$add[] = $prevline;
					$curfile .= $prevline;
				}
				$add[] = $new;
				$curfile .= $new;
				$prevline = '';
			}
		}
		elseif (strpos($new,'/*') !== false) {
			$prevline = $new;
		}
		else
			$prevline = '';
	}
	
	/* If anything to add, do it */
	if ($add) {
		/* Set up update message */
		$upmsg .= '<br />Your wassParms.class.php file has been updated.  The following constants were added:<br />';
		foreach($add as $line) {
			$upmsg .= $line . '<br />';	
		}
		
		/* Set up error message */
		$unable = 'This version of WASS includes some new class constants (in the wassParms.template.php file) that I am unable to add to the current parameters file (wassParms.class.php).  Please add these
		constants manually and re-run the install script.<br /><br />The constants are as follows:<br /><br />';
		foreach($add as $line) {
			$unable .= $line . '<br />';	
		}
		/* Test if we can write */
		if (!is_writable('../classes/wassParms.class.php'))
			die($unable);
		/* Open for write */
		$handle = fopen('../classes/wassParms.class.php','w');
		if (!$handle)
			die($unable);
		/* Close out the class */
		$curfile .= $eof;
		/* Now add the lines */
		if (!fwrite($handle,$curfile))
			die($unable);
	
		/* Close the file */
		fclose('../classes/wassParms.class.php');	
		
		/* Let user know he/she should run step 1 */
		$upmsg .= '<br />You should run the "BUILD PARAMTERS" step of this installation script to make sure that the correct values are assigned to these new constants.  You should also run the "BUILD TABLES" step to make sure your MySQL tables are up to date.<br /><br />';
		
	}
	else
		$upmsg .= 'If you are upgrading from an earlier release, you should, at a minimum, run the "BUILD TABLES" step to make sure your MySQL tables are up to date.';
		
	clearstatcache();
	
}



/*  
Check to see if wassParms.class.php file exists, and, if so, check the password and include it; 
*/
if (!file_exists('../classes/wassParms.class.php')) {
	$firsttime = true;
	include('wassParms.template.php');
}
else {
	$firsttime = false;
	include('../classes/wassParms.class.php');
}			


/* Strip slashes */
$pass = $_REQUEST['secret'];
if (get_magic_quotes_gpc())
	$pass = stripslashes($pass);


/* Check "secret" password */
if ($pass != wassParms::PASS) 
	die("Invalid password ... you must specify the secret password as an argument to install.php.  Instructions are included in the README.TXT file.");
 

 
/* Init error/inform messages */
$errmsg = '';  $infmsg = ''; $mstatus = '';

  

/* Special case the "save parameters" request */
if (trim($_REQUEST['submit']) == 'SAVE PARAMETERS') {
	saveparms($firsttime);	
	/* Re-display the form */		
	header('Location: install.php?secret=' . $pass . '&submit=' . urlencode('BUILD PARAMETERS') . '&msg=' . urlencode($mstatus));
}


/* Put out HTML header */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?php echo 'WASS Installation';?></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="profs.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
function OpenCal(password) {
  
  var sURL =  "calendar.php?secret=" + password + "&year=" + document.forms[0].txtParameter.value;
 
  window.open(sURL, "calendar", "scrollbars=yes");

}
</script>

 
</head>
<body>
<h3 id="id"><?php echo wassParms::SYSID;?></h3>
<h1 id="title">WASS Installation</h1>
<p></p>	

<?php


/* Switch based on what the user wants to do (what button was clicked, if any) */
$act = trim($_REQUEST['submit']);
switch($act) {
	/* First access (nothing submitted), show set parameters form */
	case "":
		greet($firsttime, $upmsg);
		break;
	case "EXIT":
		echo "Bye.";
		exit();
		break;
	case "SETUP BLACKBOARD":
		setupbb($firsttime);
		break;	
	case "CREATE DATABASE":
		buildbase($firsttime);
		break;
	case "BUILD PARAMETERS":
		buildparms($firsttime, "");
		break;
	case "BUILD TABLES":
		buildtables($firsttime);
		break;
	case "BUILD CALENDAR":
		buildcalendar($firsttime);
		break;
	case "SETUP REMINDERS":
		setrem($firsttime);
		break;
	case "ADMINISTRATION":
		administer($firsttime);
		break;
	case "FURTHER CUSTOMIZATION":
		further($firsttime);
		break;	
	case "TRY IT":
		tryit($firsttime);
		break;
	default:
		greet($firsttime,$upmsg);
		break;
}
?>
</body>
</html>
<?php
exit();


/* 
Greet the user, and present a menu of actions.
*/ 

function greet($firsttime,$upmsg) {
	global $pass;

/* Lets put out a header message */
	if ($firsttime) {
?>
<p>Welcome to the <strong>Web Appointment Scheduling System. </strong></p>
<p>This appears to be your first use of the system.</p>
<p> This script will take you through the installation procedure. Once done, you should have a 
working system that has been customized to your environment. </p>
<p>
Note: Certain steps of the installation require that a new browser window be opened.  
You may need to enable pop-ups in your browser for this to work.</p>
<p>The WASS system requires access to the following:</p>
<ol>
  <li>A LAMP server running Apache and PHP 5+.</li>
  <li>The following RPM packages: mod_ssl, php-xml, php-ldap, php-soap and elinks. (The mod_ssl install 
  will also do dependent updates of the distcache and httpd packages.)
  <li>An account on that server in which WASS will be installed (probably the directory account 
  you are using now to run this script).
  Typically this would be somewhere in your Apache document root structure. 
  It is VERY IMPORTANT that the WASS files not be viewable by anyone 
  execpt the Apache server and administrators. 
  The database password and other key information is stored in 
  the &quot;classes/wassParms.class.php&quot; file in this account. 
  A typical way of doing this is to set permissions on the directories/files to make them 
  readable only by the owner and group (no &quot;other&quot; permissions), and to 
  assign the files to the same group as the Apache server. 
  Another approach is to install the files on a server that is only login-accessible 
  to a limited set of folks. </li>
  <li>A MySQL 3+ server and a database on the server. WASS creates tables within this database. 
  The table names cannot be changed (without modifying the code), 
  so you probably want to create a separate database just for WASS to avoid table name conflicts. WASS will want to know the MySQL server name (connection string), and the database username and
  password.</li>
  <li>
  An LDAP (including Active Directory) or a CAS server (Central Authentication Service) for performing user authentication (login).  WASS cannot run without either LDAP, AD  or CAS for authentication (unless you want to re-write the authentication code located in classes/wassDirectory.class.php).  [Note: WASS 3.0.2+ includes a primitve local password facility that you can use if you are not running LDAP, AD or CAS. More information about this facility can be found in the local_user.txt file].</li>
  <li>
  An LDAP (including Active Directory) server for directory lookups.  WASS expects to be able to lookup people's office locations, telephone numbers, and other particulars by using LDAP.  If you are not running an LDAP (or AD) server, or it does not contain directory information about users at your institution, you can still run WASS; users will have to fill in this information themselves whenever they use the system (e.g., schedule appointments).  You can use LDAP or AD for both user authentication and for directory lookups, or you can use CAS for user authentication and LDAP or AD for directory lookups. [Note: WASS 3.0.2+ includes a primitve local password facility that you can use if you are not running LDAP. More information about this facility can be found in the local_user.txt file].
  </li>
  <li>Information about the academic calendar at your institution. 
  As part of the installation, you will create a calendar that assigns 
  each day of the year to a specific day &quot;type&quot;, where a &quot;type&quot; 
  corresponds to the way your academic calendar categorizes days of the year. 
  For example, days at your institution might fall into the following 
  mutually-exclusive classes: 
  &quot;vacation&quot;, &quot;holiday&quot;, &quot;spring break&quot;, 
  &quot;winter break&quot;, &quot;teaching day&quot;. 
  Consult your academic calendar and be sure you know what are all the possible
  day types at your institution. </li>
</ol>
<p>If you are ready to begin, continue reading below. If not, simply exit this 
script (close your browser, or go to a different URL) and re-invoke it when you are ready.</p>
<p>&nbsp;</p>
<p>INSTALLATION:</p>
<p>The installation consists of a series of steps, as follows:</p>
<ol>
	<li>
    Installation of the optional Blackboard web service.  WASS comes with a Blackboard plugin which implements a web service that allows WASS
    to dynamically determine if a given user is enrolled in a given course.  This allows WASS to implement access restrictions to calendars based on
    course enrollment.  For this plugin to work, you need to be running the enterprise version of the Blackboard LMS.  This is purely optional.  If you are not running
    the Blackboard LMS (enterprise version), or you don't want to bother with this service, then you can simply skip this step.</li>
    <li>
     Creration of the MySQL database which will be used by WASS.  This has to be done offline.  The WASS installation requires the name of the MySQL server (actually the connection string to access this server), the database name, the database username and the database password.                
    </li>
  <li>
    Creation of the &quot;classes/wassParms.class.php&quot; file, which contains 
	global variable settings for such things such as the name of your MySQL server, 
	your MySQL database name and password, the name of your institution, etc. 
	You can manually edit this file at any time, or simply re-run this script to 
	reset the values in this file. Every WASS script includes this file. One variable in 
	this file is treated in a special way ... the MySQL database password also becomes 
	the administrator password for WASS. Once set, you will need to specify that password 
	to re-invoke this script. You specify it as a GET argument, 
	as follows: https://path-to-wass/admin/install.php?secret=password. That is, you invoke 
	this script with a URL argument of 'secret=password', where 'password' is whatever 
	you have set as the MySQL password for the WASS database.<p>
      The hardest part of this step is defining the types of days available on 
	  your institution's academic calendar. 
	  WASS classifies every day of the year as being of a certain &quot;type&quot;, 
	  where you define the types. Typical types might be 
	  &quot;holiday&quot;, &quot;teaching day&quot;, &quot;exam period&quot;, 
	  &quot;spring break&quot;, &quot;summer break&quot;, etc. 
	  Any given day can only belong to one type, so you have to define an 
	  inclusive set of day types that will cover your entire academic calendar. 
	  The reason for doing this is that, when creating calendars, WASS can respect 
	  day types when deciding if a given day should/should not be part of a block of available time. 
	  For example, suppose a professor has her office hours on Tuedays from 1 to 2pm and 
	  on Saturdays from 9:30 am to 11:30 am. They probably DON'T want to include Tuesdays 
	  and Saturdays that fall during winter vacation, or spring break. 
	  When they create their office hours, they specify which day types they want to 
	  include in their office hours, and WASS figures out what days to include based 
	  upon the academic calendar. To do this, 
	  WASS needs to know what the various day types are, and 
  then which days belong to which types (you specify both of these things during the installation).</p> <p>
  Do NOT define "weekend" as a day type.  When creating schedules, people specify 
      which days
      of the week they want for their office hours, and, typically, they would not 
      include Saturdays and Sundays.  Weekend days should be classified like any
      other day of the week ... that is, into one of the day type categories
  you define.</p> </li>
  <li> Once the classes/wassParms.class.php file is set, the next step is to create the MySQL 
  tables used by WASS . This script uses the values you specified in creating the
  wassParms.class.php file
  to create to MySQL tables (e.g., the name of the MySQL server, the name of the WASS database, the MySQL database password, etc.). If, when you get to this step, 
  you are not ready to proceed, or errors are encountered while creating the tables, 
  you can exit this script and re-invoke it later ... you will have the option of 
  skipping earliet steps and going to this step to continue the installation.<br />
  </li>
  <li>The next step is to set up the academic calendar for your institution. 
  WASS uses the day types you defined in step 1, and presents you with a calendar on 
  which you can assign each day to a day type. You should run this step for at least 
  the current and the following year, so 
  that faculty members can set up calendars that extend over a full academic year.  
  If you're 
  not ready to do this now, you can skip this step and return to it later 
  (you will be able to skip earlier steps when you re-invoke this script). However, 
  people will not be able to correctly create office hour blocks until you have 
  completed this step (WASS will assume that every day of the year is available 
  for scheduling; if that is what you want, then you can skip creation of the academic calendar).
  </li>
  <li>The last step is to arrange for the admin/remind.php script to be run every evening 
  (or whenever you want it to run). This script sends out email reminders about pending 
  appointments (appointments scheduled the following day). It also emails statistics about its actions to a sysadmin (specified in the classes/wassParms.class.php file). Typically, you would use CRON to schedule the invovation 
  of this script via a line-mode html client. The script must be invoked with the MySQL 
  password passed as a GET argument. A typical crontab entry might be:<br />
    0 5 * * * /usr/bin/elinks &quot;https://path_to_WASS/admin/remind.php?secret=mysqlpassword&quot; 
  </li>
  <li>
  The installation script ends with a description of the administration of WASS and further customizations you may wish to undertake.</li>
</ol>
<p>
If you are ready to begin, click the 'SETUP BLACKBOARD' button below (you will be given the option of skipping this step).  If not, click the
'EXIT' button, and re-invoke this script when you are ready.</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="Greet" id="Greet">
<p></p>   
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="SETUP BLACKBOARD" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
</tr>
</table>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</form>
<?php
	}
	else {
?>
<p>Welcome to the <strong>Web Appointment Scheduling System. </strong></p>
<p>You appear to have used the system before.</p>
<?php echo $upmsg;?>
<p>
To setup your Blackboard web service, click on SETUP BLACKBOARD.<br />
To create your MySQL database, click on CREATE DATABASE.<br />
To build or update your parameters file, click on BUILD PARAMETERS.<br />
To build or update your MySQL tables, click on BUILD TABLES.<br />
To build or update your academic calendar, click on BUILD CALENDAR.<br />
To set up the reminder function, click on SETUP REMINDERS.<br />
To learn about administering WASS, click on ADMINISTRATION.<br  />
To learn about further customizations, click on FURTHER CUSTOMIZATION.<br />
To test the system, click on TRY IT.<br />
To exit this script, click on EXIT.<br />
</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME'];?>" method="post" name="Greet" id="Greet">
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="SETUP BLACKBOARD" /></td>
<td><input type="submit" name="submit" id="submit" value="CREATE DATABASE" /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD PARAMETERS" /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD TABLES" /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD CALENDAR" /></td>
</tr>
<tr>
<td><input type="submit" name="submit" id="submit" value="SETUP REMINDERS" /></td>
<td><input type="submit" name="submit" id="submit" value="ADMINISTRATION" /></td>
<td><input type="submit" name="submit" id="submit" value="FURTHER CUSTOMIZATION" /></td>
<td><input type="submit" name="submit" id="submit" value="TRY IT       " /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
</tr>
</table>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</form>

<?php
	}
}
/* End of Greet function */


/* Tell the user about how to setup the BB web service. */
function setupbb($firsttime) {
global $pass;
?>
<h1>Setup BLACKBOARD Web Service</h1>
<p></p>
<p>WASS includes Java code which implements a web service that allows WASS to implement calendar access restrictions based on course enrollment (e.g., "only students enrolled in my English 101 course are allowed to make appointments with me.").  This service will only work if you are running the enterprise version of the Blackboard LMS. The installation of this web service is done completely independently of this installation script.  There is a seperate set of instructions for completing this installation in the following file:</p>
<p><br />
  blackboard/README.txt </p>
<p>
You do not need to install this service to run WASS ... it is purely optional.  During a later stage of the installation, you will tell WASS whether or not you have installed this web service.  You can also install this service at a later time, and then simply tell WASS that the service has been installed (by setting some constants in the classes/wassParms.class.php file ... instructions follow).
</p>
<p>
If you are NOT running the Blackboard LMS but would still like to support course-based access restrictions, you will need to modify the code in the "IsUserInCourse" and "IsCourseValid" functions of the classes/wassLocal.class.php file.  WASS does not come with a wassLocal.class.php file; instead, it has a file called wassLocal.template.php in the "admin" directory  which contains stub code for the above two functions (and other user exits).  You can copy this template file into the "classes" directory and name it "wassLocal.class.php".  You then add your code to this file (replacing the provided stub code).   The "IsUserInCourse" function is called by WASS with two arguments:  the userid of the target user, and the courseid of the target course.  It returns a boolean (yes/no) which tells WASS whether or not the target user is enrolled in the target course.  The "IsCourseValid" function is called with one argument: a courseid. It returns a boolean that tells WASS whether or not the courseid is valid at your school.    If you do implement these functions for a non-Blackboard LMS, I would very much appreciate getting a copy of the code.
</p>
<p>
If you wish to install the web service, click on EXIT, follow the instructions in the blackboard/README.TXT file, then re-run this install.php script.</p>
<p>
If you don't want to install the web service at this time, or you have already installed the service and wish to proceed to the next step in the installation, click on
CREATE DATABASE (you will be given the option to skip this step if you have already run it).</p>
<p></p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="Greet" id="Greet">
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="CREATE DATABASE" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
}

/* Tell the user about how to create the MySQL database. */
function buildbase($firsttime) {
global $pass;
?>
<h1>Create MySQL Database</h1>
<p></p>
<p>WASS requires access to a MySQL database.  You must create such a database (or use an existing database) before you can continue with the WASS installation.  This step must be done offline (creation of databases is highly installation dependent, so this script will not attempt to carry it out).</p>
<p>
WASS will need to know the following about the MySQL database:</p>
<ol>
<li>The hostname of the MySQL database server, or, if the MySQL database is running on the same server as WASS, the PHP connection string to be used to connect to the server.  (Further instructions about this are given below, in the step where you specify the parameters for WASS).</li>
<li>The username of the MySQL user that owns the database.</li>
<li>The password for the database.
</li>
</ol>
WASS will pass these three parameters to the mysql_connect PHP function, so, if you are unclear about what is needed, check the documentation for this function (http://us.php.net/mysql_connect). 
<br />
It is recommended that you create a new database for WASS.  However, you can use an existing database as long as the WASS table names do not conflict with tables that already exist in this database.  The full list of WASS database tables is contained in the maketables.php script (in the same directory as this script).
<p>
If you need to create the MySQL database, or you need to select an existing database for WASS to use, click on EXIT, then re-run this install.php script when the database exists (you do NOT need to create the tables ... WASS will do that in a following step).</p>
<p>
If you have already created or selected the database and wish to proceed to the next step in the installation, click on
BUILD PARAMETERS (you will be given the option to skip this step if you have already run it).</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="Greet" id="Greet">
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="BUILD PARAMETERS" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>

</tr>
</table>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</form>

<?php
}


/* Build or update the parameters file (wassParms.class.php) */

function buildparms($firsttime, $msg='') {
global $pass;
?>
<h1>Build Parameters (set values in the classes/wassParms.class.php file)</h1>
<?php
if (!$msg)
	$msg = urldecode($_REQUEST['msg']);
	
if ($msg)
		echo '<p><h2>' . $msg . '</h2></p>';?>
	<p><?php
if (!$firsttime) {?>
	The current parameters in your classes/wassParms.class.php file are displayed below.  If you wish to
	make any (further) changes, edit the displayed values, then click on SAVE PARAMETERS.  If you do not need
	to make any further changes, click on BUILD TABLES to go to the MySQL table build step (you will be given the option of skipping this step), or on
	EXIT to leave.</p>
<?php 
}
else {?>
	<p>
	The operation of WASS is completely controlled by the values assigned to a set of constants in the classes/wassParms.class.php file.  Every script in WASS includes this file.  WASS is shipped with a template version of this file.  In this step you assign locally-appropriate values to the constants in this file.  At any time, you can edit this file if you wish to reset the operation of WASS.  For example, there is a constant named RUNNING which determines whether or not WASS is running (available).  If you set this variable to 0 (false), WASS will quit with an error message whenever someone tries to run any of the WASS scripts (except this and the other admin scripts). 
	</p>
	<p>
	Many of the values in the classes/wassParms.class.php file have been set to defaults which may be appropriate for your installation.  Others will need to be set by you (they are set to dummy defaults).  Values which you MUST set are indicated with asterisks in the form below.  Take your time setting the values.  You can always re-run this script to modify any of the values (or simply manually edit the classes/wassParms.class.php file).  Once you have set your values, click on the
	SAVE PARAMETERS button to save your parameters (create or 
	update the classes/wassParms.class.php file). 
	</p>
	<p>
	If you are unsure about how to set a value, or you need to gather some information, or you need to re-run an earlier installation step, simply click EXIT and re-invoke this script when you are ready.
	</p>
	<p>
	WARNING:  the 
	MySQL database password you specify below will become the password you must use whenever you invoke this or any of the admin scripts (e.g., https://path-to-wass/admin/install.php?secret=MySQLpassword).  So, if you set this paramater and save the parameters, when you next invoke this script, you will need to specify this MySQL password as an argument on the URL.  
	</p>
	<p></p>
	<p>
	The current values of your parameters (classes/wassParms.class.php) are shown below.  If you need
	to make any changes, edit the values displayed in the form, and click on the 
	SAVE PARAMETERS button.
	If the current values are OK and you don't want to make any more changes, 
	click on BUILD TABLES to go to the MySQL table build step (you will be given the option of skipping this step), or on
	EXIT to leave.</p>
<?php
}?>

<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="BuildParms" id="BuildParms">  
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="SAVE PARAMETERS " /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD TABLES" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
</tr>
</table>

<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     Local institution names/parameters.   
	</th>
	</tr>	
    <tr> 
      <th align="left">*DOMNAME</th>
      <td><input name="MMDOMNAME" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::DOMNAME);?>" /></td>
      <td>The DNS domain name of your institution.  Usually something like institution.edu.
	  It's also usually what people put after their username to form their email address.  At
	  Princeton, it is: princeton.edu</td>
	  <input type="hidden" name="EXDOMNAME" value='The DNS domain name of your institution.' />
    </tr> 
    <tr> 
      <th align="left">*INSNAME</th>
      <td><input name="MMINSNAME" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::INSNAME);?>"></td>
      <td>The (short) name of your institution.  At Princeton, this is Princeton.</td>
	  <input type="hidden" name="EXINSNAME" value='The short name of your institution.' />
    </tr> 
    <tr> 
      <th align="left">*INSFNAME</th>
      <td><input name="MMINSFNAME" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::INSFNAME);?>"></td>
      <td>The (long) name of your institution.  At Princeton, this is Princeton University.</td>
	  <input type="hidden" name="EXINSFNAME" value='The long name of your institution.' />
    </tr> 
        <tr> 
      <th align="left">*INSHOMELINK</th>
      <td><input name="MMINSHOMELINK" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::INSHOMELINK);?>"></td>
      <td>The link (URL) for your institution home page.  At Princeton, this is http://www.princeton.edu.</td>
	  <input type="hidden" name="EXINSHOMENAME" value='The link (URL) to your institution home page.' />
    </tr> 
     <tr> 
      <th align="left">*INSHOMELOGO</th>
      <td><input name="MMINSHOMELOGO" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::INSHOMELOGO);?>"></td>
      <td>The name of the file (in the WASS "images" directory) that can be used to represent the INSHOMELINK (e.g., point to your home page).</td>
	  <input type="hidden" name="EXINSHOMELOGO" value='The name of your institution home page logo file.' />
    </tr> 
    <tr> 
      <th align="left">*NETID</th>
      <td><input name="MMNETID" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::NETID);?>"></td>
      <td>Word pr phrase used at your instituion for 'netid' or 'userid'. </td>
	  <input type="hidden" name="EXNETID" value='The word/phrase used to refer to a netid/userid.' />
    </tr> 
    <tr> 
      <th align="left">*PASSNAME</th>
      <td><input name="MMPASSNAME" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::PASSNAME);?>"></td>
      <td>Word or phrase used at your instituion to refer to a password.  At Princeton this is "LDAP password".</td>
	  <input type="hidden" name="EXPASSNAME" value='Phrase used to label a password.' />
    </tr> 
    <tr> 
      <th align="left">*HELPNETID</th>
      <td><input name="MMHELPNETID" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::HELPNETID);?>"></td>
      <td>The URL of a web page that provides information on netids at your institution.</td>
	  <input type="hidden" name="EXHELPNETID" value='URL for a help page on netids.' />
    </tr> 
    <tr> 
      <th align="left">*HELPPASS</th>
      <td><input name="MMHELPPASS" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::HELPPASS);?>"></td>
      <td>The URL of a web page that provides information on passwords at your institution.</td>
	  <input type="hidden" name="EXHELPPASS" value='URL for a help page on netids.' />
    </tr> 
     <tr> 
      <th align="left" width="10%">*SYSID</th>
      <td width="58%"><input name="MMSYSID" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::SYSID);?>"></td>
      <td>The name of this system, as it appears to the user on various web pages.</td>
	  <input type="hidden" name="EXSYSID" value='The name of this system, as it appears to the user on various web pages.' />
    </tr>
    <tr> 
      <th align="left" width="10%">*NAME</th>
      <td width="58%"><input name="MMNAME" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::NAME);?>"></td>
      <td>The name of the thing being scheduled by the system.</td>
	  <input type="hidden" name="EXNAME" value='The name of the thing being scheduled.' />
    </tr> 
</table>


<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following switches allows you to turn the system ON or OFF.  
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*RUNNING</th>
      <td width="58%">
	  <input name="MMRUNNING" size="70" value="<?php echo wassParms::RUNNING;?>" />
	  </td> 
      <td>Set to 1 to turn the system on, to 0 to turn the system off (e.g., for maintenance). </td>
	  <input type="hidden" name="EXRUNNING" value='Turn the system ON or OFF.' />
      <input type="hidden" name="INTRUNNING" value='1'  />
    </tr> 	  
    <tr> 
      <th align="left" width="10%">DOWNMSG</th>
      <td width="58%">
	  <input name="XXDOWNMSG" type="text" size="55" maxlength="255" 
	  value="<?php echo wassParms::DOWNMSG;?>"></td>
      <td>Message to display when the system is down (e.g., when RUNNING is set to 0).  Value is ignored if RUNNING is set to 1.</td>
	  <input type="hidden" name="EXDOWNMSG" value='Message to display when the system is down (RUNNING=0).' />
    </tr>
    <tr> 
      <th align="left" width="10%">*REQSSL</th>
      <td width="58%">
	  <input name="MMREQSSL" size="70" value="<?php echo wassParms::REQSSL;?>" />
	  </td> 
      <td>Set to 1 to require SSL (HTTPS), to 0 to not require SSL. You should set this to 1 is you are using LDAP or AD or the local table for authentication, because WASS will prompt for a userid and password.</td>
	  <input type="hidden" name="EXREQSSL" value='Require SSL connection (HTTPS).' />
      <input type="hidden" name="INTREQSSL" value='1'  />
    </tr> 	  
</table>
	  
<p></p> 
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following values define your MySQL parameters (MySQL database that will store the WASS data).  
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*HOST</th>
      <td width="58%">
	  <input name="MMHOST" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::HOST);?>"></td>
      <td>Hostname of the machine running the MySQL service (used in mysql_connect call).  If MySQL is running on a different server from WASS, this would typically be the actual hostname of the MySQL server, possible followed by a colon and a port number.  If MySQL is running on the same server as WASS, this would be a socket description of the form ":/path-to-mysql/mysql/data/mysql.sock".  (The person who set up the MySQL server should be able to provide you with this information).</td>
	  <input type="hidden" name="EXHOST" value='Hostname of the machine running the MySQL service, or path to socket file (used in mysql_connect call).' />
    </tr>
    <tr> 
      <th align="left">*DATABASE</th>
      <td><input name="MMDATABASE" type="text" size="55" maxlength="255"
	  value="<?php echo formsafe(wassParms::DATABASE);?>"/></td>
      <td>Name of MySQL database for storing WASS tables.</td>
	  <input type="hidden" name="EXDATABASE" value='Name of MySQL database for storing WASS tables.' />
    </tr>
    <tr> 
      <th align="left">*USER</th>
      <td><input name="MMUSER" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::USER)?>"/></td>
      <td>Userid associated with the MySQL database.</td>
	  <input type="hidden" name="EXUSER" value='Userid associated with the MySQL database.' />
    </tr> 
	<tr> 
      <th align="left">*PASS</th>
      <td><input name="MMPASS" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::PASS);?>"></td>
      <td>Password associated with the MySQL database.  This also becomes the administrative 
	  password used to re-run this script (and all of the other scripts in the admin directory of WASS). Warning: BE SURE THAT THE wassParms.class.php FILE CANNOT BE READ 
	  BY USERS, as this password will be stored in clear text in that file.</td>
	  <input type="hidden" name="EXPASS" value='Password associated with the MySQL database. This also becomes the administrator password.' />
    </tr> 
</table>


<p></p>
<table border="2">
	<tr> 
     <th align="left" colspan="3" id="describe">
     The following value controls how WASS will authenticate users.
	</th>
	</tr>
    <tr> 
      <th align="left">*AUTHTYPE</th>
      <td><input name="MMAUTHTYPE" type="radio" value="LDAP" <?php if ((wassParms::AUTHTYPE == wassParms::AUTHLDAP) || (wassParms::AUTHTYPE == wassParms::AUTHAD)) echo 'checked="yes"';?>/><?php echo wassParms::AUTHLDAP;?>
          <input name="MMAUTHTYPE" type="radio" value="CAS" <?php if (wassParms::AUTHTYPE == wassParms::AUTHCAS) echo 'checked="yes"';?>/><?php echo wassParms::AUTHCAS;?>
    	  <input name="MMAUTHTYPE" type="radio" value="LOCAL" <?php if (wassParms::AUTHTYPE == wassParms::AUTHLOCAL) echo 'checked="yes"';?>/><?php echo wassParms::AUTHLOCAL;?> 
     </td>
      <td>The type of user authentication you want WASS to perform, either LDAP (including Active Directory) or CAS (Central Authentication Service) or LOCAL (you maintain a private user/password database in the wassUser table).</td>
      <input type="hidden" name="EXAUTHTYPE" value='The type of authentication performed by WASS.' />
      <input type="hidden" name="MMAUTHCAS" value='CAS' />
      <input type="hidden" name="MMAUTHLDAP" value='LDAP' />
      <input type="hidden" name="MMAUTHAD" value='AD' />
      <input type="hidden" name="MMAUTHLOCAL" value='LOCAL' />
    </tr>  
</table>


<p></p>
<table border="2">
	<tr> 
     <th align="left" colspan="3" id="describe">
     The following values control use of CAS for authentication.  If you are not using CAS (you have set your authentication type to LDAP) leave these values as is (they will be ignored).
	</th>
	</tr>
    <tr> 
      <th align="left">CASversion</th>
      <td><input name="XXCASversion" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CASversion); ?>"></td>
      <td>Version of CAS you are running. Required for
	  CAS authentication. </td>
	  <input type="hidden" name="EXCASversion" value='Version of CAS.' />
    </tr>        
    <tr> 
      <th align="left">CAShost</th>
      <td><input name="XXCAShost" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CAShost); ?>"></td>
      <td>Hostname ofthe CAS server. Required for
	  CAS authentication. </td>
	  <input type="hidden" name="EXCAShost" value='Host of CAS.' />
    </tr>        
    <tr> 
      <th align="left">CASport</th>
      <td><input name="XXCASport" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CASport); ?>"></td>
      <td>Port on which CAS is running. Required for
	  CAS authentication. </td>
	  <input type="hidden" name="EXCASport" value='CAS port.' />
      <input type="hidden" name="INTCASport" value='1'  />
    </tr>        
    <tr> 
      <th align="left">CASuri</th>
      <td><input name="XXCASuri" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CASuri); ?>"></td>
      <td>CAS uri.  Required for CAS authentication.</td>
	  <input type="hidden" name="EXCASuri" value='CAS uri.' />
    </tr>        
    <tr> 
      <th align="left">CASname</th>
      <td><input name="XXCASname" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CASname); ?>"></td>
      <td>The name you use to refer to CAS at your institution (e.g., "CAS", or "Central Authentication System", or whatever you use).</td>
	  <input type="hidden" name="EXCASname" value='CAS.' />
    </tr>        
      <tr> 
      <th align="left">CASlogout</th>
      <td><input name="XXCASlogout" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::CASlogout); ?>"></td>
      <td>The full URL (starting with http) that is used to log out of CAS at your institution.</td>
	  <input type="hidden" name="EXCASlogout" value='CAS logout URL.' />
    </tr>        
</table>


<p></p> 
<table border="2">
	<tr> 
     <th align="left" colspan="3" id="describe">
     The following values define your LDAP (including Active Directory) environment.  Please fill in the LDAP (or AD) information even if you are using CAS for authentication.  WASS uses LDAP for directory lookups.  Leave the LDAP field blank only if you are not running an LDAP (or AD) server.
	</th>
	</tr>
    <tr> 
      <th align="left">LDAP</th>
      <td><input name="XXLDAP" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAP); ?>"></td>
      <td>Hostname of LDAP or AD (Active Directory) server. Required for
	  LDAP or AD authentication and for directory lookups. </td>
	  <input type="hidden" name="EXLDAP" value='Hostname of LDAP or AD server. Required for LDAP or AD authentication, and for directory lookups.  If you are not using LDAP or AD or CAS, you will need to modify the Idcheck and getlDIR functions in winDirectory.class.php' />
    </tr>  
	<tr> 
      <th align="left">LPORT</th>
      <td><input name="XXLPORT" type="text" size="55" maxlength="255"  
	  value="<?php echo formsafe(wassParms::LPORT);?>"></td>
      <td>TCP port for connection to the LDAP or AD server (usually 636).</td>
	  <input type="hidden" name="EXLPORT" value='TCP port for connection to the LDAP server (usually 636).' />
    </tr>  
	<tr> 
      <th align="left">BDN</th>
      <td><input name="XXBDN" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::BDN);?>"></td>
      <td>LDAP or AD base domain name (distinquished name). Required for LDAP or AD authentication and directory lookups.</td>
	  <input type="hidden" name="EXBDN" value='LDAP base domain name (distinquished name).' />
    </tr>  
	<tr> 
      <th align="left">LDAPNAME</th>
      <td><input name="XXLDAPNAME" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAPNAME);?>"></td>
      <td>The LDAP or AD or LOCAL attribute (field) name for the field that holds a person's full name.</td>
	  <input type="hidden" name="EXLDAPNAME" value="The LDAP attribute name for the field that holds a person's full name." />
    </tr> 
	<tr> 
      <th align="left">LDAPPHONE</th>
      <td><input name="XXLDAPPHONE" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAPPHONE);?>"></td>
      <td>The LDAP or AD or LOCAL attribute (field) name for the field that holds a person's primary telephone number.</td>
	  <input type="hidden" name="EXLDAPPHONE" value="The LDAP attribute name for the field that holds a person's primary telephone number." />
    </tr> 
	<tr> 
      <th align="left">LDAPOFFICE</th>
      <td><input name="XXLDAPOFFICE" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAPOFFICE);?>"></td>
      <td>The LDAP or AD or LOCAL attribute (field) name for the field that holds a person's office or room location.</td>
	  <input type="hidden" name="EXLDAPOFFICE" value="The LDAP attribute name for the field that holds a person's office or room location." />
    </tr>   
	<tr> 
      <th align="left">LDAPEMAIL</th>
      <td><input name="XXLDAPEMAIL" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAPEMAIL);?>"></td>
      <td>The LDAP or AD or LOCAL attribute (field) name for the field that holds a person's primary email address.</td>
	  <input type="hidden" name="EXLDAPEMAIL" value="The LDAP attribute name for the field that holds a person's primary email address." />
    </tr>   
	<tr> 
      <th align="left">LDAPNETID</th>
      <td><input name="MMLDAPNETID" type="text" size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::LDAPNETID);?>"></td>
      <td>The LDAP or AD attribute name for the field that holds a person's netid (userid).</td>
	  <input type="hidden" name="EXLDAPNETID" value="The LDAP attribute name for the field that holds a person's netid (userid)." />
    </tr>   
</table>


<p></p>
<table border="2">
	<tr> 
     <th align="left" colspan="3" id="describe">
     The following values control use of LDAP directories that do not support anonymous binds (e.g., Active Directory).  If your LDAP server supports anonymous binds, leave these values blank.
	</th>
	</tr>
    <tr> 
      <th align="left">ADLOGIN</th>
      <td><input name="XXADLOGIN" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::ADLOGIN); ?>"></td>
      <td>The dn (netid) used to bind to Active Directory.</td>
	  <input type="hidden" name="EXADLOGIN" value='' />
    </tr>        
   <tr> 
      <th align="left">ADPASS</th>
      <td><input name="XXADPASS" type="text"  size="55" maxlength="255" 
	  value="<?php echo formsafe(wassParms::ADPASS); ?>"></td>
      <td>The password associated with the ADLOGIN specified above.</td>
	  <input type="hidden" name="EXADPASS" value='' />
    </tr>        
</table>


<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following values define support/contact information for users of the system. 
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*CONTACTNAME</th>
      <td width="58%">
	  <textarea name="MMCONTACTNAME" cols="70"><?php echo formsafe(wassParms::CONTACTNAME);?></textarea></td>
      <td>The name and contact information for the group that supports WASS .  Appears on many
	  forms, as "If you have any problems, contact ...." </td>
	  <input type="hidden" name="EXCONTACTNAME" value='The name and contact information for the group that supports WASS.' />
    </tr>
     <tr> 
      <th align="left">*CONTACTEMAIL</th>
      <td><input name="MMCONTACTEMAIL" type="text" size="70" maxlength="255"
	  value="<?php echo formsafe(wassParms::CONTACTEMAIL);?>"></td>
      <td>Email address to which users should direct questions.</td>
	  <input type="hidden" name="EXCONTACTEMAIL" value='Email address to which users should direct questions.' />
    </tr>
    <tr> 
      <th align="left">*CONTACTPHONE</th>
      <td><input name="MMCONTACTPHONE" type="text" size="70" maxlength="255"
	  value="<?php echo formsafe(wassParms::CONTACTPHONE);?>"></td>
      <td>Phone number to which users should direct questions.</td>
	  <input type="hidden" name="EXCONTACTPHONE" value='Phone number to which users should direct questions.' />
    </tr>
   <tr> 
      <th align="left">*SYSMAIL</th>
      <td><input name="MMSYSMAIL" type="text"  size="70" maxlength="255"
	  value="<?php echo formsafe(wassParms::SYSMAIL);?>"></td>
      <td>Email address to which error notifications should be sent (used as the Errors-To field
	  on email sent out by WASS). This is also the email address to which reports/statistics are sent (e.g., when the remind function runs, it sends email with a summary of it's actions to this address).</td>
	  <input type="hidden" name="EXSYSMAIL" value='Email address to which error notifications should be sent (used as the Errors-To field on email sent out by WASS ).' />
    </tr>
   <tr> 
      <th align="left">*FROMMAIL</th>
      <td><input name="MMFROMMAIL" type="text" size="70" maxlength="255"
	  value="<?php echo formsafe(wassParms::FROMMAIL);?>"></td>
      <td>The email address from which WASS email appears to come (used in the email From header). You would typically set this to the userid of the user under which the WASS code is running.</td>
	  <input type="hidden" name="EXFROMMAIL" value='The email address to be used by WASS in ther From header of any emails it sends out.' />
    </tr>
</table>

<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following switches control what informatory email messages get sent to SYSMAIL.  Enter
	 1 (TRUE) or 0 (FALSE) for each one.
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*MAILREM</th>
      <td width="58%">
	  <input name="MMMAILREM"  size="70" value="
	  <?php echo formsafe(wassParms::MAILREM);?>" />
	  </td>
      <td>Send summary email about reminders to SYSMAIL.</td>
	  <input type="hidden" name="EXMAILREM" value='Send summary email about reminders.' />
	  <input type="hidden" name="INTMAILREM" value="1" />
    </tr> 
    <tr> 
      <th align="left" width="10%">*MAILCAL</th>
      <td width="58%">
	  <input name="MMMAILCAL" size="70" value="
	  <?php echo formsafe(wassParms::MAILCAL);?>" />
	  </td>
      <td>Send email whenever a calendar is created or deleted to SYSMAIL.</td>
	  <input type="hidden" name="EXMAILCAL" value='Send email whenever a calendar is created or deleted.' />
	  <input type="hidden" name="INTMAILCAL" value="1" />
    </tr> 
</table>

<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following switches control which optional features of WASS are available or unavailable.
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*USERLIM</th>
      <td width="58%">
	  <input name="MMUSERLIM"  size="70" value="
	  <?php echo formsafe(wassParms::USERLIM);?>" />
	  </td>
      <td>Turn on user view/sign-up limits (allows calendar owner to restrict access to their calendar based on userid). </td>
	  <input type="hidden" name="EXUSERLIM" value='Turn on user view/sign-up limits (only specified users can make/view appointments).' />
	  <input type="hidden" name="INTUSERLIM" value="1" />
    </tr>
	<tr> 
      <th align="left" width="10%">*COURSELIM</th>
      <td width="58%">
	  <input name="MMCOURSELIM" size="70" value="
	  <?php echo formsafe(wassParms::COURSELIM);?>" />
	  </td>
      <td>Turn on course view/sign-up limits (allows calendar owner to restrict access to their calendar based on course enrollment).  Turn this on ONLY if you have installed the Blackboard web service (or have added your own course limit code to the wassLocal class).</td>
	  <input type="hidden" name="EXCOURSELIM" value='Turn on course view/sign-up limits (only users in specified courses can make appointments).' />
	  <input type="hidden" name="INTCOURSELIM" value="1" />
    </tr>
      <tr>
      <th align="left">OHBBWSDL</th>
      <td><input name="XXBBWSDL" type="text" size="70" maxlength="255" 
	  value="<?php echo formsafe(wassParms::BBWSDL); ?>"></td>
      <td>If using the Blackboard web service, the URL for the WSDL file (you will have determined this when you installed the Blackboard web service).</td>
	  <input type="hidden" name="EXBBWSDL" value='If using the Blackboard web service, the URL for the WSDL file.' />
    </tr>  
	<tr> 
      <th align="left">OHBBKEY</th>
      <td><input name="XXBBKEY" type="text" size="70" maxlength="255" 
	  value="<?php echo formsafe(wassParms::BBKEY); ?>"></td>
      <td>If using the Blackboard web service, the KEY for the service (you will have set this when you installed the Blackboard web servikce).</td>
	  <input type="hidden" name="EXBBKEY" value='If using the Blackboard web service, the KEY for the service.' />
    </tr> 
    <tr> 
      <th align="left">*TESTEMAIL</th>
      <td><input name="MMTESTEMAIL" type="text" size="70" 
	  value="<?php echo formsafe(wassParms::TESTEMAIL); ?>"></td>
    <td>Test email addresses to see if they appear to be valid.  This test involves actually connecting to port 25 on the designated server.  At many institutions, such connections are not allowed from a non-mail-server host.  DO NOT TURN THIS ON unless you are sure that the server running WASS is allowed to make out-going connections to port 25.</td>
	  <input type="hidden" name="EXTESTEMAIL" value='Test email addresses for validity.' />
      <input type="hidden" name="INTTESTEMAIL" value="0" /> 
      </tr>
</table>



<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following values define the location of WASS on your system. 
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*AJAXURL</th>
      <td width="58%">
	  <input name="MMAJAXURL" type="text"  size="70" maxlength="255"
      value="<?php echo wassParms::AJAXURL;?>" /></td>
      <td>The URL of the ajax/wassAjax.php file on your system.  This is 'https://apache-server-name/path-to-wass/ajax/wass.xsd".  Substitute your apache server name and the path to WASS in this URL. </td>
	  <input type="hidden" name="EXAJAXURL" value='URL of the ajax file.' />
    </tr>
    <tr> 
      <th align="left" width="10%">*AJAXSCHEMAROOT</th>
      <td width="58%">
	  <input name="MMAJAXSCHEMAROOT" type="text"  size="70" maxlength="255"
      value="<?php echo wassParms::AJAXSCHEMAROOT;?>" /></td>
      <td>The URL of the wass.xsd file on your system.  This is 'http://apache-server-name/path-to-wass/wass.xsd".  Substitute your apache server name and the path to WASS in this URL.</td>
	  <input type="hidden" name="EXAJAXSCHEMAROOT" value='URL of the xsd file' />
    </tr>    
</table>



<p></p>
<table border="2">
  <tr>
  <th align="left" colspan="3" id="describe">
     The following values define the various day-types for your academic (yearly) calendar. 
	</th>
	</tr>
    <tr> 
      <th align="left" width="10%">*DAYTYPES</th>
      <td width="58%">
	  <textarea name="MMDAYTYPES" cols="80"><?php echo wassParms::DAYTYPES;?>
	  </textarea></td>
      <td>A list of the names of all the types of days on your academic calendar, seperated by commas.  Each day type must be s single word.</td>
	  <input type="hidden" name="EXDAYTYPES" value='A list of the names of all the types of days on your academic calendar.' />
    </tr>
    <tr> 
      <th align="left" width="10%">*DEFAULTDAYTYPES</th>
      <td width="58%">
	  <input name="MMDEFAULTDAYTYPES" type="text"  size="70" maxlength="255"
      value="<?php echo wassParms::DEFAULTDAYTYPES;?>" /></td>
      <td>The day type WASS should use for a date to which you have not (yet) assigned a day type.  Must be one of the words in the above list.</td>
	  <input type="hidden" name="EXDEFAULTDAYTYPES" value='Default day type.' />
    </tr>    
    <tr> 
      <th align="left" width="10%">*DAYCOLORS</th>
      <td width="58%">
	  <textarea name="MMDAYCOLORS" cols="80"><?php echo wassParms::DAYCOLORS;?>
	  </textarea></td>
      <td>A comma-seperated list of the colors to use to represent each day type when you are building the
	  academic calendar.  Users do not see these colors.  They are only for use in the calendar
	  build step of the installation procedure.  Generally, you would specify a set of hex
	  values (the hex values you use to define text color in an HTML tag).  Specify at least as many values as you have daytypes.</td>
	  <input type="hidden" name="EXDAYCOLORS" value="A list of the colors to use to represent each day type." />
    </tr>
</table>


<p>
</p>   
<table border="2"align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="SAVE PARAMETERS " /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD TABLES" /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD CALENDAR" /></td>
</tr>
<tr>
<td><input type="submit" name="submit" id="submit" value="SETUP REMINDERS" /></td>
<td><input type="submit" name="submit" id="submit" value="TRY IT        " /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
</tr>
</table>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />

</form>

<?php
}
/* End of the buildparms function */

function saveparms($firsttime) {

global $path, $ppath, $pass, $mstatus;

/* Make sure all required values were provided */
$all_needed = true;
$missing = "";
$newpass = $pass;

/* Initialize wassParms.class.php file contents variable */
$out = <<<EOD
<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This is the parameters class file.  It contains constants that control the operation of WASS.  This file should be INCLUDED in every script of the WASS system. PLEASE EDIT THIS FILE to correspond to your installation (or use wassInstall.php).
 
*/

class wassParms {

	/* Global (not institution-specific) parameters */
	
	/* XML header parameters */
	const VALIDATEXML = false;
	const XMLNAME = 'wass';
	const XMLHEADER = '<?xml version="1.0"?>';
	const XMLFHEADER = '<?xml version="1.0"?> 
								<wass
								xmlns="http://wass.princeton.edu/"
								xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
								xsi:schemaLocation=
								"http://wass.princeton.edu/wass.xsd"> ';
	const XMLTRAILER = '';
	
	/* Icalendar parameters */
	const ICALHEADER = "BEGIN:VCALENDAR\\r\\nPRODID:-//Princeton University/Web Appointment Scheduling System//EN\\r\\nVERSION:2.0\\r\\n";
	const ICALTRAILER = "END:VCALENDAR\\r\\n";

	/* List of all supported views (appointment slot sizes) */
	const ALLVIEWS = '5 10 15 20 30 60';
	/* Default view (appointment slot size) */
	const DEFVIEW = '15';

	/* Institution-specific parameters */

EOD;


/* Write out all of the values and comments */
foreach ($_POST as $key => $value) {
	
	/* Extract the variable name */
	if (substr($key,0,2) == "MM") {
		$varname = substr($key,2);
		$needed = true;
	}
	elseif (substr($key,0,2) == "XX") {
		$varname = substr($key,2);
		$needed = false;
	}
	else
		continue;
	
	if ($needed) {
		if ($value === "") {
			$all_needed = false;
			$missing .= $varname . ' ';
		}
	}
	
	/* Make the value a string or an integer */
	$value = trim($value); 
	/* Strip slashes */
	if (get_magic_quotes_gpc())
		$value = stripslashes($value);
	$orivalue = $value;
	if ((substr($value,1,1) != '"') && (substr($value,1,1) != "'")) {
		$qname = 'QU' . $varname;
		$iname = 'INT' . $varname;
		if (isset($_POST[$qname]))
			$value = '"' . $value . '"';
		elseif (!isset($_POST[$iname]))
			$value = "'" . $value . "'";
		else {
			if ($value == 0)
				$value = '0';
		}
	}
	
	/* Set the comment */
	$expname = 'EX' . $varname; 
	if (isset($_POST[$expname])) {
		$out .= "    /* " . trim($_POST[$expname]) . " */
";
	}

	/* Now add in the constant */
	$out .= '    const ' . $varname . ' = ' . $value . ";
";

	/* Save the password */
	if ($varname == 'PASS')
		$newpass = $orivalue;

}

/* Finish the output string */
$out .= "}
?>";

/* Set the status message */
if (!$all_needed)
	$mstatus = "ERROR:  Missing values for the following variables:<br /> $missing <br />";
else
	$mstatus = '';
 
/* Save or update the parms file */

/* Erase "old" file */
if (file_exists($ppath . 'classes/wassParms.class.php.old'))
	if (!unlink($ppath . 'classes/wassParms.class.php.old'))
		$mstatus .= 'Unable to delete (unlink) file ' . $ppath . 'classes/wassParms.class.php.old<br />';

/* Reset file status cache */
clearstatcache();

/* Rename "current" file to old */		
if (file_exists($ppath . 'classes/wassParms.class.php'))
	if (!rename($ppath . 'classes/wassParms.class.php',$ppath . 'classes/wassParms.class.php.old'))
		$mstatus .= 'Unable to rename file ' . $ppath . 'classes/wassParms.class.php to ' . $ppath . 'classes/wassParms.class.php.old<br />';

/* Reset file status cache */
clearstatcache();

if (!$mstatus) {
	$wrote = FALSE;
	$handle = fopen($ppath . 'classes/wassParms.class.php','wt');
	if (!$handle)
		$wroteerr = "Unable to open " . $ppath . "classes/wassParms.class.php for writing";
	else {
		if (fwrite($handle, $out, strlen($out)) !== FALSE) {
			$wrote = TRUE;
			$pass = $newpass;
		}
		else {
			$wroteerr = "Unable to write to " . $ppath . "classes/wassParms.class.php";
		}
		fclose($handle);
	}
	/* Reset file status cache */
	clearstatcache();
	
	if (!$wrote) {
		if (file_exists($ppath . 'classes/wassParms.class.php.old')) {
			$wroteerr .=  " Old values saved in " . $ppath . 'classes/wassParms.class.php.old';
		}
		$mstatus .= $wroteerr;
	}
	else {
		$mstatus .= 'Values successfully written to classes/wassParms.class.php<br />';
		if (file_exists($ppath . 'classes/wassParms.class.php.old')) {
			$mstatus .=  " Old values saved in " . $ppath . 'classes/wassParms.class.php.old<br />';
		}
	}
}
}
/* End of the saveparms function */

function buildtables($firsttime) {

global $path, $ppath, $pass;

/* Include the parms file */
if (!file_exists($ppath . 'classes/wassParms.class.php'))
	buildparms(TRUE,'The MySQL tables cannot be created prior to building your parameters file. ');


/* let the user know what to do */
?>
<h1>Build MySQL Tables</h1>
<p>This step will create, or update, the MySQL tables used by the WASS system. For this step to work, the values in the classes/wassParms.class.php file that pertain to MySQL must be correctly set. The following values from wassParms.class.php will be used:</p>
<ul>
  <li>HOST (Name of MySQL server (connection string to the server)): <?php echo wassParms::HOST; ?></li>
  <li>DATABASE (Name of Database): <?php echo wassParms::DATABASE; ?></li>
  <li>USER (User (owner) of Database): <?php echo wassParms::USER; ?></li>
  <li>PASS (Password for Database): <?php echo wassParms::PASS; ?></li>
</ul>
<p>
If these values are correct, click on "CREATE TABLES" to build and/or update the MySQL tables.  When you do this, 
a separate PHP script will be invoked (admin/maketables.php), and the output of that script will be directed
to a separate browser window. Close that window once you have viewed the results.  If any errors were
reported, you may need to change some of the parameters ... to do so, click on "BUILD PARAMETERS". Or 
you may need to make some changes on the MySQL server, after which you should click on "CREATE TABLES"
again to retry building the MySQL tables.
</p>
<p>
If the build is successful, or you have alaready built the tables and are ready to go to the 
next step,
click on "BUILD CALENDAR".  Note:  You should run this step whenever you install a new version of WASS,
as the MySQL tables may have changed between releases; the maketables.php script will update existing tables to make them compatible with
this current release. 
   To exit, click on "EXIT" (you can re-run this same script later).
</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="buildtables" id="buildtables">
<table align="center">
<tr>
<td><input type="button" value="CREATE TABLES" onclick='window.open("maketables.php?secret=<?php echo $pass;?>","tables")' /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD CALENDAR" /></td>
<td><input type="submit" name="submit" id="submit" value="BUILD PARAMETERS" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
return;
}
/* End of the buildtables function */

function buildcalendar($firsttime) {

global $path, $ppath, $pass;

/* Include the parms file */
if (!file_exists($ppath . 'classes/wassParms.class.php'))
	buildparms(TRUE,'The calendar cannot be updated prior to building your parameters file. ');


/* let the user know what to do */
?>
<h1>Build or Update the Academic Calendar</h1>
<p> 
The step will build or update the Academic Calendar table.  
</p>
<p>WASS needs to know the day-type for every day of the 
year, so that it can decide if a given day should be eligible for office hours assignment.  When users create
their calendars, they designate which day types should be eligible for their office hours, and WASS consults this calendar
to determine a day's eligibility.  You should run this step at least twice, once for the current and
once for the following calendar year.  This makes it possible for users to create schedules that
extend beyond the current calendar year. 
</p>
<p>
If you are running this step for the first time, you should update the calendar for the 
current and the following year.  Every year, you can come back to this step and update
the calendar for the following year.  You can also run this step at any time to make changes
to the calendar, even while the system is running.</p>
<p>
To update the calendar, enter a year and click on "UPDATE CALENDAR".
When you do this, 
a separate PHP script will be invoked (admin/calendar.php), and the output of that script will be directed
to a separate browser window. Close that window once you have viewed the results. You can then enter
another year and click on "UPDATE CALENDAR" again.  When you are done,
click on "SETUP REMINDERS" to go to the next step, or click on "EXIT" to quit
(you can re-run this same script later).
</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="buildcalendar" id="buildcalendar">
<table align="center">
<tr>
<td>Year: <input name="txtParameter" type="text"></td>
<td><input type="button" name="btnOpenWin" value="UPDATE CALENDAR" onclick="OpenCal(<?php echo "'" . $pass . "'";?>);" /></td>
<td><input type="submit" name="submit" id="submit" value="SETUP REMINDERS" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
return;
}
/* End of the buildcalendar function */


function setrem($firsttime) {

global $path, $ppath, $pass;

/* Include the parms file */
if (!file_exists('../classes/wassParms.class.php'))
	buildparms(TRUE,'Reminders cannot be set prior to building your parameters file.');


/* let the user know what to do */
?>
<h1>Setup the Reminder Function</h1>
<p>
The WASS system includes a script which can issue email reminders to students and faculty of 
pending appointments.  This capability is implemented in the admin/remind.php script.
You need to arrange to have this script run every day (generally in the afternoon or evening), or whenever you want to send out reminders.
The script will send email reminders of appointments scheduled for the following day (e.g., if run
 Tuesday afternoon, it would send reminders about Wednesday appointments).  It will also
email a summary of the reminders sent to the SYSMAIL address in classes/wassParms.class.php. 
</p>
<p>
Students and faculty
have the option of specifying if they want these reminders or not when they create their
calendars and appointments (so the system will not send the reminder unless they are
requested by the users). 
</p>
<p>
Typically, you would use CRON to schedule the invocation 
of the remind.php script via a line-mode html client. The script must be invoked with the MySQL 
password passed as a GET argument. A typical crontab entry might be:<br>
    0 5 * * * /usr/bin/elinks &quot;https://path_to_WASS _directory/admin/remind.php?secret=mysqlpassword&quot;<br> 
</p>
<p>
You could also schedule execution of the remind.php script via CRON directly on the LAMP server that
is running WASS , passing the MySQL password as the first argv argument.  A typical crontab entry might be:<br>
    0 5 * * * /path_to_php_binary/php /path_to_remind.php/remind.php secret=mysqlpassword<br> 
</p>
<p>
As this is not something that this installation script can do, we leave this to
the installer.
</p>
<p>
To go to the next step and learn about administration,
click on ADMINISTRATION.  Click on
EXIT to quit.
</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="setrem" id="setrem">
<table align="center">
<tr>
<td><input name="submit" type="submit" id="submit" value="ADMINISTRATION" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
return;
}
/* End of setrem function */



function administer($firtsttime) {
global $pass;
?>
<h1>Administration</h1>
<p>With a couple of exceptions (discussed below), there are no scripts for administering WASS. Instead, WASS allows an administrator to login as any user to inspect and correct any reported problems. The way this is done is as follows:</p>
<p>1) If you are using LDAP authentication, on the Login screen, enter the target userid (netid) in the userid field, and enter &quot;secret=mysqlpassword&quot; (without the quotes) in the password field (where you substitute your MySQL WASS password for mysqlpassword), then click Login. This will log you in as the specified user.</p>
<p>2) If you are using CAS authentication, enter the target userid, then a space, then &quot;secret=mysqlpassword&quot; (without the quotes) in the email address field (where you substitute your MySQL WASS password for mysqlpassword), then click Guest. This will log you in as the specified user.</p>
<p>WASS also includes a couple of scripts in the admin directory that you may find useful, in addition to this script:</p>
<p>1) mailusers.php allows you to send email to all, or a subset, of WASS users (e.g., to let them know the system will be unavailable, or to announce changes, or to ask for feedback, etc.).</p>
<p>2) calendar.php manages your academic calendar.</p>
<p>3) remind.php sends out reminders for appointments on the following day.</p>
<p>4) didyouknow.php adds/edits/removes did-you-know items.</p>
<p>All of these scripts have to be invoked with an argument of &quot;secret=mysqlpassword&quot;, either as a GET argument in a URL, or as the first command line argument.</p>
<p>You might want, in particular, to use the didyouknow.php script to create did-you-know entries for your users. For example, you might add a didyouknow entry that lets users know that they can create multiple calendars.   WASS ships with an empty didyouknow table.  If you are interested, I would be happy to send you a dump of our table.
</p>
<p>To learn about further customization of the WASS system, click on "FURTHER CUSTOMIZATION" below.  Click on 
  "EXIT" to quit.</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="administer" id="administer">
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="FURTHER CUSTOMIZATION" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
<?php
}


function further($firsttime) {

global $path, $ppath, $pass;

/* Include the parms file */
if (!file_exists('../classes/wassParms.class.php'))
	buildparms(TRUE,'Customizations cannot be made prior to building your parameters file.');


/* Let the user know what to do */
?>
<h1>Further Customization</h1>
You can customize the WASS system by directly editing the supplied php scripts.  Some of the
customizations you might want to undertake are listed below:
<p></p>
<ol>
<li>
You can customize the look/feel of WASS by editing the style sheets in the pages/css directory.
</li>
<li>
WASS assumes you have an LDAP system which can handle directory 
services (and opionally authentication).  If you don't, you will have to modify the functions in classes/wassDirectory.class.php.</li>
<li>
WASS includes a template file in the admin directory called "wassLocal.template.php".  This file is intended to house local extensions to WASS, in particular, user exits. If you want to add local code to WASS, copy this file into the classes directory, and rename it "wassLocal.class.php".  You can then add (static) methods to this class as needed.  The template file contains stub versions of all the user exists currently in WASS.   WASS distributions will never include a wassLocal.class.php class in the classes directory, so you can be sure that anything you code will not be overwritten.    If you would like other user exists added to WASS, please contact me and let me know where/what you want.  Two of the current user exits, IsUserInCourse and IsCourseValid, can be used to implement calendar access restrictions based on course enrollment for LMSes other than Blackboard (e.g., Sakai, Moodle).  Another user exit, login, can be used to do login authorization checks.
<li>
WASS checks to see if has been invoked via an SSL connection (https), and aborts if not
(with an error message).  This check is done in the sslcheck routine in classes/wassUtil.class.php.
If you want to run under http, simply insert a return statement at the start of this 
function.  WARNING:  WASS prompts for passwords (if you are using LDAP authentication).  If you run under http, these passwords
will be transmitted in clear text.</li>
<li>
If, for any reason, you want to disable WASS and issue
a nice message to users, you can set the value of the
RUNNING variable to 0 in wassParms.class.php and set a message in the
DOWNMSG variable.  This can be done live, while the system
is running.  It's a good way to take WASS down for service.
</li>
<li>
You may want to take a look at the text of the WASS help and faq page.  These are in help.page.php and faq.htm in the pages directory.  If you have customized WASS, you may want to update these files to reflect your customizations.  Note, however, that new releases of WASS will ship with current versions of these files, so you will need to arrange a way to save your updates and re-apply them to new releases.
</li>
<li>
If you are using LOCAL user authentication, you will need to enter your users into the wassUser MySQL table (using a tool such
as phpMyAdmin.  WASS does not provide any tools to manage this table.
</li>
</ol>
<p>
To move to the next step, testing of the WASS system, click on "TRY IT" below.  Click on 
"EXIT" to quit.</p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="further" id="further">
<table align="center">
<tr>
<td><input type="submit" name="submit" id="submit" value="TRY IT" /></td>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
return;
}
/* End of further function */


function tryit($firsttime) {

global $path, $ppath, $pass;

/* Include the parms file */
if (!file_exists('../classes/wassParms.class.php'))
	buildparms(TRUE,'WASS cannot run prior to building your parameters file.');


/* let the user know what to do */
?>
<h1>TRY IT!</h1>
<p>
If you are ready to try the WASS system, click on the GO button below.  This will invoke the
main WASS script, pages/login.page.php, in a separate
browser window.  WASS includes a .htaccess file which redirects URLs that reference the main WASS directory to the login page,
so you should be able to invoke WASS with a URL of the form:</p>
<p>https://server-name/path-to-wass </p>
<p>[Note: the WASS htaccess file uses the RewriteRule directive. This will not work if your Apache is configured to dis-allow htaccess Rewrite rules.] WASS includes a built-in HELP system. When you get to the login screen, click the Help button to learn about WASS. You can click on HELP from any WASS display to get context-sensitive help.  An overview of WASS is provided in the
admin/overview.txt file.</p>
<p>
To run WASS , click on the following link:</p>
<a href="../pages/login.page.php">../pages/login.page.php</a>
<p>To exit, click on EXIT.  This is the end of the installation script. </p>
<form action="<?php echo $_SERVER['SCRIPT_NAME']; ?>" method="post" name="tryit" id="tryit">
<table align="center">
<tr>
<td><input name="submit" type="submit" id="submit" value="EXIT" /></td>
<input type="hidden" name="secret" value="<?php echo $pass;?>" />
</tr>
</table>
</form>

<?php
return;
}
/* End of tryit function */


/* Dummy formsafe function */
function formsafe($arg) {
	return $arg;
}

?>
