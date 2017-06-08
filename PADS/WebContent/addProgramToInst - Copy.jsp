<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!doctype html>
<html class="no-js" lang="en">

    <head>
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

		

function addAlert(asd){
	$('#section').append('<div class="alert alert-success"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Success!</strong> Successfully added survey called: '+asd +'.</div> <br>');
}



function addProgram(){
	
	var strUser = $('#program option:selected').text();
	
	var x = document.createElement("LI");
	
	x.innerHTML = "" + strUser + "";
	x.classList.add("list-group-item");
	
	var b = document.createElement("BUTTON");
	b.type="button";
	b.innerHTML = "<i class='fa fa-trash-o'></i> Delete";
	b.classList.add("btn");
	b.classList.add("btn-link");
	b.classList.add("btn-sm");
	b.onclick = function (){
		this.parentNode.parentNode.removeChild(this.parentNode);
	}
	b.style = "float:right;";
	
	$('#addedList').append(x);
	x.appendChild(b);
	
	
	var lal = document.getElementById("added");
	lal.scrollTop = lal.scrollHeight;
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
	
	#progItem{
	
    border: 1px solid #ececec;
    border-radius: 10px;
	padding: 5px 5px 5px 5px;
	}

</style>
    </head>

    <body>
    	 
        <div class="main-wrapper">
      				
        			
      			</div>
      			
    		

  	
			
            <div class="app" id="app">
                
                <aside class="sidebar">
				
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
								<li  class="active">
                                    <a href="#demo" data-toggle="collapse"> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    
                                    <ul id="demo" class="collapse">
                                  
                                        <li> <a href="Accreditors">
    								Accreditors
    							</a> </li>
                                        <li class="active"> <a href="Institutions">
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
				 <div class="title-block">
                        <h3 class="title" style="float:left;">
                        
							<a href="ViewInstitution?institutionID=<%=request.getParameter("ID") %>"> <em class="fa fa-arrow-circle-left"></em> <%=request.getParameter("Name") %></a> 
						</h3>
			     </div>
				<section class="section" id="section2"> 
    					<form method="POST" action="AddProgramToInst" class="form">
    					<div id="add" style="float:left; width: 100%; height: 460px;" class="card sameheight-item">
    					<div class="card-block">
    					<h3>Select General Field of Discipline</h3>
    					<div class="form-group">
  						<select name = "general" class="form-control" id="program">
  						<%@page import="java.util.ArrayList"%>
  						<%@page import="Models.Program"	%>
  						<%@page import="Utilities.ProgramUtil" %>
  						<%ArrayList<Program> programs = new ArrayList<Program>();%>
  						<%ProgramUtil progUtil = new ProgramUtil();%>
  						<%programs = progUtil.getPrograms(); %>
  						<option><i></i></option>
  							<%for(Program temp: programs){ %>
  							<option value=<%=temp.getProgramID()%> ><%=temp.getName() %></option>
    						<%} %>
  						</select>
					</div>
					<br><br>
					<div class="form-group">
						<label>Specific Program Name: </label><input type="text" style="width: 100%;" placeholder="Enter Specific Name of the Program" class="form-control underlined" name="specific" id="surveyName">
  						</div>
  						<input type="hidden" name="instID" value=<%=request.getParameter("ID") %>>
  						<br>
  						<button type="submit" class="btn btn-success"  style="float:right;">
  						<em class="fa fa-floppy-o"></em> Save Program
  						</button>
  						</div>
  						</div>
  					
  					
  					
        			</form>
        				
        			</section>
        			<hr>
        			
  						
  						
  					 </article>
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