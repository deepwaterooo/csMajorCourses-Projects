// pageheader.js draws the header bar for the page (title, etc.)

//figure out the page title, user ID
var sPageTitle = "";
if (GetElement("hidPageTitle") != null)
{
	sPageTitle = GetElement("hidPageTitle").value;
	if ( GetElementCheck("hidMakeApp", "makeapp") == 1 )
		sPageTitle = "Select Appointment Slot";
}
var sPageSubtitle = ""; //Note, not every page has a subtitle
if (GetElement("hidPageSubtitle") != null)
	sPageSubtitle = GetElement("hidPageSubtitle").value;
var sUserID = document.sUserID;
/*var sUserID = "";
if (GetElement("hidUserID") != null)
	sUserID = GetElement("hidUserID").value;*/
var sTab = "";
if (GetElement("hidTab") != null)
	sTab = GetElement("hidTab").value;

var sHTML = '';
sHTML += '<div id="pageHeader">';
sHTML += '<div id="pageTitle"><span class="pageTitle">' + sPageTitle;
if (sPageSubtitle != "") {
	sHTML += ': </span><span class="pageSubtitle">' + sPageSubtitle;
}
sHTML += '</span></div>';
/*if (isAuthenticated()) {
	if (sUserID == "") sUserID = "Guest";
	sHTML += '<div id="welcome"><span class="small" >Welcome, ' + safeHTML(sUserID);	
	sHTML += ' <a href="logout.page.php">';
	sHTML += 'Log Out</a></span></div>';
}*/
sHTML += '</div>';
document.write(sHTML);

