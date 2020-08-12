<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
#bt{
height:28px;
font-size:18px;
width:170px;
float: right;
background-color:#00b33c;
color:white;
cursor:pointer;
} 
.bt1{
height:25px;
font-size:17px;
width:50%;
background-color:#7a7a52;
color:white;
cursor:pointer;
}
a{
color:white;
text-decoration:none;
}
.bt1:hover{
background-color:#8585ad;
}
</style>
</head>
<body id="bdy">
<div id="dv1"align="center">
<button id="bt" type="submit" onclick="location.href='p_uploadReport.jsp'">Upload Reports</button><br>
<h3>Click on the following links to view your reports and prescriptions</h3><br>
<%
ResultSet rs=DbConnector.getDataFromTable("p_reports","p_id="+session.getAttribute("p_id")+" ORDER By date DESC");
while(rs.next())
{
	out.println("<button class='bt1' id='"+rs.getInt("r_id")+"' type='submit'><a href='#'>"+rs.getString("date")+ " (Dr." +rs.getString("d_name")+")</a></button><br><br>");
}
%>
</div>
</body>
<script>
$(document).ready(function(){
$('.bt1').on('click',function(){
	 var id=$(this).attr('id');
	 $.ajax({
		 url: "p_viewReports.jsp",
		 data:{r_id:id},
	 	 success: function(data){
	 		 $('#dv1').html(data);
	  }});
});
});
</script>
</html>