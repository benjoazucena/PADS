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
            
function goToAddProgramToInstitution(ID, Name){
	var apoName = Name.replace("&apo;","'");
	alert(apoName);
	document.location.href='addProgramToInst.jsp?ID=' + ID+'&Name=' + apoName;

	
}        

function saveLevel(){
	document.getElementById("editLevelButton").style.display = "block";
	document.getElementById("saveLevelButton").style.display = "none";
	var table = document.getElementById("smarttable");
	for (var i = 1, row; row = table.rows[i]; i++) {
	   //iterate through rows
	   //rows would be accessed using the "row" variable assigned in the for loop
	   var levelTemp = row.cells[4].children[0].value;
	   row.cells[4].innerHTML = levelTemp;
 	   var SPID =  row.cells[0].innerHTML;
 	   var level= levelTemp;
 	  $.ajax({url: "UpdateLevel?SPID=" + SPID+"&level="+level, success: function(result){
 	        alert(result);
 	    }});
 		
	}
	
	
}
function editLevel(){
	document.getElementById("editLevelButton").style.display = "none";
	document.getElementById("saveLevelButton").style.display = "block";
	var table = document.getElementById("smarttable");
	for (var i = 1, row; row = table.rows[i]; i++) {
	   //iterate through rows
	   //rows would be accessed using the "row" variable assigned in the for loop
	   var levelTemp = row.cells[4].innerHTML;
	   row.cells[4].innerHTML = "<input style = 'width:22%' type='text' value='"+ levelTemp +"'/>" 
	}
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
						<%@page import="Models.Institution" %>
						<% Institution inst = (Institution)request.getAttribute("institution"); %>
										
                     
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
							<a href="Institutions"><em class="fa fa-arrow-circle-left"></em> Institutions List </a> 
						</h3>
						
						<h3 class="title" style="float:right;">
							<a href="EditInstitution?institutionID=<%=inst.getInstitutionID()%>"><em class="fa fa-pencil"></em> Edit </a>
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
												<h2>
													<%=inst.getName() %> - <%=inst.getCity() %>
													</h2>
													<h6><%=inst.getAddress() %></h6>
													<h6>Date of Membership: <%=inst.getDate_addedWord() %></h6>
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
													<%= inst.getContact_email()%><br>
													</p>
                                                </div>
                                                <div class="col-md-4">
                                                   
													
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8"style="margin-left:20px;">
                                                  Tel. Nos.: (632)<%= inst.getFax()%><br>
													
													E-mail: <%= inst.getEmail()%><br>
													Website: <%= inst.getWebsite()%>
                                                </div>
                                          
												
                                                <div class="col-md-4">
                                                   
                                                </div>
                                            </div>
                                            <div class="row">
                                               
                                                <div class="col-md-12">
													<br><hr>
													<%String instApo = inst.getName().replaceAll("'", "&apo;");%>
													 <button type="button" style="float:right; width:260px;"  class="btn btn-secondary btn-sm" onclick="goToAddProgramToInstitution('<%= inst.getInstitutionID()%>','<%=instApo%>')"><em class="fa fa-plus"></em>Add Programs to this Institutions</button><br>
                                                <br>
                                                    <button type="button" id="editLevelButton"style="float:right; width:260px;"  class="btn btn-secondary btn-sm" onclick="editLevel()">Edit 'Level' of the programs</button>
                                                <button type="button" id="saveLevelButton"style="display:none;float:right; width:260px;"  class="btn btn-secondary btn-sm" onclick="saveLevel()">SAVE 'Level' of the programs</button><br>
                                                 </div>
                                            </div>
											
											
									
                                                <table id="smarttable" class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                      <tr>
                                                      <th>Program ID</th>
                                                            <th>Program Name</th>
                                                            <th>Date of Last Survey</th>
                                                            <th>Accreditation Lapse Date</th>
															<th>Level</th>
															<th>History</th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
													<c:forEach items="${programs}" var="pp" >
                                                        <tr>
                                                      <td><c:out value="${pp.getSPID()}"/> </td>
                                                            <td><c:out value="${pp.getDegree_name()}"/> </td>
                                                            <td><c:out value="${pp.getDate_addedWord()}"/></td>                                                 
                                                            <td><c:out value="${pp.getNext_survey_sched()}"/></td>
                                                              <td><c:out value="${pp.getLevel()}"/></td>
                                                              <td><a href="ViewInstitutionProgramProfile?programName=<c:out value="${pp.getDegree_name()}"/>&SPID=<c:out value="${pp.getSPID()}"/>">View</a></td>
                                                            
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