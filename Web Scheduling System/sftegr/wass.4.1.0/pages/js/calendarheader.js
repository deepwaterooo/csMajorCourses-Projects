// calendarheader.js draws the header bar for the calendar
var g_iTimeChangeIncr = 4;

function mainCalChangeMonthPrev() {
	var dir = "previous";
	//Are we displaying the "top" month in the list?  If not, dir is "current".
	if (document.arr_CalShown[0].month != document.dtViewStartTime.getMonth()) {
		dir = "current";
	}
	calendar.changeMonths(dir,document.c_sSmallCalContainerDivID);
	setCalDateLink(); //KDC, 1-24-2010.
}
function mainCalChangeMonthNext() {
	var dir = "next";
	calendar.changeMonths(dir,document.c_sSmallCalContainerDivID);
	setCalDateLink(); //KDC, 1-24-2010.
}
function mainCalChangeWeekPrev() {
	var sd = new Date(document.dtViewStartTime);
	sd.setDate(sd.getDate() - 7);
	var ed = new Date(document.dtViewEndTime);
	ed.setDate(ed.getDate() - 7);
	document.dtViewStartTime = new Date(sd.getTime());
	document.dtViewEndTime = new Date(ed.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,"week");
	changeCalDisplayView("week","current");	
	setCalDateLink(); //KDC, 1-24-2010.
}
function mainCalChangeWeekNext() {
	var sd = new Date(document.dtViewStartTime);
	sd.setDate(sd.getDate() + 7);
	var ed = new Date(document.dtViewEndTime);
	ed.setDate(ed.getDate() + 7);
	document.dtViewStartTime = new Date(sd.getTime());
	document.dtViewEndTime = new Date(ed.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,"week");
	changeCalDisplayView("week","current");	
	setCalDateLink(); //KDC, 1-24-2010.
}
/* KDC, 2-19-2008. Not used in day view overhaul */
/*
function mainCalChangeTimePrev() {
	//if we're already at the beginning of the day, do nothing
	if (document.dtViewStartTime.getHours() == 0) return false; 

	var sd = new Date(document.dtViewStartTime);
	var ed = new Date(document.dtViewEndTime);
	var numhrs = document.dtViewEndTime.getHours() - document.dtViewStartTime.getHours();
	var hr = document.dtViewStartTime.getHours() - g_iTimeChangeIncr;
	if (hr < 0) hr = 0;
	sd.setHours(hr);
	ed.setHours(hr + numhrs);
	document.dtViewStartTime = new Date(sd.getTime());
	document.dtViewEndTime = new Date(ed.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);
	changeCalDisplayView(document.iViewSlotSize,"current");	
}
function mainCalChangeTimeNext() {
	//if we're already at the end of the day, do nothing
	if (document.dtViewEndTime.getHours() == 24 || document.dtViewEndTime.getHours() == 0) return false;

	var sd = new Date(document.dtViewStartTime);
	var ed = new Date(document.dtViewEndTime);
	var numhrs = document.dtViewEndTime.getHours() - document.dtViewStartTime.getHours();
	var hr = document.dtViewEndTime.getHours() + g_iTimeChangeIncr;
	if (hr > 24 || hr < document.dtViewStartTime.getHours()) hr = 24;
	ed.setHours(hr);
	sd.setHours(hr - numhrs);
	document.dtViewStartTime = new Date(sd.getTime());
	document.dtViewEndTime = new Date(ed.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);
	changeCalDisplayView(document.iViewSlotSize,"current");	
}
*/
function mainCalChangeDayPrev() {
	var dt = new Date(document.dtViewStartTime);
	dt.setDate(dt.getDate()-1);
	calendar.showNewDate(dt,null);
	setCalDateLink(); //KDC, 1-24-2010.
}
function mainCalChangeDayNext() {
	var dt = new Date(document.dtViewStartTime);
	dt.setDate(dt.getDate()+1);
	calendar.showNewDate(dt,null);
	setCalDateLink(); //KDC, 1-24-2010.
}

function updateCalHeader(inStartDateTime,inEndDateTime) {
	var hdr = GetElement("divCalendarHeader");
	var sHTML = "";
	if (document.iViewSlotSize == "month") {
		sHTML += '<div class="CalHeadTime">';
		sHTML += '<a href="#" onclick="mainCalChangeMonthPrev();return false;"><img src="images/arrow_Lblue.gif" alt="previous month" title="previous month" border="0" class="icon" /></a> ';
		sHTML += months[inStartDateTime.getMonth()] + " " + inStartDateTime.getFullYear();
		sHTML += ' <a href="#" onclick="mainCalChangeMonthNext();return false;"><img src="images/arrow_Rblue.gif" alt="next month" title="next month" border="0" class="icon" /></a>';
		sHTML += '</div>';
		
	} else if (document.iViewSlotSize == "week") {
		sHTML += '<div class="CalHeadTime">';
		sHTML += '<a href="#" onclick="mainCalChangeWeekPrev();return false;"><img src="images/arrow_Lblue.gif" alt="previous week" title="previous week" border="0" /></a> ';
		
		var m1 = months[inStartDateTime.getMonth()];
		var d1 = inStartDateTime.getDate();
		var y1 = "";
		var m2 = "";
		var d2 = inEndDateTime.getDate();
		var y2 = inEndDateTime.getFullYear();
		if (inStartDateTime.getMonth() != inEndDateTime.getMonth())
			m2 = " " + months[inEndDateTime.getMonth()] + " ";
		if (inStartDateTime.getFullYear() != inEndDateTime.getFullYear())
			y1 = ", " + inStartDateTime.getFullYear() + " ";	
		sHTML +=  m1 + " " + d1 + y1 + "-" + m2 + d2 + ", " + y2;
		sHTML += ' <a href="#" onclick="mainCalChangeWeekNext();return false;"><img src="images/arrow_Rblue.gif" alt="next week" title="next week" border="0" /></a>';
		sHTML += '</div>';	
		
	} else { //any type of day timeslot or "day"
		var m = months[inStartDateTime.getMonth()];
		var d = inStartDateTime.getDate();
		var y = inStartDateTime.getFullYear();
		var dow = days[inStartDateTime.getDay()];
		var tm1 = GetDisplayTime(inStartDateTime);
		var tm2 = GetDisplayTime(inEndDateTime);
		sHTML += '<div class="CalHeadDate"><a href="#" onclick="mainCalChangeDayPrev();return false;"><img src="images/arrow_Lblue.gif" alt="previous day" title="previous day" border="0" /></a> ' + dow + ', ' + m + ' ' + d + ', ' + y + ' <a href="#" onclick="mainCalChangeDayNext();return false;"><img src="images/arrow_Rblue.gif" alt="next day" title="next day" border="0" /></a></div>';
		var daytype = "";
		sHTML += '<div id="divCalHeadDayType" class="CalHeadDayType">' + safeHTML(daytype) + '</div>';
		//KDC, 2-19-2008. Removing time scroll for day view overhaul
		/*
		sHTML += '<div class="CalHeadTime">';
		if (document.dtViewStartTime.getHours() > 0) {
			sHTML += '<a href="#" onclick="mainCalChangeTimePrev();return false;">';
			sHTML += '<img src="images/arrow_Lblue.gif" alt="advance time back" border="0" class="icon" />';
			sHTML += '</a> ';
		} else {
			sHTML += '<img src="images/arrow_Lblue.gif" alt="advance time back" border="0" class="icon" /> ';
		}
		sHTML += tm1 + ' - ' + tm2;
		if (document.dtViewEndTime.getHours() > 0 && document.dtViewEndTime.getHours() < 24) {
			sHTML += ' <a href="#" onclick="mainCalChangeTimeNext();return false;">';
			sHTML += '<img src="images/arrow_Rblue.gif" alt="advance time ahead" border="0" class="icon" />';
			sHTML += '</a>';
		} else {
			sHTML += ' <img src="images/arrow_Rblue.gif" alt="advance time ahead" border="0" class="icon" />';
		}
		sHTML += '</div>';
		*/
	}

//KDC, 4-29-2009. For multi-calendar viewing, disable day and week view
var sClkDay = ' onclick="changeView(\'day\');"';
var sClkMonth = ' onclick="changeView(\'month\');"';
var sClassDay = "ViewTab";
var sClassMonth = "ViewTab";
//KDC, 6-22-2009. Commenting out because we're allowing users to view multiple calendars in all views
/*if (document.isMultiCalendar) {
	sClassDay = "ViewTabDisabled";
	sClassMonth = "ViewTabDisabled";
}*/

//KDC, 3-5-2008. Changed views to tabs/buttons
sHTML += '<div class="CalHeadView">';
sHTML += '<div id="vwday" class="' + sClassDay + '" style="border-left-width: medium;"' + sClkDay + '>Day</div>';
sHTML += '<div id="vwweek" class="ViewTab" onclick="changeView(\'week\');">Week</div>';
sHTML += '<div id="vwmonth" class="' + sClassMonth + '"' + sClkMonth + '>Month</div>';
sHTML += '</div></div>';
hdr.innerHTML = sHTML;

	setCalDateLink(); //KDC, 1-24-2010
}


//KDC, 10-21-2007. Get infmsg, errmsg from viewcalendar.page.php to display message, if applicable
var infmsg = "";
if (GetElement("infmsg") != null)
	infmsg = GetElement("infmsg").value;
var errmsg = "";
if (GetElement("errmsg") != null)
	errmsg = GetElement("errmsg").value;

//figure out the page title, user ID
//KDC, 7-23-2008. Updated way calendar title is displayed from name to cal title itself
var sCalTitle = "";
if (GetElement("hidCalTitle") != null)
	sCalTitle = GetElement("hidCalTitle").value;

var sHTML = '';
//KDC, 10-21-2007. For infmsg/errmsg
if (infmsg != "") {
	sHTML += '<div id="confirm" style="margin-top:5px;margin-left:5px;">' + infmsg + '<br><a href="#" onclick="closeMessage(\'confirm\');return false;">close message</a></div>';
}
if (errmsg != "") {
	sHTML += '<div id="error">' + errmsg + '<br><a href="#" onclick="closeMessage(\'error\');return false;">close message</a></div>';
}

sHTML += '<div class="CalHead">';



sHTML += '<div style="height:10px;">';
/* KDC, 3-15-11, removed */
/*if (history.length > 0) {
	sHTML += '<div class="CalHeadBack"><a href="javascript:history.go(-1);"><img src="images/arrow_Lblue.gif" alt="go back" title="go back" border="0"/>&nbsp;back</a></div>';
} else {
	
}*/
sHTML += '<div id="caltitle" class="CalHeadTitle">' + safeHTML(sCalTitle) + '</div>';
sHTML += '<div class="CalHeadPrint"><a href="javascript:print();"><img src="images/print.gif" alt="print" border="0" class="icon" /></a></div>';
sHTML += '</div><br />';

sHTML += '<div id="divCalendarHeader">';

sHTML += '</div>';
sHTML += '</div>';


//KDC, 1-22-2010.  For getting a direct link to this page
function getCalDateLinkText() {
	var sText = "";
	if (document.iViewSlotSize == "week") 
		sText += "Week";
	else if (document.iViewSlotSize == "month") 
		sText += "Month";
	else
		sText += "Day";
	return sText;
}
function setCalDateLink() {
	//GetElement("divLinkWin").style.visibility = "hidden";
	var sURL = "";
	sURL += GetElement("hidAJAXSchemaRoot").value + "pages/viewcalendar.page.php";
	sURL += "?cal_id=" + GetElement("cal_id").value;
	sURL += "&view=" + document.iViewSlotSize;
	sURL += "&st_dt=" + formatDateforServer(document.dtViewStartTime);
	sURL += "&makeapp=1";
	GetElement('divLinkWin').innerHTML = sURL;
	var sText = "<span>Display direct URL (link) for this " + getCalDateLinkText() + "</span>";
	GetElement("divLinkBar").innerHTML = sText;
}
sHTML += '<div id="divDirectURL" style="width:100%;"><div id="divLinkBar" onmouseover="setCalDateLink();ToggleVisOn(\'divLinkWin\');" onmouseout="ToggleVisOff(\'divLinkWin\');">';
//note, text is set in setCalDateLink()
sHTML += '</div>';
sHTML += "<div class='icon'><a href='#' onclick='openHelp(\"links\",true);return false;' title='Help' ><img src='images/Q1.gif' alt='Help' border='0' /></a></div>";
sHTML += '</div>';
sHTML += '<div id="divLinkWin" style="visibility:hidden;" onmouseover="setCalDateLink();ToggleVisOn(\'divLinkWin\');" onmouseout="if (this.style.visibility=\'hidden\') ToggleVisOff(\'divLinkWin\');"></div>';

document.write(sHTML);

function setCalendarTitle(inCalTitle) {
	GetElement("caltitle").innerHTML = safeHTML(inCalTitle);
}