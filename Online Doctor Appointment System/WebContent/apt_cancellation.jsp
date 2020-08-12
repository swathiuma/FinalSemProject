<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
<%
System.out.println("apt_cancellation.jsp START ");
String s=request.getParameter("apt_no");
int apt_no=Integer.parseInt(s);

Connection con=DbConnector.connectToTable();
PreparedStatement ps=null;
PreparedStatement ps1=null;
ResultSet rs=null;
int result=-1;

String query="select * from appointments where apt_no="+apt_no;
ps=con.prepareStatement(query);
rs=ps.executeQuery();
rs.next();
String status=rs.getString("status");

 if(status.equals("booked"))
{
	//status="rejected";
String query1="UPDATE APPOINTMENTS  SET status='cancelled' WHERE apt_no="+apt_no;
ps1=con.prepareStatement(query1);
result=ps1.executeUpdate(); 
}  
 else
 {	 
	 out.println("<h1>Appointment is already cancelled!</h1>");
 }
 System.out.println("apt_cancellation.jsp ENDED..... ");
%>
</body>
</html>