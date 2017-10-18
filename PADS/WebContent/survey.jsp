<!doctype html>
<html class="no-js" lang="en">

    <head>
    <!-- IMPORTS -->

    <script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/bootstrap.min.js"></script>
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
   <link rel="stylesheet" type="text/css" href=" css/dataTables.bootstrap.min.css">
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
		<link href='css/fullcalendar.css' rel='stylesheet' />
 

    <link href='calendar/fullcalendar.print.css' rel='stylesheet' media='print' />
	 <link href='css/vendor.css' rel='stylesheet' />
	<script src='calendar/lib/moment.min.js'></script>
	<script src='calendar/fullcalendar.min.js'></script>
	
	<script type="text/javascript" src="js/jspdf.min.js"></script>
	<!-- END IMPORTS -->
	
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title> PAASCU - Accreditation Schedule Manager </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
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
			
			function delayDelete(id,delay)
			{
				setTimeout( function() { deleteEvent(id); }, delay );
			}

			function deleteEvent(id){
			$('#calendar').fullCalendar( 'removeEvents', id );
			}
        </script>



<script>
	var past = 'rgb(12, 48, 107)';
	var complete = 'rgb(0, 119, 29)';
	var incomplete = 'rgb(91, 9, 9)';
	/*
	$.getJSON("SurveyLoader", function(data) {

	      //iterating over each value that the servlet returns
	      $.each(data, function(key, value) {
	               alert(value.id); //alerting the values set in the JSONObject of the Sevlet.
	               alert(value.title);
	     });
	});*/
	
function UpdateConfirmation(con, id, psid, area, obj){
	if (con == "Not Available"){
		obj.parentNode.parentNode.className="danger";
		obj.className = "btn btn-pill-left btn-danger btn-sm";
		obj.nextSibling.className = "btn btn-pill-right btn-secondary btn-sm";
	}else if (con == "Confirmed"){
		obj.parentNode.parentNode.className="success";
		obj.className = "btn btn-pill-right btn-success btn-sm";
		obj.previousSibling.className = "btn btn-pill-left btn-secondary btn-sm";



	}
	$.ajax({url: "UpdateConfirmation?accreditorID=" + id + "&confirmation=" + con + "&PSID=" + psid + "&areaID=" + area, success: function(result){
    }});
	
	$("#calendar").fullCalendar("refetchEvents");
	$("#calendar").fullCalendar("rerenderEvents");
}
	
function DeleteProgram(PSID, obj){
	var r = confirm("Are you sure?\nThis will delete all data related to the survey-program.")
	if(r == true){
		obj.parentNode.parentNode.removeChild(obj.parentNode);
		$.ajax({url: "DeletePSID?PSID=" + PSID, success: function(result){
	        alert(result);
	    }});
		$("#calendar").fullCalendar("refetchEvents");
		$("#calendar").fullCalendar("rerenderEvents");
	}
}
	
function deleteArea(accreditorID, PSID, areaID, btn){
	btn.parentNode.parentNode.parentNode.removeChild(btn.parentNode.parentNode);
	$.ajax({url: "DeleteProgramArea?accreditorID=" + accreditorID + "&PSID=" + PSID + "&areaID=" + areaID,
			success: function(result){
			}
    });
	$("#calendar").fullCalendar("refetchEvents");
	$("#calendar").fullCalendar("rerenderEvents");
}
	
function editAccreditor(accreditorID, institutionID, PSID, areaID, btn){
	//btn.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.modal();
	$('#fullCalModal').modal("hide");


	var add = "";
	var accreditors = [];
	var obj = {};
	var counter = 0;
	$.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
		  
		
		url: "AccreditorsLoaderSurvey?PSID=" + PSID +"&institutionID=" + institutionID +"&areaID=" + areaID,
		  dataType: 'json',
		  async: false,
		  success: function(data) {
			  accreditors = data; 			
		  }
		});
	
	$('#modalTitle1').html('<span class="sr-only">close</span></button><h4 id="modalTitle1" class="modal-title"> Editing accreditor... </h4>');
	add += " *Affiliated accreditors and those of different disciplines are hidden in the table.";
	add += "<hr>";
	add += '<div class="table-responsive" style="width:100%; float:right;" id="contenthole">';
	add += '<table id="smarttable" class="table table-striped table-bordered table-hover">';
	add += '<thead><tr><th>ID</th><th>Rank</th><th>Full Name</th><th>Affiliation</th> <th>Discipline</th><th>Primary Survey Area</th><th>Secondary Survey Area</th><th>Tertiary Survey Area</th><th>Total Surveys</th><th>Last Survey Date</th><th>City</th> </tr></thead>';
	add += '<tbody>';
	if(accreditors.length > 0){
		var removes = [];
		//VALIDATOR AND STYLE CHANGER
		var removal = accreditors[accreditors.length - 1].rank;
		
		for(var i = 0; i < accreditors.length; i++){
			if(accreditors[i].rank == removal){
				removes.push(accreditors[i]);
			}else{
				add+="<tr>";
				add += '<td>' + accreditors[i].accreditorID + '</td>';
				add += '<td>' + accreditors[i].rank + '</td>';
				add += '<td>' + accreditors[i].accreditorName + '</td>';
				add += '<td>' + accreditors[i].affiliation + '</td>';
				add += '<td>' + accreditors[i].discipline + '</td>';
				add += '<td>' + accreditors[i].primaryArea + '</td>';
				add += '<td>' + accreditors[i].secondaryArea + '</td>';
				add += '<td>' + accreditors[i].tertiaryArea + '</td>';
				add += '<td>' + accreditors[i].numberSurveys + '</td>';
				add += '<td>' + accreditors[i].lastSurveyDate + '</td>';
				add += '<td>' + accreditors[i].city + '</td>';
				add += '</tr>';

			}
			
		}
	}
	add += '</tbody></table></div>';



	$('#modalBody1').html(add);
	var table = $('#modalBody1').find("table").DataTable({
		"columnDefs": [
            {
                "targets": [ 0 ],
                "visible": false,
                "searchable": false
            }
        ],
        "order": [[ 1, "asc" ]]
	});
	
	var removesButton = document.createElement("BUTTON");
	removesButton.innerHTML = "<i class='fa fa-times-circle' aria-hidden='true' ></i> Show all Accreditors ";
	removesButton.onclick = function() { 
		removesButton.parentNode.removeChild(removesButton);
		var aff;
		for(var j = 0; j < removes.length; j++){
			var t = table.row.add([
				removes[j].accreditorID,
				removes[j].rank,
				removes[j].accreditorName,
				removes[j].affiliation,
				removes[j].discipline,
				removes[j].primaryArea,
				removes[j].secondaryArea,
				removes[j].tertiaryArea,
				removes[j].lastSurveyDate,
				removes[j].numberSurveys,
				removes[j].city
			]).draw(false);
			$(t.node()).addClass('danger');
		}
	};
	
	$('#modalBody1').prepend(removesButton);
	
	 $('#smarttable tbody').on('click', 'tr', function () {
			var chosenAccreditor = table.row(this).data();
			
			var accID = chosenAccreditor[0];
			btn.parentNode.parentNode.cells[0].innerHTML = "<a href='ViewAccreditor?accreditorID=" + accID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>" + chosenAccreditor[2] +"</a>";
			
			$.ajax({url: "UpdateAccreditor?accreditorID=" + accreditorID + "&PSID=" + PSID + "&areaID=" + areaID +"&accID=" + accID,
				success: function(result){
				}
	    });
			$("#calendar").fullCalendar("refetchEvents");
			$("#calendar").fullCalendar("rerenderEvents");
			$('#addModal').modal('toggle');
			$('#fullCalModal').modal('show');
			
			

    } );

	$('#addModal').modal();
	

	//$('#addModal').modal('hide');
	
	

}
function formatDate(date) {
	  var monthNames = [
	    "January", "February", "March",
	    "April", "May", "June", "July",
	    "August", "September", "October",
	    "November", "December"
	  ];

	  var day = date.getDate();
	  var monthIndex = date.getMonth();
	  var year = date.getFullYear();

	  return monthNames[monthIndex] + ' '+ day + ', ' + year;
	}

	$(document).ready(function() {
		
		
		$("[data-toggle='tooltip']").tooltip(); 
		
		/* initialize the external events
		-----------------------------------------------------------------*/

		

		var today = new Date(); var dd = today.getDate(); var mm = today.getMonth()+1; //January is 0!
    	var yyyy = today.getFullYear();
    	if(dd<10){ dd='0'+dd;} 
    	if(mm<10){mm='0'+mm;} 
    	var today = yyyy+'-'+mm+'-'+dd;
    	
		$('#calendar').fullCalendar({
			theme:false,
			header: {
				left: 'prev,next today, month',
				center: 'title',
				right: 'prevYear, nextYear'
			},
			buttonText: {
		        month: "Month View",
				prevYear: parseInt(new Date().getFullYear(), 10) - 1,
		        nextYear: parseInt(new Date().getFullYear(), 10) + 1
		        },
	        viewRender: function(view) {
	            var d = $('#calendar').fullCalendar('getDate');
	            
	            $(".fc-prevYear-button").text(parseInt(d.year(), 10) - 1);
	            $(".fc-nextYear-button").text(parseInt(d.year(), 10) + 1);
	        },
	        dayClick: false,
			defaultDate: today,
			hiddenDays: [0],
			navLinks: true, // can click day/week names to navigate views
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
					$(this).remove();
				}
			,
			eventDrop: function(event, delta, revertFunc) {
				var d1 = Date.parse(today);
		    	var d2 = Date.parse(event.start.format());
		    	var d3 = Date.parse(event.end.format());
		  
		        $.ajax({url: "ScheduleSurvey?surveyID=" + event.id + "&start=" + event.start.format() + "&end=" + event.end.format(), success: function(result){
			        alert(result);
			    }});
		        if(d3 <= d1 ){
		        	event.backgroundColor = past;
				}else{
					if(event.completeness == 'complete'){
						event.backgroundColor = complete;
					}else if(event.completeness == 'incomplete'){
						event.backgroundColor = incomplete;
					}
				}
		        

		        $('#calendar').fullCalendar('refresh');

		    },
		    eventResize: function(event, delta, revertFunc, element) {
		    	
		        if (!confirm("Resize survey?")) {
		            revertFunc();
		        }else{
		        	$.ajax({url: "ResizeSurvey?surveyID=" + event.id + "&end=" + event.end.format(), success: function(result){
				        alert(result);
				    }});
		        }

		    },
		    eventReceive: function(event) {
		        event.start.stripTime();
				
		        event.end = event.start;
		        
		        $.ajax({url: "ScheduleSurvey?surveyID=" + event.id + "&start=" + event.start.format() + "&end=" + event.end.format(), success: function(result){
			        alert(result);
			    }});
		        if(d2 <= d1 ){
					event.backgroundColor = past;
				}else{
					if(event.completeness == 'complete'){
						event.backgroundColor = complete;
					}else if(event.completeness == 'incomplete'){
						event.backgroundColor = incomplete;
					}
				}
		        

		        $('#calendar').fullCalendar('refresh');

		    },
		    eventRender: function(event, element) {
		    	var d1 = Date.parse(today);
		    	var d2 = Date.parse(event.endDate);
				if(d2 <= d1 ){
					if(event.status == "unconfirmed"){
						event.backgroundColor = incomplete;
						//element.append("<button class='btn btn-sm btn-link' style='float:right;' data-toggle='tooltip' data-placement='top' title='Not confirmed.'><i class='fa fa-exclamation' aria-hidden='true' ></i> </button>");
					} else{
						event.backgroundColor = past;
					}
				}
				var add = "<p align='left' style='font-size:10px;'>" + event.institutionName + "<br>Programs: <br>";
				
				for(var i = 0; i < event.programs.length; i++){
					add +=  (i + 1) + ".) " + event.programs[i].programName + " - " + event.programs[i].surveyType+ "<br>";
				}
				add += "</p>";
				
			    $(element).tooltip('destroy');

				$(element).tooltip({title:add, placement:"auto left", html:true, container:'body'}); 
				
				
				$('[data-toggle="tooltip"]').tooltip(); 
	            
	        },
	        
			eventClick: function(event, jsEvent, view){
				var add = "";
				var surveyID = event.id;
				var dateStart = formatDate(new Date(event.start.format()));
				var dateEnd = formatDate(new Date(event.endDate));
				var d1 = Date.parse(today);
				var institutionID = event.institutionID;
		    	var d2 = Date.parse(event.start);

				if(d2 <= d1 ){
					
					$('#modalTitle').html(event.title + "<a class='btn btn-oval btn-sm btn-secondary'style='position: releative;float:right; right:10px; ' href='ConfirmationPage?surveyID=" + surveyID +"'>Go to confirmation page</a>");
				}else{
					$('#modalTitle').html(event.title);
				}
				if(dateStart == dateEnd){
		            $('#modalBody').html("<div style='width: 49%; float:left;'><h4>Date: " + dateStart + "</h4><h6>Institution: " + event.institutionName + "</h6></div>");
				}else{
		            $('#modalBody').html("<div style='width: 49%; float:left;'><h4>Date: " + dateStart + " to " + dateEnd + "</h4><h6>Institution: " + event.institutionName + "</h6></div>");

				}
				
				var extra = "<div style='width:30%; float:left;'>";
	            extra += "Chairperson: " + event.chairpersonName;
	            if(event.paascu1Name != "" && event.paascu1Name != null){
		            extra += "<br>PAASCU Reps: <br>" + event.paascu1Name;
	            }
	            
	            if(event.paascu2Name != "" && event.paascu2Name != null){
		            extra += "<br>" + event.paascu2Name;
	            }
	            extra += "</div>";
	            
	            $('#modalBody').append(extra);
	            
	            add += ("<button class='btn btn-sm btn-info' data-toggle='collapse' data-target='#reports' style='float:right;'><i class='fa fa-folder-open'></i> Reports</button>");
	            add += ("<div style='width: 20%; float:left; background-color:white;' id='reports' class='collapse'><div style='float:right;'><button class='btn btn-link btn-sm' onclick=\'generateTeam(" + JSON.stringify(event.programs) + ", \"" + event.institutionName + "\" , \"" + event.institutionCity + "\" , \" " + dateStart + "\", \"" + event.chairpersonName + "\" , \"" + event.chairpersonInstitution + "\" , \"" + event.chairpersonPosition + "\" , \"" + event.chairpersonCity + "\" , \"" +   event.paascu1Name + "\" , \""  + event.paascu1Position + "\" , \"" +  event.paascu2Name + "\" , \""  + event.paascu2Position + "\")' data-toggle='tooltip' data-placement='left' title='This will generate a ready-to-print PDF file of the team line up for this survey.'><i class='fa fa-file-pdf-o'></i> Team Line Up</button><label class='btn btn-link btn-sm' data-toggle='tooltip' data-placement='left' title='This will let you upload the Team Recommendations file the accreditors have filled up after the visit.'><i class='fa fa-upload'></i> Team Recommendation <input style='display:none;' type='file'></label><button class='btn btn-link btn-sm' data-toggle='tooltip' data-placement='left' title='This will let you download a copy of the survey details.'><i class='fa fa-download'></i> Survey Details</button></div></div>");
	            add += ("<br><br><br><hr><div><h4>Programs and Proponents</h4><label for='sel1'>Programs:</label><select class='form-control underlined chosen-select' data-placeholder='Choose a Program...' id='programForm' style='background: transparent;''></select><button class='btn btn-sm btn-link' style='float:right;' onclick=\"addNewProgram(" + surveyID + ", " + institutionID + ");\"><i class='fa fa-plus'></i>  Add Program</button> <br><hr><ul class='list-group' id='progList'>");
	            
	            
	            
	            for(var i = 0; i < event.programs.length; i++){
	            	var PSID = event.programs[i].PSID;
		            add += ("<li class='list-group-item'><label id='PSID"+PSID+"'>" + event.programs[i].programName + " - " + event.programs[i].surveyType + " <i id='editIcon' style='position:relative; top:0px;right:-5px;' onclick='editType("+PSID+",\""+ event.programs[i].programName +"\", \"" + event.programs[i].surveyType + "\")' class='fa fa-pencil-square-o'></i></label><button onclick='DeleteProgram(" + PSID + ", this)' class='btn btn-link btn-sm' style='float:right;' data-toggle='tooltip' title='This will delete the whole program currently associated with the visit.'><i class='fa fa-times'></i> Delete</button>");
		            add += ("<br><br><table class='table'>");
		            add += ("<thead><tr><th style='width: 20%;'>Name</th> <th style='width: 40%;'>Area</th> <th style='width: 40%;'>Specify Availability</th></tr></thead>");
		            add += ("<tbody>"); 

		            for(var j = 0; j < event.programs[i].areas.length; j++){
		            	if(event.programs[i].areas[j].confirmation == "Not Available"){
			            	add += ("<tr class='danger'>");	
		            	}else if (event.programs[i].areas[j].confirmation == "Unconfirmed"){
			            	add += ("<tr>");
		            	}else{
			            	add += ("<tr class='success'>");
		            	}
		            	if(event.programs[i].areas[j].accreditorID == 0){
		            		if(event.programs[i].areas[j].confirmation == "Not Available"){
			            		add += ("<td>" + event.programs[i].areas[j].accreditor + "</td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-pill-left btn-sm btn-danger' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-secondary btn-pill-right' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}else if(event.programs[i].areas[j].confirmation == "Confirmed"){
			            		add += ("<td>" + event.programs[i].areas[j].accreditor + "</td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-pill-left btn-sm btn-secondary' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-success btn-pill-right' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}else{
			            		add += ("<td>" + event.programs[i].areas[j].accreditor + "</td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-pill-left btn-sm btn-secondary' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-secondary btn-pill-right' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}
		            	}else{
		            		if(event.programs[i].areas[j].confirmation == "Not Available"){
				            	add += ("<td><a href='ViewAccreditor?accreditorID=" + event.programs[i].areas[j].accreditorID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>" + event.programs[i].areas[j].accreditor + "</a></td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-link btn-sm btn-pill-left btn-danger' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-pill-right btn-secondary' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}else if(event.programs[i].areas[j].confirmation == "Confirmed"){
				            	add += ("<td><a href='ViewAccreditor?accreditorID=" + event.programs[i].areas[j].accreditorID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>" + event.programs[i].areas[j].accreditor + "</a></td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-link btn-sm btn-pill-left btn-secondary' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-pill-right btn-success' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}else{
				            	add += ("<td><a href='ViewAccreditor?accreditorID=" + event.programs[i].areas[j].accreditorID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>" + event.programs[i].areas[j].accreditor + "</a></td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-link btn-sm btn-pill-left btn-secondary' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-pill-right btn-secondary' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + event.programs[i].areas[j].accreditorID + ", " + institutionID + "," + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
		            		}
		            
		            	}
		            }
		            add += ("<tr class='info' style='height:65px'><td><select id='areaSelect" + PSID + "'><option>Faculty</option><option>Instruction</option><option>Laboratories</option><option>Libraries</option><option>Community</option><option>Physical Facilities</option><option>Student Services</option><option>Administration</option><option>Research</option><option>Clinical Training</option><option>Other Resources</option></select></td><td><button onclick='addNewSurveyArea("+PSID+", " + institutionID + ")'  class='btn btn-info btn-sm' style='position:relative; left:50%; top:10px'><i class='fa fa-plus'></i> Add New Area</button></td><td></td></tr>");
		            add += ("</tbody>");
		            add += ("</table></li>");

	            }
	            add += ("</ul></div>");

	            
	            
	            add += ("</ul></div>");
	            $('#modalBody').append(add);
	            $('#programForm').empty();
				var temp = document.createElement("option");
				temp.text = "";
				temp.value = 0;
				programForm.add(temp);
				$.getJSON("ProgramLoader?institutionID=" + institutionID, function(data){
					$.each(data, function (key, value){
						var option = document.createElement("option");
						option.text = value.degreeName;
						option.value = value.SPID;
						programForm.add(option);
						
						$('#programForm').trigger("chosen:updated");

					});
				});
				
	            $('#modalfooter').html('<button id="delButton" type="button" class="close" data-dismiss="modal" onclick="deleteSurvey(' + surveyID + ')"><em id="delIcon" class="fa fa-trash-o"></em></button>');
	            $('#fullCalModal').modal();
	            $('[data-toggle="tooltip"]').tooltip(); 
			},
			eventLimit: true, // allow "more" link when too many events
			
			// EVENTS COLORS
			// Past = rgb(118, 212, 245)
			// Not Complete = rgb(238, 116, 116)
			// Complete =  rgb(133, 206, 54)
			//past, incomplete, complete
			
			eventSources: [

		        // your event source
		        {
		            url: 'SurveyLoader',
		            type: 'GET',
		            data: {
		            
		            },
		            error: function() {
		                alert('there was an error while fetching events!');
		            },
		          // a non-ajax option
		            textColor: 'white' // a non-ajax option
		        }
		
		        // any other sources...

    ]
		});
	
	var btnExpanded = $('#expanded');
	btnExpanded.click(function(){
		//java

		var curDate = $('#calendar').fullCalendar('getView').start;
		var lasDate = $('#calendar').fullCalendar('getView').end;
		
		//javascript
		var canvas = document.getElementById('canvas');
		var ctx = canvas.getContext('2d');
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		ctx.fillStyle = '#fff';
		  ctx.fillRect(0, 0, canvas.width, canvas.height);
		  ctx.beginPath();
		  var ptr = 0;
		  
		  //drawing grid
		  for(var x=0; x<=7; x++){
			if(x==1){
				ctx.moveTo(0, 40*x+1);
				ctx.lineTo(1125, 40*x+1);
				ptr = 60;
			}else if(x>1){
				ctx.moveTo(0, 100*(x-1)+1 +40);
				ctx.lineTo(1125, 100*(x-1)+1 + 40);
				ptr += 100;
			}
			else{
				ctx.moveTo(0, 100*x+1);
				ctx.lineTo(1125, 100*x+1);
			}
		  }
		  
		  for(var y=0; y<=7; y++){
			ctx.moveTo(187*y+1,0);
			ctx.lineTo(187*y+1, 756-115);
		  }
		  var date1 = curDate.format();
		  var date2 = lasDate.format();
		  
		  var date1a = date1.split("-");
		  var date2a = date2.split("-");
		  
		  var date1year = date1a[0]; var date1month = date1a[1]; var date1day = date1a[2];
		  var date2year = date2a[0]; var date2month = date2a[1]; var date2day = date2a[2];
		  var maindatemonth = parseInt(date1month) + 1; var maindateyear = 0;
		  
		  if(date1month == 12){
			maindateyear = date1year + 1;
		  }else{
		  	maindateyear = date1year;
		  }
		  
		  var month1length; var month2length; var mainmonthlength;
		  
		  if(date1month=="06" || date1month=="04" || date1month=="09" || date1month== "11"){
			month1length = 31 - date1day;
		  }else if(date1month == "02"){
			if(date1year % 4 == 0){
				month1length = 30 - date1day;
			}else{
				month1length = 29 - date1day;
			}
		  }else{
			month1length = 32 - date1day;
		  }
		  if(maindatemonth==6 || maindatemonth==4 || maindatemonth== 9 || maindatemonth== 11){
			mainmonthlength = 30;
		  }else if(maindatemonth == 2){
			if(date1year % 4 == 0){
				mainmonthlength = 29;
			}else{
				mainmonthlength = 28;
			}
		  }else{
			mainmonthlength = 31;
		  }
		  
		  month2length = 36 - (month1length + mainmonthlength);
		  
		  var includedDays = [];
		  
		  var ptr = 0;
		  
		  ctx.strokeStyle = 'black';
		  ctx.stroke();
		  ctx.fillStyle = '#000';
		  ctx.font = 'bold 16px serif';
		  
		  var days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
		  for(var i=0; i < 6; i++){	  	
			    ctx.fillText(days[i], (187*(i%6))+57, (Math.floor(i/6)*100)+25);   
		  }

		  var date1ptr = 0; var maindateptr = 0; var date2ptr = 0;
		  var dayCounter = 0; var j = 0;
		  
		  do{
		  	if(dayCounter == 6){
		  		dayCounter = 0;
		  		if(date1ptr < month1length){
					date1ptr++;
				}else if(maindateptr < mainmonthlength){
					maindateptr++;
				}else{
					date2ptr++;
				}
		  	}else{
				if(date1ptr < month1length){
					ctx.font = 'bold 12px serif';
					ctx.fillText(parseInt(date1day) + date1ptr, (187*(j%6))+8, (Math.floor(j/6)*100)+60);
					date1ptr++;
				}else if(maindateptr < mainmonthlength){
					ctx.font = 'bold 12px serif';
					ctx.fillText(maindateptr + 1, (187*(j%6))+8, (Math.floor(j/6)*100)+60);
					maindateptr++;
				}else{
					ctx.font = 'bold 12px serif';
					ctx.fillText(date2ptr + 1, (187*(j%6))+8, (Math.floor(j/6)*100)+60);
					date2ptr++;
				}
				dayCounter++; j++;
		  	}
		  }while(j < 36);
			ctx.font = 'bold 20px serif';

			ctx.fillText(date1 + " to " + date2, 900,700);
			ctx.font = 'bold 12px serif';


		  
		  $.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
			  url: "SurveyJSONLoader?startDate=" + date1 + "&endDate=" + date2,
			  dataType: 'json',
			  async: false,
			  success: function(data) {

				$.each(data, function(key, val) {
					var curDate;
					var pos = 0;
					curDate = val.start;
					var curDateDis = curDate.split("-");
					var curDateDay = parseInt(curDateDis[2]); var curDateMonth = parseInt(curDateDis[1]); var curDateYear = parseInt(curDateDis[0]);
					
					if (curDateMonth == date1month){
						pos = curDateDay - date1day;
					}else if(curDateMonth == maindatemonth){
						pos = curDateDay + month1length - Math.floor((curDateDay + month1length) / 7);
					}else if(curDateMonth == date2month){
						pos = curDateDay + month1length + mainmonthlength - Math.floor((curDateDay + month1length + mainmonthlength) / 7);
					}
					pos--;
					var hPtr = 0;
					$.each(val.institutions, function(key1,val1){
						ctx.font = 'bold 12px serif';
						ctx.fillText(val1.insAcr + " : ", (187*(pos%6))+10, (Math.floor(pos/6)*100) + 75 + (hPtr * 15));
						
						var tPtr = 0;
						
						$.each(val1.programs, function(key2, val2){
							ctx.font = '12px serif';
							if(tPtr == 1){
								tPtr=0;
								ctx.fillText(val2.proAcr + " - " + val2.surveyType, (187*(pos%6)) + 130, (Math.floor(pos/6)*100) + 75 + (15 * hPtr));
								hPtr++;
							}else{
								tPtr++;
								ctx.fillText(val2.proAcr + " - " + val2.surveyType, (187*(pos%6)) + 70, (Math.floor(pos/6)*100) + 75 + (15 * hPtr));
							}
						});
					});
					
					
					} );
			  }
			});
		  var base64 = canvas.toDataURL();
		  document.getElementById('base64').href = base64;
		  document.getElementById('base64').download = date1 + " to " + date2;
		  $('#expModal').modal("show");
		  $('#expmodalTitle').html("Showing Expanded Calendar for " + date1 + " to " + date2);
	});
	loadPendings();
});

$('[data-toggle="tooltip"]').tooltip(); 
function addAlert(){
	$('#section').append('<div class="alert alert-success"><a class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Success!</strong> Successfully added survey called: '+asd +'.</div> <br>');
}


function revertEndDate(date){
	var dates = String(date.format()).split("-");
	return dates[0] + "-" + (dates[1] - 1) + "-" + dates[2];
}

function addNewProgram(surveyID, institutionID){
	var programID = $('#programForm').find(":selected").val();
	var programName = $('#programForm').find(":selected").text();
	var adder = $('#progList');
	if(programName ==""){
		alert("Please choose a program!");
	}else{
		$.ajax({url: 'AddNewProgram?surveyID=' + surveyID + "&programID=" + programID,
				success: function(data){
					var PSID = data;
					var add = "";
					add += ("<li class='list-group-item'><label id='PSID"+PSID+"'>" + programName + " - Preliminary <i id='editIcon' style='position:relative; top:0px;right:-5px;' onclick='editType("+PSID+",\""+ programName +"\", \"Preliminary\")' class='fa fa-pencil-square-o'></i></label><button onclick='DeleteProgram(" + PSID + ", this)' class='btn btn-link btn-sm' style='float:right;' data-toggle='tooltip' title='This will delete the whole program currently associated with the visit.'><i class='fa fa-times'></i> Delete</button>");
				    add += ("<br><br><table class='table'>");
				    add += ("<thead><tr><th style='width: 20%;'>Name</th> <th style='width: 40%;'>Area</th> <th style='width: 40%;'>Specify Availability</th></tr></thead>");
				    add += ("<tbody>"); 
	
				    
				    add += ("<tr class='info' style='height:65px'><td><select id='areaSelect"+ PSID + "'><option>Faculty</option><option>Instruction</option><option>Laboratories</option><option>Libraries</option><option>Community</option><option>Physical Facilities</option><option>Student Services</option><option>Administration</option><option>Research</option><option>Clinical Training</option><option>Other Resources</option></select></td><td><button onclick='addNewSurveyArea("+PSID+", " + institutionID + ")'  class='btn btn-info btn-sm' style='position:relative; left:50%; top:10px'><i class='fa fa-plus'></i> Add New Area</button></td><td></td></tr>");
				    add += ("</tbody>");
				    add += ("</table></li>");
				    adder.append(add);
				    $("#calendar").fullCalendar("refetchEvents");
					$("#calendar").fullCalendar("rerenderEvents");
				}
		});
	
	}
}

function editType(PSID,pName, orig){
	var content = document.getElementById("PSID"+PSID).innerHTML;
	content =  pName + " - <select id='selected"+PSID+"'><option>Preliminary</option><option>Formal</option><option>Consultancy</option><option>Revisit</option><option>Interim</option><option>Resurvey</option></select> <i id='saveIcon' style='position:relative; top:0px;right:-5px;' onclick='saveType("+PSID+",\""+pName+"\", \"" + orig + "\")' class='fa fa-check'></i>" +
	"<i id='cancelIcon' style='position:relative; top:0px;right:-10px;' onclick='saveType2("+PSID+",\""+ pName +"\", \"" + orig + "\")' class='fa fa-times'></i>";

	document.getElementById("PSID"+PSID).innerHTML = content;
}

function saveType(PSID,pName, orig){
	var e = document.getElementById("selected"+PSID+"");
	var type = e.options[e.selectedIndex].text;
	var content =  pName + " - "+type+"<i id='editIcon' style='position:relative; top:0px;right:-5px;' onclick='editType("+PSID+",\""+ pName +"\")' class='fa fa-pencil-square-o'></i>";
	document.getElementById("PSID"+PSID).innerHTML = content;
	
	$.ajax({url: "UpdateSurveyType?PSID=" + PSID + "&type=" + type , success: function(result){alert("Successfully changed the program type to "+type);
    }});
	
	$("#calendar").fullCalendar("refetchEvents");
	$("#calendar").fullCalendar("rerenderEvents");
	
}

function saveType2(PSID,pName, orig){
	
	type = orig;
	var content =  pName + " - "+type+"<i id='editIcon' style='position:relative; top:0px;right:-5px;' onclick='editType("+PSID+",\""+ pName +"\", \"" + orig + "\")' class='fa fa-pencil-square-o'></i>";
	document.getElementById("PSID"+PSID).innerHTML = content;
	
	
	$("#calendar").fullCalendar("refetchEvents");
	$("#calendar").fullCalendar("rerenderEvents");
	
}

function addNewSurveyArea(PSID, institutionID){
	var e = document.getElementById("areaSelect" + PSID);
	var area = e.options[e.selectedIndex].value;
	if(area=="Faculty"){var areaID = 1}
	else if(area=="Instruction"){var areaID = 2}
	else if(area=="Other Resources"){var areaID = 11}
	else if(area=="Laboratories"){var areaID = 3}
	else if(area=="Libraries"){var areaID = 4}
	else if(area=="Community"){var areaID = 5}
	else if(area=="Physical Facilities"){var areaID = 6}
	else if(area=="Student Services"){var areaID = 7}
	else if(area=="Administration"){var areaID = 8}
	else if(area=="Research"){var areaID = 9}
	else if(area=="Clinical Training"){var areaID = 10}
	var add = "";
	$.ajax({url: "AddNewSurveyArea?PSID=" + PSID +"&areaID="+areaID , success: function(result){
    }});
	
	var nice = e.parentNode.parentNode.parentNode.parentNode;
	$("#calendar").fullCalendar("refetchEvents");
	$("#calendar").fullCalendar("rerenderEvents");
	
     	
     	//name
     e.parentNode.parentNode.remove();
     add += ("<tr><td>None</td><td>" + area+ "</td><td><button class='btn btn-pill-left btn-sm btn-secondary' onclick='UpdateConfirmation(\"Not Available\", " + "0" + ", " + PSID + ", " + areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm btn-secondary btn-pill-right' onclick='UpdateConfirmation(\"Confirmed\", " + "0" + ", " + PSID + ", " + areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button><button class='btn btn-link btn-sm'  style='float:right;' onclick='deleteArea(" + "0" + ", " + PSID + ", " + areaID + ", this)'><i class='fa fa-times'></i></button><button class='btn btn-link btn-sm'  style='float:right;' onclick='editAccreditor(" + "0" + ", " + institutionID + "," + PSID + ", " + areaID + ", this)'><i class='fa fa-pencil-square-o'></i></button></td></tr>");
     
     add += ("<tr class='info' style='height:65px'><td><select id='areaSelect" + PSID + "'><option>Faculty</option><option>Instruction</option><option>Laboratories</option><option>Libraries</option><option>Community</option><option>Physical Facilities</option><option>Student Services</option><option>Administration</option><option>Research</option><option>Clinical Training</option><option>Other Resources</option></select></td><td><button onclick='addNewSurveyArea("+PSID+", "+ institutionID + ")'  class='btn btn-info btn-sm' style='position:relative; left:50%; top:10px'><i class='fa fa-plus'></i> Add New Area</button></td><td></td></tr>");
	nice.innerHTML += add;
}

function deleteSurvey(surveyID){
	var r = confirm("Are you sure?\nThis will delete all survey details as well as the programs, areas and accreditors linked to this survey.")
	if(r == true){
		$('#calendar').fullCalendar('removeEvents',surveyID);
		$.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
			  url: "DeleteSurvey?surveyID=" + surveyID,
			  async: false,
			  success: function(data) {
					alert("Successfully deleted survey!");
					} 
		});
		
	}
	
	
}

function loadPendings(){
	
	$.getJSON("PendingSurveyLoader", function(data){
		$.each(data, function (key, value){
			var obj = $('<div class="fc-event ui-draggable ui-draggable-handle">'+ value.title + '</div>').data('event', {
				title: value.title,
				dateRequested: value.dateRequested,
				dateApproved: value.dateApproved,
				programs: value.programs,
				id: value.id,
				completeness: value.completeness,
				status: value.status,
				borderColor: value.borderColor,
				backgroundColor: value.backgroundColor
				
			} );
			
			obj.draggable({
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			$('#external-events').append(obj);

		});
		
	});
}

function addSurvey(){
	var sysVar = document.getElementById("systemForm").value;
	var instVar = document.getElementById("institutionForm").value;
	
	
	$('#external-events').append('<div class="fc-event ui-draggable ui-draggable-handle" data-event="{\"title\":\"' + sysVar + '\"}">' + instVar + '</div> <br>');
	$('#external-events .fc-event').each(function() {

		// store data so the calendar knows to render an event upon drop
		$(this).data('event', {
			title: $.trim($(this).text()), // use the element's text as the event title
			backgroundColor: incomplete,
			stick: true // maintain when user navigates (see docs on the renderEvent method)
		});

		// make the event draggable using jQuery UI
		$(this).draggable({
			
			revert: true,      // will cause the event to go back to its
			revertDuration: 0  //  original position after the drag
		});

	});
	$('#systemForm').value = "";
	$('#institutionForm').value = "" ;
	

}

    jsPDF.API.align = function(txt, options, x, y) {
        options = options ||{};
        /* Use the options align property to specify desired text alignment
         * Param x will be ignored if desired text alignment is 'center'.
         * Usage of options can easily extend the function to apply different text 
         * styles and sizes 
        */
        if( options.align == "center" ){
            // Get current font size
            var fontSize = this.internal.getFontSize();

            // Get page width
            var pageWidth = this.internal.pageSize.width;

            // Get the actual text's width
            /* You multiply the unit width of your string by your font size and divide
             * by the internal scale factor. The division is necessary
             * for the case where you use units other than 'pt' in the constructor
             * of jsPDF.
            */
            txtWidth = this.getStringUnitWidth(txt)*fontSize/this.internal.scaleFactor;

            // Calculate text's x coordinate
            x = ( pageWidth - txtWidth ) / 2;
        }

        // Draw text at x,y
        this.text(txt,x,y);
    };


function generateTeam(program, institution, institutionCity,  date, chairpersonName, chairpersonInstitution, chairpersonPosition, chairpersonCity, paascu1Name, paascu1Position, paascu2Name, paascu2Position){
	var indent = 80;
	
	var pdf = new jsPDF('p', 'mm', 'a4');
	pdf.setFontSize(12);
    pdf.align("SURVEY TEAM",{align: "center"},0,20);
    pdf.align("FOR",{align: "center"},0,25);
    pdf.setFontType("bold");
    pdf.align(institution,{align: "center"},0,30);
    pdf.align(institutionCity, {align: "center"}, 0, 35);
    pdf.setFontType("bold");
    var y = 45;
	for(var i = 0; i < program.length; i++){
	    pdf.align(program[i].programName,{align: "center"},0,y);
		y+=5;
	}
	y+=10;
	pdf.setFontType("normal");
    pdf.align(date ,{align: "center"},0, y);
    
    y+=10;
    pdf.text("Staff Chair Person", 30, y);
    pdf.setFontType("bold");
    pdf.text(": " + chairpersonName, indent, y);
    pdf.setFontType("normal");
    if(chairpersonName != "None"){
    	y+=5;
        pdf.text(": " + chairpersonPosition, indent, y);
        y+=5;
        pdf.text(": " + chairpersonInstitution, indent, y)
        y+=5;
        pdf.text(": " + chairpersonCity, indent, y)
    }
    
    y+=10;
    
	for(var i = 0; i < program.length; i++){
	    pdf.setFontType("bold");
		
	    pdf.align(program[i].programName + " - " + program[i].surveyType,{align: "center"},0,y);
		y+=10;
		
	    
		if(y >= 260){
			pdf.addPage();
			y = 20;
		}
		
		for(var j = 0; j < program[i].areas.length; j++){
			if(y >= 260){
				pdf.addPage();
				y = 20;
			}
			pdf.setFontType("normal");
		    pdf.text(program[i].areas[j].area, 30, y);
		    pdf.setFontType("bold");
		    
		    if(program[i].areas[j].confirmation == "Unconfirmed" || program[i].areas[j].confirmation == "Not Available"){
		    	pdf.text(": *" + program[i].areas[j].accreditor, indent, y);
		    }else{
		    	pdf.text(": " + program[i].areas[j].accreditor, indent, y);
		    }
		    
		    if(program[i].areas[j].accreditor != "None"){
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorPosition, indent, y);
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorInstitution, indent, y);
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorCity, indent, y);
		    }
		    y+=10;
		}
		y+=5;
	}
	
	if(y >= 260){
		pdf.addPage();
		y = 20;
	}
	
    
	if(paascu1Name != "" && paascu1Name != null && paascu2Name != "" && paascu2Name != null){
	    pdf.text("PAASCU Representative: ", 30, y);
	    pdf.setFontType("bold");
	    pdf.text(": " + paascu1Name, indent, y);
	    if(paascu1Name != null || paascu1Name != ""){
	    	y+=5;
	        pdf.text(": " + paascu1Position, indent, y);
	    }
	    
	    if(paascu2Name != null || paascu2Name != ""){
	    	y+=10;
	        pdf.text(": " + paascu2Name, indent, y);
	        y+=5;
	        pdf.text(": " + paascu2Position, indent, y);
	
	    }
	}else{
		pdf.text("PAASCU Representative ", 30, y);
	    pdf.setFontType("bold");
	    pdf.text(": No PAASCU Representatives", indent, y);
	}
    pdf.save('Team line up.pdf');
}

</script>

<style>
#expModal {
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  overflow: hidden;
}

.expDialog {
  position: fixed;
  margin: 0;
  width: 100%;
  height: 100%;
  padding: 0;
}

.expContent {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  border: 2px solid #3c7dcf;
  border-radius: 0;
  box-shadow: none;
}

.expHeader {
  position: absolute;
  top: 0;
  right: 0;
  left: 0;
  height: 35px;
  padding: 5px;
  padding-left:20px;
  background: #6598d9;
  border: 0;
}

.expmodalTitle {
  font-weight: 300;
  font-size: 2em;
  color: #fff;
  line-height: 25px;
}

.expBody{
  position: absolute;
  top: 30px;
  bottom: 60px;
  width: 100%;
  font-weight: 300;
  overflow: auto;
}

.expFooter {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  height: 60px;
  padding: 10px;
  background: #f1f3f5;
}






	.my-legend .legend-title {
    text-align: left;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 90%;
    }
  .my-legend .legend-scale ul {
    margin: 0;
    margin-bottom: 5px;
    padding: 0;
    float: left;
    list-style: none;
    }
  .my-legend .legend-scale ul li {
    font-size: 80%;
    list-style: none;
    margin-left: 0;
    line-height: 18px;
    margin-bottom: 2px;
    }
  .my-legend ul.legend-labels li span {
    display: block;
    float: left;
    height: 16px;
    width: 30px;
    margin-right: 5px;
    margin-left: 0;
    border: 1px solid #999;
    }
  .my-legend .legend-source {
    font-size: 70%;
    color: #999;
    clear: both;
    }
  .my-legend a {
    color: #777;
    }
	#contenthole{
		-webkit-box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		-moz-box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		box-shadow: 0px 4px 13px -4px rgba(0,0,0,0.5);
		padding:10px;
		background-color: #f8f8f8;
	}

	
	#smarttable th, #smarttable td {		
		text-align: left;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;	}
		
	#smarttable th{
		background-color:#85CE36;
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
		margin: 0 auto;	
		z-index:21;
		}
		
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
		
		#leftbar{
		position:absolute;
			background:#e9e9e9;
			left:83%;
			-webkit-box-shadow: inset 2px 0px 7px 2px rgba(0,0,0,0.52);
-moz-box-shadow: inset 2px 0px 7px 2px rgba(0,0,0,0.52);
box-shadow: inset 2px 0px 7px 2px rgba(0,0,0,0.52);
		}
		
		.fc-event {
    border-width:5px;
}
		
</style>


<style>

#logo{
top:80px;
left:14%;
height: 625px;
position:absolute;
opacity:0.05;

}
#delButton{
position:relative;
float:right;
right:10px;
top:0px;
opacity:1;
height:35px;
}

#delIcon{
left:40px;
top:10px;
color: #4e4e4e; !important
transition: 1s ease;
}

#delIcon:hover{
color:red;
font-size:120%;
}

.fc-content{
  transition:  height 2s ease;
}
.fc-content:hover{
height:25px;

}

#aPending{
position:relative;
top:10px;
left:10px;
font-family:Existence-Medium; 
}
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

#expanded{
position:relative;
top:80px;
left:17%;
-webkit-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 4px 7px 1px rgba(0,0,0,0.41);
}
#expanded:hover{

top:83px;
-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);

}
#cPending{
position:relative;
top:75px;
left:5px;


}
.widget{
 overflow:visible;
}
</style>
    </head>

    <body>
    	 
        <div class="main-wrapper">
            <div class="app" id="app">
               
                <aside class="sidebar" style="position:fixed"><img id ="bg" src="assets/bg.jpg">
				
                    <div class="sidebar-container">
                    	
                       <div class="sidebar-header" >
                            <div class="brand" style="background-color:#1c252e;position:relative;left:-17%;width:150%;box-shadow: 10px 9px 24px 0px rgba(1,1,1,1);"  >
                                 <div class="logo" id="logoDiv" style="width:100%;"> <img src="assets/logoicon.png" style="width:52%;height:185%; top:-40%;left:9%; opacity:1"> </div>
                       
                        </div><br>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li>
                                    <a href="Notifications"> <i class="fa fa-home"></i> Dashboard </a>
                               <li class="active">
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addSurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li>
									
                                    <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                        <li> <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li> <a href="Institutions">
    								Institutions
    							</a> </li>
								 <li> <a href="SchoolSystems">
    								School Systems
    							</a> </li>
								 <li> <a href="Programs">
    								Programs
    							</a> </li>
								 
                                 
                                    </ul>
                                    
                                    
                                </li>
                                 
                                
                               
                            </ul>
                        </nav>
                    </div>
                    <footer class="sidebar-footer">
            
			
					
                </aside>
				 <aside class="sidebar" id="leftbar">
				
                    <div class="sidebar-container">
					
						<button id="expanded" type="button" class="btn btn-info btn-sm"><i class="fa fa-plus"></i> Expanded View</button><br><br>					

                            <div id="cPending" class="col-xl-12">
                                <div class="card card-default" style="height:460px;-webkit-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);-moz-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);" >
                                    <div class="card-header">
                                        <div class="header-block"id="aPending">
                                            <p class="title"> Pending Surveys</p>
                                        </div>
                                    </div>
                                    <div class="card-block"style="height:75%;overflow-y: scroll;">
												<div id='external-events' style=" padding:5px;height:100%;width:100%;border-radius: 6px 6px 6px 6px;-moz-border-radius: 6px 6px 6px 6px;-webkit-border-radius: 6px 6px 6px 6px;border: 1px solid #e6e6e6;">
							
							
												</div>
									   </div>
                                    <div class="card-footer">
                                    
                                    <div class='my-legend' style="height:120px;">
                                    <div class='legend-title'>Legend:</div>
									<div class='legend-scale'>
									  <ul class='legend-labels'>
									    <li><span style='background:rgb(91, 9, 9);'></span>Unconfirmed/Incomplete</li>
									    <li><span style='background:rgb(0,119,29);'></span>Complete</li>
									    <li><span style='background:rgb(12, 48, 107); border-width: 2px; border-color:rgb(149, 209, 229)'></span>Confirmed by Team</li>
									    <li><span style='background:rgb(12, 48, 107); border-width: 2px; border-color:rgb(234, 232, 114)'></span>Confirmed by Board</li>
									    <li><span style='background:rgb(12, 48, 107);'></span>Confirmed by Commitee</li>
									  </ul>
									</div>
                                    </div>
                                    
                                    
                                </div>
                            </div>
						
						
			
						
					</div>
				</aside>
				<div class="container">
	<video poster="assets/banner.jpg" id="bgvid"  playsinline autoplay muted loop>
  <!-- WCAG general accessibility recommendation is that media such as background video play through only once. Loop turned on for the purposes of illustration; if removed, the end of the video will fade in the same way created by pressing the "Pause" button  -->

<source src="assets/vid.mp4" type="video/mp4">
</video>
</div>
            
			   
			   
                <article class="content dashboard-page" style="position: relative; top:-170px; left:-25px; width:78%; ">
				 <section class="section" id="section"style="position:relative; width:110%;" >  
				 <img id ="logo" src="assets/logo.png">                 
				   <div id='calendar' style="position:relative; float:right; width:100%;"></div>
				   </section>
				   				
				  
                </article>
				
				
				
				
				
		<!-- EXPANDED MODAL -->
		<div id="expModal" class="modal animated bounceIn">
    		<div class="modal-dialog expDialog">
        		<div class="modal-content expContent">
            	
            		<div class="modal-header expHeader">
                		<button type="button" class="close" data-dismiss="modal" style="padding-right: 10px;"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h6 id="expmodalTitle" class="modal-title"></h6>
            		</div>
            	
            		<div id="expmodalBody" class="modal-body expBody">
            		<center>
            		<canvas id='canvas' width='1125' height='756'></canvas>
						</center>
            		</div>
            		<div id="expmodalfooter" class="modal-footer expFooter">
                	<a class='btn btn-link' href='' id='base64'>Download</a>
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
       </div></div>
				
				
				
				
				
				
                
        <!-- QUICK ADD MODAL -->
			<div id="myModal" class="modal fade" role="dialog">
  				<div class="modal-dialog">

    			<!-- Modal content-->
    			<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
        			<h4 class="modal-title">Add Event</h4>
      			</div>
      			<div class="modal-body">
      				<form>
        			<div class="form-group">
  						<label for="sel1">Event Name:</label>
  						<input type="text"/>
					</div>
					
					<div class="form-group">
  						<label for="sel1">Remarks:</label><br>
  						<textarea rows="4" cols="50"></textarea>
					</div>
        			</form>
        			
      			</div>
      			<div class="modal-footer">
					
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-success" onclick="alert('wala pa'); "data-dismiss="modal" >Submit</button>
      			</div>
    			</div>

  				</div>
			</div>  
			
        <!-- EVENT MODAL -->
       	<div id="fullCalModal" class="modal fade">
    		<div class="modal-dialog modal-lg style="width:70%;"">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
            			
            		</div>
            		<div id="modalfooter" class="modal-footer">
                	
           		 	</div>
        		</div>
    		</div>
		
		</div>
		
		<!-- ACCREDITOR MODAL -->
       	<div id="addModal" class="modal fade">
    		<div class="modal-dialog modal-lg style="width:70%;"">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle1" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody1" class="modal-body">
            			
            		</div>
            		<div id="modalfooter1" class="modal-footer">
                	
                	
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
       </div></div>
        <script src="js/app.js"></script>
		
		</body>

</html>