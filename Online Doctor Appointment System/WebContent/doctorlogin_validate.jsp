<%@ page import="java.sql.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Doctor Page</title>
<script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
<%
System.out.println("patientlogin_validate.jsp START");
ResultSet rs=DbConnector.getDataFromTable("doctors");
String status="false";
String d_id=request.getParameter("doc_id");
String d_pwd=request.getParameter("doc_pwd");
try{
	//rs.beforeFirst();
	while(rs.next())
	{
	 String id=rs.getString("d_id");
	 String name=rs.getString("d_name");
	 String dept=rs.getString("d_dept");
	 String p=rs.getString("d_password");		 
	 if(d_id.equals(id ) && d_pwd.equals(p))
		{
		 String d=dept.toLowerCase();
		 status="true";
		 System.out.println("Database connection established");
		 session.setAttribute("doctor_id",id);
		 session.setAttribute("doctor_name",name);
		 session.setAttribute("doctor_dept",d);
		break;
		}
	}
	/* rs.first(); */
	out.println("<div id='flag'><p>"+status+"</p></div>");
	rs.close();
   }
	catch(SQLException sqe)
	{
	out.print(sqe);
	} 
System.out.println("doctorlogin_validate.jsp ENDED....");
	%>
	
	
	<script>
	var str = $( "#flag" ).text();	
	if(str=="true")
		{
		$("#flag").hide();
		var url = "doctorPortal.jsp";
	    $(location).attr('href',url);
		}
	else
		{
		$("#flag").hide();
		 alert("invalid credentials!"); 
		 var url = "doctorlogin.html";
		 $(location).attr('href',url);
		
		}
	</script>
	
</body>
</html>