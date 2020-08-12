<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String pre=request.getParameter("pre");
int id=Integer.parseInt((String)session.getAttribute("doctor_id"));
int rid=Integer.parseInt(request.getParameter("rid"));
Connection con=DbConnector.connectToTable();
String query="UPDATE p_reports SET prescription=? WHERE d_id="+id +" and r_id="+rid;
PreparedStatement pstmt=con.prepareStatement(query);
pstmt.setString(1,pre);
int i=pstmt.executeUpdate();
if(i==1){
out.println("<center><h1 color='red'>Successfully sent the prescription to patient</h1>");
out.println("Go <a href='doctorPortal.jsp'>Back</a></center>");
}
else
{
	out.println("<h1 align='center'>Prescription not sent to patient</h1>");
}
%>
</body>
</html>