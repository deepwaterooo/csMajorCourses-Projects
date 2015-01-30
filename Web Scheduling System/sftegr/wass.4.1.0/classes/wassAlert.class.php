<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class describes a WASSalert and provides a set of methods to create, delete and send alerts.
 
*/

class wassAlert {
	
	/* Properties */
	public $alertid;	/* Sequential identifier */
	public $calendarid; /* Calendar to which alert applies */
	public $datestart;	/* Starting date for alert date range */
	public $timestart;	/* Starting time for alert date range */
	public $dateend;	/* Ending date for alert date range */
	public $timeend;	/* Ending time for alert date range */
	public $userid;     /* Userid/netid of owning user */
	public $email;      /* Target email for alert */
	public $message;	/* Text of alert */
	public $type;		/* Type of alert (text string, default=APPSLOT) */
	public $sentcount;	/* How often sent */
	
	/* Static (class)  methods */
	
	
	/* 
	This method creates an alert by adding an entry to the wassAlert table 
	*/
	static function create($calendarid,$datestart,$timestart,$dateend,$timeend,$userid,$email,$message,$type) {
	
		/* Set defaults */
		if ($timestart=="") 
			$timestart=="00:00:00";
		if ($dateend=="")
			$dateend==$datestart;
		if ($timeend=="")
			$timeend=="23:59:59";
			
		if ($email=="")
			$email=wassDirectory::getEmail($userid);
	
		if ($type=="")
			$type='APPSLOT';
			
		/* Now write out the record */
		$insert = wassSQL::doQUERY('INSERT INTO ' . wassParms::DATABASE . '.wassAlert (calendarid,datestart,timestart,dateend,timeend,userid,email,message,type) VALUES ('
				  . wassSQL::sqlSafe($calendarid) . ',' . wassSQL::sqlSafe($datestart) . ',' . wassSQL::sqlSafe($timestart) . ',' . wassSQL::sqlSafe($dateend) . ','
				  . wassSQL::sqlSafe($timeend) . wassSQL::sqlSafe($userid) . ',' . wassSQL::sqlSafe($email) . ',' . wassSQL::sqlSafe($message) . ',' . wassSQL::sqlSafe($type) . 
				  ');');
		if (!$insert)
			return $insert;
		else
			return wassSQL::insert_id();
																																									
	}
	
	
	/* 
	This metod sends an alert, given its id number.
	*/
	static function issue($alertid) {
	
		/* Read in the alert */
		$alert = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAlert WHERE alertid=' . wassSQL::sqlSafe($alertid) . ';'));
		/* If found, send it out */
		if ($alert) {
			/* Allow the user to specify multiple emails, separated by a comma */
			$emails = explode(',',$alert['email']);
			foreach ($emails as $email) {
				mail($email,$alert['message'],$alert['message']);
			}
			/* And update the sent count */
			wassSQL::doQUERY('UPDATE ' . wassParms::DATABASE . '.wassAlert SET sentcount=sentcount+1 WHERE alertid=' . $alertid . ' LIMIT 1;');
		}
			
	}
	
	/*
	This function sends out all alerts for a given date range.
	*/
	static function issueall($datestart,$timestart,$dateend,$timeend,$message='') {
		
		/* Set defaults */
		if ($timestart=="") 
			$timestart=="00:00:00";
		if ($dateend=="")
			$dateend==$datestart;
		if ($timeend=="")
			$timeend=="23:59:59";	
		
		/* Locate all of the matching entries */
		$alerts = wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassAlert WHERE ((datestart>=' . wassSQL::sqlSafe($datestart) . ' AND timestart>=' . wassSQL::sqlSafe($timestart) . ') AND (dateend<=' . wassSQL::sqlSafe($dateend) . ' AND timeend<=' . wassSQL::sqlSafe($timeend) .'));');
		
		/* Now go through and send out the alerts */
		while ($alert = wassSQL::doFetch($alerts)) {
			/* Issue the alert */	
			/* Allow the user to specify multiple emails, separated by a comma */
			$emails = explode(',',$alert['email']);
			foreach ($emails as $email) {
				/* If caller did not provided a message, then use it instead of the saved one */
				if ($message)
					$alert['message'] = $message;
				mail($email,$alert['message'],$alert['message']);
			}
			/* And update the sent count */
			wassSQL::doQUERY('UPDATE ' . wassParms::DATABASE . '.wassAlert SET sentcount=sentcount+1 WHERE alertid=' . $alert['alertid'] . ' LIMIT 1;');
		}
	
	
	}
	
	
	
	/* Dynamic (object) methods */
	


}
?>