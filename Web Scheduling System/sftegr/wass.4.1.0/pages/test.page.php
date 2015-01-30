<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Test wassAjax</title>
</head>
<body>

<?php


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
	
}$val = wassUtil::slashstrip($_REQUEST['wass']);
echo 'textarea AFTER STR_REPLACE hex is:' . bin2hex($val) . '<br />';
echo 'text     AFTER STR_REPLACE hex is:' . bin2hex($val) . '<br />';
?>
                                   
<form method="post" action="test.page.php">
Enter your character into a textarea:<br />
<textarea name="wass" cols="60" rows="10"></textarea><br />
Enter your character into a text box:<br>
<input type='text' name="wasstext" size"60" /><br />
<input type="submit" name="submit" value="submit" />
</form>
</body>
</html>
