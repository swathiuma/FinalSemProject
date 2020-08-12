<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Doctor Portal</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
.heading{
top:0px;
height:120px;
width:100%;
background:#ff8000;
color: white;
font-size:180%;
position:absolute;
background-image:url('images/h2.png');
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
	$('#bodycontent').load('d_profile.jsp');
	$('#profile').on('click', function() {
		 $(this).css('background-color', '#cccc00');
		 $('#v_app,#p_details,#p_reports,#logout').css('background-color', '#cc9900');
		  $('#bodycontent').load('d_profile.jsp');
    });
	$('#v_app').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#p_details,#p_reports,#logout').css('background-color', '#cc9900');
		  $('#bodycontent').load('d_viewAppointments.jsp');
    });
	$('#p_details').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#v_app,#p_reports,#logout').css('background-color', '#cc9900');
		  $('#bodycontent').load('d_patientDetailsLogin.html');
    });
	$('#p_reports').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#p_details,#v_app,#logout').css('background-color', '#cc9900');
		  $('#bodycontent').load('d_Reports_Prescriptions.jsp');/* d_Reports_Prescriptions */
    });
	$('#logout').on('click', function() {
		$(this).css('background-color', '#cccc00');
		$('#profile,#p_details,#p_reports,#v_app').css('background-color', '#cc9900');
		  $('.bdy').load('logout.jsp');
    });
});
</script>

</head>
<body class="bdy">
<%
System.out.println("doctorPortal.jsp START");
String name=(String)session.getAttribute("doctor_name");
String id=(String)session.getAttribute("doctor_id");
String dept=(String)session.getAttribute("doctor_dept");
if(name==null && id ==null && dept==null)
{
	request.getRequestDispatcher("Message2.jsp").forward(request,response);
}
%>

<div class="heading">
<p style="float:left"><b>&nbsp;Doctor Name: <%=name%></b></p>
<p style="float:right"><b>Department : <%=dept%>&nbsp;<br>Doctor id : <%=id%>&nbsp;</b></p>
</div>
<div class="navigation">
<button id="profile" type="button">Profile</button>
<button id="v_app" type="button">View appointments</button>
<button id="p_details" type="button">Patient details</button>
<button id="p_reports" type="button">Patient reports</button>
<button id="logout" type="button">Logout&nbsp;&nbsp;</button>

</div>
<div id="bodycontent">
</div>
</body>
</html>

