var gCals = new Array();
var gBlocks = new Array();
var gShownCalID = 0;

function MakeApptView() {
	this.pagetitle = "Search for Availability";
}

//set and show the page title and set the global apptid to the input apptid (sent from calling page).
MakeApptView.prototype.setPageVars = function() {
	$("#pagetitle").text(this.pagetitle);	
	$("#divResults").hide();
	$("#txtSearch").focus();
	
	$('#txtSearch').bind("input",function () {
		var txt = $.trim($(this).val());
		if ($(this).val() == null || txt.length < 3 ) {
			if ($(".calsection")) {
				$(".calsection").remove();
			}
			$('#divCalendars').empty();
		}	
		else
			$("#search").submit();
	});
	$('.ui-input-clear').live('tap', function () {
			if ($(".calsection")) {
				$(".calsection").remove();
			}
			$('#divCalendars').empty();
	});

}

MakeApptView.prototype.setParmNetID = function(inVal) {
	$("#txtSearch").attr("placeholder",inVal.toLowerCase()+", name, or calendar title");
	$("#txtSearch").textinput();
	$(".instructions").text("Search for a calendar by "+inVal.toLowerCase()+", name, or calendar title to make an appointment.");
}

MakeApptView.prototype.loadCalendars = function() {
	$("#divResults").show();
	
	//Remove calendar section from previous search
	if ($(".calsection")) {
		$(".calsection").remove();
	}
	$('#divCalendars').empty();

	var str = "";
	
	//no calendars to show
	if (gCals.length == 0) {
		str += "No resulting calendars.";
		$('#divCalendars').append(str);
	}
	
	for (var i=0; i < gCals.length; i++) {
		if (gCals[i] != null) {
			str = '<div class="calsection calid' + gCals[i].getID() + '" data-role="collapsible" data-collapsed="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" >';
			str += '<h3>' + gCals[i].getTitle() + '<div class="collapsible-owner">' + gCals[i].getOwner().getName() + '</div>';
            str += '<div class="collapsible-desc">' + gCals[i].getDescription() + '</div></h3><div class="caltext"></div>';
			str += '</div>';
			$('#divCalendars').append(str);
		}
	}
	
	if ($(".calsection")) {
		$(".calsection").collapsible();
		$(".calsection").bind("expand", function(event, ui) {
			//Get the newly opened calendar id
			var clsarr = $(this).attr("class").split(" ");
			var idstr = $.grep(clsarr,function(value) {
				var search = new RegExp("calid","gi");
				if(value.match(search)) return true;
				return false;
			});
			var id = idstr[0].substring(5);
		
			//Close the previously expanded calendar section, unless it is this section
			if (gShownCalID != 0 && gShownCalID != id && $(".calid" + gShownCalID) != null) {
				$(".calid" + gShownCalID).trigger("collapse");
			}

			//Show a "loading" message
			$(this).find(".caltext").html("<b><i>...Looking for Availability...</i></b>");
						
			//Look up all blocks for this calendar ID
			gShownCalID = id;
			controller.getBlocks(id,new Date());
		});
		$(".calsection").bind("collapse", function(event, ui) {
		});
	}
	
	//expand it automatically for one calendar
	if (gCals.length == 1)
		$(".calsection").trigger("expand");
		
	//reset
	gCals = [];
}

MakeApptView.prototype.drawBlockAndSlots = function(blk) {
	var blkid = blk.getBlockID();
	var dte = formatDateforServer(blk.getDte());
			str = '<li class="blktitle blk' + dte + '">' + blk.getTitle();
			str += '<div class="blockdesc">' + blk.getDescription() + '</div><div style="padding: 20px 0px 8px 0px;"><ul id="ulSlots' + blkid + '" data-role="listview" data-mini="true">';

			//loop over slots
			for (var j=0; j < blk.slots.length; j++) {
				var slt = blk.slots[j];
				var st = slt.getStartTime();
				var et = slt.getEndTime();
				str += '<li><a href="appt.php?calid=' + gShownCalID + '&blockid=' + blkid + '&st=' + formatTimeforServer(st) + '&et=' + formatTimeforServer(et) + '" data-ajax="false">';
				str += formatTime(st) + ' - ' + formatTime(et);
				str += '</a></li>';
			}

			str += '</ul></div></li>';
			$('#ulBlocks').append(str);
			$("#ulSlots" + blkid).listview();
			$("#ulSlots" + blkid).listview('refresh');
			$(".blk" + dte).hide();
	
}

MakeApptView.prototype.loadBlocks = function() {
	//Remove blocks shown in another calendar section.
	if ($(".blockssection")) {
		$(".blockssection").remove();
	}
	if ($(".calid" + gShownCalID + " .caltext")) {
		$(".calid" + gShownCalID + " .caltext").empty();
	}
	
	var str = "";
	if (gBlocks.length > 0) {
		str = '<div class="instructions">Select an available appointment slot.</div><div class="blockssection"><ul id="ulBlocks" data-role="listview"></ul></div>';
		$(".calid" + gShownCalID + " .caltext").append(str);
		$("#ulBlocks").listview();
	} else { //no blocks to show
		str = "No blocks available.";
		$(".calid" + gShownCalID + " .caltext").append(str);
	}

	var dt = null;
	str = "";
	for (var i=0; i < gBlocks.length; i++) {
		if (gBlocks[i] != null) {
			blkid = gBlocks[i].getBlockID();
			
			//show the date as a list divider
			var nextdate = gBlocks[i].getDte();
			if (dt == null || isDateBefore(dt,nextdate)) {
				var str = '<li data-role="list-divider" class="expandable date' + formatDateforServer(nextdate) + '">';
				str += '<a href="#" class="ui-icon ui-icon-plus" style="text-decoration:none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;';
				str += formatDate(nextdate) + '</li>';
				$('#ulBlocks').append(str);
				dt = nextdate;
			}
			
			this.drawBlockAndSlots(gBlocks[i]);
		}
	}
	$("#ulBlocks").listview('refresh');


	if ($(".expandable")) {
		$(".expandable").bind("click", function(event, ui) {
			//Get the date from the class id
			var clsarr = $(this).attr("class").split(" ");
			var idstr = $.grep(clsarr,function(value) {
				var search = new RegExp("date","gi");
				if(value.match(search)) return true;
				return false;
			});
			var id = idstr[0].substring(4);

			if ($(this).hasClass("disp_on")) {
				//hide the blocks/slots for the given date
				$('#ulBlocks').find(".blk" + id).each(function() {
					$(this).hide();
					$("."+idstr).removeClass("disp_on");
				});
				$(this).find("a").removeClass("ui-icon-minus");
				$(this).find("a").addClass("ui-icon-plus");	
			} else {
				//show all the blocks/slots for the given date
				$('#ulBlocks').find(".blk" + id).each(function() {
					$(this).show();
					$("."+idstr).addClass("disp_on");
				});
				$(this).find("a").removeClass("ui-icon-plus");
				$(this).find("a").addClass("ui-icon-minus");	
			}
		});
	}

	
	//reset
	gBlocks = [];
}

var makeapptview = new MakeApptView();
