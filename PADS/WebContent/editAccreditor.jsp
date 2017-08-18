<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
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
	<link rel="stylesheet" href="chosen/chosen.css">
 	<script src="chosen/chosen.jquery.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
	
	
 	<link title="timeline-styles" rel="stylesheet" href="css/timeline.css">
 	<script src="js/bootstrap-datepicker.js"></script>
	<link title="timeline-styles" rel="stylesheet" href="css/datepicker.css">
	<!-- END IMPORTS -->
	
    
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title> PAASCU - Accreditation Schedule Manager </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">
        <!-- Place favicon.ico in the root directory -->
        
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
	getDisciplines();
	$('#datepicker2').datepicker({
		format: 'yyyy-mm-dd'
	});
	$('#datepicker3').datepicker({
		format: 'yyyy-mm-dd'
	});
	
	var systemFormEdu = document.getElementById('systemFormEdu');
	var systemFormWork = document.getElementById('systemFormWork');


	var institutionFormEdu = document.getElementById('institutionFormEdu');
	var institutionFormWork = document.getElementById('institutionFormWork');
	
	//EVENT LISTENER FOR CHOOSING A SYSTEM, CHANGING THE INSTITUTIONS AND SHOWING WHAT'S UNDER THAT SYSTEM
	
	
	$('#systemFormWork').chosen().change(function(){
		$('#institutionFormWork').empty();
		$('#institutionFormWork').trigger("chosen:updated");

		var temp = document.createElement("option");
		temp.text = "";
		temp.value = 0;
		var systemID = $('#systemFormWork').find(":selected").val();	
		institutionFormWork.add(temp);
		$.getJSON("InstitutionsLoader?systemID=" + systemID, function(data){
			$.each(data, function (key, value){
				var option = document.createElement("option");
				option.text = value.institutionName;
				option.value = value.institutionID;
				institutionFormWork.add(option);
				$('#institutionFormWork').trigger("chosen:updated");
			});	
		});
	});
	
	$('#systemFormEdu').chosen().change(function(){
		$('#institutionFormEdu').empty();
		$('#institutionFormEdu').trigger("chosen:updated");

		var temp = document.createElement("option");
		temp.text = "";
		temp.value = 0;
		var systemID = $('#systemFormEdu').find(":selected").val();	
		institutionFormEdu.add(temp);
		$.getJSON("InstitutionsLoader?systemID=" + systemID, function(data){
			$.each(data, function (key, value){
				var option = document.createElement("option");
				option.text = value.institutionName;
				option.value = value.institutionID;
				institutionFormEdu.add(option);
				$('#institutionFormEdu').trigger("chosen:updated");
			});	
		});
	});
	
	$('#institutionFormEdu').chosen();
	$('#institutionFormWork').chosen();

	$(".chosen-select").trigger("chosen:updated");
	
	getSystems();
	
	<c:forEach items="${accreditor.getWorks()}" var="work">

		var inst = "<c:out value="${work.getInstitution()}"/>";
		var pos = "<c:out value="${work.getPosition()}"/>";
		
		var from = formatDate("<c:out value="${work.getDate_entered()}"/>");
		
		if("<c:out value="${work.getDate_finished()}"/>" == ""){
			to = "";
		}else{
			var to = formatDate("<c:out value="${work.getDate_finished()}"/>");
		}
		
		
		
		var institutionID = "<c:out value="${work.getAccreditorID()}"/>";
		
		if(to == ""){
			var add = "<li class='list-group-item'>"+inst+"<ul class='list-group'><li class='list-group-item'>Position: " + pos + "</li><li class='list-group-item'>From " + from + " to present</li></ul></li>";

		}else{
			var add = "<li class='list-group-item'>"+inst+"<ul class='list-group'><li class='list-group-item'>Position: " + pos + "</li><li class='list-group-item'>From " + from + " to " + to + "</li></ul></li>";

		}

		var obj = {};
		obj.institutionID = institutionID;
		obj.pos = pos;
		obj.from = from;
		obj.to = to;
		affObject.works.push(obj);
		$('#addedAffiliations').append(add);
		var lal = document.getElementById("affiliations");
		lal.scrollTop = lal.scrollHeight;
	</c:forEach>
	
	<c:forEach items="${accreditor.getDegrees()}" var="deg">
		var course = "<c:out value="${deg.getDegree_name()}"/>";
		var univ = "<c:out value="${deg.getInstitution()}"/>";
		var add = "<li class='list-group-item'>"+univ+"<ul class='list-group'><li class='list-group-item'>Course: " + course + "</li></ul></li>";
		
		var obj = {};
		obj.institutionID = "<c:out value="${deg.getInstitutionID()}"/>";
		obj.course = course;
		affObject.edu.push(obj);
		
		$('#addedAffiliations').append(add);
		var lal = document.getElementById("affiliations");
		lal.scrollTop = lal.scrollHeight;
	</c:forEach>
});



function formatDate(date){
	var date = date.split("-");
	var year = date[0];
	var month = date[1];
	var day = date[2];
	if(month == "01"){
		month = "January";
	}else if(month == "02"){
		month = "February";
	}else if(month == "03"){
		month = "March";
	}else if(month == "04"){
		month = "April";
	}else if(month == "05"){
		month = "May";
	}else if(month == "06"){
		month = "June";
	}else if(month == "07"){
		month = "July";
	}else if(month == "08"){
		month = "August";
	}else if(month == "09"){
		month = "September";
	}else if(month == "10"){
		month = "October";
	}else if(month == "11"){
		month = "November";
	}else if(month == "12"){
		month = "December";
	}
	
	return month + " " + day + ", " + year;
}
function getDisciplines(){
	//GETS ALL DISCIPLINES FOR THE SELECT DROPDOWN
	var obj = document.getElementById('disciplineForm');	
	$.getJSON("DisciplineLoader", function(data){	
		var option = document.createElement("option");
		option.text = "";
		option.value = 0;
		obj.add(option);
	
		$.each(data, function (key, value){
		
			var option = document.createElement("option");
			option.text = value.disciplineName;
			option.value = value.disciplineID;
			if(option.text == "${acc.getDiscipline()}"){
				option.selected = true;
			}
			obj.add(option);
		
		});	
		$('#disciplineForm').trigger("chosen:updated");
	});
	
}

function getSystems(){
	//GETS ALL SYSTEMS FOR THE SELECT DROPDOWN
	var obj1 = document.getElementById('systemFormEdu');
	var obj2 = document.getElementById('systemFormWork');

	$.getJSON("SystemsLoader", function(data){
		var option = document.createElement("option");
		option.text = "";
		option.value = 0;
		
		var option1 = document.createElement("option");
		option1.text = "";
		option.value = 0;
		
		var option2 = document.createElement("option");
		option2.text = "";
		option2.value = 0;
		
		obj1.add(option1);
		obj2.add(option2);
		
		
		$.each(data, function (key, value){
			var option = document.createElement("option");
			option.text = value.systemName;
			option.value = value.systemID;
			
			var option1 = document.createElement("option");
			option1.text = value.systemName;
			option1.value = value.systemID;
			
			var option2 = document.createElement("option");
			option2.text = value.systemName;
			option2.value = value.systemID;
			
			obj1.add(option1);
			obj2.add(option2);
		});	
		$('#systemFormEdu').trigger("chosen:updated");
		$('#systemFormWork').trigger("chosen:updated");


	});
}
function addProp(){
	$("#progBar").html("<div class='progress-bar progress-bar-success' role='progressbar' style='width:50%' id='progDetails'>1. Details</div><div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:50%' id='progProponents'>2. Affiliations </div>");
	$(".chosen-select").trigger("chosen:updated");
	 $(".chosen-container").each(function() {
	       $(this).attr('style', 'width: 100%');
	   });     
}

function addDet(){
	$("#progBar").html("<div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:50%' id='progDetails'>1. Details</div>");

}

function changeDetails(){
	$("#progProponents").className = "progress-bar progress-bar-success progress-bar-striped";
	$("#progDetails").className = "progress-bar progress-bar-success";
	$("#progSure").className = "progress-bar progress-bar-success";
}

function saveAccreditor(){
	var id = "<c:out value='${accreditor.getAccreditorID()}'/>";
	var firstName = $('#firstName').val();
	var lastName = $('#lastName').val();
	var email = $('#email').val();
	var discipline = $('#disciplineForm').find(":selected").val();	
	var primaryArea = $('#primaryArea').find(":selected").val();	
	var datetrained = $('datepicker1').val();
	var city = $('city').val();
	if(firstName == ""){
		alert("Please fill out first name!");
	}else if(lastName == ""){
		alert("Please fill out last name!");
	}else if(email == ""){
		alert("Please fill out email!");
	}else if(discipline == ""){
		alert("Please choose a discipline!");
	}else if(primaryArea == ""){
		alert("Please choose a primary area!");
	}else if(datetrained = ""){
		alert("Please input date trained!");
	}else if(city = ""){
		alert("Please input city!")
	}else{
		$.ajax({
			url: 'SaveEditAccreditor?accreditorID=' + id + "&" + $('#accForm').serialize(),
			type: 'POST',
			async: false,
			dataType: 'json',
			data: {affObject: JSON.stringify(affObject)},
			success: function(result){
				
			}
		});
		alert('Accreditor successfully edited! Redirecting you to the accreditors page...')
	
		document.location.href = "Accreditors";
	}
}
var affObject = {
		works: [],
		edu: []
};

function addAffiliation(){
	var inst = $('#institutionFormWork').find(":selected").text();
	var pos = $('#pastPosition').val();
	var from = $('#datepicker2').val();
	var to = $('#datepicker3').val();
	
	var institutionID = $('#institutionFormWork').find(":selected").val();	
	
	if(inst ==  ""){
		alert("Please fill out institution!");
	}else if(pos == ""){
		alert("Please input position!");
	}else if(from == ""){
		alert("Please input date!");
	}else{
		if(to == ""){
			var add = "<li class='list-group-item'>"+inst+"<ul class='list-group'><li class='list-group-item'>Position: " + pos + "</li><li class='list-group-item'>From " + from + " to present</li></ul></li>";
	
		}else{
			var add = "<li class='list-group-item'>"+inst+"<ul class='list-group'><li class='list-group-item'>Position: " + pos + "</li><li class='list-group-item'>From " + from + " to " + to + "</li></ul></li>";
	
		}
	
		var obj = {};
		obj.institutionID = institutionID;
		obj.pos = pos;
		obj.from = from;
		obj.to = to;
		affObject.works.push(obj);
		$('#addedAffiliations').append(add);
		var lal = document.getElementById("affiliations");
		lal.scrollTop = lal.scrollHeight;
		
		$('#pastPosition').val("");
		$('#datepicker2').val("");
		$('#datepicker3').val("");
	}

}

function addEducation(){
	var course = $('#courseName').val();
	var univ = $('#institutionFormEdu').find(":selected").text();
	var add = "<li class='list-group-item'>"+univ+"<ul class='list-group'><li class='list-group-item'>Course: " + course + "</li></ul></li>";
	
	if(course == ""){
		alert("Please input course!");
	}else if(univ = ""){
		alert("Please choose an institution!");
	}else{
		var obj = {};
		obj.institutionID = $('#institutionFormEdu').find(":selected").val();
		obj.course = course;
		affObject.edu.push(obj);
		
		$('#addedAffiliations').append(add);
		var lal = document.getElementById("affiliations");
		lal.scrollTop = lal.scrollHeight;
		
		$('#courseName').val("");
	}
}
function togglePresent(){
	$('#datepicker3').prop('disabled', function(i, v) { return !v; });
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
	#maincard{
	height:750px;
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
					 	
					 		<div class="progress" style="width:500px; height:20px;" id="progBar">
  								<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" style="width:50%" id="progDetails">
    								1. Details
  								</div>
  								
							</div>
  							
						
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
                <aside class="sidebar"><img id ="bg" src="assets/bg.jpg">
				
                    <div class="sidebar-container">
                    	
                        <div class="sidebar-header">
                            <div class="brand">
                                <div class="logo"style="width:100%"> <img src="assets/logoicon.png" style="width:90%;height:170%; top:-5%;left:-5%; opacity:1"> </div>
                        </div>
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
								<li  class = "active" id="activeopen" >
                                 <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                        <li  class = "active" > <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li> <a href="Institutions">
    								Institution
    							</a> </li>
								 <li> <a href="SchoolSystems">
    							    Schools
    							</a> </li>
								 <li> <a href="Programs">
    								Disciplines </a></li>
								 
                                 
                                    </ul>
                                </li>
                                <li><a href="#demo3" data-toggle="collapse"> <i class="fa fa-bar-chart"></i> Reports <i class="fa arrow"></i> </a><ul id="demo3" class="collapse"><li> <a href="reportGA.html">GA Awardees</a> </li><li> <a href="reportHistory.html">History</a> </li></ul></li>
								<li>
								  <a href="settings.html"> <i class="fa fa-cog"></i> Settings </a>
								 </li>
                                
                               
                            </ul>
                        </nav>
                    </div>
                    <footer class="sidebar-footer">
            
			
					
                </aside>
				
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				<form id="accForm">

                <article class="content dashboard-page">
				
				 <div class="title-block">
                        <h3 class="title" style="float:left;">
							<a href="Accreditors"> List of Accreditors </a> > Edit Accreditor
						</h3>
			     </div>
				<div class="col-md-12"id="maincard" >
				<div class="card card-block sameheight-item"id="maincard">		
				 <section class="section" id="section">  
				 
				<div class="tab-content">     
				
				 	<div id="menu1" class="tab-pane fade in active">  
												
			<section class="section" id="section" style="height:450px;"> 		
			
				   	
      				<div class="form-group row">
      				<div class="col-xs-2">
      					<label>Title:</label>
    					<select class="form-control underlined" name="honorifics">
    						<option>Mr.</option>
    						<option>Ms.</option>
        					<option>Mrs.</option>
        					<option>Dr.</option>
        					<option>Pastor</option>
        					<option>Father</option>
        					<option>Rev.</option>
  						</select>
      				</div>
      				<c:set var="acc" scope="session" value="${accreditor}"/>
      				<div class="col-xs-5">
						<label>First Name:</label>
    					<input type="text" class="form-control underlined" id="surveyName" name="firstName" value="${acc.getFirstName()}">
    				</div>
    				<div class="col-xs-1">
						<label>M.I.:</label>
    					<input type="text" class="form-control underlined" id="surveyName" name="middleName" value="${acc.getMiddleName()}">
    				</div>
      				<div class="col-xs-4">
    					<label>Last Name:</label>
    					<input type="text" class="form-control underlined" id="surveyName" name="lastName" value="${acc.getLastName()}">
    				</div>
    				</div>
    				
    				<div class="form-group row">
    				<div class="col-xs-7">
						<label>Email:</label>
    					<input type="text" class="form-control underlined" id="surveyName" name="email" value="${acc.getEmail()}">
    				</div>
    				<div class="col-xs-5">
    					<label>Contact Number:</label>
    					<input type="text" class="form-control underlined" id="surveyName" name="contact" value="${acc.getContact()}">
    				</div>
    				</div>
    				<div class="form-group row">
    				<div class="col-xs-7">
						<label>Address:</label>
  						<input type="text" class="form-control underlined" id="surveyName" name="address" value="${acc.getAddress()}">
					</div>
					<div class="col-xs-5">
						<label>City:</label>
  						<input type="text" class="form-control underlined" id="surveyName" name="city" value="${acc.getCity()}">
					</div>
  					</div>
					
					<div class="form-group row">
					
					<div class="col-xs-7">
						<label><b>Country:</b></label>
  						<input type="text" class="form-control underlined" id="surveyName" name="country" value="${acc.getCountry()}">
					</div>
    				<div class="col-xs-5">
						<label><b>Discipline/Specialization:</b></label>
  						<select class="form-control underlined chosen-select" data-placeholder="Choose a Discipline..." id="disciplineForm" style="background: transparent;" name="discipline" value="${acc.getDiscipline()}">
						</select>
					</div>
					
    				
					
  					</div>
  					<div class="form-group row">
					
					<div class="col-xs-7">
						<label><b>Venue Trained:</b></label>
  						<input type="text" class="form-control underlined" id="surveyName" name="venue_trained" value="${acc.getVenue_trained()}">
					</div>
    				<div class="col-xs-5">
						<label><b>Date Trained:</b></label>
  						<input type="text" class="form-control underlined" id="surveyName" name="date_trained" value="${acc.getDate_trained()}">
					</div>
					
    				
					
  					</div>
					
					<div class="form-group row">
						<div class="col-xs-12">
							<label>Primary Survey Area:</label>
    					<select  id="primaryArea" class="form-control underlined" name="primaryArea" value="${acc.getPrimaryArea()}">
    						<option value="1">Faculty</option>
    						<option value="2">Instruction</option>
        					<option value="3">Laboratories</option>
        					<option value="4">Libraries</option>
        					<option value="5">Community</option>
        					<option value="6">Physical Facilities</option>
        					<option value="7">Student Services</option>
							<option value="8">Administration</option>
							<option value="9">Research</option>
							<option value="10">Clinical Training</option>
							<option value="11">Other Resources</option>
  						</select>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-xs-12">
							<label>Secondary Survey Area:</label>
    					<select  id="secondaryArea" class="form-control underlined" name="secondaryArea" value="${acc.getSecondaryArea()}">
    						<option value="0"></option>
    						<option value="1">Faculty</option>
    						<option value="2">Instruction</option>
        					<option value="3">Laboratories</option>
        					<option value="4">Libraries</option>
        					<option value="5">Community</option>
        					<option value="6">Physical Facilities</option>
        					<option value="7">Student Services</option>
							<option value="8">Administration</option>
							<option value="9">Research</option>
							<option value="10">Clinical Training</option>
							<option value="11">Other Resources</option>
  						</select>
						</div>
					</div>
					
					<div class="form-group row">
						<div class="col-xs-12">
							<label>Tertiary Survey Area:</label>
    					<select id="tertiaryArea" class="form-control underlined" name="tertiaryArea">
    						<option value="0"></option>
    						<option value="1">Faculty</option>
    						<option value="2">Instruction</option>
        					<option value="3">Laboratories</option>
        					<option value="4">Libraries</option>
        					<option value="5">Community</option>
        					<option value="6">Physical Facilities</option>
        					<option value="7">Student Services</option>
							<option value="8">Administration</option>
							<option value="9">Research</option>
							<option value="10">Clinical Training</option>
							<option value="11">Other Resources</option>
  						</select>
						</div>
					</div>
        				
        			<script>
        				$('#primaryArea').val("${acc.getPrimaryAreaID()}");
        				$('#secondaryArea').val("${acc.getSecondaryAreaID()}");
        				$('#tertiaryArea').val("${acc.getTertiaryAreaID()}");
						
        			</script>
        			
					<div class="form-group" style="float:right;top:25px;">
  						<button type="button" class="btn btn-success" onclick="addProp();"style="position:relative;top:35px; right:0px;" data-toggle="tab" href="#menu2">
  						Next Step
  						</button>
  						
					</div>
					
					
        			
					</section>
        			</div>
        			
        			
  					
  					<div id="menu2" class="tab-pane fade">
  					<section class="section" id="section2"> 
  					
    				<h3>Affiliations</h3>
    					<div style="width:30%; float:left;" class="card sameheight-item">
    					<div class="card-block" style="border-radius: 10px 10px 10px 10px;
							-moz-border-radius: 10px 10px 10px 10px;
							-webkit-border-radius: 10px 10px 10px 10px;
							border: 1px solid #b8b8b8;">
    					
    					<ul class="nav nav-tabs">
  							<li class="active"><a data-toggle="tab" href="#afi">Work</a></li>
  							<li><a data-toggle="tab" href="#edu">Education</a></li>
						</ul>
						<div class="tab-content" >
						<div id="afi" class="tab-pane fade in active">
    						<div class="form-group" ><br>
    							
		  						<label for="sel1">School System:</label><br>
		  						<select class="form-control underlined chosen-select" data-placeholder="Choose a System..." id="systemFormWork" style="background: transparent;"> 				
		  						</select>
							
		  						<label for="sel1">Institutions:</label>
		  						<select class="form-control underlined chosen-select" data-placeholder="Choose an Institution..." id="institutionFormWork" style="background: transparent;">
		  						</select>
							
    							<label>Position:</label>
    							<input type="text" class="form-control" id="pastPosition">
    							<label>From:</label>
    							<div class="input-daterange input-group">
    							<input type="text" class="form-control" id="datepicker2" />
								</div>
								<label>To:<input style="margin-left:100px;" type="checkbox" onclick="togglePresent()">Current?</label>
    							<div class="input-daterange input-group">
    							<input type="text" class="form-control" id="datepicker3" />
								</div>			
							</div>
							<div class="form-group">
    							<button type="button" class="btn btn-success" style="float:right;" onclick="addAffiliation();">Add</button>
							</div>
						</div>
						
						<div id="edu" class="tab-pane fade in">
							<div class="form-group" ><br>
    							<label for="sel1">School System:</label><br>
		  						<select class="form-control underlined chosen-select" data-placeholder="Choose a System..." id="systemFormEdu" style="background: transparent;"> 				
		  						</select>
							
		  						<label for="sel1">Institutions:</label>
		  						<select class="form-control underlined chosen-select" data-placeholder="Choose an Institution..." id="institutionFormEdu" style="background: transparent;">
		  						</select>
		  						
    							<label>Course:</label>
    							<input type="text" class="form-control" id="courseName">				
							</div>
							<div class="form-group">
    							<button type="button" class="btn btn-success" style="float:left;" onclick="addEducation();">Add</button>
							</div>
						</div>
						</div>
							
							<br><br>
							</div>
    					</div>
    					
    					<div style="width:69%; float:right; height: 418px; overflow:scroll;-webkit-box-shadow: inset 0px 1px 7px 1px rgba(0,0,0,0.41);
						-moz-box-shadow: inset 0px 1px 7px 1px rgba(0,0,0,0.41);
					box-shadow: inset 0px 1px 7px 1px rgba(0,0,0,0.41); padding:12px;" id="affiliations">
    						<ul id="addedAffiliations" class="list-group">
    						
  							
  							</ul>
    					</div>
    					
					
    				
    				
    				</section>
					
					<div id="navBut" style="position:absolute;top:670px;">
					<hr style="position:absolute;">
						
						<button type="button" class="btn btn-success" onclick="saveAccreditor();"style="position:relative;top:35px; right:0px;">
  						Submit
  						</button>
  					</div>
    				
  					</div>
					
				
					
				   
        			</div>
				
				   </div>
				   </div>
        			
					
				  
                </article>
             </form>
             
        		  
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