<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page is the main calendar page of the application.  Calendar owners and managers can add, edit, and delete blocks.
		Calendar owners, managers, and appointment makers can add and delete appointments.
		Notable GET (and POST) arguments:
			- cal_id: a comma-separated list of the calendar IDs of the calendars that should be shown.
			- st_dt, st_tm, ed_dt, ed_tm: the start date, start time, end date, and end time of the calendar to be shown. (for bookmarking)
			- view: the view of the calendar that should be shown. (for bookmarking)

*/
Header('Cache-Control: no-cache');
Header('Pragma: no-cache');
 
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

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();

/* Start session support */
session_start();

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate($_SERVER['REQUEST_URI']);


/*
Save flag indicating whether/not we are called to "make an appointment".
*/
if ($_REQUEST['makeapp'])
	$hidMakeApp = 'makeapp';
elseif ($_REQUEST['hidMakeApp'])
	$hidMakeApp = $_REQUEST['hidMakeApp'];
else
	$hidMakeApp = 'view';

$HelpTopic = $hidMakeApp;

/*
Save passed cal_id(s) (if any).  Note:  more than one calendarid can be
passed to viewcalendar.
*/
$cal_id = $_REQUEST['cal_id'];
if (!$cal_id)
	$cal_id = $_SESSION['cal_id'];
$cal_ids = explode(',',$cal_id);

if (!$cal_ids)
	die('No calendar id(s) passed to viewcalendar.');

$_SESSION['cal_id'] = $cal_id;


/* Read in the calendar(s) */
$cals = array();
try {
	foreach ($cal_ids as $calid) {
		$cals[] = new wassCalendar('load',array('calendarid'=>$calid));
	}
} catch (Exception $error) {
	die($error->getMessage());
}

/* Set session variable which stores whether/not this user manages any calendars */
if (wassManager::listManagedids($_SESSION['authid']))
	$_SESSION['ismanager'] = true;
else
	$_SESSION['ismanager'] = false;

/* Get block owner userid, if any: 1-18-2013 */
$block_ownerid = $_REQUEST['block_ownerid'];

/*
Save calendar owner's names and whether logged-in user is calendar owner/manager.  Also record whether or not blocks exist for the calendar, and
whether or not logged-in user has any appointments.
*/
$hidIsOwner = 0; $hidCalOwnerName = ''; $hidHaveBlocks = 0; $hidIsManagerOfThisCal = 0;
foreach ($cals as $cal) {
	if ($hidCalOwnerName)
		$hidCalOwnerName .= ' and ';
	$hidCalOwnerName .= $cal->name;
	if ($cal->isOwnerOrManager($_SESSION['authtype'],$_SESSION['authid'])) {
		$hidIsOwner = 1;
		/* See if any blocks defined for this calendar */
		if (!$block_ownerid)
			$blocks = wassBlock::listMatchingBlocks(array('calendarid,='=>$cal->calendarid));
		else
			$blocks = wassBlock::listMatchingBlocks(array('calendarid,='=>$cal->calendarid,'userid,=,AND'=>$block_ownerid));
		if ($blocks->entries())
			$hidHaveBlocks = 1;
		unset($blocks);
	}
	if ($cal->isManager($_SESSION['authid']))
		$hidIsManagerOfThisCal = 1;
}


/* See if user has any appointments scheduled */
$apps = wassAppointment::listMatchingAppointments(array('userid,='=>$_SESSION['authid']));
if ($apps->entries())
	$hidHaveApps = 1;
else
	$hidHaveApps = 0;
unset($apps);

/* Get passed block ID, if any, 4-20-2011 */
$block_id = $_REQUEST['block_id'];

/* Get passed start date/time, end date/time */
$st_dt = $_REQUEST['st_dt'];
$st_tm = $_REQUEST['st_tm'];
$ed_dt = $_REQUEST['ed_dt'];
$ed_tm = $_REQUEST['ed_tm'];
$view = $_REQUEST['view'];

$sView = $_REQUEST['sView'];
if ( $sView != '' )
	$view = $sView;

/* Init error/inform message text */
$errmsg = ''; $infmsg = '';

/* If user is a calendar owner and has no defined blocks, issue informatory message about creating blocks. */
if ($hidIsOwner  && ($hidMakeApp != 'makeapp')) {
	if (!$hidHaveBlocks)
		$infmsg = 'Before people can make appointments with you, you must add one or more blocks of available time to the calendar.  Click Add Block(s) to add blocks, or click Help for details.';
}
/* If user is not a calendar owner, and they have no appointments, let them know how to make an appointment */
else {
	if (!$hidHaveApps && ($hidMakeApp == 'makeapp'))
		$infmsg = 'To make an appointment, you must select a date and time when the calendar owner is available for appointments.  Click the Help button for
	details.';
}

/* Assume no display URL */
$url = '';

/* Generate URL head for displaying block */
if (!$errmsg) {
	/* Generate display URL */
	makeURLHead($cal);
}

/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

/* No form submission */

}

/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo wassParms::SYSID;?></title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript" src="js/drawcalendar.js"></script>
<script type="text/javascript" language="javascript" src="js/calendaractions.js"></script>
<script type="text/javascript" language="javascript" src="js/block.js"></script>
<script type="text/javascript" language="javascript" src="js/appointment.js"></script>
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
<script type="text/javascript" language="javascript" src="js/calendar.js"></script>
<script type="text/javascript" language="javascript" src="js/viewcalendar.js"></script>
<script type="text/javascript" language="javascript" src="js/wasscalendar.js"></script>
<link type="text/css" rel="stylesheet" href="css/calendar.css" />
<link rel="stylesheet" type="text/css" href="css/styles.css"  />
<link rel="stylesheet" type="text/css" href="css/printcalendar.css" media="print" />

<script type="text/javascript" language="javascript">
document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";
document.iCalendarID = new Array();
<?php
foreach ($cals as $cal) {?>
document.iCalendarID.push('<?php echo $cal->calendarid;?>');<?php
}?>
document.isMultiCalendar = false;
if (document.iCalendarID.length > 1) document.isMultiCalendar = true;

// KDC, 8-6-2008. Set up javascript calendars
<?php
/*
Get a list of all of the calendars owned or managed by the authenticated user.
*/
if ($_SESSION['authtype'] != 'guest') {
	$wasscalendars = wassCalendar::wlistAllCalendars($_SESSION['authid']);
}
else
	$wasscalendars = array();
foreach ($wasscalendars as $wasscal) {
	if (is_object($wasscal)) { ?>
WASSCalendar.G_ARRCALENDARS.push(new WASSCalendar(<?php echo $wasscal->calendarid; ?>,"<?php echo $wasscal->userid; ?>","<?php echo wassUtil::safeHTML($wasscal->name); ?>","<?php echo wassUtil::safeHTML($wasscal->title); ?>",<?php echo wassUtil::safeHTML($wasscal->group); ?>,"<?php echo wassUtil::safeHTML(wassManager::listActiveManagers($wasscal->calendarid)); ?>"));
<?php }
	} 
?>

document.sUserID = "<?php if ($_SESSION['authtype'] != 'guest') echo $_SESSION['authid'];?>";
document.sAuthType = "<?php echo $_SESSION['authtype'];?>";
//KDC, 9-9-2009. Added new var for guest ID (needed for showing appt info)
document.sGuestID = "<?php echo $_SESSION['authid'];?>";

/* Global Variables */
//document.sDefaultViewSlotSize = "15";
document.sDefaultViewSlotSize = "month"; //KDC, 2-18-2008. New default view is month
document.iViewSlotSize = document.sDefaultViewSlotSize;
document.arrDayTypes = null;

//KDC, 2-18-2008. Updated default times for day view overhaul
document.iDefaultStartHour = 0;
document.iDefaultStartMinutes = 0;
document.iDefaultStartSeconds = 0;
document.iDefaultEndHour = 23;
document.iDefaultEndMinutes = 59;
document.iDefaultEndSeconds = 59;


/* Constants - HTML IDs */
document.c_sSmallCalContainerDivID = "divMenuArea";
document.c_sMainCalContainerDivID = "divMainArea";
document.c_sDayCalTableID = "tblDayView";
document.c_sMonthCalTableID = "tblMonthView";
document.c_sViewsSelectID = "selViews";

/* Defaults - blocks */
// *** PHP *** Put calendar defaults in below //
document.isDefaultBlockRecurring = false;
document.sDefaultBlockTitle = "[New Sign up Block]";
document.sDefaultLocation = "330 Frist Campus Center";
document.iDefaultSlotSize = 15;
document.iDefaultBlockMaxAppts = 0;

document.g_BlockOwnerID = "<?php echo $block_ownerid ?>";

function refreshBlocks() {
	//KDC, 1-28-2009. Added closeMessage to remove the message users get with new calendars after they create a block
	closeMessage("confirm");
	ajax_redrawBlocks(document.iCalendarID,document.dtViewStartTime,document.dtViewEndTime,document.g_BlockOwnerID);
}
function reloadPage() {
	setTimeout("refreshBlocks()",0);
}

/* Initialize the page */
function init() {
	//Reset so that small calendars draw properly
	document.iViewSlotSize = document.sDefaultViewSlotSize;

	//Default the start date/time and end date/time
	var stdt = new Date();
	var enddt = new Date();
	
	//KDC, 1-6-2010.  If date is passed in, go to day view for that date.  Must also pass in "view=day".
	<?php if ($st_dt) { 
	list($yr,$mo,$dt) = explode('-',$st_dt);
	$mo = $mo - 1; ?>
	stdt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,0,0,0);
	enddt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,23,59,59);
	document.iViewSlotSize = "day";	
	<?php } ?>

	//KDC, 4-20-2011.  If block id is passed in, go to that block.
	<?php if ($block_id) { 
		/* Get the block */
		$blk = new wassBlock('load',array('blockid'=>$block_id));
		if ($blk) {
			list($yr,$mo,$dt) = explode('-',$blk->date);
			list($hr,$mn,$sc) = explode(':',$blk->starttime);
			$mo = $mo - 1; ?>
		stdt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,0,0,0);
		enddt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,23,59,59);
		<?php }
		unset($blk); 
		$view = 'day'; ?>
	document.iViewSlotSize = "day";	
	<?php } ?>

	if (document.iViewSlotSize == "week") {
		stdt = calendar.getWeekStart(stdt);
		enddt = calendar.getWeekEnd(stdt,stdt);
	}
	if (document.iViewSlotSize == "month") {
		stdt.setDate(1);
		enddt = new Date(stdt);
		enddt.setDate(calendar.getNumDaysInMonth(enddt.getMonth()+1,enddt.getFullYear()));
	}
<?php if ($st_dt && $st_tm) {
	list($yr,$mo,$dt) = explode('-',$st_dt);
	list($hr,$mn,$sc) = explode(':',$st_tm);
	$mo = $mo - 1;
?>

	stdt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,<?php echo $hr;?>,<?php echo $mn;?>,<?php echo $sc;?>);
<?php } else { ?>
	stdt.setHours(document.iDefaultStartHour);
	stdt.setMinutes(document.iDefaultStartMinutes);
	stdt.setSeconds(document.iDefaultStartSeconds);
<?php } ?>
<?php if ($ed_dt && $ed_tm) {
	list($yr,$mo,$dt) = explode('-',$et_dt);
	list($hr,$mn,$sc) = explode(':',$et_tm);
	$mo = $mo - 1;
?>
	enddt = new Date(<?php echo $yr;?>,<?php echo $mo;?>,<?php echo $dt;?>,<?php echo $hr;?>,<?php echo $mn;?>,<?php echo $sc;?>);
<?php } else { ?>
	enddt.setHours(document.iDefaultEndHour);
	enddt.setMinutes(document.iDefaultEndMinutes);
	enddt.setSeconds(document.iDefaultEndSeconds);
<?php } ?>

	document.dtViewStartTime = new Date(stdt.getTime());
	document.dtViewEndTime = new Date(enddt.getTime());
setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime);

	//Display the main calendar and small calendars
	<?php if ($view) { ?>
	//changeCalDisplayView("<?php echo $view;?>","current",true);
	changeCalDisplayView("<?php echo $view;?>","current");
	<?php } else { ?>
	changeCalDisplayView(document.sDefaultViewSlotSize,"current",true);
	<?php } ?>

	//KDC, 4-29-2009. Multiple calendar title
	if (document.isMultiCalendar) {
		setCalendarTitle("Merged Calendars");
	}
}
var isFocused = false;
function focusWin() {
	//alert(document.g_OpenWin);
	if (!isFocused && document.g_OpenWin != null) {
		alert(document.g_OpenWin);
		document.g_OpenWin.focus();
	}
	isFocused = true;
	// onfocus="if(!isFocused) { focusWin(); }"
}
</script>
</head>

<body onload="initAjax();init();">
<form id="frmViewCal" name="frmViewCal" action="#" method="post" >
<input type="hidden" id="hidPage" name="hidPage" value="viewcalendar" />
<input type="hidden" id="hidPageTitle" name="hidPageTitle" value="View Calendar" />
<input type="hidden" id="hidIsManagerOfThisCal" name="hidIsManagerOfThisCal" value="<?php echo $hidIsManagerOfThisCal;?>" />
<input type="hidden" id="hidIsOwner" name="hidIsOwner" value="<?php echo $hidIsOwner;?>" />
<input type="hidden" id="hidMakeApp" name="hidMakeApp" value="<?php echo $hidMakeApp;?>" />
<input type="hidden" id="hidUCal_id" name="hidUCal_id" value="<?php echo $_SESSION['ucal_id'];?>" />

<input type="hidden" id="hidHasCalendar" name="hidHasCalendar" value="<?php echo $_SESSION['owner'];?>" />
<input type="hidden" id="hidCalOwnerName" name="hidCalOwnerName" value="<?php echo wassUtil::safeHTML($hidCalOwnerName);?>" />
<input type="hidden" id="hidCalTitle" name="hidCalTitle" value="<?php if (sizeof($cals) > 1) echo 'Merged Calendars'; else echo wassUtil::safeHTML($cal->title);?>" />
<input type="hidden" id="hidHaveBlocks" name="hidHaveBlocks" value="<?php echo $hidHaveBlocks;?>" />
<input type="hidden" id="hidHaveApps" name="hidHaveApps" value="<?php echo $hidHaveApps;?>" />

<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $cal_id;?>" />
<input type="hidden" id="block_id" name="block_id" value="<?php echo $block_id;?>" />
<input type="hidden" id="st_dt" name="st_dt" value="<?php echo $st_dt;?>" />
<input type="hidden" id="st_tm" name="st_tm" value="<?php echo $st_tm;?>" />
<input type="hidden" id="ed_dt" name="ed_dt" value="<?php echo $ed_dt;?>" />
<input type="hidden" id="ed_tm" name="ed_tm" value="<?php echo $ed_tm;?>" />
<input type="hidden" id="helptopic" name="helptopic" value="<?php echo wassUtil::safeHTML($HelpTopic);?>" />

<input type="hidden" id="hidContactName" name="hidContactName" value="<?php echo wassParms::CONTACTNAME;?>" />
<input type="hidden" id="hidContactEmail" name="hidContactEmail" value="<?php echo wassParms::CONTACTEMAIL;?>" />
<input type="hidden" id="hidContactPhone" name="hidContactPhone" value="<?php echo wassParms::CONTACTPHONE;?>" />
<input type="hidden" id="hidInsFname" name="hidInsFname" value="<?php echo wassParms::INSFNAME;?>" />
<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<input type="hidden" id="infmsg" name="infmsg" value="<?php echo $infmsg;?>" />
<input type="hidden" id="errmsg" name="errmsg" value="<?php echo $errmsg;?>" />

<input type="hidden" id="blockurl" name="blockurl" value="<?php echo $url;?>" />

<!-- HEADER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/header.js"></script>
<script type="text/javascript" language="javascript" src="js/pageheader.js"></script>
<!-- HEADER - END -->

<div id="content">
<table cellspacing="0" cellpadding="0">
	<tr>
		<td align="left" valign="top" class="menuTD">
			<div id="divMenuArea">
			<!-- MAIN MENU - BEGIN -->
			<script type="text/javascript" language="javascript" src="js/mainmenu.js"></script>
			<!-- MAIN MENU - END -->
			</div>
		</td>
		<td align="left" valign="top">
			<div id="contentDivider">

			<!-- CALENDAR HEADER - BEGIN -->
			<script type="text/javascript" language="javascript" src="js/calendarheader.js"></script>
			<!-- CALENDAR HEADER - END -->

			<!-- CONTENT GOES HERE -->
			<div id="divMainArea">
				<div id="divLoadMsg" style="padding-left:20px; font-size:15px;">Loading...</div>
			</div>
			<!-- END CONTENT -->

			</div>
		</td>
	</tr>
</table>

</div>

<!-- FOOTER - BEGIN -->
<script type="text/javascript" language="javascript" src="js/footer.js"></script>
<!-- FOOTER - END -->

</form>
</body>
</html>


<!--                   End of HTML Code                       -->
<?php
function makeURLHead($cal) {
	
	/* Global the shared variables */
	global $url;
	
	/* Save the protocol prefixes needed for the urls */
	if ($_SERVER['HTTPS']) {
		$urlhead = 'https://';
	}
	else {
		$urlhead = 'http://';
	}
	
	/* Generate and save the subscription and view urls, and get back their redirect ids */
	$fullurl = $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/viewcalendar.page.php?makeapp=1&cal_id=' . $cal->calendarid;
	$url = $fullurl;
	
}
?>
