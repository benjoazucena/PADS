<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html class="no-js" lang="en">

    <head>
	 <!-- IMPORTS -->
    <script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/bootstrap.min.js"></script>
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <link rel="stylesheet" href="css/vendor.css">
    <link href='fullcalendar.css' rel='stylesheet' />
    <link href='calendar/fullcalendar.print.css' rel='stylesheet' media='print' />
	<script src='calendar/lib/moment.min.js'></script>
	<script src='calendar/fullcalendar.min.js'></script>
	<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
	<script src="js/dataTables.bootstrap.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	
 	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css">
	
	<!-- END IMPORTS -->
	
    <script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/bootstrap.min.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title> PAASCU - Accreditation Schedule Manager </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">
        <!-- Place favicon.ico in the root directory -->
        <link rel="stylesheet" href="css/vendor.css">
        <!-- Theme initialization -->
        <script>
            var themeSettings = (localStorage.getItem('themeSettings')) ? JSON.parse(localStorage.getItem('themeSettings')) :
            {};
            var themeName = themeSettings.themeName || '';
            if (themeName)
            {
                document.write('<link rel="stylesheet" id="theme-style" href="css/app-' + themeName + '.css">');
            }
            else
            {
                document.write('<link rel="stylesheet" id="theme-style" href="css/app.css">');
            }
        </script><link href='fullcalendar.css' rel='stylesheet' />
        
<link href='calendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='calendar/lib/moment.min.js'></script>
<script src='calendar/fullcalendar.min.js'></script>



<script>

	$(document).ready(function() {
		
		/* initialize the external events
		-----------------------------------------------------------------*/
</script>
<style>

	body {
		
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: -35px auto;
		padding: 10px;
background: rgba(255,255,255,1);
background: -moz-linear-gradient(45deg, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
background: -webkit-gradient(left bottom, right top, color-stop(0%, rgba(255,255,255,1)), color-stop(47%, rgba(246,246,246,1)), color-stop(100%, rgba(237,237,237,1)));
background: -webkit-linear-gradient(45deg, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
background: -o-linear-gradient(45deg, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
background: -ms-linear-gradient(45deg, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
background: linear-gradient(45deg, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#ededed', GradientType=1 );	
	 box-shadow: 1px 2px 5px #C0C0C0;
	}
	
	.fc-day-number{
		color: black;
	}
	
	#bg{
	height: 640px;
	position:fixed;
	}

</style>
</head>

    <body>
        <div class="main-wrapper"></div>
            <div class="app" id="app">
                <header class="header">
                    <div class="header-block header-block-collapse hidden-lg-up"> <button class="collapse-btn" id="sidebar-collapse-btn">
    			<i class="fa fa-bars"></i>
    		</button> </div>
                    <div class="header-block header-block-search hidden-sm-down">
                        <form role="search">
                            <div class="input-container"> <i class="fa fa-search"></i> <input type="search" placeholder="Search">
                                <div class="underline"></div>
                            </div>
                        </form>
                    </div>
					
                    
                    <div class="header-block header-block-nav">
                        <ul class="nav-profile">
                            <li class="notifications new">
                                <a href="" data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <sup>
    			      <span class="counter">1</span>
    			    </sup> </a>
                                <div class="dropdown-menu notifications-dropdown-menu">
                                    <ul class="notifications-container">
                                        <li>
                                            <a href="" class="notification-item">
                                                <div class="img-col">
                                                    <div class="img" style="background-image: url('assets/faces/marcos,nelson.jpg')"></div>
                                                </div>
                                                <div class="body-col">
                                                    <p> <span class="accent">Marcos, Nelson Phd</span> Achievement: <span class="accent">Completed 100th survey</span>. </p>
                                                </div>
                                            </a>
                                        </li>
                                       
                                    </ul>
                                    <footer>
                                        <ul>
                                            <li> <a href="">
    			            View All
    			          </a> </li>
                                        </ul>
                                    </footer>
                                </div>
                            </li>
                            
                        </ul>
                    </div>
                </header>
                <aside class="sidebar">
				
                    <div class="sidebar-container">
                    	
                        <div class="sidebar-header">
                            <div class="brand">
                                <div class="logo"> <span class="l l1"></span> <span class="l l2"></span> <span class="l l3"></span> <span class="l l4"></span> <span class="l l5"></span> </div> PAASCU </div>
                        </div>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="index.html"> <i class="fa fa-home"></i> Dashboard </a>
                               <li>
                                    <a href="survey.html"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addsurvey.html"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li class="active">
                                 <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                        <li > <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li> <a href="Institutions">
    								Institutions
    							</a> </li>
								 <li> <a href="SchoolSystems">
    							                School Systems
    							</a> </li>
								 <li  class="active"> <a href="Programs">
    								Programs
    							</a> </li>
								 
                                 
                                    </ul>
                                </li>
                                <li><a href="#demo3" data-toggle="collapse"> <i class="fa fa-bar-chart"></i> Reports <i class="fa arrow"></i> </a><ul id="demo3" class="collapse"><li> <a href="reportGA.html">GA Awardees</a> </li><li> <a href="reportHistory.html">History</a> </li></ul></li>
								<li>
								    <a href="notifications.html"> <i class="fa fa-bell-o"></i> Notifications <p style="width:15px; height:17px;text-align:center; border-radius:10px; font-family: Verdana; font-size:10px;float:right; background-color:red; color:white;">10</p></a> 
								 </li>
                                
                               
                            </ul>
                        </nav>
                    </div>
                    <footer class="sidebar-footer">
            
			
					
                </aside>
				
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				
                <article class="content dashboard-page">
				
				 <div class="title-block">
                        <h3 class="title" style="float:left;">
							<a href="Programs"> List of Programs </a> > Add New Program
						</h3>
			     </div>
				
				 <section class="section" id="section">   
						<div class="col-md-12">
									<div class="card card-block sameheight-item" style="height:320px;">
										<div class="title-block">
											<h3 class="title">
							New Program Form
						</h3> </div>
							<form method="post" action="AddProgram" class="form">
								<div class="form-group" style="width:48%; padding-right"> 
								<label class="control-label">Program Name</label> 
								<input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. BS-Biology" name="programName"> 
								</div>	
							<br>
							
							<label for="sel1">Survey Areas</label><hr>
								<div class="col-md-3">
								<label><input type="checkbox" class="checkbox rounded" value="Faculty" id="fac"><span>Faculty</span></label><br>
								<label><input type="checkbox" class="checkbox rounded" value="Instruction" id="ins"><span>Instruction</span></label>
								</div>
								<div class="col-md-3">
								<label><input type="checkbox" class="checkbox rounded" value="Laboratories" id="lab"><span>Laboratories</span></label>
								<label><input type="checkbox" class="checkbox rounded" value="Libraries" id="lib"><span>Libraries</span></label>
								</div>
								<div class="col-md-3">
								<label><input type="checkbox" class="checkbox rounded" value="Community" id="com"><span>Community</span></label>
								<label><input type="checkbox" class="checkbox rounded" value="Physical Plant" id="phy"><span>Physical Plant</span></label>
								</div>
								<div class="col-md-3">
								<label><input type="checkbox" class="checkbox rounded" value="Student Services" id="stu"><span>Student Services</span></label>
								<label><input type="checkbox" class="checkbox rounded" value="Administration" id="adm"><span>Administration</span></label>
								</div>
							<div class="col-md-12">
								<div class="form-group">
									<hr>
									<button type="submit" class="btn btn-info" style="float:right; padding-right:15px;"><em class="fa fa-floppy-o"></em>  Submit </button>
									<br><br><br>
								</div>
							</div>
							</form>
						
						</div>
					</div>	
				   </section>
				   
					
				  
                </article>
             
             
        		  
        <!-- Reference block for JS -->
        <div class="ref" id="ref">
            <div class="color-primary"></div>
            <div class="chart">
                <div class="color-primary"></div>
                <div class="color-secondary"></div>
            </div>
        </div>
       </div></div>
        <script src="js/app.js"></script>
		
		
		</body>

</html>