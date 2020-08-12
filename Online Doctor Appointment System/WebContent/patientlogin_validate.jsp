<%@ page import="java.sql.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
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
System.out.println("patientlogin_validate.jsp START");
ResultSet rs=DbConnector.getDataFromTable("patients");

String status="false";
String p_id=request.getParameter("p_id");
String p_pwd=request.getParameter("p_pwd");
try{
	//rs.beforeFirst();
	while(rs.next())
	{
	 String id=rs.getString("p_id");
	 String name=rs.getString("p_name");
	 String phno=rs.getString("p_phno");
	 String p=rs.getString("p_password");	
	 if(p_id.equals(id ) && p_pwd.equals(p))
		{
		 status="true";
		 System.out.println("con est");
		 session.setAttribute("p_id",id);
		 session.setAttribute("p_name",name);
		 session.setAttribute("p_phno",phno);
		 break;
		}
	}
	
	out.println("<div id='flag'><p>"+status+"</p></div>");
	rs.close();
	}
catch(SQLException sqe)
{
out.println(sqe);
} 
System.out.println("patientlogin_validate.jsp ENDED....");
%>
<script>
	var str = $( "#flag" ).text();
	
	if(str=="true")
		{
		$("#flag").hide();
		var url = "patientPortal.jsp";
	    $(location).attr('href',url);
		
		}
	else
		{
		$("#flag").hide();
		 alert("invalid credentials!"); 
		 var url = "patientlogin.html";
		    $(location).attr('href',url);
		
		}
	</script>
</body>
</html>