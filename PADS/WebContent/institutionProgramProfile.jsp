<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!doctype html>
<html class="no-js" lang="en">
<%@page import="Models.ProgramSurvey" %>
											<%@page import="java.util.*" %>
											<% ArrayList<ProgramSurvey> hist = (ArrayList<ProgramSurvey>)request.getAttribute("history"); %>
											<% String programName = (String)request.getAttribute("programName"); %>
											<% String instName = (String)request.getAttribute("instName"); %>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title> PAASCU - Accreditation Schedule Manager </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       	 <!-- IMPORTS -->
	<link rel="stylesheet" href="chosen/chosen.css">
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
	<script src="chosen/chosen.jquery.js" type="text/javascript"></script>
	
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
	<link rel="stylesheet" href="css/app.css">
        <link rel="stylesheet" href="css/vendor.css">
        <!-- Theme initialization -->
		
		<script>
$(document).ready(function() {

		
	  $('#smarttable').DataTable( {
	    	dom: 'Blfrtip',
	    	buttons: [
	                  {
	                	  extend: 'pdfHtml5',
	                	  title: "Institution Program History - <%=instName%>"  ,
	                	  download: 'open',
	                	  exportOptions: {
	                          columns: [ 0, 1,2,3,4]
	                      }
	                  },
	                  {
	                	  extend: 'excelHtml5',
	                	  title: "List of Disciplines",
	                	  exportOptions: {
	                          columns: [ 0, 1]
	                      }
	                  }
	                  
	        ],
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
</script>
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
		top:124px;  
		height:7px; 
		-webkit-box-shadow: 0px 2px 6px 2px rgba(50, 50, 50, 0.58);
		-moz-box-shadow:    0px 2px 6px 2px rgba(50, 50, 50, 0.58);
		box-shadow:         0px 2px 7px 2px rgba(50, 50, 50, 0.58); 
		font-family:Existence-Medium;
		color:#f4f4f4;
		font-size:90%;
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#eaeaea+0,eae8e8+49,dadada+51,b2b0b0+100 */
background: rgb(234,234,234); /* Old browsers */
background: -moz-linear-gradient(top,  rgba(234,234,234,1) 0%, rgba(234,232,232,1) 49%, rgba(218,218,218,1) 51%, rgba(178,176,176,1) 100%); /* FF3.6-15 */
background: -webkit-linear-gradient(top,  rgba(234,234,234,1) 0%,rgba(234,232,232,1) 49%,rgba(218,218,218,1) 51%,rgba(178,176,176,1) 100%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to bottom,  rgba(234,234,234,1) 0%,rgba(234,232,232,1) 49%,rgba(218,218,218,1) 51%,rgba(178,176,176,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#eaeaea', endColorstr='#b2b0b0',GradientType=0 ); /* IE6-9 */

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
		
	#bPending{
position:relative;
top:80px;
left:17%;
-webkit-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
}
#bPending:hover{

top:83px;
-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);

}
#bc{
position:relative;float:left;top:20px;left:30px;color:white;
}

#bc:hover{ color:green}



</style>
    </head>

    <body>
        <div class="main-wrapper">
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
                                    <a href="Notifications"> <i class="fa fa-home"></i> Dashboard </a>
                                </li>
								<li>
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addsurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li class="active open">
                                <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                        <li > <a href="accreditors.html">
    								Accreditors
    							</a> </li>
                                        <li> <a href="School Systems.html">
    								School System
    							</a> </li>
								 <li class = "active" > <a href="schoolSystems.html">
    							                School Systems
    							</a> </li>
								 <li> <a href="programs.html">
    								Disciplines </a></li>
								 
                                 
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
				
				
				<div class="container">
	<video poster="assets/banner.jpg" id="bgvid"  playsinline autoplay muted loop>
  <!-- WCAG general accessibility recommendation is that media such as background video play through only once. Loop turned on for the purposes of illustration; if removed, the end of the video will fade in the same way created by pressing the "Pause" button  -->

<source src="assets/vid.mp4" type="video/mp4">
</video>
</div>
            <div id="welcome">
			  <h1 class="title"  >
							<a style="color:white;" href="javascript:history.back()"><em class="fa fa-arrow-circle-left"></em> Back </a> 
						</h1>
			
						
			</div>
			   <header class="header" id="customheader">
			   
					
                </header>
				<article class="content grid-page">
                    <div class="title-block">
                        <h3 class="title" style="float:left;">
							<a href="javascript:history.back()"><em class="fa fa-arrow-circle-left"></em> Back </a> 
						</h3>
						
						
                    </div>
					
					<section class="section" style="position:relative;top:-150px;">
                        <div class="row sameheight-container">
                            <div class="col-md-12">
                                <div class="card sameheight-item">
                                    <div class="card-block">
										<section class="section">
											<div class="row">
											
												<div class="col-md-12">
													<h2 >
													History
													</h2>
													<h3><small>
													<%=instName %> : 
													<%=programName %></small>
													</h3>
													
												</div>
												
											</div>
										</section>
                                        <section class="section">

                                         
  
									<hr><div class="row" style="width:100%">
                                                <table id="smarttable" class="table table-striped table-bordered table-hover" style ="width:100%" >
                                                    <thead>
                                                      <tr>
                                                            <th>Survey Date</th>
                                                            <th>Survey Type</th>
                                                            <th>Board Approval</th>
															<th width="20%">Decision</th>
															<th>Expiry Date</th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
													<%for(ProgramSurvey ps: hist){ %>
                                                        <tr>
                                                            <td><%=ps.getSurveyDate()%></td>
                                                            <td><%=ps.getSurvey_type()%></td>                                                           
                                                            <td><%=ps.getDecision_date()%></td>
                                                            <td><%=ps.getBoard_decision()%></td>
                                                            <td><%=ps.getValid_thru()%></td>
                                                        </tr>
													<%} %>
														
														
														
                                                    </tbody>
                                                </table>
                                                </div>
											
                                            </div>
											
                                        </section>
                                    </div>
                                </div>
                            </div>
                        
                    </section>
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				

		  <!-- EVENT MODAL -->
       	<div id="surveyModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body"></div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)"><em id="delIcon" class="fa fa-trash-o"></em></button>
                	
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