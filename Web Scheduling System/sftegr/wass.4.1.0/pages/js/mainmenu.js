// mainmenu.js draws the right-hand menu, according to what page you're on

var sPage = "";
if (GetElement("hidPage") != null)
	sPage = GetElement("hidPage").value;
	
var sCalID = "";
if (GetElement("cal_id") != null)
	sCalID = GetElement("cal_id").value;

var isMultipleCals = sCalID.indexOf(",") != -1 ? true : false;

var sStartDate = "";
if (GetElement("st_dt") != null)
	sStartDate = GetElement("st_dt").value;
var sStartTime = "";
if (GetElement("st_tm") != null)
	sStartTime = GetElement("st_tm").value;
var sEndDate = "";
if (GetElement("ed_dt") != null)
	sEndDate = GetElement("ed_dt").value;
var sEndTime = "";
if (GetElement("ed_tm") != null)
	sEndTime = GetElement("ed_tm").value;
	
var sMakeApp = GetElementCheck("hidMakeApp", "makeapp");
var sUCal_id = GetElementValue("hidUCal_id");


//what type of user is this?  guest, logged in w/no calendar, logged in w/calendar, manager
var isGuest = isUserGuest();
var isManager = WASSCalendar.IsUserManager(document.sUserID);
var hasCalendar = WASSCalendar.DoesUserOwnPersonalCalendar(document.sUserID);

var doesOwnOrManageMultipleCals = (WASSCalendar.GetNumCalendars() > 1);
var doesOwnOrManageAnyCals = (WASSCalendar.GetNumCalendars() > 0);

//user has to select a calendar on the manage page if there is more than one or he/she doesn't have
var doesHaveToSelectCal = doesOwnOrManageMultipleCals;

//figure out selected menu option
var sClsManageCals, sClsCalSetup, sClsViewCal, sClsMakeAppt, sClsSearchAppts, sClsCreateCal;
sClsManageCals = sClsCalSetup = sClsViewCal = sClsMakeAppt = sClsSearchAppts = sClsCreateCal = "";
if (sPage == "managecalendars") sClsManageCals = ' class="selected"';
if (sPage == "calendarsetup") {
	if (sCalID == "")
		sClsCreateCal = ' class="selected"';
	else
		sClsCalSetup = ' class="selected"';
}
if (sPage == "viewcalendar" & sMakeApp != 1 )
	sClsViewCal = ' class="selected"';
if (sPage == "makeappt")
	sClsMakeAppt = ' class="selected"';
else { //catch-all to make sure makeappt is selected if user is making an appt
	if ( sMakeApp == 1 )
		sClsMakeAppt = ' class="selected"';
}
if (sPage == "searchappts") sClsSearchAppts = ' class="selected"';


//can you click on menu items, and if so, what is the action?
var sClickManageCals, sClickCalSetup, sClickViewCal, sClickMakeAppt, sClickSearchAppts, sClickAddBlock, sClickCreateCal, sClickApply;
sClickManageCals = sClickCalSetup = sClickViewCal = sClickMakeAppt = sClickSearchAppts = sClickAddBlock = sClickCreateCal = sClickApply = "";
var sCloserManage, sCloserCalSetup, sCloserViewCal, sCloserMakeAppt, sCloserSearchAppts, sCloserAddBlock, sCloserCreateCal;
sCloserManage = sCloserCalSetup = sCloserViewCal = sCloserMakeAppt = sCloserSearchAppts = sCloserAddBlock = sCloserCreateCal = "";
if (isAuthenticated()) {
	//managecalendar
	sClickManageCals = '<a href="managecalendars.page.php">';
	//calendarsetup
	//if the user owns only one calendar and does not manage any calendars, always go to the owned cal
	if (WASSCalendar.DoesUserOwnPersonalCalendarOnly(document.sUserID)) {
		sClickCalSetup = '<a href="calendarsetup.page.php?cal_id=' + sUCal_id + '">';
		sCloserCalSetup = '</a>';
	} else {
		//if there is a calendar selected, and only one, go to it
		if (sCalID != "" && !isMultipleCals && sMakeApp != 1) { 
			sClickCalSetup = '<a href="calendarsetup.page.php?cal_id=' + sCalID + '">';
			sCloserCalSetup = '</a>';
		}
		//KDC, 10-7-2009.
		if (sMakeApp == 1) {
			sClickCalSetup = "";
			sCloserCalSetup = "";
		}
	}
	//viewcalendar
	//if the user owns only one calendar and does not manage any calendars, always go to the owned cal
	if (WASSCalendar.DoesUserOwnPersonalCalendarOnly(document.sUserID)) { 
		sClickViewCal = '<a href="viewcalendar.page.php?cal_id=' + sUCal_id + '">';
	} else {
		if (sMakeApp == 1 || sCalID == "")
			sClickViewCal = "";
		else
		//otherwise, go to the selected calendar(s)
		sClickViewCal = '<a href="viewcalendar.page.php?cal_id=' + sCalID + '">';
	}
	sCloserViewCal = '</a>';

	//makeappt
	sClickMakeAppt = '<a href="makeappt.page.php">';
	//searchappts
	sClickSearchAppts = '<a href="searchappts.page.php">';	
	sCloserManage = sCloserMakeAppt = sCloserSearchAppts = '</a>';
	
	//addblock
	if (sPage == "viewcalendar" && WASSCalendar.CanUserAddBlocks(document.sUserID) && !isMultipleCals && sMakeApp == 0) {
		sClickAddBlock = '<a href="#" onclick="addBlock(' + sCalID + ',\'' + sStartDate + '\',\'' + sEndDate + '\',\'' + sStartTime + '\',\'' + sEndTime + '\');return false;">';
		sCloserAddBlock = '</a>';
	}

	//If there is more than one calendar, you can't click on calendar setup or view calendar without first selecting a cal
	if (doesOwnOrManageMultipleCals && (sPage == "makeappt" || sPage == "searchappts")) {
			sClickCalSetup = '';
			sCloserCalSetup = '';
			sClickViewCal = '';
			sCloserViewCal = '';
	}

}

var sHTML = "";
sHTML += '<div id="menu">';

//top menu section appears only if user is not a guest
if (!isGuest) {
	//If user doesn't have a calendar, show create calender.
	if (!hasCalendar) {
		sHTML += '<ul id="navlist">';
		sHTML += '<li' + sClsCreateCal + '><div class="menu"><a href="calendarsetup.page.php?cal_id=">' + 'Create Calendar' + sCloserCreateCal + '</div></li>';
	//KDC, 8-3-2008. Changing location of "apply to manage" button from calendar setup - in menu if no calendar owned
		sHTML += '<li><div class="menu"><a href="javascript:OpenWin(\'apply.page.php\',830,730,\'scrollbars=yes,resizeable=yes\');" title="If you need to manage someone else\'s calendar, click Apply and follow the instructions">Apply to Manage</a></div></li></ul>';
	}
	
	var isListStart = false;
	
//	alert(WASSCalendar.DoesUserOwnMultipleCalendars(document.sUserID));
	if (isManager || WASSCalendar.DoesUserOwnMultipleCalendars(document.sUserID)) {
		sHTML += '<ul id="navlist">';
		isListStart = true;
		sHTML += '<li' + sClsManageCals + '><div class="menu">' + sClickManageCals + 'Manage Calendar(s)' + sCloserManage + '</div></li>';
	}

	//All the rest of the menu items require the user to have a calendar or be a manager
	if (hasCalendar || doesOwnOrManageAnyCals) {
		if (!isListStart) 
			sHTML += '<ul id="navlist">';
		//calendarsetup page
		sHTML += '<li' + sClsCalSetup + '><div id="calendarsetup" class="menu">' + sClickCalSetup + 'Calendar Setup' + sCloserCalSetup + '</div></li>';
	//KDC, 8-3-2008. Changing location of "apply to manage" button from calendar setup - in menu if no calendar owned
		if (!isManager) {
			sHTML += '<li><div class="menu"><a href="javascript:OpenWin(\'apply.page.php\',830,730,\'scrollbars=yes,resizeable=yes\');" title="If you need to manage someone else\'s calendar, click Apply and follow the instructions">Apply to Manage</a></div></li>';
		}
		//viewcalendar page
		var txt = "View Calendar";
		if (isManager) txt = "View Calendar(s)";
		sHTML += '<li' + sClsViewCal + '><div id="viewcalendar" class="menu">' + sClickViewCal + txt + sCloserViewCal + '</div></li>';
		//addblock
		sHTML += '<li><div id="addblock" class="menu">' + sClickAddBlock + 'Add Block(s)' + sCloserAddBlock + '</div></li>';
	//KDC, 7-8-2009. Making this show up all of the time, but in a different location in the list.
		if (isManager) {
			sHTML += '<li><div class="menu"><a href="javascript:OpenWin(\'apply.page.php\',830,730,\'scrollbars=yes,resizeable=yes\');" title="If you need to manage someone else\'s calendar, click Apply and follow the instructions">Apply to Manage</a></div></li>';
		}
	}
	sHTML += '</ul>';
} 

sHTML += '<ul id="navlist">';
sHTML += '<li' + sClsMakeAppt + '><div class="menu">' + sClickMakeAppt + 'Make an Appointment' + sCloserMakeAppt + '</div></li>';
sHTML += '<li' + sClsSearchAppts + '><div class="menu">' + sClickSearchAppts + 'Search Appointments' + sCloserSearchAppts + '</div></li>';
sHTML += '</ul>';

sHTML += '<ul id="navlist">';
sHTML += '<li><div class="menu"><a href="#" onclick="openHelp();return false;">Help</a></div></li>';
sHTML += '<li><div class="menu"><a href="#" onclick="openFAQ();return false;">FAQ</a></div></li>';
sHTML += '<li><div class="menu"><a href="#" onclick="openWhatsnew();return false;">What\'\s New</a></div></li>';
sHTML += '</ul>';

sHTML += '</div>';
sHTML += '';

//KDC, 12-14-2009.
if (sPage == "managecalendars" || sPage == "calendarsetup") {
	sHTML += '<div id="divDYK" class="extrainfoArea">';
	sHTML += '</div>';
}

document.write(sHTML);
//alert( "sHTML=" + sHTML );

//KDC, 1-13-2010. Abstracted out of divDYK above.
function drawDYK(inDYKLink) {
	var sHTML = "";
	var sHdr = GetElement("hidDYKHeader").value;
	sHTML += '<h4>Did You Know?</h4>';
	sHTML += '<div id="divDYKHeader" class="extrainfoContent">' + sHdr + ' <a href="#" onclick="OpenWin(\'' + inDYKLink + '\',400,400,\'scrollbars=yes,resizeable=yes\');">Learn more...</a></div>';
	sHTML += '<div class="extrainfoNav"><a href="#" onclick="ajax_getDidYouKnow();">Next ></a></div>';
	GetElement("divDYK").innerHTML = sHTML;
}

function setAddBlockDisplay(inStartDate,inEndDate,inView) {
//	alert("setting: " + document.isMultiCalendar);
	if (document.isMultiCalendar) return false; //KDC, 5-1-2009. Changed this from isMultipleCals to document.isMultiCalendar, which is reset in viewcalendar openDayFromMonth()
	
	//KDC, 8-5-2009. Need to account for current date
	var today = new Date();
	today.setHours(0);
	today.setMinutes(0);
	today.setSeconds(0);
	if (document.iViewSlotSize == "week" && areDatesInSameWeek(inStartDate, today) || document.iViewSlotSize == "month" && areDatesInSameMonth(inStartDate, today))
		var stdt = formatDateforServer(today);
	else 
		var stdt = formatDateforServer(inStartDate);
	var eddt = formatDateforServer(inEndDate);
	var sttm = formatTimeforServer(inStartDate);
	var tmpEnd = new Date(inEndDate.getTime());
	tmpEnd.setHours(inStartDate.getHours() + 1)
	var edtm = formatTimeforServer(tmpEnd);
	if (inView == "month" || inView == "week" || inView == "day") {
		sttm = "";
		edtm = "";
	}
	GetElement("st_dt").value = stdt;
	GetElement("st_tm").value = sttm;
	GetElement("ed_dt").value = eddt;
	GetElement("ed_tm").value = edtm;

	var el = GetElement("addblock");

	if ( el != null ) {
		var sClick = ""; var sCloser = "";
		if ( sMakeApp == 0 && WASSCalendar.CanUserAddBlocks(document.sUserID) ) {
			//KDC, 5-1-2009. Re-get the cal_id value  because it was updated when opening a single cal from merged view
			var calid = GetElement("cal_id").value; 
			var sClick = '<a href="#" onclick="addBlock(' + calid + ',\'' + stdt + '\',\'' + eddt + '\',\'' + sttm + '\',\'' + edtm + '\');return false;">';
			var	sCloser = "</a>";
		}
		//alert(sClick + "::" + sCloser);
		el.innerHTML = sClick + 'Add Block(s)' + sCloser;
	}
}
/* for manager view */
function setViewCalDisplay(inOnOff,inParms) {
	//KDC, 10-7-2009. Changed for when users are making appointments
	if (sMakeApp != 1) {
		if (inParms == undefined || inParms == null) inParms = "";
		var el = GetElement("viewcalendar");
		if ( el != null )
		{
			var sClick = "";
			var sCloser = "";
			if (inOnOff == "on")
			{
				sClick = '<a href="viewcalendar.page.php' + inParms + '">';
				sCloser = "</a>";
			}
			if ( !doesOwnOrManageMultipleCals )
				el.innerHTML = sClick + 'View Calendar' + sCloser;
			else
				el.innerHTML = sClick + 'View Calendar(s)' + sCloser;
		}
	}
}
function setCalSetupDisplay(inOnOff,inParms) {
	//KDC, 10-7-2009. Changed for when users are making appointments
	if (sMakeApp != 1) {
		if (inParms == undefined || inParms == null) inParms = "";
		var el = GetElement("calendarsetup");
		if ( el != null )
		{
			var sClick = "";
			var sCloser = "";
			if (inOnOff == "on")
			{
				sClick = '<a href="calendarsetup.page.php' + inParms + '">';
				sCloser = "</a>";
			}
			el.innerHTML = sClick + 'Calendar Setup' + sCloser;
		}
	}
}
function setItemDisplay(inItemID,inOnOff,inParms) {
	//alert("turning " + inItemID + " " + inOnOff);
//note: this is called from managecalendars, and passes the cal_id in inParms
	if (!isAuthenticated())
		inOnOff = "off";
	if (inItemID == "viewcalendar")
		setViewCalDisplay(inOnOff,inParms);
	else if (inItemID == "calendarsetup")
		setCalSetupDisplay(inOnOff,inParms);
}

