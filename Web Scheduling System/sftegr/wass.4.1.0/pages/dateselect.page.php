<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

        This page is a pop-up calendar used for selecting dates from other forms.
        GET Arguments:
			- fld: the HTML field name where the selected date will appear on the opening window.
 
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
	
}/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Make sure we are running under SSL (if required) */
wassUtil::CheckSSL();
 
/* Start session support */
session_start();


/*
Handle a form submission.
*/
if ($_POST['btnSubmit']) {

/* This page does not do a form submission. */

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
<title>Select Date</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/calendar.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	margin: 4px;
}
</style>
<script type="text/javascript" language="javascript" src="js/global.js"></script>
<script type="text/javascript" language="javascript" src="js/calendar.js"></script>
<script type="text/javascript" language="javascript">
function init() {
	var dtShown =  new Date();
	var strDate = "";
	var win = window.opener;
	if (win != null) {
		var elDate = win.GetElement("<?php echo trim($_REQUEST['fld']);?>");
		if (elDate != null)
			strDate = elDate.value;
	}
	if (strDate != "") {
		dtShown = GetDateFromDisplay(strDate);
	}
	drawcal(dtShown);
}
function drawcal(inDate) {
	calendar.removeCalendars("divCal");
	var yr = inDate.getFullYear();
	var mo = inDate.getMonth();
	var calid = "cal" + yr + mo;
	var m1 = new calendar(calid,mo,yr,"month",inDate,inDate,"divCal",true,1,true);
	m1.writeCalendar();
	document.arr_CalShown.push(m1);
}

//overwrite for calendar
calendar.changeDate = function(inTDID) {
	//What date was selected?
	var dt = calendar.getDateFromTDID(inTDID);
	
	//Format the date
	var strDate = GetDisplayDate(dt);
	
	//Populate the text field
	var win = window.opener;
	if (win != null)
		win.GetElement("<?php echo trim($_REQUEST['fld']);?>").value = strDate;
	self.close();
}
calendar.changeMonthNext = function(e) {
	if (!e) e = window.event;  // IE Event Model
	calendar.changeMonths("next","divCal");
}
calendar.changeMonthPrevious = function(e) {
	if (!e) e = window.event;  // IE Event Model
	calendar.changeMonths("previous","divCal");
}
calendar.redrawCalendars = function(inDirection,inArrShownMonths,inArrShownDates) {
	//draw the new months
	var newDate = null;
	if (inDirection == "next") {
		newDate = inArrShownMonths[0];
		newDate.setMonth(newDate.getMonth() + 1);
	} else { //inDirection == "previous"
		newDate = inArrShownMonths[0];
		newDate.setMonth(newDate.getMonth() - 1);
	}
	drawcal(newDate);
}
</script>
</head>

<body onload="init();">
<form id="frmCal" name="frmCal" action="#" method="post">
<div id="divCal">

</div>
</form>
</body>
</html>


<!--                   End of HTML Code                       -->
<?php

?>