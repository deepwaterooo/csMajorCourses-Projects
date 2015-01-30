<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu

*/


/*

        This page allows users to create or edit recurring or one-time blocks.
		Notable GET (and POST) Arguments:
			- cal_id: the calendar that the block will be added to/edited on
			- block_id: the block that will be edited (edit only)
			- recur: the recur type to be shown ("once", "instance" or "multiple")

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
	
}

/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();

/* Start session support */
session_start();

/* If not authenticated, send back to authenticate */
wassDirectory::authenticate();

/* Init error/inform messages */
$errmsg = '';  $infmsg = '';  $action = '';  $issuccess = false;

/* Get the calendar and block id, if any */
$cal_id = intval($_REQUEST['cal_id']);
if (!$cal_id)
	$cal_id = intval($_SESSION['cal_id']);

/* Get the block id (if any) */
$block_id = intval($_REQUEST['block_id']);

/* Remember if we are editing or creating */
if ($block_id)
	$action = 'update';
else
	$action = 'create';


/* Set recurrence type of block */
$recur = $_REQUEST['recur'];
if (!$recur)
	$recur = 'once';

if ($recur == 'instance')
	$recur = 'once';

/* Get the start date for "from today onwards" updates */
$fromdate='';
if ($recur == "fromdate") {
	$fromdate = wassSQL::sqlDate($_REQUEST['date']);
	if (!$fromdate)
		$fromdate = date('Y-m-d');
}

/* JJC, hold the recur value */
if ( $recur == 'multiple' || $recur == 'fromdate' )
	$oRecur = 'Recur';
else
	$oRecur = 'OneTime';

/* Get date, starttime, endtime, or set defaults */
$date = $_REQUEST['date'];
if (!$date)
	$date = date('m/d/Y');
$starttime = $_REQUEST['starttime'];
if (!wassUtil::checkTime($starttime))
	$starttime = '';
if ($starttime == '#')
	$starttime = '';
if (!$starttime)
	$starttime = '09:00';
$endtime = $_REQUEST['endtime'];
if (!wassUtil::checkTime($endtime))
	$endtime = '';
If ($endtime == '#')
	$endtime = '';
if (!$endtime)
	$endtime = '14:00';

/* Get the user's calendar */
if (!$cal_id)
	$errmsg = 'No calendarid id passed to block.page.php,';
else {
	try {
		$cal = new wassCalendar('load',array('calendarid'=>$cal_id));
	} catch (Exception $error) {
		$errmsg = $error->getMessage();
	}
}

$slotsize = 15; $slotsizetext = ''; $maxper = 0;

$isslotted = true;
if /* (!$errmsg) */ (true) {

	/* Load block/series (if specified), else build a new one (with defaults set) */
	$block = ''; $series = ''; $period = ''; $periods='';
	if ($block_id) {
		/* We are editing a block or a series */
		try {
			$block = new wassBlock('load',array('blockid'=>$block_id));
			/* Set fields as per this block */
			$date = $block->date;
			$starttime = $block->starttime;
			$endtime = $block->endtime;

			$slotsize = $block->slotsize;
			$isslotted = $block->slotted;

			$maxper = $block->maxper;

			/* If block is part of a series and we are editing the series. */
			if (($block->recurrence == 'multiple') && ($recur == 'multiple' || $recur == 'fromdate')) {
				try {
					$series = new wassSeries('load',array('seriesid'=>$block->seriesid));
					/* Load the period blocks as well, and save them in a simple array. */
					$objperiods = wassPeriod::listMatchingPeriods(array('seriesid'=>$series->seriesid));
					foreach ($objperiods as $period) {
						$periods[] = $period;
					}
				} catch (Exception $error) {
					$errmsg = $error->getMessage();
				}
			}
		} catch (Exception $error) {
			$errmsg = $error->getMessage();
		}
	}
	else {
		/* We are creating a block or series;
		   We create a default block/series/period to show to the user. */
		   
		/* For a group calendar, we use the logged-in ID as the default user; else the calendar owner */
		if ($cal->group)
			$blockuser = $_SESSION['authid'];
		else
			$blockuser = $cal->userid;
		   
		try {
			/* If we are creating a block for a calendar member (not the owner), then we need to fill in the directory fields so that wassBlock does not fill
			   them in using the calendar defaults, which apply to the calendar owner, not the block owner. */
			   
			   /* First, the default fields */
			   $blockdata = array('calendarid'=>$cal->calendarid,'date'=>$date,'starttime'=>$starttime,'endtime'=>$endtime,'userid'=>$blockuser,'makeaccess'=>$cal->makeaccess,'viewaccess'=>$cal->viewaccess,'makeulist'=>$cal->makeulist,'makeclist'=>$cal->makeclist,'viewulist'=>$cal->viewulist,'viewclist'=>$cal->viewclist);
			   
			   /* Now the fields for members of a group calendar */
			   if ($cal->group && !$cal->isOwner($_SESSION['authtype'],$_SESSION['authid'])) {
				   	/* Add in the block owner directory fields */
				   	if ($name=wassDirectory::getName($blockuser))
				   		$blockdata['name'] = $name;
				    if ($email=wassDirectory::getEmail($blockuser))
				   		$blockdata['email'] = $email;
					if ($office=wassDirectory::getOffice($blockuser))
				   		$blockdata['location'] = $office;
					if ($phone=wassDirectory::getPhone($blockuser))
				   		$blockdata['phone'] = $phone;
			   }
			   /* Now create the block */
			   $block = new wassBlock('create',$blockdata);
		} catch (Exception $error) {
			$errmsg = $error->getMessage();
		}
		if (!$errmsg) {
			try {
				$series = new wassSeries('create',array('calendarid'=>$cal->calendarid,'startdate'=>$date,'enddate'=>$date,
'userid'=>$blockuser));
				$period = new wassPeriod('empty',array());
				$period->seriesid = $series->seriesid;
				$period->dayofweek = 'monday';
				$period->dayofmonth = 1;
				$period->weekofmonth = 1;
				$period->starttime = '09:00';
				$period->endtime = '14:00';
				$periods = array($period);
			} catch (Exception $error) {
				$errmsg = $error->getMessage();
			}
		}
	}
}

/* Assume no display URL */
$url = '';

/* Generate URL for displaying block */
if (!$errmsg && $cal_id && $block_id && !$series) {
	/* Generate display URL */
	makeBlockURL($cal,$block);
}


/*
Handle a form submission.
*/
if ($_POST['btnSubmit'] || $_POST['hidSubmitForm'] /* && !$errmsg */ ) {
	 
	/* Make sure user is authorized */
	if ($action == 'update') {
		if (!$block->isOwner($_SESSION['authtype'],$_SESSION['authid']))
			$errmsg = 'You are not authorized to edit this block.';
	}
	else {
		if (!$cal->isOwnerOrManager($_SESSION['authtype'],$_SESSION['authid']))
			$errmsg = 'You are not authorized to add blocks to this calendar.';
	}

	if (!$errmsg) {

		/* If creating/editing a series */
		if ($recur == 'multiple' || $recur == 'fromdate') {

			/* Read common data from the form into our series object (either the new one we created, or the one we are editing). */
			getCommonData($series,$_REQUEST,$action);
			/* Also save in block object, for latter re-display */
			getCommonData($block,$_REQUEST,$action);
		
			/* If creating a series, read series-specific data into the object. */
			if ($action == 'create') {

				$series->startdate = wassSQL::sqlDate(wassUtil::slashstrip($_REQUEST['txtStart_Recur']));
				$series->enddate = wassSQL::sqlDate(wassUtil::slashstrip($_REQUEST['txtEnd_Recur']));
				$series->every = $_REQUEST['selRecur'];
				if (isset($_REQUEST['chkDayType_All']))
					$series->daytypes = wassParms::DAYTYPES;
				else
					$series->daytypes = join(',',$_REQUEST['chkDayType']);
			}

			/* Save number of periods specified. */
			$specperiods = $_REQUEST['hidNumPeriods'] + 1;

			/* Now set the values in the period blocks, either the new ones we create, or the ones we are editing. */
			for ($i=0; $i<$specperiods; $i++) {
				/* Build period variable names */
				if ($i == 0)
					$is = '0';
				else
					$is = (string) $i;
				$shv = "selStartHour" . $is . '_Recur';
				$smv = "selStartMinute" . $is . '_Recur';
				$sav = "selStartAMPM" . $is . '_Recur';
				$ehv = "selEndHour" . $is . '_Recur';
				$emv = "selEndMinute" . $is . '_Recur';
				$eav = "selEndAMPM" . $is . '_Recur';
				$dowv = "selWeeklyRecurDay" . $is;
				$domv = "selMonthlyRecurDay" . $is;
				$womv = "selMonthlyRecurWeek" . $is;
	            $domwv = "selMonthlyRecurWeekDay" . $is;

				/* Test if we are all done with time periods */
				if (!isset($_REQUEST[$shv]))
					break;

				/* If creating a newly specified period, build an object for it */
				if (($action == 'create') && ($i >= count($periods))) {
					$period = new wassPeriod('empty',array());
					$periods[] = $period;
				}

				/* Point to current period */
				$period = $periods[$i];


				/* Save values in period block */
				if ($action == 'create') {
					if ($series->every != 'monthlyweekday')
						$period->dayofweek = $_REQUEST[$dowv];
					else
						$period->dayofweek = $_REQUEST[$domwv];
					$period->dayofmonth = $_REQUEST[$domv];
					$period->weekofmonth = $_REQUEST[$womv];
				}
				$period->starttime = getTime($_REQUEST[$shv],
											 $_REQUEST[$smv],
											 $_REQUEST[$sav]);
				$period->endtime = getTime($_REQUEST[$ehv],
										   $_REQUEST[$emv],
										   $_REQUEST[$eav]);

				/*
				Now validate the period. If updating, we need to go through the constructor routine to perform all checks.
				*/
				if ($action == 'create')
						$errmsg = $period->validate($series);
				else {
					try {
						$newperiod = new wassPeriod('update',get_object_vars($period),$fromdate);
					} catch (Exception $error) {
						$errmsg = $error->getMessage();
					}
				}

			}

			/*
			Now validate the series. If updating, we need to go through the constructor routine to perform all checks.
			*/
			if (!$errmsg) {
				if ($action == 'create')
					$errmsg = $series->validate();
				else {
					try {
						$newseries = new wassSeries('update',get_object_vars($series),$fromdate);
					} catch (Exception $error) {
						$errmsg = $error->getMessage();
					}
				}
			}

			/* If valid, update/create the series data */
			if (!$errmsg) {
				/* Save the series */
				try {
					$seriesid = $series->save($action,$fromdate);
					$series->seriesid = $seriesid;
				} catch (Exception $error) {
					$errmsg = $error->getMessage();
				}
				if (!$errmsg) {
					/* Save the periods */
					try {
						$blockcount = 0;
						reset($periods);
						foreach ($periods as $period) {
							$period->seriesid = $seriesid;
							/* Validate the period data */
							$errmsg = $period->validate($series);
							/* If valid, update/create the period */
							if (!$errmsg) {
								$periodid = $period->save($action,$fromdate);
								$period->periodid = $periodid;
								/* Now build the blocks */
								if ($action == 'create') {
									$serrmsg = $series->buildblocks($period);
									if (is_int($serrmsg))
										$blockcount += $serrmsg;
									else
										$errmsg .= $serrmsg . '; ';
								}
							}
						}
					} catch (Exception $error) {
						$errmsg = $error->getMessage();
					}
					if ($errmsg && ($action == 'create')) {
						if (is_object($series))
							$series->delete();
					}
				}

				if (!$errmsg) {
					/* Update variables that track block/series status */
					if (is_object($series)) {
							$slotsize = $series->slotsize;
					}
					if ($action == 'create') {
						if ($blockcount > 0) {
							$infmsg = $blockcount . ' block(s) created.  You may create additional blocks, or close this window if you are done.';
							if ($block->showappinfo)
								$infmsg .= ' Note: these blocks have "Show Appointment Details" turned on.';
							$issuccess = true;
						}
						else {
							/* We want to let the user know that they may not have gotten any blocks if they did not have all daytypes selected, */
							if (count(explode(',',$series->daytypes)) != count(explode(',',wassParms::DAYTYPES)))
								$errmsg = 'No blocks created. Make sure you have checked off the appropriate day types, then retry.';
							else
								$errmsg = 'No blocks created.  You may retry, or close this window if you are done creating blocks.';
							if (is_object($series))
								$series->delete();
							$issuccess = false;
						}
					}
					else {
						$infmsg = 'Block(s) updated.   You may make additional changes, or close this window if you are done.';
						$issuccess = true;
					}
				}
			}
		}
		/* If creating/editing a block */
		else {
			 
			/* Read common block data from the form */
			getCommonData($block,$_REQUEST,$action);
		
			/* Now read the one-time data */
			if ($action == 'create')
				$block->date = wassSQL::sqlDate(wassUtil::slashstrip($_REQUEST['txtStart_OneTime']));

			/* Save start and end time */
			$block->starttime = getTime($_REQUEST['selStartHour_OneTime'],
									$_REQUEST['selStartMinute_OneTime'],
									$_REQUEST['selStartAMPM_OneTime']);
			$block->endtime = getTime($_REQUEST['selEndHour_OneTime'],
									$_REQUEST['selEndMinute_OneTime'],
									$_REQUEST['selEndAMPM_OneTime']);
			/*
			Now validate the block. If updating, we need to go through the constructor routine to perform all checks.
			*/
			if ($action == 'create')
				$errmsg = $block->validate();
			else {
				try {
					$newblock = new wassBlock('update',get_object_vars($block));
				} catch (Exception $error) {
					$errmsg = $error->getMessage();
				}
			}

			/* If valid, update/create the block */
			if (!$errmsg) {
				try {
					$block->save($action);
					$issuccess = true;
					/* Update variables that track block/series status */
					$slotsize = $block->slotsize;
					/* Let user know what has happened */
					if ($action == 'create') {
						$infmsg = 'Block created.  You may create additional blocks, or close this window if you are done.';
						if ($block->showappinfo)
								$infmsg .= ' Note: this block has "Show Appointment Details" turned on.';
					}
					else
						$infmsg = 'Block updated.  You may make additional changes, or close this window if you are done.';

					/* Generate display URLs */
					makeBlockURL($cal,$block);


				} catch (Exception $error) {
					$errmsg = $error->getMessage();
				}
			}
		}
	}
}

/* Read common block/series data from form and save in passed object */
function getCommonData($ob,$arr,$action) {
	
	global $maxper, $slotsize, $slotsizetext;
	
	if (array_key_exists('selNetid',$arr)) {
		list($userid,$rest)= explode(' ',$arr['selNetid']);
		$ob->userid = $userid;
	}
	$ob->title = wassUtil::slashstrip($arr['txtTitle']);
	$ob->name = wassUtil::slashstrip($arr['txtOwner']);
	$ob->email = wassUtil::slashstrip($arr['txtEmail']);
	$ob->location = wassUtil::slashstrip($arr['txtLocation']);
	$ob->phone = wassUtil::slashstrip($arr['txtPhone']);
	$ob->description = wassUtil::slashstrip($arr['txtDesc']);
	$ob->appmsg = wassUtil::slashstrip($arr['txtApptext']);
	$ob->deadline = wassUtil::slashstrip($arr['txtDeadline']);
	$ob->candeadline = wassUtil::slashstrip($arr['txtCanDeadline']);
	$ob->opening = wassUtil::slashstrip($arr['txtOpening']);

	if (array_key_exists('selTimeSlots',$arr)) $ob->slotted = ($arr['selTimeSlots'] == 0) ? 0 : 1;


	/* Set the maximum appointment limit for unslotted blocks */
	if (!$ob->slotted) {
		$ob->slotsize = 0;  /*KDC, 11-13-2008. Added to allow slotted to unslotted*/
		if  ($arr['radMaxAppts'] == 1)
			$ob->maxapps = wassUtil::slashstrip($arr['txtMaxAppts']);
		else
			$ob->maxapps = 0;
	}
	else {
		if (($arr['txtSlotSize']) && is_numeric($arr['txtSlotSize']))
			$ob->slotsize = wassUtil::slashstrip($arr['txtSlotSize']);
		else
			$ob->slotsize = $arr['selTimeSlots'];
		$slotsize = $ob->slotsize;
		$slotsizetext = wassUtil::slashstrip($arr['txtSlotSize']);
	}

	$ob->maxper = wassUtil::slashstrip($arr['selMaxPerPerson']);
	$maxper = $ob->maxper;

	$ob->remind = (isset($arr['chkRemind'])) ? 1 : 0;
	$ob->remindman = (isset($arr['chkRemindMan'])) ? 1 : 0;
	$ob->notify = (isset($arr['chkNotifyMe'])) ? 1 : 0;
	$ob->notifyman = (isset($arr['chkNotifyMgrs'])) ? 1 : 0;
	$ob->showappinfo = (isset($arr['chkShowAppInfo'])) ? 1 : 0;
	$ob->purreq = (isset($arr['chkReqPurpose'])) ? 1 : 0;
	/*$ob->available = 1;*/
	$ob->available = wassUtil::slashstrip($arr['hidAvailable']);
	$ob->makeaccess = wassUtil::slashstrip($arr['selMakeApptRestr']);
	$ob->viewaccess = wassUtil::slashstrip($arr['selViewBlockRestr']);
	$ob->makeulist = wassUtil::slashstrip(@join(',',$arr['selMakeApptUserIDList']));
	$ob->makeclist = wassUtil::slashstrip(@join(',',$arr['selMakeApptCourseIDList']));
	$ob->viewulist = wassUtil::slashstrip(@join(',',$arr['selViewBlocksUserIDList']));
	$ob->viewclist = wassUtil::slashstrip(@join(',',$arr['selViewBlocksCourseIDList']));
}

function getTime($h,$m,$ap) {
	if ($ap == 'PM' && $h < 12)
		$h +=12;
	return sprintf('%02d',intval($h)) . ':' . sprintf('%02d',intval($m));
}

/*
Now display the page.
*/
?>
<!--                   Start of HTML Code                     -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><?php echo wassParms::SYSID;?></title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript" src="js/block.js"></script>
<script type="text/javascript" language="javascript" src="js/appointment.js"></script>
<script type="text/javascript" language="javascript" src="js/ajax.js"></script>
<script type="text/javascript" language="javascript">

document.g_sID = "<?php echo session_id();?>"; //"" if null
document.g_sysID = "<?php echo wassParms::SYSID;?>";
document.g_isAuth = <?php echo ($_SESSION['authenticated']) ? 'true' : 'false';?>;
document.g_sHomeLink = "<?php echo wassParms::INSHOMELINK;?>";
document.g_sHomeLogo = "<?php echo wassParms::INSHOMELOGO;?>";

document.g_isEditing = false;
document.g_iOrigNumTimePeriods = 0;
document.g_iNumTimePeriods = 0;
document.g_sOrigSlotSize = 0;
document.g_sCurrentSlotSize = 0;
function init() {

	//Set up One-time vs. recurring
	var recurtype = GetElement("recur").value;
	var rectype = recurtype == "once" ? "OneTime" : "Recur";

	changeSection(rectype,recurtype);

	resetForm();

	//populate timeslots
	ajax_getAllViews(); //call ajax, which calls updateViewList

	document.g_iOrigNumTimePeriods = resetTimePeriods();

	var blkID = GetElement("block_id").value;
	if (blkID != "") {
		ajax_getAppointments(new Array(blkID));
	}

	//KDC, 5/22/2011.
	convertMintoDHM(<?php echo $block->opening;?>,"txtOpeningDays","txtOpeningHours","txtOpeningMins");
	convertMintoDHM(<?php echo $block->deadline;?>,"txtDeadlineDays","txtDeadlineHours","txtDeadlineMins");
	convertMintoDHM(<?php echo $block->candeadline;?>,"txtCanDeadlineDays","txtCanDeadlineHours","txtCanDeadlineMins");
	
	//KDC, 2/12/2010.
	notifyUserSchedOpen();
	notifyUserSchedDeadline();
	notifyUserCanDeadline();

	var elFirst = GetElement("txtTitle");
	if (elFirst != null)
		elFirst.focus();
}
function closeAndRefreshOpener() {
	window.opener.reloadPage();

	//KDC, 4-11-2008.
	//self.close();
}
/* overwrite ajax show function */
function show_getAppointments(arrApptIDs) {
	displayEditFields(arrApptIDs.length, GetElement("recur").value);
}

function initForm() {
	//Set up Time Slot/Max appointments
<?php
	try { $slotsize = $slotsize*1; } catch ( Exception $e ) { $slotsize = 15; }
?>
	document.g_sOrigSlotSize = <?php echo $slotsize?>;
	document.g_sCurrentSlotSize = <?php echo $slotsize?>;

	setDurationVals(document.g_sShownSection,60,"0");
	changeEnd(document.g_sShownSection,"0");
	changeDuration(document.g_sShownSection,"0");
	onchangeTimeSlots();
	//alert( "initF," + document.g_sShownSection );
	setMaxAppts(document.g_sShownSection);

	//Set up advanced options section
	ShowHideSection('divAdvancedOptions','hide','linkShowAdv','linkHideAdv','showhide');
}
function removeTimePeriods() {
	var elTimePeriods = GetElement("divTimePeriods");
	if (elTimePeriods != null) {
		elTimePeriods.innerHTML = "";
		GetElement("selRecur").disabled = false;
		document.g_iNumTimePeriods = 0;
	}
}
//returns the number of time periods created
function resetTimePeriods() {
//alert("before:" + document.g_iOrigNumTimePeriods + "," + document.g_iNumTimePeriods);
	if (document.g_iOrigNumTimePeriods <= document.g_iNumTimePeriods) {
		removeTimePeriods();
//alert("removed:" + document.g_iOrigNumTimePeriods + "," + document.g_iNumTimePeriods);

	}

	<?php

	/*
	Here begins the iterated code for each period (only 1 initially if creating a new series).
	*/
	$c = 0;
	if (is_object($series)) {
		foreach ($periods as $period) {?>
			addTimePeriod_Times(<?php echo '"' . $series->every . '"';?>,<?php if ($series->every == 'monthlyday') echo '"' . $period->dayofmonth . '"';
					elseif ($series->every == 'weekly' || $series->every == 'otherweekly') echo '"' . $period->dayofweek . '"';
					elseif ($series->every == 'monthlyweekday') echo $period->weekofmonth;
					else echo 'null';?>,<?php if ($series->every == 'monthlyweekday') echo '"' . $period->dayofweeek . '"';
					else echo 'null';?>,<?php echo '"' . substr($period->starttime,0,2) . '"';?>,<?php echo '"' . substr($period->starttime,3,2) . '"';?>,<?php echo '"' . substr($period->endtime,0,2) . '"';?>,<?php echo '"' . substr($period->endtime,3,2) . '"';?>);<?php
		}
		echo 'onchangeRecur();';
		$c = $c + 1;
	}
	?>
	if (document.g_isEditing) {
		displayEditFields(0, GetElement("recur").value); //KDC, 2-13-2008. Need to replace 0 once PHP functionality is in place
	}
	return <?php echo $c;?>;
}
function resetTextToOrig() {
	//top section
	GetElement("txtTitle").value = GetElement("hidOrigTitle").value;
	GetElement("txtOwner").value = GetElement("hidOrigOwner").value;
	GetElement("txtEmail").value = GetElement("hidOrigEmail").value;
	GetElement("txtPhone").value = GetElement("hidOrigPhone").value;
	GetElement("txtDesc").value = GetElement("hidOrigDesc").value;
	GetElement("txtAppText").value = GetElement("hidOrigAppText").value;
	GetElement("txtLocation").value = GetElement("hidOrigLocation").value;

	//dates and times
	GetElement("txtStart_OneTime").value = GetElement("hidStart_OneTime").value;
	GetElement("txtStart_Recur").value = GetElement("hidStart_Recur").value;
	GetElement("txtEnd_Recur").value = GetElement("hidEnd_Recur").value;
	var opts = GetElement("selStartHour0_OneTime").options;
	for (var i=0; i < opts.length; i++) {
		if (opts[i].value == eval(GetElement("hidStartHour0_OneTime").value))
			opts[i].selected = "selected";
	}
	opts = GetElement("selStartMinute0_OneTime").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == eval(GetElement("hidStartMinute0_OneTime").value))
			opts[i].selected = "selected";
	}
	opts = GetElement("selStartAMPM0_OneTime").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == GetElement("hidStartAMPM0_OneTime").value)
			opts[i].selected = "selected";
	}
	opts = GetElement("selEndHour0_OneTime").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == eval(GetElement("hidEndHour0_OneTime").value))
			opts[i].selected = "selected";
	}
	opts = GetElement("selEndMinute0_OneTime").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == eval(GetElement("hidEndMinute0_OneTime").value)) {
			opts[i].selected = "selected";
		}
	}
	opts = GetElement("selEndAMPM0_OneTime").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == GetElement("hidEndAMPM0_OneTime").value)
			opts[i].selected = "selected";
	}
	updateDuration("OneTime",0);

	//alert("resetting time periods");
	opts = GetElement("selRecur").options;
	for (i=0; i < opts.length; i++) {
		if (opts[i].value == GetElement("hidRecur").value)
			opts[i].selected = "selected";
	}
	resetTimePeriods();

	//day type
	var setdays = new Array(
<?php
	$c = 0;
	$daytypes = explode(',',wassParms::DAYTYPES);
	if ($action == 'update')
		$setdays = explode(',',$series->daytypes);
	else
		$setdays = explode(',',wassParms::DAYTYPES);
	foreach ($daytypes as $daytype) {
		if (in_array($daytype,$setdays)) {
			if ($c != 0) echo ",";
			else $c = 1;
			echo "'" . $daytype . "'";
		}
	}
?>
	);
	//KDC, 4-23-2011.
<?php if (sizeof($daytypes) == sizeof($setdays)) { ?>
	var areAllDaysChecked = true;
<?php } else { ?>
	var areAllDaysChecked = false;
<?php } ?>
	if (areAllDaysChecked) {
		GetElement("chkDayType_All").checked = "checked";
	}
	
	var days = document.getElementsByName("chkDayType[]");
	for (var i=0; i < days.length; i++) {
		if (setdays.join("|").indexOf(days[i].value) != -1)
			days[i].checked = "checked";
		else
			days[i].checked = "";
	}

	//bottom section
	//appt slot size, max appts taken care of elsewhere
	GetElement("txtDeadline").value = GetElement("hidOrigDeadline").value;
	GetElement("txtCanDeadline").value = GetElement("hidOrigCanDeadline").value;
	GetElement("txtOpening").value = GetElement("hidOrigOpening").value;
	//KDC, 5/22/2011.
	convertMintoDHM(GetElement("txtOpening").value,"txtOpeningDays","txtOpeningHours","txtOpeningMins");
	convertMintoDHM(GetElement("txtDeadline").value,"txtDeadlineDays","txtDeadlineHours","txtDeadlineMins");
	convertMintoDHM(GetElement("txtCanDeadline").value,"txtCanDeadlineDays","txtCanDeadlineHours","txtCanDeadlineMins");
	if (eval(GetElement("hidOrigRemind").value))
		GetElement("chkRemind").checked = "checked";
	else GetElement("chkRemind").checked = "";
	if (eval(GetElement("hidOrigRemindMan").value))
		GetElement("chkRemindMan").checked = "checked";
	else GetElement("chkRemindMan").checked = "";
	if (eval(GetElement("hidOrigShowAppInfo").value))
		GetElement("chkShowAppInfo").checked = "checked";
	else GetElement("chkShowAppInfo").checked = "";
	if (eval(GetElement("hidOrigNotifyMe").value))
		GetElement("chkNotifyMe").checked = "checked";
	else GetElement("chkNotifyMe").checked = "";
	if (eval(GetElement("hidOrigNotifyMgrs").value))
		GetElement("chkNotifyMgrs").checked = "checked";
	else GetElement("chkNotifyMgrs").checked = "";
	if (eval(GetElement("hidOrigReqPurpose").value))
		GetElement("chkReqPurpose").checked = "checked";
	else GetElement("chkReqPurpose").checked = "";
	
}
//KDC, 9-3-2008. For selecting the "reset" value of the access type lists.  Must change if list values change.
function selectAccessType(inType,inSelListID) {
	var ind = 0;
	var sel = GetElement(inSelListID);
	switch(inType) {
		case "open":
			ind = 0;
			break;
		case "limited":
			ind = 1;
			break;
		case "restricted":
			ind = 2;
			break;
		case "private":
			ind = 3;
			break;
		default:
			ind = 0;
	}
	sel.selectedIndex = ind;
}
function resetForm() {
	//alert( "resetForm," + document.g_sShownSection );
	initForm();

	ResetList("selViewBlocksUserIDList[]");
	ResetList("selViewBlocksCourseIDList[]");
	ResetList("selMakeApptUserIDList[]");
	ResetList("selMakeApptCourseIDList[]");

	selectAccessType("<?php echo $block->viewaccess ?>","selViewBlockRestr");
	selectAccessType("<?php echo $block->makeaccess ?>","selMakeApptRestr");

	//KDC, 9/3/2008. Add Users and Courses to lists in Advanced section
<?php
	if ($block->viewaccess == 'restricted') {
		$vulistarr = array();
		if ($block->viewulist) $vulistarr = explode(",",$block->viewulist);
		for ($i = 0; $i < sizeof($vulistarr); $i++) { ?>
	AddValueToList("<?php echo $vulistarr[$i] ?>","selViewBlocksUserIDList[]");
	<?php }
		$vclistarr = array();
		if ($block->viewclist) $vclistarr = explode(",",$block->viewclist);
		for ($i = 0; $i < sizeof($vclistarr); $i++) { ?>
	AddValueToList("<?php echo $vclistarr[$i] ?>","selViewBlocksCourseIDList[]");
	<?php }
	}

	if ($block->makeaccess == 'restricted') {
		$mulistarr = array();
		if ($block->makeulist) $mulistarr = explode(",",$block->makeulist);
		for ($i = 0; $i < sizeof($mulistarr); $i++) { ?>
	AddValueToList("<?php echo $mulistarr[$i] ?>","selMakeApptUserIDList[]");
	<?php }
		$mclistarr = array();
		if ($block->makeclist) $mclistarr = explode(",",$block->makeclist);
		for ($i = 0; $i < sizeof($mclistarr); $i++) { ?>
	AddValueToList("<?php echo $mclistarr[$i] ?>","selMakeApptCourseIDList[]");
	<?php }
	} ?>

	onchangeAdvBlocks();
	onchangeAdvAppts();

	resetTextToOrig();
}
//KDC, 9/3/2008. Added same code from calendarsetup page to validate user and course.
var g_sTextID = "";
var g_sListID = "";
function doValidateUser(inTextID,inListID) {
	g_sTextID = inTextID;
	g_sListID = inListID;
	var arrUsers = new Array();
	var sUser = GetElement(g_sTextID).value;
	if (sUser != "") arrUsers.push(sUser);
	ajax_validateUsers(arrUsers);
}
/* overwrite ajax show function */
function show_validateUsers(arrValidUsers) {
	if (arrValidUsers.length == 0)
		alert("Invalid User");
	else
		AddItemToList(g_sTextID,g_sListID);
	GetElement(g_sTextID).select();
}
function doValidateCourse(inTextID,inListID) {
	g_sTextID = inTextID;
	g_sListID = inListID;
	var arrCourses = new Array();
	var sCourse = GetElement(g_sTextID).value;
	if (sCourse != "") arrCourses.push(sCourse);
	ajax_validateCourses(arrCourses);
}
/* overwrite ajax show function */
function show_validateCourses(arrValidCourses) {
	if (arrValidCourses.length == 0)
		alert("Invalid Course");
	else
		AddItemToList(g_sTextID,g_sListID);
	GetElement(g_sTextID).select();
}

function changeSection(inSection,inRecurType) { //inSection can be OneTime or Recur
	var showhide = "show";
	var recurtype = inRecurType;
	if (inSection == "Recur") {
		showhide = "hide";
		//recurtype = "multiple";
	}
	ToggleTwoSections('divOneTime','divRecurring',showhide,'linkOneTime','linkRecurring','showhide');
	document.g_sShownSection = inSection;
	GetElement("recur").value = recurtype;

	if (inSection == "Recur")
		onchangeRecur();

	initForm();
}

/************************************/
/* show_getAllViews (overwrite)	*/
/************************************/
/* overwrite AJAX show function */
function show_getAllViews(sViews) {
	var arrViews = parseTimeSlotSizes(sViews);
	updateViewList(arrViews);
}
document.g_ValidViews = new Array(); //for keeping track of all available time slot values
function updateViewList(inSlotSizeArray) {
	for (var i=0; i < inSlotSizeArray.length; i++) {
		document.g_ValidViews.push(inSlotSizeArray[i]);
	}
	setTimeSlots(document.g_ValidViews);
	//KDC, 7-7-2008. Added 3 lines below because slot sizes weren't correct on load of form
	var recurtype = GetElement("recur").value;
	if (recurtype == "once") recurtype = "OneTime";
	updateSlotSizes(recurtype);
}
//update the appointment slot sizes based on block duration
function updateSlotSizes(inRecurType) {
	//get duration(s)
	var arrDurations = new Array();
	var dur = GetElement("selDuration0_" + inRecurType);
	if (dur != null)
		arrDurations.push(dur.value);
	if (inRecurType == "Recur") {
		for (var i=1; i < document.g_iNumTimePeriods; i++) {
			dur = GetElement("selDuration" + i + "_" + inRecurType);
			if (dur != null)
				arrDurations.push(dur.value);
		}
	}

	var arrSlots = new Array();
	for (var i=0; i < document.g_ValidViews.length; i++) {
		var isSlotElig = true;
		for (var j=0; j < arrDurations.length; j++) {
		//alert(arrDurations[j] + "," + document.g_ValidViews[i]);
			if (arrDurations[j] % document.g_ValidViews[i] > 0)
				isSlotElig = false;
		}
		if (isSlotElig)
			arrSlots.push(document.g_ValidViews[i]);
	}
	setTimeSlots(arrSlots);

}
function setTimeSlots(inSlotSizeArray) {
	var sel = GetElement("selTimeSlots");
	sel.options.length = 0;
	var ind = 0;
		sel.options[ind] = new Option("none",0);
		ind += 1;
		for (var i=0; i < inSlotSizeArray.length; i++) {
			sel.options[ind] = new Option(inSlotSizeArray[i],inSlotSizeArray[i]);
			if (inSlotSizeArray[i] == document.g_sCurrentSlotSize) {
				sel.options[ind].selected = true;
			}
			ind += 1;
		}
	//KDC, 1-28-2009. If the old slot size was not none (slotted), and the new is none (unslotted), make it the smallest slotted size
	if (document.g_sCurrentSlotSize > 0 && sel.options[sel.selectedIndex].value == 0) {
		if (sel.options[1] != null) {
			sel.options[1].selected = true;
		}
	}
	onchangeTimeSlots();
	setMaxAppts(document.g_sShownSection);
}
function setMaxAppts(inRecurType) {
	if (GetElement("selDuration0_" + inRecurType) == null) return;
	var durval = GetElement("selDuration0_" + inRecurType).value;
	var selslots = GetElement("selTimeSlots");
	var slotsize = selslots.options[selslots.selectedIndex].value;
	var numappts = 0;
	if (slotsize != 0) numappts = durval/slotsize;

	var sel = GetElement("selMaxPerPerson");
	sel.options.length = 0;
	sel.options[0] = new Option("no limit",0);
	for (var i=0; i < numappts; i++)
	{
		sel.options[i+1] = new Option(i+1,i+1);
		//<?php echo $_REQUEST['selMaxPerPerson']; ?>
		//test
		<?php
			try { $maxper = $maxper*1; } catch ( Exception $e ) { $maxper = 0; }
		?>
		if ( (i+1) == <?php echo $maxper?> )
			sel.options[i+1].selected = true;
	}
}

document.g_arrDurationVals = new Array(0,5,10,15,20,25,30,35,40,45,50,55,60,90,120,150,180,210,240,270,300,360,420,480);
//KDC, 2-20-2008. Need to allow users to give any minutes (not just limited to the 5-min increment).
function setMinuteLists(inRecurType,inNum,inIsChecked) {
	var sStMinID = "selStartMinute" + inNum + "_" + inRecurType;
	var sEdMinID = "selEndMinute" + inNum + "_" + inRecurType;
	var indSelStMin = GetElement(sStMinID).selectedIndex;
	var indSelEdMin = GetElement(sEdMinID).selectedIndex;
	var incr = 5;
	if (inIsChecked) {
		incr = 1;
		//was in 5-min, going to 1-min
		indSelStMin = indSelStMin * 5;
		indSelEdMin = indSelEdMin * 5;
	} else {
		//was in 1-min, going to 5-min
		if (indSelStMin % 5 == 0) indSelStMin = indSelStMin / 5;
		else indSelStMin = 0;
		if (indSelEdMin % 5 == 0) indSelEdMin = indSelEdMin / 5;
		else indSelEdMin = 0;
	}
	setMinuteList(sStMinID,incr,indSelStMin);
	setMinuteList(sEdMinID,incr,indSelEdMin);
	updateDuration(inRecurType,inNum);
}
function setMinuteList(inID,inIncr,inSelIndex) {
	var elSel = GetElement(inID);
	var iIncr = inIncr;
	var cLastMinute = 59;
	var numIter = cLastMinute/iIncr;
	elSel.options.length = 0;
	for (var i=0; i <= numIter; i++) {
		var mins = eval(i*iIncr) + "";
		var minshow = mins;
		if (minshow.length < 2) minshow = "0" + minshow;
		elSel.options[i] = new Option(minshow,mins);
	}
	if (inSelIndex == undefined || inSelIndex == null) inSelIndex = 0;
	elSel.options[inSelIndex].selected = true;
}
function getDisplayMinutes(inMinutes) {
	var strDisplay = "";
	if (inMinutes < 60) {
		strDisplay = "" + inMinutes;
		if (strDisplay.length < 2) strDisplay = "0" + strDisplay;
		strDisplay += " minutes";
	} else { //hours
		var hrs = Math.floor(inMinutes / 60);
		var mins = (inMinutes % 60) + "";
		if (mins.length < 2) mins = "0" + mins;
		strDisplay = hrs + ":" + mins;
		if (hrs == 1 && mins == "00")
			strDisplay += " hour";
		else
			strDisplay += " hours";
	}
	return strDisplay;
}
function setDurationVals(inRecurType,inSelected,inNum) {
	var sel = GetElement("selDuration" + inNum + "_" + inRecurType);
	if (sel == null) return;
	sel.options.length = 0;
	var lastval = 0;
	var ind = 0;
	for (var i=0; i < document.g_arrDurationVals.length; i++) {
		if (lastval < inSelected && inSelected < document.g_arrDurationVals[i]) {
			sel.options[ind] = new Option(getDisplayMinutes(inSelected),inSelected);
			sel.options[ind].selected = true;
			ind++;
		}
		sel.options[ind] = new Option(getDisplayMinutes(document.g_arrDurationVals[i]),document.g_arrDurationVals[i]);
		if (sel.options[ind].value == inSelected) {
			sel.options[ind].selected = true;
		}
		lastval = document.g_arrDurationVals[i];
		ind++;
	}
	if (inSelected > lastval) {
		sel.options[ind] = new Option(getDisplayMinutes(inSelected),inSelected);
		sel.options[ind].selected = true;
	}
}

//Start Time, End Time, Duration updates
function getStartTime(inRecurType,inNum) {
	var dt_st = GetElement("txtStart_" + inRecurType).value;
	var dtStart = new Date();
		if (dt_st != null && dt_st != "")
			dtStart = GetDateFromDisplay(dt_st);
		if (GetElement("selStartHour" + inNum + "_" + inRecurType) == null) return dtStart;
		var h_st = GetElement("selStartHour" + inNum + "_" + inRecurType).value;
		var m_st = GetElement("selStartMinute" + inNum + "_" + inRecurType).value;
		var ampm_st = GetElement("selStartAMPM" + inNum + "_" + inRecurType).value;
		if (ampm_st == "PM" && h_st != 12)
			h_st = eval(h_st) + 12;
		dtStart.setHours(h_st);
		dtStart.setMinutes(m_st);
		dtStart.setSeconds(0);
	return dtStart;
}
function setStartTime(inRecurType,inNum,inTime) {
	if (GetElement("selStartHour" + inNum + "_" + inRecurType) != null) {
		var hrs = inTime.getHours();
		var ampm = "AM";
		if (hrs > 12) {
			hrs = hrs - 12;
			ampm = "PM";
		}
		if (hrs == 12) ampm = "PM";
		GetElement("selStartHour" + inNum + "_" + inRecurType).value = hrs;
		GetElement("selStartMinute" + inNum + "_" + inRecurType).value = inTime.getMinutes();
		GetElement("selStartAMPM" + inNum + "_" + inRecurType).value = ampm;
	}
}
function getEndTime(inRecurType,inNum) {
	var dt_ed = GetElement("txtStart_" + inRecurType).value;
/*	if (inRecurType == "Recur")
		dt_ed = GetElement("txtEnd_" + inRecurType).value;*/
	var dtEnd = new Date();
	if (GetElement("selEndHour" + inNum + "_" + inRecurType) != null) {
		if (dt_ed != null && dt_ed != "")
			dtEnd = GetDateFromDisplay(dt_ed);
		//alert( "selEndHour" + inNum + "_" + inRecurType );
		var h_ed = GetElement("selEndHour" + inNum + "_" + inRecurType).value;
		var m_ed = GetElement("selEndMinute" + inNum + "_" + inRecurType).value;
		var ampm_ed = GetElement("selEndAMPM" + inNum + "_" + inRecurType).value;
		if (ampm_ed == "PM" && h_ed != 12)
			h_ed = eval(h_ed) + 12;
		dtEnd.setHours(h_ed);
		dtEnd.setMinutes(m_ed);
		dtEnd.setSeconds(0);
	}
	return dtEnd;
}
function setEndTime(inRecurType,inNum,inTime) {
	if (GetElement("selEndHour" + inNum + "_" + inRecurType) != null) {
		var hrs = inTime.getHours();
		var ampm = "AM";
		if (hrs > 12) {
			hrs = hrs - 12;
			ampm = "PM";
		}
		if (hrs == 12) ampm = "PM";
		GetElement("selEndHour" + inNum + "_" + inRecurType).value = hrs;
		GetElement("selEndMinute" + inNum + "_" + inRecurType).value = inTime.getMinutes();
		GetElement("selEndAMPM" + inNum + "_" + inRecurType).value = ampm;
	}
}
function updateDuration(inRecurType,inNum) {
	var dtStart = getStartTime(inRecurType,inNum);
	var dtEnd = getEndTime(inRecurType,inNum);

	var durval = Math.round((dtEnd.getTime() - dtStart.getTime()) / (1000*60));
	if (durval < 0) durval = 0;
	setDurationVals(inRecurType,durval,inNum);
}
function updateEndTime(inRecurType,inNum) {
	var dtStart = getStartTime(inRecurType,inNum);
	if (GetElement("selDuration" + inNum + "_" + inRecurType) == null) return;
	var dur = GetElement("selDuration" + inNum + "_" + inRecurType).value;
	var etval = Math.round((dtStart.getMinutes() + eval(dur)));

	var dtEnd = new Date(dtStart.getTime());
	dtEnd.setMinutes(etval);
	setEndTime(inRecurType,inNum,dtEnd);
}
/* Called on the change of selStartTime */
function changeStart(inRecurType,inNum) {
	//KDC, 8-26-2008. Removing code to automatically update the end time when the start time changes, per Serge's request
/*
	//KDC,2-8-2008. Added below to make end time be ahead of start time chosen
	var dtStart = getStartTime(inRecurType,inNum);
	var dtEnd = getEndTime(inRecurType,inNum);
	//if start time is bigger or equal to end time, add 1 to hour to end (from start) as per request
	if (dtStart.getTime() >= dtEnd.getTime()) {
		dtEnd = new Date(dtStart.getTime());
		if (dtEnd.getHours() <= 23) dtEnd.setHours(dtEnd.getHours() + 1);
		else dtStart.setHours(23);
		setEndTime(inRecurType,inNum,dtEnd);
	}
	//otherwise, end time stays the same
*/
	updateDuration(inRecurType,inNum);
	updateSlotSizes(inRecurType);
	setMaxAppts(inRecurType);
}
/* Called on the change of selEndTime */
function changeEnd(inRecurType,inNum) {
	//KDC, 8-26-2008. Removing code to automatically update the end time when the start time changes, per Serge's request
/*
	//KDC,2-8-2008. Added below to make end time be ahead of start time chosen
	var dtStart = getStartTime(inRecurType,inNum);
	var dtEnd = getEndTime(inRecurType,inNum);
	//if start time is bigger or equal to end time, subtract 1 to hour to start (from end) as per request
	if (dtStart.getTime() >= dtEnd.getTime()) {
		dtStart = new Date(dtEnd.getTime());
		if (dtStart.getHours() > 1) dtStart.setHours(dtStart.getHours() - 1);
		else dtStart.setHours(1);
		setStartTime(inRecurType,inNum,dtStart);
	}
	//otherwise, start time stays the same
*/
	updateDuration(inRecurType,inNum);
	updateSlotSizes(inRecurType);
	setMaxAppts(inRecurType);
}
/* Called on the change of selDuration */
function changeDuration(inRecurType,inNum) {
	//start time stays the same
	updateEndTime(inRecurType,inNum);
	updateSlotSizes(inRecurType);
	setMaxAppts(inRecurType);
}

var txtTitleDef = "<?php echo wassUtil::safeHTML($block->title);?>";
var txtOwnerDef = "<?php echo wassUtil::safeHTML($block->name);?>";
var txtEmailDef = "<?php echo wassUtil::safeHTML($block->email);?>";

<?php
echo 'var txtStart_'.$oRecur.'Def = "'.wassUtil::usDate($block->date).'";';
echo 'var txtEnd_'.$oRecur.'Def = "'.wassUtil::usDate($block->date).'";';
?>

//KDC, 9-23-2010. Validate email address
var isValidating = false;
var isSubmitting = false;
function doSubmitPrep() {
	validateForm();
}
function validateEmail() {
	doValidateEmail();
}

function validateForm() {
	//Check for required fields
	var strReqdMsg = "Please enter the following required information: \n";
	var strReqdFields = "";
	//Calendar Title
	if (isBlankField("txtTitle"))
	{
		strReqdFields = addToMessage(strReqdFields,"Block Title, setting to default");
		document.forms[0].txtTitle.value=txtTitleDef;
	}
	//Block Owner's Name
	if (isBlankField("txtOwner"))
	{
		strReqdFields = addToMessage(strReqdFields,"Name, setting to default");
		document.forms[0].txtOwner.value=txtOwnerDef;
	}
	//Email
	if (isBlankField("txtEmail"))
	{
		strReqdFields = addToMessage(strReqdFields,"Email, setting to default");
		document.forms[0].txtEmail.value=txtEmailDef;
	}
	//If One-Time
	var recurtype = GetElement("recur").value;
	var txtRecurType = "";
	if (recurtype == "once") {
		//Start Time
			//KDC, 4-7-2008. For testing the IE bug (multiple tabs opening)
		if (isBlankField("txtStart_OneTime"))
		{
			strReqdFields = addToMessage(strReqdFields,"Start Time, setting to default");
			document.forms[0].txtStart_OneTime.value = txtStart_oneTimeDef;
		}
		//End Time
/*		if (isBlankField("txtEnd_OneTime"))
		{
			strReqdFields = addToMessage(strReqdFields,"End Time, setting to default");
			alert(strReqdFields + ":" + txtEnd_oneTimeDef);
			document.forms[0].txtEnd_OneTime.value = txtEnd_oneTimeDef;
		}
*/
		if ( document.forms[0].selDuration0_OneTime.value == 0 )
			strReqdFields = addToMessage(strReqdFields,"Correctly set the start and end times");
			
		txtRecurType = "OneTime";
	
	} else { // recurtype == multiple or instance
		//Start Time
		if (isBlankField("txtStart_Recur"))
		{
			strReqdFields = addToMessage(strReqdFields,"Start Time");
			document.forms[0].txtStart_Recur.value = txtStart_oneTimeDef;
		}
		//End Time
		if (isBlankField("txtEnd_Recur"))
		{
			strReqdFields = addToMessage(strReqdFields,"End Time");
			document.forms[0].txtEnd_Recur.value = txtStart_oneTimeDef;
		}

		if ( document.forms[0].selDuration0_Recur.value == 0 )
			strReqdFields = addToMessage(strReqdFields,"Correctly set the start and end times");
			
		txtRecurType = "Recur";
	}

	//Show the message
	if (trim(strReqdFields) != "") {
		alert(strReqdMsg + strReqdFields);
	}

	//Validate field format? (phone, email, etc.)

	//Remember the number of time periods specified by the user.
	GetElement("hidNumPeriods").value = document.g_iNumTimePeriods;

	//KDC, 11-13-2007. Disabling the drop-down stopped it from posting the value. Enabling at the last minute...
	GetElement("selRecur").disabled = false;

	//KDC, 8-26-2008. Disabling the drop-down stopped it from posting the value. Enabling at the last minute...
	var selTS = GetElement("selTimeSlots")
	selTS.disabled = false;

	//KDC, 9/3/2008. To select the list items so that they get posted.
	SelectEntireList("selViewBlocksUserIDList[]");
	SelectEntireList("selViewBlocksCourseIDList[]");
	SelectEntireList("selMakeApptUserIDList[]");
	SelectEntireList("selMakeApptCourseIDList[]");
	
	//KDC, 4-2-2009. Validate start/end time of blocks to *NOT* fall within 12AM and 6AM.
	var dt_st = GetElement("txtStart_" + txtRecurType).value;
	var dtLowVal = new Date();
	var dtHighVal = new Date(); 
	if (dt_st != null && dt_st != "") {
		dtLowVal = GetDateFromDisplay(dt_st);
		dtHighVal = GetDateFromDisplay(dt_st);
	}
	//set to midnight
	dtLowVal.setHours(0);
	dtLowVal.setMinutes(0);
	dtLowVal.setSeconds(0);
	//set to 6 AM
	dtHighVal.setHours(6);
	dtHighVal.setMinutes(0);
	dtHighVal.setSeconds(0);
	var txtDates = "";
	var isError = false;
	var isFirst = true;
	for (var i=0; i < document.g_iNumTimePeriods || isFirst; i++) {
		var dtStart = getStartTime(txtRecurType,i);
		var dtEnd = getEndTime(txtRecurType,i);
		if ((isTimeBefore(dtLowVal,dtStart) && isTimeBefore(dtStart,dtHighVal)) || (isTimeBefore(dtLowVal,dtEnd) && isTimeBefore(dtEnd,dtHighVal))) {
			if (txtDates != "")
				txtDates += " and ";
			txtDates += GetDisplayTimeFull(dtStart) + " to " + GetDisplayTimeFull(dtEnd);
			isError = true;
		}
		isFirst = false;
	}
	if (isError) {
		var answer = confirm("You are about to save a  block that goes from " + txtDates + ". Would you like to continue?");
		if (answer)
			yesSubmit();
		else
			return false;
	}

//	return true;
	yesSubmit();
	return false;
}
function yesSubmit() {
	GetElement("hidSubmitForm").value = true;
	submitForm();
}

function displayEditFields(inNumAppts,inRecurType) {
	document.g_isEditing = true;
	GetElement("divBlockType").style.display = "none";
	//Disabled fields for one-time blocks
	if (inRecurType == "once") {
		GetElement("windowTitle").innerHTML = "Edit Block";
		//KDC, 12-12-2007. Always disable the start date - PHP code isn't there yet- later version
		GetElement("txtStart_OneTime").disabled = true;
		GetElement("imgStartDate1").style.visibility = "hidden";
	} else if (inRecurType == "instance") {
		GetElement("windowTitle").innerHTML = "Edit Block Instance";

		GetElement("txtStart_Recur").disabled = true;
		GetElement("imgStartDate2").style.visibility = "hidden";
		GetElement("txtEnd_Recur").disabled = true;
		GetElement("imgEndDate2").style.visibility = "hidden";
		GetElement("selRecur").disabled = true;
		GetElement("selWeeklyRecurDay0").disabled = true;
		GetElement("selMonthlyRecurDay0").disabled = true;
		GetElement("selMonthlyRecurWeek0").disabled = true;
		GetElement("selMonthlyRecurWeekDay0").disabled = true;
		GetElement("chkDayType_All").disabled = true;
		var days = document.getElementsByName("chkDayType[]");
		for (var i=0; i < days.length; i++) {
			days[i].disabled = true;
		}

		GetElement("divAddAnother").style.display = "none";

	} else { //inRecurType == "multiple"
		GetElement("windowTitle").innerHTML = "Edit Block Series";

		GetElement("txtStart_Recur").disabled = true;
		GetElement("imgStartDate2").style.visibility = "hidden";
		GetElement("txtEnd_Recur").disabled = true;
		GetElement("imgEndDate2").style.visibility = "hidden";
		//KDC, 8/26/2008. Updated below to always enable if recurring.  PHP will return an error if user tries to edit a recurring series with any appointments scheduled
		GetElement("selTimeSlots").disabled = false;
		GetElement("selRecur").disabled = true;

		for (var i=0; i < document.g_iNumTimePeriods; i++) {
			if (GetElement("selWeeklyRecurDay" + i) != null) GetElement("selWeeklyRecurDay" + i).disabled = true;
			if (GetElement("selMonthlyRecurDay" + i) != null) GetElement("selMonthlyRecurDay" + i).disabled = true;
			if (GetElement("selMonthlyRecurWeek" + i) != null) GetElement("selMonthlyRecurWeek" + i).disabled = true;
			if (GetElement("selMonthlyRecurWeekDay" + i) != null) GetElement("selMonthlyRecurWeekDay" + i).disabled = true;
		}

		GetElement("chkDayType_All").disabled = true;
		var days = document.getElementsByName("chkDayType[]");
		for (var i=0; i < days.length; i++) {
			days[i].disabled = true;
		}

		GetElement("divAddAnother").style.display = "none";
	}
}

// Define an array that contains the name/email/phone/location of the calendar owner and calendar members of group calendars.
<?php
if ($cal->group && $cal->isOwner($_SESSION['authtype'],$_SESSION['authid'])) {
	$members = wassManager::arrayActiveManagers($cal->calendarid);
	if (count($members)) {?>
    	var Netid = new Array();
		Netid[0] = new Array();
	  	Netid[0][0] = <?php echo '"' . $cal->userid . '"';?>;
	  	Netid[0][1] = <?php echo '"' . wassDirectory::getName($cal->userid) . '"';?>;
	  	Netid[0][2] = <?php echo '"' . wassDirectory::getEmail($cal->userid) . '"';?>;
	 	Netid[0][3] = <?php echo '"' . wassDirectory::getPhone($cal->userid) . '"';?>;
	 	Netid[0][4] = <?php echo '"' . wassDirectory::getOffice($cal->userid) . '"';?>;
      	<?php 
	  	$counter = 1;
	  	foreach ($members as $member) {?>
			Netid[<?php echo $counter?>] = new Array();
	  		Netid[<?php echo $counter?>][0] = <?php echo '"' . $member . '"';?>;
	 		Netid[<?php echo $counter?>][1] = <?php echo '"' . wassDirectory::getName($member) . '"';?>;
	  		Netid[<?php echo $counter?>][2] = <?php echo '"' . wassDirectory::getEmail($member) . '"';?>;
	  		Netid[<?php echo $counter?>][3] = <?php echo '"' . wassDirectory::getPhone($member) . '"';?>;
	  		Netid[<?php echo $counter?>][4] = <?php echo '"' . wassDirectory::getOffice($member) . '"';?>;<?php
			$counter++;
		}
	}
}?>

function resetNetid(sel) {
	/* 
	The value passed is the select object.  The current selected value contains the netid and
	the index into our array for that netid.
	*/
	var selectedvalue = (sel.options[sel.selectedIndex].value).split(" ");
	var selindex = selectedvalue[1];
	
	// Now we reset the form fields as per our array.
	GetElement("txtOwner").value = Netid[selindex][1];
	GetElement("txtEmail").value = Netid[selindex][2];
	GetElement("txtPhone").value = Netid[selindex][3];
	GetElement("txtLocation").value = Netid[selindex][4];		
}

function notifyUserDeadlines(inValField,inTextField,inText) {
	//Get the updated minutes value in the hidden inValField
	var valMins = calculateMinutes(inValField);
	var elDays = GetElement(inValField+"Days");
	var elHours = GetElement(inValField+"Hours");
	var elMins = GetElement(inValField+"Mins");
	var el = GetElement(inValField);
	if (el != null)
		el.value = valMins;
	var elTxt = GetElement(inTextField);
	if (valMins > 0) {
		if (inText != null && inText != "") {
			elTxt.innerHTML = inText;
			//elTxt.innerHTML = "Block becomes " + inText + " for appointment scheduling " + valMins + " minutes prior to start time.";
		}
		elTxt.style.color = "red";
		if (elDays != null) elDays.style.color = "red";
		if (elHours != null) elHours.style.color = "red";
		if (elMins != null) elMins.style.color = "red";
	}
	else {
		elTxt.innerHTML = "prior to start of block"; //"minutes prior to start of block (e.g. 60 = 1 hour, 1440 = 1 day; 0 means now)";
		elTxt.style.color = "#000000";
		if (elDays != null) elDays.style.color = "#000000";
		if (elHours != null) elHours.style.color = "#000000";
		if (elMins != null) elMins.style.color = "#000000";
	}
	
}

//KDC, 2-12-2010.  
function notifyUserSchedOpen() {
	notifyUserDeadlines("txtOpening","divSchedOpenTxt","prior to start, block becomes available for appointment scheduling.");
}

//KDC, 2-15-2010.  
function notifyUserSchedDeadline() {
	notifyUserDeadlines("txtDeadline","divSchedDeadlineTxt","prior to start, block becomes unavailable for appointment scheduling.");
}

//KDC, 5-22-2011.  
function notifyUserCanDeadline() {
	notifyUserDeadlines("txtCanDeadline","divCanDeadlineTxt","prior to start, by when appointments must be cancelled.");
}


/* KDC, 5-23-2010 */
function lockUnlockBlock(inObj) {
	var islock = false; //no, don't lock it
	if ( (inObj.src).indexOf('unavailable') >= 0 ) //Note, somehow the images for available/unavailable are reverse...
		islock = true;

	var elAvailable = GetElement("hidAvailable");
	var elText = GetElement("divLockText");
	if (islock) {
		//change the image
		inObj.src = 'images/available_block.gif';
		inObj.title = "Block is Unavailable for Appointments. Click to make block Available";
		//set the hidden input to change status
		elAvailable.value = "0";
		//set the text
		elText.innerHTML = "locked (unavailable; click to unlock)";
	}
	else {
		//change the image
		inObj.src = 'images/unavailable_block.gif';
		inObj.title = "Block is Available for Appointments. Click to make block Unavailable";
		//set the hidden input to change status
		elAvailable.value = "1";
		//set the text
		elText.innerHTML = "unlocked (click to lock)";
	}
}

function doAllCheck() {
	var days = document.getElementsByName("chkDayType[]");
	var areAllChecked = true;
	for (var i=0; i < days.length; i++) {
		if (!days[i].checked)
			areAllChecked = false;
	}
	if (areAllChecked) {
		GetElement("chkDayType_All").checked = true;
	} else {
		GetElement("chkDayType_All").checked = false;
	}
}

</script>
</head>
<?php
if ($issuccess == true) {?>
	<body onload="initAjax();window.opener.reloadPage();init();"><?php
}
else {?>
	<body onload="initAjax();init();"><?php
}?>

<div id="close" style="float:right;"><a href="#" onclick="self.close();">Close Window</a></div>
<div class="helpBlock"><a href="#" onclick='openHelp("onetime",true);return false;' title='Help'>Get Help</a></div>


<div id="windowTitle">Create a New Block </div>

<div id="formdividerShort"></div>

<div id="divBlockType" class="mandatNote">
<span class="labelLarge">Type of Block:</span> <a href="#" id="linkOneTime" class="showhide_on" style="font-size:11px;" onclick="changeSection('OneTime','once'); return false;" tabindex="1">One-Time</a> <a href="#" id="linkRecurring" class="showhide_off" style="font-size:11px;" onclick="changeSection('Recur','multiple'); return false;" tabindex="2">Recurring</a>
<div id="formdividerShort"></div>
</div>


<form id="frmCreateBlock" name="frmCreateBlock" action="#" method="post" >
<input type="hidden" id="cal_id" name="cal_id" value="<?php echo $cal_id;?>" />
<input type="hidden" id="date" name="date" value="<?php echo $date;?>" />
<input type="hidden" id="starttime" name="starttime" value="<?php echo $starttime;?>" />
<input type="hidden" id="endtime" name="endtime" value="<?php echo $endtime;?>" />
<input type="hidden" id="block_id" name="block_id" value="<?php if ($action == 'update') echo $block_id;?>" />
<input type="hidden" id="recur" name="recur" value="<?php echo $recur;?>" />
<input type="hidden" id="hidNumPeriods" name="hidNumPeriods" value="<?php echo $hidNumPeriods;?>" />

<input type="hidden" id="hidAJAXURL" name="hidAJAXURL" value="<?php echo wassParms::AJAXURL;?>" />
<input type="hidden" id="hidAJAXSchemaRoot" name="hidAJAXSchemaRoot" value="<?php echo wassParms::AJAXSCHEMAROOT;?>" />

<input type="hidden" id="hidSubmitForm" name="hidSubmitForm" value="false" />

<?php
if ($errmsg) { ?>
    <div id="error"><?php echo $errmsg;?><br>
    <a href="#" onclick="closeMessage('error');return false;">close message</a></div>
<?php } elseif ($infmsg) { ?>
	<div id="confirm"><?php echo $infmsg;?><br>
    <a href="#" onclick="closeMessage('confirm');return false;">close message</a></div>
<?php } ?>

<fieldset>

<!-- BEGIN URL AREA -->
<?php if ($url) {?>
<div id="URLAreaBlock">
<div class="URLTitle">Block URL (for Appointment Makers)</div>
<div class="URLHelp"><a href="#" onclick='openHelp("advertiseblock",true);return false;' title='Help'><img src="images/Q1.gif" alt="Help" border="0" /></a></div>
<div class="URLText"><?php echo $url?></div>
</div>
<br>
<?php
}?>
<!-- END URL AREA-->

<!-- *** PHP *** -->
<!-- if new block (no block_id), PHP defaults these fields to the calendar setup values, else use block field values -->
<div>
<label for="txtTitle" class="mandat" title="The title of the block.">Title of Block:*</label>
<input type="text" id="txtTitle" name="txtTitle" tabindex="3" value="<?php echo wassUtil::safeHTML($block->title);?>" size="50">
<input type="hidden" id="hidOrigTitle" name="hidOrigTitle" value="<?php echo wassUtil::safeHTML($block->title);?>" />
</div>

<br>

<?php
/* If we are adding a block to a group calendar, and if the logged-in user is the calendar owner, then we need to present a drop-down list of 
the owner and member netids so that the owner can specify for which member (or themselves) the block is being added.
*/
if ($cal->group && $cal->isOwner($_SESSION['authtype'],$_SESSION['authid'])) {
	$members = wassManager::arrayActiveManagers($cal->calendarid);
	if (count($members)) {?>
      <div>
      <label for="selNetid" class="mandat" title="The <?php echo wassParms::NETID?> of the block owner."><?php echo wassParms::NETID?> of Block Owner:*</label>
      <select id="selNetid" name="selNetid" tabindex="4" onchange="resetNetid(this);">
      <option <?php if ($block->userid == $cal->userid) echo 'selected="selected"'; ?> value="<?php echo $cal->userid . ' 0';?>"><?php echo $cal->userid . ' (' . wassDirectory::getName($cal->userid) . ')';?></option>
      <?php
	  $counter = 1;
	  foreach ($members as $member) {?>
      	<option value="<?php echo $member . ' ' . $counter;?>" <?php if ($block->userid == $member) echo 'selected="selected"'; ?>><?php echo $member . ' (' . wassDirectory::getName($member) . ')';?></option><?php 
		$counter++;
	  }?>
      </select>
      </div>
      <br />
	<?php	
	}
}?>
	
	
<div>
<label id="lblOwner" for="txtOwner" class="mandat" title="The name of the block owner.">Name:*</label>
<input type="text" id="txtOwner" name="txtOwner" tabindex="4" value="<?php echo wassUtil::safeHTML($block->name);?>" size="35">
<input type="hidden" id="hidOrigOwner" name="hidOrigOwner" value="<?php echo wassUtil::safeHTML($block->name);?>" />
</div>

<br>

<div>
<label id="lblEmail" for="txtEmail" class="mandat" title="The e-mail address of the block owner.">E-mail:*</label>
<input type="text" id="txtEmail" name="txtEmail" tabindex="5" onblur="validateEmail();" value="<?php echo wassUtil::safeHTML($block->email);?>">
<input type="hidden" id="hidOrigEmail" name="hidOrigEmail" value="<?php echo wassUtil::safeHTML($block->email);?>" />
</div>

<br>

<div>
<label id="lblPhone" for="txtPhone" title="The telephone number of the block owner.">Telephone:</label>
<input type="text" id="txtPhone" name="txtPhone" tabindex="6" size="12" value="<?php echo wassUtil::safeHTML($block->phone);?>">
<input type="hidden" id="hidOrigPhone" name="hidOrigPhone" value="<?php echo wassUtil::safeHTML($block->phone);?>" />
</div>

<br>

<div>
<label id="lblDesc" for="txtDesc" title="A description or purpose of the block.">Description:</label>
<textarea id="txtDesc" name="txtDesc" cols="35" rows="2" tabindex="7" ><?php echo wassUtil::safeHTML($block->description);?></textarea>
<input type="hidden" id="hidOrigDesc" name="hidOrigDesc" value="<?php echo wassUtil::safeHTML($block->description);?>" />
</div>

<br>


<div>
<label id="lblAppText" for="txtAppText" title="Text to include in appointment notifications and reminders.">Supplemental text <br>for appointment email:</label>
<textarea id="txtAppText" name="txtApptext" tabindex="8" rows="3" cols="45"><?php echo wassUtil::safeHTML($block->appmsg);?></textarea>
<input type="hidden" id="hidOrigAppText" name="hidOrigAppText" value="<?php echo wassUtil::safeHTML($block->appmsg);?>" />
</div>

<br>

<div>
<label id="lblLocation" for="txtLocation" title="The location of the appointment.">Location:</label>
<input type="text" id="txtLocation" name="txtLocation" value="<?php echo wassUtil::safeHTML($block->location);?>" tabindex="9">
<input type="hidden" id="hidOrigLocation" name="hidOrigLocation" value="<?php echo wassUtil::safeHTML($block->location);?>" />
</div>

<br>
<div id="formdividerShort"></div>


<!-- ONE-TIME BLOCK -->
<div id="divOneTime">

<?php
/* Convert starttime and endtime to hour/minute/ampm */
list($sh,$sm,$xx) = explode(':',$block->starttime);
if ($sh >= 12) {
	$sampm = 'PM';
	if ($sh > 12)
		$sh -= 12;
}
else
	$sampm = 'AM';
list($eh,$em,$xx) = explode(':',$block->endtime);
if ($eh >= 12) {
	$eampm = 'PM';
	if ($eh > 12)
		$eh -= 12;
}
else
	$eampm = 'AM';
?>
<div>
<!-- JJC, replace OneTime $oRecur which indicates "once" or "multiple"-->
<!-- KDC, put back to OneTime here - Recur is below and if you substitute, causes problems -->
<label id="lblStart_OneTime" for="txtStart_OneTime" class="mandat" title="The start date and time of the block.">Start:*</label>
<input type="text" id="txtStart_OneTime" name="txtStart_OneTime" tabindex="10" size="12" value="<?php echo wassUtil::usDate($block->date);?>"><img id="imgStartDate1" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtStart_OneTime',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="9" class="imgbutton" />
<input type="hidden" id="hidStart_OneTime" name="hidStart_OneTime" value="<?php echo wassUtil::usDate($block->date);?>" />

<label id="lblStartHour_OneTime" for="selStartHour_OneTime" class="mandat removed">Hour:</label>
<select id="selStartHour0_OneTime" name="selStartHour_OneTime" tabindex="11" onchange="changeStart('OneTime','0');">
<option <?php if ($sh == 1) echo 'selected="selected"';?>value="1">1</option>
<option <?php if ($sh == 2) echo 'selected="selected"';?>value="2">2</option>
<option <?php if ($sh == 3) echo 'selected="selected"';?> value="3">3</option>
<option <?php if ($sh == 4) echo 'selected="selected"';?> value="4">4</option>
<option <?php if ($sh == 5) echo 'selected="selected"';?> value="5">5</option>
<option <?php if ($sh == 6) echo 'selected="selected"';?> value="6">6</option>
<option <?php if ($sh == 7) echo 'selected="selected"';?> value="7">7</option>
<option <?php if ($sh == 8) echo 'selected="selected"';?> value="8">8</option>
<option <?php if ($sh == 9) echo 'selected="selected"';?> value="9">9</option>
<option <?php if ($sh == 10) echo 'selected="selected"';?> value="10">10</option>
<option <?php if ($sh == 11) echo 'selected="selected"';?> value="11">11</option>
<option <?php if ($sh == 12) echo 'selected="selected"';?> value="12">12</option>
</select> :
<input type="hidden" id="hidStartHour0_OneTime" name="hidStartHour_OneTime" value="<?php echo $sh;?>" />
<label id="lblStartMinute_OneTime" for="selStartMinute_OneTime" class="mandat removed">Minutes:</label>
<select id="selStartMinute0_OneTime" name="selStartMinute_OneTime" tabindex="12" onchange="changeStart('OneTime','0');">
<option <?php if ($sm == 0) echo 'selected="selected"';?> value="0">00</option>
<option <?php if ($sm == 5) echo 'selected="selected"';?> value="5">05</option>
<option <?php if ($sm == 10) echo 'selected="selected"';?> value="10">10</option>
<option <?php if ($sm == 15) echo 'selected="selected"';?> value="15">15</option>
<option <?php if ($sm == 20) echo 'selected="selected"';?> value="20">20</option>
<option <?php if ($sm == 25) echo 'selected="selected"';?> value="25">25</option>
<option <?php if ($sm == 30) echo 'selected="selected"';?> value="30">30</option>
<option <?php if ($sm == 35) echo 'selected="selected"';?> value="35">35</option>
<option <?php if ($sm == 40) echo 'selected="selected"';?> value="40">40</option>
<option <?php if ($sm == 45) echo 'selected="selected"';?> value="45">45</option>
<option <?php if ($sm == 50) echo 'selected="selected"';?> value="50">50</option>
<option <?php if ($sm == 55) echo 'selected="selected"';?> value="55">55</option>
</select>
<input type="hidden" id="hidStartMinute0_OneTime" name="hidStartMinute_OneTime" value="<?php echo $sm;?>" />
<label id="lblStartAMPM_OneTime" for="selStartAMPM_OneTime" class="mandat removed">AM/PM:</label>
<select id="selStartAMPM0_OneTime" name="selStartAMPM_OneTime" tabindex="13" onchange="changeStart('OneTime','0');">
<option value="AM" <?php if ($sampm == 'AM') echo 'selected="selected"';?>>AM</option>
<option value="PM" <?php if ($sampm == 'PM') echo 'selected="selected"';?>>PM</option>
</select>
<input type="hidden" id="hidStartAMPM0_OneTime" name="hidStartAMPM_OneTime" value="<?php echo $sampm;?>" />
<input type="checkbox" id="chkByMinutes0_OneTime" tabindex="14" name="chkByMinutes_OneTime" value="1" onclick="setMinuteLists('OneTime','0',this.checked);" /> Display Time By Minutes
</div>

<div>
<!-- Ignore this field; it is not displayed -->
<label id="lblEnd_OneTime" for="txtEnd_OneTime" class="mandat" title="The end time or duration of the block.">End:*</label>
<input type="text" id="txtEnd0_OneTime" name="txtEnd_OneTime" tabindex="15" size="12" style="visibility: hidden;"><img id="imgEndDate1" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtEnd_OneTime',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="13" class="imgbutton" style="visibility: hidden;" />

<label id="lblEndHour_OneTime" for="selEndHour_OneTime" class="mandat removed">Hour:</label>
<select id="selEndHour0_OneTime" name="selEndHour_OneTime" tabindex="16" onchange="changeEnd('OneTime','0');">
<option <?php if ($eh == 1) echo 'selected="selected"';?> value="1">1</option>
<option <?php if ($eh == 2) echo 'selected="selected"';?> value="2">2</option>
<option <?php if ($eh == 3) echo 'selected="selected"';?> value="3">3</option>
<option <?php if ($eh == 4) echo 'selected="selected"';?> value="4">4</option>
<option <?php if ($eh == 5) echo 'selected="selected"';?> value="5">5</option>
<option <?php if ($eh == 6) echo 'selected="selected"';?> value="6">6</option>
<option <?php if ($eh == 7) echo 'selected="selected"';?> value="7">7</option>
<option <?php if ($eh == 8) echo 'selected="selected"';?> value="8">8</option>
<option <?php if ($eh == 9) echo 'selected="selected"';?> value="9">9</option>
<option <?php if ($eh == 10) echo 'selected="selected"';?> value="10">10</option>
<option <?php if ($eh == 11) echo 'selected="selected"';?> value="11">11</option>
<option <?php if ($eh == 12) echo 'selected="selected"';?> value="12">12</option>
</select> :
<input type="hidden" id="hidEndHour0_OneTime" name="hidEndHour_OneTime" value="<?php echo $eh;?>" />
<label id="lblEndMinute_OneTime" for="selEndMinute_OneTime" class="mandat removed">Minutes:</label>
<select id="selEndMinute0_OneTime" name="selEndMinute_OneTime" tabindex="17" onchange="changeEnd('OneTime','0');">
<option <?php if ($em == 0) echo 'selected="selected"';?> value="0">00</option>
<option <?php if ($em == 5) echo 'selected="selected"';?> value="5">05</option>
<option <?php if ($em == 10) echo 'selected="selected"';?> value="10">10</option>
<option <?php if ($em == 15) echo 'selected="selected"';?> value="15">15</option>
<option <?php if ($em == 20) echo 'selected="selected"';?> value="20">20</option>
<option <?php if ($em == 25) echo 'selected="selected"';?> value="25">25</option>
<option <?php if ($em == 30) echo 'selected="selected"';?> value="30">30</option>
<option <?php if ($em == 35) echo 'selected="selected"';?> value="35">35</option>
<option <?php if ($em == 40) echo 'selected="selected"';?> value="40">40</option>
<option <?php if ($em == 45) echo 'selected="selected"';?> value="45">45</option>
<option <?php if ($em == 50) echo 'selected="selected"';?> value="50">50</option>
<option <?php if ($em == 55) echo 'selected="selected"';?> value="55">55</option>
</select>
<input type="hidden" id="hidEndMinute0_OneTime" name="hidEndMinute_OneTime" value="<?php echo $em;?>" />
<label id="lblEndAMPM_OneTime" for="selEndAMPM_OneTime" class="mandat removed">AM/PM:</label>
<select id="selEndAMPM0_OneTime" name="selEndAMPM_OneTime" tabindex="18" onchange="changeEnd('OneTime','0');">
<option value="AM" <?php if ($eampm == 'AM') echo 'selected="selected"';?>>AM</option>
<option value="PM" <?php if ($eampm == 'PM') echo 'selected="selected"';?>>PM</option>
</select> OR SET DURATION:
<input type="hidden" id="hidEndAMPM0_OneTime" name="hidEndAMPM_OneTime" value="<?php echo $eampm;?>" />
<!-- following field does not need to be processed -->
<label id="lblDuration_OneTime" for="selDuration_OneTime" class="removed">Duration:</label>
<select name="selDuration_OneTime" id="selDuration0_OneTime" tabindex="19" onchange="changeDuration('OneTime','0');">
<option></option>
<!-- left intentionally blank. populated via JavaScript -->
</select>
</div>

</div>
<!-- END ONE-TIME BLOCK -->


<!-- RECURRING BLOCK -->
<div id="divRecurring">

<div>
<label id="lblStart_Recur" for="txtStart_Recur" class="mandat">Start Date:*</label>
<input type="text" id="txtStart_Recur" name="txtStart_Recur" tabindex="20" size="12" value="<?php if ($series) echo wassUtil::usDate($series->startdate);?>"> <img id="imgStartDate2" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtStart_Recur',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="18" class="imgbutton" />
<input type="hidden" id="hidStart_Recur" name="hidStart_Recur" value="<?php if ($series) echo wassUtil::usDate($series->startdate);?>" />
</div>

<div>
<label id="lblEnd_Recur" for="txtEnd_Recur" class="mandat">End Date:*</label>
<input type="text" id="txtEnd_Recur" name="txtEnd_Recur" tabindex="21" size="12" value="<?php if ($series) echo wassUtil::usDate($series->enddate);?>"> <img id="imgEndDate2" src="images/calendarIcon.gif" alt="Choose from Calendar" onclick="openCalendar('txtEnd_Recur',GetScreenX(event)+GetWindowLeft(), GetScreenY(event)+GetWindowTop()); return false;" tabindex="19" class="imgbutton" />
<input type="hidden" id="hidEnd_Recur" name="hidEnd_Recur" value="<?php if ($series) echo wassUtil::usDate($series->enddate);?>" /></div>

<br>
<div id="formdividerSub"></div>


<div>
<label id="lblRecur" for="selRecur" class="mandat">Recur:*</label>
<select name="selRecur" id="selRecur" tabindex="22" onchange="onchangeRecur();">
<option <?php if ($series->every == "daily") echo ' selected="selected" ';?> value="daily">Daily</option>
<option  <?php if ($series->every == "dailyweekdays") echo ' selected="selected" ';?> value="dailyweekdays">Daily - Week Days Only</option>
<option  <?php if ($series->every == "weekly") echo ' selected="selected" ';?> value="weekly">Weekly</option>
<option  <?php if ($series->every == "otherweekly") echo ' selected="selected" ';?> value="otherweekly">Every Other Week</option>
<option  <?php if ($series->every == "monthlyday") echo ' selected="selected" ';?> value="monthlyday">Same Day of Each Month (e.g., 20th of each month)</option>
<option  <?php if ($series->every == "monthlyweekday") echo ' selected="selected" ';?> value="monthlyweekday">Same Week Day of Each Month (e.g., 3rd Tuesday of each month)</option>
</select>
<input type="hidden" name="hidRecur" id="hidRecur" value="<?php echo $series->every;?>" />
</div>

<br>
<div id="formdividerSub"></div>

<div id="divTimePeriods">
</div>

<script type="text/javascript" language="javascript">
function addTimePeriod_Times(inRecurEvery,inRecurParam1,inRecurParam2,inStartHour,inStartMinute,inEndHour,inEndMinute) {
//note: only inRecurEvery values of "monthlyweekday" will have an inRecurParam2 value

	//Disable the recur field
	if (document.g_iNumTimePeriods > 0)
		GetElement("selRecur").disabled = true;

	var iNum = document.g_iNumTimePeriods+1;
	var par = GetElement("divTimePeriods");

	var elDiv = document.createElement("DIV");
	elDiv.id = "divTimePeriod" + document.g_iNumTimePeriods;
	par.appendChild(elDiv);


	//set up for selected recur values
	var iSelRecur1Index = 0;
	var iSelRecur2Index = 0;

	//Put in the correct fields for the given "recur every"
	if (document.g_iNumTimePeriods == 0 || inRecurEvery == "weekly" || inRecurEvery == "otherweekly") {
		//figure out selected index
		iSelRecur1Index = 0;
		if ((inRecurEvery == "weekly" || inRecurEvery == "otherweekly") && inRecurParam1 != undefined) {
			if (inRecurParam1 == "monday" || inRecurParam1 == "1")
				iSelRecur1Index = 0;
			else if (inRecurParam1 == "tuesday" || inRecurParam1 == "2")
				iSelRecur1Index = 1;
			else if (inRecurParam1 == "wednesday" || inRecurParam1 == "3")
				iSelRecur1Index = 2;
			else if (inRecurParam1 == "thursday" || inRecurParam1 == "4")
				iSelRecur1Index = 3;
			else if (inRecurParam1 == "friday" || inRecurParam1 == "5")
				iSelRecur1Index = 4;
			else if (inRecurParam1 == "saturday" || inRecurParam1 == "6")
				iSelRecur1Index = 5;
			else if (inRecurParam1 == "sunday" || inRecurParam1 == "0")
				iSelRecur1Index = 6;
		}

		//create the container div
		var elDivWeekly = document.createElement("DIV");
		elDivWeekly.id = "divWeekly" + document.g_iNumTimePeriods;
		elDiv.appendChild(elDivWeekly);

		//create the label
		var elLabel = document.createElement("LABEL");
		elLabel.innerHTML = "&nbsp;";
		elDivWeekly.appendChild(elLabel);

		//create the inner div
		var elDivInner = document.createElement("DIV");
		elDivInner.style.textIndent = "10px";
		elDivWeekly.appendChild(elDivInner);

		var elTxt = document.createTextNode("on: ");
		elDivInner.appendChild(elTxt);

		//create the select list
		var elSel = document.createElement("SELECT");
		elSel.id = "selWeeklyRecurDay" + document.g_iNumTimePeriods;
		elSel.name = "selWeeklyRecurDay" + document.g_iNumTimePeriods;
		elSel.tabindex = 21;
		elSel.options[0] = new Option("Monday","monday");
		elSel.options[1] = new Option("Tuesday","tuesday");
		elSel.options[2] = new Option("Wednesday","wednesday");
		elSel.options[3] = new Option("Thursday","thursday");
		elSel.options[4] = new Option("Friday","friday");
		elSel.options[5] = new Option("Saturday","saturday");
		elSel.options[6] = new Option("Sunday","sunday");
		elSel.options[iSelRecur1Index].selected = true;
		elDivInner.appendChild(elSel);


	}
	if (document.g_iNumTimePeriods == 0 || inRecurEvery  == "monthlyday") {
		//figure out selected index
		iSelRecur1Index = 0;
		if (inRecurEvery  == "monthlyday" && inRecurParam1 != undefined) {
			iSelRecur1Index = inRecurParam1;
		}

		//create the container div
		var elDivMonthlyDay = document.createElement("DIV");
		elDivMonthlyDay.id = "divMonthlyDay" + document.g_iNumTimePeriods;
		elDiv.appendChild(elDivMonthlyDay);

		//create the label
		var elLabel = document.createElement("LABEL");
		elLabel.innerHTML = "&nbsp;";
		elDivMonthlyDay.appendChild(elLabel);

		//create the inner div
		var elDivInner = document.createElement("DIV");
		elDivInner.style.textIndent = "10px";
		elDivMonthlyDay.appendChild(elDivInner);

		var elTxt = document.createTextNode("Day ");
		elDivInner.appendChild(elTxt);

		//create the select list
		var elSel = document.createElement("SELECT");
		elSel.id = "selMonthlyRecurDay" + document.g_iNumTimePeriods;
		elSel.name = "selMonthlyRecurDay" + document.g_iNumTimePeriods;
		elSel.tabindex = 22;
		for (var i=0; i < 31; i++) {
			elSel.options[i] = new Option(i+1,i+1);
		}
		elSel.options[iSelRecur1Index].selected = true;
		elDivInner.appendChild(elSel);

		var elTxt = document.createTextNode(" of every month");
		elDivInner.appendChild(elTxt);

	}
	if (document.g_iNumTimePeriods == 0 || inRecurEvery == "monthlyweekday") {
		//figure out selected index
		iSelRecur1Index = 0;
		iSelRecur2Index = 0;
		if (inRecurEvery == "monthlyweekday" && inRecurParam1 != undefined) {
			iSelRecur1Index = inRecurParam1;
		}
		if (inRecurEvery == "monthlyweekday" && inRecurParam2 != undefined) {
			if (inRecurParam2 == "monday")
				iSelRecur1Index = 0;
			else if (inRecurParam2 == "tuesday")
				iSelRecur1Index = 1;
			else if (inRecurParam2 == "wednesday")
				iSelRecur1Index = 2;
			else if (inRecurParam2 == "thursday")
				iSelRecur1Index = 3;
			else if (inRecurParam2 == "friday")
				iSelRecur1Index = 4;
			else if (inRecurParam2 == "saturday")
				iSelRecur1Index = 5;
			else if (inRecurParam2 == "sunday")
				iSelRecur1Index = 6;
		}

		//create the container div
		var elDivMonthlyWeek = document.createElement("DIV");
		elDivMonthlyWeek.id = "divMonthlyWeek" + document.g_iNumTimePeriods;
		elDiv.appendChild(elDivMonthlyWeek);

		//create the label
		var elLabel = document.createElement("LABEL");
		elLabel.innerHTML = "&nbsp;";
		elDivMonthlyWeek.appendChild(elLabel);

		//create the inner div
		var elDivInner = document.createElement("DIV");
		elDivInner.style.textIndent = "10px";
		elDivMonthlyWeek.appendChild(elDivInner);

		var elTxt = document.createTextNode("The ");
		elDivInner.appendChild(elTxt);

		//create the select list
		var elSel = document.createElement("SELECT");
		elSel.id = "selMonthlyRecurWeek" + document.g_iNumTimePeriods;
		elSel.name = "selMonthlyRecurWeek" + document.g_iNumTimePeriods;
		elSel.tabindex = 23;
		elSel.options[0] = new Option("First","1");
		elSel.options[1] = new Option("Second","2");
		elSel.options[2] = new Option("Third","3");
		elSel.options[3] = new Option("Fourth","4");
		elSel.options[4] = new Option("Last","5");
		elSel.options[iSelRecur1Index].selected = true;
		elDivInner.appendChild(elSel);

		//create the select list
		elSel = document.createElement("SELECT");
		elSel.id = "selMonthlyRecurWeekDay" + document.g_iNumTimePeriods;
		elSel.name = "selMonthlyRecurWeekDay" + document.g_iNumTimePeriods;
		elSel.tabindex = 24;
		elSel.options[0] = new Option("Monday","monday");
		elSel.options[1] = new Option("Tuesday","tuesday");
		elSel.options[2] = new Option("Wednesday","wednesday");
		elSel.options[3] = new Option("Thursday","thursday");
		elSel.options[4] = new Option("Friday","friday");
		elSel.options[5] = new Option("Saturday","saturday");
		elSel.options[6] = new Option("Sunday","sunday");
		elSel.options[iSelRecur2Index].selected = true;
		elDivInner.appendChild(elSel);

		var elTxt = document.createTextNode(" of every month");
		elDivInner.appendChild(elTxt);
	}


	//set up for selected time period values
	var iSelStartHourIndex = 8; //<?php echo substr($period->starttime,0,2) - 1;?>; //KDC 2-13-2008, this can be an enhancement
	var iSelStartMinuteIndex = 0;
	var iSelStartAMPMIndex = 0;
	var iSelEndHourIndex = 9; //<?php echo substr($period->endtime,0,2) - 1;?>; //KDC 2-13-2008, this can be an enhancement
	if (iSelEndHourIndex > 12) iSelEndHourIndex = iSelEndHourIndex - 12;
	var iSelEndMinuteIndex = 0;
	var iSelEndAMPMIndex = 0;
	if (inStartHour != undefined) {
		inStartHour = eval(inStartHour);
		if (inStartHour > 12) {
			iSelStartHourIndex = inStartHour - 13;
			iSelStartAMPMIndex = 1;
		} else {
			iSelStartHourIndex = inStartHour - 1;
			if (inStartHour == 12) iSelStartAMPMIndex = 1;
		}
	}
	if (inStartMinute != undefined) {
		inStartMinute = eval(inStartMinute);
		iSelStartMinuteIndex = inStartMinute / 5;
	}
	if (inEndHour != undefined) {
		inEndHour = eval(inEndHour);
		if (inEndHour > 12) {
			iSelEndHourIndex = inEndHour - 13;
			iSelEndAMPMIndex = 1;
		} else {
			iSelEndHourIndex = inEndHour - 1;
			if (inEndHour == 12) iSelEndAMPMIndex = 1;
		}
	}
	if (inEndMinute != undefined) {
		inEndMinute = eval(inEndMinute);
		iSelEndMinuteIndex = inEndMinute / 5;
	}


	//start time div
	var elDivStart = document.createElement("DIV");
	elDiv.appendChild(elDivStart);

	//start time: hour
	var elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartHour" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat";
	elLabel.innerHTML = "Start Time:*";
	elDivStart.appendChild(elLabel);

	var elSel = document.createElement("SELECT");
	elSel.id = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(12,1); changeStart('Recur',num); };
	for (var i=0; i < 12; i++) {
		elSel.options[i] = new Option(i+1,i+1);
	}
	elSel.options[iSelStartHourIndex].selected = true;
	elDivStart.appendChild(elSel);

	var elTxt = document.createTextNode(" : ");
	elDivStart.appendChild(elTxt);

	//start time: minutes
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartMinute" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Minutes:";
	elDivStart.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(14,1); changeStart('Recur',num); };
/*
	for (var i=0; i < 12; i++) {
		var mins = eval(i*5) + "";
		if (mins.length < 2) mins = "0" + mins;
		elSel.options[i] = new Option(mins,mins);
	}
	elSel.options[iSelStartMinuteIndex].selected = true;
*/
	elDivStart.appendChild(elSel);
	setMinuteList("selStartMinute" + document.g_iNumTimePeriods + "_Recur",5,iSelStartMinuteIndex);

	//start time: AM/PM
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "AM/PM:";
	elDivStart.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(12,1); changeStart('Recur',num); };
	elSel.options[0] = new Option("AM","AM");
	elSel.options[1] = new Option("PM","PM");
	elSel.options[iSelStartAMPMIndex].selected = true;
	elDivStart.appendChild(elSel);

	var elChk = document.createElement("INPUT");
	elChk.type = "checkbox";
	elChk.id = "chkByMinutes" + document.g_iNumTimePeriods + "_Recur";
	elChk.name = "chkByMinutes" + document.g_iNumTimePeriods + "_Recur";
	elChk.tabindex = 33;
	elChk.onclick = function () { var num = (this.id).substr(12,1); setMinuteLists('Recur',num,this.checked); };
	elDivStart.appendChild(elChk);

	elTxt = document.createTextNode(" Display Time By Minutes");
	elDivStart.appendChild(elTxt);

	//end time div
	var elDivEnd = document.createElement("DIV");
	elDiv.appendChild(elDivEnd);

	//end time: hour
	var elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndHour" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat";
	elLabel.innerHTML = "End Time:*";
	elDivEnd.appendChild(elLabel);

	var elSel = document.createElement("SELECT");
	elSel.id = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(10,1); changeEnd('Recur',num); };
	for (var i=0; i < 12; i++) {
		elSel.options[i] = new Option(i+1,i+1);
	}
//alert(document.g_iNumTimePeriods + "::" +iSelEndHourIndex);
	elSel.options[iSelEndHourIndex].selected = true;
	elDivEnd.appendChild(elSel);

	elTxt = document.createTextNode(" : ");
	elDivEnd.appendChild(elTxt);

	//end time: minutes
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndMinute" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Minutes:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(12,1); changeEnd('Recur',num); };
/*
	for (var i=0; i < 12; i++) {
		var mins = eval(i*5) + "";
		var minshow = mins;
		if (minshow.length < 2) minshow = "0" + minshow;
		elSel.options[i] = new Option(minshow,mins);
	}
	elSel.options[iSelEndMinuteIndex].selected = true;
*/
	elDivEnd.appendChild(elSel);
	setMinuteList("selEndMinute" + document.g_iNumTimePeriods + "_Recur",5,iSelEndMinuteIndex);

	//end time: AM/PM
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "AM/PM:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(10,1); changeEnd('Recur',num); };
	elSel.options[0] = new Option("AM","AM");
	elSel.options[1] = new Option("PM","PM");
	elSel.options[iSelEndAMPMIndex].selected = true;
	elDivEnd.appendChild(elSel);

	elTxt = document.createTextNode(" OR SET DURATION: ");
	elDivEnd.appendChild(elTxt);

	//end time: duration
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblDuration" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Duration:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { var num = (this.id).substr(11,1); changeDuration('Recur',num); };
	elSel.options[0] = new Option("","");
	elDivEnd.appendChild(elSel);

	var elDivLine = document.createElement("DIV");
	elDivLine.id = "formdividerSub";
	elDiv.appendChild(elDivLine);

	var elBR = document.createElement("BR");
	elDiv.appendChild(elBR);

	///setDurationVals(document.g_sShownSection,60,document.g_iNumTimePeriods);
	updateDuration('Recur',document.g_iNumTimePeriods);
	changeDuration(document.g_sShownSection,document.g_iNumTimePeriods);

	document.g_iNumTimePeriods++;
}
</script>


<div id="divAddAnother"><a href="#" class="labelButton" onclick="addTimePeriod_Times(GetElement('selRecur').value);return false;">Add another time period</a>
<div id="formdividerSub"></div>
</div>
<br>

<div class="cr">
<p id="pDayTypeLabel" class="mandat">Day Type:*</p>
<label class="mandatr" style="width:70px;"><input type="checkbox" id="chkDayType_All" name="chkDayType_All" tabindex="23" onclick="SelectAllChk('chkDayType[]',this.checked);"> All</label>
</div>

<div style="margin:0px 0px 0px 180px; height:1%; padding-bottom:5px;">
<!-- NOTE: This div wrapper prevents IE/Win in quirks mode from using BODY as the base for measuring the % width
on .floatholder. This wrapper must be dimensionally defined before IE<6 will use it as the percentage base. -->
<div style="margin: 0px 0px 0px 0px;" class="clearfix floatholder">
<!-- the "clearfix" classname MUST be the first class in the attribute for the JS to work! -->
<?php
/* Put all of the daytypes into an array */
$daytypes = explode(',',wassParms::DAYTYPES);
if ($action == 'update')
	$setdays = explode(',',$series->daytypes);
else 
	$setdays = explode(',',wassParms::DAYTYPES);
/* Now iterate through the array, 4 at a time */
$c = 0;
foreach ($daytypes as $daytype) {
	if ($c == 0) {?>
	<div class="floatbox"><?php
	}?>
	<p><input name="chkDayType[]" id="chkDayType[]" tabindex="24" type="checkbox" value="<?php echo $daytype;?>" onclick="doAllCheck();" <?php if (in_array($daytype,$setdays)) echo 'checked="checked"';?>> <?php echo $daytype;?> </p><?php
	if ($c == 4) {?>
		</div><?php
		$c = 0;
	}
	else
		$c++;
}
if ($c != 4) {?>
</div><?php
}?>

</div>

</div>
<!-- END - RECURRING FORM -->



<div id="formdividerShort"></div>
<br>

<div>
<label for="selTimeSlots" class="mandat" title="Slot size is the duration of each appointment.">Select Appointment Slot Size:* <br style="display: block;" /> ('none' for unslotted)&nbsp;&nbsp;</label>
<select name="selTimeSlots" id="selTimeSlots" tabindex="25" onchange="onchangeSlotDropDown(); setMaxAppts(document.g_sShownSection);">
<option></option>
<!-- left intentionally blank. populated via JavaScript -->
</select><!--KDC, 6-30-2008. Updated to include free-form slot size option-->
(minutes)&nbsp;&nbsp;&nbsp;&nbsp;OR Enter SLOT SIZE: <input type="text" name="txtSlotSize" id="txtSlotSize" value="<?php echo $slotsizetext;?>" style="width:40px; text-align:right;" onblur="onchangeTimeSlots();" tabindex="26" /> (minutes)
<div id="divSlotSizeMessage" style="display:block;font-style:italic;margin-left:190px;"></div>
</div>

<br>

<div id="divMaxApptsPerPerson">
<label for="selMaxPerPerson" title="The maximum amount of people that can make an appointment.">Max Appointments per person:</label>
<select name="selMaxPerPerson" id="selMaxPerPerson" tabindex="27">
<option></option>
<!-- left intentionally blank. populated via JavaScript (ajax??) -->
</select>
</div>

<div id="divMaxAppts">
<div class="cr">
<p>Max Appointments per block:</p>
<table border="0" cellspacing="0" cellpadding="0" style="margin-left: 0px;">
  <tr>
    <td><input type="radio" name="radMaxAppts" tabindex="28" value="0" <?php if ($block->maxapps == 0) echo "checked";?>></td>
    <td>No limit</td>
  </tr>
  <tr>
    <td><input type="radio" name="radMaxAppts" tabindex="29" value="1" <?php if ($block->maxapps > 0) echo "checked";?>>&nbsp;</td>
    <td><input type="text" id="txtMaxAppts" name="txtMaxAppts" value="<?php echo $block->maxapps;?>" tabindex="30" style="width:30px;margin-left:0px;display:inline;"> people</td>
  </tr>
</table>
</div>
</div>

<br>

<div>
<label id="lblOpening" for="txtOpening" title="When appointments can start to be made.">Scheduling Opening <a href="#" onclick="openHelp('deadlines',true);return false;" title="Help" ><img src="images/Q1.gif" alt="Help" border="0" /></a>:</label>
<input name="txtOpeningDays" type="text" id="txtOpeningDays" tabindex="34" value="" size="3" maxlength="3" onblur="notifyUserSchedOpen();" />
<div id="divSchedOpenDaysTxt" style="display:inline;">days</div>
<input name="txtOpeningHours" type="text" id="txtOpeningHours" tabindex="35" value="" size="3" maxlength="3" onblur="notifyUserSchedOpen();" />
<div id="divSchedOpenHoursTxt" style="display:inline;">hours</div>
<input name="txtOpeningMins" type="text" id="txtOpeningMins" tabindex="36" value="" size="3" maxlength="3" onblur="notifyUserSchedOpen();" />
<div id="divSchedOpenMinsTxt" style="display:inline;">minutes</div>
<div id="divSchedOpenTxt" style="display:inline;">prior to start of block</div>
<input name="txtOpening" type="hidden" id="txtOpening" value="<?php echo $block->opening;?>" />
<input type="hidden" id="hidOrigOpening" name="hidOrigOpening" value="<?php echo $block->opening;?>" />
</div>
<br>

<div>
<label id="lblDeadline" for="txtDeadline" title="Deadline by which appointments must be made.">Scheduling Deadline <a href="#" onclick="openHelp('deadlines',true);return false;" title="Help" ><img src="images/Q1.gif" alt="Help" border="0" /></a>:</label>
<input name="txtDeadlineDays" type="text" id="txtDeadlineDays" tabindex="37" value="" size="3" maxlength="3" onblur="notifyUserSchedDeadline();" />
<div id="divDeadlineDaysTxt" style="display:inline;">days</div>
<input name="txtDeadlineHours" type="text" id="txtDeadlineHours" tabindex="38" value="" size="3" maxlength="3" onblur="notifyUserSchedDeadline();" />
<div id="divDeadlineHoursTxt" style="display:inline;">hours</div>
<input name="txtDeadlineMins" type="text" id="txtDeadlineMins" tabindex="39" value="" size="3" maxlength="3" onblur="notifyUserSchedDeadline();" />
<div id="divDeadlineMinsTxt" style="display:inline;">minutes</div>
<div id="divSchedDeadlineTxt" style="display:inline;">prior to start of block</div>
<input name="txtDeadline" type="hidden" id="txtDeadline" value="<?php echo $block->deadline;?>" size="5" maxlength="5" onblur="notifyUserSchedDeadline();" />
<input type="hidden" id="hidOrigDeadline" name="hidOrigDeadline" value="<?php echo $block->deadline;?>" />
</div>

<br>

<div>
<label id="lblCanDeadline" for="txtCanDeadline" title="Deadline by which appointments must be cancelled.">Cancelling Deadline <a href="#" onclick="openHelp('deadlines',true);return false;" title="Help" ><img src="images/Q1.gif" alt="Help" border="0" /></a>:</label>
<input name="txtCanDeadlineDays" type="text" id="txtCanDeadlineDays" tabindex="40" value="" size="3" maxlength="3" onblur="notifyUserCanDeadline();" />
<div id="divCanDeadlineDaysTxt" style="display:inline;">days</div>
<input name="txtCanDeadlineHours" type="text" id="txtCanDeadlineHours" tabindex="41" value="" size="3" maxlength="3" onblur="notifyUserCanDeadline();" />
<div id="divCanDeadlineHoursTxt" style="display:inline;">hours</div>
<input name="txtCanDeadlineMins" type="text" id="txtCanDeadlineMins" tabindex="42" value="" size="3" maxlength="3" onblur="notifyUserCanDeadline();" />
<div id="divCanDeadlineMinsTxt" style="display:inline;">minutes</div>
<div id="divCanDeadlineTxt" style="display:inline;">prior to start of block</div>
<input name="txtCanDeadline" type="hidden" id="txtCanDeadline" value="<?php echo $block->candeadline;?>" size="5" maxlength="5" onblur="notifyUserSchedDeadline();" />
<input type="hidden" id="hidOrigCanDeadline" name="hidOrigCanDeadline" value="<?php echo $block->candeadline;?>" />
</div>

<br />

<div>
<label id="lblLock" for="imgLock" title="Lock block to make unavailable for scheduling">Lock/Unlock:</label>
<img id="imgLock" style="margin-left:8px;cursor:pointer;" class="iconprint"
	<?php if ($block->available) { ?> src="images/unavailable_block.gif" border="0" title="Block is Available for Appointments. Click to make block Unavailable" onclick="lockUnlockBlock(this);">
	<?php } else { ?> src="images/available_block.gif" border="0" title="Block is Unavailable for Appointments. Click to make block Available" onclick="lockUnlockBlock(this);">
    <?php } ?>
<div id="divLockText" style="display:inline;"><?php if ($block->available) { ?>unlocked (click to lock)<?php } else { ?>locked (unavailable; click to unlock)<?php } ?></div>
<input type="hidden" id="hidAvailable" name="hidAvailable" value="<?php echo $block->available;?>" />
</div>

<br />

<div class="cr">
<p id="pNotifyWhoLabel" title="If checked, email notification is sent when an appointment is made or cancelled.">Notifications:</p>
<label title="E-mail notifications will be sent to the block owner." style="width:150px;"><input type="checkbox" id="chkNotifyMe" name="chkNotifyMe" tabindex="43" value="me" <?php if ($block->notify) echo ' checked="checked"';?>> Block Owner</label>
<input type="hidden" id="hidOrigNotifyMe" name="hidOrigNotifyMe" value="<?php echo $block->notify;?>" />
<label class="mandat" style="_margin-left:183px; width:180px;" id="lblNotifyMgrs" title="E-mail notifications will be sent to the calendar managers."><input type="checkbox" id="chkNotifyMgrs" name="chkNotifyMgrs" tabindex="44" value="manager" <?php if ($block->notifyman) echo ' checked="checked"';?>> Calendar Manager(s)</label>
<input type="hidden" id="hidOrigNotifyMgrs" name="hidOrigNotifyMgrs" value="<?php echo $block->notifyman;?>" />
</div>
<br />

<div class="cr">
<p id="pRemindWhoLabel" title="If checked, email reminder is sent the day before the appointment.">Reminders:</p>
<label id="lblRemind" for="chkRemind" title="An email reminder is sent to the block owner the day before an appointment." style="width:130px;"><input type="checkbox" id="chkRemind" name="chkRemind" tabindex="45" value="remind" <?php if ($block->remind) echo ' checked="checked"';?>>Block Owner</label>
<input type="hidden" id="hidOrigRemind" name="hidOrigRemind" value="<?php echo $block->remind;?>" />
<label id="lblRemindMan" for="chkRemindMan" title="An email reminder is sent to the calendar managers the day before an appointment." style="width:160px;"><input type="checkbox" id="chkRemindMan" name="chkRemindMan" tabindex="46" value="remindman" <?php if ($block->remindman) echo ' checked="checked"';?>>Calendar Manager(s)</label>
<input type="hidden" id="hidOrigRemindMan" name="hidOrigRemindMan" value="<?php echo $block->remindman;?>" />
</div>
<br />


<div class="cr">
<p id="pRequirePurposeLabel" title="If checked, the purpose field is required on the appointment.">Require Appointment Purpose?:</p>
<label id="lblReqPurpose" for="chkReqPurpose" title="The purpose field is required when an appointment is made." style="width:130px;"><input type="checkbox" id="chkReqPurpose" name="chkReqPurpose" tabindex="47" value="req" <?php if ($block->purreq) echo ' checked="checked"';?>>Required</label>
<input type="hidden" id="hidOrigReqPurpose" name="hidOrigReqPurpose" value="<?php echo $block->purreq;?>" />
</div>
<br />

<div class="mandatNote">
<label class="mandat"> Required*</label>
</div>

<div id="formdividerShort"></div>
<br>

	<span class="labelLarge">Advanced Options:</span> <a href="#" id="linkHideAdv" class="showhide_off" tabindex="48" onclick="ShowHideSection('divAdvancedOptions','hide','linkShowAdv','linkHideAdv','showhide'); return false;">Hide</a><a href="#" id="linkShowAdv" class="showhide_on" tabindex="48" onclick="ShowHideSection('divAdvancedOptions','show','linkShowAdv','linkHideAdv','showhide'); return false;">Show</a>
    <a href="#" onclick='openHelp("badvanced",true);return false;' title='Help' ><img src="images/Q1.gif" alt="Help" border="0" /></a>

<br>

<div id="divAdvancedOptions">

<div>
<label>Private:</label>
<input type="checkbox" id="chkCalPrivate" name="chkCalPrivate" tabindex="49" value="unavailable" <?php if ($block->viewaccess == 'private') echo ' checked="checked"';?>> (If checked, this block will be visible to only you and your manager(s).
</div>

<div>
<!-- *** PHP *** -->
<input type="hidden" id="hidLimitedDomain" name="hidLimitedDomain" value="<?php echo wassParms::DOMNAME;?>" />
<input type="hidden" id="hidNetIDParms" name="hidNetIDParms" value="<?php echo wassParms::NETID;?>" />
<label for="selViewBlockRestr" title="Select who you will allow to view the Calendar.">View Blocks:</label>
<select id="selViewBlockRestr" name="selViewBlockRestr" tabindex="50" onchange="onchangeAdvBlocks();">
<option value="open" <?php if ($block->viewaccess == 'open') echo ' selected="selected" ';?>>Open</option>
<option value="limited" <?php if ($block->viewaccess == 'limited') echo ' selected="selected" ';?>>Limited</option>
<?php
/* The "restricted" setting only is available if course or user limits are enabled */
if (wassParms::COURSELIM || wassParms::USERLIM) {?>
<option value="restricted" <?php if ($block->viewaccess == 'restricted') echo ' selected="selected" ';?>>Restricted</option>
<?php }?>
<option value="private" <?php if ($block->viewaccess == 'private') echo ' selected="selected" ';?>>Private</option>
</select>&nbsp;<div id="divViewBlockRestrDesc" style="display:inline;">stuff</div>
</div>


<div id="divViewBlockRestr" class="authorized">
<?php
/* Only show user limit box if they are enabled */
if (wassParms::USERLIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter name or netID</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksUserID" name="txtViewBlocksUserID" value="" tabindex="51"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtViewBlocksUserID','selViewBlocksUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksUserIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksUserIDList[]" name="selViewBlocksUserIDList[]" class="listBox" size="4" multiple tabindex="52" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }

/* Only show course limit box if they are available */
if (wassParms::COURSELIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course identifier</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtViewBlocksCourseID" name="txtViewBlocksCourseID" value="" tabindex="53"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtViewBlocksCourseID','selViewBlocksCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selViewBlocksCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selViewBlocksCourseIDList[]" name="selViewBlocksCourseIDList[]" class="listBox" size="4" multiple tabindex="54" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }?>
</div>

<div id="formdividerSub"></div>
<br>

<div>
<label for="selMakeApptRestr" title="Select who you will allow to make appointments on the Calendar.">Make Appointments:</label>
<select id="selMakeApptRestr" name="selMakeApptRestr" tabindex="55" onchange="onchangeAdvAppts();" onload="onchangeAdvAppts();">
<option value="open" <?php if ($block->makeaccess == 'open') echo 'selected="selected"';?>>Open</option>
<option value="limited" <?php if ($block->makeaccess == 'limited') echo 'selected="selected"';?>>Limited</option>
<?php
/* Only show restricted option is user or course limits are enabled */
if (wassParms::USERLIM || wassParms::COURSELIM) {?>
<option value="restricted" <?php if ($block->makeaccess == 'restricted') echo 'selected="selected"';?>>Restricted</option>
<?php }?>
<option value="private" <?php if ($block->makeaccess == 'private') echo 'selected="selected"';?>>Private</option>
</select>&nbsp;<div id="divMakeApptRestrDesc" style="display:inline;">stuff</div>
</div>

<div id="divMakeApptRestr" class="authorized">
<?php
/* Only show user limit box if they are enabled */
if (wassParms::USERLIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Users</strong></p><p>Enter name or netID</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptUserID" name="txtMakeApptUserID" value="" tabindex="56"></td>
    <td><p align="center"><a href="#" onclick="doValidateUser('txtMakeApptUserID','selMakeApptUserIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptUserIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptUserIDList[]" name="selMakeApptUserIDList[]" class="listBox" size="4" multiple tabindex="57" >
			<option></option>
		</select></td>
  </tr>
</table>

<?php }

/* Only show course limit box if they are available */
if (wassParms::COURSELIM) {?>
<table width="200" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p><strong>Authorized Courses</strong></p><p>Enter course identifier</p></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
    <tr align="left" valign="top">
    <td><input type="text" id="txtMakeApptCourseID" name="txtMakeApptCourseID" value="" tabindex="58"></td>
    <td><p align="center"><a href="#" onclick="doValidateCourse('txtMakeApptCourseID','selMakeApptCourseIDList[]');return false;">Add</a></p>
        <a href="#" onclick="RemoveItemFromList('selMakeApptCourseIDList[]');return false;">Remove</a></td>
    <td><select id="selMakeApptCourseIDList[]" name="selMakeApptCourseIDList[]" class="listBox" size="4" multiple tabindex="59" >
			<option></option>
		</select></td>
  </tr>
</table>
<?php }?>
</div>

<div id="formdividerSub"></div>
<br>
<div>
<label id="lblShowAppInfo" for="chkShowAppInfo" title="If checked, details about appointments will be shown to all users.">Show Appointment Details</label>
<input type="checkbox" id="chkShowAppInfo" name="chkShowAppInfo" tabindex="60" value="show" <?php if ($block->showappinfo) echo ' checked="checked"';?>
onclick="if (this.checked) alert('If you check this box, then anyone viewing this block(s) will be able to see the full name, e-mail address and telephone number of everyone who has made an appointment in this block.  In other words, there will be no privacy associated with appointments made in this block(s). If that is what you want, then leave the box checked.  If not, uncheck the box.');">
<a href="#" onclick='openHelp("showappinfo",true);return false;' title='Help' ><img src="images/Q1_warning.gif" alt="Help" border="0" /></a>
<input type="hidden" id="hidOrigShowAppInfo" name="hidOrigShowAppInfo" value="<?php echo $block->showappinfo;?>" />
</div>

</div>

<br>

<div class="buttonsShort">
<input type="button" id="btnReset" name="btnReset" class="button1" value="Reset Form" tabindex="61" onclick="resetForm();">
<input type="submit" id="btnSubmit" name="btnSubmit" class="button1" value="Save" tabindex="62" onclick="return checkValidating();">
</div>

</fieldset>
<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>
</form>

<!--<script type="text/javascript" language="javascript">

	//Set up One-time vs. recurring
	var recurtype = GetElement("recur").value;
	var rectype = recurtype == "once" ? "OneTime" : "Recur";
	changeSection(rectype,recurtype);
	/*ToggleTwoSections('divOneTime','divRecurring','show','linkOneTime','linkRecurring','showhide');
	document.g_sShownSection = "OneTime";*/

	resetForm();
</script>-->
</body>

</html>

<!--                   End of HTML Code                       -->
<?php

/* Function to read form data into an associative array */
function getBlockVals($in) {
	$out = array();



}



?>
<?php
function makeBlockURL($cal,$blk) {
	
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
	$fullurl = $urlhead . $_SERVER['SERVER_NAME'] . dirname($_SERVER['PHP_SELF']) . '/viewcalendar.page.php?makeapp=1&cal_id=' . $cal->calendarid . '&block_id=' . $blk->blockid;
	$url = $fullurl;
	
}
?>