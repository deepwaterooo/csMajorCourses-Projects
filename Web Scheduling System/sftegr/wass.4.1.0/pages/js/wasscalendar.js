function WASSCalendar(inCalID,inOwnerUserID,inOwnerName,inTitle,inIsGroupCal,inManagerList) {
	this.iCalID = inCalID;
	this.sOwnerUserID = inOwnerUserID;
	this.sOwnerName = inOwnerName;
	this.sTitle = inTitle;
	this.isGroupCal = inIsGroupCal == 1 || inIsGroupCal == true ? true : false;
	this.sManagerList = inManagerList;
	
	this.arrManagers = new Array(); //array of user ids
	if (inManagerList != "")
		this.arrManagers = inManagerList.split(",");
}

//global (to the HTML page) array of calendars the logged in user has access to in any capacity
WASSCalendar.G_ARRCALENDARS = new Array();
//global (to the HTML page) array of calendars selected for viewing (indices into WASSCalendar.G_ARRCALENDARS)
WASSCalendar.G_ARRSELECTEDCALINDS = new Array();

WASSCalendar.GetCalendarIndexByID = function(inCalID) {
	for (var i=0; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
		if (WASSCalendar.G_ARRCALENDARS[i].iCalID == inCalID)
			return i;
	}
	return -1;
}
WASSCalendar.GetCalendarByID = function(inCalID) {
	var ind = WASSCalendar.GetCalendarIndexByID(inCalID);
	if (ind != -1)
		return WASSCalendar.G_ARRCALENDARS[ind];
	return null;
}

//Is the given user a manager of any calendar they have access to (in WASSCalendar.G_ARRCALENDARS)?
WASSCalendar.IsUserManager = function(inUserID) {
	for (var i=0; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
		for (var j=0; j < WASSCalendar.G_ARRCALENDARS[i].arrManagers.length; j++)
			if (WASSCalendar.G_ARRCALENDARS[i].arrManagers[j].toLowerCase() == inUserID.toLowerCase())
				return true;
	}
	return false;
}


//Can user add blocks for ALL selected calendars: KDC, 10-7-2009. Changed from Edit to Add for group cals.
WASSCalendar.CanUserAddBlocks = function(inUserID) {
	var canAdd = true;
	for (var i=0 && canAdd; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
		if (!WASSCalendar.G_ARRCALENDARS[i].canUserAddBlocks(inUserID,null))
			canAdd = false;
	}
	if (WASSCalendar.G_ARRCALENDARS.length == 0)
		canAdd = false;
	return canAdd;
}

//Can user edit the blocks on the selected calendar.  Calendar does not have to be in the cal array, and this assumes that the calendar array holds any calendars that the user is either an owner or manager of
//KDC, 5-17-2010. Added inBlockUserID for blocks being created at time of this check (and removed inBlockID)
WASSCalendar.CanUserEditBlocksOnThisCal = function(inUserID,inBlockUserID) {
	var cal = WASSCalendar.GetCalendarByID(GetElement("cal_id").value);
	if (cal == null) return false;
	else {
		if (cal.canUserEditBlocks(inUserID,inBlockUserID))
			return true;
	}
	return false;
}

WASSCalendar.GetNumCalendars = function() {
	return WASSCalendar.G_ARRCALENDARS.length;
}

WASSCalendar.AreAnyCalsGroup = function() {
	for (var i=0; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
		if (WASSCalendar.G_ARRCALENDARS[i].isGroupCal)
			return true;
	}
	return false;
}

//If there is only one calendar and the user is the owner of that calendar (personal calendar)
WASSCalendar.DoesUserOwnPersonalCalendar = function(inUserID) {
	for (var i=0; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
		if (WASSCalendar.G_ARRCALENDARS[i].isGroupCal == false && WASSCalendar.G_ARRCALENDARS[i].sOwnerUserID.toLowerCase() == inUserID.toLowerCase())
		return true;
	}
	return false;
}

//If there is only one calendar and the user is the owner of that calendar (personal calendar)
WASSCalendar.DoesUserOwnPersonalCalendarOnly = function(inUserID) {
	if (WASSCalendar.G_ARRCALENDARS.length == 1 && WASSCalendar.DoesUserOwnPersonalCalendar(inUserID))
		return true;
	return false;
}

//If there are more than one calendar and the user is the owner of more than one calendar (personal calendar)
WASSCalendar.DoesUserOwnMultipleCalendars = function(inUserID) {
	if (WASSCalendar.G_ARRCALENDARS.length > 1) {
		var ctr = 0;
		for (var i=0; i < WASSCalendar.G_ARRCALENDARS.length; i++) {
			if (WASSCalendar.G_ARRCALENDARS[i].sOwnerUserID.toLowerCase() == inUserID.toLowerCase())
				ctr = ctr + 1;
		}
		if (ctr > 1)
			return true;
	}
	return false;
}


//A user can edit blocks if he is either the owner of the calendar or a manager of it
//KDC, 10-7-2009. Need to differentiate between adding (for menu "Add Blocks" and editing for group calendars.  All members can add blocks, but they can only edit their own blocks.
WASSCalendar.prototype.canUserAddBlocks = function(inUserID,inBlockID) {
	if (this.sOwnerUserID.toLowerCase() == inUserID.toLowerCase() || this.isUserManager(inUserID))
		return true;
	return false;
}

//A user can edit blocks if he is either the owner of the calendar or a manager of it
//KDC, 10-7-2009. Overhaul of this method to account for group calendars/block owners.
//KDC, 5-17-2010. Added inBlockUserID for blocks being created at time of this check (and removed inBlockID)
WASSCalendar.prototype.canUserEditBlocks = function(inUserID,inBlockUserID) {
	//if user is owner of calendar, return true
	if (this.sOwnerUserID.toLowerCase() == inUserID.toLowerCase())
		return true;
	//if user is manager of calendar (and it's not a group calendar), return true
	if (this.isUserManager(inUserID) && !this.isGroupCal)
		return true;
	//if this is a group calendar, and the member is the owner of the block, return true
	//KDC, 5-17-2010. If this is being called for group calendars, the block object has not yet been created 
	// (called during creation of blocks).  Can remove below comment if no other problems arise.
/*
	var blk = null;
	if (inBlockID != undefined && inBlockID != null)
		blk = Block.GetBlockByID(inBlockID);
	if (blk != null && this.isGroupCal && blk.sUserID.toLowerCase() == inUserID.toLowerCase())
		return true;
*/
	if (this.isGroupCal && inBlockUserID.toLowerCase() == inUserID.toLowerCase()) 
		return true;
	return false;
}

WASSCalendar.prototype.isUserManager = function(inUserID) {
	for (var i=0; i < this.arrManagers.length; i++) { 
		if (this.arrManagers[i].toLowerCase() == inUserID.toLowerCase()) 
			return true;
	}
	return false;
}