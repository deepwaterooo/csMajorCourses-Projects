<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This script issues a redirect based on its single passed GET parameter.
 
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
	
}/* Get the argument */
$redirid = $_REQUEST['id'];
if (!$redirid) {
	echo "No id value passed to redir";
	exit;
}
/* Locate the corresponding URL */
$url = wassSQL::doFetch(wassSQL::doQuery('SELECT * FROM ' . wassParms::DATABASE . '.wassRedir WHERE redirid=' . wassSQL::sqlSafe($redirid))); 
if (!$url) {
	echo "Invalid id value passed to redir";
	exit;
}
/* Redirect */
header('Location: ' . $url['url']); 
exit;
?>