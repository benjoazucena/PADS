<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title> PAASCU - Accreditation Schedule Manager </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">
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
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href=" css/dataTables.bootstrap.min.css">
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
	
 	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css">
	
	<!-- END IMPORTS -->
	<script>
		$(document).ready(function() {
			$('#smarttable').DataTable();
		} );
	</script>
	<link rel="stylesheet" href="css/app.css">
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
        </script>


<style>

	body {
		
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	#bg{
	height: 640px;
	position:fixed;
	}

</style>
    </head>

    <body>
        <div class="main-wrapper">
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
				<img id="bg" src="assets/bg.jpg">
                    <div class="sidebar-container">
                        <div class="sidebar-header">
                            <div class="brand">
                                <div class="logo"style="width:100%"> <img src="assets/logoicon.png" style="width:90%;height:170%; top:-5%;left:-5%; opacity:1"> </div>
                        </div>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="Notifications"> <i class="fa fa-home"></i> Dashboard </a>
                                </li>
								<li>
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addSurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li class="active open">
                                <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                        <li > <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li> <a href="Institutions">
    								Institutions
    							</a> </li>
								 <li class = "active" > <a href="SchoolSystems">
    							                School Systems
    							</a> </li>
								 <li> <a href="Programs">
    								Disciplines </a></li>
								 
                                 
                                    </ul>
                                </li>
                                <li><a href="#demo3" data-toggle="collapse"> <i class="fa fa-bar-chart"></i> Reports <i class="fa arrow"></i> </a><ul id="demo3" class="collapse"><li> <a href="reportGA.html">GA Awardees</a> </li><li> <a href="reportHistory.html">History</a> </li></ul></li>
								<li>
								  
								 
								 </li>
                                
                               
                            </ul>
                        </nav>
                    </div>
					
					
 
                    <footer class="sidebar-footer">
            
			
					
                </aside>
				<article class="content grid-page">
                    <div class="title-block">
                        <h3 class="title" style="float:left;">
							<a href="Programs"><em class="fa fa-arrow-circle-left"></em> Program List </a> 
						</h3>
						
						
                    </div>
					
					<section class="section">
                        <div class="row sameheight-container">
                            <div class="col-md-12">
                                <div class="card sameheight-item">
                                    <div class="card-block">
										<section class="section">
											<div class="row">
												<div class="col-md-8">
													<h2 >
													<c:out value="${ program.getName() }" />
													</h2>
													</div>
												
											</div>
										</section>
                                        <section class="section">

                                           
									
                                                <table id="smarttable" class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                      <tr>
                                                            <th>Degree Program Name</th>
                                                            <th>Institutions</th>
                                                            <th>Next Survey Date</th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
													
                                                     <c:forEach items="${program.getSps()}" var="sp">
															<tr>
																<td><c:out value="${sp.getDegree_name()}"/></td>
																<td><c:out value="${sp.getInstitution()}"/></td>
																<td><c:out value="${sp.getNext_survey_sched()}"/></td>
															</tr>
													</c:forEach>
														
														
														
                                                    </tbody>
                                                </table>
											
                                            </div>
											
                                        </section>
                                    </div>
                                </div>
                            </div>
                        
                    </section>
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				

				
             
        <!-- Reference block for JS -->
        <div class="ref" id="ref">
            <div class="color-primary"></div>
            <div class="chart">
                <div class="color-primary"></div>
                <div class="color-secondary"></div>
            </div>
        </div>
          
        <script src="js/app.js"></script>
	
    </body>

</html>