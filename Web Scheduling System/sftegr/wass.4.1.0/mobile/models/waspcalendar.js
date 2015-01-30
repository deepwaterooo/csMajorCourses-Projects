//All inputs are strings.  Date is string formatted server date
function WASPCalendarHeader(inID,inTitle,inDesc,inOwner) {
	this.calendarid = inID;
	this.title = inTitle;
	this.description = inDesc;
	this.owner = inOwner; //type User
}
WASPCalendarHeader.prototype.getID = function() {
	return this.calendarid;
};

WASPCalendarHeader.prototype.getTitle = function() {
	return this.title;
};
WASPCalendarHeader.prototype.setTitle = function(inTitle) {
	this.title = inTitle;
};
	
WASPCalendarHeader.prototype.getDescription = function() {
	return this.description;
};
WASPCalendarHeader.prototype.setDescription = function(inDesc) {
	this.description = inDesc;
};
	
WASPCalendarHeader.prototype.getOwner = function() {
	return this.owner;
};
WASPCalendarHeader.prototype.setOwner = function(inOwner) {
	this.owner = inOwner;
};


WASPCalendar.prototype = new WASPCalendarHeader();
WASPCalendar.prototype.constructor = WASPCalendar;

function WASPCalendar(inID,inTitle,inDesc,inOwner,inNotifyAndRemind,inOverlapOK,inAccessRestrictions,inAvailable) {
	//Inherit from WASPCalendarHeader
	this.base = WASPCalendarHeader;
	this.base(inID,inTitle,inDesc,inOwner);
 	
	this.notifyandremind = inNotifyAndRemind; //NotifyAndRemind class
	this.overlapok = inOverlapOK == "true" || inOverlapOK == true;
	this.accessrestrictions = inAccessRestrictions;	
	this.available = inAvailable == "true" || inAvailable == true;
}

WASPCalendar.prototype.getNotifyAndRemind = function() {
	return this.notifyandremind;
};
WASPCalendar.prototype.setNotifyAndRemind = function(inNotifyAndRemind) {
	this.notifyandremind = inNotifyAndRemind;
};
	
WASPCalendar.prototype.getOverlapOK = function() {
	return this.overlapok;
};
WASPCalendar.prototype.setOverlapOK = function(inOverlapOK) {
	this.overlapok = inOverlapOK == "true" || inOverlapOK == true;
};

WASPCalendar.prototype.getAccessRestrictions = function() {
	return this.accessrestrictions;
};
WASPCalendar.prototype.setAccessRestrictions = function(inAccessRestrictions) {
	this.accessrestrictions = inAccessRestrictions;
};


WASPCalendar.prototype.getAvailable = function() {
	return this.available;
};
WASPCalendar.prototype.setAvailable = function(inAvailable) {
	this.available = inAvailable == "true" || inAvailable == true;
};
