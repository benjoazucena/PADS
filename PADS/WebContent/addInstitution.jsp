<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html class="no-js" lang="en">

    <head>
<!-- IMPORTS -->
    <script src='js/jquery.min.js'></script>
<!--     <script src='js/jquery-ui.min.js'></script> -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/bootstrap.min.js"></script>
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <link rel="stylesheet" href="css/vendor.css">
<!--     <link href='fullcalendar.css' rel='stylesheet' /> -->
<!--     <link href='calendar/fullcalendar.print.css' rel='stylesheet' media='print' /> -->
<!-- 	<script src='calendar/lib/moment.min.js'></script> -->
	<link rel="stylesheet" href="chosen/chosen.css">
 	<script src="chosen/chosen.jquery.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
	
	
<!--  	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css"> -->
 	<script src="js/bootstrap-datepicker.min.js"></script>
 	<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<!-- 	<link title="timeline-styles" rel="stylesheet" href="css/datepicker.css"> -->
	<!-- END IMPORTS -->
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


<script >	

$(document).ready(function() {
	getSystems();
	var systemForm = document.getElementById('systemForm');
	/* initialize the external events
	-----------------------------------------------------------------*/

	

	$('#systemForm').chosen().change(function(){
		document.getElementById('ssID').value= $('#systemForm').find(":selected").val();
	
	});
	$('#datepicker').datepicker({
 		format: "MM dd, yyyy",
 		autoclose:true,
 	});
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

function getSystems(){
	//GETS ALL SYSTEMS FOR THE SELECT DROPDOWN
	var obj = document.getElementById('systemForm');
	
	$.getJSON("SystemsLoader", function(data){
		var option = document.createElement("option");
		option.text = "";
		option.value = 0;
		obj.add(option);
		$.each(data, function (key, value){
			var option = document.createElement("option");
			option.text = value.systemName;
			option.value = value.systemID;
			obj.add(option);
			
		});	
		$('#systemForm').trigger("chosen:updated");
	});
	
}



</script>

<script>


	





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
                                <div class="logo"style="width:100%"> <img src="assets/logoicon.png" style="width:90%;height:170%; top:-5%;left:-5%; opacity:1"> </div>
                        </div>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="index.html"> <i class="fa fa-home"></i> Dashboard </a>
                               <li>
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addSurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li  class="active">
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
				
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				
         
                <article class="content dashboard-page">
				<form method="post" action="AddInstitution" class="form">
				
				 <div class="title-block">
                        <h3 class="title" style="float:left;">
							<a href="Institutions"> List of Institutions </a> > Add New Institutions
						</h3>
			     </div>
				
				 <section class="section" id="section">   
				 <div class="tab-content">     
				 	<div id="menu1" class="tab-pane fade in active">          

						<div class="col-md-12">
									<div class="card card-block sameheight-item">
										<div class="title-block">
											<h3 class="title">
							New Institutions Form
						</h3> </div>
											<div class="form-group">
  						<label for="sel1">School System:</label><br>
  						<select class="form-control underlined chosen-select" data-placeholder="Choose a System..." id="systemForm" style="background: transparent;" name="ssName">
							 				
  						</select>
  						
  						<input type="hidden" id="ssID" name="ssID">
					</div>
					
					
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Institution Name</label> <input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. De La Salle University" name="institutionName"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Institution Acronym</label> <input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. DLSU-M" name="institutionAcronym"> </div>
								<br><br><br>	
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Address</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. 2401 Taft Avenue, 1004 Manila, Philippines" name="address"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Date of Membership</label> <input id="datepicker" type="text" class="form-control underlined" style="width:90%;" placeholder="" name="membershipDate"> </div>
											
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">City of Institution </label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. 2401 Taft Avenue, 1004 Manila, Philippines" name="city"> </div>
								<br><br><br>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Country of Institution </label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. Philippines" name="country"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Website</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. http://www.dlsu.edu.ph/" name="website"> </div>
								<br><br><br>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Contact No. <i>(separate using semi-colon)</i></label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. (632) 523-4152 ; 247-6921" name="contactNumber"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Fax No.</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. 432-8586 " name="fax"> </div>
								<br><br><br>			
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Head</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. Mr. Jose T. Pardo" name="institutionHead"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Position of the Head</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. Chairman" name="position"> </div>
								<br><br><br>	
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Email of the Head</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. chairperson@email.com" name="headEmail"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Institution Contact Person</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. Firstname Lastname" name="contactPerson"> </div>
								<br><br><br>			
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Position of the Contact Person</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. Chairman" name="contactPosition"> </div>
											<div class="form-group"  style="width:48%; padding-right"> <label class="control-label">Email of Contact Person</label> <input type="text" class="form-control underlined" style="width:90%;" placeholder="e.g. person@email.com" name="contactEmail"> </div>
									</div>
								</div>

							
						<div class="col-md-12">
								<div class="form-group">
									<hr>
<!-- 									<button type="submit" class="btn btn-success" onclick="location.href = 'institutionProfile_sample.html'; alert('Successfully added Institutions! \nYou may now add programs in this School System.')" data-toggle="tab" style="float:right; padding-right:15px;"> -->
<!-- 									Submit then add Programs  						 -->
<!-- 									</button> -->
									
									<button type="submit" class="btn btn-info" onclick="alert('Successfully added Institutions!');location.href = 'institutions.jsp';"  style="float:right; padding-right:15px;">
									Save
									</button>
								</div>
						</div>
        			</div>
				   </section>
				   
				   </form>
					
				  
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