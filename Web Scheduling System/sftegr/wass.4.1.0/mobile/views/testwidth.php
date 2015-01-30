<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="ui-mobile">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title><?php echo $pagetitle; ?></title>
<link type="text/css" rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>

</head>

<body>

<div data-role="page" id="makeappt">

	<div data-role="header">
	</div><!-- /header -->

	<div data-role="content">	
		<h1 id="pagetitle" class="clear">Title</h1>      
    	<form id="search" method="post" action="#" data-ajax="false">

            <div>Search for a calendar by netID, name, or calendar title to make an appointment.</div>
           <!-- <div data-role="fieldcontain">
                <label for="txtSearch" class="ui-hidden-accessible">Search Text:</label>
                <input type="search" name="txtSearch" id="txtSearch" value="" placeholder="netID, name, or calendar title" />
            </div>-->
            
            <div>   
            	<hr>
                <div id="divCalendars"></div>
            </div>
        </form>
	</div><!-- /content -->

	<div data-role="footer">
	</div><!-- /header -->
    
</div><!-- /page -->

</body>
</html>
