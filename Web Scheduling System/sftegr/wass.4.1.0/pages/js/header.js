// header.js draws the header with main menu tabs

var sHTML = '';
sHTML += '<div id="header">';
sHTML += '<div id="headerimage"><img src="../pages/images/logo.jpg" alt="logo" width="52" height="45" border="0" /></div>';
sHTML += '<div id="headertitle">' + document.g_sysID + '</div>';

var sUserID = document.sUserID;
if(isAuthenticated()) {
	if (sUserID == "") sUserID = "Guest";
	//sHTML += '<div id="welcome"><span class="small" >Welcome, ' + safeHTML(sUserID);	
	sHTML += '<div id="welcome">' + sUserID;	
	sHTML += '<a class="small" href="logout.page.php">';
	sHTML += 'Log Out</a></div>';
}
sHTML += '</div>';
document.write(sHTML);

