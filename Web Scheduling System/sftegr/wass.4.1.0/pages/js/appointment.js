function Appointment(inApptID,inBlockID,inStartTime,inEndTime,inState,inUserID,inName,inEmail,inPhone,inPurpose,inIsRemind, inAvailable) {
	this.iApptID = inApptID;
	this.iBlockID = inBlockID;
	this.dtStart = inStartTime != null ? new Date(inStartTime.getTime()) : null; //null if unslotted
	this.dtEnd = inEndTime != null ? new Date(inEndTime.getTime()) : null; //null if unslotted
	this.sState = inState;

	this.sUserID = inUserID;
	this.sName = inName;
	this.sEmail = inEmail;
	this.sPhone = inPhone;
	this.sPurpose = inPurpose;
	
	this.isRemind = inIsRemind;
	this.isAvailable = inAvailable;
}

Appointment.prototype.Draw = function(inParentRowElement,inIsSlotted) {
	var tdAppt = inParentRowElement;

	var divNode = document.createElement("DIV");
	divNode.id = "div" + tdAppt.id;
	var cls = inIsSlotted ? "slottedappt" : "unslottedappt";
	tdAppt.appendChild(divNode);
	
	var sHTML = "";

	if (canUserEditAppts(this.sUserID,this.sEmail)) {  //KDC, 6-26-2008.
		if (this.isAvailable) { //KDC, 9-30-2008. Locked appointment slot handling
			sHTML += "<img src='images/cancel.gif' align='right' class='icon' onclick='cancelAppt(\"" + this.iApptID + "\",false);' title='Cancel Appointment' border='0'>";
			//KDC, 4-23-2008
			sHTML += "<img src='images/Q1.gif' align='right' class='icon' onclick='openHelp(\"appointment\");' title='Help' border='0'>";
			//KDC, 1-30-2008
			sHTML += "<img src='images/sync_appt.gif' align='right' class='icon' onclick='icalAppt(\"" + this.iApptID + "\");' title='Sync Appointment' border='0'>";
			//KDC, 9-29-2008. For easily making appointments unavailable
			//KDC, 12-2-2008. This should be available for people who can edit blocks only
			//KDC, 5-17-2010. Need to get block user id to send.
			var blk = null;
			blk = Block.GetBlockByID(this.iBlockID);
			if (WASSCalendar.CanUserEditBlocksOnThisCal(document.sUserID, blk.sUserID) && inIsSlotted)
				sHTML +=  "<img align='right' class='icon' border='0' onclick='lockAppt(" + this.iApptID + ");' src='images/unavailable_block.gif' title='Appointment slot is Available. Click to make slot Unavailable'> ";
			sHTML += "<img src='images/information.gif' align='left' class='icon' onclick='showApptInfo(\"" + this.iApptID + "\");' title='View Appointment Information' border='0'>";
			sHTML += "<img src='images/edit_appt.gif' align='left' class='icon' onclick='makeAppt(\"" + this.iBlockID + "\",null,\"" + this.iApptID + "\");' title='Edit Appointment' border='0'>";
			sHTML += safeHTML(this.sName) + "&nbsp;(<a class='apptemail' href='mailto:" + safeHTML(this.sEmail) + "'>" + safeHTML(this.sEmail) + "</a>,&nbsp;" + this.sPhone + ")";
		} else {
			//KDC, 9-29-2008. For easily making appointments unavailable
			if (inIsSlotted) {
				cls = "unavailappt";
				sHTML += "<img src='images/available_block.gif' align='right' class='icon' onclick='unlockApptSlot(this," + this.iApptID + ");'  title='Appointment slot is Unavailable. Click to make appointment Available' border='0'> ";
				sHTML += "&nbsp;Slot locked";
			}
		}
		
	} else {
		//KDC, 9-30-2008. Displaying locked appointments to students
		if (!this.isAvailable) {
			cls = "unavailappt";
			sHTML += "&nbsp;Unavailable";
		}
		else {
			//KDC, 6-23-2009. For showing appointment info
			var blk = Block.GetBlockByID(this.iBlockID);
			var isshowappinfo = false;
			if (blk != null && blk.isShowAppInfo != null && blk.isShowAppInfo == "1") isshowappinfo = true;
			if ( ((document.sAuthType != "guest" && document.sUserID != null && document.sUserID == this.sUserID) || (document.sAuthType == "guest" && document.sGuestID == this.sEmail)) || isshowappinfo ) {
				sHTML += safeHTML(this.sName) + "&nbsp;(<a class='apptemail' href='mailto:" + safeHTML(this.sEmail) + "'>" + safeHTML(this.sEmail) + "</a>,&nbsp;" + this.sPhone + ")";
			} else {
				if (inIsSlotted) {
					sHTML += "&nbsp;Slot Taken&nbsp;";
				} else {
					sHTML += "&nbsp;Appointment Taken&nbsp;";
				}
			}
		}
	}
	divNode.className = cls;
	divNode.innerHTML = sHTML;
}

