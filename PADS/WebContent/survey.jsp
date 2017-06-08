<!doctype html>
<html class="no-js" lang="en">

    <head>
    <!-- IMPORTS -->

    <script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/bootstrap.min.js"></script>
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
   
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
		}else if (con == "Confirmed"){
			obj.parentNode.parentNode.className="success";

		}
		$.ajax({url: "UpdateConfirmation?accreditorID=" + id + "&confirmation=" + con + "&PSID=" + psid + "&areaID=" + area, success: function(result){
	    }});
	}
	
	function DeleteProgram(PSID, obj){
		var r = confirm("Are you sure?\nThis will delete all data related to the survey-program.")
		if(r == true){
		obj.parentNode.parentNode.removeChild(obj.parentNode);
		$.ajax({url: "DeletePSID?PSID=" + PSID, success: function(result){
	        alert(result);
	    }});
		}
	}
	
	function EditProgram(PSID){
		document.location.href='EditPSID?PSID=' + PSID;
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
				left: 'prev,next today',
				center: 'title',
				right: 'prevYear, nextYear'
			},
			buttonText: {
		        prevYear: parseInt(new Date().getFullYear(), 10) - 1,
		        nextYear: parseInt(new Date().getFullYear(), 10) + 1
		        },
	        viewRender: function(view) {
	            var d = $('#calendar').fullCalendar('getDate');
	            
	            $(".fc-prevYear-button").text(parseInt(d.year(), 10) - 1);
	            $(".fc-nextYear-button").text(parseInt(d.year(), 10) + 1);
	        },
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
		    	
		        $.ajax({url: "ScheduleSurvey?surveyID=" + event.id + "&start=" + event.start.format() + "&end=" + event.start.format(), success: function(result){
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
		    	var d2 = Date.parse(event.start);
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
				$(element).tooltip({title:add, placement:"auto left", html:true, container:'body'}); 
				
				
				$('[data-toggle="tooltip"]').tooltip(); 
	            element.find(".closeon").click(function() {
					if(confirm("Are you sure?")) {
						alert(event.title + " was removed.");
						$('#calendar').fullCalendar('removeEvents',event._id);
						
					}
	            });
				$('[data-toggle="tooltip"]').tooltip(); 
	        },
	        
			eventClick: function(event, jsEvent, view){
				var add = "";
				var surveyID = event.id;
				var dateStart = formatDate(new Date(event.start.format()));
				var dateEnd = formatDate(new Date(event.endDate));
				var d1 = Date.parse(today);
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
	            
	            add += ("<button class='btn btn-sm btn-info' data-toggle='collapse' data-target='#reports' style='float:right;'><i class='fa fa-folder-open'></i> Reports</button>");
	            add += ("<div style='width: 49%; float:right;' id='reports' class='collapse'><div style='float:right; width: 40%;'><button class='btn btn-link btn-sm' onclick=\'generateTeam(" + JSON.stringify(event.programs) + ", \"" + event.institutionName + "\" , \"" + event.institutionCity + "\" , \" " + dateStart + "\", \"" + event.chairpersonName + "\" , \"" + event.chairpersonInstitution + "\" , \"" + event.chairpersonPosition + "\" , \"" + event.chairpersonCity + "\" , \"" +   event.paascu1Name + "\" , \""  + event.paascu1Position + "\" , \"" +  event.paascu2Name + "\" , \""  + event.paascu2Position + "\")' data-toggle='tooltip' data-placement='left' title='This will generate a ready-to-print PDF file of the team line up for this survey.'><i class='fa fa-file-pdf-o'></i> Team Line Up</button><label class='btn btn-link btn-sm' data-toggle='tooltip' data-placement='left' title='This will let you upload the Team Recommendations file the accreditors have filled up after the visit.'><i class='fa fa-upload'></i> Team Recommendation <input style='display:none;' type='file'></label><button class='btn btn-link btn-sm' data-toggle='tooltip' data-placement='left' title='This will let you download a copy of the survey details.'><i class='fa fa-download'></i> Survey Details</button></div></div>");
	            add += ("<br><br><br><hr><div><h4>Programs and Proponents</h4> <button class='btn btn-sm btn-link' style='float:right;'><i class='fa fa-plus'></i>  Add Program</button> <br><hr><ul class='list-group'>");
	            
	            for(var i = 0; i < event.programs.length; i++){
	            	var PSID = event.programs[i].PSID;
		            add += ("<li class='list-group-item'><label>" + event.programs[i].programName + " - " + event.programs[i].surveyType + "</label><button onclick='DeleteProgram(" + PSID + ", this)' class='btn btn-link btn-sm' style='float:right;' data-toggle='tooltip' title='This will delete the whole program currently associated with the visit.'><i class='fa fa-times'></i> Delete</button><button onclick='EditProgram(" + PSID + ")' class='btn btn-link btn-sm' style='float:right;' data-toggle='tooltip' title='This will take you to another page that will let you edit the proponents currently associated with the program and their areas. It will also allow you to change the type of the visit.'><i class='fa fa-pencil-square-o'></i> Edit</button>");
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
			            	add += ("<td>" + event.programs[i].areas[j].accreditor + "</td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-link btn-sm' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button></td></tr>");

		            	}else{
			            	add += ("<td><a href='ViewAccreditor?accreditorID=" + event.programs[i].areas[j].accreditorID + "' data-toggle='tooltip' title='This will take you to the accreditor page.'>" + event.programs[i].areas[j].accreditor + "</a></td><td>" + event.programs[i].areas[j].area + "</td><td><button class='btn btn-link btn-sm' onclick='UpdateConfirmation(\"Not Available\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-down'></i> Not Available</button><button class='btn btn-link btn-sm' onclick='UpdateConfirmation(\"Confirmed\", " + event.programs[i].areas[j].accreditorID + ", " + PSID + ", " + event.programs[i].areas[j].areaID + ", this)'><i class='fa fa-thumbs-o-up'></i> Available</button></td></tr>");
		            
		            	}
		            }
		            add += ("</tbody>");
		            add += ("</table></li>");

	            }
	            add += ("</ul></div>");

	            
	            
	            add += ("</ul></div>");
	            $('#modalBody').append(add);
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
		
	});
$('[data-toggle="tooltip"]').tooltip(); 
function addAlert(){
	$('#section').append('<div class="alert alert-success"><a class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Success!</strong> Successfully added survey called: '+asd +'.</div> <br>');
}


function deleteSurvey(surveyID){
	var r = confirm("Are you sure?\nThis will delete all survey details as well as the programs, areas and accreditors linked to this survey.")
	if(r == true){
		$('#calendar').fullCalendar('removeEvents',surveyID);
		
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
    pdf.text(": " + chairpersonName, 120, y);
    pdf.setFontType("normal");
    if(chairpersonName != "None"){
    	y+=5;
        pdf.text(": " + chairpersonPosition, 120, y);
        y+=5;
        pdf.text(": " + chairpersonInstitution, 120, y)
        y+=5;
        pdf.text(": " + chairpersonCity, 120, y)
    }
    
    y+=10;
    
	for(var i = 0; i < program.length; i++){
	    pdf.setFontType("bold");
		
	    pdf.align(program[i].programName + " - " + program[i].surveyType,{align: "center"},0,y);
		y+=10;
		
	    

		for(var j = 0; j < program[i].areas.length; j++){
			pdf.setFontType("normal");
		    pdf.text(program[i].areas[j].area, 30, y);
		    pdf.setFontType("bold");
		    pdf.text(": " + program[i].areas[j].accreditor, 120, y);
		    if(program[i].areas[j].accreditor != "None"){
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorPosition, 120, y);
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorInstitution, 120, y);
			    y+=5;
			    pdf.text(": " + program[i].areas[j].accreditorCity, 120, y);
		    }
		    y+=10;
		}
		y+=5;
	}
	
    
    
    pdf.text("PAASCU Representative: ", 30, y);
    pdf.setFontType("bold");
    pdf.text(": " + paascu1Name, 120, y);
    if(paascu1Name != null){
    	y+=5;
        pdf.text(": " + paascu1Position, 120, y);
    }
    
    if(paascu2Name != null){
    	y+=10;
        pdf.text(": " + paascu2Name, 120, y);
        y+=5;
        pdf.text(": " + paascu2Position, 120, y);

    }
    pdf.save('Team l	ine up.pdf');
}

</script>

<style>
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
               
                <aside class="sidebar"><img id ="bg" src="assets/bg.jpg">
				
                    <div class="sidebar-container">
                    	
                        <div class="sidebar-header">
                            <div class="brand">
                                <div class="logo"> <span class="l l1"></span> <span class="l l2"></span> <span class="l l3"></span> <span class="l l4"></span> <span class="l l5"></span> </div> PAASCU </div>
                        </div>
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
                                 <li><a href="#demo3" data-toggle="collapse"> <i class="fa fa-bar-chart"></i> Reports <i class="fa arrow"></i> </a><ul id="demo3" class="collapse"><li> <a href="reportGA.html">GA Awardees</a> </li><li> <a href="reportHistory.html">History</a> </li></ul></li>
								<li>
								    <a href="notifications.html"> <i class="fa fa-bell-o"></i> Notifications <p style="width:15px; height:17px;text-align:center; border-radius:10px; font-family: Verdana; font-size:10px;float:right; background-color:red; color:white;">10</p></a> 
								 </li>
                                
                               
                            </ul>
                        </nav>
                    </div>
                    <footer class="sidebar-footer">
            
			
					
                </aside>
				 <aside class="sidebar" id="leftbar">
				
                    <div class="sidebar-container">
					
						
						<button id="bPending" type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i> Add Event</button><br><br>
					

                            <div id="cPending" class="col-xl-12">
                                <div class="card card-default" style="height:460px;-webkit-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);-moz-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.31);" >
                                    <div class="card-header">
                                        <div class="header-block"id="aPending">
                                            <p class="title"> Pending Surveys</p>
                                        </div>
                                    </div>
                                    <div class="card-block"style="height:75%;">
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
    		<div class="modal-dialog modal-lg" style="width:70%;">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body"></div>
            		<div id="modalfooter" class="modal-footer">
                	
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
		
		<script>loadPendings();</script>
		</body>

</html>