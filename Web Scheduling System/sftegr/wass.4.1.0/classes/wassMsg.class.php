<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu		   
*/


/*

This class contains (error) messages, as well as routines to build and save the error (and informatory) messages.
 
*/



class wassMsg {

	/* Set up all of the messages in a static array */
	public static $msg = array(
		0=>'',
		1=>'The system is down.  Please contact ',
		2=>'This system must be invoked using HTTPS.  Please contact: %1',
		3=>'Unable to parse specified XML for simplexml: %1 original: %2',
		4=>'Specified XML does not validate: %1',
		5=>'Specified XML has no request action: %1',
		6=>'Invalid password',
		7=>'Email required if no userid in call to login',
		8=>'Specified parameter %1 does not exist',
		9=>'Insufficient elements for %1 in: %2',
		10=>'Invalid %1 for %2 : %3',
		11=>'%1 required for %2',
		12=>'User %1 does not own %2',
		13=>'Missing %1 data for %2 : %3',
		14=>'%1',
		15=>'Errors validating appointment data: %1',
		16=>'Error in SQL: %1',
		17=>'Errors validating block data: %1',
		18=>'Errors validating calendar data: %1',
		19=>'Errors validating period data: %1',
		20=>'Errors validating series data: %1',
		21=>'Session not authenticated',
		22=>'%1 may not view the specified %2',
		23=>'Guests may not create calendars',
		24=>'User %1 is not authorized to create/edit a calendar for user %2',
		25=>'The following blocks were not updated: %1',
		26=>'Specified %1 does not belong to %2',
		27=>'User %1 not authorized to create %2 for user %3',
		28=>'Specified email %1 does not match authenticated email %2',
		29=>'Userid or email address must be specified when creating an appointment.',
		30=>'Calendar already exists for user %1',
		31=>'%1 argument missing for iCalendar call',
		32=>'Start and end times must be specified to create an appointment',
		33=>'Appointment cancellation deadline has been reached; you must contact the %1 owner to cancel this appointment.',
		34=>'You must specify a purpose for this appointment.'
		
	);
	
	/*
	This function returns a parsed message (with substitutions).
	*/
	static function getMsg($msgnum,$subs) {

		/* First, grab the message text */
		$msgtext = self::$msg[$msgnum];
			
		/* If nothing to substitute, just return the message */
		if (!$subs)
			return $msgtext;	

		/* Now do the substitution */
		if (is_array($subs)) {
			for ($i = 0;  $i < count($subs); $i++) {
				$subtext = '%' . ($i+1);
				$sub = $subs[$i];
				$msgtext = str_replace($subtext,$sub,$msgtext);
			}
		}
		else {
			$msgtext = str_replace('%1',$subs,$msgtext);
		}
		
		return $msgtext;
	
	}
	
	/*
	This function logs an error message.
	*/
	static function logMsg($msg) {
		if (!$msg)
			return;
		$fmsg = date('Y-m-d G:i:s') . ': ' .  $msg . "\r\n"  . print_r(debug_backtrace(),true) . "\r\n" . "\r\n";
		/* 
		if (!error_log($fmsg,3,'php_error.log')) {
			error_log('The following error message could not be logged through the error-log function: ' . $fmsg,1,wassParms::SYSMAIL,"From: " . wassParms::FROMMAIL . "\r\n");
		} 
		*/
	}


}

?>