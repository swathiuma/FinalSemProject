<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DropDown list</title>
<script src="js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="Style2.css">
<style>
td{
padding:10px;
}
select,input{
width:100%;
}
</style>
</head>
<body>
<div align="center">
<form action="#">
<%
PreparedStatement ps = null;
String dept="";
try
{
	Connection con = DbConnector.connectToTable();
	String sql = "SELECT DISTINCT d_dept FROM doctors";
	ps = con.prepareStatement(sql);
	ResultSet rs = ps.executeQuery(); 
%>
<table>
<caption><b>Book Appointment</b></caption>
<tr><td>Department :</td><td><select id="d1" name="dept"   >
<option value="0">select department</option>
<%
	while(rs.next())
	{
	dept = rs.getString("d_dept"); 
%>
<option value="<%=dept %>"><%=dept %></option>
<%
	}
%>
</select></td></tr>
<%
}
catch(SQLException sqe)
{ 
out.println(sqe);
}
%>

</table>
</form>
</div>
<div id="dv2"></div>
<script>
$(document).ready(function(){
$("#d1").change(function () {
    var selectedValue = $(this).val();
   var sltval=$(this).find("option:selected").attr("value");
   $.ajax({
       type : 'post',
       url : 'bookingApt1.jsp',
       data: { sel_dept: sltval},
       success : function(data) {
          console.log(data);
          $('#dv2').html(data);
        
       }
     
   }); 
});
});
</script>
</body>
</html>
