
Welcome to WASS (Web Appointment Scheduling System).


This file contains download and installation/update instructions for WASS.


Requirements for installing and running WAS:
===========================================

Before downloading and installing WASS, make sure you have access to the following:

1. A LAMP server running Apache and PHP 5+.  WASS will not run under PHP 4. It has not been tested on a Windows server.

2. The following RPM packages: mod_ssl, php-xml, php-ldap, php-soap and elinks. (The mod_ssl install  will also do dependent 
   updates of the distcache and httpd packages.)
   
3. A directory on that server in which WASS will be installed. Typically this would be somewhere in your Apache 
	document root structure. WASS can run out of htdocs or out of a user's public_html directory.

4. A MySQL 3+ server and a database on this server. WASS creates tables within this database. The MySQL server can
	be on the WASS Apache server or on a different server.

5. An LDAP or CAS server for performing user authentication (login).  
	WASS cannot run without either LDAP or CAS for authentication (unless you want to re-write the authentication code 
	located in classes/wassDirectory.class.php).  The LDAP server can be a Windows Active Directory (AD) server, or any other
	server that supports the LDAP protocol (e.g., Sun).
	
	[NOTE:  WASS 3.0.2+ includes a primitive local password facility that allows you to run WASS without LDAP or CAS.
	This facility consists in a MySQL tables (wassUser) that you must manually maintain, and in which you store userids 
	and passwords, using a tool such as phpMyAdmin.  This is not intended to be a full-blown local login facility, but rather
	something that can be used if you have a very limited set of users that you need to authenticate.  If you are
	using LDAP for authentication, you can still use this facilty to create "private" WASS users.  See the local_user.txt file
	for details.]

6. An LDAP  server for directory lookups. The LDAP server can be a Windows Active Directory (AD) server, or any other
	server that supports the LDAP protocol (e.g., Sun).  WASS expects to be able to lookup people's office locations, telephone numbers, and other 
	particulars by consulting your local LDAP server.  If you are not running an LDAP (or AD) server, or it does not contain directory 
	information about users at your institution, you can still run WASS; users will have to fill in this information themselves 
	whenever they use the system (e.g., schedule appointments).  You can use LDAP for both user authentication and for 
	directory lookups, or you can use CAS for user authentication and LDAP for directory lookups.   
	
	[NOTE:  The primitive local password facility in WASS 3.0.2+ also allows you to specify directory information about
	users (name, email,  telephone number and office address.  You can use this local password facility instead of LDAP if you
	are maintaining a very limited set of users.  If you are using LDAP fort authentication,, you can still use this facilty to 
	create "private" WASS users. See the local_user.txt file for details.]
	
	 
If you can meet these requirements, then proceed with the installation.


Installation:
============

Note: If you have already installed an earlier version of WASS and are upgrading to a newer release, please skip to the section entitled "Upgrading".

1. Download the current WASS release.  It will have a filename of the form "wass.release.tar.gz".  You will want to download 
this file to the place from which it will run on your Apache server (either somewhere in the Apache document tree, or in 
a user's public_html space, for example).

2. Uncompress the release file.  The file was created with the Unix command:
		tar -cf - * | gzip wass.release.tar.gz
	You would typically uncompress it with (subsitute the name of the release file for "wass.release.tar.gz"):
		zcat wass.release.tar.gz | tar -xf -
		
	Please note that the resulting files and directories include a ".htaccess" file (which will not show 
	up on a standard Unix "ls" command;  use "ls -a" to see all of the files and directories).  You may need to rename
	this file to something like "htaccess" (without the leading ".") to allow the installation to proceed (see below). 
	
	The directories and files will need to be readable by your apache server.  You may need to issue a "chmod" and/or 
	"chown" command to set permissions/ownership to allow read access by your apache server.
	
3.  The distribution includes a .htaccess file with rewrite rules.

    It is possible that the apache configuration under which you are running does not support having a site issue 
	rewrite rules (or other directives in the .htaccess file). If this is the case, you will get an "internal server error" 
	when you execute the following step.  You need to talk to your  Apache administrator to make sure your site is configured so 
	as to allow these directives to be issued from an htaccess file.  The directives do the following:  
	set error flags; redirect a non-https URL to a https URL; redirect an unspecific URL to the login page; set the PHP 
	error reporting level; redirect a "m" URL to the mobile web pages.

You do not need to have the .htaccess file in place to run the installation, but you do need to have it in place to run WASS (otherwise the URLs that
WASS advertises for accessing calendars will not work). 
	
4. Step 2 will have created a set of files and directories.  One of the directories is named "admin", and in that directory
	is a file named "install.php".  Run this file from a web browser, using a URL of the form:
	
		https://apache-server-name/path-to-wass/admin/install.php?secret=themysqlpassword

	Note that you must use "https", not "http".  Substitute for "apache-server-name" the hostname of the apache 
	server on which you have downloaded and expanded WASS.  Substitute for "path-to-wass" the path to the 
	location where you have downloaded and expanded WASS.  The rest of the URL must be entered exactly as above.  
	Do not substitute for "themysqlpassword"; enter that literally in the URL.
	
	If you get an "internal server error" message, then that is probably due to your Apache server 
	not allowing the directives encoded in the .htaccess file.  If you wish to proceed with the installation 
	anyway, simply rename the .htaccess file to "htaccess" (without the leading .).  At some later time, 
	you will want to allow the directives to be issued.

5. Follow the instructions of the install.php script.

6. Following installation, you should read the administer.txt file (in the same directory as this file) for an overview of
WASS administration.  You should also read the WASS.doc or WASS.pdf files for an overview of WASS.


Upgrading
=========

If you are upgrading from an earlier WASS release, please follow these steps:

1. Save any customizations you have made.  You do not need to save your local copy of wassParms.class.php (which contains all of you local configuration information) or wassLocal.class.php (if you have coded your own user exits).  The WASS distributions never include a copy of these files, so installing WASS will never over-write your version of these files.  WASS distribitions DO, however, include an .htaccess file, the help file (help.page.php) and the faq (faq.html), so if you have modified these file or any other files, save you local versions in a separate directory so that you can re-install them later.

2. Carry out steps 1 and 2 above (download and expand the tar.gz file).  You can download the new distribution on top of the current one, or into a new directory.  If you download into a new directory, make sure you copy over any modified files (including wassParms.class.php) into the corecponding sub-directory in the directory (if you don't do this, WASS will think that you are doing an initial install).

3. Run the install.php script in the admin sub-directory, and skip to the MySQL table build step.  This step will run the maketables.php script, which contains a cumulative set of "ALTER TABLE" statements that add or remove any database fields needed by the current release of WASS.  You can skip the other steps.   The install.php script will also add any new class contants needed in your wassParms.class.php file (but will not otherwise alter that file).  YOU MUST RUN THIS STEP.  If you do not, and the new version of WASS includes class constants that are not in your current version,
then WASS will abort (you will get an error message about a missing class constant).

4. Now retro-fit any of you local customizations (in particular, restore your .htaccess file and/or any other files you have modified).


If you have any questions, please contact:  
	Serge Goldstein
	serge@princeton.edu
	609-258-6059


License
=======

WASS is licensed under the Educational Community License, 
Version 2.0 (http://www.osedu.org/licenses/ECL-2.0).

WASS contains a copy of the phpCAS distribution. phpCAS is licensed under the New BSD License, 
an OSI-certified ("open") and Gnu/FSF-recognized ("free") license.


