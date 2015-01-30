<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/

/* 

The wassAjax.php script receives the AJAX http request (as a POST data stream), parses it, invokes the appropriate class/method to execute the request, and then passes the results back to the caller as an AJAX http data stream.  It is typically invoked as:

https://serverurl/wasshome/ajax/wassAjax.php 
	   
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


/* Special case code for CAS */
require_once('../CAS/CAS.php');


/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 

/* 
Save the POST data as a string (this is the raw xml sent through the Ajax call).
*/
 
/* $ajaxml = $HTTP_RAW_POST_DATA; */

$ajaxml = trim(file_get_contents("php://input"));

/* Init the return stream buffer */
$retbuf = wassParms::XMLHEADER;

/* If no stream, return nothing */
if (!$ajaxml)
	return $retbuf . '<wass></wass>';

/* In case we got multiple <wass> streams, split them into individual units. */
$streams = explode('</wass>',$ajaxml);

foreach ($streams as $stream) {

	/* Ignore blank/null streams */
	$stream = trim($stream);
	if (!$stream)
		continue;
		
	/* Put back ending tag */
	$stream .= '</wass>';
	
	/* Start the response */
	$retbuf .= '<wass>';
	
	/* Convert the xml into a SimpleXMLElement object. */
	
	if (!$sme = simplexml_load_string($stream)) {
		$retbuf .= wassUtil::Error(3,array($stream,$ajaxml),'AJAXERR') . '</wass>';
		continue;
	}
	
	/* Dump all of the objects (requests) in the stream */
	$requests = get_object_vars($sme);
	
	/* Now handle all possible requests in the stream */	

	if (array_key_exists('login',$requests)) {
		$retbuf .= '<login>' . dologin($sme) . '</login>';
	}
	
	if (array_key_exists('getprefs',$requests)) {
		$retbuf .= '<getprefs>' . dogetprefs($sme) . '</getprefs>';
	}
	
	if (array_key_exists('getalluserprefs',$requests)) {
		$retbuf .= '<getalluserprefs>' . dogetalluserprefs($sme) . '</getalluserprefs>';
	}
	
	if (array_key_exists('saveprefs',$requests)) {
		$retbuf .= '<saveprefs>' . dosaveprefs($sme) . '</saveprefs>';
	}
	
	if (array_key_exists('validateusers',$requests)) {
		$retbuf .= '<validateusers>' . dovalidateusers($sme) . '</validateusers>';
	}
				
	if (array_key_exists('validatecourses',$requests)) {
		$retbuf .= '<validatecourses>' . dovalidatecourses($sme) . '</validatecourses>';
	}
	
	if (array_key_exists('getdaytypes',$requests)) {
		$retbuf .= '<getdaytypes>' . dogetdaytypes($sme) . '</getdaytypes>';
	}

	
	/* Example of one way to handle multiple requests in a data stream */
	if (array_key_exists('getparameter',$requests)) {
			foreach ($sme->getparameter as $child) {
				$retbuf .= '<getparameter>' . dogetparameter($child) . '</getparameter>';
			}
	}
		
	if (array_key_exists('getuserdetails',$requests)) {
		$retbuf .= '<getuserdetails>' . dogetuserdetails($sme) . '</getuserdetails>';
	}

	if (array_key_exists('getallviews',$requests)) {
		$retbuf .= '<getallviews>' . dogetallviews($sme) . '</getallviews>';
	}
		
	if (array_key_exists('getvalidviews',$requests)) {
		$retbuf .= '<getvalidviews>' . dogetvalidviews($sme) . '</getvalidviews>';
	}
		
	if (array_key_exists('getbestview',$requests)) {
		$retbuf .= '<getbestview>' . dogetbestview($sme) . '</getbestview>';
	}
	
	if (array_key_exists('iscalendarviewable',$requests)) {
		$retbuf .= '<iscalendarviewable>' . doiscalendarviewable($sme) . '</iscalendarviewable>';
	}
		
	if (array_key_exists('isblockviewable',$requests)) {
		$retbuf .= '<isblockviewable>' . doisblockviewable($sme) . '</isblockviewable>';
	}
		
	if (array_key_exists('isappointmentmakeable',$requests)) {
		$retbuf .= '<isappointmentmakeable>' . doisappointmentmakeable($sme) . '</isappointmentmakeable>';
	}
		
	if (array_key_exists('makeableapps',$requests)) {
		$retbuf .= '<makeableapps>' . domakeableapps($sme) . '</makeableapps>';
	}
	
	if (array_key_exists('getavailabledates',$requests)) {
		$retbuf .= '<getavailabledates>' . dogetavailabledates($sme) . '</getavailabledates>';
	}
	
	if (array_key_exists('getdatestatus',$requests)) {
		$retbuf .= '<getdatestatus>' . dogetdatestatus($sme) . '</getdatestatus>';
	}
		
	if (array_key_exists('getcalendars',$requests)) {
		$retbuf .= '<getcalendars>' . dogetcalendars($sme) . '</getcalendars>';
	}
		
	if (array_key_exists('addcalendar',$requests)) {
		$retbuf .= '<addcalendar>' . doaddcalendar($sme) . '</addcalendar>';
	}
		
	if (array_key_exists('editcalendar',$requests)) {
		$retbuf .= '<editcalendar>' . doeditcalendar($sme) . '</editcalendar>';
	}
		
	if (array_key_exists('deletecalendar',$requests)) {
		$retbuf .= '<deletecalendar>' . dodeletecalendar($sme) . '</deletecalendar>';
	}
					
	if (array_key_exists('listcalendars',$requests)) {
		$retbuf .= '<listcalendars>' . dolistcalendars($sme) . '</listcalendars>';
	}
				
	/* See the dogetblocks code for another way to handle multiple requests in a stream */
	if (array_key_exists('getblocks',$requests)) {
		$retbuf .= '<getblocks>' . dogetblocks($sme) . '</getblocks>';
	}

	if (array_key_exists('addblock',$requests)) {
		$retbuf .= '<addblock>' . doaddblock($sme) . '</addblock>';
	}
		
	if (array_key_exists('editblock',$requests)) {
		$retbuf .= '<editblock>' . doeditblock($sme) . '</editblock>';
	}
		
	if (array_key_exists('deleteblock',$requests)) {
		$retbuf .= '<deleteblock>' . dodeleteblock($sme) . '</deleteblock>';
	}
		
	if (array_key_exists('addseries',$requests)) {
		$retbuf .= '<addseries>' . doaddseries($sme) . '</addseries>';
	}
		
	if (array_key_exists('editseries',$requests)) {
		$retbuf .= '<editseries>' . doeditseries($sme) . '</editseries>';
	}
		
	if (array_key_exists('deleteseries',$requests)) {
		$retbuf .= '<deleteseries>' . dodeleteseries($sme) . '</deleteseries>';
	}
	
	if (array_key_exists('listappointments',$requests)) {
		$retbuf .= '<listappointments>' . dolistappointments($sme) . '</listappointments>';
	}	
		
	if (array_key_exists('getappointments',$requests)) {	
		$retbuf .= '<getappointments>' . dogetappointments($sme) . '</getappointments>';
	}
		
	if (array_key_exists('addappointment',$requests)) {
		$retbuf .= '<addappointment>' . doaddappointment($sme) . '</addappointment>';
	}
		
	if (array_key_exists('deleteappointment',$requests)) {
		$retbuf .= '<deleteappointment>' . dodeleteappointment($sme) . '</deleteappointment>';
	}
			
	if (array_key_exists('getdidyouknow',$requests)) {
		$retbuf .= '<getdidyouknow>' . dogetdidyouknow($sme) . '</getdidyouknow>';
	}
	
	if (array_key_exists('isemailvalid',$requests)) {
		$retbuf .= '<isemailvalid>' . doisemailvalid($sme) . '</isemailvalid>';
	}

/* New functions for mobile support */
	
	if (array_key_exists('getuserinfo',$requests)) {
		$retbuf .= '<getuserinfo>' . dogetuserinfo($sme) . '</getuserinfo>';
	}

	
	if (array_key_exists('getblockslots',$requests)) {
		$retbuf .= '<getblockslots>' . dogetblockslots($sme) . '</getblockslots>';
	}
	
			
	if (array_key_exists('getmatchingcalendars',$requests)) {
		$retbuf .= '<getmatchingcalendars>' . dogetmatchingcalendars($sme) . '</getmatchingcalendars>';
	}

		
	if (array_key_exists('getblockheaders',$requests)) {
		$retbuf .= '<getblockheaders>' . dogetblockheaders($sme) . '</getblockheaders>';
	}

		
	if (array_key_exists('getblockswithslots',$requests)) {
		$retbuf .= '<getblockswithslots>' . dogetblockswithslots($sme) . '</getblockswithslots>';
	}
		
	
	if (array_key_exists('getblockheaderinfo',$requests)) {
		$retbuf .= '<getblockheaderinfo>' . dogetblockheaderinfo($sme) . '</getblockheaderinfo>';
	}

		
	if (array_key_exists('getapptinfo',$requests)) {
		$retbuf .= '<getapptinfo>' . dogetapptinfo($sme) . '</getapptinfo>';
	}

			
	if (array_key_exists('getappts',$requests)) {
		$retbuf .= '<getappts>' . dogetappts($sme) . '</getappts>';
	}


	if (array_key_exists('addappt',$requests)) {
		$retbuf .= '<addappt>' . doaddappt($sme) . '</addappt>';
	}
		
		
	if (array_key_exists('editappt',$requests)) {
		$retbuf .= '<editappt>' . doeditappt($sme) . '</editappt>';
	}

		
	if (array_key_exists('lockappointment',$requests)) {
		$retbuf .= '<lockappointment>' . dolockappointment($sme) . '</lockappointment>';
	}

		
	if (array_key_exists('syncappointment',$requests)) {
		$retbuf .= '<syncappointment>' . dosyncappointment($sme) . '</syncappointment>';
	}
									
	/* 
	We have now processed all possible requests.  End the response and loop back for
	the next one. 
	*/
	$retbuf .= '</wass>';
	
}

/* Now return the results to the caller */
wassUtil::returnXML($retbuf . wassParms::XMLTRAILER);


/*
Login (establish a session).
*/	
function dologin($sme) {

	/* Save the parameters */
	$child = $sme->login;
	$userid = trim( (string) $child->userid);
	$password = trim( (string) $child->password);
	$email = trim( (string) $child->email);
	
	
	/* Init sessionid return variable */
	$sessionid = '';
	
	/* If a userid passed, validate it */
	if ($userid) {
		/* If bad password, return error */
		if (!wassDirectory::idCheck($userid,$password))
			return wassUtil::Error(6,'','AJAXERR');
	}
	/* If no userid or email, but we are using CAS, do a CAS authentication */
	elseif (!$email)  {
		if (wassParms::AUTHTYPE == wassParms::AUTHCAS) {
			/* Ask CAS to authenticate the user */
			phpCAS::client(wassParms::CASversion,wassParms::CAShost,wassParms::CASport,wassParms::CASuri);
			phpCAS::setNoCasServerValidation();
			phpCAS::forceAuthentication();
			$userid = phpCAS::getUser();
		}
	}
	else
		return wassUtil::Error(7,'','AJAXERR');

	/* Start the session and save the session id */
	session_start();
	$sessionid = session_id();
	
	/* Now save the session variables */
	if ($userid) {
		$_SESSION['authtype'] = 'user';
		$_SESSION['authid'] = $userid;
	}
	else {
		$_SESSION['authtype'] = 'guest';
		$_SESSION['authid'] = $email;
	}	
	$_SESSION['authenticated'] = true;
		
		
	/* Now complete the login data stream. */
	return wassUtil::Error(0,'','AJAXERR') . '<userid>' . $userid . '</userid><password></password><email>' . $email . '</email><sessionid>' . $sessionid . '</sessionid>';	
		
}


/*
Save a user preferences.
*/
function dosaveprefs($sme) {

	/* Point to the child element */
	$child = $sme->saveprefs;		
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'saveprefs'))
		return $err;

	/* Start building the response */
	$ret =  wassUtil::Error(0,'','AJAXERR');
	
	/* Get userid for preference */
	$userid = $_SESSION['authid'];
	
	/* Iterate through the pref elements */
	foreach ($child->pref as $pref) {
		$key = trim((string) $pref->keytag);
		$value = trim((string) $pref->val);
		$class = trim((string) $pref->class);
		if (!$class) $class = 'user';
		
		/* Save the value */
		$ok = wassPrefs::savePref($userid,$key,$value,$class);
			
		/* Add to output string */
		$ret .= '<pref><keytag>'.wassUtil::safeXml($key).'</keytag><val>'.wassUtil::safeXml($value).'</val></pref>';
	}
	
	return $ret;
}	


/*
Get user preferences.
*/
function dogetprefs($sme) {

	/* Point to the child element */
	$child = $sme->getprefs;		
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'getprefs'))
		return $err;

	/* Start building the response */
	$ret =  wassUtil::Error(0,'','AJAXERR');
	
	/* Save userid for prefrences */
	$userid = $_SESSION['authid'];
	
	/* Iterate through the pref elements */
	foreach ($child->pref as $pref) {
		$key = trim((string) $pref->keytag);
		$class = trim((string) $pref->class);
		if (!$class) $class = 'user';
		/* Get */
		$value = wassPrefs::getPref($userid,$key,$class);
		
		/* Add to output string */
		$ret .= '<pref><keytag>'.wassUtil::safeXml($key).'</keytag><val>'.wassUtil::safeXml($value).'</val></pref>';
	}
	
	return $ret;
}


/*
Get all user preferences.
*/
function dogetalluserprefs($sme) {

	/* Point to the child element */
	$child = $sme->getalluserprefs;		
	$sessionid = trim( (string) $child->sessionid);

	
	/* Test authentication */
	if ($err = testauth($sessionid,'getalluserprefs'))
		return $err;


	/* Start building the response */
	$ret =  wassUtil::Error(0,'','AJAXERR');

	/* Get all of the prerefences */
	$valarray = wassPrefs::getAllUserPrefs($_SESSION['authid'],'user');

	if ($valarray) {
		foreach ($valarray as $key=>$value) {
			/* Add to output string */
			$ret .= '<pref><keytag>'.wassUtil::safeXml($key).'</keytag><val>'.wassUtil::safeXml($value).'</val></pref>';
		}
	}
	
	return $ret;
}


/* 
Validate a list of users.	
*/
function dovalidateusers($sme) {

	/* Start building the response */
	$ret =  wassUtil::Error(0,'','AJAXERR');

	/* Iterate through the user elements */
	$child = $sme->validateusers;
	foreach ($child->user as $user) {
		$userid = trim((string) $user->userid);
		$password = trim((string) $user->password);
		$ret .= '<user><userid>'.wassUtil::safeXml($userid).'</userid><password>'.wassUtil::safeXml($password).'</password><valid>';
		/* Check userid/password if specified */
		if ($password) {
			if (wassDirectory::idCheck($userid,$password))
				$ret .= 'true';
			else
				$ret .= 'false';
		}
		/* Otherwise just check userid */
		else {
			if (wassDirectory::useridCheck($userid))
				$ret .= 'true';
			else
				$ret .= 'false';
		}
		$ret .= '</valid></user>';
	}
	
	return $ret;
}


/* 
Validate a list of courses.	
*/
function dovalidatecourses($sme) {

	/* Start building the response */
	$ret .= wassUtil::Error(0,'','AJAXERR');
	
	/* Iterate through the course elements */
	$child = $sme->validatecourses;
	foreach ($child->course as $course) {
		$courseid = trim((string) $course->courseid);
		$ret .= '<course><courseid>'.wassUtil::safeXml($courseid).'</courseid><valid>';
		/* Check if course is valid */
		if ((wassUtil::isCourseValid($courseid)) || (wassUtil::isCourseValid(strtoupper($courseid))))
			$ret .= 'true';
		else
			$ret .= 'false';
		$ret .= '</valid></course>';
	}

	/* Return the response. */
	return $ret;

}
	
	
/* 
Return a list of day types.	
*/
function dogetdaytypes($sme) {

	/* Start building the response */
	$ret = wassUtil::Error(0,'','AJAXERR');
	
	/* Iterate through the dates */
	$child = $sme->getdaytypes;
	foreach ($child->daytypes as $daytypes) {
		$date = trim((string) $daytypes->date);
		/* Get the daytype and add it to the output string. */
		$ret .= '<daytypes><date>' . $date . '</date><daytype>' . wassUtil::safeXml(wassAcCal::daytype($date)) . '</daytype></daytypes>';
	}

	/* Return the response. */
	return $ret;

}
		
		
/* 
Return a parameter value.	
*/
function dogetparameter($child) {

	/* Extract the desired parameter value */
	$parmobject = $child->parameter;
	$parameter = trim(strtoupper((string) $parmobject));

	/* Refuse to return the system password */
	if ($parameter == 'PASS')
		return wassUtil::Error(8,array($parameter),'AJAXERR');
				
	/* Return an error if the parameter does not exist */
	if (!defined('wassParms::' . $parameter))
		return wassUtil::Error(8,array($parameter),'AJAXERR');	
	/* Else return the value */
	else 
		return wassUtil::Error(0,'','AJAXERR') .  '<parameter>' . wassUtil::safeXml($parameter) . '</parameter><value>' . wassUtil::safeXml(constant('wassParms::' . $parameter)) . '</value>';
 		
}


/* 
Return information about a user.	
*/
function dogetuserdetails($sme) {
	
	/* Extract the desired userid */
	$child = $sme->getuserdetails;
	$userid= trim((string) $child->userid);
	
	if (!$userid)
		return wassUtil::Error(13,array('userid','getuserdetails'),'AJAXERR');

	/* Return the data. */
	return wassUtil::Error(0,'','AJAXERR') . '<userid>' . $userid . '</userid>' .
			 '<name>' . wassUtil::safeXml(wassDirectory::getName($userid)) . '</name>' .
			'<email>' . wassUtil::safeXml(wassDirectory::getEmail($userid)) . '</email>' .
			'<phone>' . wassUtil::safeXml(wassDirectory::getPhone($userid)) . '</phone>' .
			'<office>' . wassUtil::safeXml(wassDirectory::getOffice($userid)) . '</office>';

}



/* 
Return information about a user, different format.	
*/
function dogetuserinfo($sme) {
	
	/* Extract the desired userid */
	$child = $sme->getuserinfo;
	$userid= trim((string) $child->userid);
	
	if (!$userid)
		return wassUtil::Error(13,array('userid','getuserinfo'),'AJAXERR');

	/* Return the data. */
	return wassUtil::Error(0,'','AJAXERR') . '<userid>' . $userid . '</userid>' .
			'<userinfo>' .
			tag('userid',$userid) .
			 '<name>' . wassUtil::safeXml(wassDirectory::getName($userid)) . '</name>' .
			 '<phone>' . wassUtil::safeXml(wassDirectory::getPhone($userid)) . '</phone>' .
			'<email>' . wassUtil::safeXml(wassDirectory::getEmail($userid)) . '</email>' .
			'<office>' . wassUtil::safeXml(wassDirectory::getOffice($userid)) . '</office>' .
			'</userinfo>';

}
	
	

/* 
Return list of all supported views (appointment slot sizes).
*/		
function dogetallviews($sme) {		
	/* Return the list (from the parameters file) */
	return wassUtil::Error(0,'','AJAXERR') . '<allviews>' . wassParms::ALLVIEWS . '</allviews>';
	
}

						
	
/* 
Return list of valid views for a given calendar/date.
*/	
function dogetvalidviews($sme) {
	
	/* Extract the parameters */
	$child = $sme->getvalidviews;
	$calendarid = (int) $child->calendarid;
	$date = trim( (string) $child->date);
	
	/* Validate the parameters */
	if (!$date || !$calendarid)
		return wassUtil::Error(9,array('getvalidviews',$ajaxml),'AJAXERR');
	elseif (!wassUtil::isDateValid($date))
		return wassUtil::Error(10,array('date','getvalidviews'),'AJAXERR');
	
	/* Load the calendar */
	else {
		try {
			if (!$calendar = new wassCalendar('load', array('calendarid'=>$calendarid)))
				return wassUtil::Error(10,array('calendarid','getvalidviews'),'AJAXERR');
		} catch (Exception $error) {
			/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}
	}
	
	/* Return the list of valid views */
	return wassUtil::Error(0,'','AJAXERR') . '<calendarid>' . $calendarid . '</calendarid><date>' . $date . '</date><validviews>' . $calendar->listViews($date) . '</validviews>';
		
}

 
/* 
Return best view for a given calendar/date.
*/	
function dogetbestview($sme) {
	
	/* Extract the parameters */
	$child = $sme->getbestview;
	$calendarid = (int) $child->calendarid;
	$date = trim( (string) $child->date);
	
	/* Validate the parameters */
	if (!$date || !$calendarid)
		return wassUtil::Error(9,array('getbestview',$ajaxml),'AJAXERR');
	elseif (!wassUtil::isDateValid($date))
		return wassUtil::Error(10,array('date','getbestview'),'AJAXERR');
	
	/* Load the calendar */
	else {
		try {
			if (!$calendar = new wassCalendar('load', array('calendarid'=>$calendarid)))
				return wassUtil::Error(10,array('calendarid','getbestview'),'AJAXERR');
		} catch (Exception $error) {
			/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}
	}
	
	/* Return the list of valid views */
	return wassUtil::Error(0,'','AJAXERR') . '<calendarid>' . $calendarid . '</calendarid><date>' . $date . '</date><bestview>' . $calendar->bestView($date) . '</bestview>';
		
}

 
				
/* 
Return indication of whether/not calendar is viewable by the authenticated user.
*/	
function doiscalendarviewable($sme) {		

	/* Extract the parameters */
	$child = $sme->iscalendarviewable;
	$calendarid = (int) $child->calendarid;		
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'iscalendarviewable'))
		return $err;
		
	/* Load the calendar */
	try {
		if (!$calendar = new wassCalendar('load', array('calendarid'=>$calendarid)))
			return wassUtil::Error(10,array('calendarid','iscalendarviewable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	/* Return the availability status. */	
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><calendarid>' . $calendarid . '</calendarid><isallowed>' . $calendar->isViewable($_SESSION['authtype'], $_SESSION['authid']) . '</isallowed>';
		
}

	
/* 
Return indication of whether/not block is viewable.
*/	
function doisblockviewable($sme) {		

	/* Extract the parameter */
	$child = $sme->isblockviewable;
	$blockid = (int) $child->blockid;		
	$sessionid = trim( (string) $child->sessionid);

	/* Test authentication */
	if ($err = testauth($sessionid,'isblockviewable'))
		return $err;
				
	/* Exit if no blockid passed */
	if (!$blockid)
		return wassUtil::Error(11,array('Blockid','isblockviewable'),'AJAXERR');		
		
	/* Load the block */
	else try {
		if (!$block = new wassBlock('load', array('blockid'=>$blockid)))
			return wassUtil::Error(10,array('blockid','isblockviewable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	/* Return the availability status */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><blockid>' . $blockid . '</blockid><isallowed>' . $block->isViewable($_SESSION['authtype'], $_SESSION['authid']) . '</isallowed>';
		
}


/* 
Return indication of whether/not appointment is makeable.
*/	
function doisappointmentmakeable($sme) {		

	/* Extract the parameters */
	$child = $sme->isappointmentmakeable;
	$blockid = (int) $child->blockid;		
	$sessionid = trim( (string) $child->sessionid);

	/* Test authentication */
	if ($err = testauth($sessionid,'isappointmentmakeable'))
		return $err;

	/* Exit if no blockid passed */
	if (!$blockid)
		return wassUtil::Error(11,array('blockid','isappointmentmakeable'),'AJAXERR');		
				
	/* Load the block */
	try {
		if (!$block = new wassBlock('load', array('blockid'=>$blockid)))
			return wassUtil::Error(10,array('blockid','isappointmentmakeable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	/* Check if user can make an appointment for this block. */
	$whynot = $block->isMakeable($_SESSION['authtype'],$_SESSION['authid'],"","");			
	if (!$whynot)
		$ok = 1;
	else
		$ok = 0;

	/* Return the availability status */ 
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><blockid>' . $blockid . '</blockid><isallowed>' . $ok . '</isallowed><reason>' . wassUtil::safeXml($whynot) . '</reason>';
	
}

/* 
Return count (how many) of makeable appointments.
*/	
function domakeableapps($sme) {		

	/* Extract the parameters */
	$child = $sme->makeableapps;
	$blockid = (int) $child->blockid;		
	$sessionid = trim( (string) $child->sessionid);

	/* Test authentication */
	if ($err = testauth($sessionid,'makeableapps'))
		return $err;

	/* Exit if no blockid passed */
	if (!$blockid)
		return wassUtil::Error(11,array('blockid','makeableapps'),'AJAXERR');		
				
	/* Load the block */
	try {
		if (!$block = new wassBlock('load', array('blockid'=>$blockid)))
			return wassUtil::Error(10,array('blockid','makeableapps'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	
	/* Return the count of available apppointment slots. */ 
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><blockid>' . $blockid . '</blockid><count>' . $block->makeableApps($_SESSION['authtype'],$_SESSION['authid'],"","") . '</count>';
	
}


/* 
Return list of dates (consecutive) and their appointment availability.
*/	
function dogetavailabledates($sme) {		

	/* Extract the parameters */
	$child = $sme->getavailabledates;
	$startdate= trim($child->startdate);		
	$enddate= trim($child->enddate);		
	$calendarid= trim($child->calendarid);		
	$sessionid = trim( (string) $child->sessionid);

	/* Test authentication */
	if ($err = testauth($sessionid,'getavailabledates'))
		return $err;

	/* Exit if no startdate passed */
	if (!$startdate)
		return wassUtil::Error(11,array('startdate','getavailabledates'),'AJAXERR');						

	/* Exit if no enddate passed */
	if (!$enddate)
		return wassUtil::Error(11,array('enddate','getavailabledates'),'AJAXERR');		
	
	/* Exit if no calendarid passed */
	if (!$calendarid)
		return wassUtil::Error(11,array('calendarid','getavailabledates'),'AJAXERR');		

	/* Convert start and end dates into incrementable (loopable) Unix dates */
	$start = mktime(3,0,0,substr($startdate,5,2),substr($startdate,8),substr($startdate,0,4));
	$end = mktime(3,0,0,substr($enddate,5,2),substr($enddate,8),substr($enddate,0,4));
		
	/* Check for reasonable dates */
	if ($end < $start)
		return wassUtil::Error(11,array('date range','getavailabledates'),'AJAXERR');
		
	$test = $end-$start;
	if ($test > (60*60*24*800))
		return wassUtil::Error(11,array('date range','getavailabledates'),'AJAXERR');
		
	/* Build output header */
	$ret = wassUtil::Error(0,'','AJAXERR').'<sessionid>'.$sessionid.'</sessionid><calendarid>'. $calendarid.'</calendarid><startdate>'.$startdate.'</startdate><enddate>'.$enddate.'</enddate><dates>';
				
	
	/* Loop over all of the dates */
	for ($i=$start;$i<=$end;$i+=(24*60*60)) {
		$curdate = date('Y-m-d',$i);
		/* Get all of the blocks for this day */
		$blocks = wassBlock::listMatchingBlocks(
									array(
										'calendarid'=>trim($calendarid),
										'date'=>$curdate,
										)
									);
		/* Assume not available date */
		$avail = 0;
		foreach ($blocks as $block) {
			/* Check if user can make an appointment for this block. */
			$whynot = trim($block->isMakeable($_SESSION['authtype'],$_SESSION['authid'],"",""));			
			if (!$whynot)
				$avail = 1;
			if ($avail == 1) 
				$break;
		}
		$ret .= '<date>' . $curdate . '</date><available>' . $avail . '</available>';
	
	}
	
	return $ret . '</dates>';
	
}



/* 
Return list of dates (consecutive) and their block/slot availability.
*/	
function dogetdatestatus($sme) {		

	/* Extract the parameters */
	$child = $sme->getdatestatus;
	$startdate= trim($child->startdate);		
	$enddate= trim($child->enddate);		
	$calendarid= trim($child->calendarid);		
	$blockownerid= trim($child->blockownerid);		
	$sessionid = trim( (string) $child->sessionid);

	/* Test authentication */
	if ($err = testauth($sessionid,'getdatestatus'))
		return $err;

	/* Get userid */
	$userid = $_SESSION['authid'];
	
	/* Exit if no startdate passed */
	if (!$startdate)
		return wassUtil::Error(11,array('startdate','getdatestatus'),'AJAXERR');						

	/* Exit if no enddate passed */
	if (!$enddate)
		return wassUtil::Error(11,array('enddate','getdatestatus'),'AJAXERR');		
	
	/* Exit if no calendarid passed */
	if (!$calendarid)
		return wassUtil::Error(11,array('calendarid','getdatestatus'),'AJAXERR');		

	/* Convert start and end dates into incrementable (loopable) Unix dates */
	$start = mktime(3,0,0,substr($startdate,5,2),substr($startdate,8),substr($startdate,0,4));
	$end = mktime(3,0,0,substr($enddate,5,2),substr($enddate,8),substr($enddate,0,4));
		
	/* Check for reasonable dates */
	if ($end < $start)
		return wassUtil::Error(11,array('date range','getdatestatus'),'AJAXERR');
		
	$test = $end-$start;
	if ($test > (60*60*24*800))
		return wassUtil::Error(11,array('date range','getdatestatus'),'AJAXERR');
		
	/* Build output header */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><calendarid>' . $calendarid . '</calendarid><startdate>'.$startdate.'</startdate><enddate>'.$enddate.'</enddate><blockownerid>'.$blockownerid.'</blockownerid><dates>';
				
	/* The calendarid can be a list of calendars.  Build a select clause that ORs them together. */
	$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassBlock WHERE (';
	$calendars = explode(' ',$calendarid);
	$first = true;
	foreach ($calendars as $calendar) {
		if (!$first) 
			$select .= ' OR ';
		$select .= 'calendarid=' . wassSQL::sqlSafe($calendar);
		$first = false;
	}
	$select .= ') AND ';
	/* check for a block owner id */
	if (trim($blockownerid)) {
		$select .= 'userid=' . wassSQL::sqlSafe($blockownerid) . ' AND ';
	}
	
	/* Loop over all of the dates */
	for ($i=$start;$i<=$end;$i+=(24*60*60)) {
		$curdate = date('Y-m-d',$i);
		/* Get all of the blocks for this day */
		
		$blocks = new wassList($select . ' date=' . wassSQL::sqlSafe($curdate),'Block');
		
		/* Assume no blocks/apps/slots */
		$blockstat = 'noblocks';
		$appstat = 'noapps';
		$slotstat = 'noslots';
		
		foreach ($blocks as $block) {
			/* We have blocks */
			$blockstat = 'blocks';
			
			/* Check if user can make an appointment for this block. */
			$whynot = trim($block->isMakeable($_SESSION['authtype'],$_SESSION['authid'],"",""));			
			if (!$whynot)
				/* We have slots */
				$slotstat = 'slots';
				
			/* Check if any appointments have been made for this block */
			$appointments = wassAppointment::listMatchingAppointments(array("blockid"=>$block->blockid));	
			if ($appointments->entries()) {
				/* We have appointments */
				if ($appstat == 'noapps')
					$appstat = 'apps';
				/* See if any for this user */
				foreach ($appointments as $appointment) {
					if ((strtoupper($appointment->userid) == strtoupper($userid))  ||
						(($_SESSION['authtype'] == 'guest') &&  ($appointment->email == $userid))) {
						$appstat = 'myapps';
						break;
					}
				}
			}		
		}
		
		$ret .= '<date>' . $curdate . '</date><status>' . $blockstat . $appstat . $slotstat . '</status>';
	}
	
	return $ret . '</dates>';
	
}


/* 
Return calendar data for a specified calendarid or userid.
*/	
function dogetcalendars($sme) {		

	/* Extract the parameters */

	$children = $sme->getcalendars;
	
	/* Init return string */
	$ret = '';
	
	foreach($children as $child) {

		$calendarid = (int) $child->calendarid;		
		$userid = trim( (string) $child->userid);
		$title = trim( (string) $child->title);
		$sessionid = trim( (string) $child->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getcalendars')) {
			$ret .= $err;
			break;
		}
		/* Build calendar selection criteria based on arguments. */
		if ($calendarid)
			$loadarg = array('calendarid'=>$calendarid); 
		elseif ($userid)
			$loadarg = array('userid'=>$userid); 
		elseif ($title)
			$loadarg = array('title'=>$title); 
		else {
			$ret .= wassUtil::Error(9,array('getcalendars',$ajaxml),'AJAXERR');
			break;
		}
		/* Build return header */
		$ret .=  wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		if ($calendarid)
			$ret .= '<calendarid>' . $calendarid . '</calendarid>';
		elseif ($userid)
			$ret .= '<userid>' . $userid . '</userid>';
		else
			$ret .= '<title>' . $title . '</title>';
				
		/* Now build list of matching calendars */		
		$calendars = wassCalendar::wlistMatchingCalendars($loadarg);
		
		/* Loop through results and encode returned data on matching (viewable) calendars. */
		foreach ($calendars as $calendar) {
			if ($calendar->isViewable($_SESSION['authtype'], $_SESSION['authid']))
				$ret .= '<calendar>' . wassUtil::objectToXML($calendar,'') . '</calendar>';
			unset($calendar);	
		}
		
		/* Now handle calendars the user is managing */
		if ($userid) {
			/* Get array listing all users whose calendars the specified user is managing.*/
			$managedlist = wassManager::arrayManagedids($userid);
			/* Go through the list of users being managed (but only once per distinct user) */
			$allreadysaw[$userid] = true;
			if ($managedlist) {
				foreach ($managedlist as $manager) {
					if (!$allreadysaw[$manager]) {
						$calendars = wassCalendar::wlistMatchingCalendars(array('userid'=>$manager));
						foreach ($calendars as $calendar) {
							if ($calendar->isViewable($_SESSION['authtype'], $_SESSION['authid']))
								$ret .= '<calendar>' . wassUtil::objectToXML($calendar,'') . '</calendar>';
							unset($calendar);
						}
					}
					$allreadysaw[$manager] = true;
				}		
			}
		}
	}
	/* Return the response. */	
	return $ret;	
}


/* 
Return calendar data for a specified calendarid or userid.
*/	
function dogetmatchingcalendars($sme) {		

	/* Extract the parameters */

	$children = $sme->getmatchingcalendars;
	
	/* Init return string */
	$ret = '';
	
	foreach($children as $child) {

		$userid_list = trim( (string) $child->userid);
		$searchstring = trim( (string) $child->searchstring);
		$sessionid = trim( (string) $child->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getmatchingcalendars')) {
			$ret .= $err;
			break;
		}
		/* Build calendar selection criteria based on arguments. */
		if ($userid_list) {
			$userids = explode(',',$userid_list);
			foreach($userids as $userid) {
				if ($select)
					$select .= ' OR ';
				$select .= '`userid` =' . wassSQL::sqlSafe($userid);
			}
		}
		else 
			$select = '`userid` LIKE ' . wassSQL::sqlSafe('%'.$searchstring.'%') . ' OR `name` LIKE ' . wassSQL::sqlSafe('%'.$searchstring.'%')  . ' OR `title` LIKE ' . wassSQL::sqlSafe('%'.$searchstring.'%');
			
		$select = 'SELECT * FROM '. wassParms::DATABASE . '.wassCalendar WHERE (' . $select . ')';	
	
		
		/* Build return header */
		$ret .=  wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		if ($userid_list)
			$ret .= '<userid>' . $userid_list. '</userid>';
		else
			$ret .= '<searchstring>' . $searchstring . '</searchstring>';
	
		
		/* Now build list of matching calendars */		
		$calendars = new wassList($select,'Calendar');
		
		/* Loop through results and encode returned data on matching (viewable) calendars. */
		foreach ($calendars as $calendar) {
			if ($calendar->isViewable($_SESSION['authtype'], $_SESSION['authid']))
				$ret .= '<calendar>' . $calendar->getheaderinfo() . '</calendar>';
			unset($calendar);	
		}
		
		/* Now handle calendars the user is managing */
		if ($userid_list) {
			foreach($userids as $userid) {
			  /* Get array listing all users whose calendars the specified user is managing.*/
			  $managedlist = wassManager::arrayManagedids($userid);
			  /* Go through the list of users being managed (but only once per distinct user) */
			  $allreadysaw[$userid] = false;
			  if ($managedlist) {
				  foreach ($managedlist as $manager) {
					  if (!$allreadysaw[$manager]) {
						  $calendars = wassCalendar::wlistMatchingCalendars(array('userid'=>$manager));
						  foreach ($calendars as $calendar) {
							  if ($calendar->isViewable($_SESSION['authtype'], $_SESSION['authid']))
								  $ret .= '<calendar>' . $calendar->getheaderinfo()  . '</calendar>';
							  unset($calendar);
						  }
					  }
					  $allreadysaw[$manager] = true;
				  }	
			  }
			}
		}
	}
	/* Return the response. */	
	return $ret;	
}


	
/*
Create a calendar.
*/
function doaddcalendar($sme) {

	/* Point to the xml elements */
	$child = $sme->addcalendar;
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'addcalendar'))
		return $ret;
					
	/* Make sure we got the calendar data */	
	$calendar = $child->calendar;		
	if (!is_object($calendar))
		return wassUtil::Error(13,array('calendar','addcalendar'),'AJAXERR');

	/* Make sure authenticated user is creating their own calendar or is
	   creating a calendar for someone whose calendar they manage. */
	if ($_SESSION['authtype'] == 'guest')
		return wassUtil::Error(23,'','AJAXERR');
	elseif (strtoupper($_SESSION['authid']) != strtoupper(trim($calendar->userid))) {
		/* Check if this user is a manager for target user */
		if (!in_array(strtoupper($_SESSION['authid']),wassManager::arrayActiveManagers(strtoupper(trim($calendar->userid)))))
			return wassUtil::Error(24,array($_SESSION['authid'],trim($calendar->userid)),'AJAXERR');
	}		
		
									
	/* Create the calendar. */
	try {
		$calobject = new wassCalendar('create', get_object_vars($calendar));
	} catch (Exception $error) {
	/* If an error, return error code and message. */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	/* Now save the calendar (and update the manager table). */
	try {
		$calid = $calobject->save('create');
		/* Notify sysadmin*/
		if (wassParms::MAILCAL) {
			mail(wassParms::SYSMAIL,'Calendar created for ' . $calobject->userid . ' (' . $calobject->name . ')','','From: ' . wassParms::FROMMAIL . "\r\n");
		}
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	$calobject->calendarid = $calid;
	 
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessiondid><calendar>' . wassUtil::objectToXML($calobject) . '</calendar>';	
	
}
	
			
/*
Edit calendar properties.
*/
function doeditcalendar($sme) {

	/* Point to the xml elements */
	$child = $sme->editcalendar;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'editcalendar'))
		return $err;
						
	/* Make sure we got the calendar data */	
	$calendar = $child->calendar;		
	if (!is_object($calendar))
		wassUtil::Error(10,array('calendar','editcalendar'),'AJAXERR');			

	/* Load up the calendar and update it. */
	try {
		$calendarobject = new wasscalendar('update', get_object_vars($calendar));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user owns the calendar. */
	if (!$calendarobject->isOwnerOrManager($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'calendar  calendar'),'AJAXERR');
			
	/* Write out the updated calendar */
	try {
		$calendarid = $calendarobject->save('update');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>'. $sessionid .'</sessionid><calendar>' . wassUtil::objectToXML($calendarobject) . '</calendar>';		
		
}

	
/*
Delete a celendar (and all series/blocks/periods/appointments).
*/
function dodeletecalendar($sme) {
	/* Point to the xml elements */
	$child = $sme->deletecalendar;
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'deletecalendar'))
		return $err;
					
	/* Get the seriesid and cancel text */
	$calendarid = $child->calendarid;
	if (!$calendarid)
		return wassUtil::Error(13,array('calendarid','deletecalendar'),'AJAXERR');
	
	$text = $child->text;
		
	/* Load up the calendar */
	try {
		$calobject = new wassCalendar('load', array('calendarid'=>$calendarid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user owns the calendar. */
	if (!$calobject->canDelete($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'calendar'),'AJAXERR');
	
	/* Now delete the calendar (this will delete all blocks and appointments). */
	$calobject->delete($text);
	/* Notify sysadmin*/
	if (wassParms::MAILCAL) {
		mail(wassParms::SYSMAIL,'Calendar deleted for ' . $calobject->userid . ' (' . $calobject->name . ')','','From: ' . wassParms::FROMMAIL . "\r\n" );
	}

	/* Now let the caller know all went well */
	 return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><calendarid>' . $calendarid . '</calendarid><canceltext>' . $text . '</canceltext>' ;
	
}


		
/*
List specified data values from all calendars.
*/
function dolistcalendars($sme) {
	/* Point to the xml elements */
	$child = $sme->listcalendars;
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'listcalendars'))
		return $err;
					
	/* Get the list type (value requested) */
	$listtype = trim( (string) $child->listtype);
	if (!$listtype)
		return wassUtil::Error(13,array('listtype','listcalendars'),'AJAXERR');
	
	/* Validate the list type */	
	switch($listtype) {
		case "userid":
			$wanted = "userid";
			break;
		case "name":
			$wanted = "name";
			break;
		case "title":
			$wanted = "title";
			break;
		default:
			return wassUtil::Error(10,array('listtype','listcalendars'),'AJAXERR');
			break;
	}
	
	/* Start to build the output */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><listtype>' . $listtype . '</listtype>';
		
	/* Extract all of the requested values from all extant calendars */
	$values = wassCalendar::arrayCalendarField($wanted);
	
	foreach($values as $value) {
		$ret .= "<listvalue>" . wassUtil::safeXml($value) . "</listvalue>";
	}
 
	/* Return the completed string */
	return $ret;
	
}
		
	
/* 
Return block data for a given calendar and date.
*/	
function dogetblocks($sme) {				

	/* Point to the xml elements */
	$child = $sme->getblocks;
	
	/* Init return string */
	$ret = '';

	foreach($child as $nextblock) {

		/* Grab the sessionid */
		$sessionid = trim( (string) $nextblock->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getblocks')) {
			$ret .= $err;	
			break;
		}
			
				
		/* Look up all of the blocks as per the arguments. */
		$blockarray = array(
			array('calendarid,=,AND',trim($nextblock->calendarid)),
			array('date,>=,AND',trim($nextblock->startdate)),
			array('date,<=,AND',trim($nextblock->enddate)),
			array('endtime,>=,AND',trim($nextblock->starttime)),
		);
		if (trim($nextblock->userid)) {
			array_push($blockarray, array('starttime,<=,AND',trim($nextblock->endtime)));
			array_push($blockarray, array('userid,=',trim($nextblock->userid)));
		}
		else
			$blockarray[] = array('starttime,<=',trim($nextblock->endtime));

		$foundblocks = wassBlock::listOrderedBlocks($blockarray,'ORDER BY date, starttime');
			
		/* Build output header */
		$ret .= wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><calendarid>'.$nextblock->calendarid.'</calendarid><startdate>'.$nextblock->startdate.'</startdate><enddate>'.$nextblock->enddate.'</enddate><starttime>'.$nextblock->starttime.'</starttime><endtime>'.$nextblock->endtime.'</endtime><userid>'.$nextblock->userid.'</userid>';
		
		/* Go through all of the blocks */
		foreach ($foundblocks as $fblock) {
			/* Make sure block is viewable by this user, or user has an appointment in this block */
			$apps = wassAppointment::listOrderedAppointments(
							array(array('blockid,=,AND',trim($fblock->blockid)),array('userid',trim($_SESSION['authid']))),
							'ORDER by date');
			if ($apps->entries() || $fblock->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {		
				/* If block is part of a series, read in series block */
				$series = '';
				if ($fblock->seriesid)
					try { 
						$series = new wassSeries('load',array('seriesid'=>$fblock->seriesid));
					} catch (Exception $error) {
						$series = '';
					}
					
				/* Generate the XML for the block data */
				$ret .= '<block>' . wassUtil::objectToXML($fblock) . '</block>';
				 
				/* If a recurring block, add series data. */
				if ($series)		
					/* Append the series block */
					$ret .= '<series>' . wassUtil::objectToXML($series) . '</series>';
					
				/* Return indication as to whether/not user can make an appointment */
	
	            $ret .= '<whynotmakeable>' . $fblock->isMakeable($_SESSION['authtype'],$_SESSION['authid'],"","") . '</whynotmakeable>';		
			}	
		}
	}
	/* Return the response */
	return $ret;
}

	
/* 
Return block available slots for a given block or series, ordered by calendar date.
*/	
function dogetblockslots($sme) {	
			
	/* Point to the xml elements */
	$child = $sme->getblockslots;
	
	/* Init return string */
	$ret = '';

	foreach($child as $nextblock) {

		/* Grab the sessionid */
		$sessionid = trim( (string) $nextblock->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getblockslots')) {
			$ret .= $err;	
			break;
		}	
		
			
		/* Build output header */
		$ret .= wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		
		/* Extract blockid or seriesid */
		$blockid = trim( (string) $nextblock->blockid);
		$seriesid = trim( (string) $nextblock->seriesid);
		
		/* If a seriesid was passed, extract all the the blockids, ordered by date, else just the block. */
		if ($seriesid) {
			$ret .= '<seriesid>'.$seriesid.'</seriesid>';
			$blocks = wassBlock::listOrderedBlocks(array(array('seriesid,=',$seriesid)),'ORDER BY date, starttime');
		}
		else {
			$ret .= '<blockid>'.$blockid.'</blockid>';
			$blocks = wassBlock::listMatchingBlocks(array('blockid'=>$blockid));
		}
		
		
		/* Look up all of the blocks as per the arguments. */
		
		
		/* Go through all of the blocks and extract the slots */
		foreach ($blocks as $block) {
			/* Make sure block is viewable by this user, or user has an appointment in this block */
			if ($block->isViewable($_SESSION['authtype'], $_SESSION['authid'])) 		
	
			/* Get list of available start times */
			$available = $block->availableSlots($_SESSION['authtype'], $_SESSION['authid']);
			
			/* Add slot data */
			foreach ($available as $slotstart) {
				$ret .= '<slot>' .
						'<blockid>'.$block->blockid.'</blockid>' .
						'<date>'.$block->date.'</date>' .
						'<starttime>'.$slotstart.'</starttime>' .
						'<endtime>';
				if ($block->slotted) 
					$ret .= wassUtil::minToTime(wassUtil::timeToMin($slotstart) + $block->slotsize) . '</endtime>';
		
				else
					$ret .= $block->endtime.'</endtime>';	
				$ret .= '</slot>';	
			}				
		}	
	}
	/* Return the response */
	return $ret;
}

	
/* 
Return block available slots for a given block or series, ordered by calendar date.
*/	
function dogetblockheaderinfo($sme) {	
			
	/* Point to the xml elements */
	$child = $sme->getblockheaderinfo;
	
	/* Init return string */
	$ret = '';

	foreach($child as $nextblock) {

		/* Grab the sessionid */
		$sessionid = trim( (string) $nextblock->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getblockheaderinfo')) {
			$ret .= $err;	
			break;
		}	
		
			
		/* Build output header */
		$ret .= wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		
		/* Extract blockid  */
		$blockid = trim( (string) $nextblock->blockid);
		
		
		/* Get the block */
		$ret .= '<blockid>'.$blockid.'</blockid>';
		$block = new wassBlock('load',(array('blockid'=>$blockid)));
		

		/* Make sure block is viewable by this user, or user has an appointment in this block */
		if ($block->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {		
		  $ret .= '<block>' .
		  tag('blockid',$block->blockid) .
						tag('seriesid',$block->seriesid) .
						tag('calendarid',$block->calendarid) .
						tag('title',$block->title) .
						tag('description',$block->description) .
						'<blockowner>' .
							tag('userid',$block->userid) .
							tag('name',$block->name) .
							tag('phone',$block->phone) .
							tag('email',$block->email) .
							tag('office',$block->office) .
							'</blockowner>' .
						tag('date',$block->date) .
						tag('location',$block->location) .	
					'</block>';
		  
		  /* Get list of available start times */
		  $available = $block->availableSlots($_SESSION['authtype'], $_SESSION['authid']);
		  
		  /* Add slot data */
		  foreach ($available as $slotstart) {
			  $ret .= '<slot>' .
					  '<blockid>'.$block->blockid.'</blockid>' .
					  '<date>'.$block->date.'</date>' .
					  '<starttime>'.$slotstart.'</starttime>' .
					  '<endtime>';
			  if ($block->slotted) 
				  $ret .= wassUtil::minToTime(wassUtil::timeToMin($slotstart) + $block->slotsize) . '</endtime>';
			  else
				  $ret .= $block->endtime.'</endtime>';	
			  $ret .= '</slot>';	
		  }
		}	
	}
	/* Return the response */
	return $ret;
}



/* 
Return block header information for a given calendar and date range and time range.
*/	
function dogetblockswithslots($sme) {	
			
	/* Point to the xml elements */
	$child = $sme->getblockswithslots;
	
	/* Init return string */
	$ret = '';

	foreach($child as $nextblock) {

		/* Grab the sessionid */
		$sessionid = trim( (string) $nextblock->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getblockheaders')) {
			$ret .= $err;	
			break;
		}	
		
			
		/* Build output header */
		$ret .= wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		
		/* Extract arguments */
		$calendarid = trim( (string) $child->calendarid);
		$startdate = trim( (string) $child->startdate);
		$enddate = trim( (string) $child->enddate);
		
		if (!$enddate)
			$enddate = '3000-01-01';
		if (!$startdate)
			$enddate = '2000-01-01';
		
		/* Get list of matching blocks */		
		$foundblocks = wassBlock::listOrderedBlocks(
								array(
									array('calendarid,=,AND',trim($calendarid)),
									array('date,>=,AND',trim($startdate)),
									array('date,<=,AND',trim($enddate)),
								),
								'ORDER BY `date`, `starttime`'
							);
		
			
 		/* Build output header */
		$ret .= '<calendarid>'.$calendarid.'</calendarid><startdate>'.$startdate.'</startdate><enddate>'.$enddate.'</enddate>';
		
		/* Go through all of the blocks */
		foreach ($foundblocks as $fblock) {
			/* Make sure block is viewable by this user, or user has an appointment in this block */
			$apps = wassAppointment::listOrderedAppointments(
							array(array('blockid,=,AND',trim($fblock->blockid)),array('userid',trim($_SESSION['authid']))),
							'ORDER by date');
			if ($apps->entries() || $fblock->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {		
				/* Generate the XML for the block data */
				$ret .= '<blockwithslots><block>' . 
						tag('blockid',$fblock->blockid) .
						tag('seriesid',$fblock->seriesid) .
						tag('calendarid',$fblock->calendarid) .
						tag('title',$fblock->title) .
						tag('description',$fblock->description) .
						'<blockowner>' .
							tag('userid',$fblock->userid) .
							tag('name',$fblock->name) .
							tag('phone',$fblock->phone) .
							tag('email',$fblock->email) .
							tag('office',$fblock->office) .
							'</blockowner>' .
						tag('date',$fblock->date) .
						tag('location',$fblock->location) .		
						'</block>';
						  
		 		 /* Get list of available slots */
		  		$available = $fblock->availableSlots($_SESSION['authtype'], $_SESSION['authid']);
		  
		  		/* Add slot data */
		  		foreach ($available as $slotstart) {
			  		$ret .= '<slot>' .
					  '<blockid>'.$fblock->blockid.'</blockid>' .
					  '<date>'.$fblock->date.'</date>' .
					  '<starttime>'.$slotstart.'</starttime>' .
					  '<endtime>';
			  		if ($fblock->slotted) 
				  		$ret .= wassUtil::minToTime(wassUtil::timeToMin($slotstart) + $fblock->slotsize) . '</endtime>';
			  		else
				  		$ret .= $fblock->endtime.'</endtime>';	
			  		$ret .= '</slot>';	
		  		}
				$ret .= '</blockwithslots>';
			}	
		}
	}		
	/* Return the response */
	return $ret;
}


/* 
Return block header and slots information for a given calendar and date range and time range.
*/	
function dogetblockheaders($sme) {	
			
	/* Point to the xml elements */
	$child = $sme->getblockheaders;
	
	/* Init return string */
	$ret = '';

	foreach($child as $nextblock) {

		/* Grab the sessionid */
		$sessionid = trim( (string) $nextblock->sessionid);
		
		/* Test authentication */
		if ($err = testauth($sessionid,'getblockheaders')) {
			$ret .= $err;	
			break;
		}	
		
			
		/* Build output header */
		$ret .= wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
		
		/* Extract arguments */
		$calendarid = trim( (string) $child->calendarid);
		$startdate = trim( (string) $child->startdate);
		$enddate = trim( (string) $child->enddate);
		$starttime = trim( (string) $child->starttime);
		$endtime = trim( (string) $child->endtime);
		
		/* Set defaults for missing data */
		if (!$startdate)
			$startdate = '1990-01-01';
		if (!$enddate)
			$enddate = '2999-12-31';
		if (!$starttime)
			$starttime = '00:00';
		if (!$endtime)
			$endtime = '23:59';
		
		
		$foundblocks = wassBlock::listOrderedBlocks(
								array(
									array('calendarid,=,AND',trim($calendarid)),
									array('date,>=,AND',trim($startdate)),
									array('date,<=,AND',trim($enddate)),
									array('endtime,>=,AND',trim($starttime)),
									array('starttime,<=',trim($endtime))
								),
								'ORDER BY `date`, `starttime`'
							);
		
			
 /* Build output header */
		$ret .= '<calendarid>'.$calendarid.'</calendarid><startdate>'.$startdate.'</startdate><enddate>'.$enddate.'</enddate><starttime>'.$starttime.'</starttime><endtime>'.$endtime.'</endtime>';
		
		/* Go through all of the blocks */
		foreach ($foundblocks as $fblock) {
			/* Make sure block is viewable by this user, or user has an appointment in this block */
			$apps = wassAppointment::listOrderedAppointments(
							array(array('blockid,=,AND',trim($fblock->blockid)),array('userid',trim($_SESSION['authid']))),
							'ORDER by date');
			if ($apps->entries() || $fblock->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {		
				/* Generate the XML for the block data */
				$ret .= '<block>' . 
						tag('blockid',$fblock->blockid) .
						tag('seriesid',$fblock->seriesid) .
						tag('calendarid',$fblock->calendarid) .
						tag('title',$fblock->title) .
						tag('description',$fblock->description) .
						'<blockowner>' .
							tag('userid',$fblock->userid) .
							tag('name',$fblock->name) .
							tag('phone',$fblock->phone) .
							tag('email',$fblock->email) .
							tag('office',$fblock->office) .
							'</blockowner>' .
						tag('date',$fblock->date) .
						tag('location',$fblock->location) .		
						'</block>';
						/* For now, just return one block header */
						return $ret;	 	
			}	
		}
	}		
	/* Return the response */
	return $ret;
}



/* 
Add a block to a calendar.
*/	
function doaddblock($sme) {				

	
	/* Point to the xml elements */
	$child = $sme->addblock;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'addblock'))
		return $err;
		
	/* Make sure we got the block data */	
	$block = $child->block;	

	if (!is_object($block))
		return wassUtil::Error(10,array('block','addblock',$sme),'AJAXERR');
			
	/* Make sure we got the series and period data, if needed */	
	if (($block->recurrence == 'multiple') && (!$block->seriesid))
		return wassUtil::Error(10,array('seriesid','addblock'),'AJAXERR');
	if (($block->recurrence == 'multiple') && (!$block->periodid))
		return wassUtil::Error(10,array('periodid','addblock'),'AJAXERR');

	/* Read in the calendar */			
	try {
		if (!$calendar = new wassCalendar('load', array('calendarid'=>$block->calendarid)))
			return wassUtil::Error(10,array('calendarid','iscalendarviewable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}	

	/* Make sure the authenticated user owns the calendar. */
	if (!$calendar->isOwnerOrManager($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'block  calendar'),'AJAXERR');

	/* The user may be the calendar manager.  If so, we need to make sure that the block ends up being owned by the calendar owner (and has the owner's information, not the manager's), unless it is a group calendar. */
	if (!$calendar->group) {
	  if ($block->userid != $calendar->userid) {
		  $block->userid = $calendar->userid;
		  $block->name = $calendar->name;
		  $block->email = $calendar->email;
		  $block->phone = $calendar->phone;
	  }
	}

	/* Load up the block. */
	try {
		/* Build the block */
		$blockobject = new wassBlock('create', get_object_vars($block));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	

	
	/* Now save the block (and capture the block id) */
	try {
		$blockid = $blockobject->save('create');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	$blockobject->blockid = $blockid;
	
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><block>' . wassUtil::objectToXML($blockobject) . '</block>';
	
}


/* 
Change the data for a block.
*/			
function doeditblock($sme) {

	/* Point to the xml elements */
	$child = $sme->editblock;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'editblock'))
		return $err;
						
	/* Make sure we got the block data */	
	$block = $child->block;		
	if (!is_object($block))
		return wassUtil::Error(10,array('block','editblock'),'AJAXERR');			

	/* Read in the calendar */			
	try {
		if (!$calendar = new wassCalendar('load', array('calendarid'=>$block->calendarid)))
			return wassUtil::Error(10,array('calendarid','iscalendarviewable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}	

	/* Make sure the authenticated user owns the calendar. */
	if (!$calendar->isOwnerOrManager($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'block  calendar'),'AJAXERR');

	/* The user may be the calendar manager.  If so, we need to make sure that the block ends up being owned by the calendar owner (and has the owner's information, not the manager's). */
	if ($block->userid != $calendar->userid) {
		$block->userid = $calendar->userid;
	}

	/* Load up the block and update it. */
	try {
		$blockobject = new wassBlock('update', get_object_vars($block));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
			
	/* Write out the updated block */
	try {
		$blockid = $blockobject->save('update');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>'. $sessionid .'</sessionid><block>' . wassUtil::objectToXML($blockobject) . '</block>';		
	
}
	
	
/* 
Delete a block.
*/	
function dodeleteblock($sme) {				

	/* Point to the xml elements */
	$child = $sme->deleteblock;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'deleteblock'))
		return $err;
				
	/* Get the blockid and cancel text */
	$blockid = $child->blockid;
	if (!$blockid)
		return wassUtil::Error(13,array('blockid','deleteblock'),'AJAXERR');
	
	$text = $child->text;
	if (!$text) 
		$text = 'Block of time has become unavailable.';
		
	/* Load up the block */
	try {
		$blockobject = new wassBlock('load', array('blockid'=>$blockid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user owns the calendar. */
	if (!$blockobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],' block calendar'),'AJAXERR');
	
	/* Now delete the block (this will cancel the appointments). */
	$blockobject->delete($text);

	/* Now let the caller know all went well */
	 return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><blockid>' . $blockid . '</blockid><canceltext>' . $text . '</canceltext>';
	
}


/* 
Add a series.
*/	
function doaddseries($sme) {				

	/* Point to the xml elements */
	$child = $sme->addseries;
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'addseries'))
		return $err;
					
	/* Make sure we got the series data */	
	$series = $child->series;		
	if (!is_object($series))
		return wassUtil::Error(13,array('series','addseries'),'AJAXERR');
	
	/* Make sure we got the period data */
	$periods = $child->period;
	if (!$periods)
		return wassUtil::Error(13,array('period','addseries'),'AJAXERR');

	/* Read in the calendar */			
	try {
		if (!$calendar = new wassCalendar('load', array('calendarid'=>$series->calendarid)))
			return wassUtil::Error(10,array('calendarid','iscalendarviewable'),'AJAXERR');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}	

	/* Make sure the authenticated user owns the calendar. */
	if (!$calendar->isOwnerOrManager($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'series  calendar'),'AJAXERR');

	/* The user may be the calendar manager.  If so, we need to make sure that the block ends up being owned by the calendar owner (and has the owner's information, not the manager's), unless it is a group calendar. */
	if (!$calendar->group) {
	  if ($series->userid != $calendar->userid) {
		  $series->userid = $calendar->userid;
		  $series->name = $calendar->name;
		  $series->email = $calendar->email;
		  $series->phone = $calendar->phone;
	  }
	}
					
	/* Load up the series. */
	try {
		/* Build the series */
		$seriesobject = new wassSeries('create', get_object_vars($series));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Now save the series (and capture the series id) */
	try {
		$seriesid = $seriesobject->save('create');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Start building the output string */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessiondid><series>' . wassUtil::objectToXML($seriesobject) . '</series>';
	
	/* Now add the period elements and build the individual blocks */		
	foreach ($periods as $period) {
		/* Build the period object */
		try {
			/* Grab the specifid period data into an array */
			$parray = get_object_vars($period);
			/* Append the newly created seriesid */
			$parray['seriesid'] = $seriesid;
			/* Now build the period block */
			$periodobject = new wassPeriod('create',$parray);
		} catch (Exception $error) {
			/* Delete the series (and all periods and all blocks) */						
			$seriesobject->delete();
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}	
		/* Save the period block and capture the period id */
		$periodid = $periodobject->save('create');
		$periodobject->periodid = $periodid;
		
		/* Add period information to output string. */
		$ret .= '<period>' . wassUtil::objectToXML($periodobject) . '</period>';
		
		/* Now build the blocks */
		$errmsg = $seriesobject->buildblocks($periodobject);
		if (is_int($errmsg))
			$errmsg = '';
			
		/* If we failed, delete the series and let the user know */
		if ($errmsg) {
			$seriesobject->delete();
			return wassUtil::Error(14,$errmsg,'AJAXERR');
		}
	}
	
	/* Now return the data to the caller */
	return $ret;
	
}

/*
Edit a series (and/or the series period blocks).  Changes are diffused to all
of the series blocks.
*/		
function doeditseries($sme) {

	/* Point to the xml elements */
	$child = $sme->editseries;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'editseries'))
		return $err;
		
	/* 
	We must first validate all of the requested updates and only make
	changes if all the requested upadets are valid.
	 */		
				
	/* If we got series data */	
	$series = $child->series;		
	if (is_object($series)) {
		if (!$series->seriesid)	
			return wassUtil::Error(13,array('seriesid','editseries'),'AJAXERR');
		
		/* Read in the calendar */			
		try {
			if (!$calendar = new wassCalendar('load', array('calendarid'=>$series->calendarid)))
				return wassUtil::Error(10,array('calendarid','iscalendarviewable'),'AJAXERR');
		} catch (Exception $error) {
		/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}	
	
		/* Make sure the authenticated user owns the calendar. */
		if (!$calendar->isOwnerOrManager($_SESSION['authtype'], $_SESSION['authid']))
			return wassUtil::Error(12,array($_SESSION['authid'],'series  calendar'),'AJAXERR');
	
		/* The user may be the calendar manager.  If so, we need to make sure that the block ends up being owned by the calendar owner (and has the owner's information, not the manager's). */
		if ($series->userid != $calendar->userid) {
			$series->userid = $calendar->userid;

		}

							
		/* Load up the series and update it. */
		try {
			$seriesobject = new wassSeries('update', get_object_vars($series));
		} catch (Exception $error) {
		/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}

	}

	/* Now try to update any of the periods (time start/end data) */

	$periods = $child->period;
	$periodobjects = array();
	$pererrs = '';
	foreach($periods as $period) {
		/* Try to load and update the period */
		try {
			$periodobject = new wassPeriod('update', get_object_vars($period));
			/* Make sure the authenticated user owns the period calendar. */
			if (!$periodobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
				return wassUtil::Error(12,array($_SESSION['authid'],'period calendar'),'AJAXERR');
			/* Dave the object for later saving */
			$periodobjects[] = $periodobject;
		} catch (Exception $error) {
			/* If an error, save error message */
			$pererrs .= $error->getMessage() . '; ';
		}
	}
	if ($pererrs) 
		return wassUtil::Error(19,$perrs,'AJAXERR');
			
	/* Write out the updated series; this will update all of the blocks as well. */
	if ($series) {
		try {
			$seriesid = $seriesobject->save('update');
		} catch (Exception $error) {
		/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
		}
	}
	
	/* Now write out updated periods (this will update the blocks as well). */
	foreach ($periodobjects as $periodobject) {
		try {
			$periodobject->save('update');
		} catch (Exception $error) {
			/* If an error, return error code and message */
			return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');	
		}		
	}

	/* Start to build the return string. */
	$ret = '<sessionid>' . $sessiondid . '</sessionid>';
	
	/* Add in series (if specified) */
	if ($series) 
		$ret .= '<series>' . wassUtil::objectToXML($seriesobject) . '</series>';
	/* Add in any period data */
	foreach ($periodobjects as $periodobject) {
		$ret .= '<period>' . wassUtil::objectToXML($periodobject) . '</period>';
	}		


	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . $ret;		
	
}
	
	
/* 
Delete a series (and all associated blocks).
*/	
function dodeleteseries($sme) {				
	/* Point to the xml elements */
	$child = $sme->deleteseries;
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'deleteseries'))
		return $err;
					
	/* Get the seriesid and cancel text */
	$seriesid = $child->seriesid;
	if (!$seriesid)
		return wassUtil::Error(13,array('seriesid','deleteseries'),'AJAXERR');
	
	$text = $child->text;
	if (!$text) 
		$text = 'Block of time has become unavailable.';
		
	/* Load up the series */
	try {
		$seriesobject = new wassSeries('load', array('seriesid'=>$seriesid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}


	/* Make sure the authenticated user owns the calendar. */
	if (!$seriesobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'series calendar'),'AJAXERR');
	
	/* Now delete the series (this will delete all blocks and appointments). */
	$seriesobject->delete($text);

	/* Now let the caller know all went well */
	 return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><seriesid>' . $seriesid . '</seriesid><canceltext>' . $text . '</canceltext>';
	
}

/*
Return all appointments by/for a specified user (optionally restricted by date and time).
*/
function dolistappointments($sme) {

	/* Point to the xml elements */
	$child = $sme->listappointments;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'getappointments'))
		return $err;
	
	/* Start the output */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
					
	/* Grab the parameters */
	if ($userid = trim( (string) $child->userid))
		$ret .= '<userid>' . $userid. '</userid>';
	if ($startdate = trim( (string) $child->startdate))
		$ret .= '<startdate>' . $startdate. '</startdate>';	
	if ($enddate = trim( (string) $child->enddate))
		$ret .= '<enddate>' . $enddate. '</enddate>';	
	if ($starttime = trim( (string) $child->starttime))
		$ret .= '<starttime>' . $starttime. '</starttime>';	
	if ($endtime = trim( (string) $child->endtime))
		$ret .= '<endtime>' . $endtime. '</endtime>';	
	
	/* Bulld the select criteria */
	$select = 'SELECT * FROM ' . wassParms::DATABASE . '.wassAppointment WHERE 1 AND ';
	
	if ($userid)
		$select .= '(userid=' . wassSQL::sqlSafe($userid) . ' OR blockid in (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid=' . wassSQL::sqlSafe($userid) . '))';
		
	if ($startdate) 
		$select .= ' AND startdate >=' . wassSQL:: sqlSafe($startdate);

	if ($enddate) 
		$select .= ' AND enddate <=' . wassSQL:: sqlSafe($enddate);

	if ($starttime)
		$select .= ' AND starttime >=' . wassSQL:: sqlSafe($starttime);

	if ($endtime)
		$select .= ' AND endtime <=' . wassSQL:: sqlSafe($endtime);
			
	$select .= ' ORDER by date, starttime';
		
	/* Now get the wasslist of appointments */
	$apps = new wassList($select,'Appointment');

	/* Save viewable matching appointments in the results. */
	foreach ($apps as $app) {
		if (is_object($app)) {		
			if ($app->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {
				/* Read in the block */
				$block = new wassBlock('load', array('blockid'=>$app->blockid));
				/* Now build the output string */
				$ret .= '<appointment>' .
				        '<appointmentid>' . $app->appointmentid . '</appointmentid>' .
						'<blockid>' . $app->blockid . '</blockid>' .
						'<calendarid>' . $app->calendarid . '</calendarid>' .
					    '<date>' . $app->date . '</date>' .
					    '<for_name>' . $app->name . '</for_name>' .
			           '<for_email>' .  $app->email . '</for_email' .
			            '<for_phone>' . $app->phone . '</for_phone>' .
			            '<for_userid>' . $app->userid . '</for_userid>' .
					    '<with_name>' . $block->name . '</with_name>' .
			            'with_email>' . $block->email . '</with_email>' .
			            '<with_phone>' . $block->phone . '</with_phone>' .
			            '<with_userid>' . $block->userid . '</with_userid>' .
			            '<location>' . $block->location . '</location>' .
			            '<starttime>' . $app->starttime . '</startime>' .
			            '<endtime>' . $app->endtime . '</endtime>' .
			            '<purpose>' . $app->purpose . '</purpose>' .
			            '<whenmade>' . $app->whenmade . '</whenmade>' .
				 		'</appointment>';
			}
		}
	}
	
	/* Return the result */
	return $ret;
		
}


/* 
Return appointment data.
*/	
function dogetappointments($sme) {				
	
	/* Point to the xml elements */
	$child = $sme->getappointments;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'getappointments'))
		return $err;
					
	/* Grab the parameters */
	$userid = trim( (string) $child->userid);
		
	/* Assume no blocks */
	$blockid = '';
			
	if ($userid) {
		$appointments = wassAppointment::listMatchingAppointments(array("userid"=>$userid));
	}
	else {
		if ($child->blockid) {
			$loadarg = array();
			foreach($child->blockid as $blockid) {
				$loadarg[] = array('blockid,=,OR',(int) $blockid);
			}
			$appointments = wassAppointment::listOrderedAppointments($loadarg,'ORDER by date, starttime');
	
		}
		else {
			return wassUtil::Error(9,array('getappointments',$ajaxml),'AJAXERR');
		}
	}

	
	/* Build output header */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
	if ($blockid)
		$ret .= '<blockid>' . $blockid . '</blockid>';
	else
		$ret .= '<userid>' . $userid . '</userid>';
		
	/* Go through all of the appointments */
	foreach ($appointments as $appointment) {
		/* Generate the XML for the appointment data */
		if (is_object($appointment)) {		
			if ($appointment->isViewable($_SESSION['authtype'], $_SESSION['authid']))
				$ret .= '<appointment>' . wassUtil::objectToXML($appointment) . '</appointment>';
			}
	}
	
	/* Return the result */
	return $ret;
	
}


/* 
Return appointment data.
*/	
function dogetapptinfo($sme) {				
	
	/* Point to the xml elements */
	$child = $sme->getapptinfo;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'getapptinfo'))
		return $err;
					
	/* Grab the parameter (appointmentid) */
	$apptid = trim( (string) $child->apptid);
		
	
	/* Build output header */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>'
			.'<apptid>' . $apptid . '</apptid>';
	
	/* Get the appointment */
	$appt = new wassAppointment('load',array('appointmentid'=>$apptid));
	
	/* Generate the XML for the appointment data */
	if (is_object($appt)) {		
		if ($appt->isViewable($_SESSION['authtype'], $_SESSION['authid']))
				$ret .= '<appt>' . $appt->xmlStream() . '</appt>';
		
	}
	
	/* Return the result */
	return $ret;
	
}



/* 
Return appointment info. as per the specified search criteria.
*/	
function dogetappts($sme) {				
	
	/* Point to the xml elements */
	$child = $sme->getappts;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'getappts'))
		return $err;
		
	
	/* Init the output header */
	$ret = wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid>';
	
	/* Save logged-in userid in a convenient place */
	$userid = $_SESSION['authid'];
	
	/* Init the SQL query string that will return the appointments. */
	$query = 'SELECT * FROM '. wassParms::DATABASE . '.wassAppointment WHERE (';
	
	/* Add in a selector that restricts appointments to those belonging to blocks with the logged-in userid or to appointments with the logged-in userid */
	$query .= '(blockid IN (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid = "' . $userid. '") OR userid = "' . $userid .'") ';
	
	$ret .= tag('userid',$child->userid);
	/* Add in additional selectors if specified */
	if ($child->startdate[0]) {
		$query .= ' AND date >= ' . wassSQL::sqlSafe($child->startdate);
		$ret .= tag('startdate',$child->startdate);
	}
	if ($child->enddate[0]) {
		$query .= ' AND date <= ' . wassSQL::sqlSafe($child->enddate);
		$ret .= tag('enddate',$child->enddate);
	}
	if ($child->starttime[0]) {
		$query .= ' AND starttime >= ' . wassSQL::sqlSafe($child->starttime);
		$ret .= tag('starttime',$child->starttime);
	}
	if ($child->endtime[0]) {
		$query .= ' AND endtime <= ' . wassSQL::sqlSafe($child->endtime);
		$ret .= tag('endtime',$child->endtime);
	}
	if ($child->calendarid[0]) {
		$query .= ' AND calendarid = ' . wassSQL::sqlSafe($child->calendarid);
		$ret .= tag('calendarid',$child->calendarid);
	}
	if ($child->apptby[0]) {
		$query .= ' AND ((userid LIKE ' . wassSQL::sqlSafe('%'.$child->apptby.'%') . ' OR name LIKE ' . wassSQL::sqlSafe('%'.$child->apptby.'%') . ')
		                  OR (blockid IN (SELECT blockid FROM ' . wassParms::DATABASE . '.wassBlock WHERE userid LIKE ' . wassSQL::sqlSafe('%'.$child->apptby.'%') . ' OR name LIKE ' .  wassSQL::sqlSafe('%'.$child->apptby.'%') . ')))';	
		$ret .= tag('apptby',$child->apptby);
	}
	/* Add in the ordering */
	$query .= ') ORDER BY date, starttime';	
	//mail('kelly.d.cole@gmail.com','getappts',$query);
	
	/* Get the appointments */
	$appts = new wassList($query,'Appointment');
	
	/* Go through and format the appts */
	foreach($appts as $appt) {
		if ($appt->isViewable($_SESSION['authtype'], $_SESSION['authid'])) {
			$ret .= '<apptwithblock>';
			$ret .= '<appt>' . $appt->xmlHeaderStream() . '</appt>';
				
			/* Get the block for the appointment */
			$block = new wassBlock('load',(array('blockid'=>$appt->blockid)));
			$ret .= '<block>' .
			tag('blockid',$block->blockid) .
						tag('seriesid',$block->seriesid) .
						tag('calendarid',$block->calendarid) .
						tag('title',$block->title) .
						tag('description',$block->description) .
						'<blockowner>' .
							tag('userid',$block->userid) .
							tag('name',$block->name) .
							tag('phone',$block->phone) .
							tag('email',$block->email) .
							tag('office',$block->office) .
							'</blockowner>' .
						tag('date',$block->date) .
						tag('location',$block->location) .	
					'</block>';
			$ret .= '</apptwithblock>';
		}
	}
	

	
	/* Return the result */
	return $ret;
	
}



/* 
Add an appointment.
*/	
function doaddappointment($sme) {				

	/* Point to the xml elements */
	$child = $sme->addappointment;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'addappointment'))
		return $err;
					
	/* Make sure we got the appointment data */	
	$appointment = $child->appointment;		
	if (!is_object($appointment))
		return wassUtil::Error(13,array('appointment','addappointment',$sme),'AJAXERR');

	/* Extract the blockid from the appointment data */
	$blockid = (int) $appointment->blockid;
	if (!$blockid)
		return wassUtil::Error(13,array('blockid','addappointment'),'AJAXERR');
	
	/* Load up the block. */
	try {
		$blockobject = new wassBlock('load', array('blockid'=>$blockid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure we got a start and end time */
	if ($blockobject->slotted) {
		$starttime = (string) $appointment->starttime;
		$endtime = (string) $appointment->endtime;
		if (!$starttime || !$endtime)
			return wassUtil::Error(32,array(),'AJAXERR');
	}

	/* Make sure the authenticated user can schedule appointments. */
	$whynot = $blockobject->isMakeable($_SESSION['authtype'], $_SESSION['authid'],$starttime,$endtime);
	if ($whynot)	
		return wassUtil::Error(14,array($whynot),'AJAXERR');	
	
	/* 
	Check the userid/email, as follows:
		if the authenticated user owns/manages the block, then accept any userid/email.
		otherwise, the specified userid or email must match the authenticated user/email.
	*/
	if (!$blockobject->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
		/* Authenticated user does not own/manager the calendar */
		/* If userid specified, must match authenticated userid */
		if ($appointment->userid) {
			if (($_SESSION['authtype'] == 'guest') || (strtoupper($appointment->userid) != strtoupper($_SESSION['authid'])))
				return wassUtil::Error(27,array($_SESSION['authid'],'appointment',$appointment->userid),'AJAXERR');
		}
		elseif ($appointment->email) {
			if (($_SESSION['authtype'] != 'guest') || ($appointment->email != $_SESSION['authid']))
				return wassUtil::Error(28,array($appointment->email,$_SESSION['authid']),'AJAXERR');
		}
		else {
			return wassUtil::Error(29,'','AJAXERR');
		}
		/* Fail if required purpose was not specified */
		if ($blockobject->purreq && !$appointment->purpose)
				return wassUtil::Error(34,'','AJAXERR');
	}
	
	/*
	Make sure the slot is available.
	*/
	if ($blockobject->booked($appointment->starttime,'','')) 
		return wassUtil::Error(14,array('Appointment slot is unavailable.'),'AJAXERR');
	
	/* Create the appointment. */
	try {
		/* Fill in any unspecified values from the block */
		$appvals = get_object_vars($appointment);
		if (!$appvals['calendarid']) $appvals['calendarid'] = $blockobject->calendarid;
		if (!$appvals['date']) $appvals['date'] = $blockobject->date;
		if (!$blockobject->slotted) {
			if (!$appvals['starttime']) $appvals['starttime'] = $blockobject->starttime;
			if (!$appvals['endtime']) $appvals['endtime'] = $blockobject->endtime;
		}
		if (!$appvals['userid']) {
			/* Use the authenticated user identifier if not specified */
			if ($_SESSION['authtype'] != 'guest')
				$appvals['userid'] = $_SESSION['authid'];
			elseif (!$appvals['email'])
				$appvals['email'] = $_SESSION['authid'];
		}
		/* Add in a UID for Ical purposes */
		$appvals['uid'] =  date('Ymd\TGis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI'];
	
		
		/* Now build the appointment. */
		$appobject = new wassAppointment('create', $appvals);
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Now save the appointment (and capture the appointment id). */
	/* Write out the updated appointment. */
	try {
		$appointmentid = $appobject->save('create');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	$appobject->appointmentid = $appointmentid;
	
	/* Now check for overbooking */
	if ($blockobject->overBooked($appvals['starttime'],'')) {
		$appobject->delete(wassAppointment::NONOTIFICATION);
		return wassUtil::Error(14,array('The appointment time has just become unavailable.'),'AJAXERR');
	}
	
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appointment>' . wassUtil::objectToXML($appobject) . '</appointment>';
	
}



/* 
Add an appointment, new format.
*/	
function doaddappt($sme) {				

	/* Point to the xml elements */
	$child = $sme->addappt;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'addappt'))
		return $err;
					
	/* Make sure we got the appointment data */	
	$appt = $child->appt;		
	if (!is_object($appt))
		return wassUtil::Error(13,array('appointment','addappt',$sme),'AJAXERR');
	$apptmaker = $appt->apptmaker;
	
	/* Extract the blockid from the appointment data */
	$blockid = (int) $appt->blockid;
	if (!$blockid)
		return wassUtil::Error(13,array('blockid','addappt'),'AJAXERR');
	
	/* Load up the block. */
	try {
		$blockobject = new wassBlock('load', array('blockid'=>$blockid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure we got a start and end time */
	if ($blockobject->slotted) {
		$starttime = (string) $appt->starttime;
		$endtime = (string) $appt->endtime;
		if (!$starttime || !$endtime)
			return wassUtil::Error(32,array(),'AJAXERR');
	}

	/* Make sure the authenticated user can schedule appointments. */
	$whynot = $blockobject->isMakeable($_SESSION['authtype'], $_SESSION['authid'],$starttime,$endtime);
	if ($whynot)	
		return wassUtil::Error(14,array($whynot),'AJAXERR');	
	
	/* 
	Check the userid/email, as follows:
		if the authenticated user owns/manages the block, then accept any userid/email.
		otherwise, the specified userid or email must match the authenticated user/email.
	*/
	if (!$blockobject->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
		/* Authenticated user does not own/manager the calendar */
		/* If userid specified, must match authenticated userid */
		if ($apptmaker->userid) {
			if (($_SESSION['authtype'] == 'guest') || (strtoupper($apptmaker->userid) != strtoupper($_SESSION['authid'])))
				return wassUtil::Error(27,array($_SESSION['authid'],'appointment',$apptmaker->userid),'AJAXERR');
		}
		elseif ($apptmaker->email) {
			if (($_SESSION['authtype'] != 'guest') || ($apptmaker->email != $_SESSION['authid']))
				return wassUtil::Error(28,array($apptmaker->email,$_SESSION['authid']),'AJAXERR');
		}
		else {
			return wassUtil::Error(29,'','AJAXERR');
		}
		/* Fail if required purpose was not specified */
		if ($blockobject->purreq && !$appt->purpose)
				return wassUtil::Error(34,'','AJAXERR');
	}
	
	/*
	Make sure the slot is available.
	*/
	if ($blockobject->booked($appt->starttime,'','')) 
		return wassUtil::Error(14,array('Appointment slot is unavailable.'),'AJAXERR');
	
	/* Create the appointment. */
	try {
		/* Get the appointment properties into an associative array */
		$appvals = array_merge(get_object_vars($appt),get_object_vars($apptmaker));
		
		/* Remove the superfluous 'office' entry' */
		unset($appvals['office']);
		if (!$appvals['calendarid']) $appvals['calendarid'] = $blockobject->calendarid;
		if (!$appvals['date']) $appvals['date'] = $blockobject->date;
		if (!$blockobject->slotted) {
			if (!$appvals['starttime']) $appvals['starttime'] = $blockobject->starttime;
			if (!$appvals['endtime']) $appvals['endtime'] = $blockobject->endtime;
		}
		if (!$appvals['userid']) {
			/* Use the authenticated user identifier if not specified */
			if ($_SESSION['authtype'] != 'guest')
				$appvals['userid'] = $_SESSION['authid'];
			elseif (!$appvals['email'])
				$appvals['email'] = $_SESSION['authid'];
		}
		/* Add in a UID for Ical purposes */
		$appvals['uid'] =  date('Ymd\TGis') . "-" . rand(1000,1000000) . '@' .  $_SERVER['REQUEST_URI'];
	
		
		/* Now build the appointment. */
		$appobject = new wassAppointment('create', $appvals);
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Now save the appointment (and capture the appointment id). */
	/* Write out the updated appointment. */
	try {
		$appointmentid = $appobject->save('create');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	$appobject->appointmentid = $appointmentid;
	
	/* Now check for overbooking */
	if ($blockobject->overBooked($appvals['starttime'],'')) {
		$appobject->delete(wassAppointment::NONOTIFICATION);
		return wassUtil::Error(14,array('The appointment time has just become unavailable.'),'AJAXERR');
	}
	
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appt>' . $appobject->xmlStream() . '</appt>';
	
}


/* 
Edit an appointment.
*/	
function doeditappt($sme) {				

	/* Point to the xml elements */
	$child = $sme->editappt;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'editappt'))
		return $err;
					
	/* Make sure we got the appointment data */	
	$appt = $child->appt;		
	if (!is_object($appt))
		return wassUtil::Error(13,array('appointment','editappt',$sme),'AJAXERR');
	$apptmaker = $appt->apptmaker;
	
	/* Load up the appointment. */
	try {
		$appobject = new wassAppointment('load', array('appointmentid'=>$appt->appointmentid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user can schedule/edit this appointment. */
	if (!$appobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'appointment'),'AJAXERR');
	
	/* Update fields that can be updated */
	if (is_object($apptmaker->name))
		$appobject->name = $apptmaker->name;
	if (is_object($apptmaker->phone))
		$appobject->phone = $apptmaker->phone;
	if (is_object($apptmaker->email))
		$appobject->email = $apptmaker->email;
	/* if ($apptmaker->office)
		$appobject->office = $apptmaker->office; */
	if (is_object($appt->purpose))
		$appobject->purpose = $appt->purpose;
	if (is_object($appt->remind))
		$appobject->remind = $appt->remind;
	if (is_object($appt->textemail))
		$appobject->textemail = $appt->textemail;
	if (is_object($appt->available))
		$appobject->available = $appt->available;				

				
	/* If changing appointment start/end times, we have to do some extra work */
	if ((is_object($appt->starttime) && $appt->starttime != $appobject->starttime) || (is_object($appt->endtime) && $appt->endtime != $appobject->starttime)) {
		/* Read in the block */
		$block = new wassBlock('load',array('blockid'=>$appobject->blockid));
		/* See if requested slot is available */
		if ($block->booked($appt->starttime, $appt->endtime,$appobject))
			return wassUtil::Error(14,array('Appointment slot is unavailable.'),'AJAXERR');
		/* Reset start and end times */
		$appobject->starttime = $appt->starttime;
		$appobject->endtime = $appt->endtime;	
	}
			
	/* Now update the appointment. */
	try {
		$appointmentid = $appobject->save('update');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
		
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appt>' . $appobject->xmlStream() . '</appt>';
	
}



/* 
Lock an appointment.
*/	
function dolockappointment($sme) {				

	/* Point to the xml elements */
	$child = $sme->lockappointment;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'lockappointment'))
		return $err;
					
	/* Make sure we got the needed data */	
	$appointmentid = $child->appointmentid;		
	if (!$appointmentid)
		return wassUtil::Error(13,array('appointmentid','lockappointment',$sme),'AJAXERR');	
	
	
	/* Load up the appointment. */
	try {
		$appobject = new wassAppointment('load', array('appointmentid'=>$appointmentid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user can schedule/edit this appointment. */
	if (!$appobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'appointment'),'AJAXERR');

	/* Update available as specified */
	if ($child->makeavailable == 0)	
		$appobject->available = 0;
	else
		$appobject->available = 1;	
	
	/* Now update the appointment. */
	try {
		$appointmentid = $appobject->save('update');
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
		
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appointmentid>' . $appointmentid . '</appointmentid><makeavailable>' . $child->makeavailable .'</makeavailable>';
	
}



/* 
Send out iCal appointment information.
*/	
function dosyncappointment($sme) {				

	/* Point to the xml elements */
	$child = $sme->syncappointment;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'syncappointment'))
		return $err;
					
	/* Make sure we got the needed data */	
	$appointmentid = $child->appointmentid;		
	if (!$appointmentid)
		return wassUtil::Error(13,array('appointmentid','syncappointment',$sme),'AJAXERR');
		
	$userid = $child->userid;		
	if (!$userid)
		return wassUtil::Error(13,array('userid','syncappointment',$sme),'AJAXERR');
	
	/* Load up the appointment. */
	try {
		$appobject = new wassAppointment('load', array('appointmentid'=>$appointmentid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}

	/* Make sure the authenticated user can schedule/edit this appointment. */
	if (!$appobject->isOwner($_SESSION['authtype'], $_SESSION['authid']))
		return wassUtil::Error(12,array($_SESSION['authid'],'appointment'),'AJAXERR');

	/* Get the owning block */
	$block = new wassBlock('load',array('blockid'=>$appobject->blockid));
	
	
	/* Now build an iCalendar stream for the appointment */
	$ret = wassIcal::addApp($appobject,$block);
	
	/* Return the icalendar stream */
	wassIcal::returnICAL($ret,"PUBLISH",'OfficeHours.ics');
	
	
		
	/* Now return the data to the caller */
	return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appointmentid>' . $appointmentid . '</appointmentid><userid>' . $userid .'</userid>';
	
}

	
/* 
Delete an appointment.
*/	
function dodeleteappointment($sme) {				

	/* Point to the xml elements. */
	$child = $sme->deleteappointment;

	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'deleteappointment'))
		return $err;
							
	/* Get the appointmentid and cancel text */
	$appointmentid = (int) $child->appointmentid;
	if (!$appointmentid )
		return wassUtil::Error(13,array('appointmentid','deleteappointment'),'AJAXERR');
	
	$text = $child->text;
		
	/* Load up the appointment */
	try {
		$appobject = new wassAppointment('load', array('appointmentid'=>$appointmentid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}
	
	/* Load up the block */
	try {
		$blockobject = new wassBlock('load',array('blockid'=>$appobject->blockid));
	} catch (Exception $error) {
	/* If an error, return error code and message */
		return wassUtil::Error($error->getCode(),array($error->getMessage()),'AJAXERR');
	}	

	/* Disallow if user does not own appointment or block or calendar */
	if (!$appobject->isOwner($_SESSION['authtype'], $_SESSION['authid'])) 
		return wassUtil::Error(12,array($_SESSION['authid'],'appointment'),'AJAXERR');	
		
	/* Also disallow if not the block owner and a cancellation deadline has been exceeded */
	if (!$blockobject->isOwner($_SESSION['authtype'], $_SESSION['authid'])) {
	  if ($blockobject->candeadline_reached($appobject->date,$appobject->starttime)) 
		  return wassUtil::Error(33,array('calendar'),'AJAXERR');
	}
	
	/* Now delete the appointment (this will send email as needed). */
	$appobject->delete($text,'');

	/* Now let the caller know all went well */
	 return wassUtil::Error(0,'','AJAXERR') . '<sessionid>' . $sessionid . '</sessionid><appointmentid>' . $appointmentid . '</appointmentid><canceltext>' . $text . '</canceltext>' ;
	
}


/* 
Return a didyouknow entry.
*/	
function dogetdidyouknow($sme) {	

	/* Extract the parameters */
	$child = $sme->getdidyouknow;
	
	
	/* Grab the sessionid */
	$sessionid = trim( (string) $child->sessionid);
	
	/* Test authentication */
	if ($err = testauth($sessionid,'dogetdidyouknow'))
		return $err;
							
	/* Get parameters */
	$didyouknowid = trim($child->didyouknowid);
	$dateadded= trim($child->dateadded);		
	$release= trim($child->release);		
	$topics = trim($child->topics);		
	
	/* Topics can be a blank-separated list */
	$alltopics = explode(' ',$topics);
	if ($alltopics) $alltopics = implode(',',$alltopics);

	
	/* Start output */
	$ret = wassUtil::Error(0,'','AJAXERR');
	
	/* Get a wassList of all matching entries */
	$entries = wassDidYouKnow::getEntries($dateadded,$release,$alltopics);
	$entry_count = $entries->entries();
	
	/* Get list of entries already shown */
	$allready_seen = wassPrefs::getPref($_SESSION['authid'],'dykentries');
	if ($allready_seen)
		$allready_seen = explode(',',$allready_seen);
	else
		$allready_seen = array();
	$seen_count = count($allready_seen);

	/* If all entries have been shown, cycle back to the first one */
	if ($seen_count == $entry_count) {
		$allready_seen = array();
		$seen_count = 0;
		$_SESSION['didyouknowids'] = '';
	}
	
	/* Find "next" one to show */
	$first = true;
	$match = '';
	foreach ($entries as $entry) {
		if ($first) {
			$match = clone $entry;
			$first = false;
		}
		if (!in_array($entry->didyouknowid,$allready_seen)) {
			$match = clone $entry;
			break;	
		}
	}
	
	/* Add matching entry, if any (and remember it) */
	if ($match) {
		$ret .=  '<didyouknow>' . wassUtil::objectToXML($match) . '</didyouknow>';
		
		if ($seen_count == 0)
			$allready_seen = array($match->didyouknowid);
		else
	    	$allready_seen[] = $match->didyouknowid;
		$seen_count++;
		
		if ($seen_count > 1)
			wassPrefs::savePref($_SESSION['authid'],'dykentries',implode(',',$allready_seen));
		else
			wassPrefs::savePref($_SESSION['authid'],'dykentries',$allready_seen[0]);		

	}
		
	/* Add in total count */
	$ret .= '<total>' . (int) $entry_count . '</total>';
	/* Add in remaining count */
	$ret .= '<remaining>' . max(0,($entry_count - $seen_count)) . '</remaining>';
			
	return $ret;

}


/*
Validate an email address.
*/
function doisemailvalid($sme) {
	

	/* Extract the parameters */
	$child = $sme->isemailvalid;
	
							
	/* Get parameter */
	$email = trim($child->email);

	/* See if valid */
	if (wassUtil::validateEmail($email) == '')
		$valid = 1;
	else
		$valid = 0;
		
	/* Return results */
	return wassUtil::Error(0,'','AJAXERR') . '<email>' . $email . '</email><isvalid>' . $valid . '</isvalid>' ;

}
	

/*
This function tests authentication credentials passed in the ajax stream against the session variables set by login.
*/
function testauth($sessionid, $caller) {

	
	/* If no sessionid passed, return an error */
	if (!$sessionid) 
		return wassUtil::Error(11,array('sessionid',$caller),'AJAXERR');
	
	/* Start the session (this will set the session variables). */
	session_id($sessionid);
	session_start();
	
	/* Test authentication */
	if (!$_SESSION['authenticated'])
		return wassUtil::Error(21,'','AJAXERR');
		
}


/* This function returns an xml tag with the specified name and value */
function tag($name,$value) {
	return '<'.$name.'>'.wassUtil::safeXml($value).'</'.$name.'>';		
}

?>