<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
input{
width:80%;
}
</style>
</head>
<body><div align="center" style="font-size: large;">
<%
Statement statement = null;
ResultSet resultSet = null;
%>
<form action="ba.jsp" method="POST" name="form" autocomplete="off">
<%

try{ 
	Connection connection = DbConnector.connectToTable();
	statement=connection.createStatement();
	String doc=request.getParameter("sel_doc");
	session.removeAttribute("sel_doc");
	session.setAttribute("sel_doc",doc);
	String sql ="SELECT * FROM doctors where d_name='"+doc+"'";

	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
		
%>
<table>
<tr>
<td colspan="2">Dr.<%=doc%> is available from <%=resultSet.getString("avail_from")%> to <%=resultSet.getString("avail_to")%> </td></tr>
<tr><td>Date:</td>
<td><input type="date" id="bdate" name="bdate" onchange="myFun()" required><br>
<span id="message" style="color:red" ></span></td></tr>
<tr><td>Problem:</td><td> <input type="text" name="prob"></td></tr>
<tr><td><input id="sbt" type="submit" value="Book"></td>
<tr><td colspan=2>Note: Appointments has to be booked atleast 1 day advance</td></tr>

<% 
}} 
catch (Exception e) {
e.printStackTrace();
}
%>
</table></form></div>
<script>

function myFun(){
var today=new Date();
var maxdate=new Date();
var dd=today.getDate();
var mm=today.getMonth()+2;
var yyyy=today.getFullYear();
if(dd<10){
	dd='0'+dd
	}
	if(mm<10)
		{
		mm='0'+mm
		}
	mdate=yyyy+'-'+mm+'-'+dd;
var maxdate=new Date(mdate);
	document.getElementById("bdate").setAttribute("max",maxdate); 
var date = new Date($('#bdate').val());
var day=date.getDay();

 if(date<today)//validate date is past
	{
	document.getElementById("message").innerHTML="**Please select valid date";
	document.getElementById("bdate").value="";	
	}
 
 else if(date>maxdate)//validate date is more future
	{
	document.getElementById("message").innerHTML="**Appointments can only be booked<br> for advance one month ";
	document.getElementById("bdate").value="";
	}
	
 else if(day==0)
	{
	document.getElementById("message").innerHTML="**Sunday is a holiday ";
	document.getElementById("bdate").value="";
	}
 else
    { 
	 document.getElementById("message").innerHTML="";
	 }
}
</script>
</body>
</html>
