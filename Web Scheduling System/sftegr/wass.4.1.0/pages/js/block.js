function Block(inBlockID,inBlockSeriesID,inCalendarID,inCalOwner,inCalTitle,inIsCalGroup,inStartTime,inEndTime,inTitle,inIsRecurring,inLocation,inSlotSize,inMaxAppts,inAvailable,inDeadline,inOpening,inArrAppts,inWhyApptNotMakeable,inDescription,inUserID,inUserName,inShowAppInfo) {
	this.iBlockID = inBlockID;
	this.iBlockSeriesID = inBlockSeriesID;
	this.iCalendarID = inCalendarID;
	this.sCalOwner = inCalOwner;
	this.sCalTitle = inCalTitle; /* KDC, 7/24/2008 */
	this.isCalGroup = inIsCalGroup; /* KDC, 10-7-2009 */

	/* KDC, 7/24/2008, for managed calendars - the user who created the block */
	this.sUserID = inUserID;
	this.sUserName = inUserName;

	this.dtStart = new Date(inStartTime.getTime());
	this.dtEnd = new Date(inEndTime.getTime());
	this.dtStartDisplayed = new Date(this.dtStart);
	this.dtEndDisplayed = new Date(this.dtEnd);

	this.sTitle = inTitle;
	this.isRecurring = inIsRecurring;
	this.sLocation = inLocation;
	this.sDescription = inDescription;
	
	this.iSlotSize = inSlotSize;
	this.isSlotted = (inSlotSize > 0);
	this.iMaxAppts = inMaxAppts;	
	this.iDeadlineMins = inDeadline;
	this.iOpeningMins = inOpening; //KDC, 2-15-2010.
	this.dtOpeningTime = new Date(this.dtStart - inOpening*60000);
	this.isAvailable = inAvailable;
	this.sState = "availblk";
	
	this.setState();
	
	//KDC,3-3-3008. Added for finding end slot, in minutes
	this.duration = Math.round((this.dtEnd.getTime() - this.dtStart.getTime()) / (1000*60));
	
	this.arrAppointments = inArrAppts;
	
	this.whyApptNotMakeable = inWhyApptNotMakeable;
	this.isShowAppInfo = inShowAppInfo;
}

Block.G_ARRBLOCKS = new Array();

//this is used for multiple calendar week view
Block.OrderBlocks = function() {
	//create an array of start dates for each calendarID, then order each array
	var arrCalIDArrays = new Array();
	var iOldCalID = "";
	var iNewCalID = "";
	for (var i=0; i < Block.G_ARRBLOCKS.length; i++) {
		iNewCalID = Block.G_ARRBLOCKS[i].iCalendarID;
		if (iNewCalID != iOldCalID) {
			arrCalIDArrays.push(new Array());
			iOldCalID = iNewCalID;
		}
		arrCalIDArrays[arrCalIDArrays.length-1].push(Block.G_ARRBLOCKS[i]);
	}
	
	//now order the blocks within each array
	for (var i=0; i < arrCalIDArrays.length; i++) {
		arrCalIDArrays[i].sort(sortblocksbydate);
		
		var str = "";
		for (var j=0; j < arrCalIDArrays[i].length; j++) {
			str += arrCalIDArrays[i][j].dtStart;
		}
	}
	
	//now reassemble!
	Block.G_ARRBLOCKS = new Array();
	for (var i=0; i < arrCalIDArrays.length; i++) {
		for (var j=0; j < arrCalIDArrays[i].length; j++) {
			Block.G_ARRBLOCKS.push(arrCalIDArrays[i][j]);
		}
	}
}

function sortblocksbydate(inBlk1,inBlk2) {
	var a = new Date(inBlk1.dtStart);
	var b = new Date(inBlk2.dtStart);
	if (a.getTime() == b.getTime()) return 0;
	if (a.getTime() < b.getTime()) return -1;
	return 1;
}

Block.GetBlockIndexByID = function(inBlockID) {
	for (var i=0; i < Block.G_ARRBLOCKS.length; i++) {
		if (Block.G_ARRBLOCKS[i].iBlockID == inBlockID)
			return i;
	}
	return -1;
}
Block.GetBlockByID = function(inBlockID) {
	var ind = Block.GetBlockIndexByID(inBlockID);
	if (ind != -1)
		return Block.G_ARRBLOCKS[ind];
	return null;
}
Block.GetBlocksByCalID = function(inCalID) {
	var arr = new Array();
	for (var i=0; i < Block.G_ARRBLOCKS.length; i++) {
		if (Block.G_ARRBLOCKS[i].iCalendarID == inCalID)
			arr.push(Block.G_ARRBLOCKS[i]);;
	}
	return arr;
}
Block.IsTimeInAnotherBlock = function(inTime,inThisBlockID) {
	for(var i=0; i < Block.G_ARRBLOCKS.length; i++) {
		var blk = Block.G_ARRBLOCKS[i];
		if (blk.iBlockID != inThisBlockID) {
			if (inTime >= blk.dtStart && inTime < blk.dtEnd) {
				return true;
			}
		}
	}
	return false;
}

Block.prototype.isApptMakeable = function() {
	//alert(this.whyApptNotMakeable);
	var isMakeable = false;
	if (this.whyApptNotMakeable == null || this.whyApptNotMakeable == "")
		isMakeable = true;
	var numavail = eval(this.iMaxAppts - this.arrAppointments.length);
	if (!this.isSlotted && this.iMaxAppts > 0 && numavail <= 0) {
		if (isUserOwner() || isUserManagerOfThisCal())
			isMakeable = true;
		else
			isMakeable = false;
	}
	return isMakeable;
}

Block.prototype.isDeadlinePassed = function() {
	//if there is no deadline, return false
	if (this.iDeadlineMins == 0) return false;
	//if current time is >= block start time - deadline
	var dtNow = new Date();
	if (dtNow.getTime() >= (this.dtStart.getTime() - (this.iDeadlineMins * 60 * 1000)))
		return true;
	return false;
}
Block.prototype.setState = function() {
	var sState = "availblk";
	//check available flag
	//KDC, 5-17-2010. Added this.sUserID argument for checking editing rights before block has been created
	if (!this.isAvailable && !WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,this.sUserID))
		sState = "nablk";
	//check deadline
	if (this.isDeadlinePassed() && !WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,this.sUserID))
		sState = "nablk";
	this.sState = sState;
}
Block.prototype.setCalOwner = function(inCalOwner) {
	this.sCalOwner = inCalOwner;
}
/*KDC, 7-24-2008*/
Block.prototype.setCalTitle = function(inCalTitle) {
	this.sCalTitle = inCalTitle;
}
/*KDC, 10-7-2009*/
Block.prototype.setIsCalGroup = function(inIsCalGroup) {
	if (inIsCalGroup == 1)
		this.isCalGroup = true;
	else
		this.isCalGroup = false;	
}
Block.prototype.AddAppointment = function(inAppt) {
	this.arrAppointments.push(inAppt);
}
Block.prototype.GetAppointmentByTime = function(inTime) {
	for (var i=0; i < this.arrAppointments.length; i++) {
		var appt = this.arrAppointments[i];
		var apptstart = new Date(appt.dtStart.getTime());
		var apptend = new Date(appt.dtEnd.getTime());
		if (apptstart <= inTime && inTime < apptend)
			return appt;
	}
	return null;
}

Block.prototype.Update = function(inStartTime,inEndTime,inTitle,inLocation,inSlotSize,inMaxAppts) {
	this.dtStart = new Date(inStartTime.getTime());
	this.dtEnd = new Date(inEndTime.getTime());

	this.sTitle = inTitle;
	this.sLocation = inLocation;
	
	this.iSlotSize = inSlotSize;
	this.isSlotted = (inSlotSize > 0);
	this.iMaxAppts = inMaxAppts;
}

Block.prototype.DrawAppointmentArea = function(inStartDate,inEndDate,inSlotSize) {
	var indFirst = getTimeSlotIndexByDate(inStartDate,this.iBlockID);
	//var indLast = getTimeSlotIndexByDate(inEndDate);
	//KDC,3-3-2008. New way of getting end slots
	var indLast = indFirst + 1;
	if (this.isSlotted)
		indLast = indFirst + this.duration/this.iSlotSize;
	if (indLast >= document.arrTimeSlots.length) { //the next row hasn't been drawn, ind is the last in the array
		indLast = document.arrTimeSlots.length;
	}
	var ctrRows = indLast - indFirst;

	var elAppt = GetElement(document.c_sApptCellPrefix+indFirst);
	if (elAppt != null) {
		elAppt.rowSpan = ctrRows;
//KDC, 2-18-2008. Will default document.iViewSlotSize to be 15 here due to overhaul
//		elAppt.height = document.iViewSlotSize/5 * document.c_i5MinTimeSlotHeight + "px";
		elAppt.height = inSlotSize/5 * document.c_i5MinTimeSlotHeight + "px";
		elAppt.vAlign = "top";
	}

	if (!this.isSlotted) {
		var sClass = "appt_availblockunslotted";
		if (!this.isAvailable)
			sClass = "appt_unavailblockunslotted";
		elAppt.className = sClass;
	}
}

/* used for unslotted only */
Block.prototype.DrawAppointments = function() {
	var ind = getTimeSlotIndexByDate(this.dtStartDisplayed,this.iBlockID);
	var elID = document.c_sApptCellPrefix + ind;
	var tdApptArea = GetElement(elID);
	
	var num = this.iMaxAppts - this.arrAppointments.length;
	if (num < 0) num = 0; //KDC,2-28-2008. Owners can make more appts than originally allocated
	var sHTML = "";
	var isDeadlinePassedAndEditor = this.isDeadlinePassed() && WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,this.sUserID);
	if (this.isAvailable && this.isApptMakeable() && (!this.isDeadlinePassed() || isDeadlinePassedAndEditor)) {
			sHTML += "<div style='margin-top:-12px;'><img src='images/make_appmt.gif' align='left' class='icon' onclick='makeAppt(\"" + this.iBlockID + "\",\"" + formatTimeforServer(this.dtStart) + "\");' title='Make New Appointment'>&nbsp;";
		if (!(!this.isSlotted && this.iMaxAppts == 0)) {
			sHTML += "<div class='blocknumavail'>" + num + "&nbsp;slots&nbsp;available - <span style='font-style:italic;'>(Click the + sign to make an appointment)</span></div></div>";
		}
		else if (!this.isSlotted && this.iMaxAppts == 0)
			sHTML += "<div class='blocknumavail'>Slots&nbsp;are&nbsp;available - <span style='font-style:italic;'>(Click the + sign to make an appointment)</span></div></div>";
	}
	if(isDeadlinePassedAndEditor) {
		sHTML += "<div class='blockdeadline'>Deadline Passed</div>";
	}
	sHTML += "<div style='height:20px;font-style:italic;vertical-align:middle;font-size:10px;'>&nbsp;</div>";
	tdApptArea.innerHTML += sHTML;
	for (var i=0; i < this.arrAppointments.length; i++) {
		var appt = this.arrAppointments[i];
		appt.Draw(tdApptArea,false);
	}
}

Block.prototype.GetScheduleOpeningDisplay = function() {
	var txt = "<div class='schedulingopeningcontainer'><img id='imgClock' src='images/icon_clock.gif' title='Schedule Opening'><div class='schedopening'>Available<br>" + GetDisplayDate(this.dtOpeningTime) + " at " + GetDisplayTimeFull(this.dtOpeningTime) + "</div></div>";
	return txt;
}

/*KDC, 5-23-2010*/
Block.prototype.GetLockBlockDisplay = function() {
	var txt = "";
	if (!this.isAvailable)
		txt += "<div class='lockblockcontainer'><img id='imgLock' src='images/available_block.gif' border='0' title='Block is locked'></div>";
	return txt;
}

Block.prototype.DrawInfoArea = function(inIsMultiCalendar) {
	//Get the element representing the first row/column of the block
	var indFirst = getTimeSlotIndexByDate(this.dtStartDisplayed,this.iBlockID);
	var indLast = indFirst + 1;
	if (this.isSlotted)
		indLast = indFirst + this.duration/this.iSlotSize;
	if (indLast >= document.arrTimeSlots.length) { //the next row hasn't been drawn, ind is the last in the array
		indLast = document.arrTimeSlots.length;
	}
	var ctrRows = indLast - indFirst;
	var elBlock = GetElement(document.c_sBlockCellPrefix+indFirst);
	
	//Get the height of the row (using time column)
	var elTime = GetElement(document.c_sTimeCellPrefix+indFirst);
	var iBlockHeight = GetHeight(elTime) * ctrRows;
	
	elBlock.rowSpan = ctrRows;
	elBlock.vAlign = "top";
	elBlock.style.height = iBlockHeight + "px"; //"100%";
	for (var i=0; i < elBlock.childNodes.length; i++) {
		elBlock.removeChild(elBlock.childNodes[i]);
	}
	
	var blkElementID = "divBlock" + this.iBlockID;

	var divNode = document.createElement("DIV");
	divNode.id = blkElementID;
	divNode.className = "blockarea";
	elBlock.appendChild(divNode);

	//make the TOP buttons
//KDC, 1-28-2009. Removed for new placement of bottom buttons (since there are no top buttons)
/*	divButtonsTop = document.createElement("DIV");
	divButtonsTop.id = blkElementID + "TopButtons";
	divButtonsTop.className = "blockbuttonstop";
	divButtonsTop.innerHTML = "";
	divNode.appendChild(divButtonsTop);
*/
	
	//make the BOTTOM buttons
	divButtonsBottom = document.createElement("DIV");
	divButtonsBottom.id = blkElementID + "BottomButtons";
	divButtonsBottom.className = "blockbuttonsbottom";
	if (WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,this.sUserID)) {
		var sHTML = "";
		
		sHTML += "<img id='imgEdit"+divNode.id+"' onclick='editBlock(" + this.iBlockID;
		if (this.isRecurring) 
			sHTML += ", \"multiple\")";
		else
			sHTML += ", \"once\")";
		sHTML += ";' src='images/edit_block.gif' border='0' class='icon' title='Edit Block'>";
		var numappts = 0;
		if (this.arrAppointments != null) numappts = this.arrAppointments.length;
		sHTML += "<img id='imgCancel"+divNode.id+"' onclick='deleteBlock(" + this.iBlockID + ", " + numappts + ");' src='images/cancel.gif' border='0' class='icon' title='Cancel Block'>";
		sHTML += "<img id='imgAvail"+divNode.id+"'";
		if (!this.isDeadlinePassed())
			sHTML += " onclick='lockBlock(this," + this.iBlockID + ");' class='iconprint'";
		else
			sHTML += " class='icondisabled'";

		if ( this.isAvailable )
			sHTML += " src='images/unavailable_block.gif' border='0' title='Block is Available for Appointments. Click to make block Unavailable'>";
		else
			sHTML += " src='images/available_block.gif' border='0' title='Block is Unavailable for Appointments. Click to make block Available'>";

		//KDC, 1-30-2008
		sHTML += "<img id='imgSyncBlock"+divNode.id+"' src='images/sync_block.gif' class='icon' onclick='icalBlock(" + this.iBlockID; 				
		if (this.isRecurring) 
			sHTML += ", \"multiple\")";
		else
			sHTML += ", \"once\")";
		sHTML += ";' title='Sync Block' border='0'>";

	//KDC, 4-23-2008
		sHTML += "<img id='imgHelpBlock"+divNode.id+"' src='images/Q1.gif' class='icon' onclick='openHelp(\"";
		if (isUserOwner())
			sHTML += "ownerblock";
		else
			sHTML += "block";
		sHTML += "\");return false;' title='Help' border='0'>";

		divButtonsBottom.innerHTML = sHTML;
	}
	divNode.appendChild(divButtonsBottom);

	//make the info area
	var divText = document.createElement("DIV");
	divText.id = blkElementID + "Text";
	divText.className = "blocktext";
	var minHeight = iBlockHeight - ((GetHeight(divButtonsBottom)) + 0);
	if (minHeight < 0) {
		//alert("min height < 0: " + minHeight);
		minHeight = 0;
	}
	//divText.style.height = minHeight + "px"; 
	//KDC, 2-27-2008. Removed above because we now want the block area to expand to show the entire description.
	divText.style.minHeight = minHeight + "px";

	var txt = "<div class='IEminheight' style='height:100%;'></div>"
		+ "<span class='blocktitle'>" + safeHTML(this.sTitle) + "</span>";
	if (this.isRecurring) txt = txt + " Recurring &nbsp;<img src='images/recur.gif'>";
	//KDC, 10-7-2009. If group calendar, display block owner
	//console.log("ISGROUP:" + this.isCalGroup);
	if (this.isCalGroup || inIsMultiCalendar) txt = txt + "<br><span class='blockmax' style='font-style:italic;'>with " + safeHTML(this.sUserName) + "</span>";
	var iNum = this.iMaxAppts;
	txt = txt + "<br><br><span class='blocklocation'>" + safeHTML(this.sLocation) + "</span>";
	//KDC,2-22-2008. Fixed bug with unslotted and no limit
	if (!(!this.isSlotted && this.iMaxAppts == 0)) {
		txt = txt + "<br><span class='blockmax'>Max ";
		if (this.isSlotted)
			txt = txt + "per person";
		else
			txt = txt + "appointments";
		txt = txt + ":&nbsp;" + this.iMaxAppts + "</span>";
	}

/*
	//KDC, 7/24/2008. For Multiple Calendars
	if (this.isCalGroup || inIsMultiCalendar) {
		txt = txt + "<br><br><span style='font-style:italic;'>with " + safeHTML(this.sUserName) + "</span> (" + safeHTML(this.sUserID) + ")";
	}
*/
	
	//KDC, 2-15-2010. For schedule openings
	var tdy = new Date();
	if (this.iOpeningMins > 0 && this.dtOpeningTime.getTime() > tdy.getTime()) {
		txt = txt + "<br><br>" + this.GetScheduleOpeningDisplay();
	}

	txt = txt + "<br><br><span class='blockmax'>" + safeHTML(this.sDescription) + "</span>";

	txt += '<div class="hotspot" onmouseover="tooltip.show(event,\''+ GetElement("blockurl").value + '&block_id=' + this.iBlockID + '\',400);" >Block URL</div>'

	divText.innerHTML = txt;
	divNode.appendChild(divText);
}


function TimePeriod(inRecurEvery,inRecurDay,inStartDate,inEndDate) {
	this.iRecurEvery = inRecurEvery; //in weeks
	this.iRecurDay = inRecurDay; //0=Sunday, etc.
	this.dtStart = new Date(inStartDate.getTime());
	this.dtEnd = new Date(inEndDate.getTime());
}

