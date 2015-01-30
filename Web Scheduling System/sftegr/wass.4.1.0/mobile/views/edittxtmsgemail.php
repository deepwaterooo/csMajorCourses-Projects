<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit Text Message E-Mail</title>
<link rel="stylesheet" href="../css/jquery.mobile-1.1.0-rc.1.css" />
<link rel="stylesheet" href="../css/custom.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.5.2.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/mobile/1.0a4.1/jquery.mobile-1.0a4.1.min.js"></script>
<script type="text/javascript"> 
</script>                                                               
</head>

<body>

<!-- Edit Text Message E-Mail -->
<div data-role="page" id="txtmsgemail">

	<div data-role="header" data-backbtn="false">
	</div><!-- /header -->

	<div data-role="content">	
		<h1 class="clear"><?php echo $pagetitle; ?></h1>      
    	<form id="txtmsgemail" action="#">
        
            <div class="instructions">Select your service provider and enter your cell phone number to have a text sent to your phone.</div>
            <div data-role="fieldcontain">
                <label for="txtSearch" class="ui-hidden-accessible">Search Text:</label>
                <input type="search" name="txtSearch" id="txtSearch" value="" placeholder="netID, name, or calendar title" />
            </div>
		</form>
	</div><!-- /content -->

	<div data-role="footer">
	</div><!-- /footer -->

	<script type="text/javascript"> 
    </script>                                                               

</div><!-- /page -->

</body>
</html>
