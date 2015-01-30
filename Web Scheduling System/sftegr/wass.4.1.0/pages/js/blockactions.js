document.g_iNumTimePeriods = 0;
function addTimePeriod_Times(elDiv) {
	var iNum = document.g_iNumTimePeriods;

	//start time div	
	var elDivStart = document.createElement("DIV");
	elDiv.appendChild(elDivStart);

	//start time: hour
	var elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartHour" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat";
	elLabel.innerHTML = "Start Time:";
	elDivStart.appendChild(elLabel);
	
	var elSel = document.createElement("SELECT");
	elSel.id = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeStart('Recur',iNum); };
	for (var i=0; i < 12; i++) {
		elSel.options[i] = new Option(i+1,i+1);
	}
	elSel.options[8].selected = true;
	elDivStart.appendChild(elSel);
	
	var elTxt = document.createTextNode(" : ");
	elDivStart.appendChild(elTxt);
	
	//start time: minutes
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartMinute" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Minutes:";
	elDivStart.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeStart('Recur',iNum); };
	for (var i=0; i < 12; i++) {
		var mins = eval(i*5) + "";
		if (mins.length < 2) mins = "0" + mins;
		elSel.options[i] = new Option(mins,mins);
	}
	elSel.options[0].selected = true;
	elDivStart.appendChild(elSel);

	//start time: AM/PM
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "AM/PM:";
	elDivStart.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selStartAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeStart('Recur',iNum); };
	elSel.options[0] = new Option("AM","AM");
	elSel.options[1] = new Option("PM","PM");
	elSel.options[0].selected = true;
	elDivStart.appendChild(elSel);


	//end time div	
	var elDivEnd = document.createElement("DIV");
	elDiv.appendChild(elDivEnd);

	//end time: hour
	var elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndHour" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat";
	elLabel.innerHTML = "End Time:";
	elDivEnd.appendChild(elLabel);
	
	var elSel = document.createElement("SELECT");
	elSel.id = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndHour" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeEnd('Recur',iNum); };
	for (var i=0; i < 12; i++) {
		elSel.options[i] = new Option(i+1,i+1);
	}
	elSel.options[9].selected = true;
	elDivEnd.appendChild(elSel);
	
	elTxt = document.createTextNode(" : ");
	elDivEnd.appendChild(elTxt);
	
	//end time: minutes
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndMinute" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Minutes:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndMinute" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeEnd('Recur',iNum); };
	for (var i=0; i < 12; i++) {
		var mins = eval(i*5) + "";
		if (mins.length < 2) mins = "0" + mins;
		elSel.options[i] = new Option(mins,mins);
	}
	elSel.options[0].selected = true;
	elDivEnd.appendChild(elSel);

	//end time: AM/PM
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "AM/PM:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selEndAMPM" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeEnd('Recur',iNum); };
	elSel.options[0] = new Option("AM","AM");
	elSel.options[1] = new Option("PM","PM");
	elSel.options[0].selected = true;
	elDivEnd.appendChild(elSel);
	
	elTxt = document.createTextNode(" OR SET DURATION: ");
	elDivEnd.appendChild(elTxt);

	//end time: duration
	elLabel = document.createElement("LABEL");
	elLabel.id = "lblDuration" + document.g_iNumTimePeriods + "_Recur";
	//elLabel.for = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elLabel.className = "mandat removed";
	elLabel.innerHTML = "Duration:";
	elDivEnd.appendChild(elLabel);

	elSel = document.createElement("SELECT");
	elSel.id = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elSel.name = "selDuration" + document.g_iNumTimePeriods + "_Recur";
	elSel.tabindex = 32;
	elSel.onchange = function () { changeDuration('Recur',iNum); };
	elSel.options[0] = new Option("","");
	elDivEnd.appendChild(elSel);
	
	var elRemove = document.createElement("A");
	elRemove.href = "#";
	elRemove.className = "labelButton";
	elRemove.style.marginLeft = "20px";
	elRemove.onclick = function () { removeTimePeriod(iNum); };
	elRemove.innerHTML = "Remove time period";
	elDivEnd.appendChild(elRemove);

	var elDivLine = document.createElement("DIV");
	elDivLine.id = "formdividerSub";
	elDiv.appendChild(elDivLine);

	var elBR = document.createElement("BR");
	elDiv.appendChild(elBR);
		
	document.g_iNumTimePeriods++;
	
	setDurationVals(document.g_sShownSection,60,iNum);
	changeDuration(document.g_sShownSection,iNum);
//	alert("END");
}
document.g_arrWeekdays = new Array("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");
function addTimePeriod_Weekly(elDiv) {
	var iNum = document.g_iNumTimePeriods;

	var elDivHolder = document.createElement("DIV");
	elDivHolder.id = "divWeekly";
	elDiv.appendChild(elDivHolder);

	var elLabel = document.createElement("LABEL");
	elLabel.className = "mandatr";
	elLabel.innerHTML = "&nbsp;&nbsp;";
	elDivHolder.appendChild(elLabel);
	
	var elDiv1 = document.createElement("DIV");
	elDiv1.style.textIndent = "10px";
	elDivHolder.appendChild(elDiv1);

	var elTxt = document.createTextNode(" on: ");
	elDivHolder.appendChild(elTxt);

	var elSel = document.createElement("SELECT");
	elSel.id = "selWeeklyRecurDay" + iNum;
	elSel.name = "selWeeklyRecurDay" + iNum;
	elSel.tabindex = 32;
	for (var i=0; i < document.g_arrWeekdays.length; i++) {
		elSel.options[i] = new Option(document.g_arrWeekdays[i],document.g_arrWeekdays[i]);
	}
	elDivHolder.appendChild(elSel);
}
function addTimePeriod_MonthlyDay(elDiv) {
	var iNum = document.g_iNumTimePeriods;

	var elDivHolder = document.createElement("DIV");
	elDivHolder.id = "divMonthlyDay";
	elDiv.appendChild(elDivHolder);

	var elLabel = document.createElement("LABEL");
	elLabel.className = "mandatr";
	elLabel.innerHTML = "&nbsp;";
	elDivHolder.appendChild(elLabel);
	
	var elDiv1 = document.createElement("DIV");
	elDiv1.style.textIndent = "10px";
	elDivHolder.appendChild(elDiv1);

	var elTxt = document.createTextNode("Day ");
	elDivHolder.appendChild(elTxt);

	var elSel = document.createElement("SELECT");
	elSel.id = "selMonthlyRecurDay" + iNum;
	elSel.name = "selMonthlyRecurDay" + iNum;
	elSel.tabindex = 32;
	elDivHolder.appendChild(elSel);
	setDaysOfMonthList("selMonthlyRecurDay" + iNum);

	elTxt = document.createTextNode(" of every month");
	elDivHolder.appendChild(elTxt);
}
function setDaysOfMonthList(inSelID) {
	var elSel = GetElement(inSelID);
	
	//determine number of days in month, based on start date and end date.
	var dtStart = new Date();
	var dtEnd = new Date();
	var sStartDate = GetElement("txtStart_Recur").value;
	var sEndDate = GetElement("txtEnd_Recur").value;
	if (sStartDate != "")
		dtStart = GetDateFromDisplay(sStartDate);
	if (sEndDate != "")
		dtEnd = GetDateFromDisplay(sEndDate);
	var numdays = 31; //default
	var tmpDate = new Date(dtStart.getTime());
	//get the minimum numdays, based on selected months
	while (tmpDate <= dtEnd) {
		var num = calendar.getNumDaysInMonth(eval(tmpDate.getMonth()+1),tmpDate.getFullYear());
		if (num < numdays)
			numdays = num;
		tmpDate.setMonth(tmpDate.getMonth() + 1);
	}
	for (var i=0; i < numdays; i++) {
		elSel.options[i] = new Option(i+1,i+1);
	}
}
function addTimePeriod_MonthlyWeekDay(elDiv) {
	var iNum = document.g_iNumTimePeriods;

	var elDivHolder = document.createElement("DIV");
	elDivHolder.id = "divMonthlyWeek";
	elDiv.appendChild(elDivHolder);

	var elLabel = document.createElement("LABEL");
	elLabel.className = "mandatr";
	elLabel.innerHTML = "&nbsp;";
	elDivHolder.appendChild(elLabel);
	
	var elDiv1 = document.createElement("DIV");
	elDiv1.style.textIndent = "10px";
	elDivHolder.appendChild(elDiv1);

	var elTxt = document.createTextNode("The ");
	elDivHolder.appendChild(elTxt);

	var elSel = document.createElement("SELECT");
	elSel.id = "selMonthlyRecurWeek" + iNum;
	elSel.name = "selMonthlyRecurWeek" + iNum;
	elSel.tabindex = 32;
	elSel.options[0] = new Option("First",1);
	elSel.options[1] = new Option("Second",2);
	elSel.options[2] = new Option("Third",3);
	elSel.options[3] = new Option("Last",4);
	elDivHolder.appendChild(elSel);

	elSel = document.createElement("SELECT");
	elSel.id = "selMonthlyRecurWeekDay" + iNum;
	elSel.name = "selMonthlyRecurWeekDay" + iNum;
	elSel.tabindex = 32;
	for (var i=0; i < document.g_arrWeekdays.length; i++) {
		elSel.options[i] = new Option(document.g_arrWeekdays[i],document.g_arrWeekdays[i]);
	}
	elDivHolder.appendChild(elSel);

	elTxt = document.createTextNode(" of every month");
	elDivHolder.appendChild(elTxt);
}
function addTimePeriod() {
	var iNum = document.g_iNumTimePeriods;
	var par = GetElement("divTimePeriods");
	
	var elDiv = document.createElement("DIV");
	elDiv.id = "divTimePeriod" + document.g_iNumTimePeriods;
	par.appendChild(elDiv);
	
	//get the recur type
	var selRecurType = GetElement("selRecur");
	var sRecurType = selRecurType.options[selRecurType.options.selectedIndex].value;
//	alert(sRecurType);
	
	if (sRecurType == "daily" || sRecurType == "dailyweekdays") {
		//do nothing for daily
	} else if (sRecurType == "weekly" || sRecurType == "otherweekly") {
		addTimePeriod_Weekly(elDiv);	
	} else if (sRecurType == "monthlyday") {
		addTimePeriod_MonthlyDay(elDiv);
	} else if (sRecurType == "monthlyweekday") {
		addTimePeriod_MonthlyWeekDay(elDiv);
	}
	
	addTimePeriod_Times(elDiv);
	setRecurType();
}
function removeTimePeriod() {
	var iNum = document.g_iNumTimePeriods-1;
	var par = GetElement("divTimePeriods");
	
	var elRemove = GetElement("divTimePeriod" + iNum);
	par.removeChild(elRemove);
	
	document.g_iNumTimePeriods--;
	setRecurType();
}
function setRecurType() {
	var selRecurType = GetElement("selRecur");
	if (document.g_iNumTimePeriods > 0) {
		selRecurType.disabled = true;
	} else {
		selRecurType.disabled = false;
	}
}
