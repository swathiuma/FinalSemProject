<%@ page import="java.io.*,java.sql.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.hd{
padding-left:20px;
}
.shd{
padding-left:50px;
/* background:rgba(255, 77, 166,0.5); */
}
p{
padding-left:80px;
/* background:rgba(255, 214, 51,0.5); */
}
</style>
</head>
<body>
<h3><u>Doctors Information of various Departments</u></h3>
<%
try{
Connection con=DbConnector.connectToTable();
PreparedStatement stmt=null;
ResultSet rs=null;
String ar[]={"cardiology","dermatology","ent","orthopedic","psychiatry"};
for(int i=0;i<ar.length;i++)
{
	%>
	<details>
	<summary class="hd"><%=ar[i].toUpperCase() %></summary>
	<%
	String qry="select * from doctors where d_dept='"+ar[i]+"'";
	stmt=con.prepareStatement(qry);
	rs=stmt.executeQuery();
	while(rs.next())
	{		
		%>
		<details>
		<summary class="shd">Dr. <%=rs.getString(2)%></summary>
		<p>Name : <%=rs.getString(2)%></p>
		<p>Mobile no : <%=rs.getString(4)%></p>
		<p>Email id : <%=rs.getString(5)%></p>
		<p>Appointments limit : <%=rs.getString(7)%></p>
		<p>Timings From : <%=rs.getString(8)%></p>
		<p>Timings To : <%=rs.getString(9)%></p>
		</details><br>
		<%
	}
	out.println("</details><br>");
}
}
catch(Exception e)
{
	out.println(e);
}
%>

</body>
</html>