<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

/* This routine creates the MySQL tables used by WAS */


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

 
/* Start session support */
session_start();

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';

/* See if argument passed from the command line */
if ($_SERVER['argc'] > 1) {
	list($secret,$pass) = explode("=",$_SERVER['argv'][1]);
	if (strtoupper($secret) == 'SECRET') 
		$_REQUEST['secret'] = $pass;
	elseif ($pass == '')
		$_REQUEST['secret'] = $secret;		
}


/* Make sure password was specified */
if ($_REQUEST['secret'] != wassParms::PASS) {
	$msg = 'Attempt to access admin application ' . $_SERVER['SCRIPT_NAME'] . ' without a password from: ' . $_SERVER['REMOTE_ADDR'];
	wassMsg::logMsg($msg);
	die('Unauthorized access.');
}

/* Now define the tables */
$tables = array(
'wassEvent',
'wassPrefs',
'wassIcalendar',
'wassIcalentry',
'wassAcCal',
'wassCalendar',
'wassSeries',
'wassAppointment',
'wassManager',
'wassBlock',
'wassPeriod',
'wassNonGrata',
'wassRedir',
'wassAlert',
'wassDidYouKnow',
'wassAsset',
'wassAssMan',
'wassUser'
);


/* Build table creation SQL statements */
$d_wassEvent = "CREATE TABLE " . wassParms::DATABASE . ".wassEvent (
  `eventid` int(10) unsigned NOT NULL auto_increment,
  `when` datetime default NULL,
  `what` varchar(255) default NULL,
  `whendone` datetime default NULL,
  `whathappened` varchar(255) default NULL,
  PRIMARY KEY  (`eventid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;";


$d_wassPrefs = "CREATE TABLE " . wassParms::DATABASE . ".wassPrefs (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` varchar(255) default NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4096) NOT NULL,
  `class` varchar(255) NOT NULL default 'user',
  PRIMARY KEY  (`id`),
  KEY `netid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;";

$d_wassIcalendar = "CREATE TABLE " . wassParms::DATABASE . ".wassIcalendar (
  `icalendarid` int(10) unsigned NOT NULL auto_increment,
  `userid` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `created` datetime default NULL,
  `updated` datetime default NULL,
  `lastaccess` datetime default NULL,
  `usage` int(10) unsigned NULL default '0',
  `events` int(10) unsigned NULL default '0',
  `secret` varchar(255) default NULL,
PRIMARY KEY  (`icalendarid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";


$d_wassIcalentry = "CREATE TABLE " . wassParms::DATABASE . ".wassIcalentry (
 `entryid` int(11) NOT NULL auto_increment,
  `icalendarid` int(11) unsigned NOT NULL default '0',
  `datestart` date default NULL,
  `timestart` time default NULL,
  `dateend` date default NULL,
  `timeend` time default NULL,
  `dtstamp` varchar(255) default NULL,
  `uid` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `summary` varchar(255) default NULL,
  `description` text,
  `deleted` tinyint(1) unsigned NOT NULL default '0',
  `sequence` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";


$d_wassAcCal = "CREATE TABLE " . wassParms::DATABASE . ".wassAcCal (
  `accalid` int(10) unsigned NOT NULL auto_increment,
  `date` date NOT NULL default '0000-00-00',
  `daytypes` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`accalid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;";

$d_wassCalendar = "CREATE TABLE " . wassParms::DATABASE . ".wassCalendar (
  `calendarid` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `description` text,
  `userid` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `phone` varchar(255) default NULL,
  `email` varchar(255) NOT NULL default '',
  `managers` text NOT NULL,
  `location` varchar(255) default NULL,
  `notify` tinyint(1) unsigned NOT NULL default '0',
  `notifyman` tinyint(1) unsigned NOT NULL default '0',
  `available` tinyint(1) unsigned NOT NULL default '1',
  `makeaccess` varchar(255) NOT NULL default '',
  `viewaccess` varchar(255) NOT NULL default '',
  `makeulist` text NOT NULL,
  `makeclist` text NOT NULL,
  `viewulist` text NOT NULL,
  `viewclist` text NOT NULL,
  `remind` tinyint(1) unsigned NOT NULL default '0',
  `remindman` tinyint(1) unsigned NOT NULL default '0',
  `appmsg` text NOT NULL,
  `showappinfo` tinyint(1) unsigned default '0',
  `group` tinyint(1) unsigned default '0',
  `purreq` tinyint(1) unsigned default '0',
  `overlapok` tinyint(1) unsigned default '0',
  PRIMARY KEY  (`calendarid`),
  KEY `ownername` (`name`),
  KEY `ownernetid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Describes a user calendar.';";
        

$d_wassSeries = "CREATE TABLE " . wassParms::DATABASE . ".wassSeries (
  `seriesid` int(10) unsigned NOT NULL auto_increment,
  `calendarid` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `description` text,
  `userid` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `phone` varchar(255) default NULL,
  `email` varchar(255) NOT NULL default '',
  `location` varchar(255) default NULL,
  `startdate` date NOT NULL default '0000-00-00',
  `enddate` date NOT NULL default '0000-00-00',
  `every` varchar(255) NOT NULL default 'weekly',
  `daytypes` varchar(255) NOT NULL default 'Teaching Day',
  `slotted` tinyint(1) unsigned NOT NULL default '0',
  `slotsize` int(11) NOT NULL default '0',
  `maxapps` int(11) NOT NULL default '0',
  `maxper` int(11) NOT NULL default '0',
  `deadline` int(11) NOT NULL default '0',
  `candeadline` int(11) NOT NULL default '0',
  `opening` int(11) NOT NULL default '0',
  `notify` tinyint(1) unsigned NOT NULL default '0',
  `notifyman` tinyint(1) unsigned NOT NULL default '0',
  `available` tinyint(1) unsigned NOT NULL default '1',
  `makeaccess` varchar(255) NOT NULL default '',
  `viewaccess` varchar(255) NOT NULL default '',
  `makeulist` text NOT NULL,
  `makeclist` text NOT NULL,
  `viewulist` text NOT NULL,
  `viewclist` text NOT NULL,
  `remind` tinyint(1) unsigned NOT NULL default '0',
  `remindman` tinyint(1) unsigned NOT NULL default '0',
  `appmsg` text NOT NULL,
  `showappinfo` tinyint(1) unsigned default '0',
  `purreq` tinyint(1) unsigned default '0',
  PRIMARY KEY  (`seriesid`),
  KEY `ownername` (`name`),
  KEY `startdate` (`startdate`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Describes a recurring block.';";

$d_wassAppointment = "CREATE TABLE " . wassParms::DATABASE . ".wassAppointment (
  `appointmentid` int(10) unsigned NOT NULL auto_increment,
  `blockid` int(10) unsigned NOT NULL default '0',
  `calendarid` int(10) unsigned NOT NULL default '0',
  `date` date NOT NULL default '0000-00-00',
  `name` varchar(255) NOT NULL default '',
  `email` varchar(255) default NULL,
  `textemail` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `userid` varchar(255) default NULL,
  `starttime` time NOT NULL default '00:00:00',
  `endtime` time NOT NULL default '00:00:00',
  `purpose` text,
  `remind` tinyint(1) unsigned NOT NULL default '1',
  `reminded` tinyint(1) unsigned NOT NULL default '0',
  `notes` mediumtext NOT NULL,
  `uid` varchar(255) NOT NULL default '',
  `whenmade` datetime NOT NULL,
  `madeby` varchar(255) default NULL,
  `available` tinyint(1) unsigned NOT NULL default '1',
  `sequence` int(11) unsigned NOT NULL default '0',  
  PRIMARY KEY  (`appointmentid`),
  KEY `blocksid` (`blockid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;";


$d_wassManager = "CREATE TABLE " . wassParms::DATABASE . ".wassManager (
  `userid` varchar(255) NOT NULL default '',
  `calendarid` int(11) unsigned NOT NULL default '0',
  `managerid` varchar(255) NOT NULL default '',
  `source` varchar(255) NOT NULL default '',
  `notify` tinyint(1) unsigned NOT NULL default '1',
  `remind` tinyint(1) unsigned NOT NULL default '1',
  `password` varchar(255) NOT NULL default ' '
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";


$d_wassBlock = "CREATE TABLE " . wassParms::DATABASE . ".wassBlock (
  `blockid` int(11) unsigned NOT NULL auto_increment,
  `periodid` int(11) unsigned NOT NULL default '0',
  `seriesid` int(11) unsigned NOT NULL default '0',
  `calendarid` int(11) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `userid` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `phone` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `location` varchar(255) NOT NULL default '',
  `recurrence` varchar(255) NOT NULL default 'multiple',
  `starttime` time NOT NULL default '00:00:00',
  `endtime` time NOT NULL default '00:00:00',
  `slotted` tinyint(1) unsigned NOT NULL default '0',
  `slotsize` int(11) NOT NULL default '0',
  `maxapps` int(11) NOT NULL default '0',
  `maxper` int(11) NOT NULL default '0',
  `deadline` int(11) NOT NULL default '0',
  `candeadline` int(11) NOT NULL default '0',
  `opening` int(11) NOT NULL default '0',
  `date` date NOT NULL default '0000-00-00',
  `notify` tinyint(1) unsigned NOT NULL default '0',
  `notifyman` tinyint(1) unsigned NOT NULL default '0',
  `available` tinyint(1) unsigned NOT NULL default '1',
  `makeaccess` varchar(255) NOT NULL default '',
  `viewaccess` varchar(255) NOT NULL default '',
  `makeulist` text NOT NULL,
  `makeclist` text NOT NULL,
  `viewulist` text NOT NULL,
  `viewclist` text NOT NULL,
  `remind` tinyint(1) unsigned NOT NULL default '0',
  `remindman` tinyint(1) unsigned NOT NULL default '0',
  `appmsg` text NOT NULL,
  `showappinfo` tinyint(1) unsigned default '0',
  `uid` varchar(255) NOT NULL default '',
  `sequence` int(11) unsigned NOT NULL default '0',
  `purreq` tinyint(1) unsigned default '0',    
  PRIMARY KEY  (`blockid`),
  KEY `blockdefsid` (`calendarid`),
  KEY `blockdefsid_2` (`calendarid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 COMMENT='Describes an office hour block.';";

$d_wassPeriod = "CREATE TABLE " . wassParms::DATABASE . ".wassPeriod (
  `periodid` int(11) NOT NULL auto_increment,
  `seriesid` int(11) NOT NULL default '0',
  `starttime` time NOT NULL default '00:00:00',
  `endtime` time NOT NULL default '00:00:00',
  `dayofweek` varchar(255) NOT NULL default '',
  `dayofmonth` int(11) NOT NULL default '0',
  `weekofmonth` int(11) NOT NULL default '0',
  PRIMARY KEY  (`periodid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";


$d_wassNonGrata = "CREATE TABLE " . wassparms::DATABASE . ".wassNonGrata (
  `calendarid` int(10) unsigned NOT NULL,
  `authid` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";

$d_wassRedir = "CREATE TABLE " . wassparms::DATABASE . ".wassRedir (
`redirid` INT NOT NULL AUTO_INCREMENT ,
`url` VARCHAR( 255 ) NOT NULL ,
PRIMARY KEY ( `redirid` )
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";

$d_wassAlert = "CREATE TABLE " . wassParms::DATABASE . ".wassAlert (
`alertid` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
`calendarid` INT UNSIGNED NOT NULL ,
`datestart` DATE NOT NULL ,
`timestart` TIME,
`dateend` DATE NOT NULL ,
`timeend` TIME,
`userid` VARCHAR( 255 ) NOT NULL ,
`email` VARCHAR( 255 ) NOT NULL ,
`message` TEXT NOT NULL ,
`type` varchar(255) default 'APPSLOTS',
`sentcount` INT UNSIGNED DEFAULT '0' NOT NULL ,
PRIMARY KEY ( `alertid` )
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";

$d_wassDidYouKnow = "CREATE TABLE " . wassParms::DATABASE . ".wassDidYouKnow (
  `didyouknowid` int(11) unsigned NOT NULL auto_increment,
  `header` varchar(255) default NULL,
  `details` text,
  `dateadded` date NOT NULL,
  `release` varchar(255) default '0',
  `topics` varchar(500) default NULL,
  PRIMARY KEY  (`didyouknowid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";

$d_wassAsset = "CREATE TABLE " . wassParms::DATABASE . ".wassAsset (
  `assetid` int(11) unsigned NOT NULL auto_increment,
  `calendarid` int(11) unsigned default '0',
  `name` varchar(255) default NULL,
  `description` text,
  `location` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY  (`assetid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";

        
$d_wassAssMan = "CREATE TABLE " . wassParms::DATABASE . ".wassAssMan (
  `assetid` int(11) unsigned NOT NULL,
  `managerid` int(11) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";
        
$d_wassUser =  "CREATE TABLE " . wassParms::DATABASE . ".wassUser  (
`userid` VARCHAR( 255 ) NOT NULL ,
`password` VARCHAR( 255 ) ,
`displayname` VARCHAR( 255 ) ,
`mail` VARCHAR( 255 ) ,
`street` VARCHAR( 255 ) ,
`telephonenumber` VARCHAR( 255 )
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";

/* Build the tables */
echo '<h2>Creating Tables</h2><br />';
$needtoalter = false;
foreach ($tables as $table) {
	$varname = '$d_' . $table;	
	eval ('$res = wassSQL::doQuery(' . $varname . ');');
	if ($res) {
		echo "$table table built.<br />";
		eval ('$o_' . $table . ' = true;');
	}
	else {
		echo "$table table NOT built. " . wassSQL::error() . "<br />";
		$needtoalter = true;
	}
}
echo '<br /><br />';



/* Now define table updates that may need to be applied to upgrade older versions */

$a_wassPrefs = array();
$a_wassPrefs[] = "ALTER TABLE " . wassParms::DATABASE . ".wassPrefs ADD `class` VARCHAR(255) NOT NULL DEFAULT 'user';";

$a_wassIcalentry  = array();
$a_wassIcalentry[] = "ALTER TABLE " . wassParms::DATABASE . ".wassIcalentry ADD `sequence` int(11) unsigned NOT NULL default '0';";
$a_wassIcalentry[] = "ALTER TABLE " . wassParms::DATABASE . ".wassIcalentry ADD `deleted` tinyint(1) unsigned NOT NULL default '0';";

$a_wassCalendar = array();
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `remindman` tinyint(1) unsigned NOT NULL default '0';";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `appmsg` text NOT NULL;";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar CHANGE `remind` `remind` TINYINT(1);";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `showappinfo` TINYINT( 1 ) UNSIGNED DEFAULT '0';";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `group` tinyint(1) unsigned default '0';";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `purreq` tinyint(1) unsigned default '0';";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `password` text;";
$a_wassCalendar[] = "ALTER TABLE " . wassParms::DATABASE . ".wassCalendar ADD `overlapok` tinyint(1) unsigned default '0';";

$a_wassSeries = array();
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `remindman` tinyint(1) unsigned NOT NULL default '0';";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `notifyman` tinyint(1) unsigned NOT NULL default '0';";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `candeadline` int(11) NOT NULL default '0';";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `appmsg` text NOT NULL;";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries CHANGE `remind` `remind` TINYINT(1);";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `showappinfo` TINYINT( 1 ) UNSIGNED DEFAULT '0';";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `opening` int(11) NOT NULL default '0';";
$a_wassSeries[] = "ALTER TABLE " . wassParms::DATABASE . ".wassSeries ADD `purreq` tinyint(1) unsigned default '0';";

$a_wassBlock = array();
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `remindman` tinyint(1) unsigned NOT NULL default '0';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `notifyman` tinyint(1) unsigned NOT NULL default '0';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `candeadline` int(11) NOT NULL default '0';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `opening` int(11) NOT NULL default '0';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `appmsg` text NOT NULL;";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock CHANGE `remind` `remind` TINYINT(1);";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `showappinfo` TINYINT( 1 ) UNSIGNED DEFAULT '0';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD  `uid` varchar(255) NOT NULL default '';";
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD  `sequence` int(11) unsigned NOT NULL default '0';";    
$a_wassBlock[] = "ALTER TABLE " . wassParms::DATABASE . ".wassBlock ADD `purreq` tinyint(1) unsigned default '0';";

$a_wassAppointment = array();
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `whenmade` datetime NOT NULL;";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `available` tinyint(1) unsigned NOT NULL default '1';";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `sequence` int(11) unsigned NOT NULL default '0';";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `reminded` tinyint(1) unsigned NOT NULL default '0' after `remind`;";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `sequence` int(11) unsigned NOT NULL default '0';";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `textemail` varchar(255) default NULL;";
$a_wassAppointment[] = "ALTER TABLE " . wassParms::DATABASE . ".wassAppointment ADD `madeby` varchar(255) default NULL;";

$a_wassManager  = array();
$a_wassManager[] = "ALTER TABLE " . wassParms::DATABASE . ".wassManager ADD `notify` TINYINT( 1 ) UNSIGNED DEFAULT '1' NOT NULL;";
$a_wassManager[] = "ALTER TABLE " . wassParms::DATABASE . ".wassManager ADD `remind` TINYINT( 1 ) UNSIGNED DEFAULT '1' NOT NULL;";
$a_wassManager[] = "ALTER TABLE " . wassParms::DATABASE . ".wassManager ADD `calendarid` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `userid` ;";
$a_wassManager[] = "ALTER TABLE " . wassParms::DATABASE . ".wassManager ADD `password` text NOT NULL;";

 
/* Alter the tables as needed */
if ($needtoalter) {
  echo '<h2>Altering Existing Tables</h2><br />';
  foreach ($tables as $table) {
	  eval('$built = $o_' . $table . ';');
	  if (!$built) {
		  eval('foreach ($a_' . $table . ' as $alter) sqlQuery("' . $table . '", $alter);');
	  }	
  }
  echo '<br /><br />';
}


/*  
Handle changes in the wassManager table structure from release 1 to release 2.

If we are upgrading from a release prior to 2 to a release 2+, then the wassManager table will have userids but no calendarids.  We check for that condition here, and,
if encountered, we update the table entries with the correct calendarid.

*/

/* Get a resource of all of the wassManager entries that have a userid bu no calendarid */
echo '<h2>Updating wassManager Table</h2>';
$oldentries = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassManager WHERE calendarid=""');
/* Go through all of the entries */
$fixed = array();
while ($oldentry = wassSQL::doFetch($oldentries)) {
	$calwlist = wassCalendar::wlistOwnedCalendars($oldentry['userid']);
	foreach ($calwlist as $cal) {
		$update = wassSQL::doQuery('UPDATE ' .  wassParms::DATABASE . '.wassManager SET calendarid=' . $cal->calendarid . ' WHERE (calendarid="" AND userid=' . wassSQL::sqlSafe($oldentry['userid']) . ')');
		$fixed[] = 'Manager ' . $oldentry['managerid'] . ' for user ' .  $oldentry['userid'] . ' fixed to point to calendar ' . $cal->calendarid . '<br />';
		break;
	}	
}
if ($fixed) {
	echo 'Note: the following manager entries were updated:<br />';
	foreach ($fixed as $fix) {
		echo $fix;
	}
}
else
	echo 'No manager entries needed to be updated.<br />';
echo '<br /><br />';

/* All done */
echo '<h2>All Done</h2>';
echo "<p>Execution completed.  If errors were reported, and you are running an installation (you are NOT upgrading from an earlier version), you should quit out of the installation, fix the problem(s), then re-run the installation script.</p><p>If you are upgrading from an earlier release, and the instructions said you should run this script, it is likely that your tables are up-to-date and do not need to be altered.</p><p>
If this script opened in a new browser window (e.g., during instllation of WASS), you should close this window to continue with the installation.</p>"; 

exit();


function sqlQuery($table,$query) {
	$res = wassSQL::doQuery($query);
	if ($res)
		echo  $table . ' table changed as follows: ' . $query . "<br />";
	else
		echo $table . ' table NOT changed: ' . wassSQL::error() . "<br />";
}

?>