function CalDate(inDate,inDayType,inDayTypeAbbv,inStatus) {
	this.date = inDate;
	//date properties, set with inDate
	this.month = inDate.getMonth();
	this.year = inDate.getFullYear();
	
	this.daytype = inDayType;
	this.daytypeabbv = inDayTypeAbbv;
	this.status = inStatus; //possible values: noblocks,blocksnoappsnoslots,blocksnoappsslots,blocksappsnoslots,blocksappsslots,blocksmyappsslots,blocksmyappsnoslots
}
CalDate.prototype.getDte = function() {
		return this.date;
};
CalDate.prototype.getDayType = function() {
	return this.daytype;
};
CalDate.prototype.setDayType = function(inDayType) {
	this.daytype = inDayType;
};
CalDate.prototype.getDayTypeAbbv = function() {
	return this.daytypeabbv;
};
CalDate.prototype.setDayTypeAbbv = function(inDayTypeAbbv) {
	this.daytypeabbv = inDayTypeAbbv;
};
CalDate.prototype.getStatus = function() {
	return this.status;
};
CalDate.prototype.setStatus = function(inStatus) {
	this.status = inStatus;
};



function Calendar(inDate,inShowControls,inShowHeader,inShowCalBody) {
	this.id = "cal1";
	
	this.date = inDate;
	//date properties, set with inDate
	this.month = inDate.getMonth();
	this.year = inDate.getFullYear();
	this.datebegin = 1; //inDateBegin;
	this.dateend = Calendar.getNumDaysInMonth((this.date).getMonth()+1,(this.date).getFullYear()); //inDateEnd;
	
	//styling properties
	this.showControls = inShowControls; //true;
	this.showHeader = inShowHeader; //true;
	this.showCalBody = inShowCalBody; //true;
	this.DOWlength = 3;
	
	this.caldates = new Array();
}

Calendar.prototype.getDte = function() {
	return this.date;
}
Calendar.prototype.setDte = function(inDate) {
	this.date = inDate;
	this.month = inDate.getMonth();
	this.year = inDate.getFullYear();
	this.datebegin = 1; //inDateBegin;
	this.dateend = Calendar.getNumDaysInMonth((this.date).getMonth()+1,(this.date).getFullYear()); //inDateEnd;
}

/************************************/
/* getNumDaysInMonth				*/
/************************************/
//returns the number of days in the given month/year.  Where Jan = month #1
Calendar.getNumDaysInMonth = function(inMonthNum,inFullYear){
	//1=January, 12=December
	//thirty days has September...
	switch(inMonthNum){
		case 2:
			if((inFullYear%4==0&&inFullYear%100!=0)||inFullYear%400==0)
				return 29; //leap year
			else
				return 28;
		case 4:
			return 30;
		case 6:
			return 30;
		case 9:
			return 30;
		case 11:
			return 30
		default:
			return 31;
	}
}
Calendar.isDateInCalendarMonth = function(inCalendarDate,inDate) {
	if (inDate.getFullYear() == inCalendarDate.getFullYear()) {
		if (inDate.getMonth() == inCalendarDate.getMonth()) {
			return true;
		}
	}
	return false;
}

Calendar.changeDate = function(inDate) {
	gCal.setDte(inDate);
	$("#divDateScroll").empty();
	$("#divDateScroll").append(gCal.drawCalendar());
}
/************************************/
/* changeMonthNext					*/
/************************************/
//called when the user clicks on the "next" button on the calendar header
Calendar.changeMonthNext = function(e) {
	if (!e) e = window.event;  // IE Event Model
	var dt = new Date(gCal.getDte().getTime());
	var mo = dt.getMonth();
	dt.setMonth(mo+1);
	Calendar.changeDate(dt);
	updateContent();
}
Calendar.changeMonthPrevious = function(e) {
	if (!e) e = window.event;  // IE Event Model
	var dt = new Date(gCal.getDte().getTime());
	var mo = dt.getMonth();
	dt.setMonth(mo-1);
	Calendar.changeDate(dt);
	updateContent();
}

Calendar.selectDate = function(e) {
	if (!e) e = window.event;  // IE Event Model
	//get the td
	$td = $(e.target);
	if ($(e.target).parents(".tdday").length > 0) {
		$td = $(e.target).parents(".tdday");
	}
	//update date to selected class
	$td.addClass("selected");		
}

Calendar.getBlocksForDate = function(e) {
	if (!e) e = window.event;  // IE Event Model
	//get the td
	$td = $(e.target);
	if ($(e.target).parents(".tdday").length > 0) {
		$td = $(e.target).parents(".tdday");
	}
	//update date to selected class
	var dtnum = $td.attr("id").substr(5);
	var dt = gCal.caldates[dtnum-1].getDte();

	controller.getBlocksByCalDate(gCalendarID,dt,dt);

}

Calendar.prototype.drawHeader = function() {
	
	var trHeaderRow = document.createElement("TR");

	if (this.showControls) {
		var tdBack = document.createElement("TD");
		tdBack.className = "monthcontrol";
		tdBack.innerHTML = "&lt;";
		tdBack.title = "Last Month";
		tdBack.onmousedown = Calendar.changeMonthPrevious;
		trHeaderRow.appendChild(tdBack);
	}
		
	var headerspan = (this.showControls) ? headerspan = "5" : "7";
	var tdHeaderCol = document.createElement("TD");
	tdHeaderCol.id = "tdCalHeader";
	tdHeaderCol.colSpan = headerspan;
	tdHeaderCol.className = "monthheader";
	tdHeaderCol.innerHTML = months[this.month] + " " + this.year;
	trHeaderRow.appendChild(tdHeaderCol);

	if (this.showControls) {
		var tdNext = document.createElement("TD");
		tdNext.className = "monthcontrol";
		tdNext.innerHTML = "&gt;";
		tdNext.title = "Next Month";
		tdNext.onmousedown = Calendar.changeMonthNext;
		trHeaderRow.appendChild(tdNext);
	}
	
	return trHeaderRow;
}

Calendar.prototype.drawDOWRow = function() {
	var trDOWRow = document.createElement("TR");
	
	for(var i=0;i<days.length;i++){
		var tdDOW = document.createElement("TD");
		tdDOW.className = "dayofweek";
		tdDOW.innerHTML = days[i].substring(0,this.DOWlength);
		trDOWRow.appendChild(tdDOW);
	}
	
	return trDOWRow;
}

Calendar.prototype.drawWeek = function() {
	
}

Calendar.prototype.drawCalendar = function() {
	var tblNode = document.createElement("TABLE");
	tblNode.id = this.id;
	tblNode.cellSpacing = "0";
	tblNode.cellPadding = "0";
	tblNode.border = "0";
	
	var tblBody = document.createElement("TBODY");
	tblNode.appendChild(tblBody);
	
	if (this.showHeader) {
		tblBody.appendChild(this.drawHeader());
	}

	if (this.showCalBody) {
		
		//Draw days of week row
		tblBody.appendChild(this.drawDOWRow());
	
		//Draw the first row - for blanks
		var trRow = document.createElement("TR");

		//Write the leading empty cells
		var firstofmonth = new Date(this.date);
		firstofmonth.setDate(1);
		var firstDay = (firstofmonth).getDay();
		for (var j=0;j<firstDay;j++) {
			var tdEmpty = document.createElement("TD");
			tdEmpty.innerHTML = "&nbsp;";
			tdEmpty.className = "dayempty";
			trRow.appendChild(tdEmpty);
		}
		//Append row, even if not completely full.  Will append to row below
		tblBody.appendChild(trRow);
	
		//all cells with dates - loop over every day in the calendar
		var ctr = firstDay;
		for (var k=this.datebegin;k<=this.dateend;k++) {
			var iNumDisplay = k > this.length ? k - this.length : k; //this is for showing weeks, because a week can span multiple months
	
			var tdDay = document.createElement("TD");
			tdDay.id = this.id + "_" + iNumDisplay;
			var dtDrawn = new Date(this.year,this.month,iNumDisplay,0,0,0);
			
			$(tdDay).addClass("day tdday");
			
			var dateinfo = "<div class='dateholder'><div class='datenum'>" + iNumDisplay + "</div>";
			if (this.caldates.length >= iNumDisplay && this.caldates[iNumDisplay-1] != null) {
				dateinfo += "<div class='datetext'>" + this.caldates[iNumDisplay-1].getDayTypeAbbv() + "</div>";
				$(tdDay).addClass(this.caldates[iNumDisplay-1].getStatus());	
			}
			dateinfo += "</div>";
			$(tdDay).html(dateinfo);
			
			$(tdDay).bind("vmousedown",function(event) {
				//if no ctrl or shift, then deselect all selected - to be added later!
				$("#cal1").find(".selected").removeClass("selected")
				Calendar.selectDate(event);
				Calendar.getBlocksForDate(event);
			});
			
			//tdDay.innerHTML = "<div class='dateholder'><div class='datenum'>" + iNumDisplay + "</div><div class='datetext'></div><div class='datefooter'></div></div>";
			trRow.appendChild(tdDay);
	
			//start a new row?
			if (ctr%7 == 6) {
				trRow = document.createElement("TR");
				tblBody.appendChild(trRow);
			}
			ctr++;
		}

		//draw the rest of the empty cells after the last date
		ctr--;
		while (ctr%7 < 6) {
			var tdEmpty = document.createElement("TD");
			tdEmpty.innerHTML = "&nbsp;";
			tdEmpty.className = "dayempty";
			trRow.appendChild(tdEmpty);
			ctr++;
		}

	}
	
	return tblNode;
}
