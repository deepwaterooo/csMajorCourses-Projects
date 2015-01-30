document.g_isGetBlocks = false;
var sCals_availblocks = null;
document.sCals_datestatus = null;
var maxApptsForBlock = null;

/************************************/
/* changeCalDisplayView				*/
/************************************/
//Change the Display of the Main Calendar and small calendars to the given view
//THIS is what should be called from every method where a redraw needs to occur.
function changeCalDisplayView(inView,inRotateDirection,inIsRefreshDay,inIsSpecificDateSelected) {
 	var isChangingViews = false;
	if (inView != document.iViewSlotSize) isChangingViews = true;
	
	if (inIsSpecificDateSelected == undefined || inIsSpecificDateSelected == null)
		inIsSpecificDateSelected = false;

	if (document.dtViewStartTime == null) document.dtViewStartTime = new Date();
	if (document.dtViewEndTime == null) document.dtViewEndTime = new Date();
	
	var stdt = new Date(document.dtViewStartTime.getTime());
	var enddt = new Date(document.dtViewEndTime.getTime());
	var today = new Date();
	today.setHours(0);
	today.setMinutes(0);
	today.setSeconds(0);
	
	var isGoToServer = true; //should we go to the server for updated info?
	var isRefreshDay = false;
	if (inIsRefreshDay != undefined && inIsRefreshDay != null) isRefreshDay = inIsRefreshDay;
	
	//take action based on the current view (document.iViewSlotSize)
	if (document.iViewSlotSize == "week") {
		if (inView == "week") {
			//do nothing
		} else if (inView == "month") {
			//KDC, 8-5-2009. Week may be displaying multiple months.  If current day shown in week, go to today's month.
			//else, get the month containing the first day of the week (in document.dtViewStartTime)
			if (areDatesInSameWeek(document.dtViewStartTime, today)) {
				stdt = new Date(today.getTime());
			}
			else {
				stdt = new Date(document.dtViewStartTime.getTime());
			}
			stdt.setDate(1);
			enddt = new Date(stdt.getTime());
			enddt.setDate(calendar.getNumDaysInMonth(enddt.getMonth()+1,enddt.getFullYear()));
			enddt.setHours(23);
			enddt.setMinutes(59);
			enddt.setSeconds(59);
		} else { //day
			//KDC, 8-5-2009. If the current day is in the week, go to that day instead of the first day
			//else, get the first day of the week (in document.dtViewStartTime)
			//KDC, 11-29-2009. Added check for inIsSpecificDateSelected)
			if (areDatesInSameWeek(document.dtViewStartTime, today) && !inIsSpecificDateSelected) {
				stdt = new Date(today.getTime());
			}
			else {
				stdt = new Date(document.dtViewStartTime.getTime());
			}
			stdt.setHours(document.iDefaultStartHour);
			stdt.setMinutes(document.iDefaultStartMinutes);
			stdt.setSeconds(document.iDefaultStartSeconds);
			enddt = new Date(stdt.getTime());
			enddt.setHours(document.iDefaultEndHour);
			enddt.setMinutes(document.iDefaultEndMinutes);
			enddt.setSeconds(document.iDefaultEndSeconds);
		}
	
	} else if (document.iViewSlotSize == "month") {
		if (inView == "week") {
			//get the week containing the first day of the month (in document.dtViewStartTime)
			//KDC, 2-26-2009. If today's date is in the currently displayed month, go to that week.
			if (areDatesInSameMonth(today,document.dtViewStartTime)) {
				stdt = calendar.getWeekStart(today);
				enddt = calendar.getWeekEnd(today,stdt);
				stdt.setHours(0);
				stdt.setMinutes(0);
				stdt.setSeconds(0);
				enddt.setHours(23);
				enddt.setMinutes(59);
				enddt.setSeconds(59);
			} else {
				stdt = calendar.getWeekStart(document.dtViewStartTime);
				enddt = calendar.getWeekEnd(document.dtViewStartTime,stdt);
			}
		} else if (inView == "month") {
			//do nothing
		} else { //day
			//KDC, 8-5-2009. If current day is in the displayed month, go to that day.
			//else, get the first day of the month (in document.dtViewStartTime)
			if (areDatesInSameMonth(document.dtViewStartTime, today) && isDateBetween(today,document.dtViewStartTime,document.dtViewEndTime) && !inIsSpecificDateSelected) {
				stdt = new Date(today.getTime());
			}
			else {
				stdt = new Date(document.dtViewStartTime.getTime());
			}
			enddt = new Date(stdt.getTime());
			enddt.setHours(document.iDefaultEndHour);
			enddt.setMinutes(document.iDefaultEndMinutes);
			enddt.setSeconds(document.iDefaultEndSeconds);
		}

	} else { //day
		if (inView == "week") {
			//get the week containing this day (in document.dtViewStartTime)
			stdt = calendar.getWeekStart(document.dtViewStartTime);
			stdt.setHours(0);
			stdt.setMinutes(0);
			stdt.setSeconds(0);
			enddt = calendar.getWeekEnd(document.dtViewStartTime,stdt);
			enddt.setHours(23);
			enddt.setMinutes(59);
			enddt.setSeconds(59);
		} else if (inView == "month") {
			//get the month containing this day (in document.dtViewStartTime)
			stdt = new Date(document.dtViewStartTime.getTime());
			stdt.setDate(1);
			stdt.setHours(0);
			stdt.setMinutes(0);
			stdt.setSeconds(0);
			enddt = new Date(stdt.getTime());
			enddt.setDate(calendar.getNumDaysInMonth(enddt.getMonth()+1,enddt.getFullYear()));
			enddt.setHours(23);
			enddt.setMinutes(59);
			enddt.setSeconds(59);
		} else { //day
			if (document.iViewSlotSize != inView)
				isGoToServer = isRefreshDay;
		}		
	}
	
//	alert(stdt + "," + enddt);
	document.iViewSlotSize = inView;
	document.dtViewStartTime = new Date(stdt.getTime());
	document.dtViewEndTime = new Date(enddt.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);

	// Draw main calendar
	drawNewCalendarDay(document.dtViewStartTime,document.dtViewEndTime, isGoToServer);
	if (isGoToServer) updateCalHeader(document.dtViewStartTime,document.dtViewEndTime);

	// Draw side calendars
	var mo = stdt.getMonth();		//should occur only on init
	var yr = stdt.getFullYear();	//should occur only on init
	//alert( mo + "," + yr );
	if (document.arr_CalShown.length > 0) {
		mo = document.arr_CalShown[0].month;
		yr = document.arr_CalShown[0].year;
		if (inRotateDirection == "next") {
			mo = mo + 1;
			if (mo == 12)
			{
				mo = 0;
			}
		}
	}
	
	//KDC, 3-5-2008
	//set styles for view tab/buttons
	var el = GetElement("vw" + document.iViewSlotSize);
	el.className = "ViewTab";
	el = GetElement("vw" + inView);
	el.className = "ViewTabSel";

	//alert( mo + "," + yr + "," + stdt + "," + enddt );
	calendar.drawTwoCalendars(mo,yr,stdt,enddt);
}

/************************************/
/* drawNewCalendarDay				*/
/************************************/
//Sets up the drawing of the main calendar (calls ajax)
function drawNewCalendarDay(inStartDate,inEndDate,isGoToServer) {
	document.g_isGetBlocks = false;
// not necessary - already done in calling method?  what's with the blocks, though...
	if (inStartDate != undefined && inEndDate != undefined) {
		document.dtViewStartTime = inStartDate;
		document.dtViewEndTime = inEndDate;
		setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);
		document.g_isGetBlocks = true;
	}


	var dtDisplayStart = new Date(document.dtViewStartTime.getTime());
	var dtDisplayEnd = new Date(document.dtViewEndTime.getTime());
	
	//alert( '***' + "," + dtDisplayStart + "," + dtDisplayEnd );
	if (isGoToServer) ajax_initCalendar(document.iCalendarID,document.sUserID,dtDisplayStart,dtDisplayEnd,document.g_isGetBlocks,document.g_BlockOwnerID);
	else drawCal();
}

/************************************/
/* drawCal							*/
/************************************/
//Actually draws the calendar, after all info has been obtained via AJAX
///do we need this??? or can we call drawCalendar directly?  and put in some of this code?
function drawCal() {
	//remove the previous calendar
	var par = GetElement(document.c_sMainCalContainerDivID);
	var el = GetElement(document.sMainCalTableID);
	if (el != null)
		par.removeChild(el);

	//set up styling for the calendar by setting the container div
	if (document.iViewSlotSize == "month" || document.iViewSlotSize == "week") {
		document.sMainCalTableID = document.c_sMonthCalTableID;
	} else {
		document.sMainCalTableID = document.c_sDayCalTableID;
	}

	var dtDisplayStart = new Date(document.dtViewStartTime.getTime());
	var dtDisplayEnd = new Date(document.dtViewEndTime.getTime());
	drawCalendar(dtDisplayStart,dtDisplayEnd,document.c_sMainCalContainerDivID);
}

/************************************/
/* openDayFromMonth					*/
/************************************/
function openDayFromMonth(inCalendarID,inCalOwner,inCalTitle,inStartDate,inEndDate) {
	document.dtViewStartTime = new Date(inStartDate.getTime());
	document.dtViewStartTime.setHours(document.iDefaultStartHour);
	document.dtViewStartTime.setMinutes(document.iDefaultStartMinutes);
	document.dtViewStartTime.setSeconds(document.iDefaultStartSeconds);
	//JJC, 10-4-2007.  This doesn't refresh the menu items.  redraw the entire calendar.
	//alert( document.dtViewStartTime );
	GetElement("st_dt").value = formatDateforServer(document.dtViewStartTime);
	//GetElement("st_tm").value = formatTimeforServer(document.dtViewStartTime);
	GetElement("st_tm").value = formatTimeforServer(document.dtViewStartTime) + ":00";
	//alert( GetElement("st_dt").value );

	//GetElement("st_dt").value = '';
	//GetElement("st_tm").value = '';
	
	//for multiple calendars:
	document.iCalendarID = new Array();
	document.iCalendarID.push(inCalendarID);
	
	//KDC, 5-1-2009. If in merged calendar and open a day, going to single calendar mode.
	GetElement("cal_id").value = inCalendarID;
	
	document.isMultiCalendar = false;
	
	//KDC, 5-1-2009. Turn on the calendar setup for going to single view mode.
	setCalSetupDisplay("on","?cal_id=" + inCalendarID);
	
	//alert( "openDayFromMonth isMultiCalendar=" + document.isMultiCalendar );
	//alert( "openDayFromMonth inCalOwner=" + inCalOwner );
	setCalendarTitle(inCalTitle);
	GetElement("cal_id").value = inCalendarID;
	//KDC, 6/3/2009. Removed hidUseCalendarID, so commented below
	//GetElement("hidUserCalendarID").value = inCalendarID;
	GetElement("hidCalOwnerName").value=safeHTMLJS(inCalOwner);
	GetElement("hidCalTitle").value=safeHTMLJS(inCalTitle);

	//changeCalDisplayView("15","current"); //KDC, 2-19-2008. changed to day for new dayview overhaul
	changeCalDisplayView("day","current",null,true);
		//JJC, 10-4-2007.  This doesn't refresh the menu items.  redraw the entire calendar.
		///document.frmViewCal.action = "viewcalendar.page.php?sView=15&cal_id=" + inCalendarID;
		//alert( document.frmViewCal.action );
		//document.frmViewCal.submit();
	//KDC, 1-10-2008. The above change doesn't do a lot of complicated calendar logic!  Need to rework refreshing the menu items.
}


document.iBestView = document.sDefaultViewSlotSize;

/************************************/
/* updateViewList					*/
/************************************/
//KDC, 3-5-2008. The function below is no longer used.
// updates the drop-down list of timeslots, given an array of values
function updateViewList(inSlotSizeArray) {  //called from show_getValidViews
	var iCurrentSlotSize = document.iViewSlotSize;


	//get the select list for views. if it's null, draw it.
	var sel = GetElement(document.c_sViewsSelectID);
	if (sel == null) {	
		var par = GetElement("divCalendarHeader");
		sel = document.createElement("SELECT");
		sel.id = document.c_sViewsSelectID;
		sel.name = "view";
		sel.onchange = changeView;
		par.appendChild(sel);
	}

//KDC, 2-19-2008. Note that this could be cleaned up since we now don't need to get "getvalidviews" from ajax.  This wouldn't need to rebuild the select list, just set the correct default value (that is, if the drop-down is built originally elsewhere)
	//reset the options
	sel.options.length = 0;
	
	var iSelectedView = iCurrentSlotSize;
	iSelectedView = document.iBestView;

	//create the new options
	var i=0;
/*
	if (!document.isMultiCalendar)
	{
		if ( iCurrentSlotSize == 'week' || iCurrentSlotSize == 'month' )
		{
			sel.options[i] = new Option("Day",inSlotSizeArray[i]);
			sel.options[i].selected = true;
			document.iViewSlotSize = inSlotSizeArray[i];
		} else
		{
			for (i=0; i < inSlotSizeArray.length; i++)
			{
				sel.options[i] = new Option("Day x " + inSlotSizeArray[i] + " min",inSlotSizeArray[i]);
				if (inSlotSizeArray[i] == iSelectedView) {
					sel.options[i].selected = true;
					document.iViewSlotSize = inSlotSizeArray[i];
				}
			}
		}
	}
*/
	sel.options[i] = new Option("Day","day");
	if ("day" == iCurrentSlotSize) {
		sel.options[i].selected = true;
		document.iViewSlotSize = "day";
	}
	i = sel.options.length;
	sel.options[i] = new Option("Week","week");
	if ("week" == iCurrentSlotSize) {
		sel.options[i].selected = true;
		document.iViewSlotSize = "week";
	}
	i = sel.options.length;
	if (!document.isMultiCalendar) {
		sel.options[i] = new Option("Month","month");
		if ("month" == iCurrentSlotSize) {
			sel.options[i].selected = true;
			document.iViewSlotSize = "month";
		}
	}
}

function updateHeaderDayType(inDayType) {
	var elDiv = GetElement("divCalHeadDayType");
	if (elDiv != null) {
		elDiv.innerHTML = safeHTML(inDayType);	
	}
}

/************************************/
/* changeView						*/
/************************************/
//This is called onchange in the view drop-down list.
/*function changeView(e) {
	if (!e) var e = window.event;
	
	//alert( "dtDisplayStart=" + document.dtDisplayStart );
	//Get the select list
	var sel = GetElement(document.c_sViewsSelectID);
	//Get the selected option and set the global slot size variable to that value.
	var opt = sel.options[sel.selectedIndex].value;
	
	//redisplay the calendars - main and small
	changeCalDisplayView(opt,"current");
}*/
//KDC, 3-5-2008. Changed due to view list no longer select - now buttons
function changeView(inNewView) {
	//redisplay the calendars - main and small
	changeCalDisplayView(inNewView,"current");
}

/************************************/
/* show_getDayTypes (overwrite)		*/
/************************************/
/* overwrite AJAX show functions */
function show_getDayTypes(arrDayTypes) {
	document.arrDayTypes = new Array();
	document.arrDayTypes = arrDayTypes;
	if (document.iViewSlotSize == "month") {
	} else if (document.iViewSlotSize == "week") {
	} else { //day
		updateHeaderDayType(arrDayTypes[0]);
	}
}
/************************************/
/* show_getBestView (overwrite)		*/
/************************************/
/* overwrite AJAX show functions */
function show_getBestView(sBestView) {
	document.iBestView = sBestView;
}
/************************************/
/* show_getValidViews (overwrite)	*/
/************************************/
/* overwrite AJAX show functions */
//KDC, 3-5-2008. The function below is no longer used.
function show_getValidViews(sViews) {
	//alert("showing!");
	var arrViews = parseTimeSlotSizes(sViews);
	updateViewList(arrViews);
}
