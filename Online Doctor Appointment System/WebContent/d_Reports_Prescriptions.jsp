<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
#dv1{
font-size:20px;
}
a{
color:white;
text-decoration:none;
}
.btn{
height:25px;
font-size:17px;
width:50%;
background-color:#7a7a52;
color:white;
cursor:pointer;
}
.btn:hover{
background-color:#8585ad;
}
</style>
</head>
<body>
<div id="dv1" align="center">
<h3>Click on the following links to view patient reports</h3><br>
<%
ResultSet rs=DbConnector.getDataFromTable("p_reports","d_id="+session.getAttribute("doctor_id")+" and prescription IS NULL ORDER By date");
while(rs.next())
{
	out.println("<button class='btn' id='"+rs.getInt("r_id")+"' type='submit'><a href='#'>"+rs.getString("date")+ " (" +rs.getString("p_name")+")</a></button><br><br>");
}
%>
</div>
</body>
<script>
$(document).ready(function(){
$('.btn').on('click',function(){
	 var id=$(this).attr('id');
	 $.ajax({
		 url: "d_viewReports.jsp",
		 data:{r_id:id},
	 	 success: function(data){
	 		 $('#dv1').html(data);
	  }});
});
});
</script>
</html>