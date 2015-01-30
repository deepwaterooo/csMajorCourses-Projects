Web Service for Princeton University's Web Appointment Scheduling System.


Installation-

The web service files are contained in the "blackboard" directory of WASS. 

To install the Blackboard building block:

1) Copy the two files config.properties and puBBAPI_OHpublish.war from the blackboard directory to a working area on you desktop.

2)  Login to your blackboard system as administrator.

3)  From the Blackboard user interface, select the “System Admin” tab, “Building Blocks” and “Install Building Blocks”.

4)  You should see file upload form.  Browse to puBBAPI_OHpublish.war and click submit.

5)  In the absence of errors, the building block will be installed and will reside in this plugin directory –

/usr/local/blackboard/content/vi/bb_bb60/plugins/pu-etc-bb-ws

Do not make it “available” yet because there are configuration parameters you may want to change.

6)  If the “config” directory doesn’t already exist, create this directory on your Blackboard machine at the same level as the “webapp” directory.

/usr/local/blackboard/content/vi/bb_bb60/plugins/pu-etc-bb-ws/config

7)  Edit the local copy of your config.properties file and set the value of the "pu.ws.key" to a password.  You will later specify this password in the WASS parameters file.  Ignore any other variables.

8) Upload the edited "config.properties" file to the Blackboard machine’s "config" directory created in step 6.
 
9)  After installing the building block in step 4, the war file will have expanded into the building block’s “webapp” directory –

/usr/local/blackboard/content/vi/bb_bb60/plugins/pu-etc-bb-ws/webapp

If you drill down into “WEB-INF/config”, you will find a couple of configuration files.


10)	In the “sectioning_db.properties” file, change the values of “toemail” and “fromemail”.  If a non-SSL HTTP request is received, email notification will be sent to "toemail", and will appear to come from "fromemail".  You should set these variables to a local sysadmin email address.  The other variables can be left as they are and will not be used.

11)  You can change the log settings by editing “log4j.properties".  Refer to 

http://logging.apache.org

for details.

12)  Make the building block available through the “Building Blocks” tab.
    
It is necessary to stop and restart the Blackboard servers.

13) Write down the web services key that you set in step 7 above.  You also need to write down the address of the web services WSDL file.  This address is:

https://blackboardatyourintitution.edu/webapps/pu-etc-bb-ws-bb_bb60/services/puBBAPI_OHpublish?wsdl

You will need to substitute the host name of your blackboard server for "blackboardatyourintitution.edu" in the above URL.  You will need these two values (web services key and wsdl URL) when you set up your WASS parameters file during the WASS installation.




Testing the Web Service –


Below is a sample php test program –

<?php

  $wsdl_url = "https://blackboardatyourinstitution.edu/webapps/pu-etc-bb-ws-bb_bb60/services/puBBAPI_OHpublish?wsdl";
  $webkey = 'whatever you set your web key to in step 7 above';
  
  $netid = 'netid of someone at your school';
  $course = 'full blackboard courseid of some course in your blackboard system';
  

  $client = new SoapClient($wsdl_url);

  $result = $client -> getUserRole( $netid, $course, $webkey);

  echo $result[0];

?>



