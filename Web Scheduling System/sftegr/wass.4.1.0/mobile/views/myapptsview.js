var gCal;
var gApptCals = new Array();
var gAppts = new Array();

function MyApptsView() {
	this.pagetitle = "My Appointments";
	this.filters = {};
	this.numfilters = 0;
}

//set and show the page title and set the global apptid to the input apptid (sent from calling page).
MyApptsView.prototype.setPageVars = function() {
	$("#pagetitle").text(this.pagetitle);
	
	//Filter: Start Date
	$('#txtStartDate').scroller({
		preset: 'date',
		theme: 'jqm',
		display: 'modal',
		mode: 'scroller',
		dateOrder: 'D ddMyy', //'MD ddyy',
		endYear: 2015,
		minDate: new Date(2009,0,1)
	});    
	$('#txtStartDate').scroller('setDate',new Date(),true);
	$('#txtStartDate').bind("change",function () {
		if ($(this).val() != null && $(this).val() != "") {
			$('#txtStartDateClear').show();
			$('#txtEndDate').scroller("option","minDate", new Date($(this).val()));
		}
		else
			$('#txtStartDateClear').hide();
		$("#listappts").submit();
	});
    $('#txtStartDateClear').click(function () {
        $('#txtStartDate').val('');
		$(this).hide();
		$("#listappts").submit();
        return false;
    });
	$('#txtStartDateClear').show();

	
	//Filter: End Date
	$('#txtEndDate').scroller({
		preset: 'date',
		theme: 'jqm',
		display: 'modal',
		mode: 'scroller',
		dateOrder: 'D ddMyy', //'MD ddyy',
		endYear: 2015
	});
	$('#txtEndDate').scroller("setDate",new Date($("#txtStartDate").val()));
	$('#txtEndDate').scroller("option","minDate", new Date($("#txtStartDate").val()));
	$('#txtEndDate').bind("change",function () {
		if ($(this).val() != null && $(this).val() != "")
			$('#txtEndDateClear').show();
		else
			$('#txtEndDateClear').hide();
		$("#listappts").submit();
	});
    $('#txtEndDateClear').click(function () {
        $('#txtEndDate').val('');
		$(this).hide();
		$("#listappts").submit();
        return false;
    });
	$('#txtEndDateClear').hide();


	//Filter: Appt With
	$('#txtApptName').bind("change",function () {
		if ($(this).val() != null && $(this).val() != "")
			$('#txtApptNameClear').show();
		else
			$('#txtApptNameClear').hide();
		$("#listappts").submit();
	});
    $('#txtApptNameClear').click(function () {
        $('#txtApptName').val('');
		$(this).hide();
		$("#listappts").submit();
        return false;
    });
	$('#txtApptNameClear').hide();

	//Filter defaults
	this.setFilters();	
}

MyApptsView.prototype.resetFilterDesc = function() {
	$("#divFilterDesc").show();
	$("#divFilterDesc").text("(All Appointments)");
}

MyApptsView.prototype.setParmNetID = function(inVal) {
	$("#txtApptName").attr("placeholder",inVal.toLowerCase()+" or name");
	$("#txtApptName").textinput();
}

MyApptsView.prototype.addFilter = function(inFilter) {
	if (inFilter != null) {
		var str = "";
		str = '<div id="divFilter' + inFilter.getFilterField() + '" class="filter">' + inFilter.getFilterDisplayValue();
		str += '<a href="#" onclick="myapptsview.removeFilter(\'' + inFilter.getFilterField() + '\'); return false;"><img src="../images/cancel.gif" alt="remove" border="0" class="inlineicon" /></a></div>';
		$("#divFilterList").append(str);
		this.filters[inFilter.getFilterField()] = inFilter;
		this.numfilters++;
		
		$("#divFilterDesc").hide();
	}
}

MyApptsView.prototype.removeFilter = function(inFilterField) {
	var f = this.filters[inFilterField]
	$("div").remove("#divFilter" + inFilterField);
	//reset the form field
	var type = $("#" + f.getFormField()).attr("type");
	//handle selects, input type=text
	if (type.indexOf("select") > -1) {
		$("#" + f.getFormField()).prop('selectedIndex',0);
	}
	else if (type == "text") {
		$("#" + f.getFormField()).val("");
	}
	$("#" + f.getFormField() + "Clear").hide();
	this.filters[inFilterField] = null;
	this.numfilters--;
	
	if (this.numfilters == 0) {
		this.resetFilterDesc();
	}
	
	//reload the data
	controller.getAppointments(this.filters);
}

MyApptsView.prototype.removeAllFilters = function() {
	this.resetFilterDesc();
	$("#divFilterList").empty();
	this.filters = {};	
	this.numfilters = 0;
}

//Set filter data from form to filter objects and append to filters property
MyApptsView.prototype.setFilters = function() {
	var caltype = "appointment";
	var f = null;
	
	var sd = isNullOrBlank($('#txtStartDate').val()) ? null : new Date($('#txtStartDate').val());
	if (sd != null) {
		f = new Filter(caltype,"startdate",">=",sd,"Start " + formatDateShort(sd),"txtStartDate");
		this.addFilter(f);
	}
	var ed = isNullOrBlank($('#txtEndDate').val()) ? null : new Date($('#txtEndDate').val());
	if (ed != null) {
		f = new Filter(caltype,"enddate","<=",ed,"End " + formatDateShort(ed),"txtEndDate");
		this.addFilter(f);
	}
	var apptwith = $("#txtApptName").val();
	if (apptwith != null && apptwith != "") {
		f = new Filter(caltype,"apptwith","==",apptwith,apptwith,"txtApptName");
		this.addFilter(f);
	}
}

//Unused
MyApptsView.prototype.loadCalendarList = function() {
console.log("loading calendar list: " + gApptCals.length);
	for (var i=0; i < gApptCals.length; i++) {
		if (gApptCals[i] != null) {
			$('#selCalendars').append("<option value = '" + gApptCals[i].getID() + "'>" + gApptCals[i].getTitle() + "</option>");
		}
	}
	$('#selCalendars').selectmenu('refresh');
}



//Put the appt data from the appt object on the form
MyApptsView.prototype.loadAppts = function() {
	$("#ulAppts").empty();
	$("#ulAppts").listview('refresh');

	var str = "";
	
	//no appointments to show
	if (gAppts.length == 0) {
		$("#divFilterDesc").show();
		$('#divFilterDesc').text("No appointments");
	}

	var dt = null;
	for (var i=0; i < gAppts.length; i++) {
		if (gAppts[i] != null) {
			//get the appointment date and if it is different, create a new divider
			var nextdate = gAppts[i].getDte();
				if (dt == null || isDateBefore(dt,nextdate)) {
					$('#ulAppts').append('<li data-role="list-divider">' + formatDate(nextdate) + '</li>');
					dt = nextdate;
				}
				var st = gAppts[i].getStartTime();
				var et = gAppts[i].getEndTime();
				str = '<li><a href="appt.php?calid=' + gAppts[i].getCalendarID() + '&blockid=' + gAppts[i].getBlockID() + '&apptid=' + gAppts[i].getID() + '&st=' + formatTimeforServer(st) + '&et=' + formatTimeforServer(et) + '" data-ajax="false">';
				str += '<span class="appttime">' + formatTime(st) + ' - ' + formatTime(et) + ' with ';
				if (g_loggedInUserID == gAppts[i].getBlockOwner().getUserID())
					str += gAppts[i].getMaker().getName();
				else 
					str += gAppts[i].getBlockOwner().getName();
				str += '</span>';
				str += '</a></li>';
				$('#ulAppts').append(str);
		}
	}
	$("#ulAppts").listview('refresh');
}

//Validate the form before saving
MyApptsView.prototype.isValidForm = function() {
	return true;	
}

var myapptsview = new MyApptsView();
