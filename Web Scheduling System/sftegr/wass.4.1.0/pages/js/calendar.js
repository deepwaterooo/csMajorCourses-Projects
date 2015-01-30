//Global variables for the page
document.arrDatesShownID = new Array();	//This represents the dates highlighted (small calendars only)
document.arr_CalShown = new Array();	//This represents the calendars shown (small calendars only)

var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');
var today = new Date();

/************************************/
/* calendar (constructor)			*/
/************************************/
//Constructor, creates a month-long calendar
function calendar(inID,inMonth,inYear,inDisplay,inSelStartDate,inSelEndDate,inParentElementID,isShowControls,inDOWLength,inIsSelectableDates){
	this.par = inParentElementID;
	this.id = inID;
	
	//calendar display values
	this.display = inDisplay; //week or month
	this.month = inMonth;
	this.year = inYear;
	this.datebegin = this.display == "month" ? 1 : (calendar.getWeekStart(inSelStartDate)).getDate();
	this.length = this.getLength();
	this.dateend = this.display == "month" ? this.length : this.datebegin + 6;

	//get the first day (of week) of the month's selected day
	var dtTmp = new Date(inYear,inMonth,this.datebegin,0,0,0);
	this.firstDay = dtTmp.getDay();

	//selected/highlighted days
	this.dtStart = new Date(inSelStartDate.getTime());
	this.dtEnd = new Date(inSelEndDate.getTime());		//KDC, note: for week calendars, this may be > this.length
	this.isSelectableDates = inIsSelectableDates; //keeping track of global day switching on small calendars
	
	this.isShowControls = isShowControls;
	this.iDOWLength = inDOWLength;
	this.sCalType = this.getCalSelectedType();
}

/************************************/
/* getNumDaysSelected (prototype)	*/
/************************************/
//using the calendar selected start date and end date, return the # days selected
calendar.prototype.getNumDaysSelected = function() {
	var iNumDays = this.dtEnd.getDate() - this.dtStart.getDate() + 1;
	return iNumDays;
}
/************************************/
/* getCalSelectedType (prototype)	*/
/************************************/
//based on the # days selected, return what type of calendar display it is (day, week, month)
calendar.prototype.getCalSelectedType = function() {
	var iNumDays = this.getNumDaysSelected();
	var type = "";
	if (iNumDays == 1)
		type = "day";
	else if (iNumDays == 7)
		type = "week";
	else
		type = "month";
	return type;
}
/************************************/
/* writeCalendar (prototype)		*/
/************************************/
//write the calendar by creating DOM HTML elements
calendar.prototype.writeCalendar = function(){
	var par = GetElement(this.par);
	var tblNode = document.createElement("TABLE");
	tblNode.id = this.id;
	tblNode.cellSpacing = "0";
	tblNode.cellPadding = "0";
	tblNode.border = "0";
	tblNode.className = "month";
	par.appendChild(tblNode);
	
	var tblBody = document.createElement("TBODY");
	tblNode.appendChild(tblBody);
	
	var trHeaderRow = document.createElement("TR");
	tblBody.appendChild(trHeaderRow);

	if (this.isShowControls) {
		var tdBack = document.createElement("TD");
		tdBack.className = "monthcontrol";
		tdBack.innerHTML = "&lt;";
		tdBack.title = "Last Month";
		tdBack.onmousedown = calendar.changeMonthPrevious;
		trHeaderRow.appendChild(tdBack);
	}

	var headerspan = "7";
	if (this.isShowControls) headerspan = "5";	
	var tdHeaderCol = document.createElement("TD");
	tdHeaderCol.colSpan = headerspan;
	tdHeaderCol.className = "monthheader";
	tdHeaderCol.innerHTML = months[this.month] + " " + this.year;
	trHeaderRow.appendChild(tdHeaderCol);

	if (this.isShowControls) {
		var tdNext = document.createElement("TD");
		tdNext.className = "monthcontrol";
		tdNext.innerHTML = "&gt;";
		tdNext.title = "Next Month";
		tdNext.onmousedown = calendar.changeMonthNext;
		trHeaderRow.appendChild(tdNext);
	}

	//Draw days of week row
	var trDOWRow = document.createElement("TR");
	tblBody.appendChild(trDOWRow);
	
	for(var i=0;i<days.length;i++){
		var tdDOW = document.createElement("TD");
		tdDOW.className = "monthdayofweek";
		tdDOW.innerHTML = days[i].substring(0,this.iDOWLength);
		trDOWRow.appendChild(tdDOW);
	}
	
	//Draw the first row - for blanks
	var trRow = document.createElement("TR");
	tblBody.appendChild(trRow);

	//Write the leading empty cells
	if (document.sUserID == "jtkatz") alert(this.firstDay);
	for (var j=0;j<this.firstDay;j++) {
		var tdEmpty = document.createElement("TD");
		tdEmpty.innerHTML = "&nbsp;";
		tdEmpty.className = "monthday_empty";
		trRow.appendChild(tdEmpty);
	}
	
	var ctr = this.firstDay;
	
	//all cells with dates
	for (var k=this.datebegin;k<=this.dateend;k++) {
		var iNumDisplay = k > this.length ? k - this.length : k; //this is for showing weeks, because a week can span multiple months

		var tdDay = document.createElement("TD");
		tdDay.id = this.id + "_" + iNumDisplay;
		var dtDrawn = new Date(this.year,this.month,iNumDisplay,0,0,0);
		//alert( "dtDrawn=" + dtDrawn + ", tdDayid=" + tdDay.id + ", " + this.isSelectableDates );
		if (this.isSelectableDates && this.isDateSelected(dtDrawn)) {
			tdDay.className = "monthday_selected";
			document.arrDatesShownID.push(tdDay.id);
		}
		else
			tdDay.className = "monthday";
			
		tdDay.innerHTML = "<div class='dateholder'><div class='datenum'>" + iNumDisplay + "</div><div class='datetext'></div><div class='datefooter'></div></div>";
		tdDay.onmousedown = calendar.selectDate;
		trRow.appendChild(tdDay);

		//start a new row?
		if (ctr%7 == 6) {
			trRow = document.createElement("TR");
			tblBody.appendChild(trRow);
		}
		ctr++;
	}

	//draw the rest of the empty cells after the last date
	ctr--;
	while (ctr%7 < 6) {
		var tdEmpty = document.createElement("TD");
		tdEmpty.innerHTML = "&nbsp;";
		tdEmpty.className = "monthday_empty";
		trRow.appendChild(tdEmpty);
		ctr++;
	}

}
/************************************/
/* isDateSelected (prototype)		*/
/************************************/
//checks to see if the given date is selected (using the calendar selected start and end dates)
calendar.prototype.isDateSelected = function(inDate) {
	if (this.dtStart.getFullYear() == inDate.getFullYear() && this.dtStart.getMonth() == inDate.getMonth() && this.dtStart.getDate() <= inDate.getDate() && inDate.getDate() <= this.dtEnd.getDate()) {
			return true;
	}
	return false;
}
/************************************/
/* getLength (prototype)			*/
/************************************/
//gets the length of the calendar (# days)
calendar.prototype.getLength = function() {
	return calendar.getNumDaysInMonth(eval(this.month + 1),this.year);
}



/************************************/
/* getWeekStart						*/
/************************************/
//gets the first day in the week of the given date
calendar.getWeekStart = function(inDate) {
	var stdt = new Date(inDate.getTime());
	var first = stdt.getDate() - stdt.getDay();
	//if (first < 1) first = 1;
	stdt.setDate(first);
	return stdt;
}
/************************************/
/* getWeekEnd						*/
/************************************/
//gets the last day in the week of the given date (using a start date, if given)
calendar.getWeekEnd = function(inDate,inWeekStart) {
	var enddt = new Date();
	if (inWeekStart != undefined && inWeekStart != null) {
		enddt = new Date(inWeekStart.getTime());
	} else {
		var enddt = calendar.getWeekStart(inDate);
	}
	enddt.setDate(enddt.getDate() + 6 - enddt.getDay());
	enddt.setHours(23);
	enddt.setMinutes(59);
	enddt.setSeconds(59);
	return enddt;
}
/************************************/
/* getNumDaysInMonth				*/
/************************************/
//returns the number of days in the given month/year.  Where Jan = month #1
calendar.getNumDaysInMonth = function(inMonthNum,inFullYear){
	//1=January, 12=December
	//thirty days has September...
	switch(inMonthNum){
		case 2:
			if((inFullYear%4==0&&inFullYear%100!=0)||inFullYear%400==0)
				return 29; //leap year
			else
				return 28;
		case 4:
			return 30;
		case 6:
			return 30;
		case 9:
			return 30;
		case 11:
			return 30
		default:
			return 31;
	}
}
/************************************/
/* getCalObjFromTDID				*/
/************************************/
//gets the calendar object (created using new calendar()) given the ID of the TD
calendar.getCalObjFromTDID = function(inTDID) {
	var dt = calendar.getDateFromTDID(inTDID);
	var id = "cal" + dt.getFullYear() + dt.getMonth();
	for (var i=0; i < document.arr_CalShown.length; i++) {
		if (document.arr_CalShown[i].id == id)
			return document.arr_CalShown[i]
	}
	return null;
}
/************************************/
/* getDateFromTDID					*/
/************************************/
//gets the date given the ID of the TD.  presumes all TD IDs are of a given format from which the date can be derived.
calendar.getDateFromTDID = function(inTDID) {
//TDID must be in format: calYYYYMM_DD
	var ind = inTDID.indexOf("_");
	var iShownYear = inTDID.substring(3,7);
	var iShownMonth = inTDID.substring(7,ind);
	var iShownDate = inTDID.substring(ind+1,inTDID.length);
	var dt = new Date(iShownYear,iShownMonth,iShownDate,0,0,0);
	return dt;
}
/************************************/
/* getTDIDFromDate					*/
/************************************/
//gets the ID of the TD given the date (reverse of getDateFromTDID)
calendar.getTDIDFromDate = function(inDate) {
	var sTDID = "cal" + inDate.getFullYear() + inDate.getMonth() + "_" + inDate.getDate();
	return sTDID;
}

/************************************/
/* changeDate						*/
/************************************/
//changes the date on the actual small calendars to the given TD ID date
calendar.changeDate = function(inTDID) {
	//reset dtStart, dtEnd for the calendar. (??)

	//What date was selected by the user (what's the new date)?
	var dt = calendar.getDateFromTDID(inTDID);

	//What kind of calendar is this?  day, week, month...
	//get the start and end selection dates
	var cal = calendar.getCalObjFromTDID(inTDID);
	
	//KDC, 1-23-2008. Abstracted the rest of this method to showNewDate in order to call it elsewhere
	calendar.showNewDate(dt,cal.length);
}

/************************************/
/* showNewDate						*/
/************************************/
//updates the display based on the given new display date (dt) and the type of display already existing (month,week,day)
//NOTE: lengthofmonth is used for month only and can be null or undefined for week or day
calendar.showNewDate = function(dt,lengthofmonth) {
//alert("SHOWING NEW");
	var iStartDate = dt.getDate();
	var iEndDate = dt.getDate();
	var sd = new Date(dt.getTime());
	var ed = new Date(dt.getTime());

//KDC, 2-21-2008. Want click of calendar date to always go to day
/*
	if (document.iViewSlotSize == "month") {
		iStartDate = 1;
		sd.setDate(iStartDate);
		iEndDate = lengthofmonth;
		ed.setDate(iEndDate);
		ed.setHours(23);
		ed.setMinutes(59);
		ed.setSeconds(59);
	} else if (document.iViewSlotSize == "week") {
		sd = calendar.getWeekStart(dt);
		iStartDate = sd.getDate();
		ed = calendar.getWeekEnd(dt,sd);
		iEndDate = ed.getDate();
		ed.setHours(23);
		ed.setMinutes(59);
		ed.setSeconds(59);
	} else { // document.iViewSlotSize == "day" or some timeslot size*/
		sd.setHours(document.iDefaultStartHour);
		sd.setMinutes(document.iDefaultStartMinutes);
		sd.setSeconds(document.iDefaultStartSeconds);
		ed.setHours(document.iDefaultEndHour);
		ed.setMinutes(document.iDefaultEndMinutes);
		ed.setSeconds(document.iDefaultEndSeconds);
/*
	}
	*/
	
	document.iViewSlotSize = "day"; //KDC, 2-21-2008, added so that always go to day
	
	//perform the change action - update the entire calendar!
	document.dtViewStartTime = new Date(sd.getTime());
	document.dtViewEndTime = new Date(ed.getTime());
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);
	changeCalDisplayView(document.iViewSlotSize,"current");

//	calendar.highlightNewDates(sd,ed);  //KDC,2-28-2008. Antiquated - we don't highlight anymore, taken care of in highlightDateStatus
	//alert( document.iCalendarID.length );
	for ( var i=0; i<document.iCalendarID.length; ++i )
	{
		//ajax_getAvailableDates(document.iCalendarID[i], sd);
		ajax_getDateStatus(document.iCalendarID[i], sd, document.g_BlockOwnerID); //KDC, 2-27-2008. New side-calendar display
		////KDC, 1-16-2008. Removed highlight call below and moved it into process_getAvailableDates
		////calendar.highlightAvailableDates( sd, document.iCalendarID.length );
	}
	//calendar.highlightAvailableDates(sd);
}

//KDC,2-28-2008. Antiquated - we don't highlight anymore, taken care of in highlightDateStatus
/*
calendar.highlightNewDates = function(inNewStartDate,inNewEndDate) {
alert("HIGHLIGHTING NEW: " + inNewStartDate + "," + inNewEndDate);
	//unhighlight the old
	//alert( "startdate=" + inNewStartDate + ", enddate=" + inNewEndDate );
	for (var i=0; i < document.arrDatesShownID.length; i++) {
		var el = GetElement(document.arrDatesShownID[i]);
		if (el != null) {
			el.className = "monthday";
		}
		//alert( document.arrDatesShownID[i] );
	}
	document.arrDatesShownID.length = 0;

	//highlight the new date(s)
	var dtIter = new Date(inNewStartDate.getTime());
	//alert( "dtIter=" + dtIter );
	while (dtIter <= inNewEndDate) {
		var sTDID = calendar.getTDIDFromDate(dtIter);
		var el = GetElement(sTDID);
		//alert( "sTDID=" + sTDID );

		if (el != null) {
			el.className = "monthday_selected";
			document.arrDatesShownID.push(sTDID);
		}
		dtIter.setDate(dtIter.getDate()+1);
	}
}
*/

calendar.highlightDateStatus = function(inNewStartDate, inMulti) {
	//set up new month/year arrays
	var m = new Array(2); 
	var y = new Array(2);
	m[0] = inNewStartDate.getMonth(); 
	m[1] = (m[0]+1)%12;
	y[0] = inNewStartDate.getFullYear();
	y[1] = y[0];
	if ( m[1]<m[0] ) y[1] = y[0]+1;
	
	//check to see if the user is the owner or manager of this calendar
	var isownermgr = false;
	if (isUserOwner() || isUserManagerOfThisCal())
		isownermgr = true;
		
	var sDateTemp = "";
	var el = null;
	//loop over 2 months
	for (var i=0; i < 2; i++) {
		//loop over dates in each month
		for (var j=1; j<=getNumDaysInMonth(m[i]+1, y[i]); j++) {
			sDateTemp = 'cal'+y[i]+m[i]+'_'+j;
			el = GetElement(sDateTemp);
			if (el != null && document.sCals_datestatus != null) {
				//check to see if the date is selected
				var sSelected = "";
				if (el.className.indexOf("selected") != -1)
					sSelected = "_selected";
				//change the class of the element based on the date status
				switch(document.sCals_datestatus[i][j]) {
					case "noblocksnoappsnoslots":
						el.className = "monthday" + sSelected;
						break;
					case "blocksnoappsnoslots":
						if (isownermgr)
							el.className = "monthday" + sSelected + "_available";
						else
							el.className = "monthday" + sSelected + "_unavailable";
						break;
					case "blocksnoappsslots":
						el.className = "monthday" + sSelected + "_available";
						break;
					case "blocksappsnoslots":
						if (isownermgr)
							el.className = "monthday" + sSelected + "_appointment";
						else
							el.className = "monthday" + sSelected + "_unavailable";
						break;
					case "blocksappsslots":
						if (isownermgr)
							el.className = "monthday" + sSelected + "_appointment";
						else
							el.className = "monthday" + sSelected + "_available";
						break;
					case "blocksmyappsslots":
						if (isownermgr)
							el.className = "monthday" + sSelected + "_appointment";
						else
							el.className = "monthday" + sSelected + "_myappointment";
						break;
					case "blocksmyappsnoslots":
						if (isownermgr)
							el.className = "monthday" + sSelected + "_appointment";
						else
							el.className = "monthday" + sSelected + "_myappointment";
						break;
				}
//				if (i == 0 && j == 6) alert(i + "," + j + ":" + document.sCals_datestatus[i][j] + "  " + el.id + "  " + el.className);
			}
		}
	}
	//alert("after cal, before today");
	//"today" gets its own special class
	var today = new Date();
	el = GetElement( 'cal' + today.getFullYear() + today.getMonth() + '_' + today.getDate() );
	if ( el != null ) {
		if (el.className.indexOf("selected") != -1)
			el.className = "today_selected";
		else
			el.className = "today";
	}
	//alert("after today");
}

calendar.highlightAvailableDates= function( inNewStartDate, inMulti )
{
	//unhighlight the old
	//alert("highlighting available");
	//alert( "avail, start date, m=" + inNewStartDate.getMonth() );
	
	var m = new Array(2); var y = new Array(2);
	m[0] = inNewStartDate.getMonth(); m[1] = (m[0]+1)%12;
	y[0] = inNewStartDate.getFullYear(); y[1] = y[0]; if ( m[1]<m[0] ) y[1] = y[0]+1;

	//var today = new Date();
	//alert( m[0] + "," + y[0] + "," + m[1] + "," + y[1] );

	//alert( (m1+1) + "," + y1 + "," + getNumDaysInMonth(m1+1,y1) + "," + (m2+1) + "," + y2 + "," + getNumDaysInMonth(m2+1,y2) );

	var calTemp;
	for ( var i=0; i<2; ++i )
	{
		for (var j=1; j<=getNumDaysInMonth(m[i]+1, y[i]); j++)
		{
			calTemp = 'cal'+y[i]+m[i]+'_'+j;
			//alert( calTemp );
			el = GetElement(calTemp);
			if (el != null && sCals_availblocks !=null)
			{
				//alert( calTemp + "," + i + "," + j + "," + sCals_availblocks[i][j] );
				//console.log( calTemp + "," + i + "," + j + "," + sCals_availblocks[i][j] );
				if ( sCals_availblocks[i][j] == 1 )
				{
					if ( el.className == 'monthday_selected' )
					{
						el.className = "monthday_selected_available";
					}
					else
						el.className = "monthday_available";

					el.innerHTML = "<div class='dateholder'><div class='datenum'>" + j + "</div><div class='datetext'></div><div class='datefooter'></div></div>";
    			el.onmousedown = calendar.selectDate;

				} else
				{
					if ( inMulti != undefined && inMulti == 1 )
					{
						if ( el.className == 'monthday_available' )
							el.className = "monthday";
						else if ( el.className == 'monthday_selected_available' )
							el.className = "monthday_selected";
					}
				}
			}
		}
	}

	var el = GetElement( 'cal' + today.getFullYear() + today.getMonth() + '_' + today.getDate() );
	if ( el != null )
	{
		if ( el.className.indexOf("monthday_selected") >= 0 )
			el.className = "today_selected";
		else
			el.className = "today";
	}	


}

/************************************/
/* selectDate						*/
/************************************/
//called when the user clicks on a date on a selectable calendar
calendar.selectDate = function(e) {
	if (!e) e = window.event;  // IE Event Model
	calendar.changeDate(this.id);
}
/************************************/
/* setDateShown						*/
/************************************/
//set the small calendars selected date to the given date
calendar.setDateShown = function(inDate) {
	//figure out the TDID based on the given date
	var iDate = inDate.getDate();
	var sMonth = months[inDate.getMonth()];
	var sTDID = "cal" + inDate.getFullYear() + inDate.getMonth() + "_" + iDate;
	calendar.changeDate(sTDID);
}

/************************************/
/* changeMonths						*/
/************************************/
//change the display of the small months, given a direction (next,previous,current) and container DIV ID
calendar.changeMonths = function(inDirection,inParentContainerID) {
	//get shown date(s)
	var arrShownDates = new Array();
	for (var i=0; i < document.arrDatesShownID.length; i++) {
		var ind = document.arrDatesShownID[i].indexOf("_");
		arrShownDates.push(document.arrDatesShownID[i].substring(ind+1,document.arrDatesShownID[i].length));
	}
//	alert(arrShownDates);
	
	//save the shown month dates
	var arr_dtShownMonths = new Array();
	for (var i=0; i < document.arr_CalShown.length; i++) {
		var obj = document.arr_CalShown[i];
		var dt = new Date(obj.year,obj.month,1);
//KDC, 1-30-2009. Moved setting year, month up to Date() instantiation because if current date (30) is > month's #days in month (like Feb), gets moved to March!
/*		var dt = new Date();
		dt.setMonth(obj.month);
		alert("set mo:"+dt);
		dt.setYear(obj.year);
		alert("set yr:"+dt);
		*/
		
		//KDC, 2-1-2008. Checking to make sure the new date isn't higher than the number of days in the month. Adjust appropriately.
		var newdate = arrShownDates[0];
		var daysinmonth = getNumDaysInMonth(obj.month+1,obj.year);
//		alert("obj mo/year: " + obj.month + "/" + obj.year + ";;" + newdate + "::" + daysinmonth);
		if(newdate > daysinmonth)
			newdate = daysinmonth;
//		alert(newdate);
		dt.setDate(newdate);

		////dt.setDate(arrShownDates[0]);
//		alert(dt);
		arr_dtShownMonths.push(dt);
	}

//	alert( arr_dtShownMonths );
	calendar.redrawCalendars(inDirection,arr_dtShownMonths,arrShownDates);
}
/************************************/
/* changeMonthNext					*/
/************************************/
//called when the user clicks on the "next" button on the calendar header
calendar.changeMonthNext = function(e) {
	if (!e) e = window.event;  // IE Event Model
	calendar.changeMonths("next",document.c_sSmallCalContainerDivID);
}
/************************************/
/* changeMonthPrevious				*/
/************************************/
//called when the user clicks on the "previous" button on the calendar header
calendar.changeMonthPrevious = function(e) {
	if (!e) e = window.event;  // IE Event Model
	calendar.changeMonths("previous",document.c_sSmallCalContainerDivID);
}
/************************************/
/* removeCalendars					*/
/************************************/
//removes all small calendars currently displayed
calendar.removeCalendars = function(inParentID) {
	//remove current months
	var par = GetElement(inParentID);
	for (var i=0; i < document.arr_CalShown.length; i++) {
		var obj = document.arr_CalShown[i];
		var el = GetElement(obj.id);
		if (el != null) {
			par.removeChild(el);
			document.arr_CalShown[i] = null;
		}
	}
	document.arr_CalShown.length = 0;
}

calendar.isSelectedDateDisplayed = function(inSelDate) {
	var tdid = calendar.getTDIDFromDate(inSelDate);
	var el = GetElement(tdid);
	if (el == null)
		return false;
	return true;
}
/************************************/
/* drawTwoCalendars					*/
/************************************/
/* Draw the two small calendars */
calendar.drawTwoCalendars = function(inMonth1,inYear1,inSelStartDate,inSelEndDate)
{
	//alert( "inMonth=" + inMonth1 + ", inYear=" + inYear1 + ", start=" + inSelStartDate + ", end=" + inSelEndDate );
	//JJC, 9-21-2007, hack fix to the small calendar previous and next arrows.
	inYear1 = inSelStartDate.getFullYear();
	inMonth1 = inSelStartDate.getMonth();
	var firstmonth = document.arr_CalShown.length > 0 ? document.arr_CalShown[0].month : -1;
	var isRotateMonths = firstmonth == inMonth1 ? false : true;
	var isStartShown = calendar.isSelectedDateDisplayed(inSelStartDate);
	if (!isStartShown && inSelStartDate.getMonth() < inMonth1 && !isRotateMonths) {
		inMonth1 = inMonth1 - 1;
		if (inMonth1 == -1) inMonth1 = 11;
	}
	var isEndShown = calendar.isSelectedDateDisplayed(inSelEndDate);
	if (!isEndShown && inSelEndDate.getMonth() > (eval(inMonth1) +1) && !isRotateMonths) {
		inMonth1 = inMonth1 + 1;
		if (inMonth1 == 12) inMonth1 = 0;
	}
	//remove the calendars only if: 
	// 1. given month is not the currently shown month 
	// 2. OR start date is not displayed
	// 3. OR end date is not displayed
	//remove calendars, if they exist
	if (isRotateMonths || !isStartShown || !isEndShown) {
		calendar.removeCalendars(document.c_sSmallCalContainerDivID);

		//The first calendar is for inMonth1, inYear1
		var id = "cal" + inYear1 + inMonth1;
		//alert( id );
		var m1 = new calendar(id,inMonth1,inYear1,"month",inSelStartDate,inSelEndDate,document.c_sSmallCalContainerDivID,true,1,true);
		m1.writeCalendar();
		//add to the global array of small calendars
		document.arr_CalShown.push(m1);
	
		//The second calendar month is the month following inDate
		var nextmonth = new Date(inYear1,inMonth1,1,0,0,0);
		var i = nextmonth.getMonth() + 1;
		nextmonth.setMonth(i);
		id = "cal"+nextmonth.getFullYear() + nextmonth.getMonth();
		var m2 = new calendar(id,nextmonth.getMonth(),nextmonth.getFullYear(),"month",inSelStartDate,inSelEndDate,document.c_sSmallCalContainerDivID,false,1,true);
		m2.writeCalendar();
		//add to the global array of small calendars
		document.arr_CalShown.push(m2);
	}
	
//	calendar.highlightNewDates(inSelStartDate,inSelEndDate); //KDC,2-28-2008. Antiquated - we don't highlight anymore, taken care of in highlightDateStatus

for ( var i=0; i<document.iCalendarID.length; ++i )
	{
		//ajax_getAvailableDates(document.iCalendarID[i], inSelStartDate);
		ajax_getDateStatus(document.iCalendarID[i], inSelStartDate, document.g_BlockOwnerID); //KDC, 2-27-2008. New side-calendar display
		////KDC, 1-16-2008. Removed highlight call below and moved it into process_getAvailableDates
		////calendar.highlightAvailableDates( inSelStartDate, document.iCalendarID.length );
	}

}
/************************************/
/* redrawCalendars					*/
/************************************/
//redraws the small calendars, and the large calendar to reflect user changes to the small calendars
calendar.redrawCalendars = function(inDirection,inArrShownMonths,inArrShownDates) {
	//draw the new months
/* KDC: may be able to use the global array for this, instead of passing it in... */
	var newDate = null;
	if (inDirection == "next") {
		newDate = inArrShownMonths[1];
	}
	else if (inDirection == "previous") {
		newDate = inArrShownMonths[0];
		//alert("new date before: " + newDate);
		var newmonth = inArrShownMonths[0].getMonth() - 1;
		//KDC, 2-1-2008. Checking to make sure the new date isn't higher than the number of days in the previous month. 
		//Adjust appropriately.
		var newday = inArrShownMonths[0].getDate();
		var daysinmonth = getNumDaysInMonth(newmonth+1,inArrShownMonths[0].getFullYear());
		//alert(newday + "::" + daysinmonth);
		if(newday > daysinmonth)
			newday = daysinmonth;
		newDate.setDate(newday);
		newDate.setMonth(newmonth+0);
	} else { //keep it the same ("current")
		newDate = inArrShownMonths[0];
	}
	//alert("new date: " + newDate);
	
	//get start date and end date
	//KDC, 2-1-2008. Changed this because now setting the date in newDate in the changeMonth method
	///var dtSelStart = new Date(newDate.getFullYear(),newDate.getMonth(),inArrShownDates[0],0,0,0);
	var dtSelStart = new Date(newDate.getFullYear(),newDate.getMonth(),newDate.getDate(),0,0,0);
	var dtSelEnd = new Date(dtSelStart.getFullYear(),dtSelStart.getMonth(),1,23,59,59);
	//alert( dtSelStart + "," + dtSelEnd );

	if (document.iViewSlotSize == "week") {
		dtSelStart = calendar.getWeekStart(dtSelStart);
		dtSelEnd = calendar.getWeekEnd(dtSelStart,dtSelStart);
	} else if (document.iViewSlotSize == "month") {
		dtSelEnd = new Date(dtSelStart.getTime());
		var enddate = calendar.getNumDaysInMonth(dtSelEnd.getMonth()+1,dtSelEnd.getFullYear());
		dtSelEnd = new Date(dtSelEnd.getFullYear(),dtSelEnd.getMonth(),enddate,23,59,59);
	} else {
		dtSelEnd = new Date(dtSelStart.getTime());
		dtSelStart.setHours(document.iDefaultStartHour);
		dtSelStart.setMinutes(document.iDefaultStartMinutes);
		dtSelStart.setSeconds(document.iDefaultStartSeconds);
		dtSelEnd.setHours(document.iDefaultEndHour);
		dtSelEnd.setMinutes(document.iDefaultEndMinutes);
		dtSelEnd.setSeconds(document.iDefaultEndSeconds);
	}

	document.dtViewStartTime = new Date(dtSelStart.getTime());
	document.dtViewEndTime = new Date(dtSelEnd.getTime());
	//alert( document.dtViewStartTime + "," + document.dtViewEndTime );
	setAddBlockDisplay(document.dtViewStartTime,document.dtViewEndTime,document.iViewSlotSize);
	//ajax_getAvailableDates( document.iCalendarID, dtSelStart );
	ajax_getDateStatus(document.iCalendarID, dtSelStart, document.g_BlockOwnerID); //KDC, 2-27-2008. New side-calendar display
	changeCalDisplayView(document.iViewSlotSize,inDirection);
}
