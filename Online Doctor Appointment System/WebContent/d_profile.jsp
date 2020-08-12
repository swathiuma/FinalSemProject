<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Doctor Profile</title>
<link rel="stylesheet" href="Style2.css">
<style>
table
{
height:250px; 
width:450px; 
}
table,td{
border:1px solid black;
 border-collapse: collapse;
}
td
{
/* text-align: center;  */
padding:5px;
}
#editbtn{
height:30px;
font-size:20px;
width:70px;
float: right;
background-color:#00b33c;
color:white;
cursor:pointer;
} 
</style>
</head>
<body>
<%
System.out.println("d_profile.jsp START");
ResultSet rs=null;
String id=(String)session.getAttribute("doctor_id"); 
int i=Integer.parseInt(id);
String cond="d_id="+i;
rs=DbConnector.getDataFromTable("doctors", cond);
 rs.next(); 
%>
<button id="editbtn" type="submit" onclick="location.href='d_profileEdit.jsp'">Edit</button>
<br>
<table align="center">
<caption><b>Doctor Profile</b></caption>
<tr><td>ID:</td><td><%=rs.getString(1) %></td></tr>
<tr><td>Name:</td><td><%=rs.getString(2) %></td></tr>
<tr><td>Department:</td><td><%=rs.getString(3) %></td></tr>
<tr><td>Mobile No:</td><td><%=rs.getString(4) %></td></tr>
<tr><td>Email id:</td><td><%=rs.getString(5) %></td></tr>
<tr><td>Appointments Limit:</td><td><%=rs.getString(7) %></td></tr>
<tr><td>Timings From:</td><td><%=rs.getString(8) %></td></tr>
<tr><td>Timings To:</td><td><%=rs.getString(9) %></td></tr>
</table>
<%
System.out.println("d_profile.jsp ENDED...");
%>
</body>
</html>