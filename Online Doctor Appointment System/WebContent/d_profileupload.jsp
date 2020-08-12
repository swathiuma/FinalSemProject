<%@ page import="java.sql.*,java.text.*,java.util.Date,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Doctor Profile</title>
</head>
<body>
<%
System.out.println("d_profileupload.jsp START");
String id=(String)session.getAttribute("doctor_id");
String pno=request.getParameter("doc_phno");
String email=request.getParameter("doc_email");
String pwd=request.getParameter("doc_pwd");
String limit=request.getParameter("doc_limit");
//doctor from time
String tf=request.getParameter("doc_tf");
SimpleDateFormat _24Htf = new SimpleDateFormat("HH:mm");
SimpleDateFormat _12Htf = new SimpleDateFormat("hh:mma");
Date _24Htd = _24Htf. parse(tf); 
System.out.println("time="+_12Htf.format(_24Htd));
//doctor to time
String tt=request.getParameter("doc_tt");
SimpleDateFormat _24Hf = new SimpleDateFormat("HH:mm");
SimpleDateFormat _12Hf = new SimpleDateFormat("hh:mma");
Date _24Hd = _24Hf. parse(tt); 
System.out.println("time="+_12Hf.format(_24Hd));

String update_sql="UPDATE DOCTORS SET d_phno=?,d_email=?,d_password=?,avail_from=?,avail_to=?,d_limit=? WHERE d_id="+id;
Connection con=DbConnector.connectToTable();
PreparedStatement pstmt=con.prepareStatement(update_sql);
pstmt.setString(1,pno);
pstmt.setString(2,email);
pstmt.setString(3,pwd);
pstmt.setString(4,_12Htf.format(_24Htd));
pstmt.setString(5,_12Hf.format(_24Hd));
pstmt.setString(6,limit); 
int i=pstmt.executeUpdate();

con.close();
System.out.println("d_profileupload.jsp ENDED.......");
%>
<script>
var str=<%=i%>;
if(str==1)
	{
	 alert("Your details are updated!");
	window.location.href="doctorlogin.html";    
	}
else
	{
	alert("Your details are not updated!");
	var url = "d_profileEdit.jsp";
    $(location).attr('href',url);
	}
	</script>
</body>
</html>