<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
		$(document).ready(function() {

     $('#smarttable').DataTable( {
        "scrollX": true
    } );

    $('#smarttable').DataTable( {
	
        initComplete: function () {
            this.api().columns().every( function () {
                var column = this;
                var select = $('<select><option value=""></option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
 
                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );
 
                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        }
    } );

	
		$('#smarttable tbody').on( 'click', 'tr', function () {
		document.location.href='institutionProgramProfile.html';
		} );
	
		
} );

$(document).ready(function() {
			$('#smarttable2').DataTable();
		} );
$.fn.dataTable.ext.errMode = 'none';
		
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
            
function goToAddProgramToInstitution(ID){
	
	document.location.href='addProgramToInst.jsp?ID=' + ID;

	
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
	
	#smarttable2{
	
	}
	
	#smarttable th, #smarttable td {		
		text-align: left;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;	}
		
	#smarttable th{
		background-color:#85CE36; !important
		color:#3c4731;
		font-size:110%;		}

	#smarttable td{
		padding:15px;
		padding-left:10px;
		border: none;
		color:#3c4731;		}


	#smarttable tr:nth-child(even){
		background-color:#e6f2da;}
	
	.container{
		width: 125%;
		overflow:hidden;
		display:block;
		height: 130px;
		z-index:-1;
		margin-left:-15px;}
		
	#smarttable tr:hover {
		background: rgba(255,255,255,1);
		background: -moz-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
		background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(255,255,255,1)), color-stop(47%, rgba(246,246,246,1)), color-stop(100%, rgba(237,237,237,1)));
		background: -webkit-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
		background: -o-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
		background: -ms-linear-gradient(top, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
		background: linear-gradient(to bottom, rgba(255,255,255,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%);
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#ededed', GradientType=0 );

		-webkit-box-shadow: inset 0px 1px 5px 0px rgba(0,0,0,0.49);
		-moz-box-shadow: inset 0px 1px 5px 0px rgba(0,0,0,0.49);
		box-shadow: inset 0px 1px 5px 0px rgba(0,0,0,0.49);
		cursor: pointer;}
		
	#bPending{


-webkit-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
}
#bPending:hover{

top:3px;
-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);

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
                                        <li class = "active" > <a href="Institutions">
    								Institutions
    							</a> </li>
								 <li> <a href="SchoolSystems">
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
                        <% String systemName = (String)request.getParameter("systemName"); %>
							<a href="javascript:history.back()"><em class="fa fa-arrow-circle-left"></em> <%=systemName %> Profile </a> 
						</h3>
						
						<h3 class="title" style="float:right;">
							<em class="fa fa-pencil"></em> Edit
                        </h3>
                    </div>
					
					<section class="section">
                        <div class="row sameheight-container">
                            <div class="col-md-12">
                                <div class="card sameheight-item">
                                    <div class="card-block">
										<section class="section">
											<div class="row">
												<div class="col-md-12" >
										<%@page import="Models.Institution" %>
										<% Institution inst = (Institution)request.getAttribute("institution"); %>
													<h2>
													<%=inst.getName() %> - <%=inst.getDate_added() %>
													</h2>
													<h6><%=inst.getAddress() %></h6>
													<hr>
												</div>
												
												
											</div>
										</section>
                                        <section class="section">
										
													
                                            <div class="row">
                                                <div class="col-md-6"style="margin-left:20px;">
                                                    <p>
													
													Institution Head: 	
													<%= inst.getHead() %>
													<br>
													Position:
													<%= inst.getPosition() %><br>
													Email:
													<%= inst.getEmail() %>
													
													<br><br>
													
													Contact Person: 
													<%= inst.getContact_person() %>	
													<br>
													Contact Number:
													<%= inst.getContact_number()%>
													<br>
													lazojennifer@yahoo.com<br>
													</p>
                                                </div>
                                                <div class="col-md-4">
                                                   
													
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8"style="margin-left:20px;">
                                                  Tel. Nos.: <%= inst.getFax()%><br>
													(632) 523-4148 (direct line)<br>
													Fax No.: (632) 521-9094<br>
													E-mail: <%= inst.getEmail()%><br>
													Website: <%= inst.getWebsite()%>
                                                </div>
                                          
												
                                                <div class="col-md-4">
                                                   
                                                </div>
                                            </div>
                                            <div class="row">
                                               
                                                <div class="col-md-12">
													<br><hr>
                                                    <button type="button" style="float:right; width:260px;"  class="btn btn-secondary btn-sm" onclick="goToAddProgramToInstitution(<%= inst.getInstitutionID()%>)"><em class="fa fa-plus"></em>Add Programs to this Institutions</button><br>
                                                 </div>
                                            </div>
											
											
									
                                                <table id="smarttable" class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                      <tr>
                                                            <th>Program Name</th>
                                                            <th>End Date of Last Survey</th>
                                                            <th>Accreditation Expiry</th>
															<th>Level</th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
													<c:forEach items="${programs}" var="pp" >
                                                        <tr>
                                                            <td><c:out value="${pp.getDegree_name()}"/> </td>
                                                            <td><c:out value="${pp.getDate_added()}"/></td>                                                 
                                                            <td><c:out value="${pp.getNext_survey_sched()}"/></td>
                                                              <td><c:out value="${pp.getLevel()}"/></td>
                                                            
                                                        </tr>
														
													</c:forEach>				
														
                                                    </tbody>
                                                </table>
												
												<hr>
												
																							
									
                                              
											
                                            </div>
											
                                        </section>
                                    </div>
                                </div>
                            </div>
                        
                    </section>
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				

		  <!-- EVENT MODAL -->
       	<div id="surveyModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:80%;">
        		<div class="modal-content">
					<div class="modal-body">
						  <table id="smarttable2" class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                      <tr>
                                                            <th>Program Name</th>
                                                            <th>Survey Type</th>
                                                            <th>Star Date</th>
															<th>End Date</th>
															<th>Board Approval Date</th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
													
                                                        <tr>
                                                            <td>Computer Science with specialization in Software Technology</td>
                                                            <td>Preliminary</td>
                                                            <td>September 21, 2000</td>
                                                            <td>September 22, 2000</td>
                                                            <td>November 11, 2000</td>
                                                            
                                                        </tr>
														
														
                                                    </tbody>
                                                </table>
					
					</div>
        		</div>
    		</div>
		
		</div>				
             
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