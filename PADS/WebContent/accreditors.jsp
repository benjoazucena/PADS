<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html class="no-js" lang="en">
	
    <head>
    	 <!-- IMPORTS -->
	
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <link rel="stylesheet" href="css/vendor.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href=" css/dataTables.bootstrap.min.css">
	<link href="css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />	
	<link href="css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css" media="all" />	
	<link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" media="all" />	
	<link href="css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" media="all" />	
	
	<script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
	<script src="js/dataTables.buttons.min.js"></script>
	<script src="js/dataTables.jqueryui.min.js"></script>
	<script src="js/buttons.print.min.js"></script>
	<script src="js/jszip.min.js"></script>
	<script src="js/pdfmake.min.js"></script>
	<script src="js/buttons.html5.min.js"></script>
	<script src="js/vfs_fonts.js"></script>
	
	<!-- END IMPORTS -->
    	
    	
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
        </script>
		
	
<script>
$(document).ready(function() {

    $('#smarttable').DataTable( {
    	dom: 'Bfrtip',
    	buttons: [
                  {
                	  extend: 'pdfHtml5',
                	  title: "List of Accreditors",
                	  download: 'open',
                	  exportOptions: {
                          columns: [ 0, 1, 2, 3 ]
                      }
                  },
                  {
                	  extend: 'excelHtml5',
                	  title: "List of Accreditors",
                	  exportOptions: {
                          columns: [ 0, 1, 2, 3 ]
                      }
                  }
                  
        ]
    } );

	
		
	
		
} );
$.fn.dataTable.ext.errMode = 'none';
</script>

<style>

	#contenthole{
		-webkit-box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		-moz-box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		padding:15px;
		background-color: #f8f8f8;
		

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

	#bgvid{
		position:relative;
		top:-400px;
		margin-top:0px;
		width:115%	}

	body {		
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;	}
		
	#bg{
		height: 640px;
		position:fixed;	}
	
	#main{
		position:relative;
		top:-290px;	}
	
	#pnum_danger,#pnum_info,#pnum_warning,#pnum_primary{
		font-size:75px; 
		text-align:center;
		margin-left: -2px;
		padding: 0;
		
		line-height:85px;	}
		
	#pnum_danger{
	color:#ff2b2b;	}
	
	#pnum_warning{
		color:#fe8832;	}
	
	#pnum_info{
		color:#5ecdf3;	}
	
	#pnum_primary{
		color:#85CE36;	}
	
	#psub{
		font-size:17px; 
		color:#bcbcbc;
		text-align:center;
		margin-top: 6px;
		padding: 0;
		line-height:20px;	}
	
	#bc {
		color:white;	}
	
	#bc:hover { 
		color:#85CE36;	}
	
	#welcome{
		position:relative;
		top:-65px;
		color:white;
		left:20px;
		font-family:Existence-Light;	}
		
	.h1{
		font-size:100%;	}
	
	@font-face {
		font-family: Existence-Light;
		src: url(fonts/Roboto-Thin.ttf);}
		
	@font-face {
		font-family: Existence-Medium;
		src: url(fonts/Roboto-Regular.ttf);	}
			
	#notifcard{
		-webkit-box-shadow: 0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		-moz-box-shadow:    0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		box-shadow:         0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		width:87%;
		left:15px;	}
	
	#customheader{
		overflow:hidden;
		top:122px;  
		height:10px; 
		-webkit-box-shadow: 0px 2px 6px 2px rgba(50, 50, 50, 0.58);
		-moz-box-shadow:    0px 2px 6px 2px rgba(50, 50, 50, 0.58);
		box-shadow:         0px 2px 7px 2px rgba(50, 50, 50, 0.58); 
		font-family:Existence-Medium;
		color:#f4f4f4;
		font-size:90%;
		/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#e2e2e2+0,dbdbdb+50,d1d1d1+51,fefefe+100;Grey+Gloss+%231 */
		background: rgb(226,226,226); /* Old browsers */
		background: -moz-linear-gradient(top,  rgba(226,226,226,1) 0%, rgba(219,219,219,1) 50%, rgba(209,209,209,1) 51%, rgba(254,254,254,1) 100%); /* FF3.6-15 */
		background: -webkit-linear-gradient(top,  rgba(226,226,226,1) 0%,rgba(219,219,219,1) 50%,rgba(209,209,209,1) 51%,rgba(254,254,254,1) 100%); /* Chrome10-25,Safari5.1-6 */
		background: linear-gradient(to bottom,  rgba(226,226,226,1) 0%,rgba(219,219,219,1) 50%,rgba(209,209,209,1) 51%,rgba(254,254,254,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#e2e2e2', endColorstr='#fefefe',GradientType=0 ); /* IE6-9 */	}
	
	#customheader h2{
	color:black;	}
		
	#maincard{
		width:100%;
		padding:0px;
		background-color: #ffffff;
		top:-50px;
		margin-bottom: 10px;
		margin-top: 0px;
		height:700px;
		border-radius: 3px;
	   
		-webkit-box-shadow: 0px 9px 24px 0px rgba(0,0,0,0.75);
		-moz-box-shadow: 0px 9px 24px 0px rgba(0,0,0,0.75);
		box-shadow: 0px 9px 24px 0px rgba(0,0,0,0.75);	}
		
</style>
    </head>

    <body>
	
        <div class="main-wrapper" style="z-index:1;">
            <div class="app" id="app">
				   
               <aside class="sidebar">
				<img id="bg" src="assets/bg.jpg">
                    <div class="sidebar-container">
                         <div class="sidebar-header">
                            <div class="brand">
                                <div class="logo"> <span class="l l1"></span> <span class="l l2"></span> <span class="l l3"></span> <span class="l l4"></span> <span class="l l5"></span> </div> PAASCU </div>
                        </div>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="index.html"> <i class="fa fa-home"></i> Dashboard </a>
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
                                  
                                        <li class="active"> <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li> <a href="Institutions">
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
				  
				<div class="container">
	<video poster="assets/banner.jpg" id="bgvid"  playsinline autoplay muted loop>
  <!-- WCAG general accessibility recommendation is that media such as background video play through only once. Loop turned on for the purposes of illustration; if removed, the end of the video will fade in the same way created by pressing the "Pause" button  -->

<source src="assets/vid.mp4" type="video/mp4">
</video>
</div>
            <div id="welcome">
			<h1>List of Accreditors</h1>
			
						<button type="button"  style="float:right; position:relative;left:-50px; top:-52px; color:#3c4731;" class="btn btn-oval btn-secondary" onclick="location.href='addAccreditor.html';"><em class="fa fa-plus"></em><b> Add Accreditor</b></button>
                   
			</div>
			   <header class="header" id="customheader">
			   
					
                </header>
                <article class="content dashboard-page"  >
                    <section class="section" style="position: relative; top:-135px; left:-25px; width:105%;" >
                      
					
					
						
					
                                            <div class="table-responsive" style="width:100%; float:right;" id="contenthole">
										
                                                <table id="smarttable" class="table table-striped table-bordered table-hover" style="width:100%">
												   
                                                    <thead>
                                                      <tr>
                                                            <th>Full Name</th>
                                                            <th>Discipline/Program of Study</th>
															<th>Total Surveys</th>
                                                            <th>City</th>
                                                            <th>Controls</th>
                                                        </tr>
                                                    </thead>
													
                                                    <tbody>
														<c:forEach items="${accreditors}" var="acc">
												        <tr>
												          <td><c:out value="${acc.getFullName()}"/></td>
												          <td><c:out value="${acc.getDiscipline()}"/></td>
												          <td><c:out value="${acc.getTotalSurveys()}"/></td>
												          <td><c:out value="${acc.getCity()}"/></td>
												          <td>
												          <a href="ViewAccreditor?accreditorID=<c:out value='${acc.getAccreditorID()}'/>">View</a>
												          <a href="EditAccreditor?accreditorID=<c:out value='${acc.getAccreditorID()}'/>">Edit</a>
												          <a href="DeleteAccreditor?accreditorID=<c:out value='${acc.getAccreditorID()}'/>">Delete</a></td>
												        </tr>
												        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </section>
                                    </div>
                                </div>
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

        <script src="js/app.js"></script>

    </body>

</html>