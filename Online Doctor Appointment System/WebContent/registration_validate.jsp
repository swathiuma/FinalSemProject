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

int p_id=0;
String nm=request.getParameter("Name");
String gend=request.getParameter("myradio");
String phn=request.getParameter("phone");
String email=request.getParameter("email");
String pswd=request.getParameter("password");
String ag=request.getParameter("date");

try
{
	con=DbConnector.connectToTable();
	ps=con.prepareStatement("select * from patients where p_name='"+nm+"' and p_phno='"+phn+"'");
	ResultSet rs=ps.executeQuery();
	if(rs.next())
	{
		out.println("<h1><center>You are already registered</center></h1>");
	}
	else
	{
	ps=con.prepareStatement("select max(p_id) from patients");
	rs=ps.executeQuery();
	if(rs.next()){
		p_id=rs.getInt(1);
		p_id++;
		
		PreparedStatement st=con.prepareStatement("insert into patients values(?,?,?,?,?,?,?)");
		st.setInt(1,p_id); 
		st.setString(2,nm);
		st.setString(3,gend);
		st.setString(4,phn);
		st.setString(5,email);
		st.setString(6,pswd);
		st.setString(7,ag);

	int i=st.executeUpdate();
	if(i>0){
		out.println("<h2><center>You are Successfully registered <br> Please remember your id <br>Your ID is: "+p_id);
		out.println("<br><a href='patientlogin.html'>Go to Login</a></center></h2>");
			}
	}
	}
}
catch(SQLException sqe)
{
out.println(sqe); 
} 
%>
</body>
</html>
