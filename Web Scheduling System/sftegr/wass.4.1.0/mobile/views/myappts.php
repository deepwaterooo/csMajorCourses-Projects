<?php 
$pagenav = 'myappts'; /*for setting the "selected" page navigation */
include "_header.php"; ?>

<script type="text/javascript" language="javascript" src="../models/waspcalendar.js"></script>
<script type="text/javascript" language="javascript" src="../models/appointment.js"></script>
<script type="text/javascript" language="javascript" src="../models/filter.js"></script>
<script type="text/javascript" language="javascript" src="myapptsview.js"></script>
<script type="text/javascript">
   	$(document).ready(function() {
		myapptsview.setPageVars();
		controller.loadMyApptsViewData();
	}); 
</script>                                                                                                                             
</head>

<body>

<div data-role="page" id="myappts">

	<div data-role="header" data-backbtn="false">
		<?php include('_mainmenu.php'); ?>
	</div><!-- /header -->

	<div data-role="content">	
		<h1 id="pagetitle" class="clear">Title</h1>      
    	<form id="listappts" method="post" action="#" data-ajax="false">
        
            <div class="instructions">Filter for a specific appointment or browse the list of all appointments.</div>
                       
            <div id="divApptFilter" data-role="collapsible" data-collapsed="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d">
            	<h3>Filtering Options</h3>
                <fieldset>               
                <div id="divStartDate" data-role="fieldcontain">
                	<div class="ui-grid-b">
                        <div class="ui-block-a"><label id="lblStartDate" for="txtStartDate">Start:</label></div>
                        <div class="ui-block-b"><input type="text" id="txtStartDate" name="txtStartDate" placeholder="__/__/____" /></div>
                        <div class="ui-block-c"><a href="#" id="txtStartDateClear" class="clrbutton">X</a></div>
                    </div>
                </div>
                <div id="divEndDate" data-role="fieldcontain">
                	<div class="ui-grid-b">
                        <div class="ui-block-a"><label id="lblEndDate" for="txtEndDate">End:</label></div>
                    	<div class="ui-block-b"><input type="text" name="txtEndDate" id="txtEndDate" placeholder="__/__/____" /></div>
                        <div class="ui-block-c"><a href="#" id="txtEndDateClear" class="clrbutton">X</a></div>
                    </div>
                </div>
                <div id="divApptName" data-role="fieldcontain">
                	<div class="ui-grid-b">
                        <div class="ui-block-a"><label id="lblApptName" for="txtApptName">Appt With:</label></div>
                    	<div class="ui-block-b"><input type="text" name="txtApptName" id="txtApptName" placeholder="" /></div>
                        <div class="ui-block-c"><a href="#" id="txtApptNameClear" class="clrbutton">X</a></div>
                    </div>
                </div>                
                </fieldset>
            </div>
            
			<div id="divFilters">
                <div id="divFilterList"></div>
            	<div id="divFilterDesc"></div>
            </div>
            
            <div id="divApptList" class="clear">
				<ul id="ulAppts" data-role="listview" data-theme="b" data-divider-theme="b"></ul>
            </div>
            
        </form>
	</div><!-- /content -->

	<?php include('_footer.php'); ?>
    
    <script type="text/javascript"> 		
	$("#listappts").submit(function(e) {
		$("#divApptFilter").trigger("collapse");
		myapptsview.removeAllFilters();
		myapptsview.setFilters();
		controller.getAppointments(myapptsview.filters);
		return false;
	});
    </script>                                                               

</div><!-- /page -->

</body>
</html>
