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
	
}
/* Turn on output buffering */
ob_start();

$input = wassParms::XMLFHEADER . $_POST['wass'] . '</wass>';
 
$host = $_SERVER['SERVER_NAME'];
$path = substr($_SERVER['PHP_SELF'],0,-22);
 
echo '<html><head><title>wassAjax</title></head><body>Input is:<br />' . htmlentities($input) . '<br /><br />Output is:<br /><br />';

echo htmlentities(sendToHost('ssl://' . $host,
			443,
			'post',
			$path . 'ajax/wassAjax.php',
			$input,
			$useragent=0));
			 
echo '</body></html>';
 
/* Flush the output buffer */
ob_flush();

exit();


/* Issue a GET or POST to a web host */
/* sendToHost
 * ~~~~~~~~~~
 * Params:
 *   $host      - host name, possibly preceded with ssl:// 
 *   $port      - 80 or 443 (ssl)
 *   $method    - get or post, case-insensitive
 *   $path      - The /path/to/file.html part
 *   $data      - The query string, without initial question mark (or post data)
 *   $useragent - If true, 'MSIE' will be sent as 
                  the User-Agent (optional)
 *
 * Examples:
 *   sendToHost('www.google.com',80,'get','/search','q=php_imlib');
 *   sendToHost('www.example.com','post','/some_script.cgi',
 *              'param=First+Param&second=Second+param');
 *   For GET, the data consists of urlencoded field=value strings, seperated by & signs:
 *             name=Serge+Goldstein&id=serge&password=secret
 *
 */

function sendToHost($host,$port,$method,$path,$data,$useragent=0)
{
    // Supply a default method of GET if the one passed was empty
    if (empty($method)) {
        $method = 'GET';
    }
	list($prefix,$justhost) = explode('://',$host);
	if ($justhost == '') 
		$justhost = $host;
    $method = strtoupper($method);
    $fp = fsockopen($host, $port);
	if (!$fp) {
		echo "$errstr ($errno)<br />\n";
		exit();
	}
    if ($method == 'GET') {
        $path .= '?' . $data;
    }
    fputs($fp, "$method $path HTTP/1.1\r\n");
    fputs($fp, "Host: $justhost\r\n");
    fputs($fp,"Content-type: text/xml\r\n");
    fputs($fp, "Content-length: " . strlen($data) . "\r\n");
    if ($useragent) {
        fputs($fp, "User-Agent: MSIE\r\n");
    }
    fputs($fp, "Connection: close\r\n\r\n");
    if ($method == 'POST') {
        fputs($fp, $data);
    }
	$buf = '';
    while (!feof($fp)) {
        $buf .= fgets($fp,128);
    }
    fclose($fp);
    return $buf;
}