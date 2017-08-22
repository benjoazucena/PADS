        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!doctype html>
<html class="no-js" lang="en">

    <head>
    <script src='js/jquery.min.js'></script>
    <script src='js/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="chosen/chosen.css">
  <script src="chosen/chosen.jquery.js" type="text/javascript"></script>
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
<link rel="stylesheet" type="text/css" href=" css/dataTables.bootstrap.min.css">
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
	


<script>
	$(document).ready(function() {
		
		var systemForm = document.getElementById('systemForm');
		var institutionForm = document.getElementById('institutionForm');
		var programForm = document.getElementById('programForm');
		
		//EVENT LISTENER FOR CHOOSING A SYSTEM, CHANGING THE INSTITUTIONS AND SHOWING WHAT'S UNDER THAT SYSTEM
		$('#systemForm').chosen().change(function(){
			var temp = document.createElement("option");
			temp.text = "";
			temp.value = 0;
			var systemID = $('#systemForm').find(":selected").val();	
			$('#institutionForm').empty();
			institutionForm.add(temp);
			$.getJSON("InstitutionsLoader?systemID=" + systemID, function(data){
				$.each(data, function (key, value){
					var option = document.createElement("option");
					option.text = value.institutionName;
					option.value = value.institutionID;
					institutionForm.add(option);
					$('#institutionForm').trigger("chosen:updated");
				});	
			});
		});
		
		//EVENT LISTENER FOR CHOOSING AN INSTITUTION, CHANGING THE PROGRAMS AND SHOWING WHAT'S UNDER THAT INSTITUTION
		$('#institutionForm').chosen().change(function(){
			$('#programForm').empty();
			var institutionID = $('#institutionForm').find(":selected").val();
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
					if(value.surveyType == null || value.surveyType == ""){
						document.getElementById('suggestedSurveyType').innerHTML = "Suggested Survey Type: Preliminary";

					}else{
						document.getElementById('suggestedSurveyType').innerHTML = "Suggested Survey Type: " + value.surveyType;
					}
					$('#programForm').trigger("chosen:updated");

				});
			});
		});
		getSystems();
		
		$('[data-toggle="tooltip"]').tooltip(); 
		
	var selected = [];
    $('#smarttable').DataTable( {
		"fnCreatedRow": function( nRow, aData, iDataIndex ) {
			if ( aData[3] != "Faculty")
			{
				$('td:eq(3)', nRow).css({"background-color": "red"});
				if( aData[4].includes("Faculty") ){
					$('td:eq(4)', nRow).css({"background-color": "green"});
				}
			}
			if ( aData[1] == "De La Salle University" )
			{
				$('td:eq(1)', nRow).css({"background-color": "red"});
			}
		},
		"order": [[ 4, "desc" ]],
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
	
	 $('#smarttable tbody').on('click', 'tr', function () {
			alert('Successfully selected an accreditor!');
			$('#addModal').modal('toggle');
    } );

	$('#smarttable2').DataTable( {
		
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
	
	 $('#smarttable2 tbody').on('click', 'tr', function () {
			alert('Successfully selected an accreditor!');
			$('#addModal').modal('toggle');
    } );
	
	$('#smarttable3').DataTable( {
	
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
	
	 $('#smarttable3 tbody').on('click', 'tr', function () {
			alert('Successfully selected an accreditor!');
			$('#addModal').modal('toggle');
    } );
	
	
	
	});


//PROGRESS BAR HANDLERS
function addProp(){
	$("#progBar").html("<div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progDetails'><i class='fa fa-file-text-o'></i> Details</div><div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progProponents'><i class='fa fa-university'></i> Programs/Areas </div>");
	$(".chosen-container").each(function() {
	       $(this).attr('style', 'width: 100%');
	   });    
}

function addDet(){
	$("#progBar").html("<div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progDetails'><i class='fa fa-file-text-o'></i> Details</div>");

}

function addSure(){
	$("#progBar").html("<div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progDetails'><i class='fa fa-file-text-o'></i> Details</div><div class='progress-bar progress-bar-success' role='progressbar' style='width:33%' id='progProponents'><i class='fa fa-university'></i>  Programs/Areas </div><div class='progress-bar progress-bar-success progress-bar-striped' role='progressbar' style='width:33%' id='progProponents'> <i class='fa fa-users'></i> Accreditors </div>");

}

//LEGACY FUNC
function addRep(){
	$('#addRep').modal();
}


function changeDetails(){
	$("#progProponents").className = "progress-bar progress-bar-success progress-bar-striped";
	$("#progDetails").className = "progress-bar progress-bar-success";
	$("#progSure").className = "progress-bar progress-bar-success";
}

//THIS IS THE JSON OBJECT THAT'S GOING TO BE BUILT ALL THROUGHOUT THE PROCESS, TO BE PASSED TO THE SERVLET FOR PARSING
var surveyObject = {
		programList:[],
};

//CHECKER FOR AFFILIATION AND PROGRAM
function checkAffiliations(SPID, systemID,area){
	var obj = [];
	var counter = 0;
	
	$.ajax({
		  url: "AccreditorsLoader?SPID=" + SPID +"&systemID=" + systemID+"&area="+ area,
		  dataType: 'json',
		  async: false,
		  success: function(data) {
			  $.each(data, function (key, value){
					obj.push({});					
					obj[counter]['accreditorName'] = value.accreditorName;
					obj[counter]['primaryArea'] = value.primaryArea;
					obj[counter]['secondaryArea'] = value.secondaryArea;
					obj[counter]['tertiaryArea'] = value.tertiaryArea;
					obj[counter]['primaryAreaID'] = value.primaryAreaID;
					obj[counter]['secondaryAreaID'] =  value.secondaryAreaID;
					obj[counter]['tertiaryAreaID'] = value.tertiaryAreaID;
					obj[counter]['city'] = value.city;
					obj[counter]['discipline'] = value.discipline;
					obj[counter]['numberSurveys'] = value.numberSurveys;	
					obj[counter]['accreditorID'] = value.accreditorID;
					obj[counter]['rank'] = value.rank;
					obj[counter]['score'] = value.score;
					counter++;
					});					
				return obj;
		  }
		});
	
	
}

var globalPrograms = 0;
//HANDLER FOR EACH ADD OF PROGRAM IN PROCESS 2
function addProgram(){
	

	var strUser = $('#programForm option:selected').text();
	var strSurvey = $('#surveyForm option:selected').text();
	var programID = $('#programForm option:selected').val();
	var systemID = $('#systemForm option:selected').val();
	if(strUser == ""){
		alert("Please choose a program!");
	}else if(strSurvey == ""){
		alert("Please choose survey type!");
	}else{
	var obj = {};
	obj.SPID = programID;
	obj.surveyType = strSurvey;
	obj.areas = [];
	globalPrograms++;
	obj.id = globalPrograms;
	var areaCounter = 0;
	var counter = 0;
	alert(strSurvey);

	var add =  "<li class='list-group-item' id='programLi"+ globalPrograms +"'><h6>" + strUser + " - " + strSurvey + "</h6> <ul class='list-group'>";
	
	
	//BUILDING DYNAMIC TABLE FOR ASSIGNING ACCREDITORS FOR EACH PROGRAM
	
	var title = document.createElement("h6");
	title.appendChild(document.createTextNode( strUser + " - " + strSurvey));
	
	var tableDiv = document.createElement("div");
	tableDiv.className = "table-responsive";
	tableDiv.style.width = "100%";
	tableDiv.id = "accTable" + globalPrograms;
	
	var table = document.createElement("table");
	table.className = "table table-striped";

	var thead = table.createTHead();
	var theadRow = thead.insertRow(0);
	theadRow.insertCell(0).innerHTML = "<b>Area</b>";
	theadRow.insertCell(1).innerHTML = "<b>Most Recent Accreditor</b>";
	theadRow.insertCell(2).innerHTML = "<b>Select Accreditors</b>";
	
	

	var add3 = "<h6>" + strUser + " - " + strSurvey + "</h6><div class='table-responsive' style='width: 100%;'><table class='table table-striped'><thead><tr><th>Area</th><th>Most Recent Accreditor</th><th>Controls</th></tr></thead><tbody>"
	var acc = "Not Loaded, system failed.";
	
	//BUILDING JSON OBJECT TO BE PASSED TO SERVLET
	//EACH AJAX CALL CHECKS FOR THE LATEST ACCREDITOR THAT HAS BEEN ASSIGNED TO A SURVEY TO THAT INSTITUTION AND PROGRAM
	//EACH AJAX CALL ALSO BUILDS THE TABLE WITH THE RECOMMENDER SYSTEM (AS YOU CAN SEE in addAccreditor Function)
	//IT ALSO BUILDS THE BUTTON THAT WOULD DYNAMICALLY ADD THE SPECIFIC ACCREDITOR CHOSEN TO THE SPECIFIC AREA AND APPENDS IT BACK TO THE JSON OBJECT
	var programCounter = surveyObject.programList.length;
	if(document.getElementById('fac').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 1;
		obj.areas[areaCounter]['area'] = 'Faculty';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter1 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=1",  async: false, success: function(result){
	       	acc = result;
	       	var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('fac').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('fac').value, programID, strSurvey, facCounter1, programCounter, this);       		

	       	};
	       	rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('fac').value + "</li>";
	}
	if(document.getElementById('ins').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 2;
		obj.areas[areaCounter]['area'] = 'Instruction';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter2 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=2",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('ins').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('ins').value, programID, strSurvey,  facCounter2, programCounter, this);       		

	       	};	       	
	       	rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('ins').value + "</li>";
	}
	if(document.getElementById('lab').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 3;
		obj.areas[areaCounter]['area'] = 'Laboratories';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter3 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=3",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('lab').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('lab').value, programID, strSurvey,  facCounter3, programCounter, this);       		
 	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('lab').value + "</li>";
	}
	if(document.getElementById('lib').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 4;
		obj.areas[areaCounter]['area'] = 'Libraries';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter4 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=4",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('lib').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('lib').value, programID, strSurvey,  facCounter4, programCounter, this);       		
      	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('lib').value + "</li>";
	}
	if(document.getElementById('com').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 5;
		obj.areas[areaCounter]['area'] = 'Community';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter5 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=5",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('com').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('com').value, programID, strSurvey,  facCounter5, programCounter, this);       		
 	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('com').value + "</li>";
	}
	if(document.getElementById('phy').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 6;
		obj.areas[areaCounter]['area'] = 'Physical Facilities';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter6 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=6",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('phy').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('phy').value, programID, strSurvey,  facCounter6, programCounter, this);       		

	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('phy').value + "</li>";
	}
	if(document.getElementById('stu').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 7;
		obj.areas[areaCounter]['area'] = 'Student Services';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter7 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=7",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('stu').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('stu').value, programID, strSurvey,  facCounter7, programCounter, this);       		
    	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('stu').value + "</li>";
	}
	if(document.getElementById('adm').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 8;
		obj.areas[areaCounter]['area'] = 'Administration';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter8 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=8",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('adm').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('adm').value, programID, strSurvey,  facCounter8, programCounter, this);       		
   	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('adm').value + "</li>";
	}
	if(document.getElementById('res').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 9;
		obj.areas[areaCounter]['area'] = 'Research';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter9 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=9",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('res').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('res').value, programID, strSurvey,  facCounter9, programCounter,  this);       		
      	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);

	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('res').value + "</li>";
	}
	if(document.getElementById('cli').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 10;
		obj.areas[areaCounter]['area'] = 'Clinical Training';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter10 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=10",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('cli').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('cli').value, programID, strSurvey,  facCounter10, programCounter, this);       		     	
	       		};	       	
	       		rowTemp.insertCell(2).appendChild(btnTemp);
	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('cli').value + "</li>";
	}
	if(document.getElementById('oth').checked) {
		obj.areas.push({});
		obj.areas[areaCounter]['areaID'] = 11;
		obj.areas[areaCounter]['area'] = 'Other Resources';
		obj.areas[areaCounter]['accreditorIDs'] = [];
		var facCounter11 = areaCounter;
		
		$.ajax({url: "LatestAccreditor?SPID=" + programID + "&areaID=11",  async: false, success: function(result){
	        acc = result;
	        var rowTemp = table.insertRow();
	       	rowTemp.insertCell(0).innerHTML = document.getElementById('oth').value;
	       	rowTemp.insertCell(1).innerHTML = acc;
	       	var btnTemp = document.createElement('BUTTON');
	       	btnTemp.appendChild(document.createTextNode('Add'));
	       	btnTemp.onclick = function(){
	       		addAccreditor(document.getElementById('oth').value, programID, strSurvey,  facCounter11, programCounter, this);       		
	       	};	       	
	       	rowTemp.insertCell(2).appendChild(btnTemp);

	    }});
		areaCounter++;
		add += "<li class='list-group-item'>" + document.getElementById('oth').value + "</li>";
	}
	
	surveyObject.programList.push(obj);
	
	
   	//appendChild(btnX);
	add += "</ul></li>";
	var try1 = $('#addedList').append(add);
	var lel = globalPrograms;
	
	var closer = document.createElement("i");
	closer.className="fa fa-times";
	closer.style ="top:-10px; position:relative;";
	
	var btnX = document.createElement('BUTTON');
	btnX.type="button";
	btnX.className = "btn btn-s btn-link";
	btnX.style="float:right;";
	btnX.appendChild(closer);
	btnX.onclick = function(){
		$("#programLi"+lel).remove();
		$("#accTable"+lel).remove();

		surveyObject.programList = surveyObject.programList.filter(function(item){
			return item.id !== lel;
		});
		
   	};	      
   	
   	$("#programLi"+lel).find("h6").append(btnX);
   	
	var lal = document.getElementById("added");
	lal.scrollTop = lal.scrollHeight;
	
	tableDiv.appendChild(title);
	tableDiv.appendChild(table);
	$('#addedList2').append(tableDiv);

	}
}

function addChairperson(btn){
	var accreditors = [];
	var counter = 0;
	
	
	$.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
		  url: "AccreditorsLoader?SPID=0&systemID=0",
		  dataType: 'json',
		  async: false,
		  success: function(data) {
			  $.each(data, function (key, value){
				  	accreditors.push({});
					accreditors[counter]['accreditorName'] = value.accreditorName;
					accreditors[counter]['primaryArea'] = value.primaryArea;
					accreditors[counter]['secondaryArea'] = value.secondaryArea;
					accreditors[counter]['primaryAreaID'] = value.primaryAreaID;
					accreditors[counter]['secondaryAreaID'] =  value.secondaryAreaID;
					accreditors[counter]['city'] = value.city;
					accreditors[counter]['discipline'] = value.discipline;
					accreditors[counter]['numberSurveys'] = value.numberSurveys;	
					accreditors[counter]['accreditorID'] = value.accreditorID;
					accreditors[counter]['hasAffiliation'] = value.hasAffiliation;
					counter++;
					});					
				
		  }
		});
	
	var add = "";
	//BUILDING THE ACCREDITOR TABLE SPECIFICALLY TAILORED FOR EACH INSTITUTION - PROGRAM - AREA

	$('#modalTitle').html('<span class="sr-only">close</span></button><h4 id="modalTitle" class="modal-title"> Choosing survey chairperson</h4>');
	add += "<hr>";
	add += '<div class="table-responsive" style="width:100%; float:right;" id="contenthole">';
	add += '<table id="smarttable" class="table table-striped table-bordered table-hover">';
	add += '<thead><tr><th>ID</th><th>Full Name</th><th>Discipline/Specialization</th><th>Primary Survey Area</th><th>Secondary Survey Areas</th><th>Total Surveys</th><th>City</th> </tr></thead>';
	add += '<tbody>';
	
	//VALIDATOR AND STYLE CHANGER
	for(var i = 0; i < accreditors.length; i++){
		add += '<tr>';
		add += '<td>' + accreditors[i].accreditorID + '</td>';
		add += '<td>' + accreditors[i].accreditorName + '</td>';
		add += '<td>' + accreditors[i].discipline + '</td>';
		add += '<td>' + accreditors[i].primaryArea + '</td>';
		add += '<td>' + accreditors[i].secondaryArea + '</td>';
		add += '<td>' + accreditors[i].numberSurveys + '</td>';
		add += '<td>' + accreditors[i].city + '</td>';
		add += '</tr>';
	}
	add += '</tbody></table></div>';
	$('#modalBody').html(add);
	var table = $('#smarttable').DataTable( {} );
	
	//ONCLICK OF ASSIGNING ACCREDITOR
	 $('#smarttable tbody').on('click', 'tr', function () {
			var chosenAccreditor = table.row(this).data();
			surveyObject.chairpersonID = chosenAccreditor[0];
			btn.innerHTML = chosenAccreditor[1] + " (change)";
			$('#addModal').modal('toggle');
    } );
	
	$('#addModal').modal();
}
function addAccreditor(area, program, survey, areaCounter, programCounter, btn){
	var add = "";
	//BUILDING THE ACCREDITOR TABLE SPECIFICALLY TAILORED FOR EACH INSTITUTION - PROGRAM - AREA
	var accreditors = [];
	var obj = {};
	var systemID = $('#systemForm option:selected').val();
	var counter = 0;
	$.ajax({ //CALLING ACCREDITORS WITH EXTRA CHECKING FOR AFFILIATION CONFLICTS
		  
		
		url: "AccreditorsLoader?SPID=" + program +"&systemID=" + systemID +"&area=" + area,
		  dataType: 'json',
		  async: false,
		  success: function(data) {
			  accreditors = data; 			
		  }
		});
	
	$('#modalTitle').html('<span class="sr-only">close</span></button><h4 id="modalTitle" class="modal-title"> Adding accreditor for ' + program + " - " + area + '</h4>');
	add += " *Affiliated accreditors and those of different disciplines are hidden in the table.";
	add += "<hr>";
	add += '<div class="table-responsive" style="width:100%; float:right;" id="contenthole">';
	add += '<table id="smarttable" class="table table-striped table-bordered table-hover">';
	add += '<thead><tr><th>ID</th><th>Rank</th><th>Full Name</th><th>Affiliation</th> <th>Discipline</th><th>Primary Survey Area</th><th>Secondary Survey Area</th><th>Tertiary Survey Area</th><th>Total Surveys</th><th>Last Survey Date</th><th>City</th> </tr></thead>';
	add += '<tbody>';
	
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
	add += '</tbody></table></div>';



	$('#modalBody').html(add);
	var table = $('#modalBody').find("table").DataTable({
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
	
	$('#modalBody').prepend(removesButton);
		
	
	//var table = $('#smarttable').DataTable( {} );
	
	//ONCLICK OF ASSIGNING ACCREDITOR
	 $('#smarttable tbody').on('click', 'tr', function () {
			var chosenAccreditor = table.row(this).data();
			var accIDs = surveyObject.programList[programCounter].areas[areaCounter].accreditorIDs;
			var ch = false;
			accIDs.filter(function(item){
				if(item == chosenAccreditor[0]){
					ch = true;
				}
			});
			if(ch == true){
				alert("You have selected a duplicate!");
			}else{
				accIDs.push(chosenAccreditor[0]);
				var accCounter = accIDs.indexOf(chosenAccreditor[0]);
	
	
	       		var accBtn = document.createElement("BUTTON");
	       		accBtn.innerHTML = "<i class='fa fa-times-circle' aria-hidden='true' ></i> "+ chosenAccreditor[2] + " ";
	       		accBtn.onclick = function() { 
	       			accBtn.parentNode.removeChild(accBtn);
	       			accIDs.splice(accCounter, 1);
	       		};

	       		btn.parentNode.insertBefore(accBtn, btn);
				
				
				$('#addModal').modal('toggle');
			}
			
    } );
	
	$('#addModal').modal();
}

function selectAll(){
	document.getElementById("fac").checked = true;
	document.getElementById("ins").checked = true;
	document.getElementById("lab").checked = true;
	document.getElementById("lib").checked = true;
	document.getElementById("com").checked = true;
	document.getElementById("phy").checked = true;
	document.getElementById("stu").checked = true;
	document.getElementById("adm").checked = true;
	document.getElementById("res").checked = true;
	document.getElementById("cli").checked = true;
	document.getElementById("oth").checked = true;
}

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

function saveSurvey(){
	//CALLS AND PASSES THE JSON OBJECT BUILT ALL THROUGH OUT THE PROCESS, TO THE SERVLET
	var systemID = $('#systemForm').find(":selected").val();	
	var institutionID = $('#institutionForm').find(":selected").val();
	
	var paascu1Name = $('#paascu1Name').val();
	var paascu1Position = $('#paascu1Position').val();
	var paascu1Contact = $('#paascu1Contact').val();
	
	var paascu2Name = $('#paascu2Name').val();
	var paascu2Position = $('#paascu2Position').val();
	var paascu2Contact = $('#paascu2Contact').val();
	
	surveyObject.systemID = systemID;
	surveyObject.institutionID = institutionID;
	
	surveyObject.paascu1Name = paascu1Name;
	surveyObject.paascu1Position = paascu1Position;
	surveyObject.paascu1Contact = paascu1Contact;
	
	surveyObject.paascu2Name = paascu2Name;
	surveyObject.paascu2Position = paascu2Position;
	surveyObject.paascu2Contact = paascu2Contact;

	$.ajax({
		url: 'SaveSurvey',
		type: 'POST',
		dataType: 'json',
		async: false,
		data: {surveyObject: JSON.stringify(surveyObject)},
		success: function(result){
			alert('Survey successfully added! Redirecting you to the survey page...')
		
		}
	});
	alert("Survey Successfully Added");
	document.location.href="survey.jsp";
	
}

</script>
<style>
	tr.highlight{
		background-color: red !important;
	}
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
					 	
					 		<div class="progress" style="width:500px; height:20px;" id="progBar">
  								<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" style="width:33%" id="progDetails">
    								<i class='fa fa-file-text-o'></i> Details
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
								<li  class="active">
                                    <a href="AddSurvey"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
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
				
                <div class="sidebar-overlay" id="sidebar-overlay"></div>
				
                <article class="content dashboard-page">
				 
				 <div class="tab-content">     
				
				 <!-- MENU 1 -->
				 	<div id="menu1" class="tab-pane fade in active">    
				 	 <section class="section" id="section1">          
				   	<form style="height:420px; overflow:scroll;">
        			<div class="form-group">
  						<label for="sel1">School System:</label><br>
  						<select class="form-control underlined chosen-select" data-placeholder="Choose a System..." id="systemForm" style="background: transparent;">
							 				
  						</select>
					</div>
					
					<div class="form-group">
  						<label for="sel1">Institutions:</label>
  						<select class="form-control underlined chosen-select" data-placeholder="Choose an Institution..." id="institutionForm" style="background: transparent;">
  						</select>
					</div>
					
				
					
					
					
        			</form>
        			<hr>
        			<button type="button" class="btn btn-success" onclick="addProp();" data-toggle="tab" href="#menu2" style="float:right;">
  						Next Step <i class="fa fa-angle-double-right"></i>
  					</button>	
        			</section>
        			</div>
        			
        			<!-- MENU 2 -->
        			 
        			<div id="menu2" class="tab-pane fade">
        			<section class="section" id="section2"> 
    					<form style="height:520px; overflow:scroll;">
    					<div id="add" style="float:left; width: 40%; height: 500px;" class="card sameheight-item">
    					<div class="card-block">
    					<h3>Add Programs</h3>
    					<div class="form-group">
  						<label for="sel1">Program:</label><br>
  						<select class="form-control underlined chosen-select" style="width:100%;" data-placeholder="Choose a Program..." id="programForm">
  						</select>
					</div>
					
					<div class="form-group">
					<label id="suggestedSurveyType"></label>
  						<label for="sel1">Type of Survey:</label>
  						<select class="form-control underlined" id="surveyForm">
							<option>Preliminary</option>
							<option>Consultancy</option>
							<option>Formal</option>
							<option>Revisit</option>
							<option>Interim</option>
							<option>Resurvey</option>        					
  						</select>
					</div>
					
					<div class="form-group">
  						<label for="sel1">Areas:</label> <button type="button" class="btn btn-link btn-sm" onclick="selectAll();">Select All <i class='fa fa-plus-circle'></i></button><br>
  						<div style="width: 44%; float:left;">
  						<label><input type="checkbox" class="checkbox " value="Faculty" id="fac"><span>Faculty</span></label>
						<label><input type="checkbox" class="checkbox " value="Instruction" id="ins"><span>Instruction</span></label>
						<label><input type="checkbox" class="checkbox " value="Laboratories" id="lab"><span>Laboratories</span></label>
						<label><input type="checkbox" class="checkbox " value="Libraries" id="lib"><span>Libraries</span></label>
						<label><input type="checkbox" class="checkbox " value="Research" id="res"><span>Research</span></label>
						<label><input type="checkbox" class="checkbox " value="Community" id="com"><span>Community</span></label>						
						</div>
						<div style="width: 55%; float:right;">
						<label><input type="checkbox" class="checkbox " value="Physical Plant" id="phy"><span>Physical Plant</span></label>
						<label><input type="checkbox" class="checkbox " value="Student Services" id="stu"><span>Student Services</span></label>
						<label><input type="checkbox" class="checkbox " value="Administration" id="adm"><span>Administration</span></label>
						<label><input type="checkbox" class="checkbox " value="Clinical Training" id="cli"><span>Clinical Training</span></label>
						<label><input type="checkbox" class="checkbox " value="Other Resources" id="oth"><span>Other Resources</span></label>
						
						
						</div>
					</div>
					<div class="form-group">
						<button type="button" class="btn btn-success" onclick="addProgram()" style="float:right;">
  						Add <i class="fa fa-plus"></i> 
  						</button>
  						</div>
  						</div>
  						</div>
  					<div id="added" style="width: 59%; height: 460px; float:right; overflow: scroll;">
  						<ul id="addedList" class="list-group">
  							
  						</ul>
  					</div>
  					
  					<div id="navBut">
					<div class="form-group">
						
  					</div>
        			</form>
        				
        			</section>
        			<hr>
        			<button type="button" class="btn btn-success" onclick="addDet();" data-toggle="tab" href="#menu1" style="float:left;">
  						<i class="fa fa-angle-double-left"></i> Back
  						</button>
  						<button type="button" class="btn btn-success" onclick="addSure();" data-toggle="tab" href="#menu3" style="float:right;">
  						Next Step <i class="fa fa-angle-double-right"></i>
  						</button>
  					</div>
  					
  				
  					
  					
  					<!-- MENU 3 -->
  					  
  					<div id="menu3" class="tab-pane fade">
  					<section class="section" id="section3">
  					<h3>Assign Accreditors</h3>
    					
    					
  						
    					<div id="added2" class="form-group">
  							<ul id="addedList2" class="list-group">		
  							</ul>
  						</div>
        			
        				<div class="card card-block sameheight-item">
    					<form role="form" class="form-inline">
    					<div class="form-group form-inline">
  							<div class="title-block"> <h3 class="title"> Chairperson: </h3> </div>
								<button type="button" class="btn btn-link" onclick="addChairperson(this);">
  								Select Chairperson <i class="fa fa-angle-double-right"></i>
  								</button>			
							</div>
  						</form>
  						</div>
  						
  						<div class="card card-block sameheight-item">
    					<form role="form" class="form-inline">
    					<div class="form-group form-inline">
  							<div class="title-block"> <h3 class="title"> PAASCU Rep 1: </h3> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Name</label><br> <input type="text" id="paascu1Name" style="width:90%;" class="form-control underlined"  placeholder="e.g. Alma"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Position</label> <input type="text" id="paascu1Position" style="width:90%;" class="form-control underlined"   placeholder="e.g. Board Director"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Contact Number</label> <input type="text" id="paascu1Contact" style="width:90%;" class="form-control underlined"  placeholder="e.g. 0999-999-999"> </div>  						</div>
  						</form>
  						</div>
  						
  						<div class="card card-block sameheight-item">
    					<form role="form" class="form-inline">
    					<div class="form-group form-inline">
  							<div class="title-block"> <h3 class="title"> PAASCU Rep 2: (Leave blank if unnecessary) </h3> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Name</label><br> <input type="text" id="paascu2Name" style="width:90%;" class="form-control underlined"  placeholder="e.g. Alma"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Position</label> <input type="text" id="paascu2Position" style="width:90%;" class="form-control underlined"   placeholder="e.g. Board Director"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Contact Number</label> <input type="text" id="paascu2Contact" style="width:90%;" class="form-control underlined"  placeholder="e.g. 0999-999-999"> </div>  						</div>
  						</form>
  						</div>
  							
        				<button type="button" class="btn btn-success" onclick="addProp();" data-toggle="tab" href="#menu2" style="float:left;">
  							<i class="fa fa-angle-double-left"></i> Back
  							</button>
  							<button type="button" class="btn btn-info" onclick="saveSurvey();" style="float:right;">
  							<i class="fa fa-check"></i> Save 
  							</button>
        			</section>
        			</div>
        			 
				  
             
					
				  
                </article>
             	
       	<!-- ADD ACCREDITOR MODAL -->
            
             <div id="addModal" class="modal fade">
    		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title"></h4>
            		</div>
            	
            		<div id="modalBody" class="modal-body">
							 <div class="table-responsive" style="width:100%; float:right;" id="contenthole">
										
                                                <table id="smarttable" class="table table-striped table-bordered table-hover">
												   
                                                    <thead>
                                                      <tr>
                                                            <th>Full Name</th>
															<th>Institution</th>
                                                            <th>Discipline/Specialization</th>
                                                            <th>Primary Survey Area</th>
															<th>Secondary Survey Areas</th>
															<th>Total Surveys</th>
                                                            <th>City</th>
                                                            <th>Controls</th>
                                                        </tr>
                                                    </thead>
													
													
													<tbody>
														<c:forEach items="${accreditors}" var="acc">
														
												        <tr>
												        
												          <td><c:out value="${acc.getFullName()}"/></td>
												          <td><c:out value="${acc.getInstitution()}"/></td>
 												          <c:if test="${acc.getInstitution()}">
 												          
												          	
												          	<td style="background-color:red;" ><c:out value="${acc.getInstitution()}"/></td>
												          </c:if>
												          
												           <c:if test="${acc.getInstitution()}">
												          
												          	<td ><c:out value="${acc.getInstitution()}"/></td>
												          </c:if>
												          
												          
												         
												         
												          <td><c:out value="${acc.getDiscipline()}"/></td>
                                                          
                                                          
                                                          <td><c:out value="${acc.getFullName()}"/></td>
												          <c:if test="${acc.getInstitution()}">
												          	
												          	<td style="background-color:red;" ><c:out value="${acc.getPrimaryArea()}"/></td>
												          </c:if>
												          
												           <c:if test="${acc.getInstitution()}">
												          
												          <td><c:out value="${acc.getPrimaryArea()}"/></td>
												          </c:if>
                                                          
                                                          
                                                          
												          <td><c:out value="${acc.getSecondaryArea()}"/></td>
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
						</div>
            		<div class="modal-footer">
                		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                		
           		 	</div>
        		</div>
    		</div>
		
		</div>

		
		
		<!-- Modal for adding PAASCU Rep and Chair-->
		<div id="addRep" class="modal fade">
    		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
            	
            		<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                		<h4 id="modalTitle" class="modal-title">Adding a PAASCU Rep/Chair</h4>
            		</div>
					
            		<div id="modalBody" class="modal-body">
						<div class="table-responsive" style="width:100%;" id="contenthole">
								<form role="form" class="form-inline">
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Name</label> <input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. Alma"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Position</label> <input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. Board Director"> </div>
											<div class="form-group" style="width:48%; padding-right"> <label class="control-label">Contact Number</label> <input type="text" class="form-control underlined" style="width:90%;"  placeholder="e.g. 0999-999-999"> </div>
								</form>
					</div>
            		<div class="modal-footer">
                		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                		<button type="button" class="btn btn-success" data-dismiss="modal" onclick="alert('Successfully added Rep/Chair!');">Submit</button>
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
		  <script type="text/javascript">
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:10},
      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
      '.chosen-select-width'     : {width:"95%"}
    }
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
  </script>
		
		</body>

</html>