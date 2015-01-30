<?php 
/*
        This page allows appointment makers to sign up for an appointment.
		Arguments:
			- blockid: the block that the appointment is on (new appointments only)
			- st: the start time of the selected appoinment slot
			- et: the end time of the selected appoinment slot
			- apptid: the appoinment to be viewed/edited
*/

$pagenav = 'makeappt'; /*for setting the "selected" page navigation, new appointment */
if ($_GET["apptid"]) $pagenav = 'myappts'; /* if view/edit appointment */
include "_header.php"; ?>

<script type="text/javascript" language="javascript" src="../models/block.js"></script>
<script type="text/javascript" language="javascript" src="../models/appointment.js"></script>
<script type="text/javascript" language="javascript" src="apptview.js"></script>
<script type="text/javascript">
	var txtMsgGateways = new Array();
	txtMsgGateways["Alltel"] = "message.Alltel.com";
	txtMsgGateways["AT&T"] = "txt.att.net";
	txtMsgGateways["Cellular One"] = "mobile.celloneusa.com";
	txtMsgGateways["Cingular"] = "cingular.com";
	txtMsgGateways["Nextel"] = "messaging.nextel.com";
	txtMsgGateways["Sprint"] = "messaging.sprintpcs.com";
	txtMsgGateways["T-Mobile"] = "tmomail.net";
	txtMsgGateways["Verizon Wireless"] = "vtext.com";
	
   	$(document).ready(function() {
		apptview.setPageVars($.urlParam("apptid"),$.urlParam("st"),$.urlParam("et"));
		controller.loadApptViewData($.urlParam("calid"), $.urlParam("blockid"), $.urlParam("apptid"));
	
		$("#editTextMsgEmail").bind({
   			popupafteropen: function(event, ui) {
				for (var i in txtMsgGateways) {
					$("#selProviders").append("<option value='" + i + "'>" + i + "</option>");
				}
				$("#selProviders").selectmenu("refresh");
			}
		});
	});

</script>                                                               
</head>

<body>

<!-- Sign up for an Appointment -->
<div data-role="page" id="signup">

	<div data-role="header" data-backbtn="false">
		<?php include('_mainmenu.php'); ?>
<!--        <div id="breadcrumbs">
        	<ul>
            	<li><a href="#">Make Appt</a>&nbsp;&nbsp;></li>
                <li>Sign Up</li>
            </ul>
        </div>-->
	</div><!-- /header -->

	<div data-role="content">	
		<h1 id="pagetitle" class="clear">Title</h1>      
    	<form id="apptinfo" method="post" action="#" data-ajax="false">
        
            <div class="instructions">Enter your information below to sign up for the selected appointment.</div>
            
            <fieldset>
            <div id="divBlockTitle" data-role="fieldcontain"></div>
            <div id="divBlockOwner" data-role="fieldcontain"></div>
            <div id="divBlockLocation" data-role="fieldcontain"></div>
            <div id="divStartDate" data-role="fieldcontain"></div>

            <div id="divTime" data-role="fieldcontain">
                <label id="lblTime" for="selTime" class="ui-hidden-accessible">Time:</label>
                <select name="selTime" id="selTime" title="Appt Time"></select>
            </div>
            <div id="divPurpose" data-role="fieldcontain">
                <label id="lblPurpose" for="txtPurpose" class="ui-hidden-accessible">Purpose:</label>
                <textarea name="txtPurpose" id="txtPurpose" placeholder="Purpose" title="Purpose"></textarea>
            </div>
            <div id="divWhenMade" data-role="fieldcontain"></div>
            </fieldset>
            <hr>
            
            <h2>Who is the appointment for?</h2>

			<fieldset>
            <!-- need input text for owners/managers -->
            <div id="divUserID" data-role="fieldcontain"></div>
             
            <div id="divApptName" data-role="fieldcontain">
                <label id="lblApptName" for="txtApptName" class="ui-hidden-accessible">Name:</label>
                <input type="text" name="txtApptName" id="txtApptName" class="required" placeholder="Name" title="Name" />
            </div>
            
            <div id="divPhone" data-role="fieldcontain">
                <label id="lblPhone" for="txtPhone" class="ui-hidden-accessible">Telephone:</label>
                <input type="tel" name="txtPhone" id="txtPhone" placeholder="___-___-____" title="Phone" />
            </div>
            </fieldset>
            <hr>
            
			<fieldset>
            <div class="instructions">If checked, a reminder will be sent to the e-mail address(es) provided (comma-separated). To also receive a text message, enter your cell phone number and provider.</div>
            
            <div id="divRemind" data-role="fieldcontain">
                <label id="lblRemind" for="chkRemind">Remind?</label>
                <input type="checkbox" name="chkRemind" id="chkRemind" checked="checked" title="Remind" />
            </div>
            
            <div id="divEmail" data-role="fieldcontain">
                <label id="lblEmail" for="txtEmail">E-mail(s), comma-separated:</label>
                <input type="text" name="txtEmail" id="txtEmail" class="required" placeholder="" title="E-mail" />
            </div>
            
            <label id="lblTxtEmail" for="txtTxtEmail">Txt Msg E-mail:</label>
           	<div id="divTextEmail" class="inline"></div> <a href="#editTextMsgEmail" data-rel="popup">edit</a>
            </fieldset>

            <div id="divSubmit" data-role="fieldcontain" class="margintop">    
  	 			<input id="btnSubmit" type="submit" value="Make the Appointment" data-inline="true" />
    		</div>
            
        </form>

        <div data-role="popup" id="editTextMsgEmail">
            <a href="#" data-rel="back" data-role="button" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
            <form id="frmTextEmail" method="post" action="#" data-ajax="false">
            <div style="padding:10px 20px; width:250px;">
                <h3>Generate Text E-mail</h3>
                <div class="instructions">Select your service provider and enter your cell phone number to have a text sent to your phone.</div>
                <label for="selProviders" class="ui-hidden-accessible">Service Provider:</label>
                <select name="selProviders" id="selProviders"></select>
                
                <label for="txtTextNumber" title="Enter your cell phone number" class="ui-hidden-accessible">Cell Number:</label>
                <input type="text" id="txtTextNumber" name="txtTextNumber" value="" placeholder="Cell Number" />
                
                <div class="instructions italic importantnote" style="margin-top:15px;margin-bottom:2px;">If your service provider is not listed, enter your text message e-mail address manually.</div>

                <label for="txtTxtEmailAddr" title="Enter your txt msg e-mail" class="ui-hidden-accessible">Txt Msg E-mail:</label>
                <input type="text" id="txtTxtEmailAddr" name="txtTxtEmailAddr" value="" placeholder="e.g. 6095551212@att.net" />
                
                <input type="submit" value="Generate" data-inline="true" />
            </div>
            </form>
        </div>
        
        <div id="divCancel">
        	<hr>
        	<form id="frmCancel" method="post" action="#" data-ajax="false">
            <h2><img src="../images/cancel.gif" alt="Cancel Appointment" border="0" class="inlineicon" />Cancel this appointment?</h2>
            
            <fieldset>
             <div id="divCancelText" data-role="fieldcontain">
             	<div class="instructions">Enter any text you would like to be included in the cancelation e-mail.</div>
                <label id="lblCancelText" for="txtCancelText" class="ui-hidden-accessible">Cancelation Text:</label>
                <textarea name="txtCancelText" id="txtCancelText" placeholder="Cancelation text for e-mail"></textarea>
            </div>
            
            <div id="divCancel" data-role="fieldcontain">    
  	 			<input type="submit" value="Cancel the Appointment" data-inline="true" />
    		</div>
            </fieldset>

			</form>
        </div>
        
        <div data-role="popup" id="cancelConfirm">
            <a href="#" data-rel="back" data-role="button" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
            <form id="frmCancelConfirm" method="post" action="#" data-ajax="false">
            <div style="padding:10px 20px; width:250px;">
                <h3>Confirm Appointment Cancelation</h3>
                <div class="instructions">Are you sure you want to cancel this appointment? This action cannot be undone.</div>                
				<input type="submit" value="Cancel the Appointment" data-inline="true" />
            </div>
            </form>
        </div>
        
	</div><!-- /content -->

	<?php include('_footer.php'); ?>
    
    <script type="text/javascript"> 
		$("#frmTextEmail").submit(function(e) {
			var txtaddr = "";
			//check to see if entered manually
			if ($("#txtTxtEmailAddr").val() != null && $("#txtTxtEmailAddr").val() != "")
				txtaddr = $("#txtTxtEmailAddr").val();
			else { //generate from the provider and cell number
				var nmbr = $("#txtTextNumber").val();
				if (nmbr != null && nmbr != ""){
					var prvdr = $("#selProviders").val();
					nmbr = nmbr.replace(/\D/g, "");
					txtaddr = nmbr + "@" + txtMsgGateways[prvdr];
				}
			}
			controller.validateEmail(txtaddr,"apptview.showIsValidTxtEmail");
			return false;
		});
		
		function doSubmit() {
			if (apptview.isValidForm()) {
				apptview.saveApptData();
				if (apptview.isNewAppt) {
					controller.addAppt(gAppt);
				} else {
					controller.editAppt(gAppt);
				}
			}
		}
		
		$("#apptinfo").submit(function(e) {
			doSubmit();
			return false;
		});

		$("#frmCancelConfirm").submit(function(e) {
			controller.deleteAppt(apptview.apptid,$("#txtCancelText").val());
			return false;
		});
		
		$("#frmCancel").submit(function(e) {
			$("#cancelConfirm").popup("open");
			return false;
		});

    </script>                                                               

</div><!-- /page -->

</body>
</html>
