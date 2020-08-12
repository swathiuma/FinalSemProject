<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Doctor Profile</title>
</head>
<body>
<%
System.out.println("p_profileupload.jsp START");
String id=(String)session.getAttribute("p_id");
String pno=request.getParameter("patient_phno");
String email=request.getParameter("patient_email");
String pwd=request.getParameter("patient_pwd");
String dob=request.getParameter("patient_dob");


String update_sql="UPDATE PATIENTS SET p_phno=?,p_email=?,p_password=? WHERE p_id="+id;
Connection con=DbConnector.connectToTable();
PreparedStatement pstmt=con.prepareStatement(update_sql);
pstmt.setString(1,pno);
pstmt.setString(2,email);
pstmt.setString(3,pwd);
 
int i=pstmt.executeUpdate();

con.close();
System.out.println("p_profileupload.jsp ENDED.......");
%>
<script>
var str=<%=i%>;
if(str==1)
	{
	 alert("Your details are updated!");
	window.location.href="patientlogin.html";
    
	}
else
	{
	alert("Your details are not updated!");
	var url = "p_edit.jsp";
    $(location).attr('href',url);
	}
	</script>
</body>
</html>