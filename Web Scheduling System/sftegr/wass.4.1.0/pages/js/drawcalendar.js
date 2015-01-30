/* JavaScript file for Drawing the Main Calendar */

/***********************/
/* Constants           */
/***********************/
document.c_i5MinTimeSlotHeight = 18; /* in px */

document.c_sTableBodyID = "tblBody";
document.c_sBlockCellPrefix = "tdBlock";
document.c_sTimeCellPrefix = "tdTime";
document.c_sApptCellPrefix = "tdAppt";

/***********************/
/* TimeSlot class      */
/***********************/
document.arrTimeSlots = new Array();
function TimeSlot(inBlockID, inTime) {
	this.iBlockID = inBlockID;
	this.dtTime = new Date(inTime.getTime());
}
function getEndTimeIndexByBlockID(inStartTimeIndex,inBlockID) {
	//note that inBlockID could be null
	for (var i=inStartTimeIndex; i < document.arrTimeSlots.length; i++) {
		if (document.arrTimeSlots[i].iBlockID != inBlockID) return (i-1);
	}
	return document.arrTimeSlots.length-1;
}
//KDC, 2-18-2008. Changing for day view overhaul
//KDC, 7-24-2008. Updated to take blockID too, for group calendars (overlapping blocks)
function getTimeSlotIndexByDate(inDate,inBlockID) {
	for (var i=0; i < document.arrTimeSlots.length; i++) {
		var iID = document.arrTimeSlots[i].iBlockID;
		var dtTS = document.arrTimeSlots[i].dtTime;
		//KDC, 7-24-2008. Check for Block ID, too.
		//compare everything but seconds
		if (iID == inBlockID && dtTS.getFullYear() == inDate.getFullYear() && dtTS.getMonth() == inDate.getMonth() && dtTS.getDate() == inDate.getDate() && dtTS.getHours() == inDate.getHours() && dtTS.getMinutes() == inDate.getMinutes())
			return i;
	}
	return -1;
}
function getTimeSlotByDate(inDate,inBlockID) {
	var ind = getTimeSlotIndexByDate(inDate,inBlockID);
	if (ind == -1) return null;
	else return document.arrTimeSlots[ind];
}
function printTimeSlots() {
	var msg = "";
	for (var i=0; i < document.arrTimeSlots.length; i++) {
		msg += (i + ": " + document.arrTimeSlots[i].iBlockID + "," + document.arrTimeSlots[i].dtTime + "\n");
	}
	alert(msg);
}


/***********************/
/* Calendar Drawing    */
/***********************/
function drawCalendar(inViewStartDateTime,inViewEndDateTime,inParent) {
	document.arrTimeSlots = new Array();
	if (document.iViewSlotSize == "month") {
		var stdt = new Date(inViewStartDateTime.getTime());
//		alert(stdt);
		stdt.setDate(1);	
		drawMonthViewCalendar(stdt,inViewEndDateTime,"month",inParent);
	} else if (document.iViewSlotSize == "week") {
		var stdt = calendar.getWeekStart(inViewStartDateTime);	
		drawMonthViewCalendar(stdt,inViewEndDateTime,"week",inParent);
	} else
		drawDayViewCalendar(inViewStartDateTime,inViewEndDateTime,inParent);
}

function drawMonthViewCalendar(inViewStartDate,inViewEndDate,inCalType,inParent) {
	var firstmonth = new Date(inViewStartDate.getTime());
	firstmonth.setDate(1);
	var id = document.c_sMonthCalTableID;

	var calObj = new calendar(id,firstmonth.getMonth(),firstmonth.getFullYear(),document.iViewSlotSize,inViewStartDate,inViewEndDate,document.c_sMainCalContainerDivID,false,3,false);
	calObj.writeCalendar();
	//KDC, 3-28-2012. Remove loading message.
	GetElement("divLoadMsg").style.display = "none";
	
	
	//put all day types in (and TODAY)
	var ctr = 0;
	for (var i=calObj.datebegin; i <= calObj.dateend; i++) {
		//check for a week that spans multiple months
		var mo = calObj.month;
		var yr = calObj.year;
		var dt = i;
		if (i > calObj.length) {
			dt = i - calObj.length;
			mo = calObj.month + 1;
			if (mo == 12) {
				mo = 0;
				yr = calObj.year + 1;
			}
		}
		var id = calObj.id + "_" + dt;
		var elTD = GetElement(id);
		if (elTD != null) {
			elTD.onmousedown = function() { return false; };
			var elDivMain = elTD.getElementsByTagName("div")[0];
			var elDivFooter = elDivMain.getElementsByTagName("div")[2];
			elDivFooter.innerHTML = document.arrDayTypes[ctr]; //"Teaching";
			
			var dt = new Date(yr,mo,dt,0,0,0);
			var today = new Date();
			if (dt.getFullYear() == today.getFullYear() && dt.getMonth() == today.getMonth() && dt.getDate() == today.getDate()) {
				var elDivText = elDivMain.getElementsByTagName("div")[0];
				elDivText.innerHTML = elDivText.innerHTML + "<span class='today'>TODAY</span>";
			}
		}
		ctr++;
	}
	
	//loop over all blocks now - **assume blocks are in order of calendarIDs, by date**!
	var tdy = new Date();
	var oldCalID = "";
	var newCalID = "";
	var oldDt = new Date(0,0,0,0,0,0);
	var newDt = new Date(0,0,0,0,0,0);
	if (document.isMultiCalendar) Block.OrderBlocks();	
	for (var i=0; i < Block.G_ARRBLOCKS.length; i++) {
		var blk = Block.G_ARRBLOCKS[i];
		var txt = "";
		
		if (document.isMultiCalendar) {
			//get the calendar id and start date
			newCalID = blk.iCalendarID;
			newDt = new Date(blk.dtStart);
			newDt.setHours(0);
			newDt.setMinutes(0);
			newDt.setSeconds(0);
			if (newCalID != oldCalID || newDt.getTime() > oldDt.getTime()) {
				txt += "<div style='height:10px;'>&nbsp;</div>";
				txt += blk.sCalOwner + "<br>";
				oldCalID = newCalID;
				oldDt = newDt;
			}
		}


		//Get the TD id
		var end = new Date(blk.dtEnd.getFullYear(),blk.dtEnd.getMonth(),blk.dtEnd.getDate(),document.iDefaultEndHour,document.iDefaultEndMinutes,document.iDefaultEndSeconds);
		var numAppts = blk.arrAppointments.length;
		txt += '<div class="monthblock">';

		txt += '<div style="margin-bottom:-10px;padding-bottom:-10px;">';
		//KDC, 5-23-2010. Show lock icon if block is locked
		txt += blk.GetLockBlockDisplay();

		txt += '<a href="#" class="monthblock" onclick="openDayFromMonth(' + blk.iCalendarID + ',\'' + escapeSingle(blk.sCalOwner) + '\',\'' + escapeSingle(safeHTML(blk.sCalTitle)) + '\',new Date(' + blk.dtStart.getTime() + '),new Date(' + end.getTime() + '));return false;">' + GetDisplayTimeFull(blk.dtStart) + ' - ' + GetDisplayTimeFull(blk.dtEnd) + '</a>';
		txt += '</div>';

		//KDC, 6-23-2009. Show block title only if in week view
		if (inCalType == "week") {
			//KDC, 1-28-2009. Show block title.
			txt += "<br><span class='weekBlockTitle'>" + blk.sTitle + "</span>";
		}
		//KDC, 1-13-2010. Show block title in month view, only 14 chars
		if (inCalType == "month") {
			txt += "<br><span class='weekBlockTitle'>" + (blk.sTitle).substr(0,15) + "</span>";
		}
		
		//KDC, 2-18-2010. For group calendars, display who the block owner is
		txt += "<br><span class='weekBlockOwner'>with " + safeHTML(blk.sUserName) + "</span>";

		//KDC, 2-15-2010. Do not display appointment info for schedule openings (that have not already passed).  Just schedule opening info.

		if (blk.iOpeningMins > 0 && blk.dtOpeningTime.getTime() > tdy.getTime()) {
			txt += blk.GetScheduleOpeningDisplay();
		}
		else {			
			//KDC, 6-23-2009. Show appointment stats for month only. (used to see this for week only)
			if (inCalType == "month") {
				txt += "<br>" + numAppts + " Appointment";
				if (numAppts != 1) txt += "s";
				if (blk.isSlotted) {
					//KDC, 3-9-2010. People who make multiple consecutive appointments really only have "one appointment".  Need to account for slot sizes when subtracting for num available.
					var numSlotsTaken = 0;
					for (var k=0; k < blk.arrAppointments.length; k++) {
						numSlotsTaken += (blk.arrAppointments[k].dtEnd.getTime() - blk.arrAppointments[k].dtStart.getTime()) / 1000 / 60 / blk.iSlotSize;
					}
					var numLeft = ((blk.dtEnd.getTime() - blk.dtStart.getTime()) / 1000 / 60 / blk.iSlotSize) - numSlotsTaken;
					if (numLeft < 0) numLeft = 0; //KDC,2-28-2008. This should never be the case
					txt += "<br>" + numLeft + " Available";
				}
				//KDC,2-22-2008. If block is unslotted and has appointment limit, show # left
				if (!blk.isSlotted && blk.iMaxAppts > 0) {
					var numLeft = blk.iMaxAppts - numAppts;
					if (numLeft < 0) numLeft = 0; //KDC,2-28-2008. This will be needed because profs can make more than the available slots for unslotted blocks
					txt += "<br>" + numLeft + " Available";
				}
			}
			//KDC, 6-23-2009.  If this is a week calendar, show the appointments
			if (inCalType == "week") {
				//KDC, 2-24-2009. Show appointment list on week view
				//alert(isUserOwner() + "," + isUserManagerOfThisCal());
				if ((isUserOwner() || isUserManagerOfThisCal()) && blk.arrAppointments.length > 0) {
					txt += "<br>";
					for (var a=0; a < blk.arrAppointments.length; a++) {
						txt += "<div style='margin:0px;padding:0px 5px 0px 5px;text-align:left;font-size:9px;'>*" + blk.arrAppointments[a].sName;
						if (blk.isSlotted) 
							txt += "&nbsp;(" + GetDisplayTimeFull(blk.arrAppointments[a].dtStart) + " - " + GetDisplayTimeFull(blk.arrAppointments[a].dtEnd) + ")";
						txt += "</div>";	
					}
				}
			}
		}
		
		txt += "</div>";
		var id = calObj.id + "_" + blk.dtStart.getDate();
		var elTD = GetElement(id);
		if (elTD != null) {
			//check to see if the user is the owner or manager of this calendar
			var isownermgr = false;
			if (isUserOwner() || isUserManagerOfThisCal())
				isownermgr = true;
			//check the date status for this day
			//change the class of the element based on the date status
			//get the right month
			var indCal = 0;
			if (blk.dtStart.getMonth() > document.arr_CalShown[0].month) indCal = 1;

			switch(document.sCals_datestatus[indCal][blk.dtStart.getDate()]) {
				case "noblocks":
					//elTD.className = "monthday";
					break;
				case "blocksnoappsnoslots":
					if (isownermgr)
						elTD.className = "monthday_availblock";
					else
						elTD.className = "monthday_unavailblock";
					break;
				case "blocksnoappsslots":
					//KDC, 2-15-2010. schedule openings should show as unavailable
					if (!isownermgr && blk.iOpeningMins > 0 && blk.dtOpeningTime.getTime() > tdy.getTime())
						elTD.className = "monthday_unavailblock";
					else
						elTD.className = "monthday_availblock";
					break;
				case "blocksappsnoslots":
					if (isownermgr)
						elTD.className = "monthday_apptblock";
					else
						elTD.className = "monthday_unavailblock";
					break;
				case "blocksappsslots":
					if (isownermgr)
						elTD.className = "monthday_apptblock";
					else if (!isownermgr && blk.iOpeningMins > 0 && blk.dtOpeningTime.getTime() > tdy.getTime()) {
						//KDC, 2-15-2010. schedule openings should show as unavailable
						elTD.className = "monthday_unavailblock";
					}
					else
						elTD.className = "monthday_availblock";
					break;
				case "blocksmyappsslots":
					if (isownermgr)
						elTD.className = "monthday_apptblock";
					else
						elTD.className = "monthday_myapptblock";
					break;
				case "blocksmyappsnoslots":
					if (isownermgr)
						elTD.className = "monthday_apptblock";
					else
						elTD.className = "monthday_myapptblock";
					break;
			}
			//KDC, 5-25-2010. If block is locked (available =0), show unavailable class
			/*if (blk != null && !blk.isAvailable && !isownermgr)
				elTD.className = "monthday_unavailblock";*/
				
			var elDivMain = elTD.getElementsByTagName("div")[0];
			var elDivText = elDivMain.getElementsByTagName("div")[1];
			elDivText.innerHTML += txt;
		}
	}
	
}

function getDisplayedStartDate(inCalType,inViewStartDate) {
	var iSelStartDate = inCalType == "month" ? 0 : inViewStartDate.getDate() - 1;
	return iSelStartDate;
}
function getDisplayedEndDate(inCalType,inSelectedStartDate) {
	var iSelEndDate = inCalType == "month" ? calendar.getNumDaysInMonth(inSelectedStartDate.getMonth()+1,inSelectedStartDate.getFullYear()) : eval(inSelectedStartDate + 7);
	return iSelEndDate;
}
//KDC, 2-18-2008. Complete rewrite due to day view overhaul
function drawDayViewCalendar(inViewStartTime,inViewEndTime,inParent) {
	//Set up the table
	var par = GetElement(inParent);
	var tblNode = document.createElement("TABLE");
	tblNode.id = document.c_sDayCalTableID;
	tblNode.cellSpacing = "0";
	tblNode.cellPadding = "0";
	tblNode.border = "0";
	par.appendChild(tblNode);
	
	var tblBody = document.createElement("TBODY");
	tblBody.id = document.c_sTableBodyID;
	tblNode.appendChild(tblBody);
	
	//KDC, 2-18-2008. If there are no blocks, display a message
	if (Block.G_ARRBLOCKS.length == 0) {
		//Draw header row
		var trHeaderRow = document.createElement("TR");
		tblBody.appendChild(trHeaderRow);

		var infmsg = "No appointments available for this day.";
		if (isUserManagerOfThisCal() || isUserOwner())
			infmsg += "  Click Add Block to add a block of available time.";
		var sHTML = '<div id="confirm' + document.g_iNumConfirmMsg + '" class="confirm" style="margin-top:5px;margin-left:5px;">' + infmsg + '<br><a href="#" onclick="closeMessage(\'confirm' + document.g_iNumConfirmMsg + '\');return false;">close message</a></div>';
		document.g_iNumConfirmMsg++;
		var td = document.createElement("TD");
		td.colspan = 3;
		td.innerHTML = sHTML;
		trHeaderRow.appendChild(td);
	} else {
		

		//Loop over time slots and draw each row group (and empty rows)
		var tmpTime = new Date(inViewStartTime.getTime());
			for(var i=0; i < Block.G_ARRBLOCKS.length; i++) {
				//KDC, 4-20-2011. If a block_id was passed in the URL, display only that block 
				//(id is in hidden input on viewcalendar.page.php)
				var blkid = 0;
				if (GetElement("block_id") != null) blkid = GetElement("block_id").value;
				
				var blk = Block.G_ARRBLOCKS[i];
				
				//If no block_id passed in, draw the block.  If a block_id was passed in, and this is it, draw the block.
				if (blkid == 0 || blk.iBlockID == blkid) {
		
				//KDC, 3-7-2008. Moved header here so that one appears for each block
				var txt = "";
				var trHeaderRow = document.createElement("TR");
				tblBody.appendChild(trHeaderRow);

				var tdHeaderBlock = document.createElement("TD");
				tdHeaderBlock.className = "blockheader";
				tdHeaderBlock.innerHTML = "Block";
				trHeaderRow.appendChild(tdHeaderBlock);
			
				var tdHeaderTime = document.createElement("TD");
				tdHeaderTime.className = "timeheader";
				if (blk.isSlotted) txt = "Time";
				else txt = "Time-Range";
				tdHeaderTime.innerHTML = txt;
				trHeaderRow.appendChild(tdHeaderTime);
			
				var tdHeaderAppts = document.createElement("TD");
				tdHeaderAppts.className = "apptheader";
				if (blk.isSlotted) txt = "Appointment Slots";
				else txt = "Appointments";
				tdHeaderAppts.innerHTML = txt;
				trHeaderRow.appendChild(tdHeaderAppts);
	

				var slotsize = blk.iSlotSize;
				if (slotsize == 0) {
					slotsize = eval((blk.dtEnd.getTime() - blk.dtStart.getTime())/60/1000); //KDC, 2-19-2008. For unslotted blocks
				}
				tmpTime = drawRowGroup(tblBody,blk.dtStartDisplayed,blk.dtEndDisplayed,slotsize,blk.sState,blk.iBlockID);
				//Draw a space between blocks
				drawRow(tblBody,null,"noblk",-1,false,false,null,null,slotsize);
				
				}
			}			
	}
}

/* inState: noblk = no block
			startblk = there is no block, but one has been started by clicking on the "add"
			blk = there is a block, not sure what type yet.
*/
/* inBlockID is optional */
function drawRowGroup(inParent,inStartTime,inEndTime,inSlotSize,inState,inBlockID) {
	var sState = inState;
	var isBlock = inState == "blk" || inState == "nablk" || inState == "availblk" || inState == "fillblk" ? true : false;
	if (inBlockID == undefined || inBlockID == null) inBlockID = null;
	
	// for new blocks
	var blk = null;
	if (isBlock) {
		//look up block information using inBlockID
		blk = Block.GetBlockByID(inBlockID);
		//set the appropriate state
		if (inState == "blk") sState = "availblk";
		if (inSlotSize == 0)
			inSlotSize = eval((inEndTime.getTime() - inStartTime.getTime())/60/1000); //KDC, 2-19-2008. For unslotted blocks //KDC, 3-4-2008. Moved here instead of in drawDayViewCalendar
	}
	
	//set up counter for creating the block rowspan, if necessary
	var ctrRows = 0;
	
	//for drawing appointments that span multiple timeslots
	var apptStartTime = null;
	var isDrawApptArea = false;
	var isApptAreaStarted = false;

	//loop over time slots
	var tmpTime = new Date(inStartTime.getFullYear(),inStartTime.getMonth(),inStartTime.getDate(),inStartTime.getHours(),inStartTime.getMinutes(),"30");
	
	
	if (blk != null && blk.isSlotted) var nextslottime = new Date(tmpTime.getTime());
	
	
	while (tmpTime.getTime() < inEndTime.getTime()) {
		//alert("looping: " + tmpTime);
		var tm = new Date(tmpTime.getTime());
		var blkID = blk != null ? blk.iBlockID : -1;
		var ind = getTimeSlotIndexByDate(tm,blkID);
		var oldTime = new Date(tmpTime.getTime());
		if (ind == -1) {  //no time slot for this time exists yet
			document.arrTimeSlots.push(new TimeSlot(inBlockID,new Date(tmpTime.getTime())));
			ind = document.arrTimeSlots.length - 1;
		} else {
			document.arrTimeSlots[ind].iBlockID = inBlockID;
		}

		//only draw the block column if this isn't a block, or it is a block and it's the first row.  All others will be rowspan.
		var isDrawBlockCol = true;
		if (isBlock && ctrRows > 0) isDrawBlockCol = false;
		
		//Get appointment info
		var isDrawApptCol = true;
		var appt = null;
		if (isBlock && blk != null) {
			//slotted, get appt by time
			if (blk.isSlotted) {
				appt = blk.GetAppointmentByTime(new Date(tmpTime.getTime()));
				
				//spans multiple time slots - keep track of start, middle, and end to know what to draw.
				var nextTime = new Date(tmpTime.getTime() + (inSlotSize * 60 * 1000));

				//if we're at the start of a block slot
				var isStartOfAppt = false;
				if (tmpTime.getTime() == nextslottime.getTime()) {
					isApptAreaStarted = true;
					isDrawApptCol = true;
					apptStartTime = new Date(tmpTime.getTime());
					isStartOfAppt = true;
					nextslottime = new Date(nextslottime.getTime() + inSlotSize * 60 * 1000);
				} else if (isApptAreaStarted) { //we're in the middle of a block slot
					isDrawApptCol = false;
					isStartOfAppt = false;
				}
				if (nextTime.getTime() == nextslottime.getTime()) { //we're at the end of a block slot
					//if this is also the first time, don't draw an area
					if (isStartOfAppt) {
						isDrawApptArea = false;
						isApptAreaStarted = false;
						isDrawApptCol = true;
					} else {
						isDrawApptArea = true;
						isApptAreaStarted = false;
						isDrawApptCol = false;
					}
					isStartOfAppt = false;
				}
				
				
			}
			
			//unslotted
			if (ctrRows > 0 && !blk.isSlotted) isDrawApptCol = false;
		}

		//Draw the row for this time
		drawRow(inParent,new Date(tmpTime.getTime()),sState,ind,isDrawBlockCol,isDrawApptCol,blk,appt,inSlotSize);
		
		//increment time and counters
		tmpTime.setTime(tmpTime.getTime() + (inSlotSize * 60 * 1000));
		ctrRows++;

		//If we need an appointment area for this row (which will only happen for slotted), draw it
		if (isDrawApptArea) {
			blk.DrawAppointmentArea(apptStartTime,new Date(tmpTime.getTime()),inSlotSize);
			isDrawApptArea = false;
			apptStartTime = null;
		}

		// Need because somehow the array gets overwritten
		document.arrTimeSlots[ind].dtTime = oldTime;
	}
	
	
	//if isBlock, draw overlay with Block Info and buttons
	if (isBlock) {
		blk.DrawInfoArea(document.isMultiCalendar);
		if (!blk.isSlotted) {
			blk.DrawAppointmentArea(blk.dtStartDisplayed,blk.dtEndDisplayed,inSlotSize);
			blk.DrawAppointments();
		}
	}
	return tmpTime;
}

function drawRow(inParent,tmpTime,inState,inTimeSlotIndex,inIsDrawBlockCol,inIsDrawApptCol,inBlockObj,inApptObj,inSlotSize) {
	var isBlankRow = false;
	if (tmpTime == null) {
		isBlankRow = true;
		inSlotSize = document.iDefaultSlotSize;
	}

	var trID = "tr";
	if (!isBlankRow) trID += inBlockObj.iBlockID + GetStringTime(tmpTime);
	var trRow = null;

	var ind = inTimeSlotIndex; 
	var tdBlockID = document.c_sBlockCellPrefix + ind;
	var tdTimeID = document.c_sTimeCellPrefix + ind;
	var tdApptID = document.c_sApptCellPrefix + ind;
	
	trRow = GetElement(trID);
	var tdBlock = null;
	var tdTime = null;
	var tdAppt = null;
	
	//check for existence of this ID
	if (trRow == null || trID == "tr") {
		//no ID exists, create all new TR and TDs
		trRow = document.createElement("TR");
		trRow.id = trID;
		inParent.appendChild(trRow);
		
		//accommodate rows separating blocks
		if (isBlankRow) {
			tdBlock = document.createElement("TD");
			tdBlock.innerHTML = "&nbsp;";
			tdBlock.colspan = 3;
			tdBlock.height = inSlotSize/5*document.c_i5MinTimeSlotHeight + "px"; 
			trRow.appendChild(tdBlock);
		}

		if (inIsDrawBlockCol) {
			tdBlock = document.createElement("TD");
			tdBlock.id = tdBlockID;
			tdBlock.className = "blockempty";
			if (new Date(tmpTime.getTime() + (inSlotSize * 60 * 1000)).getTime() >= document.dtViewEndTime.getTime()) {
				tdBlock.style.borderBottom = "1px solid #000000";
			}
			tdBlock.innerHTML = "&nbsp;";
			trRow.appendChild(tdBlock);
		}
	
		tdTime = document.createElement("TD");
		tdTime.id = tdTimeID;
		tdTime.className = "timeempty";
		tdTime.innerHTML = "&nbsp;";
		trRow.appendChild(tdTime);
		
		if (inIsDrawApptCol) {
			tdAppt = document.createElement("TD");
			tdAppt.id = tdApptID;
			tdAppt.className = "apptempty";
			tdAppt.innerHTML = "&nbsp;";
			trRow.appendChild(tdAppt);
		}
	} else {
		//check that the block column is there (span for block)
		tdBlock = GetElement(tdBlockID);
		//only draw the block if we should, and one doesn't exist
		if (inIsDrawBlockCol && tdBlock == null) {
			tdBlock = document.createElement("TD");
			tdBlock.id = tdBlockID;
			tdBlock.className = "blockempty";
			//check for last row
			if (new Date(tmpTime.getTime() + (inBlockObj.iSlotSize * 60 * 1000)).getTime() >= document.dtViewEndTime.getTime()) {
				tdBlock.style.borderBottom = "1px solid #000000";
			}
			tdBlock.innerHTML = "&nbsp;";
			trRow.insertChild(tdBlock,0);
		}
		//if a col DOES exist, but we don't want one, remove it.
		if (!inIsDrawBlockCol && tdBlock != null) {
			var par = GetParent(tdBlock);
			par.removeChild(tdBlock);
		}
		
		//assume the block, time, appt cols have already been created
		tdTime = GetElement(tdTimeID);
		
		//only draw the appt if we should, and one doesn't exist
		tdAppt = GetElement(tdApptID);
		if (inIsDrawApptCol && tdAppt == null) {
			tdAppt = document.createElement("TD");
			tdAppt.id = tdApptID;
			tdAppt.className = "apptempty";
			tdAppt.innerHTML = "&nbsp;";
			trRow.appendChild(tdAppt);
		}
		//if an appt DOES exist, but we don't want one, remove it.
		if (!inIsDrawApptCol && tdAppt != null) {
			var par = GetParent(tdAppt);
			par.removeChild(tdAppt);
		}

	}
	
	var blockstate = inState;
	var timestate = inState;
	var apptstate = inState;
	
	if (inApptObj != null) {
		blockstate = "fillblk";
		timestate = "fillblk";
		apptstate = "fillblk";
		if (inApptObj.isAvailable == false) {
			timestate = "nablk";
			apptstate = "nablk";
		}
	}
	
	if (inIsDrawBlockCol)
		drawBlockCol(tdBlock,blockstate,inSlotSize,inBlockObj);

	if (!isBlankRow) drawTime(tdTime,tmpTime,timestate,inSlotSize,inBlockObj);

	if (inIsDrawApptCol)
		drawAppointmentCol(tdAppt,apptstate,inBlockObj,inApptObj,tmpTime);
}

/* inState: noblk = no block
			startblk = there is no block, but one has been started by clicking on the "add"
			availblk = in a block, an appointment can be made
			fillblk = in a block, an appointment has been made
			nablk = in a block, but time not available for an appointment
*/
function drawTime(inElement,inTime,inState,inSlotSize,inBlockObj) {
	var tdTime = inElement;
	var sStyle = "timeempty";
	var sHTML = GetDisplayTime(inTime);
	//KDC, 5-8-2008. Updated to always show start-end
	//if (inBlockObj.isSlotted == false) {
		var tmpTime = new Date();
		tmpTime.setTime(inTime.getTime() + (inSlotSize * 60 * 1000));
		sHTML += " - " + GetDisplayTime(tmpTime);
	//}
	var sMakeApp = GetElementCheck("hidMakeApp", "makeapp");
	
	switch(inState) {
		case "noblk":
			sStyle = "time_noblock";
			if (canUserEditBlocks())
			{	
				if ( sMakeApp == 0 )
				{
					sHTML = "<img src='images/make_block.gif' align='left' class='icon' onclick='startBlock(\"" + tdTime.id + "\");' title='Begin New Block'>&nbsp;"+GetDisplayTime(inTime);
				}
			}
			break;
		case "startblk":
			sStyle = "time_noblock";
			sHTML = "<img src='images/end_block.gif' align='left' class='icon' onclick='endBlock(\"" + tdTime.id + "\");' title='End Block'>&nbsp;"+GetDisplayTime(inTime);
			break;
		case "availblk":
			//KDC, 2-15-2010. Schedule openings (that have not already passed) show as unavailable.
			var tdy = new Date();
			if (!(isUserManagerOfThisCal() || isUserOwner()) && inBlockObj.iOpeningMins > 0 && inBlockObj.dtOpeningTime.getTime() > tdy.getTime())
				sStyle = "time_unavailblock";
			else if (!(isUserManagerOfThisCal() || isUserOwner()) && !inBlockObj.isAvailable) //KDC, 5-25-2010. For locked blocks
				sStyle = "time_unavailblock";
			else
				sStyle = "time_availblock";
			break;
		case "fillblk":
			sStyle = "time_apptblock";
			break;
		case "nablk":
			sStyle = "time_unavailblock";
			break;
	}
	
	tdTime.className = sStyle;
	if (inBlockObj.isSlotted == false) {
		tdTime.style.verticalAlign = "top";
		tdTime.style.paddingTop = "5px";
	}
	tdTime.style.height = inSlotSize/5 * document.c_i5MinTimeSlotHeight + "px";
	tdTime.innerHTML = sHTML;
}

function drawBlockCol(inElement,inState,inSlotSize,inBlockObj) {
	var tdBlock = inElement;
	var sStyle = "blockempty";
	var sHTML = "&nbsp;";
	
	switch(inState) {
		case "noblk":
			sStyle = "block_noblock";
			break;
		case "startblk":
			sStyle = "block_noblock";
			break;
		case "availblk":
			//KDC, 2-15-2010. Schedule openings (that have not already passed) show as unavailable.
			var tdy = new Date();
			if (!(isUserManagerOfThisCal() || isUserOwner()) && inBlockObj.iOpeningMins > 0 && inBlockObj.dtOpeningTime.getTime() > tdy.getTime())
				sStyle = "block_unavailblock";
			else if (!inBlockObj.isAvailable) //KDC, 5-25-2010. For locked blocks
				sStyle = "block_unavailblock";
			else
				sStyle = "block_availblock";
			break;
		case "fillblk":
			sStyle = "block_apptblock";
			break;
		case "nablk":
			sStyle = "block_availblock";
			break;
	}

	tdBlock.className = sStyle;
	tdBlock.style.height = inSlotSize/5 * document.c_i5MinTimeSlotHeight + "px";
	tdBlock.innerHTML = sHTML;
}


function drawAppointmentCol(inElement,inState,inBlockObj,inApptObj,inApptStartTime) {
	var sState = inState;
	
	var tdAppt = inElement;
	var sStyle = "apptempty";
	var sHTML = "&nbsp;";

	switch(sState) {
		case "noblk":
			sStyle = "appt_noblock";
			break;
		case "startblk":
			sStyle = "appt_noblock";
			break;
		case "availblk":
			//KDC, 2-15-2010. Schedule openings (that have not already passed) show as unavailable.
			var tdy = new Date();
			if (!(isUserManagerOfThisCal() || isUserOwner()) && inBlockObj.iOpeningMins > 0 && inBlockObj.dtOpeningTime.getTime() > tdy.getTime())
				sStyle = "appt_unavailblock";
			else if (!(isUserManagerOfThisCal() || isUserOwner()) && !inBlockObj.isAvailable) //KDC, 5-25-2010. For locked blocks
				sStyle = "appt_unavailblock";
			else
				sStyle = "appt_availblock";
			var tm = formatTimeforServer(inApptStartTime);

			//KDC, 9-30-2008. Code for easily "locking" untaken appointment slots.
			//if (WASSCalendar.CanUserEditBlocks(document.sUserID) && inBlockObj.isSlotted) {
			if (WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,inBlockObj.sUserID) && inBlockObj.isSlotted) {
				var et = new Date(inApptStartTime.getTime() + (inBlockObj.iSlotSize * 60 * 1000));
				et = formatTimeforServer(et);
				var dt = formatDateforServer(inApptStartTime);
				sHTML = "<img align='right' class='icon' border='0' onclick='lockApptSlot(this," + inBlockObj.iBlockID + ",\"" + dt + "\",\"" + tm + "\",\"" + et + "\");' src='images/unavailable_block.gif' title='Appointment slot is Available. Click to make slot Unavailable' style='margin-right:10px;_margin-right:12px;'> ";
			}
			
			if (inBlockObj.isApptMakeable()) {
				if (inBlockObj.isSlotted) {
				sHTML += "<img src='images/make_appmt.gif' align='left' class='icon' onclick='makeAppt(\"" + inBlockObj.iBlockID + "\",\"" + tm + "\");' title='Make New Appointment'>&nbsp;";
					sHTML += "<div style='font-style:italic;font-size:10px;display:inline;height:25px;vertical-align:middle;'>(Click the + sign to make an appointment)</div>";
					if (inBlockObj.isDeadlinePassed() && WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID,inBlockObj.sUserID))
						sHTML += "<span class='blockdeadline'>Deadline Passed</span>";
				}
				else
					sHTML += "";
				sHTML += "";
			} else {
				//KDC, 12-14-2008. Commenting this out because in IE it takes over the entire unslotted slot and users can't see appointments
				//sHTML += "<div style='width:100%;height:100%;cursor:default;' alt='" + inBlockObj.whyApptNotMakeable + "' title='" + inBlockObj.whyApptNotMakeable + "'></div>";
			}
			break;
		case "fillblk":
			sStyle = "appt_apptblock";
			sHTML = "";
			break;
		case "nablk":
			sStyle = "appt_unavailblock";
			//KDC, 9-30-2008. Will fix text soon...
			if (inApptObj != null && !inApptObj.isAvailable)
				sHTML = "";
			if (inBlockObj.isDeadlinePassed())
				sHTML = "<div class='blockdeadline'>Deadline Passed</div>";
			else {
				sHTML = "Unavailable";
			}
			break;
	}

	tdAppt.className = sStyle;
	tdAppt.style.height = inBlockObj.iSlotSize/5 * document.c_i5MinTimeSlotHeight + "px";
	tdAppt.innerHTML = sHTML;

	//draw the appointment, if one exists. must be after innerHTML
	if (inApptObj != null) inApptObj.Draw(tdAppt,true);
}
