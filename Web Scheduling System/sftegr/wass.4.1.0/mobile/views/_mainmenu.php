<?php 
$selectedclass = ' class="ui-btn-active"';
?>
	
    	<div class="logo floatleft">
        	<img src="../images/smclock.jpg" alt="WASP" border="0" class="icon floatleft" />
        	<h2><?php echo wassParms::SYSID; ?><br></h2>
        </div>
        <div id="nav" data-role="navbar">
            <ul>
                <li><a href="myappts.php" rel="external"<?php if ($pagenav == 'myappts') echo $selectedclass; ?>>My Appts</a></li>
                <li><a href="makeappt.php" rel="external"<?php if ($pagenav == 'makeappt') echo $selectedclass; ?>>Make Appt</a></li>
                <li><a href="logout.php" rel="external"<?php if ($pagenav == 'logout') echo $selectedclass; ?>>Log Out</a></li>
           </ul>
        </div>
        <div id="divMessage"></div>