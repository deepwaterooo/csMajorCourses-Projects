var g_AJAXXMLHeader = '<?xml version="1.0"?><wass xmlns="' + g_schemaRoot + '" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xsi:schemaLocation="' + g_schemaRoot + 'wass.xsd">';
var g_AJAXXMLFooter = "</wass>";

function Controller() {
	this.blockheaders = new Array();
}

/********************************************/
/* Utilities								*/
/********************************************/

Controller.prototype.addBlockHeader = function(blk) {
	this.blockheaders.push(blk);
};

Controller.prototype.objectToArray = function(inObj) {
	var vars = {};
	for (var key in inObj) {
		if (inObj.hasOwnProperty(key) && key != "base") {
			//console.log("is this an object?" + eval(inObj[key] instanceof Object));
			if (inObj[key] instanceof Object) {
				vars[key] = this.objectToArray(inObj[key]);
			}	
			console.log(key + ": " + inObj[key]);
			vars[key] = inObj[key];
		}
	}
	console.log(vars);
	return vars;
}



/********************************************/
/* XML Builders								*/
/********************************************/

Controller.prototype.getUserXML = function(inUser) {
	var str = "<userid>" + inUser.getUserID() + "</userid>";
	str += "<name>" + inUser.getName() + "</name>";
	str += "<phone>" + inUser.getPhone() + "</phone>";
	str += "<email>" + inUser.getEmail() + "</email>";
	str += "<office>" + inUser.getOffice() + "</office>";
	return str;
}
Controller.prototype.getAppointmentXML = function(inAppt) {
	var str = "<appt>";
	var id = inAppt.getID();
	if (id != null)
		str += "<appointmentid>" + id + "</appointmentid>";

	var dt = inAppt.getDte();
	str += "<date>" + formatDateforServer(dt) + "</date>";

	var tm = inAppt.getStartTime();
	var strtm = tm;
	if (tm != null && jQuery.type(tm) == "date") strtm = formatTimeforServer(tm);
	str += "<starttime>" + strtm + "</starttime>";
	tm = inAppt.getEndTime();
	strtm = tm;
	if (tm != null && jQuery.type(tm) == "date") strtm = formatTimeforServer(tm);

	str += "<endtime>" + strtm + "</endtime>";
	str += "<apptmaker>" + this.getUserXML(inAppt.getMaker()) + "</apptmaker>";
	str += "<blockid>" + inAppt.getBlockID() + "</blockid>";
	str += "<purpose>" + inAppt.getPurpose() + "</purpose>";

	var rem = 0;
	if (inAppt.getRemind()) rem = 1;
	str += "<remind>" + rem + "</remind>";

	str += "<textemail>" + inAppt.getTextEmail() + "</textemail>";
	str += "<madeby>" + inAppt.getMadeBy() + "</madeby>";
	
	var avail = 0;
	if (inAppt.getAvailable()) avail = 1;
	str += "<available>" + avail + "</available>";
	str += "</appt>";
	return str;
}
Controller.prototype.getGetAppointmentsXML = function(inUserID,inSD,inED,inST,inET,inID,inApptBy) {
	var str = "<getappts><sessionid>" + g_sessionid + "</sessionid>";
	//str += "<userid>" + inUserID + "</userid>";
	var sd = isNullOrBlank(inSD) ? "" : formatDateforServer(inSD);
	str += "<startdate>" + sd + "</startdate>";
	var ed = isNullOrBlank(inED) ? "" : formatDateforServer(inED);
	str += "<enddate>" + ed + "</enddate>";
	var st = isNullOrBlank(inST) ? "" : formatTimeforServer(inST);
	str += "<starttime>" + st + "</starttime>";
	var et = isNullOrBlank(inET) ? "" : formatTimeforServer(inET);
	str += "<endtime>" + et + "</endtime>";
	str += "<calendarid>" + inID + "</calendarid>";
	str += "<apptby>" + inApptBy + "</apptby>";
	str += "</getappts>";
	return str;
}
Controller.prototype.getGetUserInfoXML = function(inUserID) {
	var str = "<getuserinfo><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + inUserID + "</userid>";
	str += "</getuserinfo>";
	return str;
}


Controller.prototype.showValidTextEmail = function(data) {
	
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
		
	//isemailvalid
	var isvalid = false;
	var email = "";
	if ($xml.find("isemailvalid")) {
		$xml.find("isemailvalid").each(function() {
			isvalid = ($(this).find("isvalid").text() == "1");
			email = $(this).find("email").text();
		});
	}
	apptview.showIsValidTxtEmail(isvalid,email);
}

Controller.prototype.validateEmail = function(inEmailAddr,inSuccessFunction) {
	var str = "<isemailvalid><email>" + inEmailAddr + "</email>";
	str += "</isemailvalid>";

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showValidTextEmail);
}


Controller.doErrorCheck = function($xml) {
	//error checking
//console.log("error checking");
	var errs = [];
	var err = null;
	if ($xml.find("error")) {
		$xml.find("error").each(function() {
			err = readErrorXML($(this));
			if(err != null) {
				errs.push(err);
				//alert("error! " + err.getErrCode() + ": " + err.getErrText());
			}
		});
	}
	if (errs.length > 0) Error.displayErrors(errs);
	return errs;
}

Controller.getXMLDoc = function(data) {
	var xmlDoc = data.getElementsByTagName('wass')[0];
	//var xmlDoc = $.parseXML(data);
	return $(xmlDoc);
	
}


/********************************************/
/* Global - get parameter					*/
/********************************************/
Controller.prototype.setParameters = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
		
	//getparameter
	var parm = "";
	var val = "";
	if ($xml.find("getparameter")) {
		$xml.find("getparameter").each(function() {
			parm = $(this).find("parameter").text();
			val = $(this).find("value").text();
			gParms[parm] = val;
			if (parm == "NETID") {	
				if (typeof makeapptview != 'undefined') makeapptview.setParmNetID(val);
				if (typeof myapptsview != 'undefined') myapptsview.setParmNetID(val);
			}
		});
	}
}

Controller.prototype.getParameter = function(inParam) {
	var str = "<getparameter>";
	str += "<parameter>" + inParam + "</parameter>";
	str += "</getparameter>";

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.setParameters);
}


/********************************************/
/* ApptView - page load						*/
/********************************************/

//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showApptViewData = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
		
	//getcalendars
	var calid = 0;
	var userid = "";
	var managers = [];
	var purreq = false;
	if ($xml.find("getcalendars")) {
		$xml.find("getcalendars").each(function() {
			if ($(this).find("calendarid"))
				calid = $(this).find("calendarid").text();
			if ($(this).find("userid"))
				userid = $(this).find("userid").text();
			if ($(this).find("managers"))
				managers = $(this).find("managers").text();
			if ($(this).find("purreq"))
				purreq = isTrue($(this).find("purreq").text());
		});
		apptview.loadCalendarData(calid,userid,managers,purreq);
	}

	//getblockheaderinfo
	var blk = null;
	if ($xml.find("getblockheaderinfo")) {
		$xml.find("getblockheaderinfo").each(function() {
			$(this).find("block").each(function() {
				blk = readBlockHeaderXML($(this));
			});
			$(this).find("slot").each(function() {
				slt = readSlotXML($(this));
				if (slt != null) 
					blk.addSlot(slt);
			});
		});
		if (blk != null) {
			apptview.loadBlockData(blk);
		}
	}
	
	//getuserinfo for logged in user (if no appointment loading). Will be just one.
	var usr = null;
	if ($xml.find("getuserinfo")) {
		$xml.find("getuserinfo").each(function() {
			$(this).find("userinfo").each(function() {
				usr = readUserInfoXML($(this));
			});	
		});	
	}
	if (usr != null) {
		apptview.loadLoggedInUserData(usr);
	}
	
	//getapptinfo (if view/edit appointment)
	var appt = null;
	if ($xml.find("getapptinfo")) {
		$xml.find("getapptinfo").each(function() {			
			$(this).find("appt").each(function() {			
				appt = new readApptXML($(this));
			});
		});
	}
	if (appt != null) {
		apptview.loadApptData(appt);
	}
}

//Create the XML and call AJAX for populating the apptview
Controller.prototype.loadApptViewData = function(inCalID,inBlockID,inApptID) {
	var str = "<getblockheaderinfo><sessionid>" + g_sessionid + "</sessionid>";
	str += "<blockid>" + inBlockID + "</blockid>";
	str += "</getblockheaderinfo>";
	str += "<getcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<calendarid>" + inCalID + "</calendarid>";
	str += "</getcalendars>";
//console.log(str);

	//If this is a new appointment, look up the logged in user.  Otherwise, look up the appointment
	if (isNullOrBlank(inApptID)) {
		str += this.getGetUserInfoXML(g_loggedInUserID);
	} else {
		str += "<getapptinfo><sessionid>" + g_sessionid + "</sessionid>";
		str += "<apptid>" + inApptID + "</apptid>";
		str += "</getapptinfo>";
	}

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showApptViewData);
}

//Look up user info based on entered user ID
Controller.prototype.loadUserInfo = function(inUserID) {
	var str = this.getGetUserInfoXML(inUserID);
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showApptViewData);
}


/********************************************/
/* Appointment - Add/Edit/Delete			*/
/********************************************/

//After adding or editing, and the AJAX response is returned, the user goes to my appts page
Controller.prototype.goToMyAppts = function() {
	document.location.href = "myappts.php";
}

Controller.prototype.addAppt = function(inAppt) {
	var str = "<addappt><sessionid>" + g_sessionid + "</sessionid>";
	str += this.getAppointmentXML(inAppt);
	str += "</addappt>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;	
	DoAJAX(datastring, g_ajaxURL, this.goToMyAppts);
}

Controller.prototype.editAppt = function(inAppt) {
	var str = "<editappt><sessionid>" + g_sessionid + "</sessionid>";
	str += this.getAppointmentXML(inAppt);
	str += "</editappt>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.goToMyAppts);
}

Controller.prototype.deleteAppt = function(inApptID,inCancelText) {
	var str = "<deleteappointment><sessionid>" + g_sessionid + "</sessionid>";
	str += "<appointmentid>" + inApptID + "</appointmentid>";
	str += "<canceltext>" + inCancelText + "</canceltext>";
	str += "</deleteappointment>";
console.log(str);
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;	
	DoAJAX(datastring, g_ajaxURL, this.goToMyAppts);
}

Controller.prototype.lockAppt = function(inAppt) {
		
}

Controller.prototype.syncAppt = function(inAppt) {
		
}



/********************************************/
/* MakeApptView - page load and block load	*/
/********************************************/
Controller.prototype.showBlocks = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
		
	//getblockswithslots
	var blk = null;
	if ($xml.find("getblockswithslots")) {
		$xml.find("blockwithslots").each(function() {
			$(this).find("block").each(function() {
				blk = readBlockHeaderXML($(this));
			});
			$(this).find("slot").each(function() {			
				slt = readSlotXML($(this));
				if (slt != null)
					blk.addSlot(slt);
			});
			gBlocks.push(blk);
		});
	}

	makeapptview.loadBlocks();
}

Controller.prototype.getBlocks = function(inCalID,inSD,inED) {
	var str = "<getblockswithslots><sessionid>" + g_sessionid + "</sessionid>";
	str += "<calendarid>" + inCalID + "</calendarid>";
	var sd = isNullOrBlank(inSD) ? "" : formatDateforServer(inSD);
	str += "<startdate>" + sd + "</startdate>";
//	var ed = isNullOrBlank(inED) ? "" : formatDateforServer(inED);
	var ed = new Date(inSD.getTime());
	ed.setMonth(ed.getMonth() + 2);
	str += "<enddate>" + formatDateforServer(ed) + "</enddate>";
	str += "</getblockswithslots>";

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showBlocks);
}


Controller.prototype.showMakeApptSearchResults = function(data) {
	$xml = Controller.getXMLDoc(data);

	Controller.doErrorCheck($xml);
		
	//getmatchingcalendars
	var cal = null;
	if ($xml.find("getmatchingcalendars")) {
		$xml.find("getmatchingcalendars").each(function() {			
			$(this).find("calendar").each(function() {
				cal = new readCalendarHeaderXML($(this));
				gCals.push(cal);
			});
		});
	}

	makeapptview.loadCalendars();	
}

//Create the XML and call AJAX for populating the apptview
Controller.prototype.searchCalendarsByString = function(inString) {
	var str = "<getmatchingcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<searchstring>" + inString + "</searchstring>";
	str += "</getmatchingcalendars>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showMakeApptSearchResults);
}



/********************************************/
/* MyApptsView - page load					*/
/********************************************/

//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showMyApptsViewData = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
	
	//getapptcalendars
/*	var cal = null;
	if ($xml.find("getapptcalendars")) {
		$xml.find("getapptcalendars").each(function() {			
			$(this).find("calendar").each(function() {
				cal = new readCalendarHeaderXML($(this));
				gApptCals.push(cal);
			});
		});
	}
console.log(gApptCals.length);
	if (gApptCals.length > 0) {
		myapptsview.loadCalendarList();
	}*/

	//getappts
	gAppts = []; //reset 
	var appt = null;
	if ($xml.find("getappts")) {
		$xml.find("getappts").each(function() {	
			$(this).find("apptwithblock").each(function() {			
				$(this).find("appt").each(function() {			
					appt = new readApptXML($(this));
					gAppts.push(appt);
				});
				$(this).find("block").each(function() {	
					var owner = readUserInfoXML($(this).find("blockowner"));	
					appt.setBlockOwner(owner);
				});
			});
		});
	}
	myapptsview.loadAppts();
}

//Create the XML and call AJAX for populating the apptview
Controller.prototype.loadMyApptsViewData = function() {
	//Get all appointments starting today
	var sd = new Date();
	var ed = "";
	var str = this.getGetAppointmentsXML(g_loggedInUserID,sd,ed,"","","","");
	
/*	str += "<getapptcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + g_loggedInUserID + "</userid>";
	str += "</getapptcalendars>";*/

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showMyApptsViewData);
}



/********************************************/
/* MyApptsView - submit of filter selection	*/
/********************************************/

Controller.prototype.getAppointments = function(inFilterList) {
	var sd = "";
	var ed = "";
	var st = "";
	var et = "";
	var id = "";
	var apptwith = "";
	for(var key in inFilterList) {
		var f = inFilterList[key];
		if (f != null) {
			var fld = f.getFilterField();
			var val = f.getFilterValue();
			switch(fld) {
				case "startdate": sd = val; break;
				case "starttime": st = val; break;
				case "enddate": ed = val; break;
				case "endtime": et = val; break;
				case "calendarid": id = val; break;
				case "apptwith": apptwith = val; break;
			}
		}
	}
	var str = this.getGetAppointmentsXML(g_loggedInUserID,sd,ed,st,et,id,apptwith);
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;
	DoAJAX(datastring, g_ajaxURL, this.showMyApptsViewData);
	
}



/********************************************/
/* Login									*/
/********************************************/

Controller.prototype.doGuestLogin = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	var errs = Controller.doErrorCheck($xml);
	
	if (errs.length == 0) {
		var sid = null;
		if ($xml.find("login")) {
			$xml.find("login").each(function() {
				sid = $(this).find("sessionid");
			});	
		}
		g_sessionid = sid;

		document.location.href = "makeappt.php";
	}
}

Controller.prototype.loginGuest = function(inEmailAddr) {
	var str = "<login>";
	str += "<email>" + inEmailAddr + "</email>";
	str += "</login>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.doGuestLogin);

}

Controller.prototype.loginCAS = function() {
	
}

/********************************************/
/* CalendarsView - page load				*/
/********************************************/
Controller.showManagedCals = function($xml) {
	gManagedCals = []; //reset 
	gManagedPendingCals = []; //reset
	
	//getmanagedcalendars - active and pending
//console.log("getmanagedcalendars");
	var cal = null;
	if ($xml.find("getmanagedcalendars")) {
		$xml.find("getmanagedcalendars").each(function() {
//console.log($(this).find("status").text());
			if ($(this).find("status").text() == "active") {			
				$(this).find("calendar").each(function() {
					cal = new readCalendarHeaderXML($(this));
					gManagedCals.push(cal);
				});
			}
			else if ($(this).find("status").text() == "pending") {			
				$(this).find("calendar").each(function() {
					cal = new readCalendarHeaderXML($(this));
					gManagedPendingCals.push(cal);
				});
			}

		});
	}
//console.log(gManagedCals.length);
	if (gManagedCals.length > 0) {
		calendarsview.loadManagedCalendars();
	}
	
//console.log(gManagedPendingCals.length);
	if (gManagedPendingCals.length > 0) {
		calendarsview.loadManagedPendingCalendars();
	}
}


//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showCalendarsViewData = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
	
	//getownedcalendars
//console.log("getownedcalendars");
	var cal = null;
	if ($xml.find("getownedcalendars")) {
		$xml.find("getownedcalendars").each(function() {			
			$(this).find("calendar").each(function() {
				cal = new readCalendarHeaderXML($(this));
				gOwnedCals.push(cal);
			});
		});
	}
//console.log(gOwnedCals.length);
	if (gOwnedCals.length > 0) {
		calendarsview.loadOwnedCalendars();
	}


	Controller.showManagedCals($xml);
	
	//getmembercalendars
//console.log("getmembercalendars");
	cal = null;
	if ($xml.find("getmembercalendars")) {
		$xml.find("getmembercalendars").each(function() {			
			$(this).find("calendar").each(function() {
				cal = new readCalendarHeaderXML($(this));
				gMemberCals.push(cal);
			});
		});
	}
//console.log(gMemberCals.length);
	if (gMemberCals.length > 0) {
		calendarsview.loadMemberCalendars();
	}

}

//Create the XML and call AJAX for populating the apptview
Controller.prototype.loadCalendarsViewData = function() {
	var str = "<getownedcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + g_loggedInUserID + "</userid>";
	str += "</getownedcalendars>";
	str += "<getmanagedcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + g_loggedInUserID + "</userid>";
	str += "<status>active</status>";
	str += "</getmanagedcalendars>";
	str += "<getmanagedcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + g_loggedInUserID + "</userid>";
	str += "<status>pending</status>";
	str += "</getmanagedcalendars>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.showCalendarsViewData);
	
}



Controller.prototype.showApplySearchResults = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
		
	//getmatchingcalendars
//console.log("getmatchingcalendars");
	var cal = null;
	if ($xml.find("getmatchingcalendars")) {
		$xml.find("getmatchingcalendars").each(function() {			
			$(this).find("calendar").each(function() {
				cal = new readCalendarHeaderXML($(this));
				gApplyCals.push(cal);
			});
		});
	}
//console.log(gApplyCals.length);
	if (gApplyCals.length > 0) {
		calendarsview.loadApplyCalendars();
	}
	
}

Controller.prototype.searchCalendarsByNetIDs = function(inUserIDs) {
	str = "<getmatchingcalendars><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + inUserIDs + "</userid>";
	str += "</getmatchingcalendars>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.showApplySearchResults);
}


//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showAppliedCals = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
	
	Controller.showManagedCals($xml);
	
}


Controller.prototype.applyToManage = function(inCalIDs,inEmailText) {
//console.log(inCalIDs + ":::" + inEmailText);
	str = "<applytomanagecalendar><sessionid>" + g_sessionid + "</sessionid>";
	str += "<userid>" + g_loggedInUserID + "</userid>";
	str += "<calendarid>" + inCalIDs + "</calendarid>";
	str += "<emailtext>" + inEmailText + "</emailtext>";
	str += "</applytomanagecalendar>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.showAppliedCals);
}




//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showBlocksByCalDate = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
	
		//getcalendardates
	var blk = null;
	var slt = null;
	var appt = null;
	if ($xml.find("getblocksbycalendardate")) {
		$xml.find("getblocksbycalendardate").each(function() {			
			$(this).find("blockwithslots").each(function() {
		$xml.find("block").each(function() {			
				blk = readBlockXML($(this));
				$(this).find("slotappt").each(function() {
					$xml.find("slot").each(function() {
						slt = readSlotXML($(this));
					});
					$xml.find("appt").each(function() {			
						appt = readApptXML($(this));
					});
					slt.setAppt(appt);
					blk.addSlot(slt);
				});
				gBlocks.push(blk);
			});
			});
		});
	}

	viewcalview.loadBlocksByDate();

}


Controller.prototype.getBlocksByCalDate = function(inCalID,inSD,inED) {
	var str = "<getblocksbycalendardate><sessionid>" + g_sessionid + "</sessionid>";
	str += "<calendarid>" + inCalID + "</calendarid>";
	var sd = isNullOrBlank(inSD) ? "" : formatDateforServer(inSD);
	str += "<startdate>" + sd + "</startdate>";
	var ed = isNullOrBlank(inED) ? "" : formatDateforServer(inED);
	str += "<enddate>" + ed + "</enddate>";
	str += "</getblocksbycalendardate>";

	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.showBlocksByCalDate);
	
}


//called from success AJAX.  Read the XML, load data into form and create global appt object
Controller.prototype.showViewCalViewData = function(data) {
	$xml = Controller.getXMLDoc(data);
	
	Controller.doErrorCheck($xml);
	
		//getcalendardates
//console.log("getcalendardates");
	var caldate = null;
	if ($xml.find("getcalendardates")) {
		$xml.find("getcalendardates").each(function() {			
			$(this).find("dates").each(function() {
//console.log("found a date!");
				caldate = new readCalendarDateInfoXML($(this));
				gCal.caldates.push(caldate);
			});
		});
	}
//console.log(gCal.caldates.length);

	$("#divDateScroll").append(gCal.drawCalendar());

}


//Create the XML and call AJAX for populating the viewcalview
Controller.prototype.loadViewCalViewData = function(inCalID,inStartDate,inEndDate) {
	str = "<getcalendardates><sessionid>" + g_sessionid + "</sessionid>";
	str += "<calendarid>" + inCalID + "</calendarid>";
	str += "<startdate>" + inStartDate + "</startdate>";
	str += "<enddate>" + inEndDate + "</enddate>";
	str += "</getcalendardates>";
	
	var datastring = g_AJAXXMLHeader + str + g_AJAXXMLFooter;

	DoAJAX(datastring, g_ajaxURL, this.showViewCalViewData);
}


Controller.prototype.viewCalendar = function(inCalIDs) {
	
}
	
	
var controller = new Controller();
