<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging Out</title>
<script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
<%
System.out.println("logout.jsp START");
session.invalidate();
//request.getRequestDispatcher("HomePage.html").forward(request,response);
 //response.sendRedirect("HomePage.html"); 
%>
<center>
<h1>You're successfully logged out </h1>
<h3>Go To <a href="HomePage.html">Home Page</a></h3>
</center>
</body>

</html>