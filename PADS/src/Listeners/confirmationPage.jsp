<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!doctype html>
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
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href=" css/dataTables.bootstrap.min.css">
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
	
 	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css">
	
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
	start();
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
		document.location.href='accreditorProfile.html';
		} );
		
		
	
		
	
		
} );
$.fn.dataTable.ext.errMode = 'none';




function start(){
	alert("start");
	
	var ID = <%=request.getAttribute("surveyID")%> ;
	alert(ID);
	
$.ajax({
	  url: "ConfirmationPageLoader?surveyID=" + ID,
	  dataType: 'json',
	  async: false,
	  error:function(){alert("fail")},
	  success: function(data) {
		alert("suc");
		
		
		
		
		
		
		  var add = "";
		  add += ("<ul class='list-group'> <br>") ;
		  
		  $.each(data, function (key, value){
			
		var title = "<h4>Institution: "+value.title+"</h4><h6>Date: "+value.start+"</h6>";
		$('#surveyTitle').append(title);
			  
			
// 			  var ctype = "";
// 				 if(value.programs[i].surveyType == "Preliminary" ){ctype = "preliminaryConfirm";}
// 				if(value.programs[i].surveyType == "Consultancy"){ctype = "consultancyConfirm";}
// 				 if(value.programs[i].surveyType == "Formal"){ctype = "formalConfirm";}
// 				 if(value.programs[i].surveyType == "Resurvey"){ctype = "resurveyConfirm";};
				 
			  
		for(var i = 0; i < value.programs.length; i++){ 
			var link = getLink(value.programs[i].surveyType,i, ID);
							  
				  
			 add += (" <li class='list-group-item'>");
			 add += ("<div class='col-md-12' style='position:relative; left:-15px;''><label><h5>" + value.programs[i].programName + " - " + value.programs[i].surveyType + "</h5></label>"); 
			    add += ("<button id='bPending' type='button' class='btn btn-danger btn-sm' onClick="+link+"><i class='fa fa-plus'></i>Survey Decision</button><br><br> </div>			<br><br> ");
			    add += ("<table class='table'> ");
			   		add += ("<thead><tr><th style='width: 20%;'>Name</th> <th style='width: 50%;'>Area</th> <th style='width: 30%;'>Confirm Attendance</th></tr></thead> ");
			    	add += (" <tbody> ");
			    	
			    	 for(var j = 0; j < value.programs[i].areas.length; j++){
			    		var checked = checkAttendance(value.programs[i].areas[j].confirmation)
			    	 
			    		add += ("<tr > ");
			    		add += ("<td><a href='ViewAccreditor?accreditorID=" + value.programs[i].areas[j].accreditorID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>"+ value.programs[i].areas[j].accreditor + "</a></td><td>" + value.programs[i].areas[j].area + "</td>");
			    		
			   				add += ("<td><label><input type='checkbox' "+ checked +" onclick='confirmAccreditor(" + j + "," + value.programs[i].areas[j].areaID + "," + value.programs[i].areas[j].accreditorID + ")' class='checkbox rounded' value='Confirm Attendance' id='checkbox_confirm"+value.programs[i].areas[j].accreditorID+"'><span>Confirm</span></label> <button class='btn btn-link btn-sm' id='changedbutton"+value.programs[i].areas[j].accreditorID+"'><i class='fa fa-pencil'></i>Changed</button></td>");
			 					
			    			add += ("</tr> ");
			    	 }
			    		add += ("</tbody> ");
			    add += ("</table> ");
			  
			    
			 add += ("</li><br>");
			  }
			
		});	
		  
		  $('#surveyPrograms').append(add + "</ul>");
		
	  }
	});

}
        		
//This function checks what type of survey then returns appropriate modal function 
function getLink(type,i,ID){
i=+1;
	alert(type);
	if(type=="Formal"){return "'formalConfirm("+i+")'"};
	if(type=="Consultancy"){return "'consultancyConfirm("+i+")'"};
	if(type=="Preliminary"){return "'preliminaryConfirm("+i+")'"};
		
}


function checkAttendance(str){
	
	if(str=="Confirmed") {return "checked"};
	if(str=="Unonfirmed") {return ""};
	
}

		 
function confirmAccreditor(PSID, areaID, accID){
	
	alert("yey"+accID);
	
	$.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
		  url: "ConfirmAttendance?PSID=" + PSID +"&areaID=" + areaID+"&accID=" + accID,
		 
		  success: function() {
			 alert("attendance confirmed")
			}
	});					
				
		
	
}

function formalConfirm(PSID) {
	var add = "";
	
	
	 $('#modalBody2').html("<div style='width: 49%; float:left;'><h4>Formal Survey - </h4></div>");
    
	add += ("<form role='form' class='form-inline'>");
	add += ("<div id='modalBody' class='modal-body'>	"); 
    add += ("<div class='form-group'> ");
    add += ("<div> <label>  <input class='radio' type='radio' name='g'>   <span>Accreditation grant for 3 years</span> </label> <br> <hr>");
    add += ("<label> <input class='radio' type='radio' name='g'> <span>Accreditation not granted</span> </label> ");
    add += ("<div class='form-group'> <label class='control-label'>Reason(s) for denial</label> <textarea name='remarks' rows='3' class='form-control'></textarea> </div></div> </div>"); 
    add += ("<div id='modalfooter' class='modal-footer'>	<button id='delButton' type='submit' class='close' data-dismiss='modal' onclick='delayDelete(1,650)'>Submit</button></div>");
    add += ("</form >");
    
    add += ("</div>");
    $('#modalBody2').append(add);
    $('#fullCalModal').modal();
    $('[data-toggle="tooltip"]').tooltip(); 
   
}




function consultancyConfirm(PSID) {
	var add = "";
	alert(PSID+"hhhhhh");
	
	
// 	<div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button><hh4 id="modalTitle" class="modal-title">Computer Science - Consultancy Survey (Survey Details)</h4></div>
	
	
	
	 $('#modalBody2').html("<div style='width: 49%; float:left;'><h4>Consultancy Survey</h4></div>");
    
    add += ("<form method='post' action='SurveyProgramDecision'>");
   	 add += ("<div id='modalBody' class='modal-body'>	");
   		 add += ("<div class='form-group' style='width:100%;'> <div> 	");
   			 add += ("<label class='control-label' style='width:100%;'> <input name='opt' class='radio ' type='radio'>	<span>Eligible for formal survey in </span> <input type='text' name='duration' class='form-control underlined' style='width:15%;'  placeholder='e.g. 5'><span> months </span><br> <hr></label>");
   			 add += ("<label> <input type='hidden' name='PSID' value='"+PSID+"'> <input type='hidden' name='type'value='Consultancy'> <input name='opt'class='radio' type='radio'>   <span>Accreditation not granted</span> </label> <br>");
  		 add += ("<div class='form-group'> <label class='control-label'>Reason(s) for denial</label> <br> <textarea name='remarks' rows='3' value = '' class='form-control' style='width:100%;'></textarea> </div>");
   	 add += ("</div> </div></div>");

    add += ("<div id='modalfooter' class='modal-footer'>	<button id='delButton' type='submit' class='close' >Submit</button></div>");
    add += ("</form >");
    
    
  
    
    $('#modalBody2').append(add);
    $('#fullCalModal').modal();
    $('[data-toggle="tooltip"]').tooltip(); 
   
}

function resurveyConfirm() {
	var add = "";
	
	
	 $('#modalBody2').html("<div style='width: 49%; float:left;'><h4>Formal Survey - </h4></div>");
   
   add += ("<div class='form-group'> ");
   add += ("<div> <label>  <input class='radio' type='radio' name='g'>   <span>Accreditation grant for 3 years</span> </label> <br> <hr>");
   add += ("<label> <input class='radio' type='radio' name='g'> <span>Accreditation not granted</span> </label> ");
   add += ("<div class='form-group'> <label class='control-label'>Reason(s) for denial</label> <textarea rows='3' class='form-control'></textarea> </div></div> </div>"); 
  
   
   add += ("</ul></div>");
   $('#modalBody2').append(add);
   $('#fullCalModal').modal();
   $('[data-toggle="tooltip"]').tooltip(); 
  
}

</script>

<style>

	#contenthole{
		
		padding:15px;
		background-color: white;
		

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
		
	#bPending{
		position:relative;
		left:-120px;
		float:right;
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
                                    <a href="survey.html"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addsurvey.html"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li class="active open">
                                <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                  
                                        <li class="active"> <a href="accreditors.html">
    								Accreditors
    							</a> </li>
                                        <li> <a href="institutions.html">
    								Institutions
    							</a> </li>
								 <li> <a href="schoolSystems.html">
    							                School Systems
    							</a> </li>
								 <li> <a href="programs.html">
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
				  
				<div class="container">
	<video poster="assets/banner.jpg" id="bgvid"  playsinline autoplay muted loop>
  <!-- WCAG general accessibility recommendation is that media such as background video play through only once. Loop turned on for the purposes of illustration; if removed, the end of the video will fade in the same way created by pressing the "Pause" button  -->
<source src="assets/vid.mp4" type="video/mp4">
</video>
</div>
            <div id="welcome">
			<h1>Visit Confirmation Page</h1>
			
					
			</div>
			   <header class="header" id="customheader">
			   
					
                </header>
                <article class="content dashboard-page"  >
                    <section class="section" style="position: relative; top:-135px; left:-25px; width:105%;" >
                      
		
					
               <div class="table-responsive" style="width:100%; float:right;" id="contenthole">
					<div class="col-md-12">
					
					
				<!--INSERT attribute get for details of survey  -->								
				<div id="surveyTitle" style='width: 90%; float:left;'></div>
	           		  <br><br><br><hr>
	           		  
	           		  <div id="surveyPrograms">
	           		  </div>
					
												
												</div>
                                               
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>
                        </div>
						
                    </section>
                </article>
             
          
          	<div id="preliminaryModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Computer Science - Preliminary Survey (Survey Details)</h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
					
					<div class="form-group"> <label class="control-label">Board Decision</label> <textarea rows="3" class="form-control"></textarea> </div>
					  
					  <div class="form-group"> <label class="control-label">Additional Information</label>
                                    <div> <label>
			                    <input class="radio" type="radio" name="g2">
			                    <span>Required to submit progress report</span>
			                </label> <label>
			                    <input class="radio" type="radio" name="g2">
			                    <span>Required to undergo Interim</span>
			                </label> </div>
							 
                        </div>
					
					</div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)">Submit</button>
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>	   
			 
		  <!-- EVENT MODAL Formal Survey -->
       	<div id="formalModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Computer Science - Formal Visit (Survey Details)</h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
					
					 
					  <div class="form-group"> <label class="control-label">Additional Information</label>
                                    <div> <label>
			                    <input class="radio" type="radio" name="g0">
			                    <span>Accreditation grant for 3 years</span>
			                </label> <br> <hr><label>
			                    <input class="radio" type="radio" name="g0">
			                    <span>Accreditation not granted</span>
			                </label> 
							<div class="form-group"> <label class="control-label">Reason(s) for denial</label> <textarea rows="3" class="form-control"></textarea> </div>
							</div>
							 
                        </div>
					
					</div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)">Submit</button>
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>	

		 <!-- EVENT MODAL Consultancy Survey -->
       	<div id="consultancyModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Computer Science - Consultancy Survey (Survey Details)</h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
					
					<div class="form-group" style="width:100%;"> <label class="control-label">Additional Information</label>
                            <div> 
								<form role="form" class="form-inline">
									<label class="control-label" style="width:100%;">
			                    <input name="g1" class="radio " type="radio">
			                   
								<span>Eligible for formal survey in </span> <input type="text" class="form-control underlined" style="width:15%;"  placeholder="e.g. 5"><span> months </span>
								</form >
							<br> <hr><label>
			                    <input name="g1"class="radio" type="radio">
			                    <span>Accreditation not granted</span>
			                </label> <br>
							<div class="form-group"> <label class="control-label">Reason(s) for denial</label> <br> <textarea rows="3" class="form-control" style="width:100%;"></textarea> </div>
							
							</div>
							 
                    </div>
					
					
					</div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)">Submit</button>
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>	
		




 <!-- EVENT MODAL Resurvey -->
       	<div id="resurveyModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Computer Science - Resurvey (Survey Details)</h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
					
					<div class="form-group"> <label class="control-label">Board Decision</label> <textarea rows="3" class="form-control"></textarea> </div>
					  
					  <div class="form-group"> <label class="control-label">Additional Information</label>
                                    <div> <label>
			                    <input class="checkbox rounded" type="checkbox">
			                    <span>Required to submit progress report</span>
			                </label> <label>
			                    <input class="checkbox rounded" type="checkbox">
			                    <span>Required to undergo Interim</span>
			                </label> </div>
							 
                        </div>
					
					</div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)">Submit</button>
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>	

		 <!-- EVENT MODAL Revisit Survey -->
       	<div id="revisitModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Computer Science - Revisit (Survey Details)</h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
					
					<div class="form-group"> <label class="control-label">Board Decision</label> <textarea rows="3" class="form-control"></textarea> </div>
					  
					  <div class="form-group"> <label class="control-label">Additional Information</label>
                                    <div> <label>
			                    <input class="checkbox rounded" type="checkbox">
			                    <span>Required to submit progress report</span>
			                </label> <label>
			                    <input class="checkbox rounded" type="checkbox">
			                    <span>Required to undergo Interim</span>
			                </label> </div>
							 
                        </div>
					
					</div>
            		<div id="modalfooter" class="modal-footer">
					<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="delayDelete(1,650)">Submit</button>
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>	
		
		
		<div id="fullCalModal" class="modal fade">
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody2" class="modal-body"></div>
            		
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