<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html class="no-js" lang="en">
	
	
    <head>
    	<script src="js/jquery.min.js"></script>
    	
    	
    	
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
		
<script src="calendar/fullcalendar.js"></script>
    	<script src="calendar/fullcalendar.min.js"></script>
    	
    		
<script>

$(document).ready(function() {
	
// 	Call check for unconfirmned surveys
	

	buildHome();
	buildAwards();
	buildExpirations();
	buildUnconfirmedSurveys();
	buildRead();
	
	
});
  



function buildHome(){
	var add = "";	
	add += "<ul class='item-list striped' id='g' >";	
	<c:forEach items="${all}" var="all">
		add += "<li class='item'  >";
		add += "<div class='item-row' id='awardNotif'> ";
	    add += "<div class='item-col fixed item-col-check'> <label class='item-check' id='select-all-items'><span></span></label> </div>";
	    var type = '${all.type}';
	    if( type=="Awards"){	
	    	add += " <div class='item-col fixed item-col-img md'><i class='fa fa-trophy fa-2x'></i></div>";
	    }
	    else if(type =="Expirations"){	
	    	add += " <div class='item-col fixed item-col-img md'> <i class='fa fa-exclamation fa-2x'></i></div>";
	    }
	    else if(type =="UnconfirmedSurveys"){	
	    	add += " <div class='item-col fixed item-col-img md'> <i class='fa fa-warning fa-2x'></i></div>";
	    }
	   
	    		add += "<div class='item-col fixed pull-left item-col-title'>";
	    		add += " <div>   <b><c:out value='${all.getContent()}'/></b> <div><c:out value='${all.getType()}'/></div></div></div>";
	    		add += "<div class='item-col item-col-date'>";           
	         	add += "    <div class='no-overflow'> <c:out value='${all.getDateCreated()}'/> </div>";
	         	add += "<div class='col-md-1' > <i class='fa fa-times' id='deleteNotif' onclick='deleteNotif(${all.getNotificationID()}, this)'></i> </div></div>";
	        add += "</div>";
	    add += "</li>";    
	</c:forEach>   
	    
    add += "</ul>";
        
    
    $('#home-pills').append(add);
         
         
}

function buildRead(){
	var add = "";	
	add += "<ul class='item-list striped' id='g' >";	
	<c:forEach items="${read}" var="read">
		add += "<li class='item'  >";
		add += "<div class='item-row' id='awardNotif'> ";
	    add += "<div class='item-col fixed item-col-check'> <label class='item-check' id='select-all-items'><span></span></label> </div>";
	    var type = '${read.type}';
	    if( type=="Awards"){	
	    	add += " <div class='item-col fixed item-col-img md'><i class='fa fa-trophy fa-2x'></i></div>";
	    }
	    else if(type =="Expirations"){	
	    	add += " <div class='item-col fixed item-col-img md'> <i class='fa fa-exclamation fa-2x'></i></div>";
	    }
	    else if(type =="UnconfirmedSurveys"){	
	    	add += " <div class='item-col fixed item-col-img md'> <i class='fa fa-warning fa-2x'></i></div>";
	    }
	   
	    		add += "<div class='item-col fixed pull-left item-col-title'>";
	    		add += " <div>   <b><c:out value='${read.getContent()}'/></b> <div><c:out value='${read.getType()}'/></div></div></div>";
	    		add += "<div class='item-col item-col-date'>";           
	         	add += "    <div class='no-overflow'> <c:out value='${read.getDateCreated()}'/> </div>";
	        add += "</div>";
	    add += "</li>";    
	</c:forEach>   
	    
    add += "</ul>";
        
    
    $('#readNotifications-pills').append(add);
}

function buildAwards(){
	var add = "";
	
	add += "<ul class='item-list striped' id='g' >";
	
	<c:forEach items="${awards}" var="awards">
		add += "<li class='item'  >";
		add += "<div class='item-row' id='awardNotif'> ";
	    add += "<div class='item-col fixed item-col-check'> <label class='item-check' id='select-all-items'><span></span></label> </div>";
	    	add += " <div class='item-col fixed item-col-img md'><i class='fa fa-trophy fa-2x'></i></div>";
	    		add += "<div class='item-col fixed pull-left item-col-title'>";
	    		add += " <div>   <c:out value='${awards.getContent()}'/> <div>Award</div></div></div>";
	    		add += "<div class='item-col item-col-date'>";           
	         	add += "    <div class='no-overflow'> <c:out value='${all.getDateCreated()}'/> </div>";
	         	add += "<div class='col-md-1' > <i class='fa fa-times' id='deleteNotif' onclick='deleteNotif(${awards.getNotificationID()}, this)'></i> </div></div>";
	        add += "</div>";
	    add += "</li>";    
	</c:forEach>   
	    
    add += "</ul>";
        
    
    $('#award-pills').append(add);
         
         
}

function deleteRead(){
	$('#readNotifications-pills ul li').remove();
	
	var sure = confirm("Are you sure?");
	if(sure == true){
		$.ajax({URL:'DeleteReadNotifications', success: function(data){
			alerT("Successfully deleted all notifications!");
		}
		});
	}
	
}

function buildExpirations(){
	var add = "";
	add += "<ul class='item-list striped' id='g' >";
	
	<c:forEach items="${expirations}" var="expirations">
		add += "<li class='item'  >";
		add += "<div class='item-row' id='awardNotif'> ";
	    add += "<div class='item-col fixed item-col-check'> <label class='item-check' id='select-expirations.-items'><span></span></label> </div>";
	    	add += " <div class='item-col fixed item-col-img md'><i class='fa fa-exclamation fa-2x'></i></div>";
	    		add += "<div class='item-col fixed pull-left item-col-title'>";
	    		add += " <div>   <c:out value='${expirations.getContent()}'/> <div>Expirations</div></div></div>";
	    		add += "<div class='item-col item-col-date'>";           
	         	add += "    <div class='no-overflow'> <c:out value='${expirations.getDateCreated()}'/> </div>";
	         	add += "<div class='col-md-1' > <i class='fa fa-times' id='deleteNotif' onclick='deleteNotif( ${expirations.getNotificationID()}, this )'></i> </div></div>";
	        add += "</div>";
	    add += "</li>";    
	</c:forEach>   
	    
    add += "</ul>";
        
    
    $('#expiration-pills').append(add);
         
         
}

function buildUnconfirmedSurveys(){
	var add = "";
	
	add += "<ul class='item-list striped' id='g' >";
	
	<c:forEach items="${unconfirmedSurveys}" var="unconfirmedSurveys">
		add += "<li class='item'  >";
		add += "<div class='item-row' id='awardNotif'> ";
	    add += "<div class='item-col fixed item-col-check'> <label class='item-check' id='select-'><span></span></label> </div>";
	    	add += " <div class='item-col fixed item-col-img md'> <i class='fa fa-warning fa-2x'></i></div>";
	    		add += "<div class='item-col fixed pull-left item-col-title'>";
	    		add += " <div>   <c:out value='${unconfirmedSurveys.getContent()}'/> <div>Unconfirmed Survey</div></div></div>";
	    		add += "<div class='item-col item-col-date'>";           
	         	add += "    <div class='no-overflow'> <c:out value='${unconfirmedSurveys.getDateCreated()}'/> </div>";
	         	add += "<div class='col-md-1' > <i class='fa fa-times' id='deleteNotif' onclick='deleteNotif(${unconfirmedSurveys.getNotificationID()}, this)'></i> </div></div>";
	        add += "</div>";
	    add += "</li>";    
	</c:forEach>   
	    
    add += "</ul>";
        
    
    $('#unconfirmedSurvey-pills').append(add);
         
         
}

function deleteNotif(notificationID, btn){
	var deleter = btn.parentNode.parentNode.parentNode.parentNode;
	btn.parentNode.removeChild(btn);
	var divDel = deleter.cloneNode(true);
	deleter.remove();
	$('#readNotifications-pills ul').append(divDel);

	var sure = confirm("Set this notification as read?");
	if (sure == true){
		$.ajax({url:"MarkNotification?notificationID=" + notificationID, success: function(data){}
			
		});
	}
}


</script>

<style>

	.container{
		width: 110%;
		overflow:hidden;
		display:block;
		height: 200px;
		z-index:-1;
		margin-left:-15px;
}
	#bgvid{
		position:relative;
		top:-400px;
		margin-top:0px;
		width:110%
	
	}

	body {
		
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	#bg{
		height: 640px;
		position:fixed;
	}
	
	#main{
		position:relative;
		top:-290px;
	
	}
	
	#pnum_danger,#pnum_info,#pnum_warning,#pnum_primary{
		font-size:75px; 
		text-align:center;
		 margin-left: -2px;
		padding: 0;
		
		line-height:85px;
	}
	
	#pnum_danger{
	color:#5c5c5c;	
	transition: all 0.5s ease;
	}	
		#pnum_danger:hover{
		color:#ff2b2b;	
		font-size:100px;
		cursor:pointer;
		}

	#pnum_warning{
	color:#5c5c5c;	
	transition: all 0.5s ease;
	}	#pnum_warning:hover{
		font-size:100px;
		cursor:pointer;
		color:#fe8832;
		}
		
	#pnum_info{
	color:#5c5c5c;	
	transition: all 0.5s ease;
	}	#pnum_info:hover{
		color:#5ecdf3;
		font-size:100px;
		cursor:pointer;
		}
	
	#pnum_primary{
	color:#5c5c5c;	
	transition: all 0.5s ease;
	}	#pnum_primary:hover{
		color:#85CE36;
		font-size:100px;
		cursor:pointer;
		}
	
	#psub{
		font-size:17px; 
		color:#bcbcbc;
		text-align:center;
		margin-top: 6px;
		padding: 0;
		line-height:20px;
	}
	
	#bc {
		color:white;
	}
	
	#bc:hover { 
		color:#85CE36;
	}
	
	#welcome{
		position:relative;
		top:-60px;
		color:white;
		left:40px;
		font-family:Existence-Light;
		
	}
	.h1{
		font-size:100%;
	}
	
	@font-face {
		font-family: Existence-Light;
		src: url(fonts/Roboto-Thin.ttf);
	}
	
				
	#notifcard{
		-webkit-box-shadow: 0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		-moz-box-shadow:    0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		box-shadow:         0px 1px 5px 0px rgba(50, 50, 50, 0.58);
		width:87%;
		left:15px;	}
		
	#notifContent{
		width:700px;
	}
	
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
		
	#deleteNotif:hover{
	color:red;
	transition: color 300ms ease;
	transition: font-size 300ms ease;
	 font-size:1.5em;
		}
		
	#expiryNotif{
	padding-top:15px;
	padding-bottom:15px;
	position:relative;
	  cursor: pointer;
	 
	}
	#expiryNotif:hover{
	background-color:#afafaf;
	color:white;
	
		-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		box-shadow: 0px 3px 2px 0px rgba(0,0,0,0.31);
		 transition: background-color 400ms linear;
		 transition: color 400ms linear;
		 }
	#unconfirmedNotif{
	padding-top:15px;
	padding-bottom:15px;
	position:relative;
	  cursor: pointer;
	 
	}
	#unconfirmedNotif:hover{
	background-color:#afafaf;
	color:white;
	
		-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		box-shadow: 0px 3px 2px 0px rgba(0,0,0,0.31);
		 transition: background-color 400ms linear;
		 transition: color 400ms linear;
		 }	 
		 
	#awardNotif{
	padding-top:15px;
	padding-bottom:15px;
	position:relative;
	  cursor: pointer;
	 
	}
	#awardNotif:hover{
	background-color:#afafaf;
	color:white;
	
		-webkit-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		-moz-box-shadow: 0px 1px 7px 1px rgba(0,0,0,0.41);
		box-shadow: 0px 3px 2px 0px rgba(0,0,0,0.31);
		 transition: background-color 400ms linear;
		 transition: color 400ms linear;
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
	
        <div class="main-wrapper" >
            <div class="app" id="app">
				   
                <aside class="sidebar" style="" ><img id ="bg" src="assets/bg.jpg">
                
                    <div class="sidebar-container">
                    				
                    
                          <div class="sidebar-header" >
                            <div class="brand" style="background-color:#1c252e;position:relative;left:-17%;width:150%;box-shadow: 10px 9px 24px 0px rgba(1,1,1,1);"  >
                                 <div class="logo" id="logoDiv" style="width:100%;"> <img src="assets/logoicon.png" style="width:52%;height:185%; top:0%;left:9%; opacity:1"> </div>
                       
                        </div><br>
                        <nav class="menu">
                            <ul class="nav metismenu" id="sidebar-menu">
                                <li class="active">
                                    <a href="Notifications"> <i class="fa fa-home"></i> Dashboard </a>
                                </li>
								<li>
                                    <a href="survey.jsp"> <i class="fa fa-table"></i> Survey Schedule </a>
								
                                </li>
								<li>
                                    <a href="addSurvey.jsp"> <i class="fa fa-pencil-square-o"></i> Add New Survey </a>
								</li>
								<li>
                                    <a href=""> <i class="fa fa-file-text-o"></i> Database <i class="fa arrow"></i> </a>
                                    <ul>
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
    								Disciplines
    							</a> </li>
                                    </ul>
                                </li>
								
								
								
                                
								<li>
								     
								 </li>
                                
                               
                            </ul>
                        </nav>
                    </div>
                    </div>
                   
            
			
					
                </aside>
				
				<div class="container">
	<video poster="assets/banner.jpg" id="bgvid"  playsinline autoplay muted loop>
  <!-- WCAG general accessibility recommendation is that media such as background video play through only once. Loop turned on for the purposes of illustration; if removed, the end of the video will fade in the same way created by pressing the "Pause" button  -->

<source src="assets/vid.mp4" type="video/mp4">
</video>
</video>
</div>
            <div id="welcome">
			<h1>Welcome back!</h1>
			</div>
			   <header class="header" style="top:200px; background-color:FFFFFF; height:5px; -webkit-box-shadow: 0px 2px 11px 2px rgba(50, 50, 50, 0.58);
-moz-box-shadow:    0px 2px 11px 2px rgba(50, 50, 50, 0.58);
box-shadow:         0px 2px 11px 2px rgba(50, 50, 50, 0.58); ">
                    <div class="header-block header-block-collapse hidden-lg-up"> <button class="collapse-btn" id="sidebar-collapse-btn">
    			<i class="fa fa-bars"></i>
    		</button> </div>
                  
                </header>
                
                <article class="content dashboard-page" >
                   
                    
                     <section class="section" style="position: relative; top:-130px; left:-25px; width:105%;" >
                    <div class="card items">
					
                    <div class="card sameheight-item" >
                                    <div class="card-block" style="position:relative; top:0px">
                                        <div class="card-title-block">
                                            <h3 class="title">Notifications</h3> 
                                        </div>
                                    <!-- Nav tabs -->
                                        <ul class="nav nav-pills" style="width: 100%;">
                                            <li class="nav-item"> <a href="" onclick="document.getElementById('deleteRead').style.visibility = 'hidden';" class="nav-link active" data-target="#home-pills" aria-controls="home-pills" data-toggle="tab" role="tab">All</a> </li>
                                            <li class="nav-item"> <a href="" onclick="document.getElementById('deleteRead').style.visibility = 'hidden';" class="nav-link" data-target="#award-pills" aria-controls="awards-pills" data-toggle="tab" role="tab">Awards</a> </li>
                                            <li class="nav-item"> <a href="" onclick="document.getElementById('deleteRead').style.visibility = 'hidden';" class="nav-link" data-target="#expiration-pills" aria-controls="expiration-pills" data-toggle="tab" role="tab">Accreditation Expirations</a> </li>
                                            <li class="nav-item"> <a href="" onclick="document.getElementById('deleteRead').style.visibility = 'hidden';" class="nav-link" data-target="#unconfirmedSurvey-pills" aria-controls="unconfirmedSurvey-pills" data-toggle="tab" role="tab">Unconfirmed Surveys</a> </li>
                                        	<li class="nav-item"> <a href="" onclick="document.getElementById('deleteRead').style.visibility = 'visible';" class="nav-link" data-target="#readNotifications-pills" aria-controls="readNotifications-pills" data-toggle="tab" role="tab">Show Read Notifications</a> </li>
                                        	<button class="btn btn-danger btn-sm" id="deleteRead" onclick="deleteRead();" style="float:right; visibility:hidden;">Delete Read Notifications</button>
                                        </ul>
                                    <!-- Tab panes -->
					                    <div class="tab-content">                     
										<!-- Start of Home tab Content -->
					                     	<div class="tab-pane fade in active" id="home-pills">				            
					                        </div>
					                        <div class="tab-pane fade" id="award-pills">					                             
					                        </div>
					                        <div class="tab-pane fade" id="expiration-pills">					                                            
					                        </div>
					                        <div class="tab-pane fade" id="unconfirmedSurvey-pills">					                                               
					                        </div>
					                        <div class="tab-pane fade" id="readNotifications-pills">					                                               
					                        </div>
					                   </div>
                                    </div>
                  	</div>
                  	</div>
                       
					
					<!--item 2-->
					
                        
                   
					
					
                    
                
					
					
					
					
					
					
					
					
<!--                     <nav class="text-xs-right"> -->
<!--                         <ul class="pagination"> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				Prev -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item active"> <a class="page-link" href=""> -->
<!-- 				1 -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				2 -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				3 -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				4 -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				5 -->
<!-- 			</a> </li> -->
<!--                             <li class="page-item"> <a class="page-link" href=""> -->
<!-- 				Next -->
<!-- 			</a> </li> -->
<!--                         </ul> -->
<!--                     </nav> -->
                    </section>
                </article>
                
                </div></div>
             
             
             
        <!-- Reference block for JS -->
        <div class="ref" id="ref">
            <div class="color-primary"></div>
            <div class="chart">
                <div class="color-primary"></div>
                <div class="color-secondary"></div>
            </div>
        </div>
        <script src="js/vendor.js"></script>
        <script src="js/app.js"></script>

    </body>

</html>