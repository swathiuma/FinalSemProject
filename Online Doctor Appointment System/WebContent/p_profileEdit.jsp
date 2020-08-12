<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Doctor Profile</title>
<link rel="stylesheet" href="Style2.css">
<style>
body{
/* top:0px; */
width:100%;
height: auto;
min-height: 100% !important;
position:absolute;
background-image:url('images/bgg5.jpg');
background-position:center;
background-repeat:repeat;
background-size:cover; 
/* background:rgba(194, 194, 163,0.3); */
}
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
padding: 10px 10px;
}

</style>
</head>
<body>
<%
System.out.println("p_edit.jsp START");
ResultSet rs=null;
String id=(String)session.getAttribute("p_id"); 
int i=Integer.parseInt(id);
String cond="p_id="+i;
rs=DbConnector.getDataFromTable("patients", cond);
 rs.next(); 
 
%>
<form name="profileedit" action="p_profileupload.jsp" method="post">
<table align="center">
<caption><b>Patient Profile</b></caption>
<tr><td>ID:</td><td><%=rs.getString(1)%></td></tr>
<tr><td>Name:</td><td><%=rs.getString(2) %></td></tr>
<tr><td>Gender:</td><td><%=rs.getString(3) %></td></tr>
<tr><td>Phone Number:</td><td><input  name="patient_phno" type="text" maxlength=10 value=<%=rs.getString(4)%>></td></tr>
<tr><td>Email id:</td><td><input name="patient_email" type="text" value=<%=rs.getString(5)%>></td></tr>
<tr><td>Password:</td><td><input name="patient_pwd" type="text" value=<%=rs.getString(6)%>></td></tr>
<tr><td>DOB:</td><td><%=rs.getString(7)%></td></tr>
<tr><td><input type="submit" value="submit"></td>
<td><input type="reset" value="Reset"></td></tr>
</table>
</form>
<%
System.out.println("p_editdit.jsp ENDED...");
%>
</body>
</html>