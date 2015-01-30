<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This is the parameters template file.  It contains constants that control the operation of WASS.  This file is edited during installation, and the edited form is stored as classes/wassParms.class.php.
 
*/

class wassParms {

	/* Local (institution) names/parameters */
	/* Domain name */
	const DOMNAME = 'somewhere.edu';	
	/* Short name of institution */
	const INSNAME = 'Some University';
	/* Long name of institution */
	const INSFNAME = 'Some University';
	/* The link to the institution home page */
    const INSHOMELINK = 'http://homepage.yourinstitution.edu';
    /* The logo for the institution (to link to home) (default is homelogo.png) */
    const INSHOMELOGO = 'homelogo.png';
	/* Name used for 'netid' or 'userid' */
	const NETID = 'Netid';
	/* Phrase used to label a 'password' */
	const PASSNAME = 'LDAP Password';
	/* URL for a help page on netids */
	const HELPNETID = "http://help.someplace.edu/help_on_netid";
	/* URL for a help page on passwords */
	const HELPPASS = "http://help.someplace.edu/help_on_passwords";
	/* The name oif the system */
	const SYSID = "Web Appointment Scheduling System (Release 1.0)";
	/* The name of the thing being scheduled by the system */
	const NAME = "Office Hour";		

	
	/* Switch that determines if system is up or not */ 
	const RUNNING = 1; 
	/* Message to display when system is not running */
	const DOWNMSG = "";
	/* Require SSL connection */
	const REQSSL = 1;
	
	/* XML header parameters */
	const VALIDATEXML = false;
	const XMLNAME = 'wass';
	const XMLHEADER = '<?xml version="1.0" encoding="ISO-8859-1"?>';
	const XMLFHEADER = '<?xml version="1.0" encoding="ISO-8859-1"?> 
								<wass
								xmlns="http://wass.princeton.edu/"
								xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
								xsi:schemaLocation=
								"http://wass.princeton.edu/wass.xsd"> ';
	const XMLTRAILER = '';
	
	/* Icalendar parameters */
	const ICALHEADER = "BEGIN:VCALENDAR\r\nPRODID:-//Princeton University/Web Appointment Scheduling System//EN\r\nVERSION:2.0\r\n";
	const ICALTRAILER = "END:VCALENDAR\r\n";

	/* List of all supported views (appointment slot sizes) */
	const ALLVIEWS = '5 10 15 20 30 60';
	/* Default view (appointment slot size) */
	const DEFVIEW = '15';
	
	
	/* MYSQL parameters */
	
	/* Name of host running the MySQL service */
	/* const HOST = "webscript.princeton.edu"; */
	const HOST = "socket or hostname";
	/* Name of MYSQL database in which tables will be stored */
	const DATABASE = "you must fill in a database name";
	/* User id associated with the MYSQL database */
	const USER = "you must fill in a database userid";
	/* Password associated with the MYSQL database */
	const PASS = "themysqlpassword";
	
	
	/* Flag to control validty-checking of email addresses */
	const CHECKEMAIL = false;
	
	
	/* Flag which determines who authentication will be done.  Choices are:
		LDAP
		CAS
	 */
	const AUTHTYPE = 'LDAP';  
	const AUTHLDAP = 'LDAP'; 
	const AUTHCAS = 'CAS';
	const AUTHAD = 'AD';
	const AUTHLOCAL = 'LOCAL';
	
	
	/* LDAP configuration parameters */
	/* Name of LDAP/Active Directory server */
	const LDAP = "ldap.somewhere.edu";
	/* LDAP port  ... use SSL if possible */
	const LPORT = '636';
	/* LDAP distinquished name */
	const BDN = 'o=Some University,c=US';
	/* LDAP attribute values */
	/* Full name */
	const LDAPNAME = 'displayname';
	/* Telephone number (primary) */
	const LDAPPHONE = 'telephonenumber';
	/* Office Location */
	const LDAPOFFICE = 'street';
	/* Preferred email address */
	const LDAPEMAIL = 'mail';
	/* Netid */
	const LDAPNETID = 'uid';
	
	/* Windows Active Directory parameters */
	const ADLOGIN = '';
	const ADPASS  = '';
	
	
	/* CAS configurations parameters */
	const CASversion = '2.0';
	const CAShost = 'your-case-server-hostname.your-institution.edu';
	const CASport = '443';
	const CASuri = 'CAS URI at your institution';
	const CASname = 'CAS';
	const CASlogout = 'http://cas.yourinstitution.edu/logout';

	
	/* Name and contact information for support */
	const CONTACTNAME = "Fill in contact information for user support.";
	const CONTACTEMAIL = "someone@someplace.edu";
	const CONTACTPHONE = "555-1212";
	const SYSMAIL = 'someone@someplace.edu';
	const FROMMAIL = 'someone@someplace.edu';
	

	/* Switches that control what informatory email messages get sent to SYSMAIL */
	/* Send summary email about reminders. */
	const MAILREM = 1;
	/* Send email when schedules are created/deleted. */
	const MAILCAL = 1; 
	
	/* Switches that control which optional features are available or unavailable. */
	/* Turn on user view/sign-up limits (only specified users can make appointments). */
	const USERLIM = 1;
	/* Turn on course view/sign-up limits (only users in specified courses can make appointments). */
	const COURSELIM = 1;
	/* Should email validity be tested? */
	const TESTEMAIL = 0;
	
	/* Variables that control the course view/sign-up limit facility. */
	/* If using the Blackboard web service, the URL for the WSDL file. */
	const BBWSDL =
		"https://blackboard.someplace.edu/webapps/pu-etc-bb-ws-bb_bb60/services/puBBAPI?wsdl";	
	/* If using Blackboard web service, the KEY for the web service. */
	const BBKEY = "ws_someplace";
	
	/* Ajax Directory URL */
	const AJAXURL = "https://mypath/ajax/wassAjax.php";
	const AJAXSCHEMAROOT = "http://mypath/";
	
	
	/* List of comma-separated academic daytypes */
	const DAYTYPES = 'Teaching,Holiday,Fall,Spring,Winter,Summer,Recess,Reading,Exam,Midterms';

	/* List of colors associated with day type (for display) */
	const DAYCOLORS = '#FF0000,#009900,#3322FF,#448833,#99FF00,#FF9933,#FF00FF,#3377FF,#FFFFFF,#FFFF00'; 

	/* Default day type */
	const DEFAULTDAYTYPES = 'Teaching';

} 
?>