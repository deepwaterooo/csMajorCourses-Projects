var gAppt;
var gBlkID;
var gApptDate;

function ApptView() {
	this.apptid = null;
	this.pagetitle = "Sign Up for Appointment"; //Default to new appointment
	this.isNewAppt = true;
	this.starttime = new Date();
	this.endtime = new Date();
	
	this.calid = null;
	this.calownerid = "";
	this.managers = [];
	this.purreq = false;
	
	this.isOwnerManager = false;
}

//set and show the page title and set the global apptid to the input apptid (sent from calling page).
ApptView.prototype.setPageVars = function(inApptID,inST,inET) {
	if (inApptID != null && inApptID != "") {
		this.apptid = inApptID;
		this.pagetitle = "View/Edit Appointment";
		$("#btnSubmit").button();
		$("#btnSubmit").val("Save the Appointment");
		$("#btnSubmit").button({
			submit: function(event, ui) {
				doSubmit();
			}
		});
		$("#btnSubmit").button("refresh");
		this.isNewAppt = false;
	}
	if (inST != null && inST != "") {
		this.starttime = formatDateTimeFromServer(null,inST);
	}
	if (inET != null && inET != "") {
		this.endtime = formatDateTimeFromServer(null,inET);
	}
	
	$("#pagetitle").text(this.pagetitle);
	
	//Show/Hide appropriate fields
	if (this.apptid == null) {
		$("#divWhenMade").hide();
		$("#divCancel").hide();
	} else {
		$("divCancel").show();
	}
		
	gApptDate = null;
}

ApptView.prototype.checkEnabled = function() {
	var today = new Date();
console.log(this.isOwnerManager);
	if (gAppt.getDte().getTime() < today.getTime() && !this.isOwnerManager) {
		$("form").find("input","textarea").each(function() {
			if ($(this).textinput())
				$(this).textinput("disable");
		});
		$("textarea").addClass('ui-disabled');
		$("form").find("input[type='checkbox']").each(function() {
			$(this).checkboxradio('disable');
		});
		$("form").find("select").each(function() {
			$(this).selectmenu('disable');
		});
		$("form").find("input[type='submit']").each(function() {
			$(this).button('disable');
		});
	}
}

ApptView.prototype.setParmNetID = function(inVal) {
	//txtUserID set dynamically below
}

ApptView.prototype.showIsValidTxtEmail = function(isValid,txtaddr) {
	if (!isValid) {
		alert("Note: This text message email address does not appear to be valid; please check to make sure you have the correct cell phone number and provider SMS gateway.");
	} else {
		$("#divTextEmail").text(txtaddr);
		$("#editTextMsgEmail").popup("close");
	}
}


ApptView.prototype.loadCalendarData = function(inCalID,inCalOwnerID,inManagers,inPurReq) {
	this.calid = inCalID;
	this.calownerid = inCalOwnerID;
	if (inManagers != null && inManagers.length > 0)
		this.managers = inManagers.split(",");
	this.purreq = inPurReq;
	
	//Check for purpose required
	if (this.purreq)
		$("#txtPurpose").attr("placeholder", "Purpose (required)");
		
	//Check if logged in user is owner of the calendar, or manager of calendar
	if (g_loggedInUserID == this.calownerid)
		this.isOwnerManager = true;
	if (this.managers != null && this.managers.length > 0 && this.managers.indexOf(g_loggedInUserID) != -1)
		this.isOwnerManager = true;
}


//Put the block data from the block object on the form
ApptView.prototype.loadBlockData = function(inBlk) {
	gBlkID = inBlk.getBlockID();
	$("#divBlockTitle").text(inBlk.getTitle());
	$("#divBlockOwner").text("with " + inBlk.getOwner().getName());
	var loc = inBlk.getLocation();
	if (isNullOrBlank(loc)) loc = "<span style='font-style:italic;'>No location specified</span>";
	$("#divBlockLocation").html(loc);
	var dt = inBlk.getDte();
	$("#divStartDate").text(formatDateLong(dt));
	gApptDate = dt;
	
	//$('#selTime').selectmenu();
	//$('#selTime').empty();
	for (var i = 0; i < inBlk.slots.length; i++) {
		var slt = inBlk.slots[i];
		var st = slt.getStartTime();
		var strText = formatTime(st) + " - " + formatTime(slt.getEndTime());
		var str = "<option value = '" + formatTimeforServer(st) + "," + formatTimeforServer(slt.getEndTime()) + "'";
		if (isTimeSame(st,this.starttime))
			str += " selected='selected'";
		str += ">" + strText + "</option>";
		$('#selTime').append(str);
	//$('#selTime').selectmenu('refresh');
	}
	$('#selTime').selectmenu('refresh');
	
	//Check to see if logged in user is block owner
	if (g_loggedInUserID == inBlk.getOwner().getUserID())
		this.isOwnerManager = true;
}
	

ApptView.prototype.getUserString = function(inUserID) {
	var strUsr = inUserID;
	//Make editable for owner/manager
	if (this.isOwnerManager) {
		strUsr = '<label id="lblUserID" for="txtUserID" class="ui-hidden-accessible">User ID:</label><input type="text" name="txtUserID" id="txtUserID" placeholder="' + gParms["NETID"] + '" title="User ID" class="required" value="' + inUserID + '" />';
	}
	return strUsr;
}
ApptView.prototype.getUserVal = function() {
	var userid = "";
	if($("#txtUserID").length > 0) { 
		userid = $("#txtUserID").val();
	} else { 
		userid = $("#divUserID").text(); 
	}
	return userid;
}

//Put the user data from the user object on the form
ApptView.prototype.loadLoggedInUserData = function(inUser) {
	$("#divUserID").html(this.getUserString(inUser.getUserID()));
	if ($("#txtUserID")) {
		$("#txtUserID").textinput();
		$("#txtUserID").bind("blur", function(event, ui) {
			if (!isNullOrBlank($(this).val())) controller.loadUserInfo($(this).val());
		});
	}
	$("#txtApptName").val(inUser.getName());
	$("#txtPhone").val(inUser.getPhone());
	$("#txtEmail").val(inUser.getEmail());
}
	
	
//Put the appt data from the appt object on the form
ApptView.prototype.loadApptData = function(inAppt) {
	gAppt = inAppt;

	//Set Appointment Time
	var stAppt = inAppt.getStartTime();
	var etAppt = inAppt.getEndTime();
	var str = "<option value = '" + formatTimeforServer(stAppt) + "," + formatTimeforServer(etAppt) + "' selected='selected'>" + formatTime(stAppt) + " - " + formatTime(etAppt) + "</option>";
	var isInserted = false;
	$("#selTime > option").each(function() {
		//read the option value start time
		var ind = $(this).val().indexOf(",");
		var val = $(this).val().substring(0,ind);
		var stSlot = formatDateTimeFromServer(null,val,inAppt.getDte());
		if (!isInserted && stAppt.getTime() < stSlot.getTime()) {
			$(str).insertBefore($(this));
			isInserted = true;
		}
	});
	if (!isInserted) //account for last slot
		$('#selTime').append(str);
	$('#selTime').selectmenu('refresh');	
	
	$("#txtPurpose").val(inAppt.getPurpose());
	if (this.purreq) {
		$("#txtPurpose").attr("placeholder", "Purpose (required)");
		$("#txtPurpose").addClass("required");
	}
	
	$("#divWhenMade").text("When Made: " + inAppt.getWhenMade());
	$("#divWhenMade").show();
	
	//appt for/maker
	$("#divUserID").append(this.getUserString(inAppt.getMaker().getUserID()));
	if ($("#txtUserID")) $("#txtUserID").textinput();
	$("#txtApptName").val(inAppt.getMaker().getName());
	$("#txtPhone").val(inAppt.getMaker().getPhone());
	$("#txtEmail").val(inAppt.getMaker().getEmail());
	
	$("#chkRemind").checkboxradio();
	if (inAppt.getRemind()) {
		$("#chkRemind").prop("checked",true); 
	} else {
		$("#chkRemind").prop("checked",false); 
	}
	$("#chkRemind").checkboxradio('refresh');

	var txtemail = inAppt.getTextEmail();
	if (isNullOrBlank(txtemail)) txtemail = "<span class='italic'>(none selected)</span>";
	$("#divTextEmail").html(txtemail);
	
	this.checkEnabled();
}


ApptView.prototype.isValidForm = function() {
	var str = "";
	var numErrors = 0;
	
	//works for input type=text and textarea
	$("#apptinfo").find(".required").each(function() {
		var val = $(this).val();
		if (isNullOrBlank(val)) {
			if (!isNullOrBlank(str)) str += ", ";
			str += $(this).attr("title");
			numErrors++;
		}
	});
	if (numErrors > 0) {
		if (numErrors == 1) str += " is a required field";
		else str += " are required fields";
		var err = new Error("",str);
		Error.displayErrors(new Array(err));
		return false;		
	}
	return true;
}


//Save appointment data from form to input appointment object (gAppt)
ApptView.prototype.saveApptData = function() {
	var sd = formatDateforServer(gApptDate);
	var tm = $('#selTime').val(); //time is string formatted for server already
	var i = tm.indexOf(",");
	var st = tm.substring(0,i);
	var et = tm.substring(i+1,tm.length);
	
	var pur = $("#txtPurpose").val();
	
	var userid = this.getUserVal();
	var nm = $("#txtApptName").val();
	var ph = $("#txtPhone").val();
	var eml = $("#txtEmail").val();
	var maker = new User(userid,nm,ph,eml,null);

	var rmd = $("#chkRemind").prop("checked");
	var txteml = $("#divTextEmail").text();

	if (gAppt == null) {
		gAppt = new Appointment(null,sd,st,et,maker,gBlkID,this.calid,pur,rmd,txteml,null,g_loggedInUserID,true);
	} else {	
		//gAppt.setDte(sd);
		gAppt.setStartTime(st);
		gAppt.setEndTime(et);
		gAppt.setPurpose(pur);		
		var mkr = gAppt.getMaker();
		//mkr.setUserID(userid);
		mkr.setName(nm);
		mkr.setPhone(ph);
		mkr.setEmail(eml);
		gAppt.setMaker(mkr);	
		gAppt.setRemind(rmd);	
		gAppt.setTextEmail(txteml);
	}

}

var apptview = new ApptView();