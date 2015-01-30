/*
Defines:	Slot
			BlockHeader
			Period
			AccessRestrictions
			Block
*/

function Slot(inBlockID,inDate,inStartTime,inEndTime) {
	this.blockid = inBlockID;
	this.starttime = formatDateTimeFromServer(inDate,inStartTime);
	this.endtime = formatDateTimeFromServer(inDate,inEndTime);
	this.appt = null;
}

Slot.prototype.getStartTime = function() {
	return this.starttime;
};
	
Slot.prototype.getEndTime = function() {
	return this.endtime;
};

Slot.prototype.getAppt = function() {
	return this.appt;
}
Slot.prototype.setAppt = function(inAppt) {
	this.appt = inAppt;
}



//All inputs are strings.  Date is string formatted server date
function BlockHeader(inID,inSeriesID,inTitle,inDesc,inDate,inLocation,inBlockOwner) {//,inUserID,inUserName,inUserPhone,inUserEmail,inUserOffice) {
	this.blockid = inID;
	this.seriesid = inSeriesID; //for recurring blocks
	this.title = inTitle;
	this.description = inDesc;
	this.date = formatDateTimeFromServer(inDate);
	this.location = inLocation;
	this.owner = inBlockOwner; //type User
//	this.owner = new User(inUserID,inUserName,inUserPhone,inUserEmail,inUserOffice);
	this.slots = new Array();
}

BlockHeader.prototype.getBlockID = function() {
	return this.blockid;
};

BlockHeader.prototype.getSeriesID = function() {
	return this.seriesid;
};

BlockHeader.prototype.getTitle = function() {
	return this.title;
};
	
BlockHeader.prototype.getDescription = function() {
	return this.description;
};
	
BlockHeader.prototype.getDte = function() {
	return this.date;
};
	
BlockHeader.prototype.getLocation = function() {
	return this.location;
};
	
BlockHeader.prototype.getOwner = function() {
	return this.owner;
};
	
BlockHeader.prototype.isRecurring = function() {
	return !(this.seriesid == null);
};
	
BlockHeader.prototype.addSlot = function(inSlot) {
	this.slots.push(inSlot);  //need to worry about order?
};


	
function Period(inID,inStartTime,inEndTime,inEvery,inDayOfWeek,inDayOfMonth,inWeekOfMonth) {
	this.periodid = inID;
	this.starttime = formatDateTimeFromServer('',inStartTime);
	this.endtime = formatDateTimeFromServer('',inEndTime);
	this.every = inEvery; //Recurrance. Values: once,daily,dailyweekdays,weekly,otherweekly,monthlyday,monthlyweekday
	
	//only one of the following will have data:
	this.dayofweek = inDayOfWeek; //String: monday,tuesday,wednesday,etc. (every=weekly,otherweekly)
	this.dayofmonth = inDayOfMonth; //Decimal (every=monthlyday,monthlyweekday?)
	this.weekofmonth = inWeekOfMonth; //Decimal
}



Block.prototype = new BlockHeader();
Block.prototype.constructor = Block;

function Block(inID,inSeriesID,inTitle,inDesc,inDate,inLocation,inOwner,inStartTime,inEndTime,inSlotSize,inMaxApptsPerSlot,inMaxApptsPerPerson,inPurReq,inAvailable,inEvery,inEndDate,inDayTypes,inNotifyAndRemind,inOpening,inDeadline,inCanDeadline,inAccessRestrictions) {
	//Inherit from BlockHeader
	this.base = BlockHeader;
	this.base(inID,inSeriesID,inTitle,inDesc,inDate,inLocation,inOwner);
 	
	this.starttime = formatDateTimeFromServer('',inStartTime,this.date);
	
	this.slotsize = inSlotSize;
	this.maxapptsperslot = inMaxApptsPerSlot;
	this.maxapptsperperson = inMaxApptsPerPerson;
	this.purposereq = inPurReq == "1" || inPurReq == "true" || inPurReq == true;
	this.available = inAvailable == "1" || inAvailable == "true" || inAvailable == true;
	this.every = inEvery; //Recurrance. Values: once,daily,dailyweekdays,weekly,otherweekly,monthlyday,monthlyweekday
	
	//Recurring block fields, only data if "every" is not "once"
	this.enddate = formatDateTimeFromServer(inEndDate,inEndTime);
	this.endtime = new Date(this.enddate.getTime()); //new Date(inEndTime.getTime());
	this.periods = new Array(); //array populated by "addPeriod"
	this.daytypes = inDayTypes.split(","); //array of strings. inDayTypes is comma-separated strings
	
	//Notify and Remind Manager	
	this.notifyandremind = inNotifyAndRemind; //type NotifyAndRemind
	/*this.notifyowner = inNotify == "true" || inNotify == true;
	this.remindowner = inRemind == "true" || inRemind == true;
	this.apptnotifymsg = inApptMsg;*/
		
	//value is in minutes
	this.opening = inOpening;
	this.deadline = inDeadline;
	this.candeadline = inCanDeadline;
	//this.dtOpeningTime = new Date(this.dtStart - inOpening*60000);
	
	this.accessrestrictions = inAccessRestrictions;
	//this.accessrestrictions = new AccessRestrictions(inViewAccess,inViewCList,inMakeAccess,inMakeCList,inShowAppInfo);
	//Access Restriction Users added by calling method
}
Block.prototype = new BlockHeader;

Block.prototype.getStartTime = function() {
	return this.starttime;
}
Block.prototype.setStartTime = function(inStartTime) {
	this.starttime = inStartTime;
}

Block.prototype.getSlotSize = function() {
	return this.slotsize;
}
Block.prototype.setSlotSize = function(inSlotSize) {
	this.slotsize = inSlotSize;
}

Block.prototype.getMaxApptsPerSlot = function() {
	return this.maxapptsperslot;
}
Block.prototype.setMaxApptsPerSlot = function(inMaxApptsPerSlot) {
	this.maxapptsperslot = inMaxApptsPerSlot;
}

Block.prototype.getMaxApptsPerPerson = function() {
	return this.maxapptsperperson;
}
Block.prototype.setMaxApptsPerPerson = function(inMaxApptsPerPerson) {
	this.maxapptsperperson = inMaxApptsPerPerson;
}

Block.prototype.getPurposeReq = function() {
	return this.purposereq;
}
Block.prototype.setPurposeReq = function(inPurReq) {
	this.purposereq = inPurReq == "1" || inPurReq == "true" || inPurReq == true;
}

Block.prototype.getAvailable = function() {
	return this.available;
}
Block.prototype.setAvailable = function(inAvailable) {
	this.available = inAvailable == "1" || inAvailable == "true" || inAvailable == true;
}

Block.prototype.getEvery = function() {
	return this.every;
}
Block.prototype.setEvery = function(inEvery) {
	this.every = inEvery;
}

Block.prototype.getEndDate = function() {
	return this.enddate;
}
Block.prototype.setEndDate = function(inEndDate) {
	this.enddate = formatDateTimeFromServer(inEndDate,'');
}

Block.prototype.getEndTime = function() {
	return this.endtime;
}
Block.prototype.setEndTime = function(inEndTime) {
	this.endtime = formatDateTimeFromServer('',inEndTime);
}

Block.prototype.getDayTypes = function() {
	return this.daytypes;
}
Block.prototype.setDayTypes = function(inDayTypes) {
	this.daytypes = inDayTypes.split(","); //array of strings. inDayTypes is comma-separated strings
}

Block.prototype.getNotifyAndRemind = function() {
	return this.notifyandremind;
}
Block.prototype.setNotifyAndRemind = function(inNotifyAndRemind) {
	this.notifyandremind = inNotifyAndRemind; //type NotifyAndRemind
}

Block.prototype.getOpening = function() {
	return this.opening;
}
Block.prototype.setOpening = function(inOpening) {
	this.opening = inOpening;
}

Block.prototype.getDeadline = function() {
	return this.deadline;
}
Block.prototype.setDeadline = function(inDeadline) {
	this.deadline = inDeadline;
}

Block.prototype.getCanDeadline = function() {
	return this.candeadline;
}
Block.prototype.setCanDeadline = function(inCanDeadline) {
	this.candeadline = inCanDeadline;
}

Block.prototype.getAccessRestrictions = function() {
	return this.accessrestrictions;
}
Block.prototype.setAccessRestrictions = function(inAccessRestrictions) {
	this.accessrestrictions = inAccessRestrictions;
}

Block.prototype.addPeriod = function(inPeriod) {
		this.periods.push(inPeriod);
};
