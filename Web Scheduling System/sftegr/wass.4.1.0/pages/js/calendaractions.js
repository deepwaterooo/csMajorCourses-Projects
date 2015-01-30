/*********************************/
/*  Block Actions				 */
/*********************************/

/* Click on Time to Create Block */
document.indStartBlockTime = -1;
document.indEndBlockTime = -1;

/* Click on "Add Block(s) menu item to open create block window */
function addBlock(inCalID,inStartDate,inEndDate,inStartTime,inEndTime) {
	var url = "block.page.php?cal_id=" + inCalID + "&date=" + inStartDate + "&starttime=" + inStartTime + "&endtime=" + inEndTime;
	OpenWin(url,790,740,"scrollbars=yes,resizeable=yes");
}

/* Click on Edit button to open edit block window */
function openEditBlock(inCalID,inBlockID,inRecurType,inDate,inStartTime,inEndTime,inIsFromMsg) {
	var url = "";
	url = "block.page.php?cal_id=" + inCalID + "&block_id=" + inBlockID + "&recur=" + inRecurType + "&date=" + inDate + "&starttime=" + inStartTime + "&endtime=" + inEndTime;
	var isNeedNewWin = inIsFromMsg ? true : false;
	OpenWin(url,800,780,"scrollbars=yes,resizeable=yes",null,null,isNeedNewWin);
}
function editBlock(inBlockID,inRecurType) {
	var blk = Block.GetBlockByID(inBlockID);
	var dt = formatDateforServer(blk.dtStart);
	var st = formatTimeforServer(blk.dtStart);
	var et = formatTimeforServer(blk.dtEnd);
	if (inRecurType == "once") {
		openEditBlock(document.iCalendarID,inBlockID,inRecurType,dt,st,et,false);
	} else { //inRecurType == "multiple"
		var url = "";
		url = "blockeditmsg.page.php?block_id=" + inBlockID + "&cal_id=" + document.iCalendarID + "&date=" + dt;
		OpenWin(url,480,210,"scrollbars=yes,resizeable=yes");
	}
}

/* Click on Delete button to open delete block window */
function deleteBlock(inBlockID, inNumAppts) {
	var url = "deleteblock.page.php?block_id=" + inBlockID + "&numappts=" + inNumAppts;
	OpenWin(url,550,350);
}

/* Click on Lock button to make available/unavailable */
function lockBlock(inObj,inBlockID) {
	if ( (inObj.src).indexOf('unavailable') >= 0 )
		inObj.src = 'images/available_block.gif';
	else
		inObj.src = 'images/unavailable_block.gif';
	var blk = Block.GetBlockByID(inBlockID);
	ajax_lockBlock(document.iCalendarID,inBlockID,!(blk.isAvailable));
}


/* The following methods are used for locking and unlocking appointment slots */

function deleteAppt(inApptID) {
	ajax_deleteAppointment(inApptID,"");	
}

function addAppt(inBlockID,inStartDate,inStartTime,inEndTime,inAvailable) {
	var calid = document.iCalendarID;
	var cal = WASSCalendar.GetCalendarByID(calid);
	ajax_addAppointment(calid,inBlockID,inStartDate,inStartTime,inEndTime,cal.sOwnerUserID,cal.sOwnerName,"","","",inAvailable);
}

/* Click on Lock button to make *already scheduled* appointment available/unavailable */
function lockAppt(inApptID) {
	//cancel appointment
	cancelAppt(inApptID,true);
	//The cancel appointment screen will create the unavailable "dummy" appointment
}

/* Click on Lock button to make appointment slot unavailable */
function lockApptSlot(inObj,inBlockID,inStartDate,inStartTime,inEndTime) {
	inObj.src = 'images/unavailable_block.gif';
	addAppt(inBlockID,inStartDate,inStartTime,inEndTime,0);
}

/* Click on Unlock button to make unavailable appointment available */
function unlockApptSlot(inObj,inApptID) {
	inObj.src = 'images/available_block.gif';
	//delete dummy appointment
	deleteAppt(inApptID);
}
