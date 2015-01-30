<?php  
$pagenav = 'makeappt'; /*for setting the "selected" page navigation */
include "_header.php"; ?>

<script type="text/javascript" language="javascript" src="../models/waspcalendar.js"></script>
<script type="text/javascript" language="javascript" src="../models/block.js"></script>
<script type="text/javascript" language="javascript" src="makeapptview.js"></script>
<script type="text/javascript">
   	$(document).ready(function() {
		makeapptview.setPageVars();
	}); 
</script> 
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-38178606-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>                                                     
</head>

<body>

<div data-role="page" id="makeappt">

	<div data-role="header" data-backbtn="false">
		<?php include('_mainmenu.php'); ?>
	</div><!-- /header -->

	<div data-role="content">	
		<h1 id="pagetitle" class="clear">Title</h1>      
    	<form id="search" method="post" action="#" data-ajax="false">

            <div class="instructions"></div>
            <div data-role="fieldcontain">
                <label for="txtSearch" class="ui-hidden-accessible">Search Text:</label>
                <input type="search" name="txtSearch" id="txtSearch" value="" placeholder="" />
            </div>
            
            <div id="divResults">   
            	<hr>
                <div id="divCalendars"></div>
            </div>
        </form>
	</div><!-- /content -->

	<?php include('_footer.php'); ?>

	<script type="text/javascript"> 
	$("#search").submit(function(e) {
		controller.searchCalendarsByString($("#txtSearch").val());
		//$("#txtSearch").blur();
		return false;
	});
    </script>                                                               

</div><!-- /page -->

</body>
</html>
