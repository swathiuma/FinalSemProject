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
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

System.out.println("ba.jsp STARTED");

int apt_no=0;
String id=(String)session.getAttribute("p_id");
int pid=Integer.parseInt(id);
String dn=(String)session.getAttribute("sel_doc");
String dateB=request.getParameter("bdate");
String prblm=request.getParameter("prob");
try
{
	con=DbConnector.connectToTable();
	ps=con.prepareStatement("select * from appointments where p_id="+pid+" and date_booked='"+dateB+"' and d_name='"+dn+"'");
	rs=ps.executeQuery();
	if(rs.next())
	{
		out.println("<h1><center>You are already having appointment with same doctor on that day</center></h1>");
	}
	else{
	ps=con.prepareStatement("select count(apt_no) from appointments where d_name='"+dn+"' and date_booked='"+dateB+"' and status='booked'");
	rs=ps.executeQuery();
	rs.next();
	int count=rs.getInt(1);
	ps=con.prepareStatement("select d_limit from doctors where d_name='"+dn+"'");
	rs=ps.executeQuery();
	rs.next();
	String limit=rs.getString(1);
	int lmt=Integer.parseInt(limit);
	System.out.println("Count="+count+"limit="+lmt);
	if(count<lmt)
	{
		ps=con.prepareStatement("select max(apt_no) from appointments");
		rs=ps.executeQuery();
		if(rs.next())
		{
			apt_no=rs.getInt(1);
			apt_no++;
						
			PreparedStatement pstt=con.prepareStatement("insert into appointments values(?,?,?,?,?,?)");
			pstt.setInt(1,apt_no); 
			pstt.setString(2,dateB);
			pstt.setInt(3,pid);
			pstt.setString(4,dn);
			pstt.setString(5,prblm);
			pstt.setString(6,"booked");
			System.out.println("chk");
			int i=pstt.executeUpdate();
			
			if(i>0){
			out.println("<center><h2>Your appointment is booked</h2>");
			out.println("Go <a href='patientPortal.jsp'>Back</a></center>");
			} 
		}
	}
	else{
		out.println("<center><h2>All Appointment on this day are booked<br>Please choose other day <br>"+
				"Go <a href='patientPortal.jsp'>Back</a></h2></center>");
		}
	}
	con.close();
}
catch(SQLException sqe)
{
out.println(sqe);
} 
%>
</body>
</html>
