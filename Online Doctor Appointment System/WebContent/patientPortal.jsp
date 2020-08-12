<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Portal</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
.heading{
top:0px;
height:120px;
width:100%;
background:#ff8000;
color: white;
position:absolute;
background-image:url('images/h5.jpg');
background-position:center;
background-repeat:repeat;
background-size:cover; 
}
.navigation{
top:110px;
background-color:#cc9900;
height:40px;
width:100%;
position:absolute;
}
#logout{
  float:right;
  border-right: none; 
}

.navigation button{
font-size:15px;
height:40px;
background-color:#cc9900;
border: none;
color: white;
text-decoration:none;
border-right:1px solid #bbb;
cursor:pointer;
}
.navigation button:hover{
background-color: green;
}
#bodycontent{
top:155px;
width:100%;
/* height:600px; */
height: auto;
min-height: 100% !important;
padding:0;
margin:0;
position:absolute;
background-image:url('images/bg5.jpg');
background-position:center;
background-repeat:no-repeat;
background-size:cover; 
}
</style>

<script>
$(document).ready( function() {
	$('#bodycontent').load('p_profile.jsp');
	$('#profile').on('click', function() {
		 $(this).css('background-color', '#cccc00');
		 $('#v_app,#b_app,#p_reports,#logout,#doc_info').css('background-color', '#cc9900');
		  $('#bodycontent').load('p_profile.jsp');
    });
	$('#doc_info').on('click', function() {
		 $(this).css('background-color', '#cccc00');
		 $('#v_app,#b_app,#p_reports,#logout,#profile').css('background-color', '#cc9900');
		  $('#bodycontent').load('p_doctorsInfo.jsp');
   });
	$('#v_app').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#b_app,#p_reports,#logout,#doc_info').css('background-color', '#cc9900');
		  $('#bodycontent').load('p_viewAppointments.jsp');
    });
	$('#b_app').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#v_app,#p_reports,#logout,#doc_info').css('background-color', '#cc9900');
		  $('#bodycontent').load('bookingApt.jsp');
    });
	$('#p_reports').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#b_app,#v_app,#logout,#doc_info').css('background-color', '#cc9900');
		  $('#bodycontent').load('p_Reports_Prescription.jsp');
    });
	$('#logout').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#b_app,#p_reports,#v_app,#doc_info').css('background-color', '#cc9900');
		  $('.bdy').load('logout.jsp');
    });
});
</script>

</head>
<body class="bdy">
<%
System.out.println("patientPortal.jsp START");
String name=(String)session.getAttribute("p_name");
String id=(String)session.getAttribute("p_id");
if(name==null && id==null)
{
	request.getRequestDispatcher("Message2.jsp").forward(request,response);
}
%>

<div class="heading">
<h1 style="float:left"><b>&nbsp;User Name: <%=name%></b></h1>
<h1 style="float:right"><b>User id : <%=id%>&nbsp;</b></h1>
</div>
<div class="navigation">
<button id="profile" type="button">Profile</button>
<button id="doc_info" type="button">Doctors Info</button>
<button id="v_app" type="button">View appointments</button>
<button id="b_app" type="button">Book appointments</button>
<button id="p_reports" type="button">Reports & Prescriptions</button>
<button id="logout" type="button">Logout&nbsp;&nbsp;</button>

</div>
<div id="bodycontent">
</div>
</body>
</html>

