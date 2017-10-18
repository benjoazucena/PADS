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
	<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
	<script src="js/dataTables.bootstrap.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	
 	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css">
		<script src="js/bootstrap-datepicker.js"></script>
	<link title="timeline-styles" rel="stylesheet" href="css/datepicker.css">
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
		$('#activeopen').collapse("show");
		$('#datepicker').datepicker();
		/* initialize the external events
		-----------------------------------------------------------------*/

		$('#external-events .fc-event').each(function() {

			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).text()), // use the element's text as the event title
				stick: true // maintain when user navigates (see docs on the renderEvent method)
			});

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});

	
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek,basicDay'
			},
			defaultDate: '2016-09-12',
			navLinks: true, // can click day/week names to navigate views
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
					$(this).remove();
				}
			,
			eventDrop: function(event, delta, revertFunc) {
		        alert(event.title + " was dropped on " + event.start.format());
		    },
		    eventReceive: function(event) {
		        alert(event.title + " was dropped on " + event.start.format());
		    },
		    eventRender: function(event, element) {
	            element.append( "<a class='closeon'> Delete</a>" );
	            element.find(".closeon").click(function() {
	            	alert(event.title + " was removed.");
	               $('#calendar').fullCalendar('removeEvents',event._id);
	            });
	        },

			eventLimit: true, // allow "more" link when too many events
			events: [
				{
					title: 'All Day Event',
					start: '2016-09-01'
				},
				{
					title: 'Conference',
					start: '2016-09-11'
				},
				{
					title: 'Meeting',
					start: '2016-09-12T10:30:00',
					end: '2016-09-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2016-09-12T12:00:00'
				},
				{
					title: 'Meeting',
					start: '2016-09-12T14:30:00'
				},
				{
					title: 'Happy Hour',
					start: '2016-09-12T17:30:00'
				},
				{
					title: 'Dinner',
					start: '2016-09-12T20:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2016-09-13T07:00:00'
				}
			]
		});
		
	});
	
	


function addAlert(asd){
	$('#section').append('<div class="alert alert-success"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Success!</strong> Successfully added survey called: '+asd +'.</div> <br>');
}

function addSurvey(){
	var surveyName = document.getElementById("surveyName").value;
	var school = document.getElementById("school").value;
	var School System = document.getElementById("School System").value;
	
	$('#external-events').append('<div class="fc-event ui-draggable ui-draggable-handle" data-event="{\"title\":\"' + surveyName + '\"}">' + surveyName + '</div> <br>');
	$('#external-events .fc-event').each(function() {

		// store data so the calendar knows to render an event upon drop
		$(this).data('event', {
			title: $.trim($(this).text()), // use the element's text as the event title
			stick: true // maintain when user navigates (see docs on the renderEvent method)
		});

		// make the event draggable using jQuery UI
		$(this).draggable({
			zIndex: 999,
			revert: true,      // will cause the event to go back to its
			revertDuration: 0  //  original position after the drag
		});

	});
	$('#surveyName').value = "";
	$('#school').value = "" ;
	$('#School System').value = "";
	addAlert(surveyName);
}

function duplicateCheck(ss){
	var hasMatch = false;
// 	alert(entry);
	 $.ajax({
   	  url: "SystemsLoader",
   	  dataType: 'json',
   	  async: false,
   	  success: function(data) {
   		  $.each(data, function (key, value){
   			
   				if(ss.toUpperCase() == value.systemName.toUpperCase()){
	   				alert("This institution already exists in the database."); 
	   				hasMatch=true; 
	   				return false;
   				} 
   			});	
   		
   	  }
   	});	
	 if(!hasMatch){return true;}	
}


function validateForm() {
	
	
	var ssName = document.forms["addSSForm"]["ssName"].value;
	

    if(duplicateCheck(ssName)){
    if(ssName==""){
    	alert("School System must be selected");
        return false;	
    } 
    else{
    	alert("succesfully added institution!");
    	
        }}
    else return false;
}

function addProp(){
	$("#progBar").html("<div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progDetails'>1. Details</div><div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progProponents'>2. Proponents </div>");

}

function addDet(){
	$("#progBar").html("<div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progDetails'>1. Details</div>");

}

function addSure(){
	$("#progBar").html("<div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progDetails'>1. Details</div><div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progProponents'>2. Proponents </div><div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progProponents'>3. Final </div>");

}


function changeDetails(){
	$("#progProponents").className = "progress-bar progress-bar-success progress-bar-striped";
	$("#progDetails").className = "progress-bar progress-bar-success";
	$("#progSure").className = "progress-bar progress-bar-success";
}
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
    	 
        <div class="main-wrapper">
      				
        			
      			</div>
      			
    		

  	
			
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
					 <div style="margin-left:-150px;">
					 	
  							
						
					 </div>
                    
                   
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
                <aside class="sidebar" style="position:fixed"><img id ="bg" src="assets/bg.jpg">
				<img id="bg" src="assets/bg.jpg">
                    <div class="sidebar-container">
                    	
                        <div class="sidebar-header" >
                            <div class="brand" style="background-color:#1c252e;position:relative;left:-17%;width:150%;box-shadow: 10px 9px 24px 0px rgba(1,1,1,1);"  >
                                 <div class="logo" id="logoDiv" style="width:100%;"> <img src="assets/logoicon.png" style="width:52%;height:185%; top:-40%;left:9%; opacity:1"> </div>
                       
                        </div><br>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="Notifications"> <i class="fa fa-home"></i> Dashboard </a>
                               <li>
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addSurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
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
								 <li class="active"> <a href="SchoolSystems">
    							                School Systems
    							</a> </li>
								 <li> <a href="Programs">
    								Disciplines </a></li>
								 
                                 
                                    </ul>
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
							<a href="SchoolSystems"> List of School Systems </a> > Edit School System
						</h3>
			     </div>
				
				<section class="section" id="section">   
				 <div class="tab-content">     
				 	<div id="menu1" class="tab-pane fade in active">          
		<form name="addSSForm" onsubmit="return validateForm()"  method="post" action="UpdateSchoolSystem" class="form">
						<div class="col-md-12">
									<div class="card card-block sameheight-item">
										<div class="title-block">
											<h3 class="title">
							New School System Form
						</h3> </div>
						<%@page import="Models.SchoolSystem" %>
						<% SchoolSystem ss = (SchoolSystem)request.getAttribute("SchoolSystem"); %>
						
											<div style="width:48%; padding-right"> <label class="control-label">School System Name</label> 
											<input type="text" class="form-control underlined" style="width:90%;" value="<%=ss.getName() %>" placeholder="e.g. De La Salle" name="ssName"> </div>
											<input type="hidden" value="<%=ss.getSchoolSystemID() %>" name="systemID">
										
										<br><br>
										
											<div style="width:48%; padding-right"> <label class="control-label">Membership Date</label> 
											<input type="text" class="form-control underlined" style="width:90%;" value="<%=ss.getDate_joined()%>" placeholder="e.g. 2017-01-01" name="joinDate"> </div>
											
										
									</div>
								</div>

							
				
						<div class="col-md-12">
								<div class="form-group">
									<hr>
<!-- 									<button type="button" class="btn btn-success" onclick="location.href = 'schoolProfile_sample.html'; alert('Successfully added Institutions! \nYou may now add programs in this School System.')" data-toggle="tab" style="float:right; padding-right:15px;"> -->
<!-- 									Submit then add an Institutions 						 -->
<!-- 									</button> -->
								
									<button type="submit" class="btn btn-info" style="float:right; padding-right:15px;">Save
									</button>
								</div>
						</div>
						</form>
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