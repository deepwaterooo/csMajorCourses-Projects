//Notification and Reminder settings
var NotifyAndRemind = function(inNotifyOwn,inNotifyMan,inNotifyMem,inRemindOwn,inRemindMan,inRemindMem,inApptMsg) {
	this.notifyown = inNotifyOwn == "true" || inNotifyOwn == true;
	this.notifyman = inNotifyMan == "true" || inNotifyMan == true;
	this.notifymem = inNotifyMem == "true" || inNotifyMem == true;
	this.remindown = inRemindOwn == "true" || inRemindOwn == true;
	this.remindman = inRemindMan == "true" || inRemindMan == true;
	this.remindmem = inRemindMem == "true" || inRemindMem == true;
	this.apptmsg = inApptMsg;
}
NotifyAndRemind.prototype.getNotifyOwn = function() {
	return this.notifyown;
};
NotifyAndRemind.prototype.setNotifyOwn = function(inNotifyOwn) {
	this.notifyown = inNotifyOwn == "true" || inNotifyOwn == true;
};
NotifyAndRemind.prototype.getNotifyMan = function() {
	return this.notifyman;
};
NotifyAndRemind.prototype.setNotifyMan = function(inNotifyMan) {
	this.notifyman = inNotifyMan == "true" || inNotifyMan == true;
};
NotifyAndRemind.prototype.getNotifyMem = function() {
	return this.notifymem;
};
NotifyAndRemind.prototype.setNotifyMem = function(inNotifyMem) {
	this.notifymem = inNotifyMem == "true" || inNotifyMem == true;
};
NotifyAndRemind.prototype.getRemindOwn = function() {
	return this.remindown;
};
NotifyAndRemind.prototype.setRemindOwn = function(inRemindOwn) {
	this.remindown = inRemindOwn == "true" || inRemindOwn == true;
};
NotifyAndRemind.prototype.getRemindMan = function() {
	return this.remindman;
};
NotifyAndRemind.prototype.setRemindMan = function(inRemindMan) {
	this.remindman = inRemindMan == "true" || inRemindMan == true;
};
NotifyAndRemind.prototype.getRemindMem = function() {
	return this.remindmem;
};
NotifyAndRemind.prototype.setRemindMem = function(inRemindMem) {
	this.remindmem = inRemindMem == "true" || inRemindMem == true;
};
NotifyAndRemind.prototype.getApptMsg = function() {
	return this.apptmsg;
};
NotifyAndRemind.prototype.setApptMsg = function(inApptMsg) {
	this.apptmsg = inApptMsg;
};




//Restrict Access to Calendars and Blocks for both individual users and courses
var AccessRestrictions = function(inViewAccess,inViewCList,inMakeAccess,inMakeCList,inShowAppInfo) {
	this.viewaccess = inViewAccess; //values: open,limited,restricted,private
	this.viewulist = new Array(); //array of users with view access. Populated with addUser
	this.viewclist = inViewCList.split(","); //array of courses with view access, inViewCList is comma-separated string.
	this.makeaccess = inMakeAccess; //values: open,limited,restricted,private
	this.makeulist = new Array(); //array of users with create appt access. Populated with addUser
	this.makeclist = inMakeCList.split(","); //array of courses with create appt access, inMakeCList is comma-separated string.
	this.showapptinfo = inShowAppInfo == "true" || inShowAppInfo == true;
}

//inAccessLevel is "view" or "make"
AccessRestrictions.prototype.addUser = function(inAccessLevel,inUser) {
		if (inAccessLevel == "view")
			this.viewulist.push(inUser);
		else if (inAccessLevel == "make")
			this.makeulist.push(inUser);
};
	
	//inAccessLevel is "view" or "make"
AccessRestrictions.prototype.addCourse = function(inAccessLevel,inStr) {
		if (inAccessLevel == "view")
			this.viewclist.push(inStr);
		else if (inAccesLevel == "make")
			this.makeclist.push(inStr);
};




function Error(inErrCode,inErrText) {
	this.errorcode = inErrCode;
	this.errortext = inErrText;
}

Error.prototype.getErrCode = function() {
		return this.errorcode;
};
Error.prototype.setErrCode = function(inErrCode) {
		this.errorcode = inErrCode;
};

Error.prototype.getErrText = function() {
		return this.errortext;
};
Error.prototype.setErrText = function(inErrText) {
		this.errortext = inErrText;
};

Error.prototype.display = function() {
	var str = this.errortext;
	if (!isNullOrBlank(this.errorcode)) str += " (" + this.errorcode + ")";
	$("#divMessage").append(str);
}
Error.displayErrors = function(inErrs) {
	for (var i=0; i < inErrs.length; i++) {
		inErrs[i].display();	
	}
	$("#divMessage").addClass("error");
	Message.display();
}


function Message(inText) {
}
Message.setConfirm = function(inText) {
	$("#divMessage").append(inText);
	$("#divMessage").addClass("confirm");
}
Message.display = function() {
	var strclose = '<a href="#" onclick="Message.erase();">close message</a>';
	$("#divMessage").append(strclose);
	$("#divMessage").show();
	window.scrollTo(0,0);
}
Message.erase = function() {
	$("#divMessage").empty();
	$("#divMessage").removeClass().addClass("message");
	$("#divMessage").hide();
}

