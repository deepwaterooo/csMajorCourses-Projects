//All inputs are strings.  Date is string formatted server date
function AppointmentHeader(inID,inDate,inStartTime,inEndTime,inApptMaker,inBlockID,inCalendarID) {
	this.appointmentid = inID;
	//**NEEDS WORK this.date
	this.date = inDate != null ? formatDateTimeFromServer(inDate) : null;
	if(jQuery.type(inStartTime) == "date") {
		this.starttime = inStartTime;
	} else { //it's a string
		if (inDate != null && inStartTime != null)
			this.starttime = formatDateTimeFromServer(inDate,inStartTime);
	}
	if(jQuery.type(inEndTime) == "date") {
		this.endtime = inEndTime;
	} else { //it's a string
		if (inDate != null && inEndTime != null)
			this.endtime = formatDateTimeFromServer(inDate,inEndTime);
	}
	this.maker = inApptMaker; //type User
	this.blockid = inBlockID;
	this.calendarid = inCalendarID;
}
AppointmentHeader.prototype.getID = function() {
	return this.appointmentid;
};
/*AppointmentHeader.prototype.setID = function(inApptID) {
	this.appointmentid = inApptID;
};*/

AppointmentHeader.prototype.getDte = function() {
		return this.date;
};

AppointmentHeader.prototype.getStartTime = function() {
	return this.starttime;
};
AppointmentHeader.prototype.setStartTime = function(inTime) {
	this.starttime = inTime;
};
	
AppointmentHeader.prototype.getEndTime = function() {
	return this.endtime;
};
AppointmentHeader.prototype.setEndTime = function(inTime) {
	this.endtime = inTime;
};
	
AppointmentHeader.prototype.getBlockID = function() {
	return this.blockid;
};
AppointmentHeader.prototype.setBlockID = function(inBlockID) {
	this.blockid = inBlockID;
};
	
AppointmentHeader.prototype.getCalendarID = function() {
	return this.calendarid;
};
AppointmentHeader.prototype.setCalendarID = function(inCalendarID) {
	this.calendarid = inCalendarID;
};
	
AppointmentHeader.prototype.getMaker = function() {
	return this.maker;
};
AppointmentHeader.prototype.setMaker = function(inMaker) {
	this.maker = inMaker;
};

AppointmentHeader.prototype.blockowner = null;
AppointmentHeader.prototype.setBlockOwner = function(inOwner) {
	this.blockowner = inOwner;
}
AppointmentHeader.prototype.getBlockOwner = function() {
	return this.blockowner;
}


Appointment.prototype = new AppointmentHeader();
Appointment.prototype.constructor = Appointment;

function Appointment(inID,inDate,inStartTime,inEndTime,inApptMaker,inBlockID,inCalendarID,inPurpose,inRemind,inTextEmail,inWhenMade,inMadeBy,inAvailable) {
	//Inherit from AppointmentHeader
	this.base = AppointmentHeader;
	this.base(inID,inDate,inStartTime,inEndTime,inApptMaker,inBlockID,inCalendarID);
 	
	this.purpose = inPurpose;
	this.remind = isTrue(inRemind);
	
	this.textemail = inTextEmail;
	
	this.whenmade = inWhenMade;		//***is this a date and time?***
	this.madeby = inMadeBy; //userid string
	
	this.available = isTrue(inAvailable);
}

Appointment.prototype.getPurpose = function() {
	return this.purpose;
};
Appointment.prototype.setPurpose = function(inPurpose) {
	this.purpose = inPurpose;
};
	
Appointment.prototype.getRemind = function() {
	return this.remind;
};
Appointment.prototype.setRemind = function(inRemind) {
	this.remind = isTrue(inRemind);
};

Appointment.prototype.getTextEmail = function() {
	return this.textemail;
};
Appointment.prototype.setTextEmail = function(inTextEmail) {
	this.textemail = inTextEmail;
};

Appointment.prototype.getWhenMade = function() {
	var str = "";
	var dts = (this.whenmade).split(" ");
	str += formatDateShort(formatDateTimeFromServer(dts[0])) + " " + dts[1];
	return str;
};
//Whenmade set by database insert.

Appointment.prototype.getMadeBy = function() {
	return this.madeby;
};
Appointment.prototype.setMadeBy = function(inMadeBy) {
	this.madeby = inMadeBy;
};

Appointment.prototype.getAvailable = function() {
	return this.available;
};
Appointment.prototype.setAvailable = function(inAvailable) {
	this.available = isTrue(inAvailable);
};

Appointment.prototype.createVarsArray = function() {
	var vars = {};
	console.log("creating vars array");
	for (var i in this) {
		console.log(i + ": " + this[i]);
		vars[i] = this[i];
	}
	console.log(vars);
	alert("STOP");
	//vars["blockid"] = inBlockID;
	
	return vars;
};