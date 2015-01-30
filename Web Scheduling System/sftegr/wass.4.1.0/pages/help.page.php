<?php
/*
Copyright 2006, 2008 The Trustees of Princeton University.

For licensing terms, see the license.txt file in the admin directory.

Written by: Serge J. Goldstein, serge@princeton.edu.
            Kelly D. Cole, kellyc@princeton.edu
			Jill Moraca, jmoraca@princeton.edu
		   
*/


/*

       This page presents help text.
 
*/




/* Handle loading of classes. */
function __autoload($class) {
	/* Set path to wassParms and wassLocal */
	if (($class == 'wassParms') || ($class == 'wassLocal'))
		$parmspath = getenv('WASSPARMS');
	if (!$parmspath)
		$parmspath = '../classes/';
		
	/* Now load the class */ 
	if ($class != 'wassLocal')
		require_once($parmspath.$class.'.class.php');
	else
		@include_once($parmspath.$class.'.class.php');
	
}/* Make sure we are up and running; if not, terminate with an error message. */
wassUtil::OnOff();

/* Start session support */
session_start();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Web Appointment Scheduling System - Help</title>
<script type="text/javascript" language="javascript">
document.g_sOldTopic = "";
function showTopic(inTopic) {
	//hide any open topics
	if (document.g_sOldTopic != "") {
		var oldhelp = document.getElementById(document.g_sOldTopic);
		if (oldhelp != null) oldhelp.style.display = "none";
	}
/**KDC,12-12-2007. This doesn't work in IE.  IE views names/ids the same.  Rewrote above.**/
/*	var divs = document.getElementsByName("divHelp");
	for (var i=0; i < divs.length; i++) {
		divs[i].style.display = "none";
	}
*/
	//open the new topic
	var topic = document.getElementById(inTopic);
	if (topic != null) topic.style.display = "block";
	document.g_sOldTopic = inTopic;
}
function init() {
	var el = document.getElementById("helptopic");
	if (el.value != "")
		showTopic(el.value);
}
</script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-weight: bold}
-->
</style>
</head>

<body onload="init();">
<form id="frmMain" name="frmMain" action="" method="post">
<input type="hidden" id="helptopic" name="helptopic" value="<?php echo trim($_REQUEST['helptopic']);?>" />

<div id="smallWindowIcon"><img src="images/logo.jpg" alt="logo" width="52" height="45"/></div>
<div id="smallWindowTitle">Help</div>


<!-- must put the helptopic value as a parameter to showTopic (which matches the div name below) -->
<div class="leftHelp">
	<div id="helplist">
		<ul id="helplist">
			<li><a href="#" onclick="showTopic('start');return false;">Introduction</a></li>
			<li><a href="#" onclick="showTopic('login');return false;">Log In</a></li>
			<li><a href="#" onclick="showTopic('makeappoint');return false;">Make an Appointment</a></li>
			<li><a href="#" onclick="showTopic('makeapp');return false;">Select Appointment Date and Time</a></li>
            <li style="padding-top: 7px; padding-bottom: 7px;">View Calendar</li>
            	<ul id="subhelplist">
					<li><a href="#" onclick="showTopic('view');return false;">Overview</a></li>
					<li><a href="#" onclick="showTopic('appointment');return false;">Appointments</a></li>					
                    <li><a href="#" onclick="showTopic('block');return false;">Select Block</a></li>
					<li><a href="#" onclick="showTopic('ownerblock');return false;">Edit Block</a></li>
                    <li><a href="#" onclick="showTopic('delblock');return false;">Delete Block</a></li>
                    <li><a href="#" onclick="showTopic('links');return false;">Direct Links</a></li>
                </ul>
			<li><a href="#" onclick="showTopic('search');return false;">Search Appointments</a></li>
			<li><a href="#" onclick="showTopic('manage');return false;">Manage Calendars</a></li>
			<li style="padding-top: 7px; padding-bottom: 7px;">Calendar Setup</li>
				<ul id="subhelplist">
					<li id="subactive"><a href="#" onclick="showTopic('basic');return false;">Basic</a></li>
					<li><a href="#" onclick="showTopic('advanced');return false;">Access Restrictions</a></li>
                    <li><a href="#" onclick="showTopic('groupcal');return false;">Group Calendars</a></li>
					<li><a href="#" onclick="showTopic('remove');return false;">Remove Calendar</a></li>
					<li><a href="#" onclick="showTopic('apply');return false;">Apply to Manage</a></li>
					<li><a href="#" onclick="showTopic('calmanage');return false;">Calendar's Manager(s)</a></li>
                    <li><a href="#" onclick="showTopic('calmember');return false;">Group Calendar's Member(s)</a></li>
                    <li><a href="#" onclick="showTopic('subscribe');return false;">Subscribe to a Calendar</a></li>
                    <li><a href="#" onclick="showTopic('advertise');return false;">Advertise a Calendar</a></li>
                    <li><a href="#" onclick="showTopic('subscriberss');return false;">Subscribe to a Calendar as RSS feed</a></li>
				</ul>
			<li style="padding-top: 7px; padding-bottom: 7px;">Add Block</li>
				<ul id="subhelplist">
					<li><a href="#" onclick="showTopic('onetime');return false;">One-Time</a></li>
					<li><a href="#" onclick="showTopic('recurring');return false;">Recurring</a></li>
                    <li><a href="#" onclick="showTopic('deadlines');return false;">Deadlines</a></li>
                    <li><a href="#" onclick="showTopic('badvanced');return false;">Access Restrictions</a></li>
					<li><a href="#" onclick="showTopic('showappinfo');return false;">Show Appointment Details</a></li>
					<li><a href="#" onclick="showTopic('advertiseblock');return false;">Advertise a Block</a></li>
				</ul>
		</ul>
	</div>
</div>




<!-- div id is helptopic value, div name must be "divHelp" -->
<div class="rightHelp" id="start" name="divHelp" style="display:none;">
	<h2>Introduction</h2>
	<p>The <?php echo wassParms::SYSID;?> allows people to schedule appointments over the Web. People with whom appointments are made (e.g., people who hold office hours) create a calendar in the system and list their available times on that calendar. People who want to make appointments can then locate that calendar and make an appointment.</p>
	<p>Anyone with a <?php echo wassParms::NETID;?> can create a calendar.  Once created, calendar owners can add blocks of time to that calendar to indicate when they are available for appointments. These blocks of time can be divided into individual appointment slots, or the whole block can be left unslotted and managed on a first-come, first-served basis. When a block of available time is added to a calendar, the calendar owner can restrict who is allowed to schedule appointments during that block of time.</p>
    <p>A calendar owner can designate one or more people to serve as calendar "managers" for the calendar.  Managers have the same rights as the owner, and they can add and remove blocks of available time or add and remove appointments.</p>
    <p>A calendar owner can create more than one calendar.  Each calendar has its own unique URL, and each can be separately advertised to potential appointment recipients.  For example, a professor might have one calendar on which she lists office hour appointments for her undergraduate classes, and another on which she lists office hours for her graduate classes.  Or someone might want to create a calendar for an organization that they manage, or for a piece of equipment that they run, or for any other entity that is available for limited periods of time.  It is also possible to create a "Group Calendar" which is shared by a number of people.</p>
	<p>People who want to make appointments with a calendar owner can look up the specific calendar in the system, find a block of time when the calendar owner, or calendar member in the case of a Group Calendar, is available for appointments, and schedule an appointment.  People do not need to create a calendar in the system to make appointments.  They
     only need to create a calendar if they want people to be able to make appointments with them (e.g., they hold office hours).</p>
	<p>The system uses e-mail to notify and remind people of pending appointments.  Appointments can be cancelled with or without e-mail notification.  The calendar owner can check the calendar at any time to see if s/he has pending appointments, and users who have made appointments can see a list of their pending appointments.
    It is also possible to synchronize appointments in the system with a local calendaring application, such as Outlook or iCal.</p>
</div>
<div class="rightHelp" id="login" name="divHelp" style="display:none;">
	<h2>Log In</h2>
	<p>To use the <?php echo wassParms::SYSID;?> you must first identify yourself, either by clicking the Log In button and entering a <?php echo wassParms::NETID;?> and <?php echo wassParms::PASSNAME;?>, or, if you are a guest (not a member of the <?php echo wassParms::INSNAME;?> community), by entering your e-mail address and clicking the Guest Log In button.</p>
	<p>Once you have logged in, you will be able to make appointments with people who have created calendars in the system, or you can create and manage your own calendars and enable people to make appointments with you.  Note that to create and/or manage a calendar, you must login with a  <?php echo wassParms::NETID;?>. Guests cannot create or manage calendars, but they are able to make appointments on calendars set to permit guests.</p>
</div>
<div class="rightHelp" id="makeappoint" name="divHelp" style="display:none;">
	<h2>Make an Appointment</h2>
	<p>To make an appointment, first locate the calendar of the person with whom you wish to make the appointment.  To do that, click the "Make an Appointment" menu button, then enter the person's name or <?php echo wassParms::NETID;?> or calendar title in the appropriate box, then click the "Search" button. If the search is successful, then a list of all matching calendars will be displayed, and you can click on the "Make Appointment With" link for the desired calendar.  This will cause the calendar to be be displayed.  You can also use the "browse" links to display a list of all calendars, sorted either by first name,  <?php echo wassParms::NETID;?>, or calendar title, and then select a calendar from the displayed list.
</p>
<?php if ($_SESSION['ismanager'] || $_SESSION['owner']) {?> 
<p>
[Note:  The "Make Apppointment" page also displays entries corresponding to any calendars you own and for which are a member or that you manage. To add an appointment to one of these calendars, simply click its corresponding "Make Appointment" link.]
</p>
<?php
}?>
</div>
<div class="rightHelp" id="makeapp" name="divHelp" style="display:none;">
	<h2>Select Appointment Date and Time</h2>
    <p>
Once you have located the calendar on which you want to make an appointment, you then select a date and time when the calendar owner is available for appointments.  On the calendar display,  a set of small calendars in the left-hand navigation bar shows an overview of a calendar in two-month increments. Days with available time(s) are  shown in orange. Click on the date to display that day in the main calendar view. You can also set the main calendar view to "Week" or "Month" to quickly locate a day on which the calendar owner is available.  The blocks of available time are then displayed directly on the main calendar view, again in orange, with any appointments that have already been scheduled. 
</p>
<p>
Calendar owners can divide blocks of available time into individual appointment slots, or they can treat the entire block as a single, first-come, first-served appointment period. This will be obvious from the display. To make an appointment, simply click on the "+" sign corresponding to the appointment time you want. You will be shown a form where you can fill in additional information about yourself and the appointment. If the block of time is divided into individual appointment slots, and if the calendar owner allows it, you can select multiple consecutive periods of time if you want a longer appointment. Once made, both you and the calendar owner will be notified of the appointment via e-mail.
</p>
</div>
<div class="rightHelp" id="search" name="divHelp" style="display:none;">
	<h2>Search Appointments</h2>
	<p>The Search Appointments page allows you to search for any appointments you have made (or that someone has made on your behalf), or any appointments that people have made with you.  The page displays a set of fields which allow you to restrict the search by various criteria.  When the page is initially displayed, the fields are filled in on the assumption that you want to search for all of your appointments from today on.  If that is the case, simply click the "Search" button at the bottom of the page, and a list of your appointments will be returned.  If you want to limit the search to specific date ranges, or to specific calendars (e.g., based on the person with whom you have made the appointment), simply fill in or select the appropriate field on the form, then click the "Search" button. If you own or manage a calendar, and want to see appointments that have been made with you by a specific person, enter their <?php echo wassParms::NETID;?> (or name) in the "Appointment by" field on the form, then click the "Search" button.</p>
	<p>The displayed list of appointments will provide details about the appointment(s), and also allow you to cancel the appointment(s), if you wish.  You can also print the displayed list, or export it into a CSV (comma-separated) file.  If no appointments are found, a message to that effect will be displayed.</p>
</div>
<div class="rightHelp" id="manage" name="divHelp" style="display:none;">
	<h2>Manage Calendars</h2>
	<p>If you have one or more calendars in the system, or if you manage one or more calendars, those calendars will be listed on the Manage Calendars page.  To view a calendar, click on its title (in the "Calendar Title" column of the display).  If you own or manage multiple calendars, you can view multiple calendars simultaneously by checking the boxes next to the calendar titles, then clicking the "View Calendar(s)" button.
    </p>
	 <p>If you wish to make global changes to a calendar, you should check the box next to the calendar's title and click the "Calendar Setup" button on the left-hand menu.  Changes you can make include changing the title of the calendar, adding or removing calendar managers, changing block defaults, and changing settings for e-mail notifications and reminders.  You can also delete a calendar or create a new calendar.</p>
	 <p>Changes you make to settings in Calendar Setup, such as a different location, apply to blocks that are added to the calendar subsequent to the change.  However, when you make such a change, you will be prompted as to whether or not you wish to have these changes propagated to existing blocks as well.</p>
	  <p>If you do not have a calendar in the system, and you wish to create one, click on the "Create Calendar" button on the left-hand menu.  This will take you to a form where you can fill in the particulars about your calendar.  You should only create a calendar if you want people to be able to make appointments with you.  You do not need to create a calendar if you simply wish to make appointments with calendar owners.  Once you have created a calendar, you can use it to schedule your appointments; you do not need to delete and recreate your calendar each time you want to use it.</p>
      <p>If you want to create additional calendars, click on the "Calendar Setup" button associated with any one of your existing calendars, then, in the Calendar Setup page, click on the "Go" button in the "Create Additional Calendar" panel (displayed on the right-hand side of the page).
	 </p> 
</div>
<!-- Calendar Setup -->
<div class="rightHelp" id="basic" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Basic</h2>
	<p>The Calendar Setup form lets you create or edit a calendar, and set default values that will be used when you add blocks of available time to your calendar.  If you are creating a calendar, many of the fields will have been filled in based on your Directory entry, but you can modify any of these fields.  You must specify (or use the default) calendar title, your name, your telephone number and your e-mail address.  You can optionally enter a description of your calendar (people making appointments will see this description, along with the calendar's title and your contact information).</p>
    <p>You can create a calendar for a group by checking the "Group Calendar" box in Calendar Setup.   Group calendars have specialized uses. See the Group Calendar entry in Help for details. (Before clicking the Group Calendar checkbox, be sure you understand what group calendars are and how they work).</p>
<p>If you wish, you can designate one or more "managers" for your calendar.  Calendar managers can do everything you can do with your calendar (view/schedule/cancel appointments).  To add or remove managers, click on the "Go" button associated with the "Calendar's Managers" panel on the right side of the page.</p>
<p>You can control whether you and/or your calendar managers receive e-mail notifications or reminders by setting the appropriate checkboxes in Calendar Setup. Notifications are sent out at the time an appointment is made or cancelled. Reminders are sent out one day prior to the scheduled appointment.  You can also set notifications and reminders individually for each calendar manager by clicking the "Go" button in the "Calendar Managers" panel.</p>
 </p>
</div>
<div class="rightHelp" id="advanced" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Access Restrictions</h2>
	<p>If you click the "Show" link next to "Access Restrictions", you will be shown two fields, "View Calendar" and "Make Appointments," which allow you to control who can view your calendar and/or make appointments.  These settings are used as defaults when you add blocks to your calendar (you can override them on a block-by-block basis). 
    <p><strong>Open</strong><br />You can set either field to "Open," which allows access to anyone at all.</p>
    <p><strong>Limited</strong><br />By default, both fields are set to "Limited," which means that anyone with a <?php echo wassParms::NETID;?> can view 
    your calendar blocks and/or schedule an appointment.</p>    
    <p><strong>Restricted</strong><br />Setting either field to "Restricted" brings up additional fields which allow you to list the users <?php if (wassParms::COURSELIM) {?>and/or courses <?php }?>which are allowed access to the calendar blocks. <?php if (wassParms::COURSELIM) {?>To enter a course name you will need use the Blackboard Course ID (ex. SPA101_F2009). <br />
<br />
To locate a Blackboard Course ID, log into <a href="https://blackboard.princeton.edu" target="_blank">Blackboard</a> and locate the course in the "My Courses (sortable)" module. The Course ID will be prepended to the course name. For example, if your course is listed as SPA101_F2009 Beginner's Spanish I, the Course ID is SPA101_F2009. Note that there will be an underscore (_) between the course code (SPA101)and the semester/year code (F2009). It is important to include this underscore, and to not have spaces in the Course ID, when you enter it.<?php }?></p>    
    <p><strong>Private</strong><br />Setting either field to "Private" limits access to only you and your calendar managers, if any.  This allows you to add blocks to your calendar that only you and your calendar
    managers can use.  People wanting to make an appointment would have to contact you or one of your calendar managers and request the appointment  be added.</p>
    <p>Note that you can have different settings for "View Calendar" and "Make Appointments."  For example, if you want anyone at all to be able to view your calendar blocks, but only you to be the one to schedule appointments, you would set "View Calendar" to "Open" and "Make Appointments" to "Private."</p>
</div>
<div class="rightHelp" id="groupcal" name="divHelp" style="display:none;">
<h2>Calendar Setup - Group Calendars</h2>
	<p>You create a calendar for a group of people by checking the "Group Calendar" box on the Calendar Setup form.  A group calendar is a calendar that is shared by a group of people, all of whom offer a similar service, and who are referred to as "calendar members." For example, a group of people offering tutoring services might create a group calendar on which each tutor creates blocks for his or her available hours.  When someone accesses a group calendar, they see all of these blocks of available time, along with the identity of the person who added the block to the calendar. </p>
    <p> Like an ordinary calendar, a group calendar has an owner&#8212;the person who creates the calendar and who has complete authority over the calendar.  Unlike an ordinary calendar, a group calendar has zero or more group members, the people who, along with the calendar's owner, can add blocks of time to the calendar.   The calendar owner can, at any time, add or remove group members from this calendar.  Once a person has been added as a member to the calendar, s/he can add or remove blocks of available time from that calendar.  Any block added to a group calendar belongs to the member who has added that block (or the calendar owner, if s/he is adding the block). The person making an appointment for that block will be making the appointment with just that group member.  <br />
<br />
The "members" of a group calendar are analogous to the "managers" of a regular calendar, and have many of the same rights.</p>
    <p>When creating a group calendar, it is very important to give that calendar a meaningful title, as people will be looking up the calendar by its title, rather than by the names or IDs of the individual group members (whom they may not even know).    
    </p>
    <p><strong>Please note:</strong> You should not create a group calendar unless you have a very specific need for sharing a calendar among a group of people.  Your personal calendar should not be a group calendar.  Only create a group calendar if you have a group of people who offer a common service and with whom people need to make appointments to access that service.
    </p>
</div>
<div class="rightHelp" id="remove" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Remove Calendar</h2>
	<p>If you click the "Remove" button on the right side of the form, the calendar will be removed, any scheduled appointments will be cancelled, and e-mail notifications will be sent. You will, however, be prompted to confirm the removal and be given the opportunity to edit the e-mail notification message to these cancelled-appointment holders beforehand.
	<p>You should only remove your calendar if you no longer wish to use the system altogether. You do not need to remove your calendar between semesters or years. Instead, you can just continue to add blocks to your calendar that correspond to your availability at future times.</p>
</div>
<div class="rightHelp" id="apply" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Apply to Manage/Join a Calendar</h2>
	<p>If you click the "Apply" button, a form will be displayed that lets you apply to manage someone else's calendar (or, if the calendar is a group  calendar, to become a member of that group).  When you submit the form, an e-mail is sent to the calendar owner informing them of your request. They will have the option to accept or decline the request. <br />
<br />
A calendar manager/member can do all of the same things as a calendar owner.  If the person to whom you are applying does not have a calendar in the system, a default calendar will be built.</p>
</div>
<div class="rightHelp" id="calmanage" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Calendar's Managers</h2>
	<p>If you click the "Go" button inside this panel, a form will be displayed that lists all of the people who are managing the calendar. </p> 
    <p><strong>Pending manager</strong><br />
    Anyone who has applied to manage your calendar will be listed with both "Allow" and "Deny" options next to their name. Click "Allow" to make them your calendar's manager, or click "Deny" to refuse the request and generate an optional e-mail to them regarding your selected action.</p>
	<p><strong>To add a new manager for your calendar</strong><br />Enter their <?php echo wassParms::NETID;?> in the text field and click "Allow." They can receive an e-mail notification that they have been added as a manager for your calendar. When they log in, your calendar will appear in their "Manage Calendars" list.</p>
    <p><strong>To remove a manager</strong><br />
    Remove a manager by clicking "Deny" next to their <?php echo wassParms::NETID;?> and name. They can receive an e-mail notification that they are no longer one of your calendar's managers.<br />
<br />
[You are given an opportunity, each time, to send or suppress the e-mail notifications related to these aforementioned actions.]</p>
  </div>
<div class="rightHelp" id="calmember" name="divHelp" style="display:none;">
	<h2>Calendar Setup - Group Calendar's Members</h2>
	<p>Group calendars have zero or more members instead of managers.  If you click the "Go" button inside this panel, a form will be displayed that lists all of the people who are members of your calendar, if any. </p> 
	<p><strong>Pending member</strong><br />
    A person who has applied to be a member of your calendar will be listed with both "Allow" and "Deny" options next to their name. Click "Allow" to make them a member, or click "Deny" to refuse their request and generate an optional e-mail to them regarding your selected action.</p>
	
    <p><strong>To add a member to your calendar</strong><br />Enter their <?php echo wassParms::NETID;?> in the text field and click "Allow." They can receive an e-mail notification 
    that they have been added as a member of your calendar. When a member logs in, your calendar will appear in their "Group Calendars" list.</p>
    <p><strong>To remove a member</strong><br />
    Remove a member by clicking "Deny" next to their <?php echo wassParms::NETID;?> and name. They can receive an e-mail notifiaction that they are no longer one of your calendar's members.<br />
<br />
[You are given an opportunity, each time, to send or suppress the e-mail notifications related to these aforementioned actions.]
</p>
    
</div>
<div class="rightHelp" id="view" name="divHelp" style="display:none;">
	<h2>View Calendar - Overview</h2>
<p>The calendar display shows a specific calendar, including blocks of available time, and any appointments that have been made for those blocks.
The calendar owner or managers see details about the appointment; others only see that the appointment has been made. If the "Show Appointment Details" flag is set at the time the block is added to the calendar, then everyone sees complete information about the appointment.  <br />
<br />
The display can be toggled between three views: month, week, and day. You select a view using the Day/Week/Month buttons in the upper right of the display.  In Month and Week view, blocks of available time are shown by their time ranges.  Clicking one of these time ranges takes you to the Day view for that day, which displays the blocks of available time, as well as appointments in those blocks.<br />
<br />
A set of small calendars to the left of the display provides a quick overview of the calendar in two-month increments.  Clicking on a date in these calendars takes you to the Day view for that date.</p>
<p>All of the calendar displays use colors to indicate the status of a day, as follows:</p>
<ul>
<li>No color: There are no blocks of available time on this day.</li>
<li>Grey: There are blocks of available time on this day, but none of the appointment slots are available.</li>
<li>Orange: You can make appointments on this day.</li>
<li>Yellow: You have appointments scheduled on this day.</li>
</ul>
<p>
To make an appointment, select a day which has available appointment slots (an orange day, or, if you are trying to make an additional appointment for a given day, a yellow day).  The display will show blocks of available time.  These blocks can be either "slotted" or "unslotted."  A slotted block is divided into fixed-duration appointment slots.  Click on the "+" sign of an available slot to make an appointment for that specific time.  An unslotted block is just a block of undivided time.  Click on the "+" sign to make an appointment for that time period.  You will be shown a form where you can fill in details about the appointment.
</p>
<p>
To edit an appointment, in the Day view, click the "pencil" icon associated with the appointment. This will bring up a panel that lets you edit an appointment.  You can change the name/email/phone number associated with the appointment, as well as the start and end times (as long as you do not violate any block restrictions).  
</p>
<p>
To cancel an appointment, in the Day view click the "x" icon associated with the appointment.  You will be given a chance to specify the text of the e-mail that will be sent notifying the parties of the cancellation.   Clicking the lowercase "i" icon will provide additional information about an appointment.
To add an appointment to your local calendaring application (e.g., Outlook or iCal), click the "double arrow" icon.
</p>
<?php if ($_SESSION['owner'] || $_SESSION['ismanager']) {?>
<p>Before people can make appointments with you, you need to add one or more blocks of available time to your calendar.  You do this by clicking the "Add Block(s)" button on the left-hand menu.  This will display a form that lets you specify details about the block, including a title and a description for the block, whether it is a single or a recurring block,  start/end times, and access restrictions.
</p>
<p>You can edit the properties of an existing block by clicking the "pencil" icon associated with the block. 
You can delete a block by clicking the "x" icon associated with the block (any scheduled appointments will be cancelled, and you will be given a chance to specify the text of the e-mail that will be sent to anyone whose appointment is cancelled).  Clicking the "double arrow" icon will cause the block to be added to your local calendaring application (e.g., Outlook).  Clicking the "padlock" icon will make a block unavailable and prevent anyone from making a new appointment in that block.  Clicking the padlock again will make the block available.
</p>
<?php 
}?>
</div>
<!-- Appointment -->



<div class="rightHelp" id="appointment" name="divHelp" style="display:none;">
	<h2>View Calendar - Appointments</h2>
    <p>Each displayed appointment has a set of associated icons which you can use to take action on the appointment, as follows:</p>
    <ul>
    	<li>Clicking the "?" icon displays the Help pages.</li>
        <li>Clicking the "i" icon will display additional information about the appointment.</li>
        <li>Clicking the "pencil" icon will bring up a panel that lets you edit the appointment (change start/end times, name, email, phone number).
        <li>Clicking the "x" icon will cancel the appointment.  You will be asked to confirm the deletion, and to specify the text that should
        be included in the e-mail which will be sent out announcing the apppintment cancellation.</li>
        <li>Clicking the "double-arrow" icon will cause the appointment information to be sent to you browser in a special format (iCal format).
        This will cause the appointment information to be added to you local calendar (e.g., Outlook or ical or whatever local
        calendaring program you use).</li>
		<li>[For Calendar Owners] Clicking the "lock" icon will lock the appointment slot (or unlock it, if it is currently locked).  Once locked, no one can schedule an appointment for that slot.  (If an appointment slot is already taken by someone and you lock that slot, the appointment will be cancelled and an e-mail sent to the appointment holder.)
    </ul>
</div>
<!-- Block Select -->
<div class="rightHelp" id="block" name="divHelp" style="display:none;">
	<h2>View Calendar - Select Block</h2>
    <p>A block corresponds to a period of time during which the calendar owner is available for
    appointments.  Its Day view displays the title of the block, an optional description, and information about the maximum number of appointments for the block.</p>
    <p>Blocks are of two types:  slotted and unslotted. <br />
<br />
A slotted 
   	block is divided into individual appointment time slots.  Any available slot of time will be displayed in orange and will have an associated "+" sign. Simply click the "+" sign to schedule an appointment.<br />
<br />
Unslotted blocks are not divided into individual appointment slots; they serve as sign-up sheets. So, as long as the block's appointment limit has not been reached, you can make an appointment or sign-up for that time period by clicking the "+" sign associated with that block.</p> 
</div>
<!-- Block Edit -->
<div class="rightHelp" id="ownerblock" name="divHelp" style="display:none;">
	<h2>View Calendar - Edit Block</h2>
       <p>These blocks correspond to periods of time during which you (e.g., the calendar owner) are available for
    appointments.  The display shows the title of the block, whether or not the block is part of a recurring series of blocks, an optional description, and information about the maximum number of appointments. (Also see Select Block.) </p>
        <p>Any scheduled appointments are shown in yellow, and, in the Day view have an associated set of icons that let you cancel the appointment, get more information about the appointment, or synchronize the appointment with your local calendar.
    <p>In addition to the appointment information, each block has a set of associated icons which you can use to take action on the block, as follows:</p>
    <ul>
    	<li>Clicking the "?" icon displays the Help pages.</li>
        <li>Clicking the "pencil" icon displays additional information about the block, and lets you edit block properties (e.g., the title, location, derscription, etc.).</li>
        <li>Clicking the "x" icon deletes the block and cancels any associated appointments.  You will be asked to confirm the deletion, and to specify the text that should
        be included in the e-mail which will be sent out announcing the appointment cancellation(s).</li>
        <li>Clicking the "lock" icon locks the block (no one can make an appointment); click again to unlock.
        <li>Clicking the "double-arrow" icon causes the block information to be sent to your browser in a special format (iCal format).
       The block information will be added to your local calendar (e.g., Outlook or ical or whatever local
        calendaring program you use).</li>
    </ul>
</div>
<!-- Delete block -->
<div class="rightHelp" id="delblock" name="divHelp" style="display:none;">
	<h2>View Calendar - Delete Block</h2>
       <p>To delete a block, locate the block you want to delete on your calender, make sure you are in "Day" view (click the "Day" box at the top of the calendar display) then click the "x" icon at the top of the block description.  If the block is a recurring block (part of a "series"), you will be asked if you want to delete just the current instance of the block or the entire series.</p>
    <p>When a block is deleted, any appointments scheduled for that block (or any of the blocks in a series, if you are deleting a series) are cancelled.  You can specify the text that should included in the e-mail that will be sent to notify people of the cancellation, or specify that such e-mail notifications should not be sent.</p> 
</div>
<!-- Delete block -->
<div class="rightHelp" id="links" name="divHelp" style="display:none;">
	<h2>Direct Links</h2>
       <p>There may be circumstances where you want people to be able to access a specific day, week or month of your calendar, without their having to scroll through the calendar display.  You can advertise a URL (link) that will take people to a specific day, week or month (after they login) as follows:</p>
       <ul>
       <li>Scroll your calendar to the date/time which you want to advertise.</li>
       <li>Set the calendar view display to either day, week or month.</li>
       <li>Move your cursor so that it is hovering over the sentence that reads "Display direct URL (link) ...", located at the top right of the calendar display.</li>
       <li>A window will pop up that displays the URL which you can advertise.  You can copy/paste this URL.</li>
       </ul>
       <p>Anyone using this URL will first be taken to the login page, and then directly to the day/week/month that you selected.</p>
</div>
<!-- Add Block -->
<div class="rightHelp" id="onetime" name="divHelp" style="display:none;">
	<h2>Add Block - One-Time</h2>
<p>Before people can schedule appointments with you, blocks of available time need to be added to your calendar.  These might be your office hours, or they might be discrete blocks of time on specific days when you are available to meet with people.  You can add either one-time or recurring blocks of time to your schedule in by clicking the "Add Block" button on the left-hand menu.
This will cause the "Create a New Block" form to be displayed.    
</p>
<p>The first choice you have is whether you want this to be a recurring or a one-time block.  For one-time blocks, you specify a title and fill in your contact information.  You then specify the "slot" size for the block ... this refers to the length of the appointment slots within the block.  If you select "none" from the dropdown list, people will not select a specific time within the block (e.g., this is appropriate for the traditional first-come, first-served office hours block, or for a meeting).  You can, however, set a limit on the number of people who can sign up for that block.  If, instead, you specify a slot size, then the block will be divided into an integral number of these slots, and people will select specific times.  With slotted blocks, you can specify whether people are allowed to sign-up for multiple consecutive slots, and how many.</p>
<p>For example, if you create a block that goes from 11:30 am until 3:00 pm, and you use a slot size of 30 minutes, the system will create seven consecutive half-hour slots (11:30-12, 12-12:30, etc.).  People can then select whatever time slot is available.  If you want people to be able to make half-hour or 1 hour appointments, you would set a "Max appointments" value of 2 (so that people can make appointments that span up to 2 half-hour time slots).</p>
<p>
You can associate a number of time restrictions for a block, as follows:</p>
<ul>
<li>Scheduling Opening:  Lets you specify when, in minutes prior to the start of the block, that it becomes available for scheduling.  For example, a value of 60 would mean that people could only start making appointments within 60 minutes of the start of the block.  The default is zero, which means that the block is always available for scheduling.</li>
<li>Scheduling Deadline: Lets you specify when, in minutes prior to the start of the block, that it becomes unavailable for scheduling.  For example, if you specify a value of 60, then people could no longer schedule appointments once the current time was less than 60 minutes from the start time of the block.  The default is zero, which means that people can make appointments right up until the appointment start time.  The Opening and Deadline values let you specify a "window" within which appointments can be scheduled, relative to the start time of the block.  You can specify neither or either or both of these values.</li>
<li>
Cancelling Deadline: Lets you specify when, in minutes prior to the start of the appointment, that a person can no longer cancel the appointment.  For example, if you specify a value of 60, then a person who has made an appointment could not cancel that appointment any later than 60 minutes prior to its start.  The default is zero, which menas that appointments can be scheduled right up until their start time.</li>
</ul>
<p>
If you click the "Show" button next to the "Access Restrictions" link on the Add Block page, you will be shown a set of fields that allow you to restrict who can view this block and/or make appointments for this block.  
</p>
<ul>
<li>Limited:  Only users who can login to the system (have a userid/netid) will be able to view and/or make appointments. This is the <strong>default</strong> setting.</li>
<li>Restricted: Only the specified users<?php if (wassParms::COURSELIM) {?>, or users enrolled in the specified courses,<?php }?> can view and/or make appointments (you provide a list of users <?php if (wassParms::COURSELIM) {?>and/or courses <?php }?>.</li>
<li>Private: Only you or your managers can view and/or make appointments.</li>
</ul>
<p>Note that you can set access restrictions separately on the viewing of the block and on the making of appointments (although you would usually want these to be the same).</p>	
</div>
<div class="rightHelp" id="recurring" name="divHelp" style="display:none;">
	<h2>Add Block - Recurring</h2>
	<p>Recurring blocks have options in addition to those of One-Time blocks. A recurring block is a repeated blocked with a start date and end date and can recur daily, weekly, monthly, and so on. You can also specify on what types of days the blocks should be scheduled, wherein the type of day corresponds to the way days are classified on the academic calendar at <?php echo wassParms::INSNAME;?>.</p>
    <p><strong>To create a recurring block</strong><br />Click the "Add Block(s)" button on the left-hand menu. Select "Recurring" as the type of block, fill in the required information, and click "Save." A recurring block appears with this icon <img src="images/recur_4helpdoc.gif" alt="recur icon here" /> on the calendar.</p>
     <p><strong>To edit a recurring block</strong><br />Click the pencil icon. You can either edit one instance of the block or the entire series. When editing a recurring block, certain features are not editable because those changes could unexpectedly affect appointments.</p>
</div>
<div>
<div class="rightHelp" id="deadlines" name="divHelp" style="display:none;">
	<h2>Deadlines</h2>
<p>
When you add or edit a one-time or recurring block in you calendar, 
you can associate a number of time restrictions (deadlines) for appointments made in that block.  You do so by filling in values
for the following fields:
</p>
<ul>
<li>Scheduling Opening:  Lets you specify when, in minutes prior to the its start, that the block becomes available for scheduling.  For example, a value of 60 would mean that people could only start making appointments within 60 minutes of the start of the block.  The default is zero, which means that the block is always available for scheduling.</li>
<li>Scheduling Deadline: Lets you specify when, in minutes prior to its start, that the block becomes unavailable for scheduling.  For example, if you specify a value of 60, then people could no longer schedule appointments once the current time was less than 60 minutes from the start time of the block.  The default is zero, which means that people can make appointments right up until the appointment start time.  The Opening and Deadline values let you specify a "window" within which appointments can be scheduled, relative to the start time of the block.  You can specify neither or either or both of these values.</li>
<li>
Cancelling Deadline: Lets you specify when, in minutes prior to the start of the appointment, that a person can no longer cancel the appointment.  For example, if you specify a value of 60, then a person who has made an appointment could not cancel that appointment any later than 60 minutes prior to its start.  The default is zero, which menas that appointments can be scheduled right up until their start time.</li>
</ul>
</div>
<div class="rightHelp" id="subscribe" name="divHelp" style="display:none;">
<h2>Subscribe to a Calendar</h2> 
(Note: the Subscription URL is for use by <span class="style2">Calendar Owners and Calendar Managers ONLY.)<br /><br />

If you are using a local calendaring application that supports "internet calendars" (sometimes referred to as "public calendars" or "web calendars"), then you can view your appointments and blocks directly from your local calendaring application. To set this up you'll use the "Subscription URL" displayed on the Calendar Setup page.  </span><br> <br> 
The Subscription URL (which begins with "webcal" instead of the usual "http") currently works well with Microsoft Outlook 2007, the iCal application on a Mac, and Google Calendar. It is not supported by prior Outlook versions or  Entourage. It <i>may</i> work with other calendaring applications, but you would need to check the documentation for the application to see if it supports calendar subscriptions.<br><br>
To use this capability,  first  locate the Subscription URL.  It is displayed on the Calendar Setup page, and begins with "webcal."  Copy this entire URL into your browser's cut-and-paste buffer aka your clipboard, or just jot it down.  The next steps depend on which local calendaring application you are using.<br />
 <br /> <strong>If you are using Outlook 2007</strong></p> <ol>   <li>    From the Outlook Tools menu, select <strong>Account Settings</strong>.</li>   <li>      Click the tab for <strong>Internet Calendars</strong>. </li>   <li>      Click <strong>New</strong>.</li>   <li>      Paste the previously copied webcal link into the New Internet Calendars Subscription box.</li>   <li>      Click the <strong>Add</strong> button.</li>   <li> In the Subscription Options popup, give the folder a name such as WebAppts.</li>   <li> <em>optional &nbsp;&nbsp;</em> Provide a brief description of the calendar.</li>   <li> Click <strong>OK</strong>.</li>   <li> Click <strong>Close</strong>.</li> </ol> <p> You should now see Internet Calendars added to the list in Folder View and the name you entered, from step #6 above, listed.</p> <p>    <strong>If you are using Google Calendar </strong></p> <ol>   <li>   Go to Google calendar and locate the calendar list on the left side of the page.</li>   <li> At the bottom of the "Other calendars" list, click <strong>Add</strong> </li>   <li> Select <strong>Add by URL</strong>.</li>   <li> Paste the previously copied webcal link into the Add Other Calendar popup.</li>   <li> Be sure Make the calendar publicly accessible is not checked.</li>   <li> Click the <strong>Add</strong> button.</li>   <li> Locate the webcal link now in the list of Other calendars and click it to display your Web Appointments Scheduling System calendar.<br>   </li> </ol> <p><strong>If you are using iCal on a Mac</strong></p> <ol>     <li>In iCal, under the Calendar menu, click <span class="style1">Subscribe</span>.</li>     
<li>Paste the previously copied webcal link into the Calendar URL text box and click <strong>Subscribe</strong>.</li>    
<li>Enter a name for this calendar (e.g., WebAppts), then click <strong>OK</strong>.</li>    
</ol>  
 <p>This particular Web Appointment Scheduling System calendar should now appear in the list of available calendars.</p>
 <p>NOTE:  Google calendar currently can take as long as a day to update a subscribed calendar, so you should NOT use this mechanism to keep up with recently scheduled appointments.  Instead, use the link that is included in the appointment announcement e-mail to add appointments one by one to your Google calendar.</p>
 <p><strong>If you are using Mozilla Lightning or Sunbird</strong></p>
 <ol>
   <li> From the File menu, select New, Calendar.</li>
   <li> Click the radio button for On the Network.</li>
   <li> Click <strong>Next</strong>.</li>
   <li> Be sure the Format selected is iCalendar (ICS)</li>
   <li>In the Location field, paste the previously copied webcal link into the Location field. </li>
   <li> Click <strong>Next</strong>. </li>
   <li> Provide  a name, such as WebAppts, in the Name field and make any other desired changes (e.g., color, show alarms).</li>
   <li>Click <strong>Next</strong> to display &quot;Your calendar has been created.&quot;</li>
   <li>Click <strong>Finish</strong>.</li>
  </ol>
 <p>You should now see the name of the calendar you entered, from step #7 above,  added to your list of calendars. </p>
  </div>
<div class="rightHelp" id="subscriberss" name="divHelp" style="display:none;">
<h2>Subscribe to a Calendar as an RSS feed</h2> 
<p>
If this calendar is used to schedule things such as events, seminars, presentations, or other group-oriented events (typically represented by unslotted blocks), then the listed URL will allow people to subscribe to the calendar as an RSS feed (the system will send them the calendar in RSS format).  This subscription only returns block information; it does not return information about individual appointments.  It is intended for event calendars, and allows someone to see all of the scheduled events (calendar blocks) in an RSS reader.
</p><p>If you own this calendar, and you are using the calendar to schedule group events, you can advertise this calendar to potential attendees, thus allowing them to download the calendar events intoi their RSS reader.</p>
</div>
  <div class="rightHelp" id="badvanced" name="divHelp" style="display:none;">
	<h2>Add Block - Access Restrictions</h2>
	<p>If you click the "Show" link next to "Access Restrictions," you will be shown two fields, "View Blocks" and "Make Appointments," which allow you to control who can view this block and/or make appointments.  You can set the following access restrictions on a block:
    <p><strong>Open</strong><br />You can set either field to "Open," which allows access to anyone at all.</p>
    <p><strong>Limited</strong><br />By default, both fields are set to "Limited," which means that anyone with a <?php echo wassParms::NETID;?> can view 
   your block and/or schedule an appointment.</p>    
   
   <p><strong>Restricted</strong><br />Setting either field to "Restricted" brings up additional fields which allow you to list the users <?php if (wassParms::COURSELIM) {?>and/or courses <?php }?>which are allowed access to the calendar blocks. <?php if (wassParms::COURSELIM) {?>To enter a course name you will need use the Blackboard Course ID (ex. SPA101_F2009). <br />
<br />
To locate a Blackboard Course ID, log into <a href="https://blackboard.princeton.edu" target="_blank">Blackboard</a> and locate the course in the "My Courses (sortable)" module. The Course ID will be prepended to the course name. For example, if your course is listed as SPA101_F2009 Beginner's Spanish I, the Course ID is SPA101_F2009. Note that there will be an underscore (_) between the course code (SPA101)and the semester/year code (F2009). It is important to include this underscore, and to not have spaces in the Course ID, when you enter it.<?php }?></p>    
    <p><strong>Private</strong><br />Setting either field to "Private" limits access to only you and your calendar managers, if any.  This allows you to add blocks to your calendar that only you and your calendar
    managers can use.  People wanting to make an appointment would have to contact you or one of your calendar managers and request the appointment be added.</p>
   	<p>Note that you can have different settings for "View Blocks" and "Make Appointments."  For example, if you want anyone at all to be able to view your block, but only you to the one to schedule appointments, you would set "View Blocks" to "Open" and "Make Appointments" to "Private."</p>
    <p>Below the Access Restriction settings is a checkbox labelled "Show Appointment Details."  DO NOT check this box until you understand the consequences, which are detailed in the "Show Appointment Details" help topic.
</div>
 <div class="rightHelp" id="showappinfo" name="divHelp" style="display:none;">
<h2>Show Appointment Details</h2> 
<p>When the <?php echo wassParms::SYSID;?> displays a calendar to anyone who is not a calendar owner or manager (or group calenar member), it masks details about appointments that other people have made. It only shows that an appointment slot is taken, with no information about who has taken the slot.  This is done to protect people's privacy.  There are cases, however, where you may want everyone to see who else has made appointments.  For example, if you are using the <?php echo wassParms::SYSID;?> to schedule meetings, you may want people to be able to see who else is attending the meeting.  If you check the  "Show appointment details" checkbox, then complete appointment details will be shown to everyone.<br />
<img src="images/Q1_warning.gif" width="16" height="16" alt="warning icon" /> WARNING:  this means that there will be no privacy associated with appointments.</p>
</div>

<div class="rightHelp" id="advertiseblock" name="divHelp" style="display:none;">
<h2>Advertise a Block</h2> 
Once you have created a block, you may want to advertise your block so that students (or others) can easily locate the block of time to make appointments with you.  <br /> <br />
The Block URL, which is displayed on the Edit Block page as well as on the View Calendar page in "Day" view, points directly to the block.  When people invoke that URL, they will first be asked to log into the <?php echo wassParms::SYSID;?>, and then they will be taken directly to the given block on your calendar.<br /><br />
To summarize, the "Block URL" on the View Calendar page and on the Edit Block page is a URL that you should advertise to people who will want to make appointments with you.   
</div>

<div class="rightHelp" id="advertise" name="divHelp" style="display:none;">
<h2>Advertise a Calendar</h2> 
Once you have created a calendar, and placed blocks of available time on that calendar, you may want to advertise your calendar so that students (or others) can easily locate your calendar and make appointments with you.  People can locate your calendar by going to the <?php echo wassParms::SYSID;?> and using the calendar search function, but you can simplify this process for them by advertising the "Calendar URL" displayed on the Calendar Setup page.<br /> <br />
The Calendar URL points directly to your calendar.  When people invoke that URL, they will first be asked to log into the <?php echo wassParms::SYSID;?>, and then they will be taken directly to your calendar, where they can find a block of available time and make an appointment with you.<br /><br />
To summarize, the "Calendar URL" on the Calendar Setup page is a URL that you should advertise to people who will want to make appointments with you.   
</div>
</form>
<br><br>

<div id="close"><a href="#" onclick="self.close();">Close Window</a></div>

</body>
</html>
