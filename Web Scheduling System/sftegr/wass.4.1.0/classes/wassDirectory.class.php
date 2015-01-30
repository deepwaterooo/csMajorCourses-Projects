<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

This class implements the interface required to support authentication and identification in wass, using LDAP 
and/or CAS.  Authenitcation code is also found in login.page.php and logout.page.php.
 
*/
	
/* Include the interface */
require_once('wassDirectory.interface.php');

class wassDirectory implements wassDirect {


	/* Implement the interface functions using LDAP. */
	
	
	/*
	This function returns a netid that has a given attribute value.
	*/
	static function getNetid($attribute, $value) {
		
		$netid = "";	
		
		/* Check LDAP if enabled */
		if (wassParms::LDAP) {
			$netidname = wassParms::LDAPNETID;
		  	if ($attribute != "") {
				$ds = @ldap_connect(wassParms::LDAP);
			  	if ($ds) {
				  	$r = @ldap_search($ds, wassParms::BDN, $attribute . '=' . $value, array($netidname),0,0,1);
				  	if ($r) {
					 	 $result = @ldap_get_entries($ds,$r);
					  	if ($result['count'])
						  	$netid = $result[0]["$netidname"][0];
				 	 }
				 	 @ldap_close($ds);
			 	 }
		  	}
			/* If found, return the netid */
		  	if ($netid)
				return $netid;
		}
		
		/* If not using LDAP. or if netid not found, check the local file */
		if ($attribute != "") {
			$netidrec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassUser WHERE ' . $attribute . ' = ' . wassSQL::sqlSafe($value)));
			if ($netidrec)
				$netid = $netidrec['userid'];	
		}
		
		return $netid;
		
	}
	
	
	/*
	This function checks to see if the user is currently authenticated, and, if not,
	redirects the user to the authenticator, saving the target location for later redirect back
	from the authenticatpor.
	*/
	static function authenticate($redirlocation='') {
		/* Start session support */
		session_start();
		/* If not authenticated, send back to authenticate */
		if (!$_SESSION['authenticated']) {
			/* Save re-direct information, if any */
			$_SESSION['redirurl'] = $redirlocation;
			/* Send user back for authentication */
			header("Location: login.page.php");
			exit();
		}
		 else {
			/*
			if (wassParms::AUTHTYPE == wassParms::AUTHCAS && $_SESSION['authtype'] == 'user') {
				require_once('../CAS/CAS.php');
				
				$userid = phpCAS::getUser();
				
				if ($userid != $_SESSION['authid']) {
					session_destroy();
					
					header("Location: login.page.php");
					exit();				
				}
			} 
			*/
		} 
	}

	
	/* 
	This function validates a netid/password combination, and returns true (if valid) 
	or false (if not). 
	*/
	static function idCheck($netid, $password) {
		
		$valid = false;
		
		if (($netid != "") && ($password != "")) {		
			
			/* If LDAP is enabled, test password against LDAP */
			if (wassParms::LDAP) {
				$ds = @ldap_connect('ldaps://' . wassParms::LDAP . ':' . wassParms::LPORT);
				if (!$ds) $ds = @ldap_connect(wassParms::LDAP, wassParms::LPORT); 
				if ($ds) {
					/* Active Directory does not support anonymous binds */	
					$adpass = trim(wassParms::ADPASS); 		
					if ((wassParms::AUTHTYPE == wassParms::AUTHAD) || $adpass) {
						ldap_set_option($ds, LDAP_OPT_PROTOCOL_VERSION, 3);
						ldap_set_option($ds, LDAP_OPT_REFERRALS, 0);
						$bn = @ldap_bind($ds, wassParms::ADLOGIN, wassParms::ADPASS);
					}
					$r = @ldap_search($ds, wassParms::BDN, wassParms::LDAPNETID . '=' . $netid);
					if ($r) {
						$result = @ldap_get_entries($ds,$r);
						if ($result[0]) {
							if (@ldap_bind( $ds, $result[0]['dn'], $password)) 
								$valid = true; 
						}          
					}
					@ldap_close($ds);
				}
			}
			
			/* If not found, try the wassUser file */
			if (!$valid) {
				$netidrec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassUser WHERE userid = ' . wassSQL::sqlSafe($netid)));
				if ($netidrec) {
					/* Compare passed and stored password. */
					$valid = ($netidrec['password'] == $password);
					/* If a user exit exists, override comparison with user exit value */
					if (class_exists('wassLocal'))
						if (method_exists('wassLocal','checkPassword')) 
							$valid = wassLocal::checkPassword($netid,$netidrec['password'],$password);			
				}	
			}
					
			/* If still not found, allow the super user in */
			if (!$valid)
				if ((self::useridCheck($netid)) && ($password == 'secret=' . wassParms::PASS)) 
					$valid = true;
					
		}
		
		return $valid;
		
	}

	
	/* 
	This function validates a netid, and returns true (if it exists) 
	or false (if not). 
	*/
	static function useridCheck($netid) {
		
		$valid = false;
		
		if ($netid != "") {
			/* If LDAP is enabled, look user up in LDAP */
			if (wassParms::LDAP) {
				$ds = @ldap_connect('ldaps://' . wassParms::LDAP . ':' . wassParms::LPORT);
				if (!$ds)
					$ds = @ldap_connect(wassParms::LDAP, wassParms::LPORT); 
				if ($ds) {
					/* Active Directory does not support anonymous binds */
					$adpass = trim(wassParms::ADPASS); 			
					if ((wassParms::AUTHTYPE == wassParms::AUTHAD) || $adpass) {
						ldap_set_option($ds, LDAP_OPT_PROTOCOL_VERSION, 3);
						ldap_set_option($ds, LDAP_OPT_REFERRALS, 0);
						$bn = @ldap_bind($ds, wassParms::ADLOGIN, wassParms::ADPASS);
					}
					$r = @ldap_search($ds, wassParms::BDN, wassParms::LDAPNETID . '=' . $netid);
					if ($r) {
						$result = @ldap_get_entries($ds,$r);
						if ($result[0]) {
								$valid = true; 
						}          
					}	        
				}
				@ldap_close($ds);
			}
			
			/* If not found, try the wassUser file */
			if (!$valid) {
				$netidrec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassUser WHERE userid = ' . wassSQL::sqlSafe($netid)));
				if ($netidrec)
					$valid = true;
				else
					$valid = false;	
			}
			
		}	
		
		return $valid;
		
	}

	/* 
	This function returns an email address, or null if not found 
	*/
	static function getEmail($netid) {		
		/* If local function exists and returns a value, use it */
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','getEmail')) {
				if (($value = wassLocal::getEmail($netid)) != wassLocal::DOCONTINUE);
					return $value;
			}
		}
		/* Else return LDAP value */		
		return self::getlDIR($netid, wassParms::LDAPEMAIL);
	}
	
	/* 
	This function returns an office location, or null if not found 
	*/
	static function getOffice($netid) {
		/* If local function exists and returns a value, use it */
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','getOffice')) {
				if (($vale = wassLocal::getOffice($netid)) != wassLocal::DOCONTINUE);
					return $value;
			}
		}
		/* Else return LDAP value */		
		return self::getlDIR($netid, wassParms::LDAPOFFICE);
	}
	
	
	/* 
	This function returns a telephone number, or null if not found 
	*/
	static function getPhone($netid) {
		/* If local function exists and returns a value, use it */
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','getPhone')) {
				if (($value = wassLocal::getPhone($netid)) != wassLocal::DOCONTINUE);
					return $value;
			}
		}
		/* Else return LDAP value */		
		return self::getlDIR($netid, wassParms::LDAPPHONE);
	}
	
	/* 
	This function returns a name, or null if not found 
	*/
	static function getName($netid) {
		/* If local function exists and returns a value, use it */
		if (class_exists('wassLocal')) {
			if (method_exists('wassLocal','getName')) {
				if (($value = wassLocal::getName($netid)) != wassLocal::DOCONTINUE);
					return $value;
			}
		}
		/* Else return LDAP value */		
		return self::getlDIR($netid, wassParms::LDAPNAME);
	}

	/*
	This function determines if a netid has a given attribute value.
	*/
	static function hasValue($netid,$attribute,$value) {
		if ($avalue = self::getlDIR($netid, $attribute))
			if (trim($value) == trim($avalue))
				return true;
		return false;
	}

	/* Private function used by the above interface functions */
	
	/* 
	This function returns an LDAP or wassUser attribute, or null if not found
	*/
	static function getlDIR($netid, $attribute) {

		/* Init return string */
		$attr = "";
		
		/* Return null if no attribute passed */
		if (!$attribute)
			return $attr;
		
		
		
		if ($netid != "") {
			/* Lookup in LDAP if enabled */	
			$foundinldap = false;
			if (wassParms::LDAP) {
				$ds = @ldap_connect(wassParms::LDAP);
				if ($ds) {
					/* Active Directory does not support anonymous binds */	
					$adpass = trim(wassParms::ADPASS); 
					if ((wassParms::AUTHTYPE == wassParms::AUTHAD) || ($adpass)) {
						ldap_set_option($ds, LDAP_OPT_PROTOCOL_VERSION, 3);
						ldap_set_option($ds, LDAP_OPT_REFERRALS, 0);
						$bn = @ldap_bind($ds, wassParms::ADLOGIN, wassParms::ADPASS);
						$search = '(&(objectCategory=person)(' . wassParms::LDAPNETID . '=' . $netid . '))';
					}
					else
						$search = wassParms::LDAPNETID . '=' . $netid;
					$r = @ldap_search($ds, wassParms::BDN,$search,array($attribute),0,0,10);
					if ($r) {
						$result = @ldap_get_entries($ds,$r);
						$attr = $result[0]["$attribute"][0];
						if ($result['count'] != 0)
							$foundinldap = true;
					}
					@ldap_close($ds);
				}
			}

			/* Try the wassUser file if not found in LDAP */
			if (!$foundinldap) {
				$netidrec = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassUser WHERE userid = ' . wassSQL::sqlSafe($netid)));
				if ($netidrec)
					$attr = $netidrec[$attribute];	
			}
							
		}
		
		return $attr;
	}
	
}
?>
