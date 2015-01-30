/*var scrollInProgress = false;
$(document).bind('scrollstop', function(e){
//alert("scroll done!");
    e.stopPropagation();
    e.stopImmediatePropagation();    
    scrollInProgress = false;    
});
$(document).bind('scrollstart', function(e){
//alert("scrolling!");
    //e.stopPropagation();
   //e.stopImmediatePropagation();    
    scrollInProgress = true;    
});
$(document).bind('vmouseup', function(e){
//alert("vmouseup!");
	if (scrollInProgress) {
		e.preventDefault();
	}
});
$(document).bind('tap', function(e){
//alert(scrollInProgress);
	if (scrollInProgress) {
//alert("already scrolling!");
		e.preventDefault();
	}
   // e.stopPropagation();
   // e.stopImmediatePropagation();    
});
$(document).bind('vmousedown', function(e){
	console.log("vmousedown: " + scrollInProgress);
});*/

$.urlParam = function(name){
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
	if (results != null)
    	return results[1] || "";
	return "";
}

/********************************************************/
/*  Date and Time										*/
/********************************************************/

var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');

//Format Time (Input is string hh:mm:ss to output hh:mmam)
/*function FormatTime(inTimeString) {
	var str = "";
	if (inTimeString != null && inTimeString != "") {
		var hr = inTimeString.substr(0,2);
		var mn = inTimeString.substr(3,2);
		var sc = inTimeString.substr(6,2);
		var ampm = "am";
		if (hr >= 12) {
			ampm = "pm";
			hr = hr - 12;
		}
		if (hr == 0) hr = 12;
		str = hr + ":" + mn + ampm;
	}

	return str;
}*/

//mm/dd/yyyy
function formatDateShort(inDate) {
	var str = "";
	if (inDate != null && inDate != "") {
		var yr = inDate.getFullYear();
		var mo = inDate.getMonth()+1;
		var dt = inDate.getDate();
		str = mo + "/" + dt + "/" + yr;
	}
	return str;
}
//month date, year
function formatDate(inDate) {
	var str = "";
	if (inDate != null && inDate != "") {
		var yr = inDate.getFullYear();
		var mo = inDate.getMonth();
		var dt = inDate.getDate();
		str = months[mo] + " " + dt + ", " + yr;
	}
	return str;
}
//day of week, month date, year
function formatDateLong(inDate) {
	var str = "";
	if (inDate != null && inDate != "") {
		var dy = inDate.getDay();
		str = days[dy] + ", " + formatDate(inDate);
	}
	return str;
}
//month year
function formatDateMonthYear(inDate) {
	var str = "";
	if (inDate != null && inDate != "") {
		var mo = inDate.getMonth();
		var yr = inDate.getFullYear();
		str = months[mo] + " " + yr;
	}
	return str;
}
//day of week, Mo. date
function formatDateDayDate(inDate) {
	var str = "";
	if (inDate != null && inDate != "") {
		var dy = inDate.getDay();
		var mo = inDate.getMonth();
		var dt = inDate.getDate();
		str = days[dy] + ", " + months[mo].substr(0,3) + " " + dt;
	}
	return str;
}

function formatTime(inTime) {
	var str = "";
	if (inTime != null && inTime != "") {
		var hr = inTime.getHours();
		var mn = inTime.getMinutes();
		if (mn == 0) mn = "00";
		var sc = inTime.getSeconds();
		var ampm = "am";
		if (hr >= 12) {
			ampm = "pm";
			hr = hr - 12;
		}
		if (hr == 0) hr = 12;
		str = hr + ":" + mn + ampm;
	}
	return str;
}

function formatDateforServer(inDate) {
	var str = "";
	var strmn = (inDate.getMonth() + 1) + "";
	if (strmn.length < 2)
		strmn = "0" + strmn;
	var strdt = inDate.getDate() + "";
	if (strdt.length < 2)
		strdt = "0" + strdt;

	str += inDate.getFullYear() + "-" + strmn + "-" + strdt;
	return str;
}
function formatTimeforServer(inDate) {
	var str = "";
	var strmn = inDate.getMinutes() + "";
	if (strmn.length < 2)
		strmn = "0" + strmn;
	var strsec = inDate.getSeconds() + "";
	if (strsec.length < 2)
		strsec = "0" + strsec;
	var strhrs = inDate.getHours() + "";
	if (strhrs.length < 2)
		strhrs = "0" + strhrs;
	//str += strhrs + ":" + strmn + ":" + strsec;
	str += strhrs + ":" + strmn;
	return str;
}
//Input String is format yyyy-mm-dd, hh:mm:ss. inDate is javascript date if time should be "added to" that date.
function formatDateTimeFromServer(inDateStr,inTimeStr,inDate) {
	var date;
	if (inDate != null)
		date = new Date(inDate.getTime());
	else
		date = new Date();
		
	if (inDateStr != null && inDateStr != "") {
		var yr = inDateStr.substr(0,4);
		var mo = inDateStr.substr(5,2);
		mo = eval(mo) - 1; //month in javascript is 1 less, Jan = 0
		var day = inDateStr.substr(8,2);
		date = new Date(yr,mo,day,0,0,0);
	}
	if (inTimeStr != null && inTimeStr != "") {
		var hr = inTimeStr.substr(0,2);
		var mn = inTimeStr.substr(3,2);
		var sc = inTimeStr.substr(6,2);
		date.setHours(hr);
		date.setMinutes(mn);
		date.setSeconds(sc);
	}
	return date;
}



//To see if date 1 is earlier than date 2
function isDateBefore(inDate1, inDate2) {
	if (inDate1.getTime() < inDate2.getTime())
		return true;
	return false;
}
//To see if date 1 is same as date 2
function isDateSame(inDate1, inDate2) {
	if (inDate1.getFullYear() == inDate2.getFullYear() && inDate1.getMonth() == inDate2.getMonth() && inDate1.getDate() == inDate2.getDate())
		return true;
	return false;
}
//To see if a date is contained within a range
function isDateBetween(inDateTest,inDate1,inDate2) {
	if ((isDateBefore(inDate1,inDateTest) || isDateSame(inDate1,inDateTest)) && (isDateBefore(inDateTest,inDate2) || isDateSame(inDateTest,inDate2)))
		return true;
	return false;
}
//To see if time 1 is same as time 2
function isTimeSame(inTime1, inTime2) {
//	if (inTime1.getHours() == inTime2.getHours() && inTime1.getMinutes() == inTime2.getMinutes() && inTime1.getSeconds() == inTime2.getSeconds())
	if (inTime1.getHours() == inTime2.getHours() && inTime1.getMinutes() == inTime2.getMinutes())
		return true;
	return false;
}
//To see if time 1 is earlier than time 2 - assume that the date is the same, for now
function isTimeBefore(inTime1,inTime2) {
	if (inTime1.getHours() < inTime2.getHours() || (inTime1.getHours() == inTime2.getHours() && inTime1.getMinutes() <= inTime2.getMinutes()))
		return true;
	return false;
}



function isTrue(inVal) {
	if (inVal == "1" || inVal == "true" || inVal == true)
		return true;
	return false;
}
function isNullOrBlank(inVal) {
	if (inVal == null || $.trim(inVal) == "") {
		return true;
	}
	return false;
}



var inputMapVar = null;
function validateForm() {
	inputMapVar = $('input[name*="_r"]'); 
}



// Released under MIT license: http://www.opensource.org/licenses/mit-license.php
// Placeholder fix to make it show up in textareas.
$('[placeholder]').focus(function() {
  var input = $(this);
  if (input.val() == input.attr('placeholder')) {
    input.val('');
    input.removeClass('placeholder');
  }
}).blur(function() {
  var input = $(this);
  if (input.val() == '' || input.val() == input.attr('placeholder')) {
    input.addClass('placeholder');
    input.val(input.attr('placeholder'));
  }
}).blur().parents('form').submit(function() {
  $(this).find('[placeholder]').each(function() {
    var input = $(this);
    if (input.val() == input.attr('placeholder')) {
      input.val('');
    }
  })
});


//SafeHTML
function safeHTML(inText) {
	var str = "";
	str = htmlentities(inText,'ENT_NOQUOTES');
	
	//11-1-2009. For allowing certain HTML markup.
	var okescapednum = new Array('&#60;b&#62;','&#60;/b&#62;','&#60;i&#62;','&#60;/i&#62;','&#60;em&#62;','&#60;/em&#62;','&#60;strong&#62;','&#60;/strong&#62;','&#60;p&#62;','&#60;/p&#62;','&#60;br&#62;','&#60;br/&#62;','&#60;br /&#62;','"','&#');
	var okescaped = new Array('&lt;b&gt;','&lt;/b&gt;','&lt;i&gt;','&lt;/i&gt;','&lt;em&gt;','&lt;/em&gt;','&lt;strong&gt;','&lt;/strong&gt;','&lt;p&gt;','&lt;/p&gt;','&lt;br&gt;','&lt;br/&gt;','&lt;br /&gt;','"','&amp;#');
	var okhtml = new Array('<b>','</b>','<i>','</i>','<em>','</em>','<strong>','</strong>','<p>','</p>','<br>','<br/>','<br />','&quot;','&#');
	
	for (var i=0; i < okescaped.length; i++) {
		str = str.replace(okescapednum[i],okhtml[i]);
		str = str.replace(okescaped[i],okhtml[i]);
	}

	return str;
}

function safeHTMLJS(inText) {
	return addslashes(inText);
}

function htmlentities (string, quote_style) {
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: nobbler
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // -    depends on: get_html_translation_table
    // *     example 1: htmlentities('Kevin & van Zonneveld');
    // *     returns 1: 'Kevin &amp; van Zonneveld'
 
    var histogram = {}, symbol = '', tmp_str = '', entity = '';
    tmp_str = string.toString();
    
    if (false === (histogram = get_html_translation_table('HTML_ENTITIES', quote_style))) {
        return false;
    }
    
    for (symbol in histogram) {
        entity = histogram[symbol];
        tmp_str = tmp_str.split(symbol).join(entity);
    }
    
    return tmp_str;
}

function get_html_translation_table(table, quote_style) {
    // http://kevin.vanzonneveld.net
    // +   original by: Philip Peterson
    // +    revised by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   bugfixed by: noname
    // %          note: It has been decided that we're not going to add global
    // %          note: dependencies to php.js. Meaning the constants are not
    // %          note: real constants, but strings instead. integers are also supported if someone
    // %          note: chooses to create the constants themselves.
    // %          note: Table from http://www.the-art-of-web.com/html/character-codes/
    // *     example 1: get_html_translation_table('HTML_SPECIALCHARS');
    // *     returns 1: {'"': '&quot;', '&': '&amp;', '<': '&lt;', '>': '&gt;'}
    
    var entities = {}, histogram = {}, decimal = 0, symbol = '';
    var constMappingTable = {}, constMappingQuoteStyle = {};
    var useTable = {}, useQuoteStyle = {};
    
    useTable      = (table ? table.toUpperCase() : 'HTML_SPECIALCHARS');
    useQuoteStyle = (quote_style ? quote_style.toUpperCase() : 'ENT_COMPAT');
    
    // Translate arguments
    constMappingTable[0]      = 'HTML_SPECIALCHARS';
    constMappingTable[1]      = 'HTML_ENTITIES';
    constMappingQuoteStyle[0] = 'ENT_NOQUOTES';
    constMappingQuoteStyle[2] = 'ENT_COMPAT';
    constMappingQuoteStyle[3] = 'ENT_QUOTES';
    
    // Map numbers to strings for compatibilty with PHP constants
    if (!isNaN(useTable)) {
        useTable = constMappingTable[useTable];
    }
    if (!isNaN(useQuoteStyle)) {
        useQuoteStyle = constMappingQuoteStyle[useQuoteStyle];
    }
    
    if (useQuoteStyle != 'ENT_NOQUOTES') {
        entities['34'] = '&quot;';
    }
 
    if (useQuoteStyle == 'ENT_QUOTES') {
        entities['39'] = '&#039;';
    }
 
    if (useTable == 'HTML_SPECIALCHARS') {
        // ascii decimals for better compatibility
        entities['38'] = '&amp;';
        entities['60'] = '&lt;';
        entities['62'] = '&gt;';
    } else if (useTable == 'HTML_ENTITIES') {
        // ascii decimals for better compatibility
      entities['38']  = '&amp;';
      entities['60']  = '&lt;';
      entities['62']  = '&gt;';
      entities['160'] = '&nbsp;';
      entities['161'] = '&iexcl;';
      entities['162'] = '&cent;';
      entities['163'] = '&pound;';
      entities['164'] = '&curren;';
      entities['165'] = '&yen;';
      entities['166'] = '&brvbar;';
      entities['167'] = '&sect;';
      entities['168'] = '&uml;';
      entities['169'] = '&copy;';
      entities['170'] = '&ordf;';
      entities['171'] = '&laquo;';
      entities['172'] = '&not;';
      entities['173'] = '&shy;';
      entities['174'] = '&reg;';
      entities['175'] = '&macr;';
      entities['176'] = '&deg;';
      entities['177'] = '&plusmn;';
      entities['178'] = '&sup2;';
      entities['179'] = '&sup3;';
      entities['180'] = '&acute;';
      entities['181'] = '&micro;';
      entities['182'] = '&para;';
      entities['183'] = '&middot;';
      entities['184'] = '&cedil;';
      entities['185'] = '&sup1;';
      entities['186'] = '&ordm;';
      entities['187'] = '&raquo;';
      entities['188'] = '&frac14;';
      entities['189'] = '&frac12;';
      entities['190'] = '&frac34;';
      entities['191'] = '&iquest;';
      entities['192'] = '&Agrave;';
      entities['193'] = '&Aacute;';
      entities['194'] = '&Acirc;';
      entities['195'] = '&Atilde;';
      entities['196'] = '&Auml;';
      entities['197'] = '&Aring;';
      entities['198'] = '&AElig;';
      entities['199'] = '&Ccedil;';
      entities['200'] = '&Egrave;';
      entities['201'] = '&Eacute;';
      entities['202'] = '&Ecirc;';
      entities['203'] = '&Euml;';
      entities['204'] = '&Igrave;';
      entities['205'] = '&Iacute;';
      entities['206'] = '&Icirc;';
      entities['207'] = '&Iuml;';
      entities['208'] = '&ETH;';
      entities['209'] = '&Ntilde;';
      entities['210'] = '&Ograve;';
      entities['211'] = '&Oacute;';
      entities['212'] = '&Ocirc;';
      entities['213'] = '&Otilde;';
      entities['214'] = '&Ouml;';
      entities['215'] = '&times;';
      entities['216'] = '&Oslash;';
      entities['217'] = '&Ugrave;';
      entities['218'] = '&Uacute;';
      entities['219'] = '&Ucirc;';
      entities['220'] = '&Uuml;';
      entities['221'] = '&Yacute;';
      entities['222'] = '&THORN;';
      entities['223'] = '&szlig;';
      entities['224'] = '&agrave;';
      entities['225'] = '&aacute;';
      entities['226'] = '&acirc;';
      entities['227'] = '&atilde;';
      entities['228'] = '&auml;';
      entities['229'] = '&aring;';
      entities['230'] = '&aelig;';
      entities['231'] = '&ccedil;';
      entities['232'] = '&egrave;';
      entities['233'] = '&eacute;';
      entities['234'] = '&ecirc;';
      entities['235'] = '&euml;';
      entities['236'] = '&igrave;';
      entities['237'] = '&iacute;';
      entities['238'] = '&icirc;';
      entities['239'] = '&iuml;';
      entities['240'] = '&eth;';
      entities['241'] = '&ntilde;';
      entities['242'] = '&ograve;';
      entities['243'] = '&oacute;';
      entities['244'] = '&ocirc;';
      entities['245'] = '&otilde;';
      entities['246'] = '&ouml;';
      entities['247'] = '&divide;';
      entities['248'] = '&oslash;';
      entities['249'] = '&ugrave;';
      entities['250'] = '&uacute;';
      entities['251'] = '&ucirc;';
      entities['252'] = '&uuml;';
      entities['253'] = '&yacute;';
      entities['254'] = '&thorn;';
      entities['255'] = '&yuml;';
    } else {
        throw Error("Table: "+useTable+' not supported');
        return false;
    }
    
    // ascii decimals to real symbols
    for (decimal in entities) {
        symbol = String.fromCharCode(decimal)
        histogram[symbol] = entities[decimal];
    }
    
    return histogram;
}