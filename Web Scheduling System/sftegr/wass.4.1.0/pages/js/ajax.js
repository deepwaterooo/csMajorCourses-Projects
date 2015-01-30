/***************************/
/* AJAXInteraction "class" */
/***************************/

//Class needed to allow for multiple, concurrent AJAX requests.  Need to pool?  IE apparently only allows 2 at a time.
function AJAXInteraction(inURL, inHandleFunction) {
	var httpreq = getHTTPObject(); //HTTP Object for AJAX
	httpreq.onreadystatechange = processResponse;
	
	function getHTTPObject() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			try {
				xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch(e) {
				try {
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch(e) {
					xmlhttp = null;
				}
			}
		}
		return xmlhttp;
	}
	function processResponse() {
		if (httpreq.readyState == 4) {
			if (httpreq.status == 200) {
				//alert("text: " + httpreq.responseText);
				//alert("xml: " + httpreq.responseXML);
				//alert("inHandleFunction:" + inHandleFunction);
			  if (inHandleFunction) inHandleFunction(httpreq.responseXML);
			  httpreq = null;
			} else {
			  alert ("Not able to retrieve response");
			}
		}
	}
	this.doRequest = function(inParms) {
		//httpreq = getHTTPObject();  //create the HTTP Object for AJAX
		//alert( 'url=' + inURL );
		//alert( 'inParms=' + inParms );
		httpreq.open("POST", inURL, true);
		httpreq.setRequestHeader("Content-type","text/xml; charset=ISO-8859-1");
		httpreq.send(inParms);
	}
}

function AJAXInteractionSynch(inURL, inHandleFunction)
{
	var httpreq = getHTTPObject(); //HTTP Object for AJAX
	httpreq.onreadystatechange = processResponse;
	
	function getHTTPObject() {
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return xmlhttp;
	}
	function processResponse() {
		if (httpreq.readyState == 4) {
			if (httpreq.status == 200) {
				//alert("text: " + httpreq.responseText);
				//alert("xml: " + httpreq.responseXML);
				//alert("inHandleFunction:" + inHandleFunction);
			  if (inHandleFunction) inHandleFunction(httpreq.responseXML);
			  httpreq = null;
			} else {
			  alert ("Not able to retrieve response");
			}
		}
	}
	this.doRequest = function(inParms) {
		//httpreq = getHTTPObject();  //create the HTTP Object for AJAX
		//alert( 'url=' + inURL );
		//alert( 'inParms=' + inParms );
		httpreq.open("POST", inURL, false);
		httpreq.setRequestHeader("Content-type","text/xml; charset=ISO-8859-1");
		httpreq.send(inParms);
	}
}
/**************************************/
/* AJAX Utility variables and methods */
/**************************************/


var g_sXMLHeader = "";
var g_sXMLFooter = "";
var g_sURL = "";

function initAjax() {
	var sSchemaRoot = GetElement("hidAJAXSchemaRoot").value;
	g_sXMLHeader = '<?xml version="1.0" encoding="ISO-8859-1"?> <wass xmlns="' + sSchemaRoot + '" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xsi:schemaLocation="' + sSchemaRoot + '/wass.xsd"> ';
	g_sXMLFooter = ' </wass>';
	g_sURL = GetElement("hidAJAXURL").value;
}

function isThereAValueFor(inXML,inField) {
	if (inXML.getElementsByTagName(inField).length > 0 && inXML.getElementsByTagName(inField)[0].firstChild != null)
		return true;
	return false;
}
function getValueFor(inXML,inField) {
	if (isThereAValueFor(inXML,inField))
		return inXML.getElementsByTagName(inField)[0].firstChild.data;
	return "";
}

function parseMessage(respXML,inL1TagName) {
	var theresponse = respXML; //httpreq.responseXML;
	if (theresponse == null) {
		return false;
		alert("NO AJAX RESPONSE FROM SERVER");
	}
	//console.log(theresponse);
	//console.log(theresponse.getElementsByTagName('wass').length);
	if (theresponse.getElementsByTagName('wass').length == 0) {
		alert("XML cannot be read.  Please verify XML stream");
		return false;
	}
	var root = theresponse.getElementsByTagName('wass')[0]; //1 and only 1 wass element
	//alert("root:" + root);
	var xmlresult = null;
	
	//check for errors on the whole transaction
	var errcode = 0;
	var errmsg = "";
	//alert(root.childNodes.length);
		for (var i=0; i < root.childNodes.length; i++) {
			var nde = root.childNodes[i];
			if (nde.nodeName == "error") {
				errcode = nde.getElementsByTagName('errorcode')[0].firstChild.data;
				//alert(errcode);
				if (errcode > 0) {
					//there's an error, handle accordingly...
					errmsglist = nde.getElementsByTagName('errortext');
					if (errmsglist != null)
						errmsg = nde.getElementsByTagName('errortext')[0].firstChild.data;
					alert("AJAX ERROR: " + errcode + ":" + errmsg);
					return "";
				}
			}
		}
	
		//now parse the rest of it
		//assume parseMessage will be called for each transaction type returned (and that there will be only 1)
		xmlresult = root.getElementsByTagName(inL1TagName);
		if (xmlresult != null && xmlresult.length > 0) {
			xmlresult = xmlresult[0];
			//check for errors within the transaction
			errcode = 0;
			errmsg = "";
			var errlist = xmlresult.getElementsByTagName('error'); //0 or 1 error element. If 0 elements, then success
			//if there's an error...
			if (errlist != null && errlist.length > 0) {
				errcode = errlist[0].getElementsByTagName('errorcode')[0].firstChild.data;
				if (errcode > 0) {
					//there's an error, handle accordingly...
					errmsglist = errlist[0].getElementsByTagName('errortext');
					if (errmsglist != null)
						errmsg = errlist[0].getElementsByTagName('errortext')[0].firstChild.data;
					alert("AJAX ERROR: " + errcode + ":" + errmsg);
					return "";
				}
				xmlresult.removeChild(errlist[0]);
			}
		}
	
	//alert ( 'xmlresult=' + xmlresult );

	return xmlresult;
}





/*****************/
/* AJAX Calls    */
/*****************/


/********************************************/
/* getAvailableDays                */
/********************************************/
function parms_getAvailableDatesTwoMonths(inCalendarID, inMonth1, inYear1)
{
	var inMonth2 = inMonth1*1+1;
	var inYear2 = inYear1;
	if ( (inMonth2*1) < (inMonth1*1) )
		inYear2 = inYear1*1+1;

	//alert( inMonth1 + "," + inYear1 + "," + inMonth2 + "," + inYear2 );

  var sParms = "<getavailabledates>"
		+ "<sessionid>" + document.g_sID + "</sessionid>"
    + "<calendarid>" + inCalendarID + "</calendarid>"
    + "<startdate>" + inYear1 + "-" + getRightMonth(inMonth1) + "-01</startdate>"
    + "<enddate>" + inYear2 + "-" + getRightMonth(inMonth2) + "-" + getNumDaysInMonth( eval(getRightMonth(inMonth2)*1), inYear2) + "</enddate>"
    + "</getavailabledates>";
  return sParms;
}

function parms_getMaxApptsForBlock( inBlockId )
{
  var sParms = "<makeableapps>"
		+ "<sessionid>" + document.g_sID + "</sessionid>"
    + "<blockid>" + inBlockId + "</blockid></makeableapps>"
	return sParms;
}


function ajax_getMaxApptsForBlock( inSessionId, inBlockId)
{
  var sParms = g_sXMLHeader + parms_getMaxApptsForBlock(inBlockId) + g_sXMLFooter;
  var ai = new AJAXInteractionSynch(g_sURL,process_getMaxApptsForBlock);
  ai.doRequest(sParms);
}

function process_getMaxApptsForBlock(inXML)
{
  var elResults = parseMessage(inXML,"makeableapps");
  if (elResults == null) {
    errorhandle_getMaxApptsForBlock();
    return false;
  }
	var count = elResults.getElementsByTagName('count')[0].firstChild.data + "";
	if ( count != null )
	{
		alert( "max appoint num=" + count );
		maxApptsForBlock = count;
	} else
		maxApptsForBlock = 1;
}

function ajax_getAvailableDates(inCalendarID,inDate)
{
	var sParms = g_sXMLHeader;
  sParms += parms_getAvailableDatesTwoMonths(inCalendarID, inDate.getMonth(), inDate.getFullYear());
	sParms += g_sXMLFooter;

  var ai = new AJAXInteractionSynch(g_sURL,process_getAvailableDates);
  ai.doRequest(sParms);
}

function process_getAvailableDates(inXML) {
  //Parse response
  //alert("processing");
  var elResults = parseMessage(inXML,"getavailabledates");
  if (elResults == null) {
    errorhandle_getAvailableDates();
    return false;
  }

	//alert( document.isMultiCalendar );
	var avail, dtemp;
	var date = elResults.getElementsByTagName('startdate')[0].firstChild.data + "";
	//alert( 'start xml=' + date );
	//alert( date.substr(0,4) + ',' + date.substr(5,2) + ',' + date.substr(8,2) );

  var dtStart = new Date();
	dtStart.setYear((date.substr(0,4)));
	dtStart.setMonth((date.substr(5,2))-1);
	dtStart.setDate((date.substr(8,2)));

	//alert( 'start date=' + dtStart );
  var dtEnd = new Date(elResults.getElementsByTagName('enddate')[0].firstChild.data); //required
  var dates = elResults.getElementsByTagName('date');
	//JJC, 9-19-2007.  Loop thru available days and store in two dim array.
	//JJC, 10-1-2007.  redo. inefficient usage of arrays.
	sCals_availblocks = new Array(2);
	sCals_availblocks[0] = new Array(dates.length);
	sCals_availblocks[1] = new Array(dates.length);
	for ( var i=0; i<dates.length; ++i )
	{
		dtemp = elResults.getElementsByTagName('date')[i].firstChild.data;
		date = new Date( dtemp.substr(0,4), dtemp.substr(5,2)-1, dtemp.substr(8,2) );
		if ( date.getMonth() == dtStart.getMonth() )
		{
			sCals_availblocks[0][date.getDate()] = elResults.getElementsByTagName('available')[i].firstChild.data;
			//alert( "date=" + date + " *** 0, " + date.getDate() + ", avail=" + sCals_availblocks[0, date.getDate()] + ", " + elResults.getElementsByTagName('available')[i].firstChild.data );
		} else
		{
			sCals_availblocks[1][date.getDate()] = elResults.getElementsByTagName('available')[i].firstChild.data;
			//alert( "date=" + date + " &&& 1, " + date.getDate() + ", avail=" + sCals_availblocks[1, date.getDate()] + ", " + elResults.getElementsByTagName('available')[i].firstChild.data );
		}
	}

	//alert( sCals_availblocks );
  //Reflect changes on screen
  //show_getAvailableDays(sBestView);
  //KDC, 1-16-2008. Adding call to update the left calendar highlighted dates here.
  calendar.highlightAvailableDates(dtStart,1);
}

function show_getAvailableDates(sBestView) {}
function errorhandle_getAvailableDates() {}

function getRightMonth( inMonth )
{
	var ret = eval(inMonth*1 + 1) + "";
	if ( ret.length == 1 ) ret = "0" + ret; 
	//alert( inMonth + ", " + ret );
	return  ret;
}


/********************************************/
/* getdatestatus                            */
/********************************************/
function parms_getDateStatusTwoMonths(inCalendarID, inMonth1, inYear1, inBlockOwnerID)
{
	var inMonth2 = inMonth1*1+1;
	if ( (inMonth2*1) >= 12 )
		inMonth2 = 0;
	var inYear2 = inYear1;
	if ( (inMonth2*1) < (inMonth1*1) )
		inYear2 = inYear1*1+1;

	//alert( inMonth1 + "," + inYear1 + "," + inMonth2 + "," + inYear2 );

	//KDC, 6-23-2009. Handle multiple calendar IDs
	var calids = (inCalendarID + "").split(",").join(" ");
		
	var sParms = "<getdatestatus>"
		+ "<sessionid>" + document.g_sID + "</sessionid>"
		+ "<calendarid>" + calids + "</calendarid>"
		+ "<startdate>" + inYear1 + "-" + getRightMonth(inMonth1) + "-01</startdate>"
		+ "<enddate>" + inYear2 + "-" + getRightMonth(inMonth2) + "-" + getNumDaysInMonth( eval(getRightMonth(inMonth2)*1), inYear2) + "</enddate>"
		+ "<blockownerid>" + inBlockOwnerID + "</blockownerid>"
		+ "</getdatestatus>";
	return sParms;
}

function ajax_getDateStatus(inCalendarID,inDate,inBlockOwnerID)
{
	var sParms = g_sXMLHeader;
	sParms += parms_getDateStatusTwoMonths(inCalendarID, inDate.getMonth(), inDate.getFullYear(), inBlockOwnerID);
	sParms += g_sXMLFooter;

	var ai = new AJAXInteractionSynch(g_sURL,process_getDateStatus);
	ai.doRequest(sParms);
}

function process_getDateStatus(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getdatestatus");
	if (elResults == null) {
		errorhandle_getDateStatus();
		return false;
	}

	var avail, dtemp;
	var dt = elResults.getElementsByTagName('startdate')[0].firstChild.data + "";
	//alert( 'start xml=' + date );
	//alert( date.substr(0,4) + ',' + date.substr(5,2) + ',' + date.substr(8,2) );

	var dtStart = new Date();
	dtStart.setDate((dt.substr(8,2))); //KDC, 1-31-2010. Moved date first because if "today" is the 31st and month of dt is Feb, then the date gets bumped to March (since there is no Feb 31).
	dtStart.setYear((dt.substr(0,4)));
	dtStart.setMonth((dt.substr(5,2))-1);

	//var dtEnd = new Date(elResults.getElementsByTagName('enddate')[0].firstChild.data); //required
	//alert( 'start date=' + dtStart + ', end date=' + dtEnd );
	var dates = elResults.getElementsByTagName('date');
	//put the dates into a 2-dim array, by month (2 months)
	document.sCals_datestatus = new Array(2);
	document.sCals_datestatus[0] = new Array(dates.length);
	document.sCals_datestatus[1] = new Array(dates.length);
	for ( var i=0; i<dates.length; i++ ) {
		dtemp = elResults.getElementsByTagName('date')[i].firstChild.data;
		dt = new Date( dtemp.substr(0,4), dtemp.substr(5,2)-1, dtemp.substr(8,2) );
		if ( dt.getMonth() == dtStart.getMonth() ) {
			document.sCals_datestatus[0][dt.getDate()] = elResults.getElementsByTagName('status')[i].firstChild.data;
			//alert( "date=" + date + " *** 0, " + date.getDate() + ", avail=" + sCals_availblocks[0, date.getDate()] + ", " + elResults.getElementsByTagName('available')[i].firstChild.data );
		} else {
			document.sCals_datestatus[1][dt.getDate()] = elResults.getElementsByTagName('status')[i].firstChild.data;
			//alert( "date=" + date + " &&& 1, " + date.getDate() + ", avail=" + sCals_availblocks[1, date.getDate()] + ", " + elResults.getElementsByTagName('available')[i].firstChild.data );
		}
	}

	//Reflect changes on screen
	calendar.highlightDateStatus(dtStart,1);
}

function show_getDateStatus() {}
function errorhandle_getDateStatus() {}



/********************************************/
/* initCalendar								*/
/********************************************/
function ajax_initCalendar(inCalendarID,inUserID,inStartDate,inEndDate,isGetBlocks,inBlockOwnerID) {
	//AJAX Calls (getdaytypes,getbestview,getvalidviews,getblocks)
	var sParms = g_sXMLHeader;
		sParms += parms_getDayTypes(inStartDate,inEndDate);
		sParms += parms_getBestView(inCalendarID,inStartDate);
//KDC, 3-5-3008. No longer needed.
//		sParms += parms_getValidViews(inCalendarID,inStartDate); //should only be called for day view
		if (isGetBlocks)
			sParms += parms_getBlocks(inCalendarID,inStartDate,inEndDate,inBlockOwnerID);
		sParms += parms_getCalendars(inCalendarID);
		//sParms += parms_getAvailableDatesTwoMonths(inCalendarID, inStartDate.getMonth(), inStartDate.getFullYear());
		sParms += parms_getDateStatusTwoMonths(inCalendarID, inStartDate.getMonth(), inStartDate.getFullYear(),inBlockOwnerID); //KDC,2-27-2008
		sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_initCalendar);
	ai.doRequest(sParms);
}
function process_initCalendar(inXML) {

	process_getDayTypes(inXML);
	process_getBestView(inXML);
//KDC, 3-5-3008. No longer needed.
//	process_getValidViews(inXML);
	process_getBlocks(inXML);  //calls ajax_getAppointments
	//process_getAvailableDates(inXML);
	//alert("getting date status initCal");
	process_getDateStatus(inXML); //KDC, 2-27-2008. Removed Available, put status
	process_getCalendars(inXML);
	//alert("processed getCals");
}


/********************************************/
/* redrawBlocks								*/
/********************************************/
var dTemp;
function ajax_redrawBlocks(inCalendarID,inStartDate,inEndDate,inBlockOwnerID) {
	//AJAX Calls (getbestview,getvalidviews,getblocks)
	var cal = document.arr_CalShown[0];
	dTemp = new Date( cal.year, cal.month, cal.datebegin );

	//console.log( "startDate=" + inStartDate + ", dTemp=" + dTemp );
	var sParms = g_sXMLHeader;
		sParms += parms_getBestView(inCalendarID,inStartDate);
//KDC, 3-5-3008. No longer needed.
//		sParms += parms_getValidViews(inCalendarID,inStartDate); //should only be called for day view
		sParms += parms_getBlocks(inCalendarID,inStartDate,inEndDate,inBlockOwnerID);
//		sParms += parms_getAvailableDatesTwoMonths(inCalendarID, cal.month, cal.year );
		sParms += parms_getDateStatusTwoMonths(inCalendarID, cal.month, cal.year, inBlockOwnerID ); //KDC,2-27-2008
		sParms += parms_getCalendars(inCalendarID); //KDC, 2-19-2010. This adds more overhead, but need to do it for group calendar info at block level.
		sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_redrawBlocks);
	ai.doRequest(sParms);
}
function process_redrawBlocks(inXML) {
	process_getBestView(inXML);
//KDC, 3-5-3008. No longer needed.
//	process_getValidViews(inXML);
	process_getBlocks(inXML);  //calls ajax_getAppointments
	//process_getAvailableDates(inXML);
	process_getDateStatus(inXML); //KDC,2-27-2008. Removed available, added status
	process_getCalendars(inXML); //KDC, 2-19-2010. This adds more overhead, but need to do it for group calendar info at block level.
	////calendar.highlightAvailableDates(dTemp, 1);
}


/********************************************/
/* getcalendars								*/
/********************************************/
function parms_getCalendars(inCalID) {
	var sParms = "";
	for (var i=0; i < inCalID.length; i++) {
		sParms += "<getcalendars>";
		sParms += "<sessionid>" + document.g_sID + "</sessionid>";
		sParms += "<calendarid>" + inCalID[i] + "</calendarid>";
		sParms += "</getcalendars>";
	}
	return sParms;
}
function ajax_getCalendars(inCalID) {
	//AJAX Call (getcalendars)
	var sParms = g_sXMLHeader + parms_getCalendars(inCalID) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getCalendars);
	ai.doRequest(sParms);
}
function process_getCalendars(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getcalendars");
	if (elResults == null) {
		errorhandle_getCalendars();
		return false;
	}

	var xmlCals = elResults.getElementsByTagName("calendar"); //required
	if (xmlCals != null && xmlCals.length > 0) {
		for (var i=0; i < elResults.childNodes.length; i++) {
			var elXML = elResults.childNodes[i];
			if (elResults.childNodes[i].nodeName == "calendar") {
				var iCalID = elXML.getElementsByTagName("calendarid")[0].firstChild.data;
				var sName = elXML.getElementsByTagName("name")[0].firstChild.data;
				var sTitle = elXML.getElementsByTagName("title")[0].firstChild.data;
				var isGroup = elXML.getElementsByTagName("group")[0].firstChild.data;
				var arrBlks = Block.GetBlocksByCalID(iCalID);
				for (var j=0; j < arrBlks.length; j++) {
					arrBlks[j].setCalOwner(sName);
					arrBlks[j].setCalTitle(sTitle);
					arrBlks[j].setIsCalGroup(isGroup);
				}
			}
		}
	}

	//Reflect changes into HTML
	//show_getCalendars();
}
function show_getCalendars() {
	return false;
}
function errorhandle_getCalendars() {
}


/********************************************/
/* getdaytypes								*/
/********************************************/
function parms_getDayTypes(inStartDate,inEndDate) {
	var sParms = "<getdaytypes>";
	var iNumDays = 0;
	var iNumDaysInStartMonth = calendar.getNumDaysInMonth(inStartDate.getMonth()+1,inStartDate.getFullYear());
	//note that for weeks, start and end dates could span 2 months.
	//KDC, 1-28-2009. Need to check for years, too.
	if ((inStartDate.getFullYear() == inEndDate.getFullYear() && inStartDate.getMonth() < inEndDate.getMonth()) || inStartDate.getFullYear() < inEndDate.getFullYear()) {
		iNumDays = iNumDaysInStartMonth - inStartDate.getDate() + 1 + inEndDate.getDate();
	} else {
		iNumDays = inEndDate.getDate() - inStartDate.getDate() + 1;
	}
	for (var i=0; i < iNumDays; i++) {
		var dt = new Date(inStartDate.getTime());
		var newDate = dt.getDate() + i;
		//note that for weeks, start and end dates could span 2 months
		if (newDate > iNumDaysInStartMonth) {
			var mo = dt.getMonth() + 1;
			newDate = newDate - iNumDaysInStartMonth;
			if (mo == 12) {
				mo = 0;
				dt.setFullYear(dt.getFullYear() + 1);
			}
			dt.setMonth(mo);
		}
		dt.setDate(newDate);
		sParms += "<daytypes><date>" + formatDateforServer(dt) + "</date></daytypes>";
	}
	sParms += "</getdaytypes>";
	return sParms;
}
function ajax_getDayTypes(inStartDate,inEndDate) {
	//AJAX Call (getdaytype)
	var sParms = g_sXMLHeader + parms_getDayTypes(inStartDate,inEndDate) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getDayTypes);
	ai.doRequest(sParms);
}
function process_getDayTypes(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getdaytypes");
	if (elResults == null) {
		errorhandle_getDayTypes();
		return false;
	}

	var xmlDayTypes = elResults.getElementsByTagName("daytypes"); //required
	var arrDayTypes = new Array();
	for (var i=0; i < xmlDayTypes.length; i++) {
		var sDayType = xmlDayTypes[i].getElementsByTagName("daytype")[0].firstChild.data;
		arrDayTypes.push(sDayType);
	}

	//Reflect changes into HTML
	show_getDayTypes(arrDayTypes);
}
function show_getDayTypes(arrDayTypes) {
	alert("showing day types: " + arrDayTypes);
}
function errorhandle_getDayTypes() {
}


/* Parameters */
/********************************************/
/* getparameter								*/
/********************************************/
function parms_getParameter(inParameter) {
	var sParms = "<getparameter><parameter>" + inParameter + "</parameter></getparameter>";
	return sParms;
}
function ajax_getParameter(inParameter) {
	//AJAX Call (getParameter)
	var sParms = g_sXMLHeader + parms_getParameter(inParameter) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getParameter);
	ai.doRequest(sParms);
}
function process_getParameter(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getparameter");
	if (elResults == null) {
		errorhandle_getParameter();
		return false;
	}

	var sParam = "";
	var sVal = "";
	sParam = elResults.getElementsByTagName('parameter')[0].firstChild.data; //required
	sVal = elResults.getElementsByTagName('value')[0].firstChild.data; //required
	
	//Reflect changes into HTML
	show_getParameter(sParam,sVal);
}
function show_getParameter(sParam,sVal) {
	alert("showing parameter: " + sParam + ":" + sVal);
}
function errorhandle_getParameter() {
}



/* Preferences */
/********************************************/
/* saveprefs								*/
/********************************************/

function parms_savePrefs(inPrefKey, inValue) {
	var sParms = "<saveprefs><sessionid>" + document.g_sID + "</sessionid>";
		sParms += "<pref><keytag>" + inPrefKey + "</keytag><val>" + inValue + "</val></pref></saveprefs>";
	return sParms;
}
function ajax_savePrefs(inPrefKey, inValue) {
	//AJAX Call (saveprefs)
	var sParms = g_sXMLHeader + parms_savePrefs(inPrefKey, inValue) + g_sXMLFooter;
	//alert(sParms);
	var ai = new AJAXInteraction(g_sURL,process_savePrefs);
	ai.doRequest(sParms);
}
function process_savePrefs(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"saveprefs");
	if (elResults == null) {
		errorhandle_savePrefs();
		return false;
	}
	
	//Reflect changes into HTML
	//show_savePrefs();
}
function show_savePrefs() {
	//alert("showing prefs");
}
function errorhandle_savePrefs() {
}

/********************************************/
/* getprefs  								*/
/********************************************/
/*function parms_getPrefs(inPrefKeyArray) {
	var sParms = "<getprefs><sessionid>" + document.g_sID + "</sessionid>";
	for (var i=0; i < inPrefKeyArray.length; i++) {
		sParms += "<pref><keytag>" + inPrefKeyArray[i] + "</keytag></pref>";
	}
	sParms += "</getprefs>";
	return sParms;
}
function ajax_getPrefs(inPrefKeyArray) {
	//AJAX Call (getprefs)
	var sParms = g_sXMLHeader + parms_getPrefs(inPrefKeyArray) + g_sXMLFooter;
//	alert(sParms);
	var ai = new AJAXInteraction(g_sURL,process_getPrefs);
//	alert(ai);
	ai.doRequest(sParms);
}
function process_getPrefs(inXML) {
//	alert("processing");
	//Parse response
	var elResults = parseMessage(inXML,"getprefs");
	if (elResults == null) {
		errorhandle_getPrefs();
		return false;
	}

	var xmlPrefs = elResults.getElementsByTagName('pref');	
//alert(xmlPrefs.length);
	var arrKeys = new Array();
	var arrVals = new Array();
	for (var i=0; i < xmlPrefs.length; i++) {
		var sKey = xmlPrefs[i].getElementsByTagName("keytag")[0].firstChild.data;
		arrKeys.push(sKey);
		var sValue = xmlPrefs[i].getElementsByTagName("val")[0].firstChild.data;
		arrVals.push(sValue);
	}
	
	//Reflect changes into HTML
	show_getPrefs(arrKeys,arrVals);
}
function show_getPrefs(arrKeys,arrVals) {
	alert("showing prefs: " + arrKeys + ":" + arrVals);
}
function errorhandle_getPrefs() {
}
*/

/********************************************/
/* getalluserprefs 							*/
/********************************************/
/*function parms_getAllUserPrefs(inPrefKeyArray) {
	var sParms = "<getalluserprefs><sessionid>" + document.g_sID + "</sessionid>";
		sParms += "</getalluserprefs>";
	return sParms;
}
function ajax_getAllUserPrefs(inPrefKeyArray) {
	//AJAX Call (getalluserprefs)
	var sParms = g_sXMLHeader + parms_getAllUserPrefs(inPrefKeyArray) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getAllUserPrefs);
	ai.doRequest(sParms);
}
function process_getAllUserPrefs(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getalluserprefs");
	if (elResults == null) {
		errorhandle_getAllUserPrefs();
		return false;
	}

	var xmlPrefs = elResults.getElementsByTagName('pref');	
//alert(xmlPrefs.length);
	var arrKeys = new Array();
	var arrVals = new Array();
	for (var i=0; i < xmlPrefs.length; i++) {
		var sKey = xmlPrefs[i].getElementsByTagName("keytag")[0].firstChild.data;
		arrKeys.push(sKey);
		var sValue = xmlPrefs[i].getElementsByTagName("val")[0].firstChild.data;
		arrVals.push(sValue);
	}
	
	//Reflect changes into HTML
	show_getAllUserPrefs(arrKeys,arrVals);
}
function show_getAllUserPrefs(arrKeys,arrVals) {
	alert("showing prefs: " + arrKeys + ":" + arrVals);
}
function errorhandle_getAllUserPrefs() {
}
*/


/* Views (Time Slot Sizes) */
function parseTimeSlotSizes(inSViews) {
	var arrViews = inSViews.split(" ");
	return arrViews;
}
/********************************************/
/* getallviews								*/
/********************************************/
function parms_getAllViews() {
	var sParms = "<getallviews/>";
	return sParms;
}
function ajax_getAllViews() {
	//AJAX Call (getAllViews)
	var sParms = g_sXMLHeader + parms_getAllViews() + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getAllViews);
	ai.doRequest(sParms);
}
function process_getAllViews(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"getallviews");
	if (elResults == null) {
		errorhandle_getAllViews();
		return false;
	}
	
	//var sViews = elResults.firstChild.data; //required
	var sViews = elResults.getElementsByTagName('allviews')[0].firstChild.data;
	sViews = trim(sViews);
	
	//Reflect changes on screen
	show_getAllViews(sViews);
}
function show_getAllViews(sViews) {
	alert("showing all views: " + sViews);
}
function errorhandle_getAllViews() {
}

/********************************************/
/* getvalidviews							*/
/********************************************/
function parms_getValidViews(inCalendarID,inDate) {
	var sParms = "<getvalidviews>"
		+ "<calendarid>" + inCalendarID + "</calendarid>"
		+ "<date>" + formatDateforServer(inDate) + "</date>"
		+ "</getvalidviews>";
	return sParms;
}
function ajax_getValidViews(inCalendarID,inDate) {
	//AJAX Call (getValidViews)
	var sParms = g_sXMLHeader + parms_getValidViews(inCalendarID,inDate) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getValidViews);
	ai.doRequest(sParms);
}
function process_getValidViews(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getvalidviews");
	if (elResults == null) {
		errorhandle_getValidViews();
		return false;
	}

	var dtShown = elResults.getElementsByTagName('date')[0].firstChild.data; //required
	var sViews = elResults.getElementsByTagName('validviews')[0].firstChild.data;
	sViews = trim(sViews);
	
	//Reflect changes on screen
	show_getValidViews(sViews);
}
function show_getValidViews(sViews) {
	alert("showing views: " + sViews);
}
function errorhandle_getValidViews() {
}

/********************************************/
/* getbestview								*/
/********************************************/
function parms_getBestView(inCalendarID,inDate) {
	var sParms = "<getbestview>"
		+ "<calendarid>" + inCalendarID + "</calendarid>"
		+ "<date>" + formatDateforServer(inDate) + "</date>"
		+ "</getbestview>";
	return sParms;
}
function ajax_getBestView(inCalendarID,inDate) {
	//AJAX Call (getbestview)
	var sParms = g_sXMLHeader + parms_getBestView(inCalendarID,inDate) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getBestView);
	ai.doRequest(sParms);
}
function process_getBestView(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getbestview");
	if (elResults == null) {
		errorhandle_getBestView();
		return false;
	}

	var dtShown = elResults.getElementsByTagName('date')[0].firstChild.data; //required
	var sBestView = elResults.getElementsByTagName('bestview')[0].firstChild.data;
	sBestView = trim(sBestView);
	
	//Reflect changes on screen
	show_getBestView(sBestView);
}
function show_getBestView(sBestView) {
	alert("best view: " + sBestView);
}
function errorhandle_getBestView() {
}


/* Blocks */
function parseBlock(inBlockXML,inSeriesXML,inWhyApptNotMakeable) {
	var iBlockID = inBlockXML.getElementsByTagName('blockid')[0].firstChild.data; //required, and only 1
	//check to see if the block is already existing?  if so, update instead of create new?
	var isUpdate = true;
	var blk = Block.GetBlockByID(iBlockID);
	if (blk == null) isUpdate = false;

	//block series ID
	var iBlockSeriesID = getValueFor(inBlockXML,"seriesid");
	if (iBlockSeriesID == "") iBlockSeriesID = -1;
	if (isUpdate) blk.iBlockSeriesID = iBlockSeriesID;

	//calendar ID
	var iCalendarID = getValueFor(inBlockXML,"calendarid");
	if (isUpdate) blk.iCalendarID = iCalendarID;
	
	var sCalOwner = "";
	var sCalTitle = "";
	var isCalGroup = false; 
	
	//recurrence
	var sRecurrence = getValueFor(inBlockXML,"recurrence");
	if (sRecurrence == "") sRecurrence = "once"; //values are once, multiple
	var isRecur = sRecurrence == "multiple" ? true : false; 
	if (isUpdate) blk.isRecurring = isRecur;

	//title
	var sTitle = getValueFor(inBlockXML,"title");
	if (isUpdate) blk.sTitle = sTitle;

	//location
	var sLocation = getValueFor(inBlockXML,"location");
	if (isUpdate) blk.sLocation = sLocation;

	//description
	var sDescription = getValueFor(inBlockXML,"description");
	if (isUpdate) blk.sDescription = sDescription;

	//slot size
	var iSlotSize = getValueFor(inBlockXML,"slotsize");
	if (iSlotSize == "") iSlotSize = 0;
	if (isUpdate) blk.iSlotSize = iSlotSize;
	
	//max appointments - will get only 1 value.  maxapps used for unslotted, maxper for slotted
	var isSlotted = getValueFor(inBlockXML,"slotted");
	if (isSlotted == "") isSlotted = "0";
	var iMaxAppts = 1; //default value
	if (isSlotted == "0") { //not slotted, get maxapps
		iMaxAppts = getValueFor(inBlockXML,"maxapps");
	} 
	else {	
		iMaxAppts = getValueFor(inBlockXML,"maxper");
		if ( iMaxAppts == 0 || iMaxAppts == "0")
			iMaxAppts = "no limit";
	}
	//console.log( "maxper=" + iMaxAppts );
	if (isUpdate) blk.iMaxAppts = iMaxAppts;
	
	//dates and times
	var dtStart = new Date();
	var sStart = getValueFor(inBlockXML,"date"); //in format yyyy-mm-dd
	if (sStart != "") {
		var yr = sStart.substr(0,4);
		var mo = sStart.substr(5,2);
		mo = eval(mo) - 1; //month in javascript is 1 less, Jan = 0
		var day = sStart.substr(8,2);
		dtStart = new Date(yr,mo,day,0,0,0);
	}
	var sStartTime = getValueFor(inBlockXML,"starttime"); //in format hh:mm:ss
	if (sStartTime != "") {
		var hr = sStartTime.substr(0,2);
		var mn = sStartTime.substr(3,2);
		var sc = sStartTime.substr(6,2);
		dtStart.setHours(hr);
		dtStart.setMinutes(mn);
		dtStart.setSeconds(sc);
	}
	if (isUpdate) { blk.dtStart = dtStart; blk.dtStartDisplayed = dtStart; }

	var dtEnd = new Date(dtStart.getTime());
	var sEndTime = getValueFor(inBlockXML,"endtime"); //in format hh:mm:ss
	if (sEndTime != "") {
		var hr = sEndTime.substr(0,2);
		var mn = sEndTime.substr(3,2);
		var sc = sEndTime.substr(6,2);
		dtEnd.setHours(hr);
		dtEnd.setMinutes(mn);
		dtEnd.setSeconds(sc);
	}
	if (isUpdate) { blk.dtEnd = dtEnd; blk.dtEndDisplayed = dtEnd; }
	
	//available
	var isAvailable = true;
	var sAvailable = getValueFor(inBlockXML,"available");
	if (sAvailable != "") {
		isAvailable = sAvailable == "0" ? false : true;
	}
	if (isUpdate) blk.isAvailable = isAvailable;
	
	//viewaccess
	//makeaccess

	//deadline
	var sDeadline = getValueFor(inBlockXML,"deadline"); //in minutes
	if (isUpdate) blk.iDeadlineMins = sDeadline;
	
	//schedule opening
	var sOpening = getValueFor(inBlockXML,"opening"); //in minutes
	if (isUpdate) blk.iOpeningMins = sOpening;
	
	//whyApptNotMakeable
	var sWhyApptNotMakeable = null;
	if (inWhyApptNotMakeable != undefined) { 
		sWhyApptNotMakeable = inWhyApptNotMakeable;
		if (isUpdate) blk.whyApptNotMakeable = sWhyApptNotMakeable;
	}

	//userid
	var sUserID = getValueFor(inBlockXML,"userid");
	if (isUpdate) blk.sUserID = sUserID;

	//name
	var sUserName = getValueFor(inBlockXML,"name");
	if (isUpdate) blk.sUserName = sUserName;
	
	//show appointment info (showappinfo).  KDC, 6-23-2009.
	var isShowAppInfo = getValueFor(inBlockXML,"showappinfo");
	if (isShowAppInfo == "") isShowAppInfo = "0";
	if (isUpdate) blk.isShowAppInfo = isShowAppInfo;
	
	if (isUpdate) {
		blk.setState();
		var ind = Block.GetBlockIndexByID(iBlockID);
		Block.G_ARRBLOCKS[ind] = blk;
	} else {
		blk = new Block(iBlockID,iBlockSeriesID,iCalendarID,sCalOwner,sCalTitle,isCalGroup,dtStart,dtEnd,sTitle,isRecur,sLocation,iSlotSize,iMaxAppts,isAvailable,sDeadline,sOpening,new Array(),sWhyApptNotMakeable,sDescription,sUserID,sUserName,isShowAppInfo);
		Block.G_ARRBLOCKS.push(blk);
	}
	
	return iBlockID;
}

/********************************************/
/* getblocks								*/
/********************************************/
function parms_getBlocks(inCalendarID,inStartDate,inEndDate,inUserID) {
	if (inEndDate.getHours() == 0) {
		inEndDate.setHours(23);
		inEndDate.setMinutes(59);
		inEndDate.setSeconds(59);
	}
	var sParms = "";
	for (var i=0; i < inCalendarID.length; i++) {
		sParms += "<getblocks><sessionid>" + document.g_sID + "</sessionid>"
			+ "<calendarid>" + inCalendarID[i] + "</calendarid>"
			+ "<startdate>" + formatDateforServer(inStartDate) + "</startdate>"
			+ "<enddate>" + formatDateforServer(inEndDate) + "</enddate>"
			+ "<starttime>" + formatTimeforServer(inStartDate) + "</starttime>"
			+ "<endtime>" + formatTimeforServer(inEndDate) + "</endtime>"
			+ "<userid>" + inUserID + "</userid>"
			+ "</getblocks>";
	}
	return sParms;
}
function ajax_getBlocks(inCalendarID,inStartDate,inEndDate,inUserID) {
	//AJAX Call (getblocks)
	var sParms = g_sXMLHeader + parms_getBlocks(inCalendarID,inStartDate,inEndDate,inUserID) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getBlocks);
	ai.doRequest(sParms);
}
function process_getBlocks(inXML) {
	//Parse response
	var arrBlockIDs = new Array();
	var elResults = parseMessage(inXML,"getblocks");
	if (elResults == null) {
		errorhandle_getBlocks();
		return false;
	}

	var xmlBlocks = elResults.getElementsByTagName('block');
	Block.G_ARRBLOCKS = new Array(); //reset
	if (xmlBlocks != null && xmlBlocks.length > 0) {
		//Hard-coded that this is the 6th element for now.
		var j = 0; //for whynotmakeable increment
		for (var i=7; i < elResults.childNodes.length; i++) {
			var blk = null;
			if (elResults.childNodes[i].nodeName == "block") {
				blk = elResults.childNodes[i];
			}
			var ser = null;
			if (i+1 < elResults.childNodes.length && elResults.childNodes[i+1].nodeName == "series") {
				ser = elResults.childNodes[i+1];
				i++;
			}
			//KDC - added for isappointmentmakeable information
			//alert(i + ": getting whynotmakeable - " + elResults.childNodes[i+1].nodeName + "," + elResults.getElementsByTagName('whynotmakeable').length);
			var whynotmakeable = null;
			if (i+1 < elResults.childNodes.length && elResults.childNodes[i+1].nodeName == "whynotmakeable") {
				if (j < elResults.getElementsByTagName('whynotmakeable').length && elResults.getElementsByTagName('whynotmakeable')[j].firstChild != null) {
					whynotmakeable = elResults.getElementsByTagName('whynotmakeable')[j].firstChild.data;
					j++;
				}
				i++;
			}
			
			if (blk != null) {
				//alert(whynotmakeable);
				var blockID = parseBlock(blk,ser,whynotmakeable);
				arrBlockIDs.push(blockID);
			}
		}
	}
	
	//Now get the appointments (need blocks to be created first)
	if (arrBlockIDs.length > 0) {
		//ajax_isAppointmentMakeable();
		ajax_getAppointments(arrBlockIDs); //process_getAppointments calls drawCal
	}
	else
		drawCal();
}
function errorhandle_getBlocks() {
}

/********************************************/
/* addblock									*/
/********************************************/
function parms_addBlock(inCalID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline) {
	var slotted = 0;
	var tagMaxAppts = "maxapps";
	if (inSlotSize > 0) {
		slotted = 1;
		tagMaxAppts = "maxper";
	}
	
	var sParms = "<addblock><sessionid>" + document.g_sID + "</sessionid>"
		+ "<block>"
		+ "<calendarid>" + inCalID + "</calendarid>"
		+ "<title>" + inTitle + "</title>"
		+ "<description>" + inDesc + "</description>"
		+ "<userid>" + inUserID + "</userid>"
		+ "<location>" + inLocation + "</location>"
		+ "<starttime>" + formatTimeforServer(inStartDateTime) + "</starttime>"
		+ "<endtime>" + formatTimeforServer(inEndDateTime) + "</endtime>"
		+ "<slotted>" + slotted + "</slotted>"
		+ "<slotsize>" + inSlotSize + "</slotsize>"
		+ "<" + tagMaxAppts + ">" + inMaxAppts + "</" + tagMaxAppts + ">"
		+ "<deadline>" + inDeadline + "</deadline>"
		+ "<date>" + formatDateforServer(inStartDateTime) + "</date>"
		+ "<recurrence>once</recurrence>"
		+ "</block>"
		+ "</addblock>";
	return sParms;
}
function ajax_addBlock(inIsRecurring,inCalID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline) {
	//AJAX Call (getblocks)
	var sParms = g_sXMLHeader + parms_addBlock(inCalID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline);
	//if (inIsRecurring)
	//	sParms += parms_addSeries();
	sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_addBlock);
	ai.doRequest(sParms);
}
function process_addBlock(inXML) {
	//Parse response
	var arrBlockIDs = new Array();
	var elResults = parseMessage(inXML,"addblock");
	if (elResults == null) {
		errorhandle_addBlock();
		return false;
	}
	
	var xmlBlocks = elResults.getElementsByTagName('block');
	
	if (xmlBlocks != null && xmlBlocks.length > 0) {
		//Hard-coded that this is the 1st element for now.
		for (var i=1; i < elResults.childNodes.length; i++) {
			var blk = null;
			if (elResults.childNodes[i].nodeName == "block") {
				blk = elResults.childNodes[i];
			}
			var ser = null;
			if (i+1 < elResults.childNodes.length && elResults.childNodes[i+1].nodeName == "series") {
				ser = elResults.childNodes[i+1];
				i++;
			}
			var blockID = parseBlock(blk,ser);
			arrBlockIDs.push(blockID);
		}
	}
	
	show_addBlock(arrBlockIDs);
}
function show_addBlock(arrBlockIDs) {
	var blk = Block.GetBlockByID(arrBlockIDs[0]);
	var tmpTime = drawRowGroup(GetElement(document.c_sTableBodyID),new Date(blk.dtStartDisplayed.getTime()),new Date(blk.dtEndDisplayed.getTime()),blk.iSlotSize,blk.sState,blk.iBlockID);
//KDC, 11/2/2007. Commented here and put in calendaractions.js endBlock() so that values can be used after this call.
//	document.indStartBlockTime = -1;
//	document.indEndBlockTime = -1;
}
function errorhandle_addBlock() {
	cancelBlock();
}


/********************************************/
/* extendblock								*/
/********************************************/
function parms_extendBlock(inCalID,inBlockID,inStartDateTime,inEndDateTime) {
	var sParms = "<editblock><sessionid>" + document.g_sID + "</sessionid>"
		+ "<block>"
		+ "<calendarid>" + inCalID + "</calendarid>"
		+ "<blockid>" + inBlockID + "</blockid>"
		+ "<starttime>" + formatTimeforServer(inStartDateTime) + "</starttime>"
		+ "<endtime>" + formatTimeforServer(inEndDateTime) + "</endtime>"
		+ "</block>"
		+ "</editblock>";
	return sParms;
}
function ajax_extendBlock(inCalID,inBlockID,inNewStartDate,inNewEndDate) {
	//AJAX Call (editblock)
	var sParms = g_sXMLHeader + parms_extendBlock(inCalID,inBlockID,inNewStartDate,inNewEndDate);
	sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_editBlock);
	ai.doRequest(sParms);
}


/********************************************/
/* lockblock								*/
/********************************************/
function parms_lockBlock(inCalID,inBlockID,inAvailable) {
	var sParms = "<editblock><sessionid>" + document.g_sID + "</sessionid>"
		+ "<block>"
		+ "<calendarid>" + inCalID + "</calendarid>"
		+ "<blockid>" + inBlockID + "</blockid>"
		+ "<available>" + inAvailable + "</available>"
		+ "</block>"
		+ "</editblock>";
	return sParms;
}
function ajax_lockBlock(inCalID,inBlockID,inAvailable) {
	//AJAX Call (editblock)
	inAvailable = inAvailable == true ? "1" : "0";
	var sParms = g_sXMLHeader + parms_lockBlock(inCalID,inBlockID,inAvailable);
	sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_editBlock);
	ai.doRequest(sParms);
}


/********************************************/
/* editblock								*/
/********************************************/
function parms_editBlock(inCalID,inBlockID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline,inRecurrence,inAvailable) {
	var sParms = "<editblock><sessionid>" + document.g_sID + "</sessionid>"
		+ "<block>"
		+ "<calendarid>" + inCalID + "</calendarid>"
		+ "<blockid>" + inBlockID + "</blockid>"
		+ "<title>" + inTitle + "</title>"
		+ "<description>" + inDesc + "</description>"
		+ "<userid>" + inUserID + "</userid>"
		+ "<location>" + inLocation + "</location>"
		+ "<starttime>" + formatTimeforServer(inStartDateTime) + "</starttime>"
		+ "<endtime>" + formatTimeforServer(inEndDateTime) + "</endtime>"
		+ "<slotted>" + slotted + "</slotted>"
		+ "<slotsize>" + inSlotSize + "</slotsize>"
		+ "<maxper>0</maxper>"
		+ "<maxapps>0</maxapps>"
		+ "<deadline>" + inDeadline + "</deadline>"
		+ "<date>" + formatDateforServer(inStartDateTime) + "</date>"
		+ "<recurrence>" + inRecurrence + "</recurrence>"
		+ "<available>" + inAvailable + "</available>"
		+ "</block>"
		+ "</editblock>";
	return sParms;
}
function ajax_editBlock(inCalID,inBlockID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline,inRecurrence,inAvailable) {
	//AJAX Call (editblock)
	var sParms = g_sXMLHeader + parms_editBlock(inCalID,inBlockID,inTitle,inDesc,inUserID,inLocation,inStartDateTime,inEndDateTime,inSlotSize,inMaxAppts,inDeadline,inRecurrence,inAvailable);
	sParms += g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_editBlock);
	ai.doRequest(sParms);
}
function process_editBlock(inXML) {
	//Parse response
	var arrBlockIDs = new Array();
	var elResults = parseMessage(inXML,"editblock");
	if (elResults == null) {
		errorhandle_editBlock();
		return false;
	}
	
	var xmlBlocks = elResults.getElementsByTagName('block');
	
	if (xmlBlocks != null && xmlBlocks.length > 0) {
		//Hard-coded that this is the 1st element for now.
		for (var i=1; i < elResults.childNodes.length; i++) {
			var blk = null;
			if (elResults.childNodes[i].nodeName == "block") {
				blk = elResults.childNodes[i];
			}
			var ser = null;
			if (i+1 < elResults.childNodes.length && elResults.childNodes[i+1].nodeName == "series") {
				ser = elResults.childNodes[i+1];
				i++;
			}
			var blockID = parseBlock(blk,ser);
			arrBlockIDs.push(blockID);
		}
	}
	show_editBlock(arrBlockIDs);
}
function show_editBlock(arrBlockIDs) {
	var blk = Block.GetBlockByID(arrBlockIDs[0]);
	//console.log(blk.dtStartDisplayed + "," + blk.dtEndDisplayed + "," + blk.iSlotSize + "," + blk.sState + "," + blk.iBlockID);
	var tmpTime = drawRowGroup(GetElement(document.c_sTableBodyID),new Date(blk.dtStartDisplayed.getTime()),new Date(blk.dtEndDisplayed.getTime()),blk.iSlotSize,blk.sState,blk.iBlockID);
}
function errorhandle_editBlock() {
	// no action taken
}



/* Appointments */
function parseAppt(inApptXML) {
	var iApptID = inApptXML.getElementsByTagName('appointmentid')[0].firstChild.data; //required, and only 1

	//block ID
	var	iBlockID = getValueFor(inApptXML,"blockid");
	if (iBlockID == "") iBlockID = -1;

	//dates and times
	var dtStart = new Date();
	var sStart = getValueFor(inApptXML,"date"); //in format yyyy-mm-dd
	if (sStart != "") {
		var yr = sStart.substr(0,4);
		var mo = sStart.substr(5,2);
		mo = eval(mo) - 1; //month in javascript is 1 less, Jan = 0
		var day = sStart.substr(8,2);
		dtStart = new Date(yr,mo,day,0,0,0);
	}
	var sStartTime = getValueFor(inApptXML,"starttime"); //in format hh:mm:ss
	if (sStartTime != "") {
		var hr = sStartTime.substr(0,2);
		var mn = sStartTime.substr(3,2);
		var sc = sStartTime.substr(6,2);
		dtStart.setHours(hr);
		dtStart.setMinutes(mn);
		dtStart.setSeconds(sc);
	}

	var dtEnd = new Date(dtStart.getTime());
	var sEndTime = getValueFor(inApptXML,"endtime"); //in format hh:mm:ss
	if (sEndTime != "") {
		var hr = sEndTime.substr(0,2);
		var mn = sEndTime.substr(3,2);
		var sc = sEndTime.substr(6,2);
		dtEnd.setHours(hr);
		dtEnd.setMinutes(mn);
		dtEnd.setSeconds(sc);
	}
	
	//name
	var sName = getValueFor(inApptXML,"name");
	
	//email
	var sEmail = getValueFor(inApptXML,"email");
	
	//phone
	var sPhone = getValueFor(inApptXML,"phone");
	
	//userid
	var sUserID = getValueFor(inApptXML,"userid");
	
	//purpose
	var sPurpose = getValueFor(inApptXML,"purpose");
	
	//remind?
	var isRemind = getValueFor(inApptXML,"remind");
	if (isRemind == "") isRemind = false;
	
	//available
	var isAvailable = true;
	var sAvailable = getValueFor(inApptXML,"available");
	if (sAvailable != "") {
		isAvailable = sAvailable == "0" ? false : true;
	}
	

	var blk = Block.GetBlockByID(iBlockID);
	var appt = new Appointment(iApptID,iBlockID,dtStart,dtEnd,"fillblk",sUserID,sName,sEmail,sPhone,sPurpose,isRemind,isAvailable);
	if (blk != null) blk.AddAppointment(appt);

	return iBlockID;	
}

/********************************************/
/* getappointments							*/
/********************************************/
function parms_getAppointments(inArrBlockIDs) {
	var sParms = "<getappointments><sessionid>" + document.g_sID + "</sessionid>";
	for (var i=0; i < inArrBlockIDs.length; i++) {
		sParms += "<blockid>" + inArrBlockIDs[i] + "</blockid>";
	}
	sParms += "</getappointments>";
//alert(sParms);
	return sParms;
}
function ajax_getAppointments(inArrBlockIDs) {
	//AJAX Call (getappointments)
	var sParms = g_sXMLHeader + parms_getAppointments(inArrBlockIDs) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getAppointments);
	ai.doRequest(sParms);
}
function process_getAppointments(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getappointments");
	if (elResults == null) {
		errorhandle_getAppointments();
		return false;
	}

	var xmlAppointments = elResults.getElementsByTagName('appointment'); //required
//alert(xmlAppointments.length);
	var arrBlockIDs = new Array();
	for (var i=0; i < xmlAppointments.length; i++) {
		var appt = xmlAppointments[i];
		var iBlockID = parseAppt(appt);
		//console.log( 'iBlockID = ' + iBlockID );
		arrBlockIDs.push(iBlockID);
	}

	//Reflect changes on screen
	show_getAppointments(arrBlockIDs);
}
function show_getAppointments(arrBlockIDs) {
	drawCal();
}
function errorhandle_getAppointments() {
}

/********************************************/
/* addappointment							*/
/********************************************/
function parms_addAppointment(inCalID,inBlockID,inStartDate,inStartTime,inEndTime,inUserID,inName,inEmail,inPhone,inPurpose,inAvailable) {
	var sParms = "<addappointment><sessionid>" + document.g_sID + "</sessionid>";
	sParms += "<appointment>";
	sParms += "<calendarid>" + inCalID + "</calendarid>";
	sParms += "<blockid>" + inBlockID + "</blockid>";
	sParms += "<date>" + inStartDate + "</date>";
	sParms += "<starttime>" + inStartTime + "</starttime>";
	sParms += "<endtime>" + inEndTime + "</endtime>";
	sParms += "<userid>" + inUserID + "</userid>";
	sParms += "<name>" + inName + "</name>";
	sParms += "<email>" + inEmail + "</email>";
	sParms += "<phone>" + inPhone + "</phone>";
	sParms += "<purpose>" + escape(inPurpose) + "</purpose>";
	sParms += "<available>" + inAvailable + "</available>";
	sParms += "</appointment>";
	sParms += "</addappointment>";
	return sParms;
}
function ajax_addAppointment(inCalID,inBlockID,inStartDate,inStartTime,inEndTime,inUserID,inName,inEmail,inPhone,inPurpose,inAvailable) {
	//AJAX Call (addappointment)
	var sParms = g_sXMLHeader + parms_addAppointment(inCalID,inBlockID,inStartDate,inStartTime,inEndTime,inUserID,inName,inEmail,inPhone,inPurpose,inAvailable) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_addAppointment);
	ai.doRequest(sParms);
}
function process_addAppointment(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"addappointment");
	if (elResults == null) {
		errorhandle_addAppointment();
		return false;
	}

	//Reflect changes on screen
	show_addAppointment();
}
function show_addAppointment() {
	reloadPage();
}
function errorhandle_addAppointment() {
}

/********************************************/
/* deleteappointment						*/
/********************************************/
function parms_deleteAppointment(inApptID,inCancelText) {
	var sParms = "<deleteappointment><sessionid>" + document.g_sID + "</sessionid>";
	sParms += "<appointmentid>" + inApptID + "</appointmentid>";
	sParms += "<canceltext>" + escape(inCancelText) + "</canceltext>";
	sParms += "</deleteappointment>";
	return sParms;
}
function ajax_deleteAppointment(inApptID,inCancelText) {
	//AJAX Call (deleteappointment)
	var sParms = g_sXMLHeader + parms_deleteAppointment(inApptID,inCancelText) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_deleteAppointment);
	ai.doRequest(sParms);
}
function process_deleteAppointment(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"deleteappointment");
	if (elResults == null) {
		errorhandle_deleteAppointment();
		return false;
	}

	//Reflect changes on screen
	show_deleteAppointment();
}
function show_deleteAppointment() {
	reloadPage();
}
function errorhandle_deleteAppointment() {
}


/* Users and access restrictions */
/********************************************/
/* getuserdetails							*/
/********************************************/
function parms_getUserDetails(inUserID) {
	var sParms = "<getuserdetails>";
	sParms += "<userid>" + inUserID + "</userid>";
	sParms += "</getuserdetails>";
	return sParms;
}
function ajax_getUserDetails(inUserID) {
	//AJAX Call (getuserdetails)
	var sParms = g_sXMLHeader + parms_getUserDetails(inUserID) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getUserDetails);
	ai.doRequest(sParms);
}
function process_getUserDetails(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"getuserdetails");
	if (elResults == null) {
		errorhandle_getUserDetails();
		return false;
	}
	var sName = getValueFor(elResults,'name');
	var sEmail = getValueFor(elResults,'email');
	var sPhone = getValueFor(elResults,'phone');
	var sOffice = getValueFor(elResults,'office');

	//Reflect changes into HTML
	show_getUserDetails(sName,sEmail,sPhone,sOffice);
}
function show_getUserDetails(sName,sEmail,sPhone,sOffice) {
	alert("done getUserDetails");
}
function errorhandle_getUserDetails() {
}

/********************************************/
/* validateusers							*/
/********************************************/
function parms_validateUsers(inArrUserIDs) {
	var sParms = "<validateusers>";
	for (var i=0; i < inArrUserIDs.length; i++) {
		sParms += "<user>";
		sParms += "<userid>" + inArrUserIDs[i] + "</userid>";
		sParms += "</user>";
	}
	sParms += "</validateusers>";
	return sParms;
}
function ajax_validateUsers(inArrUserIDs) {
	//AJAX Call (validateusers)
	var sParms = g_sXMLHeader + parms_validateUsers(inArrUserIDs) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_validateUsers);
	ai.doRequest(sParms);
}
function process_validateUsers(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"validateusers");
	if (elResults == null) {
		errorhandle_validateUsers();
		return false;
	}
	var sUsersValid = elResults.getElementsByTagName('user'); //required
	var arrValidUsers = new Array();
	for (var i=0; i < sUsersValid.length; i++) {
		var sUser = sUsersValid[i].getElementsByTagName('userid')[0].firstChild.data;
		var isValid = (sUsersValid[i].getElementsByTagName('valid')[0].firstChild.data == "true") ? true : false;
		if (isValid) {
			arrValidUsers.push(sUser);
		}
	}

	//Reflect changes into HTML
	show_validateUsers(arrValidUsers);
}
function show_validateUsers(arrValidUsers) {
	alert("done validateUsers");
}
function errorhandle_validateUsers() {
}

/********************************************/
/* validatecourses							*/
/********************************************/
function parms_validateCourses(inArrCourseIDs) {
	var sParms = "<validatecourses>";
	for (var i=0; i < inArrCourseIDs.length; i++) {
		sParms += "<course>";
		sParms += "<courseid>" + inArrCourseIDs[i] + "</courseid>";
		sParms += "</course>";
	}
	sParms += "</validatecourses>";
	return sParms;
}
function ajax_validateCourses(inArrCourseIDs) {
	//AJAX Call (validatecourses)
	var sParms = g_sXMLHeader + parms_validateCourses(inArrCourseIDs) + g_sXMLFooter;
//	alert(sParms);
	var ai = new AJAXInteraction(g_sURL,process_validateCourses);
	ai.doRequest(sParms);
}
function process_validateCourses(inXML) {
	//Parse response
//alert(inXML);
	var elResults  = parseMessage(inXML,"validatecourses");
//alert(elResults);
	if (elResults == null) {
		errorhandle_validateCourses();
		return false;
	}
//	alert("processing");
	var sCoursesValid = elResults.getElementsByTagName('course'); //required
//	alert(sCoursesValid);
	var arrValidCourses = new Array();
//	alert(sCoursesValid.length);
	for (var i=0; i < sCoursesValid.length; i++) {
		var sCourse = sCoursesValid[i].getElementsByTagName('courseid')[0].firstChild.data;
		var isValid = (sCoursesValid[i].getElementsByTagName('valid')[0].firstChild.data == "true") ? true : false;
		if (isValid) {
			arrValidCourses.push(sCourse);
		}
	}

	//Reflect changes into HTML
//	alert('about to show');
	show_validateCourses(arrValidCourses);
}
function show_validateCourses(arrValidCourses) {
	alert("done validateCourses");
}
function errorhandle_validateCourses() {
}


/********************************************/
/* iscalendarviewable						*/
/********************************************/
function parms_isCalendarViewable(inCalendarID) {
	var sParms = "<iscalendarviewable><calendarid>" + inCalendarID + "</calendarid></iscalendarviewable>";
	return sParms;
}
function ajax_isCalendarViewable(inCalendarID) {
	//AJAX Call (iscalendarviewable)
	var sParms = g_sXMLHeader + parms_isCalendarViewable(inCalendarID) +  g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_isCalendarViewable);
	ai.doRequest(sParms);
}
function process_isCalendarViewable(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"iscalendarviewable");
	if (elResults == null) {
		errorhandle_isCalendarViewable();
		return false;
	}

	var isAllowed = elResults.getElementsByTagName('isallowed')[0].firstChild.data; //required
	
	//Reflect changes into HTML
	show_isCalendarViewable(isAllowed);
}
function show_isCalendarViewable(isAllowed) {
	alert("done isCalViewable: " + isAllowed);
}
function errorhandle_isCalendarViewable() {
}

/********************************************/
/* isblockviewable							*/
/********************************************/
function parms_isBlockViewable(inBlockID,inUserID) {
	var sParms = "<isblockviewable><blockid>" + inBlockID + "</blockid><userid>" + inUserID + "</userid></isblockviewable>";
	return sParms;
}
function ajax_isBlockViewable(inBlockID,inUserID) {
	//AJAX Call (isblockviewable)
	var sParms = g_sXMLHeader + parms_isBlockViewable(inBlockID,inUserID) +  g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_isBlockViewable);
	ai.doRequest(sParms);
}
function process_isBlockViewable(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"isblockviewable");
	if (elResults == null) {
		errorhandle_isBlockViewable();
		return false;
	}

	var isAllowed = elResults.getElementsByTagName('isallowed')[0].firstChild.data; //required
	
	//Reflect changes into HTML
	show_isBlockViewable(isAllowed);
}
function show_isBlockViewable(isAllowed) {
	alert("done isBlockViewable: " + isAllowed);
}
function errorhandle_isBlockViewable() {
}

/********************************************/
/* isappointmentmakeable					*/
/********************************************/
function parms_isAppointmentMakeable(inBlockID,inUserID) {
	var sParms = "<isappointmentmakeable><blockid>" + inBlockID + "</blockid><userid>" + inUserID + "</userid></isappointmentmakeable>";
	return sParms;
}
function ajax_isAppointmentMakeable(inBlockID,inUserID) {
	//AJAX Call (isappointmentmakeable)
	var sParms = g_sXMLHeader + parms_isAppointmentMakeable(inBlockID,inUserID) +  g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_isAppointmentMakeable);
	ai.doRequest(sParms);
}
function process_isAppointmentMakeable(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"isappointmentmakeable");
	if (elResults == null) {
		errorhandle_isAppointmentMakeable();
		return false;
	}

	var isAllowed = elResults.getElementsByTagName('isallowed')[0].firstChild.data; //required
	
	//Reflect changes into HTML
	show_isAppointmentMakeable(isAllowed);
}
function show_isAppointmentMakeable(isAllowed) {
	alert("done isAppointmentMakeable: " + isAllowed);
}
function errorhandle_isAppointmentMakeable() {
}


/********************************************/
/* listcalendars							*/
/* - for browsing calendars by inListType	*/
/* - inListType: userid,name,title,grptitle	*/
/********************************************/
function parms_listCalendars(inListType) {
	var sParms = "<listcalendars><sessionid>" + document.g_sID + "</sessionid>";
	sParms += "<listtype>" + inListType + "</listtype>";
	sParms += "</listcalendars>";
	return sParms;
}
function ajax_listCalendars(inListType) {
	//AJAX Call (listcalendars)
	var sParms = g_sXMLHeader + parms_listCalendars(inListType) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_listCalendars);
	ai.doRequest(sParms);
}
function process_listCalendars(inXML) {
	//Parse response
	var elResults  = parseMessage(inXML,"listcalendars");
	if (elResults == null) {
		errorhandle_listCalendars();
		return false;
	}
	
	var xmlCalendars = elResults.getElementsByTagName('listvalue');
	var arrCals = new Array();
	if (xmlCalendars != null && xmlCalendars.length > 0) {
		for (var i=0; i < xmlCalendars.length; i++) {
			if (xmlCalendars[i].firstChild != undefined && xmlCalendars[i].firstChild != null)
				arrCals.push(xmlCalendars[i].firstChild.data);
		}
	}
	
	//Reflect changes on screen
	show_listCalendars(arrCals);
}
function show_listCalendars(arrCals) {
	//overwritten on browse.page.php
	alert("showing all calendars: " + arrCals);
}
function errorhandle_listCalendars() {
}


/********************************************/
/* getdidyouknow							*/
/* KDC, 1-13-2010							*/
/********************************************/
function parms_getDidYouKnow() {
	var sParms = "";
	sParms += "<getdidyouknow>";
	sParms += "<sessionid>" + document.g_sID + "</sessionid>";
	sParms += "</getdidyouknow>";
	return sParms;
}
function ajax_getDidYouKnow() {
	//AJAX Call (getdidyouknow)
	var sParms = g_sXMLHeader + parms_getDidYouKnow() + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_getDidYouKnow);
	ai.doRequest(sParms);
}
function process_getDidYouKnow(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"getdidyouknow");
	if (elResults == null) {
		errorhandle_getDidYouKnow();
		return false;
	}

	var sDYK = elResults.getElementsByTagName('didyouknow');
	var sTotalDYK = elResults.getElementsByTagName('total')[0].firstChild.data; 
	var sRemainingDYK = elResults.getElementsByTagName('remaining')[0].firstChild.data; 

	if (sDYK.length > 0) {
		var sDYKID = elResults.getElementsByTagName('didyouknowid')[0].firstChild.data; //required
		var sDYKTopics = elResults.getElementsByTagName('topics')[0].firstChild.data; //required
		var sDYKHeader = elResults.getElementsByTagName('header')[0].firstChild.data; //required
		var sDYKDetails = elResults.getElementsByTagName('details')[0].firstChild.data; //required

		//Reflect changes into HTML
		show_getDidYouKnow(sDYKID,sDYKHeader,sDYKDetails);
	}
}
var g_sDYKLink = "didyouknowdetails.page.php";
function show_getDidYouKnow(inDYKID,inDYKHeader,inDYKDetails) {
	g_sDYKLink += '?dykid=' + inDYKID;
	//The following fields must be on the pages that show the Did You Know Header and link to the details page
	GetElement("hidDYKHeader").value = inDYKHeader;
	GetElement("hidDYKDetails").value = inDYKDetails;
	
	drawDYK(g_sDYKLink);
}
function errorhandle_getDidYouKnow() {
}


/* Validate Email Address */
/********************************************/
/* isemailvalid								*/
/********************************************/
document.g_sEmailValidValue = "";
function parms_isEmailValid(inEmail) {
	var sParms = "<isemailvalid><email>" + inEmail + "</email></isemailvalid>";
	return sParms;
}
function ajax_isEmailValid(inEmail) {
	//AJAX Call (isemailvalid)
	var sParms = g_sXMLHeader + parms_isEmailValid(inEmail) + g_sXMLFooter;
	var ai = new AJAXInteraction(g_sURL,process_isEmailValid);
	ai.doRequest(sParms);
}
function process_isEmailValid(inXML) {
	//Parse response
	var elResults = parseMessage(inXML,"isemailvalid");
	if (elResults == null) {
		errorhandle_isEmailValid();
		return false;
	}

	var sIsValid = "0";
	var isValid = false;
	sIsValid = elResults.getElementsByTagName('isvalid')[0].firstChild.data; //required
	if (sIsValid == "1")
		isValid = true;
	
	//We only want to test each value once.
	document.g_sEmailValidValue = elResults.getElementsByTagName('email')[0].firstChild.data;
	
	//Reflect changes into HTML
	show_isEmailValid(isValid);
}
function show_isEmailValid(isValid) {
	showIsValidEmail(isValid);
}
function errorhandle_isEmailValid() {
}




function xmlEscapeXMLToHTML(xmlData) {
    /*************************************************************************************
    Function:       xmlEscapeXMLToHTML

    author:         xwisdom@yahoo.com

    description:
        Encodes XML data for use in a web page

    ************************************************************************************/
    var gt; 

    var str = xmlData + "";

    //replace < with «
    gt = -1;
	
    while ( str.indexOf('<', gt + 1) > -1) {
        var gt = str.indexOf('<', gt + 1);
        var newStr = str.substr(0, gt);
        newStr += "«";
        newStr = newStr + str.substr(gt + 1, str.length);
        str = newStr;
    }

    //replace > with »
    gt = -1;
    while (str.indexOf('>', gt + 1) > -1) {
        var gt = str.indexOf('>', gt + 1);
        var newStr = str.substr(0, gt);
        newStr += "»";
        newStr = newStr + str.substr(gt + 1, str.length);
        str = newStr;
    }

    //replace & with §
    gt = -1;
    while (str.indexOf('&', gt + 1) > -1) {
        var gt = str.indexOf("&", gt + 1);
        var newStr = str.substr(0, gt);
        newStr += "§";
        newStr = newStr + str.substr(gt + 1, str.length);
        str = newStr;
    }

    return str

}  // end function xmlEscapeXMLToHTML

