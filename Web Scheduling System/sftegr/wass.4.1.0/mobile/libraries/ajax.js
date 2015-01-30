//Generic function that creates the AJAX XML string
//	Inputs:		inCallName: the XML element
//				inVars: array of key/values for tag name and value
//  Outputs:	xmlstr: the XML string
function createXML(inCallName,inVars) {
	var xmlstr = "<" + inCallName + ">";
	xmlstr += "<sessionid>" + g_sessionid + "</sessionid>";
	//loop over vars in array and append
	$.each(inVars, function(key, value) {
		xmlstr += "<" + key + ">" + value + "</" + key + ">";
	});
	xmlstr += "</" + inCallName + ">";
	return xmlstr;
}

function readErrorXML($xml) {
	var er = null;
	$errorcode = $xml.find("errorcode");
	$errortext = $xml.find("errortext");
	var errc = $errorcode.text();
	if (errc != "" && errc != "0") {
		err = parseInt(errc);
		er = new Error(errc,$errortext.text());
	}
	//if(er != null) alert("error! " + er.getErrCode() + ": " + er.getErrText());
	return er;
}

function readUserInfoXML($xml) {
	var usr = null;
	$userid = $xml.find("userid");
	$name = $xml.find("name");
	$phone = $xml.find("phone");
	$email = $xml.find("email");
	$office = $xml.find("office");
	usr = new User($userid.text(),$name.text(),$phone.text(),$email.text(),$office.text());
	return usr;
}

function readSlotXML($xml) {
	var slt = null;
	$strxml = $xml;
	$blockid = $strxml.find("blockid");
	$date = $strxml.find("date");
	$starttime = $strxml.find("starttime");
	$endtime = $strxml.find("endtime");
	slt = new Slot($blockid.text(),$date.text(),$starttime.text(),$endtime.text());
	return slt;
}

function readCalendarHeaderXML($xml) {
	var cal = null;
	$id = $xml.find("calendarid");
	$title = $xml.find("title");
	$desc = $xml.find("description");
	var owner = null;
	$xml.find("owner").each(function() {
		owner = readUserInfoXML($(this));
	});
	cal = new WASPCalendarHeader($id.text(),$title.text(),$desc.text(),owner);
	return cal;
}

function readBlockHeaderXML($xml) {
	var blk = null;
	$strxml = $xml;
	$id = $strxml.find("blockid");
	$seriesid = $strxml.find("seriesid");
	$title = $strxml.find("title");
	$desc = $strxml.find("description");
	$date = $strxml.find("date");
	$loc = $strxml.find("location");
	var owner = null;
	$strxml.find("blockowner").each(function() {
		owner = readUserInfoXML($(this));
	});
	blk = new BlockHeader($id.text(),$seriesid.text(),$title.text(),$desc.text(),$date.text(),$loc.text(),owner);
	return blk;
}

function readBlockXML($xml) {
	var blk = null;
	$strxml = $xml;
	//$xml.find("block").each(function() {
		$id = $strxml.find("blockid");
		$seriesid = $strxml.find("seriesid");
		$title = $strxml.find("title");
		$desc = $strxml.find("description");
		$date = $strxml.find("date");
		$loc = $strxml.find("location");
		var owner = null;
		$strxml.find("blockowner").each(function() {
			owner = readUserInfoXML($(this));
		});
		
		$starttime = $strxml.find("starttime");
		$endtime = $strxml.find("endtime");
		$slotsize = $strxml.find("slotsize");
		$maxapptsperslot = $strxml.find("maxapptsperslot");
		$maxapptsperperson = $strxml.find("maxapptsperperson");
		$purreq = $strxml.find("purreq");
		$available = $strxml.find("available");
		$every = $strxml.find("every");
		$enddate = $strxml.find("enddate");		
		$daytypes = $strxml.find("daytypes");
		
		var nr = null;
		$strxml.find("notifyandremind").each(function() {
			$notifyown = $(this).find("notifyown");
			$notifyman = $(this).find("notifyman");
			$notifymem = $(this).find("notifymem");
			$remindown = $(this).find("remindown");
			$remindman = $(this).find("remindman");
			$remindmem = $(this).find("remindmem");
			$apptmsg = $(this).find("apptmsg");			
		});
		nr = new NotifyAndRemind($notifyown.text(),$notifyman.text(),$notifymem.text(),$remindown.text(),$remindman.text(),$remindmem.text(),$apptmsg.text());
		
		$opening = $strxml.find("opening");
		$deadline = $strxml.find("deadline");
		$candeadline = $strxml.find("candeadline");
		
		var ar = null;
		var vu = null;
		var mu = null;
		$strxml.find("accessrestrictions").each(function() {
			$viewaccess = $(this).find("viewaccess");
			$viewulist = $(this).find("viewulist");
			vu = $viewulist.text().split(",");
			$viewclist = $(this).find("viewclist");
			$makeaccess = $(this).find("makeaccess");
			$makeulist = $(this).find("makeulist");
			mu = $viewulist.text().split(",");
			$makeclist = $(this).find("makeclist");
			$showappinfo = $(this).find("showappinfo");
		});
		
		ar = new AccessRestrictions($viewaccess.text(),$viewclist.text(),$makeaccess.text(),$makeclist.text(),$showappinfo.text());
		for(var i=0; i < vu.length; i++) {
			ar.addUser("view",vu[i]);
		}
		for(i=0; i < mu.length; i++) {
			ar.addUser("make",mu[i]);
		}
		
		blk = new Block($id.text(),$seriesid.text(),$title.text(),$desc.text(),$date.text(),$loc.text(),owner,$starttime.text(),$endtime.text(),$slotsize.text(),$maxapptsperslot.text(),$maxapptsperperson.text(),$purreq.text(),$available.text(),$every.text(),$enddate.text(),$daytypes.text(),nr,$opening.text(),$deadline.text(),$candeadline.text(),ar);

		$strxml.find("periods").each(function() {
			$periodid = $(this).find("periodid");
			$starttime = $(this).find("starttime");
			$endtime = $(this).find("endtime");
			$dayofweek = $(this).find("dayofweek");
			$dayofmonth = $(this).find("dayofmonth");
			$weekofmonth = $(this).find("weekofmonth");
			var pd = new Period($periodid.text(),$starttime.text(),$endtime.text(),$every.text(),$dayofweek.text(),$dayofmonth.text(),$weekofmonth.text());
			blk.addPeriod(pd);
		});
		
	//});
	return blk;
}

function readApptXML($xml) {
	var appt = null;
	$strxml = $xml;
	$apptid = $strxml.find("appointmentid");
	$date = $strxml.find("date");
	$blockid = $strxml.find("blockid");
	$calendarid = $strxml.find("calendarid");
	$starttime = $strxml.find("starttime");
	$endtime = $strxml.find("endtime");
	
	//apptmaker
	var apptmaker = null;
	$strxml.find("apptmaker").each(function() {
		apptmaker = readUserInfoXML($(this));
	});
			
	$purpose = $strxml.find("purpose");
	$remind = $strxml.find("remind");
	$textemail = $strxml.find("textemail");
	$whenmade = $strxml.find("whenmade");
	$madeby = $strxml.find("madeby");
	$available = $strxml.find("available");

	appt = new Appointment($apptid.text(), $date.text(), $starttime.text(), $endtime.text(), apptmaker, $blockid.text(), $calendarid.text(), $purpose.text(), $remind.text(), $textemail.text(), $whenmade.text(), $madeby.text(), $available.text());
	return appt;
}

function readCalendarDateInfoXML($xml) {
	var caldate = null;
	$date = $xml.find("date");
	var dt = null;
	if ($date != null) dt = formatDateTimeFromServer($date.text());
	$daytype = $xml.find("daytype");
	$daytypeabbv = $xml.find("daytypeabbv");
	$status = $xml.find("status");
	
	caldate = new CalDate(dt, $daytype.text(), $daytypeabbv.text(), $status.text());
	return caldate;
}



function DoAJAX(inDatastring, inURL, inCallBack) {
	$.ajax({
		/*beforeSend: function() { $.mobile.showPageLoadingMsg(); },
		complete: function() { $.mobile.hidePageLoadingMsg() },*/
		type: "POST",
		url: inURL,
		dataType: "xml",
		data: inDatastring,
		success: inCallBack
	});
}