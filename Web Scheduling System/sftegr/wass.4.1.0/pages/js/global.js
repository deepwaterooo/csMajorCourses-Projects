// JavaScript Document
function isAuthenticated() {
	var isAuth = false;
	if (document.g_isAuth == true || document.g_isAuth == "true")
		isAuth = true;
	return isAuth;
}
function isUserOwner() {
	var isowner = false;
	var el = GetElement("hidIsOwner");
	if (el != null) {
		isowner = el.value == "true" || el.value == "1" ? true : false;
	}
	return isowner;	
}
function isUserGuest() {
	var isGuest = true;
	var user = document.sUserID;
	if (user != "")
		isGuest = false;
	return isGuest;
}

function hasCalendar()
{
  var hasCalendar = GetElementValue("hidHasCalendar");
  if ( hasCalendar == 1 )
		return true;

	return false;
}

/* KDC, 6/2/2009.  Not in use. */
/*
function hasCalendarRemove()
{
	var hasCalendar = true;
	//var hasCalendar = false; *** NEED TO CHANGE BACK ONCE PHP IS DONE ON VIEWCALENDAR ***
	if (GetElement("hidUserCalendarID") != null)
	{
		if ( GetElement("hidUserCalendarID").value == "" )
		{
			if ( GetElementValue("hidUCal_id") == "" )
				return false;
			else
				return true;

			return false;
		}
		return true;
	}
}
*/

function canUserEditBlocks() {
	return isUserOwner();
}
function isUserManagerOfThisCal() {
	var isManager = false;
	if (GetElement("hidIsManagerOfThisCal") != null) {
		var ismgr = GetElement("hidIsManagerOfThisCal").value;
		isManager = ismgr == "true" || ismgr == "1" || ismgr == 1 ? true : false;
	}
	return isManager;

}
/*function canUserMakeAppts(inApptStartTime) {
	var now = new Date();
	if (isUserManagerOfThisCal() || isUserOwner() || now < inApptStartTime)
		return true;
	return false;
}*/
function canUserEditAppts(inUserID,inEmail) {
	var canedit = false;
	//check for owner/manager
	var el = GetElement("hidIsOwner");
	if (el != null) {
		if (el.value == "true" || el.value == "1") canedit = true;
	}
	if (document.sUserID != null) {
		//check for student (logged in) KDC, 6-26-2008.
		if (document.sUserID != '' && document.sUserID.toLowerCase() == inUserID.toLowerCase()) canedit = true;
		//check for guest KDC, 6-26-2008.
		if (document.sAuthType == 'guest' && document.sGuestID == inEmail) canedit = true;
	}
	return canedit;
}

/*function validateReqd() {
	var strBlankFields = "";
	var isOK = true;
	var arrReqdLabels = getElementsByClassName("mandat");
	for (var i=0; i < arrReqdLabels.length; i++) {
		if (arrReqdLabels[i].getAttribute('for') != null) {
			var elID = arrReqdLabels[i].getAttribute('for');
			if (GetElement(elID) != null) {
				var el = GetElement(elID);
				if (trim(el.value) == "") {
					isOK = false;
					var strLabelText = GetElement(arrReqdLabels[i].getAttribute('id')).innerHTML;
					if (strBlankFields != "") strBlankFields += ", ";
					strBlankFields += strLabelText;
				}
			}
		} else {
			
		}		
	}
}*/

function isBlankField(inID) {
	var isBlank = true;
	var val = null;
	var el = GetElement(inID);
	if (el != null) {
		val = "";
		if (el.type == "text" || el.tagName == "TEXTAREA")
			val = trim(el.value);
		else if (el.type == "select" || el.type == "select-multiple") {
			val = el.options[el.selectedIndex];
		}
	}
	if (val != "")
		isBlank = false;
	return isBlank;
}
function addToMessage(inText, inNewText) {
	if (trim(inText) != "")
		inText += "\n ";
	inText += inNewText;
	return inText;
}

function trim(inputString) {
   // Removes leading and trailing spaces from the passed string. Also removes
   // consecutive spaces and replaces it with one space. If something besides
   // a string is passed in (null, custom object, etc.) then return the input.
   if (typeof inputString != "string") return inputString;
   var retValue = inputString;
   var ch = retValue.substring(0, 1);

   while (ch == " ") { // Check for spaces at the beginning of the string
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length - 1, retValue.length);

   while (ch == " ") { // Check for spaces at the end of the string
      retValue = retValue.substring(0, retValue.length - 1);
      ch = retValue.substring(retValue.length - 1, retValue.length);
   }

  // Note that there are two spaces in the string - look for multiple spaces within the string
   while (retValue.indexOf("  ") != -1) {
    // Again, there are two spaces in each of the strings
      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ") + 1, retValue.length);
   }
   return retValue; // Return the trimmed string back to the user
}

function escapeSingle(inStr) {
	if (inStr == null || inStr == "")
		return "";
	var arr = inStr.split("'");
	var tmp = arr[0];
	for (var i=1; i<arr.length; i++) {
		tmp += "\\'" + arr[i];
	}
	return tmp;
}

function getElementsByClassName(strClass, strTag, objContElm) {
  strTag = strTag || "*";
  objContElm = objContElm || document;
  var objColl = (strTag == '*' && document.all && !window.opera) ? document.all : objContElm.getElementsByTagName(strTag);
  var arr = new Array();
  var delim = strClass.indexOf('|') != -1  ? '|' : ' ';
  var arrClass = strClass.split(delim);
  for (var i = 0, j = objColl.length; i < j; i++) {
    var arrObjClass = objColl[i].className.split(' ');
    if (delim == ' ' && arrClass.length > arrObjClass.length) continue;
    var c = 0;
    comparisonLoop:
    for (var k = 0, l = arrObjClass.length; k < l; k++) {
      for (var m = 0, n = arrClass.length; m < n; m++) {
        if (arrClass[m] == arrObjClass[k]) c++;
        if (( delim == '|' && c == 1) || (delim == ' ' && c == arrClass.length)) {
          arr.push(objColl[i]);
          break comparisonLoop;
        }
      }
    }
  }
  return arr;
}


/****************************************/
/* Key Presses                          */
/****************************************/
function GetKeyCode(inEvent) {
  var code = 0;
  if (inEvent.keyCode)
    code = inEvent.keyCode;
  else if (inEvent.which)
    code = inEvent.which;
  return code;
}

function CheckForEnterKey(inEvent) {
  var code = GetKeyCode(inEvent);
  if (code == 13)
    return true;
  return false;
}


// To cover IE 5.0's lack of the push method
Array.prototype.push = function(value) {
  this[this.length] = value;
}


/* Date and Time */
function GetTime(inHour,inMinute,inSeconds) {
	var dt = new Date();
	dt.setHours(inHour);
	dt.setMinutes(inMinute);
	if (inSeconds == undefined || inSeconds == null) inSeconds = 30;
	dt.setSeconds(inSeconds);
	return dt;
}
function GetStringTime(inDate) {
	var hr = inDate.getHours() + "";
	var mn = inDate.getMinutes() + "";
	if (hr.length < 2) hr = "0" + hr;
	if (mn.length < 2) mn = "0" + mn;
	return hr + mn;
}
function GetDisplayTime(inDate) {
	var hr = inDate.getHours();
	var mn = inDate.getMinutes();
	var strmn = mn + "";
	if (strmn.length < 2)
		strmn = "0" + strmn;
	var ampm = "a";
	if (hr >= 12) {
		ampm = "p";
		hr = hr - 12;
	}
	if (hr == 0) hr = 12;
	var str = hr + ":" + strmn + ampm;
	return str;
}
function GetDisplayTimeFull(inDate) {
	var sDate = GetDisplayTime(inDate);
	return sDate;
}
function GetDisplayDate(inDate) {
//Gives mm/dd/yyyy
	var mo = inDate.getMonth()+1 + "";
	var dt = inDate.getDate() + "";
	var yr = inDate.getFullYear() + "";
	if (mo.length < 2) mo = "0" + mo;
	if (dt.length < 2) dt = "0" + dt;
	var strDate = mo + "/" + dt + "/" + yr;
	return strDate;
}
function GetDateFromDisplay(inStrDate) {
//Need mm/dd/yyyy
	var arrDate = inStrDate.split("/");
	var mo = arrDate[0];
	mo = eval(mo) - 1;
	var dy = arrDate[1];
	var yr = arrDate[2];
	var dt = new Date(yr,mo,dy,0,0,0);
	return dt;
}


function formatDateforServer(inDate) {
	var str = "";
	var strmn = (inDate.getMonth() + 1) + "";
	if (strmn.length < 2)
		strmn = "0" + strmn;
	var strdt = inDate.getDate() + "";
	if (strdt.length < 2)
		strdt = "0" + strdt;

	str += inDate.getFullYear() + "-" + strmn + "-" + strdt;
	return str;
}
function formatTimeforServer(inDate) {
	var str = "";
	var strmn = inDate.getMinutes() + "";
	if (strmn.length < 2)
		strmn = "0" + strmn;
	var strsec = inDate.getSeconds() + "";
	if (strsec.length < 2)
		strsec = "0" + strsec;
	var strhrs = inDate.getHours() + "";
	if (strhrs.length < 2)
		strhrs = "0" + strhrs;
	//str += strhrs + ":" + strmn + ":" + strsec;
	str += strhrs + ":" + strmn;
	return str;
}
//KDC, 2-26-2009. To see if date 1 is earlier than date 2
function isDateBefore(inDate1, inDate2) {
	if (inDate1.getFullYear() <= inDate2.getFullYear() && inDate1.getMonth() <= inDate2.getMonth() && inDate1.getDate() < inDate2.getDate())
		return true;
	return false;
}
//KDC, 2-26-2009. To see if date 1 is same as date 2
function isDateSame(inDate1, inDate2) {
	if (inDate1.getFullYear() == inDate2.getFullYear() && inDate1.getMonth() == inDate2.getMonth() && inDate1.getDate() == inDate2.getDate())
		return true;
	return false;
}
//KDC, 8-6-2009. To see if a date is contained within a range
function isDateBetween(inDateTest,inDate1,inDate2) {
	if ((isDateBefore(inDate1,inDateTest) || isDateSame(inDate1,inDateTest)) && (isDateBefore(inDateTest,inDate2) || isDateSame(inDateTest,inDate2)))
		return true;
	return false;
}
																													
//KDC, 2-26-2009. To see if date 1 and date 2 are in the same month
function areDatesInSameMonth(inDate1, inDate2) {
	if (inDate1.getFullYear() == inDate2.getFullYear() && inDate1.getMonth() == inDate2.getMonth())
		return true;
	return false;
}
//KDC, 8-5-2009. To see if date 1 and date 2 are in the same week
function areDatesInSameWeek(inDate1, inDate2) {
	if (inDate1.getFullYear() == inDate2.getFullYear() && inDate1.getMonth() == inDate2.getMonth() && calendar.getWeekStart(inDate1).getDate() == calendar.getWeekStart(inDate2).getDate())
		return true;
	return false;
}
//KDC, 4-3-2009. To see if time 1 is earlier than time 2 - assume that the date is the same, for now
function isTimeBefore(inTime1,inTime2) {
	if (inTime1.getHours() < inTime2.getHours() || (inTime1.getHours() == inTime2.getHours() && inTime1.getMinutes() <= inTime2.getMinutes()))
		return true;
	return false;
}


/* Get Elements */
function GetElement(inID) {
	if (document.getElementById) return document.getElementById(inID);
	else if (document.all) return document.all.inID;
	else return false;
}

/* Get Numerical Elements */
function GetElementNum(inID)
{

	if ( GetElement(inID) != null )
	{
		if ( eval(GetElement(inID).value*1) )
			return GetElement(inID).value*1;
		else return 0;
	}

	return 0;
}

/* return element value and "" if null */
function GetElementValue(inID)
{

	if ( GetElement(inID) != null )
	{
		return GetElement(inID).value;
	}

	return "";
}

/* Get Element with a check for true */
function GetElementCheck(inID, trueValue)
{

		if ( GetElement(inID) != null )
		{
			if ( GetElement(inID).value == trueValue )
				return 1
			else return 0;
		}

		return 0;
}

function GetParent(inElement) {
	if (inElement == null) return null;
	if (inElement.parentNode) return inElement.parentNode;
	else if (inElement.parentElement) return inElement.parentElement;
	else return GetElement(G_PARENTDIV);
}
function GetParentByID(inID) {
	var el = GetElement(inID);
	return GetParent(el);
}


/* Width and Height */
function GetWidth(inHTMLElement) {
	return inHTMLElement.offsetWidth;
}
function SetWidth(inHTMLElement, inWidth) {
	inHTMLElement.style.width = inWidth + "px";
}
function GetHeight(inHTMLElement) {
	return inHTMLElement.offsetHeight;
}
function SetHeight(inHTMLElement, inHeight) {
	inHTMLElement.style.height = inHeight + "px";
}


/* Positioning */
function GetLeft(inHTMLElement) {
	return inHTMLElement.offsetLeft;
}
function GetAbsoluteLeft(inElement) {
  var curleft = 0;
  if (inElement.offsetParent) {
    while (inElement.offsetParent) {
      curleft += inElement.offsetLeft
      inElement = inElement.offsetParent;
    }
  }
  else if (inElement.x)
    curleft += inElement.x;
  return curleft;
}
function GetAbsoluteRight(inElement) {
	return GetAbsoluteLeft(inElement) + GetWidth(inElement);
}
function SetLeft(inHTMLElement, inLeft) {
	inHTMLElement.style.left = inLeft + "px";
}

function GetTop(inHTMLElement) {
	return inHTMLElement.offsetTop;
}
function GetAbsoluteTop(inElement) {
  var curtop = 0;
  if (inElement.offsetParent) {
    while (inElement.offsetParent) {
      curtop += inElement.offsetTop
      inElement = inElement.offsetParent;
    }
  }
  else if (inElement.y)
    curtop += inElement.y;
  return curtop;
}
function GetAbsoluteBottom(inElement) {
	return GetAbsoluteTop(inElement) + GetHeight(inElement);
}
function SetTop(inHTMLElement, inTop) {
	inHTMLElement.style.top = inTop + "px";
}


/****************************************************/
/*  Screen Positioning of event                     */
/****************************************************/

function GetScreenLeft() {
  var theLeft = 0;
  if (document.documentElement && document.documentElement.scrollLeft) {
    theLeft = document.documentElement.scrollLeft;
  }
  else if (document.body) {
    theLeft = document.body.scrollLeft;
  }
  else {
    theLeft = window.pageXOffset;
  }
  return theLeft;
}
function GetScreenX(e) {
  if (!e) var e = window.event;
  var x = 0;
  if (e.pageX)
  	x = e.pageX;
  else if (e.clientX)
    x = e.clientX + GetScreenLeft();
  return x;
}

function GetScreenTop() {
  var theTop = 0;
  if (document.documentElement && document.documentElement.scrollTop) {
    theTop = document.documentElement.scrollTop;
  }
  else if (document.body) {
    theTop = document.body.scrollTop;
  }
  else {
    theTop = window.pageYOffset;
  }
  return theTop;
}
function GetScreenY(e) {
  if (!e) var e = window.event;
  var y = 0;
  if (e.screenY)
  	y = e.screenY;
  else if (e.pageY)
  	y = e.pageY;
  else if (e.clientY)
    y = e.clientY + GetScreenTop();
  return y;
}
function GetScreenWidth() {
  var w = 0;
  var test1 = document.body.scrollHeight;
  var test2 = document.body.offsetHeight;
  if (test1 > test2) { // all but Explorer Mac
    w = document.body.scrollWidth;
  }
  else {  // Explorer Mac (would also work in Explorer 6 Strict, Mozilla and Safari)
    w = document.body.offsetWidth;
  }
  return w;
}
function GetScreenHeight() {
  var h = 0;
  var test1 = document.body.scrollHeight;
  test1 = document.documentElement && document.documentElement.scrollHeight > test1 ? document.documentElement.scrollHeight : test1;
  var test2 = document.body.offsetHeight;
  test2 = document.documentElement && document.documentElement.offsetHeight > test2 ? document.documentElement.offsetHeight : test2;
  if (test1 > test2) { // all but Explorer Mac
    h = test1;
  }
  else {  // Explorer Mac (would also work in Explorer 6 Strict, Mozilla and Safari)
    h = test2;
  }
  return h;
}

function GetScreenBottom() {
  var theBottom = GetScreenTop() + GetWindowHeight();
  return theBottom;
}

function GetWindowLeft() {
  var l = 0;
  if (window.screenLeft)
    l = window.screenLeft;
  else if (window.screenX)
    l = window.screenX;
  return l;
}
function GetWindowTop() {
  var t = 0;
  if (window.screenTop)
    t = window.screenTop;
  else if (window.screenY)
    t = window.screenY;
  return t;
}
function GetWindowWidth() {
  var w = 0;
  if (window.innerWidth)
    w = window.innerWidth;
  else if (document.documentElement && document.documentElement.clientWidth)
    w = document.documentElement.clientWidth;
  else if (document.body)
    w = document.body.clientWidth;
  return w;
}
function GetWindowHeight() {
  var h = 0;
  if (window.innerHeight)
    h = window.innerHeight;
  else if (document.documentElement && document.documentElement.clientHeight)
    h = document.documentElement.clientHeight;
  else if (document.body)
    h = document.body.clientHeight;
  return h;
}
function GetWindowRight() {
  return (GetWindowLeft() + GetWindowWidth());
}
function GetWindowBottom() {
  return (GetWindowTop() + GetWindowHeight());
}




/* General */
document.g_iNumConfirmMsg = 0;
function closeMessage(inDivID) {
	var el = GetElement(inDivID);
	if (el != null) {
		el.style.display = "none";
	}
	document.g_iNumConfirmMsg = document.g_iNumConfirmMsg - 1;
}
function SelectAllChk(inChkName,inIsOn) {
	var chk = document.getElementsByName(inChkName);
	for (var i=0; i < chk.length; i++) {
		chk[i].checked = inIsOn;
	}
}
function doWinOpenSetup(inWidth,inHeight,inParams,inTop,inLeft) {
	var pageX = GetWindowLeft() + 450 - (inWidth/2);
	var pageY = GetWindowTop() + 300 - (inHeight/2);
	if (inTop != undefined)
		pageY = inTop;
	if (inLeft != undefined)
		pageX = inLeft;
	var params = "width="+inWidth+",height="+inHeight+",top="+pageY+",left="+pageX;
	if (inParams != undefined && inParams != null)
		params += "," + inParams;
	return params;
}
document.g_OpenWin = null;
//inParams can be (for example): scrollbars=yes,resizeable=yes
function OpenWin(inURL,inWidth,inHeight,inParams,inTop,inLeft,isCal) {
	var params = doWinOpenSetup(inWidth,inHeight,inParams,inTop,inLeft);
	var winname = "newwin";
	if (document.g_OpenWin != null && !isCal) {
		try {
			document.g_OpenWin.close(); 
			document.g_OpenWin = null;
		} catch(ex) {
		}
	}
	//document.g_OpenWin = window.open(inURL,winname,"width="+inWidth+",height="+inHeight+",top="+pageY+",left="+pageX);
	if (isCal)
		var win = window.open(inURL,"cal",params);	
	else
		document.g_OpenWin = window.open(inURL,winname,params);

}
document.g_OpenWin2 = null;
function OpenSecondWin(inURL,inWidth,inHeight,inParams,inTop,inLeft) {
	var params = doWinOpenSetup(inWidth,inHeight,inParams,inTop,inLeft);
	var winname = "newwin2";
	if (document.g_OpenWin2 != null) {
		try {
			document.g_OpenWin2.close(); 
			document.g_OpenWin2 = null;
		} catch(ex) {
		}
	}
	document.g_OpenWin2 = window.open(inURL,winname,params);
}
function openCalendar(inDateFieldID,inX,inY) {
	//Is there anything in the date field?  If so, pass it
	var strDate = "";
	var today = new Date();
	var mo = today.getMonth();
	var dt = today.getDate();
	var yr = today.getFullYear();
	if (GetElement(inDateFieldID) != null) {
		strDate = GetElement(inDateFieldID).value;
		if (strDate != "") {
			var arrDate = strDate.split("/");
			mo = arrDate[0];
			dy = arrDate[1];
			yr = arrDate[2];
		}
	}
	var url = "dateselect.page.php?fld=" + inDateFieldID + "&mo=" + mo + "&dt=" + dt + "&yr=" + yr;
	OpenWin(url,160,175,null,inY,inX,true);
}
//KDC, 7-24-2008. For opening a "browse" window for searching (such as on the Make an Appointment page)
function openBrowse(inType,inX,inY,inReturnField) {
	var url = "browse.page.php?listtype=" + inType + "&fld=" + inReturnField;
	OpenWin(url,360,375,'scrollbars=yes,resizeable=yes',eval(inY - 180),inX,false);	
}
function openTextMsgEmail(inReturnField,inTxtEmailVal,inX,inY) {
	var url = "textemailselect.page.php?fld=" + inReturnField + "&txtemail=" + inTxtEmailVal;
	OpenWin(url,400,300,'scrollbars=yes,resizeable=yes',inY,inX,true);	
}
/* Click on New Appointment to open new appointment window */
function makeAppt(inBlockID, inApptStartTime, inApptID) {
	var url = "createappt.page.php?block_id=" + inBlockID;
	if (inApptStartTime != undefined && inApptStartTime != null)
		url += "&app_start=" + inApptStartTime;
	if (inApptID != undefined && inApptID != null)
		url += "&app_id=" + inApptID;
	OpenWin(url,530,790,"scrollbars=yes,resizeable=yes");
}
/* Click on Cancel Appointment to open cancel appointment window */
function cancelAppt(inApptID,inIsLockApptSlot) {
	var islock = 0;
	if (inIsLockApptSlot) islock = 1;
	var url = "cancelappt.page.php?appt_id=" + inApptID + "&islock=" + islock;
	OpenWin(url,520,300);
}
function deletePastAppt(inApptID) {
	GetElement("hidDeleteApptID").value = inApptID;
	submitForm();
}
function submitForm() {
	document.forms[0].submit();
}
function reloadPage() {
	window.location.href = unescape(window.location.pathname);
}


/* Click on Appointment Info to open appointment info window */
function showApptInfo(inApptID) {
	var url = "apptinfo.page.php?appt_id=" + inApptID;
	OpenWin(url,550,550,"scrollbars=yes,resizeable=yes");
}

/* Click on Appointment Sync to get an ical stream of the appointment */
// KDC, 1-30-2008
function icalAppt(inApptID) {
	if (document.sUserID != null) {
		var url = "ical.page.php?action=GETAPP&appid=" + inApptID + "&authid=" + document.sUserID;
		OpenWin(url,550,480,"scrollbars=yes,resizeable=yes");
	}
}
/* Click on Block Sync to get an ical stream of the block */
// KDC, 1-30-2008
function doIcalBlock(inBlockID,inRecurType,inIsFromMsg) {
	if (document.sUserID != null) {
		var recurtype = "once";
		if (inRecurType != undefined && inRecurType != null) recurtype = inRecurType;
		var url = "ical.page.php?action=GETBLOCK&blockid=" + inBlockID + "&authid=" + document.sUserID + "&recurrence=" + recurtype;
		var isNeedNewWin = inIsFromMsg ? true : false;
		OpenWin(url,550,480,"scrollbars=yes,resizeable=yes",null,null,isNeedNewWin);
	}
}
/* Click on Block Sync to get an ical stream of the block */
// KDC, 1-30-2008
function icalBlock(inBlockID,inRecurType) {
	if (inRecurType == "once") {
		doIcalBlock(inBlockID,null,false);
	} else { //inRecurType == "multiple"
		var url = "";
		url = "blocksyncmsg.page.php?block_id=" + inBlockID;
		OpenWin(url,400,200,"scrollbars=yes,resizeable=yes");
	}
}


/* Help Windows */
//KDC, 7-9-2008. Added "inNeedNewWin" for help in block.page.php
function openHelp(inTopic,inNeedNewWin) {
	var topic = ""; //whatever the default page is should go here
	if (inTopic && inTopic != undefined && inTopic != null)
		topic = inTopic;
	else {
		var el = GetElement("helptopic");
		if (el != null) topic = el.value;
	}
	var url = "help.page.php?helptopic=" + topic;
	OpenSecondWin(url,650,650,"",null,null);
}

//KDC, 9-17-2008. Added for FAQ
function openFAQ() {
	var url = "faq.page.php";
	OpenWin(url,650,700,"",null,null,false);
}

//JEM, 2-25-2009. Added for What's New
function openWhatsnew() {
	var url = "whatisnew.page.php";
	OpenWin(url,650,700,"",null,null,false);
}

/* Show and Hide Form Elements */
function ShowHideElement(inElementID,inShowHide) {
//alert(inElementID);
	var el = GetElement(inElementID);
	if (el == null) return;
	if (inShowHide == "show") {
		el.style.display = "block";
	} else {
		el.style.display = "none";
	}
}
/* Toggle visibility of a form element */
function ToggleVisibility(inElementID) {
	var el = GetElement(inElementID);
	if (el == null) return;
	if (el.style.visibility == "hidden") {
		el.style.visibility = "visible";
	} else {
		el.style.visibility = "hidden";
	}
}
function ToggleVisOn(inElementID) {
	var el = GetElement(inElementID);
	if (el == null) return;
	el.style.visibility = "visible";
}
function ToggleVisOff(inElementID) {
	var el = GetElement(inElementID);
	if (el == null) return;
	el.style.visibility = "hidden";
}
function ShowHideSection(inSectionID,inShowHide,inShowToggleID,inHideToggleID,inToggleRootClassName) {
	ShowHideElement(inSectionID,inShowHide);
	var el1 = GetElement(inShowToggleID);
	var el2 = GetElement(inHideToggleID);
	if (inShowHide == "show") {
		el1.className = inToggleRootClassName + "_on";
		el2.className = inToggleRootClassName + "_off";
	} else {
		el1.className = inToggleRootClassName + "_off";
		el2.className = inToggleRootClassName + "_on";
	}
}
function ToggleTwoSections(inSection1ID,inSection2ID,inShowHideSection1,inShowToggleID,inHideToggleID,inToggleRootClassName) {
	//These must be in this order!
	if (inShowHideSection1 == "show") {
		ShowHideSection(inSection2ID,"hide",inShowToggleID,inHideToggleID,inToggleRootClassName);
		ShowHideSection(inSection1ID,"show",inShowToggleID,inHideToggleID,inToggleRootClassName);
	} else {
		ShowHideSection(inSection2ID,"show",inShowToggleID,inHideToggleID,inToggleRootClassName);
		ShowHideSection(inSection1ID,"hide",inShowToggleID,inHideToggleID,inToggleRootClassName);
	}
	
}

/* Advanced Options Section */
function changeRestrDescription(inSelEl,inDescID) {
	var elDiv = GetElement(inDescID);
	
	//Get Domain information from hidden input field on page
	var sDomain = "";
	var elDomain = GetElement("hidLimitedDomain");
	if (elDomain != null)
		sDomain = elDomain.value;
	var sNetIDParms = "";
	var elNetIDParms = GetElement("hidNetIDParms");
	if (elNetIDParms != null)
		sNetIDParms = elNetIDParms.value;
		
	if (inSelEl.selectedIndex == 0 || inSelEl.value == "open") { //Open
		elDiv.innerHTML = "(Anyone is allowed)";
	} else if (inSelEl.value == "limited") { //Limited
		elDiv.innerHTML = "(Anyone with a " + sDomain + " " + sNetIDParms + " is allowed)";
	} else if (inSelEl.value == "restricted") { //Restricted
		elDiv.innerHTML = "(Specify allowed users and/or courses below)";
	} else if (inSelEl.value == "private") { //Private
		elDiv.innerHTML = "(Only you and your calendar managers are allowed)";
	}
}
function onchangeAdvBlocks() {
	var sel = GetElement("selViewBlockRestr");
	changeRestrDescription(sel,"divViewBlockRestrDesc");
	if (sel.value == "restricted") { //2 is restricted
		ShowHideElement("divViewBlockRestr","show");
	} else {
		ShowHideElement("divViewBlockRestr","hide");
	}
}
function onchangeAdvAppts() {
	var sel = GetElement("selMakeApptRestr");
	changeRestrDescription(sel,"divMakeApptRestrDesc");
	if (sel.value == "restricted") { //2 is restricted
		ShowHideElement("divMakeApptRestr","show");
	} else {
		ShowHideElement("divMakeApptRestr","hide");
	}
}
function AddItemToList(inItemID,inListID) {
	var elItem = GetElement(inItemID);
	var sItem = elItem.value;
	AddValueToList(sItem,inListID);
	return false;
}
function AddValueToList(inValue,inListID) {
	var elList = GetElement(inListID);
  	if (elList != null) {
		var indNextOption = elList.options.length == 1 && (elList.options[elList.options.length-1].value == null || elList.options[elList.options.length-1].value == "") ? 0 : elList.options.length;	
		elList.options[indNextOption] = new Option(inValue,inValue);
	}
	return false;
}
function RemoveItemFromList(inListID) {
	var elList = GetElement(inListID);
	if (elList != null) {
		var len = elList.options.length - 1;
		for (var i=len; i>=0; i--) {
			if (elList.options[i].selected) {
				elList.options[i] = null;
			}
		}
	}
}
function ResetList(inListID) {
	var elList = GetElement(inListID);
	if (elList != null) {
		var len = elList.options.length - 1;
		for (var i=len; i>=0; i--) {
			elList.options[i] = null;
		}	
	}
}
function SelectEntireList(inListID) {
	var elList = GetElement(inListID);
	if (elList != null) {
		for (var i=0; i < elList.options.length; i++) {
			elList.options[i].selected = "selected";
		}
	}
}

/* For Blocks */
//KDC, 7-2-2008. Added so that we can differentiate and do something additional for the drop-down slot size vs. the free-form text.
function onchangeSlotDropDown() {
	var txtSlotSize = GetElement("txtSlotSize");
	if (txtSlotSize != null) txtSlotSize.value = "";
	onchangeTimeSlots();
}
function onchangeTimeSlots() {
	//KDC, 6-30-2008. Updated to include new free-form text slot size
	var slotval = 0;
	var txtslotsize = GetElement("txtSlotSize");
	var sel = GetElement("selTimeSlots");
	var divMsg = GetElement("divSlotSizeMessage");

	if (txtslotsize != null && txtslotsize.value != null && txtslotsize.value != "" && txtslotsize.value != 0 && txtslotsize.value != "0")
		slotval = txtslotsize.value;
	else { //drop-down selected
		if (sel.selectedIndex == 0) slotval = 0;
		else slotval = sel.options[sel.selectedIndex].value;
	}
	
	if (slotval == 0) { //0 is none
		ShowHideElement("divMaxAppts","show");
		ShowHideElement("divMaxApptsPerPerson","hide");
		divMsg.innerHTML = "Appointments are on a first-come, first-served basis.";
	} else {
		ShowHideElement("divMaxApptsPerPerson","show");
		ShowHideElement("divMaxAppts","hide");
		divMsg.innerHTML = "Appointments are " + slotval + " minutes in duration.";
	}
	//KDC, 2-18-2008. Added below in order to keep slot size selected if user changes other values on screen (times)
	if (sel.options.length > 1)
		document.g_sCurrentSlotSize = sel.options[sel.selectedIndex].value;
//alert(document.g_sCurrentSlotSize);
}

function onchangeRecur() {
	var sel = GetElement("selRecur");
	if (sel.selectedIndex == 0 || sel.selectedIndex == 1) { //0 & 1 are Daily
		//ShowHideElement("divDaily","show");
		ShowHideElement("divWeekly0","hide");
		ShowHideElement("divMonthlyDay0","hide");
		ShowHideElement("divMonthlyWeek0","hide");
	} else if (sel.selectedIndex == 2 || sel.selectedIndex == 3) { //2 & 3 are Weekly
		//ShowHideElement("divDaily","hide");
		ShowHideElement("divWeekly0","show");
		ShowHideElement("divMonthlyDay0","hide");
		ShowHideElement("divMonthlyWeek0","hide");
	} else if (sel.selectedIndex == 4) { //4 is Monthly, by day
		//ShowHideElement("divDaily","hide");
		ShowHideElement("divWeekly0","hide");
		ShowHideElement("divMonthlyDay0","show");
		ShowHideElement("divMonthlyWeek0","hide");
	} else { //5 is Monthly, by week
		//ShowHideElement("divDaily","hide");
		ShowHideElement("divWeekly0","hide");
		ShowHideElement("divMonthlyDay0","hide");
		ShowHideElement("divMonthlyWeek0","show");
	}
}

/************************************/
/* getNumDaysInMonth        */
/************************************/
//returns the number of days in the given month/year.  Where Jan = month #1
function getNumDaysInMonth(inMonthNum,inFullYear)
{
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

/* Create hidden input element for post */
function createHiddenInput( inName, inValue )
{
	var newInputObj = document.createElement("input");
  newInputObj.setAttribute("type","hidden");
  newInputObj.setAttribute("name", inName);
  newInputObj.setAttribute("value", inValue);
	return newInputObj;
}
/*
function GetKeyCode(inEvent) {
	var code = 0;
	if (inEvent.keyCode)
		code = inEvent.keyCode;
	else if (inEvent.which)
		code = inEvent.which;
	return code;	
}

function CheckForEnterKey(inEvent) {
	var code = GetKeyCode(inEvent);
	if (code == 13)
		return true;
	return false;
}
*/
function addslashes(str) {
str=str.replace(/\'/g,'\\\'');
str=str.replace(/\"/g,'\\"');
str=str.replace(/\\/g,'\\\\');
str=str.replace(/\0/g,'\\0');
return str;
}
function stripslashes(str) {
str=str.replace(/\\'/g,'\'');
str=str.replace(/\\"/g,'"');
str=str.replace(/\\\\/g,'\\');
str=str.replace(/\\0/g,'\0');
return str;
}


//SafeHTML
function safeHTML(inText) {
	var str = "";
	str = htmlentities(inText,'ENT_NOQUOTES');
	
	//11-1-2009. For allowing certain HTML markup.
	var okescapednum = new Array('&#60;b&#62;','&#60;/b&#62;','&#60;i&#62;','&#60;/i&#62;','&#60;em&#62;','&#60;/em&#62;','&#60;strong&#62;','&#60;/strong&#62;','&#60;p&#62;','&#60;/p&#62;','&#60;br&#62;','&#60;br/&#62;','&#60;br /&#62;','"','&#');
	var okescaped = new Array('&lt;b&gt;','&lt;/b&gt;','&lt;i&gt;','&lt;/i&gt;','&lt;em&gt;','&lt;/em&gt;','&lt;strong&gt;','&lt;/strong&gt;','&lt;p&gt;','&lt;/p&gt;','&lt;br&gt;','&lt;br/&gt;','&lt;br /&gt;','"','&amp;#');
	var okhtml = new Array('<b>','</b>','<i>','</i>','<em>','</em>','<strong>','</strong>','<p>','</p>','<br>','<br/>','<br />','&quot;','&#');
	
	for (var i=0; i < okescaped.length; i++) {
		str = str.replace(okescapednum[i],okhtml[i]);
		str = str.replace(okescaped[i],okhtml[i]);
	}

	return str;
}

function safeHTMLJS(inText) {
	return addslashes(inText);
}

function htmlentities (string, quote_style) {
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: nobbler
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // -    depends on: get_html_translation_table
    // *     example 1: htmlentities('Kevin & van Zonneveld');
    // *     returns 1: 'Kevin &amp; van Zonneveld'
 
    var histogram = {}, symbol = '', tmp_str = '', entity = '';
    tmp_str = string.toString();
    
    if (false === (histogram = get_html_translation_table('HTML_ENTITIES', quote_style))) {
        return false;
    }
    
    for (symbol in histogram) {
        entity = histogram[symbol];
        tmp_str = tmp_str.split(symbol).join(entity);
    }
    
    return tmp_str;
}

function get_html_translation_table(table, quote_style) {
    // http://kevin.vanzonneveld.net
    // +   original by: Philip Peterson
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: noname
    // %          note: It has been decided that we're not going to add global
    // %          note: dependencies to php.js. Meaning the constants are not
    // %          note: real constants, but strings instead. integers are also supported if someone
    // %          note: chooses to create the constants themselves.
    // %          note: Table from http://www.the-art-of-web.com/html/character-codes/
    // *     example 1: get_html_translation_table('HTML_SPECIALCHARS');
    // *     returns 1: {'"': '&quot;', '&': '&amp;', '<': '&lt;', '>': '&gt;'}
    
    var entities = {}, histogram = {}, decimal = 0, symbol = '';
    var constMappingTable = {}, constMappingQuoteStyle = {};
    var useTable = {}, useQuoteStyle = {};
    
    useTable      = (table ? table.toUpperCase() : 'HTML_SPECIALCHARS');
    useQuoteStyle = (quote_style ? quote_style.toUpperCase() : 'ENT_COMPAT');
    
    // Translate arguments
    constMappingTable[0]      = 'HTML_SPECIALCHARS';
    constMappingTable[1]      = 'HTML_ENTITIES';
    constMappingQuoteStyle[0] = 'ENT_NOQUOTES';
    constMappingQuoteStyle[2] = 'ENT_COMPAT';
    constMappingQuoteStyle[3] = 'ENT_QUOTES';
    
    // Map numbers to strings for compatibilty with PHP constants
    if (!isNaN(useTable)) {
        useTable = constMappingTable[useTable];
    }
    if (!isNaN(useQuoteStyle)) {
        useQuoteStyle = constMappingQuoteStyle[useQuoteStyle];
    }
    
    if (useQuoteStyle != 'ENT_NOQUOTES') {
        entities['34'] = '&quot;';
    }
 
    if (useQuoteStyle == 'ENT_QUOTES') {
        entities['39'] = '&#039;';
    }
 
    if (useTable == 'HTML_SPECIALCHARS') {
        // ascii decimals for better compatibility
        entities['38'] = '&amp;';
        entities['60'] = '&lt;';
        entities['62'] = '&gt;';
    } else if (useTable == 'HTML_ENTITIES') {
        // ascii decimals for better compatibility
      entities['38']  = '&amp;';
      entities['60']  = '&lt;';
      entities['62']  = '&gt;';
      entities['160'] = '&nbsp;';
      entities['161'] = '&iexcl;';
      entities['162'] = '&cent;';
      entities['163'] = '&pound;';
      entities['164'] = '&curren;';
      entities['165'] = '&yen;';
      entities['166'] = '&brvbar;';
      entities['167'] = '&sect;';
      entities['168'] = '&uml;';
      entities['169'] = '&copy;';
      entities['170'] = '&ordf;';
      entities['171'] = '&laquo;';
      entities['172'] = '&not;';
      entities['173'] = '&shy;';
      entities['174'] = '&reg;';
      entities['175'] = '&macr;';
      entities['176'] = '&deg;';
      entities['177'] = '&plusmn;';
      entities['178'] = '&sup2;';
      entities['179'] = '&sup3;';
      entities['180'] = '&acute;';
      entities['181'] = '&micro;';
      entities['182'] = '&para;';
      entities['183'] = '&middot;';
      entities['184'] = '&cedil;';
      entities['185'] = '&sup1;';
      entities['186'] = '&ordm;';
      entities['187'] = '&raquo;';
      entities['188'] = '&frac14;';
      entities['189'] = '&frac12;';
      entities['190'] = '&frac34;';
      entities['191'] = '&iquest;';
      entities['192'] = '&Agrave;';
      entities['193'] = '&Aacute;';
      entities['194'] = '&Acirc;';
      entities['195'] = '&Atilde;';
      entities['196'] = '&Auml;';
      entities['197'] = '&Aring;';
      entities['198'] = '&AElig;';
      entities['199'] = '&Ccedil;';
      entities['200'] = '&Egrave;';
      entities['201'] = '&Eacute;';
      entities['202'] = '&Ecirc;';
      entities['203'] = '&Euml;';
      entities['204'] = '&Igrave;';
      entities['205'] = '&Iacute;';
      entities['206'] = '&Icirc;';
      entities['207'] = '&Iuml;';
      entities['208'] = '&ETH;';
      entities['209'] = '&Ntilde;';
      entities['210'] = '&Ograve;';
      entities['211'] = '&Oacute;';
      entities['212'] = '&Ocirc;';
      entities['213'] = '&Otilde;';
      entities['214'] = '&Ouml;';
      entities['215'] = '&times;';
      entities['216'] = '&Oslash;';
      entities['217'] = '&Ugrave;';
      entities['218'] = '&Uacute;';
      entities['219'] = '&Ucirc;';
      entities['220'] = '&Uuml;';
      entities['221'] = '&Yacute;';
      entities['222'] = '&THORN;';
      entities['223'] = '&szlig;';
      entities['224'] = '&agrave;';
      entities['225'] = '&aacute;';
      entities['226'] = '&acirc;';
      entities['227'] = '&atilde;';
      entities['228'] = '&auml;';
      entities['229'] = '&aring;';
      entities['230'] = '&aelig;';
      entities['231'] = '&ccedil;';
      entities['232'] = '&egrave;';
      entities['233'] = '&eacute;';
      entities['234'] = '&ecirc;';
      entities['235'] = '&euml;';
      entities['236'] = '&igrave;';
      entities['237'] = '&iacute;';
      entities['238'] = '&icirc;';
      entities['239'] = '&iuml;';
      entities['240'] = '&eth;';
      entities['241'] = '&ntilde;';
      entities['242'] = '&ograve;';
      entities['243'] = '&oacute;';
      entities['244'] = '&ocirc;';
      entities['245'] = '&otilde;';
      entities['246'] = '&ouml;';
      entities['247'] = '&divide;';
      entities['248'] = '&oslash;';
      entities['249'] = '&ugrave;';
      entities['250'] = '&uacute;';
      entities['251'] = '&ucirc;';
      entities['252'] = '&uuml;';
      entities['253'] = '&yacute;';
      entities['254'] = '&thorn;';
      entities['255'] = '&yuml;';
    } else {
        throw Error("Table: "+useTable+' not supported');
        return false;
    }
    
    // ascii decimals to real symbols
    for (decimal in entities) {
        symbol = String.fromCharCode(decimal)
        histogram[symbol] = entities[decimal];
    }
    
    return histogram;
}

var g_sEmailFieldBeingChecked = "txtEmail";
function valEmailAddress(inTextFieldID) {
	isValidating = true;
	g_sEmailFieldBeingChecked = inTextFieldID;
	if (GetElement(inTextFieldID)) {
		var val = GetElement(inTextFieldID).value;
		if (document.g_sEmailValidValue != val) {
			ajax_isEmailValid(val);
		}
		else {
			isValidating = false;
			if (isSubmitting) alert("already checked, so now I'm submitting");
			if (isSubmitting) doSubmitPrep();
		}
	}
	return false;
}
//KDC, 9-23-2010. Validate email address (doSubmitPrep must be defined on the individual page.  Must have txtEmail)
function doValidateEmail() {
	valEmailAddress("txtEmail");
	return false;
}
function checkValidating() {
	isSubmitting = true;
	if (isValidating) return false;
	else doSubmitPrep();
	return false;
}
function showIsValidEmail(isValid) {
	if (!isValid) {
		alert("Note: This email address does not appear to be valid; please check to make sure you have not misspelled it.");
		GetElement(g_sEmailFieldBeingChecked).select();
		isSubmitting = false;
	}
	else if (isSubmitting) {
		doSubmitPrep();
	}
	isValidating = false;
}

//KDC, 5-12-2011
function convertDHMtoMin(inDays,inHours,inMinutes) {
	var mins = 0;
	mins = mins + (inDays * 24 * 60);
	mins = mins + (inHours * 60);
	mins = mins + (inMinutes * 1);
	return mins;
}
function calculateMinutes(inValField) {
	var el = null;
	var days = 0;
	var hrs = 0;
	var mins = 0;
	el = GetElement(inValField+"Days");
	if (el != null) days = el.value;
	el = GetElement(inValField+"Hours");
	if (el != null) hrs = el.value;
	el = GetElement(inValField+"Mins");
	if (el != null) mins = el.value;
	return convertDHMtoMin(days,hrs,mins);
}
function convertMintoDHM(inMinutes,inDaysField,inHoursField,inMinsField) {
	var minsleft = 0;
	var el = null;
	var days = 0;
	var hrs = 0;
	days = Math.floor(inMinutes / (60*24));
	el = GetElement(inDaysField);
	if (el != null) el.value = days;
	minsleft = inMinutes % (60*24);
	hrs = Math.floor(minsleft / 60);
	el = GetElement(inHoursField);
	if (el != null) el.value = hrs;
	minsleft = minsleft % 60;
	el = GetElement(inMinsField);
	if (el != null) el.value = minsleft;
	return false;
}

//KDC, 5-26-2011. Using sixrevisions.com script
var tooltip=function(){
 var id = 'tt';
 var top = 3;
 var left = 3;
 var maxw = 500;
 var speed = 10;
 var timer = 20;
 var endalpha = 95;
 var alpha = 0;
 var tt,t,c,b,h;
 var ie = document.all ? true : false;
 return{
  show:function(e,v,w){
   if(tt == null){
    tt = document.createElement('div');
    tt.setAttribute('id',id);
    t = document.createElement('div');
    t.setAttribute('id',id + 'top');
    c = document.createElement('div');
    c.setAttribute('id',id + 'cont');
    b = document.createElement('div');
    b.setAttribute('id',id + 'bot');
    tt.appendChild(t);
    tt.appendChild(c);
    tt.appendChild(b);
    document.body.appendChild(tt);
    tt.style.opacity = 0;
    tt.style.filter = 'alpha(opacity=0)';
   	//document.onmousemove = this.pos;
	tt.onmouseout = this.hide;
   }
   tt.style.display = 'block';
   c.innerHTML = v;
   tt.style.width = w ? w + 'px' : 'auto';
   if(!w && ie){
    t.style.display = 'none';
    b.style.display = 'none';
    tt.style.width = tt.offsetWidth;
    t.style.display = 'block';
    b.style.display = 'block';
   }
  if(tt.offsetWidth > maxw){tt.style.width = maxw + 'px'}
  h = parseInt(tt.offsetHeight) + top;
  clearInterval(tt.timer);
  tt.timer = setInterval(function(){tooltip.fade(1)},timer);
	var u = ie ? event.clientY + document.documentElement.scrollTop : e.pageY;
	var l = ie ? event.clientX + document.documentElement.scrollLeft : e.pageX;
	tt.style.top = (u - h + 30) + 'px';
	tt.style.left = (l + left - 30) + 'px';
  },
  pos:function(e){
		var u = ie ? event.clientY + document.documentElement.scrollTop : e.pageY;
		var l = ie ? event.clientX + document.documentElement.scrollLeft : e.pageX;
		tt.style.top = (u - h + 14) + 'px';
		tt.style.left = (l + left - 30) + 'px';
  },
  fade:function(d){
   var a = alpha;
   if((a != endalpha && d == 1) || (a != 0 && d == -1)){
    var i = speed;
   if(endalpha - a < speed && d == 1){
    i = endalpha - a;
   }else if(alpha < speed && d == -1){
     i = a;
   }
   alpha = a + (i * d);
   tt.style.opacity = alpha * .01;
   tt.style.filter = 'alpha(opacity=' + alpha + ')';
  }else{
    clearInterval(tt.timer);
     if(d == -1){tt.style.display = 'none'}
  }
 },
 hide:function(){
	//clearInterval(tt.timer);
	//tt.timer = setInterval(function(){tooltip.fade(-1)},timer);
	tt.style.display = 'none';
  }
 };
}();

