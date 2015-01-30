
Welcome to WASS (Web Appointment Scheduling System).

The installation instructions are located in the README.txt file.  This file contains a warning and a request.

WARNING:  This latest version of WASS adds two new class variables to the wassParms.class.php file.  If you are currently running a version of WASS earlier than version 4.0.0, you MUST run the install.php script included in this release.  This script will add the two new variables to your wassParms.php file.  If you do not do this, WASS will not work (you will get a blank screen).  The new variables are:

 /* The link to the institution home page */
 const INSHOMELINK = 'http://home.yourinstitution.edu';
 /* The logo for the institution (to link to home) (default is homelogo.png) */
 const INSHOMELOGO = 'homelogo.png';

If you are not currently running WASS, you will be running install.php as part of the normal installation procedure documented in README.txt. 

REQUEST:  We are tying to decide where to take WASS, and what should be in the next release.  If you are running WASS, it would be enourmously helpful to us if you would send us a brief comment saying who you are and what you are doing with WASS, and whether or not we can include you in an email list for queries regarding new feature requests.  I have set up a forum on the sourceforge WASS page where you can post your comment, or you can simply email it to serge@princeton.edu.  Thanks,

The WASS team.

