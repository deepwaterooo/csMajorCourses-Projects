// footer.js draws the footer

//Get contact information
var contactname = "";
if (GetElement("hidContactName") != null)
	contactname = GetElement("hidContactName").value;
var contactemail = "";
if (GetElement("hidContactEmail") != null)
	contactemail = GetElement("hidContactEmail").value;
var contactphone = "";
if (GetElement("hidContactPhone") != null)
	contactphone = GetElement("hidContactPhone").value;
var insfname = "";
if (GetElement("hidInsFname") != null)
	insfname = GetElement("hidInsFname").value;

var sHTML = '';
sHTML += '<div id="footer">&copy; 2010 The Trustees of ' + insfname + ' <br>';
sHTML += 'Send questions/comments to ' + contactname + '. ';
sHTML += 'E-mail: <a href="mailto:' + contactemail + '?subject=Scheduling%20System%20Question/Comment">' + contactemail + '</a>&nbsp;';
sHTML += 'Tel: ' + contactphone + '.';
if (document.g_sHomeLink != null && document.g_sHomeLink != "null" && document.g_sHomeLink != "") {
	if (document.g_sHomeLogo == "null" || document.g_sHomeLogo == "")
		document.g_sHomeLogo = "homelogo.gif";
	sHTML += '<div id="homelink"><a href="' + document.g_sHomeLink + '"><img src="images/' + document.g_sHomeLogo + '" border="0"></a></div>';
}
sHTML += '</div>';
document.write(sHTML);

