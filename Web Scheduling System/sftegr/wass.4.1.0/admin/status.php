<?php

/* Set error reporting level */
error_reporting(E_ALL);
 
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Report status of a list of netids or emails </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<h1 align="center">Report status of a list of netids or emails</h1><p></p>

<?php

$in = ""; $out = "";

if (isset($_POST['submit'])) {
	$out = "";
	$in = $_REQUEST["in"];
	$tok = strtok($in, " \r\n\t");		
	while ($tok !== false) {
		$tok = trim($tok);
		if ($tok) {
			if (strstr($tok,'@') !== False)
				$statarray = getlATTR('mail',$tok);
			else
				$statarray = getlATTR('uid', $tok);
			$status = $statarray[0]['pustatus'][0];
			$netid = $statarray[0]['uid'][0];
			$name = $statarray[0]['displayname'][0];
			$email = $statarray[0]['mail'][0];
			$out .= "netid=$netid name='$name' email=$email status = $status\r\n";
		}
		$tok = strtok(" \r\n\t");
	}
}

/* This function looks up an LDAP attribute and returns a matching array */
function getlATTR($attribute, $value) {
	$result = array();
	if (($attribute != "") && ($value != "")) {
		$ds = @ldap_connect('ldaps://ldap.princeton.edu:636');
		if (!$ds)
			$ds = @ldap_connect('ldap.princeton.edu', 636); 
		if ($ds) {
			$r = @ldap_search($ds, 'o=Princeton University,c=US', "$attribute" . "=" . $value);
        	if ($r) {
           		$result = @ldap_get_entries($ds,$r);
			}
			@ldap_close($ds);
		}
	}
	return $result;
} 

?>
 


<form name="ids" id="ids" method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
 
<p>
Copy the names or email addresses of the people you want to look up into the In box, then click "submit".  The names or email addresses should all be separated from each other by a newline (that is, each name or email address should appear on a separate line in the box).  The results will appear in the Out box.
</p>


<table width="100%" border="0">
<th align="left" width="5%">In</th>
<td width="95%"><textarea name="in"  rows="10" cols="50"><?php echo "$in";?></textarea></td>
</tr>
<tr>
<th align="left" width="5%">Out</th>
<td width="95%"><textarea name="out"  rows="10" cols="100"><?php echo "$out";?></textarea></td>
</tr>
</table>
<input type="submit" name="submit" value="submit" />
</form>
</body>
</html>