<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class contains a number of static utility functions.
 
*/

class wassUtil {
	
	/*
	This static variable holds a table that translates htmlentities into ordinal entities.
	*/
	static $entitytrans = '';
	
	
	/*
	This function returns a parameter from the wassParms file if it exists, else it returns NULL.
	*/
 	function getParm($parm) {
		if (defined('wassParms::'.$parm))
			return eval('return wassParms::'.$parm.';');
		else
			return NULL;
	}

		
	/* 
	This method determines if the WASS system is up and running and, if not,
	terminates with an error message.  It also installs an error handler to trap errors and log them. 
	*/
	static function OnOff() {
		/* If we are down */
		if (!wassParms::RUNNING) {
			if (wassParms::DOWNMSG)
				/* Issue specified error message if set */
				die(wassParms::DOWNMSG);
			else 
				/* Else issue default error message */
				die('The system is down.  Please contact ' . wassParms::CONTACTNAME);
		}
		
	}
	
	/* 
	This method determines if the WASS system was invoked through https (secure http). 
	*/
	static function CheckSSL() {
	
		if (wassParms::REQSSL) {
			if (!$_SERVER['HTTPS']) {
				die('This system must be invoked using HTTPS, not HTTP');
			}
		}
	}


	/*
	This function makes sure user is authenticated.
	*/
	static function Authenticated() {
		/* For now, return true */
		return true;	
	}
	
	
	/*
	This function makes sure session support is working.
	*/
	static function checkSession($test) {
		/* Skip test if not required */
		if ($test == 'skip')
			return;
		/* See if login session variable is set */
		if (!isset($_SESSION['authenticated']))
			self::Error(1,'You must enable cookies in your web browser to use this system.', 'HTTP');
	}

	
	
	/*
	This function handles errors.  It is copied from the PHP manual secton on error handling.
	*/
	function myErrorHandler($errno, $errmsg, $filename, $linenum, $vars)
	{
	
	   // define an assoc array of error string
	   // in reality the only entries we should
	   // consider are E_WARNING, E_NOTICE, E_USER_ERROR,
	   // E_USER_WARNING and E_USER_NOTICE
	   $errortype = array (
				   E_ERROR              => 'Error',
				   E_WARNING            => 'Warning',
				   E_PARSE              => 'Parsing Error',
				   E_NOTICE            => 'Notice',
				   E_CORE_ERROR        => 'Core Error',
				   E_CORE_WARNING      => 'Core Warning',
				   E_COMPILE_ERROR      => 'Compile Error',
				   E_COMPILE_WARNING    => 'Compile Warning',
				   E_USER_ERROR        => 'User Error',
				   E_USER_WARNING      => 'User Warning',
				   E_USER_NOTICE        => 'User Notice',
				   E_STRICT            => 'Runtime Notice',
				   E_RECOVERABLE_ERROR  => 'Catchable Fatal Error'
				   );
	   /* Set of errors for which we log and die. */
	   $die_errors = array(E_ERROR,E_PARSE,E_COMPILE_ERROR,E_PARSE);

	  
	   $err = "<errorentry>\n";
	   $err .= "\t<errornum>" . $errno . "</errornum>\n";
	   $err .= "\t<errortype>" . $errortype[$errno] . "</errortype>\n";
	   $err .= "\t<errormsg>" . $errmsg . "</errormsg>\n";
	   $err .= "\t<scriptname>" . $filename . "</scriptname>\n";
	   $err .= "\t<scriptlinenum>" . $linenum . "</scriptlinenum>\n";
	   $err .= "</errorentry>\n\n";
	  
		if (in_array($errno, $die_errors)) {
	   		/* Log error */
	  		wassMsg::logMsg($err);
			/* Send email */
		   	mail(wassParms::SYSMAIL, "Critical User Error", $err);
			/* Die */
			die('An error has occured running WASS.  A notification has been sent to the support staff.');
	   }
	   
	   /* Continue running */
	   return true;
	}
	
	
	/*
	This function makes sure a date is valid.
	*/
	static function isDateValid($date) {
		if (strpos($date,'/') !== false)
			list($m,$d,$y) = explode('/',$date);
		elseif (strpos($date,'-') !== false)
			list($y,$m,$d) = explode('-',$date);
		else
			return false;
			
		if (!checkdate((int) $m,(int) $d,(int) $y))
			return false;
		else
			return true;			
	}

	/*
	This function compares dates.
	*/
	static function compareDates ($date1, $date2) {
		list($y1,$m1,$d1) = explode('[/.-]',$date1);
		list($y2,$m2,$d2) = explode('[/.-]',$date2);
		
		if ($y2 > $y1) 
			return '>';
		elseif ($y2 < $y1)
			return '<';
		else {
			if ($m2 > $m1)
				return '>';
			elseif ($m2 < $m1)
				return '<';
			else {
				if ($d2 > $d1)
					return '>';
				elseif ($d2 < $d1)
					return '<';
				else
					return '=';
			}
		}
	}
	
	
	/*
	This function converts a date to us format.
	*/
	static function usDate($date) {
		if (strpos($date,'/') !== false)
			return $date;
		else {
			list($y,$m,$d) = explode('-',$date);
			return sprintf("%u/%u/%u",$m,$d,$y);
		}
	}

	/*
	This function converts a date to long format.
	*/
	static function longDate($date) {
		if (strpos($date,'/') !== false)
			list($m,$d,$y) = explode('/',$date);
		elseif (strpos($date,'-') !== false)
			list($y,$m,$d) = explode('-',$date);
		else
			return "";
			
		
		$months = array('','January','February','March','April','May','June','July','August','September','October','November','December');
		
		return $months[ (integer) $m] . ' ' . sprintf('%2u',$d) . ', ' . $y;
		
	}



	/* 
	This function converts minutes into hh:mm format (24 hour).
	*/
	static function minToTime($minutes) {
		$mins = $minutes%60;
		$hours = ($minutes - $mins)/60;
		return sprintf('%02d:%02d',$hours,$mins);
	}
	
	/*
	This function comverts hh:mm format into total minutes.
	*/
	static function timeToMin($time) {
		list($h,$m,$s) = explode(':',$time);
		return (($h*60) + $m);
	}
	

	/*
	This method returns an XML stream to a web browser.
	*/
	static function returnXML($xml) {
		header('Content-type: text/xml');
		echo $xml;
	}


	/*
	This function encodes the input string as numeric entity references, as that’s a safe way to use high 
	characters and special characters in an xml document.
	*/
	static function xmlCharEncode($string) {
		if (!self::$entitytrans) {
	 		self::$entitytrans = get_html_translation_table(HTML_ENTITIES, ENT_QUOTES);
			foreach (self::$entitytrans as $k=>$v)
				self::$entitytrans[$k]= "&#".ord($k).";";
		}
		return strtr($string, self::$entitytrans);
	}
		
		
	/*
	This function takes text that will be imbedded in an XML stream and esacpes any characters that might
	causes problems.
	*/
	static function safeXml($text) {
		/* KDC, 11-11-2009. Testing no entity conversion. */
		/*return htmlentities(iconv('ISO-8859-1', 'ISO-8859-1//IGNORE', $text),ENT_QUOTES,'ISO-8859-1');*/
		return self::xmlCharEncode($text);
	}	

		
	/*
	This function takes text that will be imbedded in an HTML stream and esacpes any characters that might
	cause problems.
	*/
	static function safeHTML($text) {
		$okescaped = array('&lt;b&gt;','&lt;/b&gt;','&lt;i&gt;','&lt;/i&gt;','&lt;em&gt;','&lt;/em&gt;','&lt;strong&gt;','&lt;/strong&gt;','&lt;p&gt;','&lt;/p&gt;','&lt;br&gt;','&lt;br/&gt;','&lt;br /&gt;');
		$okhtml = array('<b>','</b>','<i>','</i>','<em>','</em>','<strong>','</strong>','<p>','</p>','<br>','<br/>','<br />');
		return str_replace($okescaped, $okhtml,htmlentities($text,ENT_QUOTES,'ISO-8859-1'));
	}	


	/*
	This method takes an error message and routes it to the specified desitinations, including returning it to the web server as a stream (echo).
	
	The supported destinations are detailed in the code.
	*/
	
	
	static function Error($code,$subarray,$destinations) {

		/* Extract the destinations into an array */
		$dests = explode(',',trim(strtoupper($destinations)));
		/* Get the message text (with substitutions performed) */
		$msg = wassMsg::getMsg($code,$subarray);
		/* Log the message (regardless of destination) */
		wassMsg::logMsg($msg);
		/* Now hande each destination */
		foreach($dests as $dest) {
			switch($dest) {
				case 'HTMLFORMAT':
					$msg = '<html><head></head><body>' . $msg . '</body></html>';
				case 'HTTP': 
				case 'HTML':
					echo $msg;
					break;
				case 'LOG': /* Done in all cases */
					break;
				case 'SYSEMAIL':
					$subject = 'Error report from ' . wassParms::SYSID;
					$message = "Error reported on " . date('m/d/Y H:i') . ':' . 
							   "\r\n" . $msg;
					mail(wassParms::SYSMAIL,$subject,$message);
					break;
				case 'AJAXRET':
					return wassParms::XMLHEADER . '<wass><error><errorcode>' . $code . '</errorcode><errortext>' . $msg . '</errortext></error></wass>' . wassParms::XMLTRAILER;
					break;
				case 'AJAXHEAD':
					return wassParms::XMLHEADER . '<wass><error><errorcode>' . $code . '</errorcode><errortext>' . $msg . '</errortext></error>';
					break;				
				case 'AJAXERR':
					return '<error><errorcode>' . $code . '</errorcode><errortext>' . $msg . '</errortext></error>';
					break;
				case 'AJAX':
					$ret = wassParms::XMLHEADER . '<wass><error><errorcode>' . $code . '</errorcode><errortext>' . $msg . '</errortext></error></wass>' . wassParms::XMLTRAILER;
					self::returnXML($ret);
					break;
				case 'ICAL':
					wassIcal::returnICAL(wassParms::ICALHEADER . "REQUEST-STATUS:3." . $code . ";" . $msg .  "\r\n" . wassParms::ICALTRAILER,"PUBLISH",'');
					break;
				case 'FORMAT':
					return $msg;
					break;
				case 'DIE':
					die();			
			}
		}
	}
	
	
	/* 
	Write a message to the log 
	*/
	
	static function Log($type, $msg) {
	/*
	To be implemented.
	*/
	}
	
	
	/*
	This method loads an object with values from an associative array.
	*/
	static function loadObject($ob,$arr) {
		/* 
		For each element in the associative array, load the corresponding property in the object. 
		*/
		$obvars = array_keys(get_object_vars($ob));
		foreach ($arr as $key => $value) {
			if (in_array($key,$obvars))
 				$ob->$key = $value;
			}				
	}
	
	
	
	/*
	This method generates an xml stream from an object.
	*/
	static function objectToXML($ob) {
		
		/* Extract all properties into an associative array. */
		$arr = get_object_vars($ob);
		/* Rumble through the array and generate the xml. */
		$xml = '';
		foreach ($arr as $key => $value) {
			$xml .= '<' . self::safeXml($key) . '>';
			if (is_object($value))
				$xml .= self::objectToXML($value);
			else
				$xml .= self::safeXml($value);
			$xml .= '</' . self::safeXml($key) . '>';
		}
		/* Return the xml string. */
		return $xml;					
	}
	
	/*
	This method converts an asociative array into an xml string.
	If a second argument is specified, only that key is converted.
	*/
	static function arrayToXML($arr,$only) {
		$xml = '';
		foreach ($arr as $key => $value) {
			if ((!$only) || ($key == $only))
				$xml .= '<' . self::safeXml($key) . '>' . self::safeXml($value) . '</' . self::safeXml($key) . '>';
		}
		return $xml;	
	}

	
	/*
	This method removes the specified elements from an xml string.
	*/
	static function stripFromXML($arr,$xml) {
		$outxml = '';
		foreach ($arr as $key) {
			list($beforexml,$rest) = explode('<' . $key . '>',$xml);
			list ($before,$afterxml) = explode('</' . $key . '>',$rest);
			$outxml .= $beforexml . $afterxml;
		}
		return $outxml;	
	}


	/*
	This function strips slashes if necessary.
	*/
	static function slashstrip($arg) {
		/* Convert Microsoft Word chars to ASCII chars */

        $arg = preg_replace(array('/[\x60\x82\x91\x92\xb4\xb8]/i','/[\x84\x93\x94]/i','/[\x85]/i','/[\x00-\x0d\x0b\x0c\x0e-\x1f\x7f-\x9f]/i'),
							array('\'','"','...',''),
							$arg);  
		
		
		/* Now strip the slashes */
	  	if (get_magic_quotes_gpc())
       		return stripslashes($arg);
		else
			return $arg;
	}	
			

	/* 
	Determine if a user is in a course.
	*/
	static function IsUserInCourse($courseid, $userid) {
	
		/* Call user exit.  It will return one of three values:
			USERNOTINCOURSE, USERINCOURSE, NULL
			
			If USERNOTINCOURSE, it will return false.
			If USERINCOURSE, it will return true.
			Else it will drop down to the standard code.
			
		*/
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','IsUserInCourse')) {
				switch (wassLocal::IsUserInCourse($courseid, $userid)) {
					case wassLocal::USERNOTINCOURSE :
						return false;
						break;
					case wassLocal::USERINCOURSE :
						return true;
						break;
					
				}
			}	
		}
	
	
		/* Build SOAP client. */
		$client = new SoapClient(wassParms::BBWSDL);

		/* Make sure data is in array format */
		if (is_array($courseid))
			$courses = $courseid;
		else
			$courses = array($courseid);
		
		/* Check the courses */		
		foreach ($courses as $course) {
			/* Call the web service*/
			$result = $client -> getUserRole($userid, $course, wassParms::BBKEY);
	
			/* Returned value may be a string or an array */
			if (is_array($result))
				$testvalue = trim($result[0]);
			else
				$testvalue = trim($result);
	
			/* If any kind of error, including user not in course, or invalid
	   			course, continue looking.  */
			if (substr($testvalue,0,10) == 'ErrorCodes')
				;	
			/* For now, we accept ANY role in the course */	
			else
				return true;
		}
		
		/* Return the bad news */
		return false;		
	}


	/* 
	Determine if a course exists 
	*/
	static function IsCourseValid($courseid) {
	
		/* Call user exit.  It will return one three values:
			COURSEISVALID, COURSEISNOTVALID, NULL
			
			If COURSEISVALID, it will return true.
			If COURSEISNOTVALID, it will return false.
			Else it will drop down to the standard code.
			
		*/
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','IsCourseValid')) {
				switch (wassLocal::IsCourseValid($courseid)) {
					case wassLocal::COURSEISVALID :
						return true;
						break;
					case wassLocal::COURSEISNOTVALID :
						return false;
						break;
					
				}
			}
		}
		
		/* Build SOAP client. */
		$client = new SoapClient(wassParms::BBWSDL);
	
		/* Call the web service */
		$result = $client -> getUserRole('xxxxxxxx', $courseid, wassParms::BBKEY);
	
		/* Returned value may be a string or an array */
		if (is_array($result))
			$testvalue = trim($result[0]);
		else
			$testvalue = trim($result);
	
		/* If error says course invalid, return false */
		if ($testvalue == 'ErrorCodes.INVALID_COURSE')
			return false;
		else
			return true;
			
	}

	/* Determine if pased date is before today */
	static function beforeToday($date) {
	
		$thisday = getdate();
		$toyear = $thisday['year'];
		$tomonth = $thisday['mon'];
		$today = $thisday['mday'];
		
		if (strpos($date,'/') !== false)
			list($pmonth,$pday,$pyear) = explode('/',$date);
		elseif (strpos($date,'-') !== false)
			list($pyear,$pmonth,$pday) = explode('-',$date);
		else
			return false;
			
		if ($pyear > $toyear)
			return false;
		elseif ($pyear < $toyear)
			return true;
		elseif ($pmonth > $tomonth)
			return false;
		elseif ($pmonth < $tomonth)
			return true;
		elseif ($pday < $today)
			return true;
		else
			return false;
			
	}


	/* 
	Determine if pased date is today 
	*/
	static function isToday($date) {
	
		$thisday = getdate();
		$toyear = $thisday['year'];
		$tomonth = $thisday['mon'];
		$today = $thisday['mday'];
		
		if (strpos($date,'/') !== false)
			list($pmonth,$pday,$pyear) = explode('/',$date);
		elseif (strpos($date,'-') !== false)
			list($pyear,$pmonth,$pday) = explode('-',$date);
		else
			return false;
			
		if (($pyear == $toyear) && ($pmonth == $tomonth) && ($pday == $today))
			return true;
		else
			return false;
			
	}


	/*
	Determine if passed date and time are before current data and time.
	*/
	static function beforeNow($date, $time) {
	
		/* If date if before today, return true */
		if (self::beforeToday($date))
			return true;
			
		/* If after today, return false */
		if (!self::isToday($date))
			return false;
			
		/* So we know the date is for today.  Check the time */
		list($ph, $pm, $ps) = explode(':',$time);
		$ch = date('G');
		$cm = date('i');
		
		if ($ch > $ph) 
			return false;
		elseif ($ch < $ph)
			return true;
		elseif ($cm > $pm)
			return false;
		else
			return true;
		
	}
	


	/*
	This function attempts to determine if an email address is valid.
	*/
	static function validateEmail($Email) {
		
		/* Return valid if testing is disabled */
		if (!wassParms::TESTEMAIL)
			return '';
		
		
		/* Courtesy John Coggeshall, http://www.coggeshall.org/. */
		
		
		/* First, validate the format of the email */
		if (!eregi("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$", 
			$Email))
			return 'Email address ' . $Email . ' does not appear to be properly formatted.';
			
		/* Now get the name of the target email server (use MX lookup) */
		list ( $Username, $Domain ) = split ("@",$Email);
  		if (getmxrr($Domain, $MXHost))  {
			$ConnectAddress = $MXHost;
    	} else {
        	$ConnectAddress = array($Domain);
    	}
		
		$me = $_SERVER['SERVER_ADDR'];
		
		/* Now connect to the server and check the address */
		foreach ($ConnectAddress as $server) {
			$Connect = fsockopen ($server,25,$errno,$errtext,3); 
			if ($Connect) break;
		}
				
    	if ($Connect) {
			if (ereg("^220", $Out = fread($Connect, 1024))) {
				fputs($Connect, "HELO $me\r\n", strlen($me)+7);
				
				$fout = fread($Connect, 1024);
				
				$Out = substr(trim($fout),0,3);
				if ($Out < 200 || $Out > 399) {
					fputs ($Connect, "QUIT\r\n");
					
					fclose($Connect);
					
					return 'Email server ' . $ConnectAddress . ' replies: ' . $fout;	
				}				
				fputs ($Connect, "MAIL FROM:<" . wassParms::SYSMAIL . ">\r\n");
				
				$Ffrom = fread($Connect, 1024);
				
				$From = substr(trim($Ffrom),0,3);
				if ($From < 250  || $From > 252) {
					fputs ($Connect, "QUIT\r\n");
					
					fclose($Connect);
					
					return 'Email server ' . $ConnectAddress . ' will not accept email: ' . $Ffrom;	
				}				
				fputs ($Connect, "RCPT TO:<" . $Email . ">\r\n");
				
				$Fto = fread($Connect,1024);
				
				$To = substr(trim($Fto),0,3);
				if ($To < 250  || $To > 252) {
					fputs ($Connect, "QUIT\r\n");
					
					fclose($Connect);
					
					return 'Email server ' . $ConnectAddress . ' rejected specified email address: ' . $Fto;	
				}				
				fputs ($Connect, "QUIT\r\n");
				
				fclose($Connect);
				
			} 
			else
				return "No response from server";
    	}
        else
			return "Can not connect to E-Mail server " . $ConnectAddress;
 	
		/* Success */
		return '';
	}	
		


	/* 
	This function checks a 5-character time entry (hh:mm).  It also converts a "am/pm"
	type time to 24-hour notation, and rechecks ambigous times (e.g., 6:30), and converts
	times like 2:30 to 14:30.
	  
	It returns a null string if the time is not valid or ambiguous.
	*/
	static function checkTime($time) {
			
			$ampm = "";
			$t = strtoupper($time);
			if (strpos($t, "PM") !== false) {
				$ampm = "pm";
				$t = trim(str_replace("PM","",$t));
			}
			elseif (strpos($t, "AM") !== false) {
				$ampm = "am";
				$t = trim(str_replace("AM","",$t));
			}
			elseif (strpos($t, "MIDNIGHT") !== false) {
				$ampm = "am";
				$t = trim(str_replace("MIDNIGHT","",$t));
			}
			elseif (strpos($t,"NOON") !== false) {
				$ampm = "pm";
				$t = trim(str_replace("NOON","",$t));
			}
			else
				$t = trim($t);
			
			if (($t== "") || (strlen($t) > 8)) 
				return "";
			
			if (strpos($t, ':') === false) {
				if (strlen($t) > 2) 
					return "";
				$t = $t . ":00";
			}
	
			list($hh, $mm, $ss) = explode(":",$t);
			if (!$ss) $ss = "00";
			
			if ($hh == "")
				return "";
				
			if ($mm == "")
				$mm = "00";
				
			/* Convert times like 5:30 to pm, and reject times like 6:30. */	
			if (strlen($hh) == 1)
				if ($ampm == "")
					if ($hh < 7)
						$hh += 12;
					elseif ($hh < 9)
						return "";
	
			$hh = intval($hh);
			$mm = intval($mm);
		
			if ($ampm == "pm")
				if ($hh < 12)
					$hh += 12;
			
			if ($ampm == "am")
				if ($hh == 12)
					$hh = "00";
	
			if (($hh > 23) || ($hh < 0))
				return "";
				
			if (($mm > 60) || ($mm < 0))
				return "";
				
			if (strlen($hh) == 1) $hh = "0" . $hh;
			if (strlen($mm) == 1) $mm = "0" . $mm;
			
			return $hh . ":" . $mm . ":" . $ss;		 
	}

	/* 
	This function computes elpased time (duration) in minutes between a (valid) start time
	and a (valid) end time on the same day, using 24-hout time notation.  
	
	It returns zero if the duration is zero or negative 
	*/
	static function elapsedTime($starttime, $endtime) {
	
		list($sh,$sm,$ss) = explode(":",$starttime);
		list($eh,$em,$es) = explode(":",$endtime);
		$elapsed = (($eh*60) + $em) - (($sh*60) + $sm);
		return $elapsed;
	
	}	

	/* 
	This function checks to see if a passed value could be a boolean value. 
	*/
	static function checkBool($value) {
		if ($value == "1" || (is_int($value) && ($value == 1)) || $value == 'true' || (is_bool($value) && ($value == true)) || $value == "0" || (is_int($value) && ($value == 0)) || $value == 'false' || (is_bool($value) && ($value == false)))
			return true;
		else
			return false;
	}	


	/* 
	This function does a case-insensitive search for an element in an array. 
	*/
	static function in_array_ci($item,$array) {  
     	foreach($array as $arrayvalue) {    
        	 if (strtoupper($item) == strtoupper($arrayvalue)) { 
              	 return true;
         	}
    	 }
	return false;
	}
			
	/* 
	This function converts 24-hour time to am/pm time for display. 
	*/
	static function AmPM($time) {
	
		if ((self::posistr($time, "pm") !== false) || (self::posistr($time, 'am') !== false) || (self::posistr($time, 'noon') !== false) || (self::posistr($time, 'midnight') !== false))
			return trim($time);
		
		if (trim($time) == "")
			return trim($time);
		
		list($hh,$mm,$jj) = explode(":",$time);
		if ($hh >=12) {
			if ($hh > 12) {
				$hh = $hh - 12;
				$ampm = " pm";
			}
			else {
				if ($mm == 0)
					$ampm = " noon";
				else
					$ampm = " pm";
			}
		}
		else {
			$ampm = " am";
		}
			
		return trim($hh . ":" . $mm . $ampm);
			
	}


	/* 
	This function does a case-insensitive string search.
	 */
	static function posistr($haystack, $needle, $offset=0) {
	  return strpos(strtoupper($haystack), strtoupper($needle), $offset);
	}


	/* 
	This function issues a GET or POST to a web host 
	 * ~~~~~~~~~~
	 * Params:
	 *   $host      - host name, possibly preceded with ssl:// 
	 *   $port      - 80 or 443 (ssl)
	 *   $method    - get or post, case-insensitive
	 *   $path      - The /path/to/file.html part
	 *   $data      - The query string, without initial question mark (or post data)
	 *   $useragent - If true, 'MSIE' will be sent as 
					  the User-Agent (optional)
	 *
	 * Examples:
	 *   sendToHost('www.google.com',80,'get','/search','q=php_imlib');
	 *   sendToHost('www.example.com','post','/some_script.cgi',
	 *              'param=First+Param&second=Second+param');
	 *   For POST, the data consists of urlencoded field=value strings, seperated by & signs:
	 *             name=Serge+Goldstein&id=serge&password=secret
	 *
	 */
	
	static function sendToHost($host,$port,$method,$path,$data,$useragent=0)
	{
		// Supply a default method of GET if the one passed was empty
		if (empty($method)) {
			$method = 'GET';
		}
		list($prefix,$justhost) = explode('://',$host);
		if ($justhost == '') 
			$justhost = $host;
		$method = strtoupper($method);
		$fp = fsockopen($host, $port);
		if (!$fp) {
			echo "$errstr ($errno)<br />\n";
			exit();
		}
		if ($method == 'GET') {
			$path .= '?' . $data;
		}
		fputs($fp, "$method $path HTTP/1.1\r\n");
		fputs($fp, "Host: $justhost\r\n");
		fputs($fp,"Content-type: text/xml\r\n");
		fputs($fp, "Content-length: " . strlen($data) . "\r\n");
		if ($useragent) {
			fputs($fp, "User-Agent: MSIE\r\n");
		}
		fputs($fp, "Connection: close\r\n\r\n");
		if ($method == 'POST') {
			fputs($fp, $data);
		}
	
		$buf = '';
		while (!feof($fp)) {
			$buf .= fgets($fp,128);
		}
		fclose($fp);
		return $buf;
	}


	/*
	This function generates a random string of the specified length.
	
	$l (lowercase L) = the length of the key you want generated
	$u (optional) is a Boolean which forbids two of the same characters to be next to each other.  
		Defaults to allowing random repeating characters.
	*/
	
	function rand_chars($l, $u = FALSE) {
 		$c = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
 		if (!$u) 
			for ($s = '', $i = 0, $z = strlen($c)-1; $i < $l; $x = rand(0,$z), $s .= $c{$x}, $i++);
 		else 
			for ($i = 0, $z = strlen($c)-1, $s = $c{rand(0,$z)}, $i = 1; $i != $l; $x = rand(0,$z), $s .= $c{$x}, $s = ($s{$i} == $s{$i-1} ? substr($s,0,-1) : $s), $i=strlen($s));
 		return $s;
	}

	
	/*
	echo the input array as csv data maintaining consistency with most CSV implementations
	* uses double-quotes as enclosure when necessary
	* uses double double-quotes to escape double-quotes 
	* uses CRLF as a line separator
	*/
	
	function echocsv($fields) {
		$separator = '';
		foreach ( $fields as $field ) {
			if ( preg_match( '/\\r|\\n|,|"/', $field ) ) {
				$field = '"' . str_replace( '"', '""', $field ) . '"';
			}
			echo $separator . $field;
			$separator = ',';
		}
		echo "\r\n";
	}
	
	
	/*
	writes a csv file given an array of results (Array of associative arrays). 
	NOTE: this is for appointments
	*/
	function writecsvfile($arrayofresults) {
		// send response headers to the browser
		// following headers instruct the browser to treat the data as a csv file called export.csv
		//header( 'Location: blank');
		header("Pragma: public");
  		header("Expires: 0");
  		header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
  		header("Cache-Control: private",false);
		header( 'Content-Type: text/csv' );
		header( 'Content-Disposition: attachment; filename="appointments.csv"' );
		header("Content-Transfer-Encoding: binary");
				
		// output header row (if atleast one row exists)
		if ( $arrayofresults[0] ) {
			self::echocsv( array_keys( $arrayofresults[0] ) );
		}
		
		// output data rows (if atleast one row exists)
		foreach ( $arrayofresults as $row ) {
			self::echocsv( $row );
		}	
	}
/*	
	function writecsvfile($criteria, $orderby) {
		// send response headers to the browser
		// following headers instruct the browser to treat the data as a csv file called export.csv
		header( 'Content-Type: text/csv' );
		header( 'Content-Disposition: attachment;filename=appointments.csv' );
		
		// get the data
		$fields = 'calendarid, date, starttime, endtime, name, email, phone, purpose, whenmade';
		$result = wassSQL::doQuery(wassSQL::buildOrderedSelect('wassAppointment',$criteria,$orderby,$fields));
		
		// output header row (if atleast one row exists)
		$row = mysql_fetch_assoc( $result );
		if ( $row ) {
			self::echocsv( array_keys( $row ) );
		}
		
		// output data rows (if atleast one row exists)
		while ( $row ) {
			self::echocsv( $row );
			$row = mysql_fetch_assoc( $result );
		}	
	}
*/


}	
?>