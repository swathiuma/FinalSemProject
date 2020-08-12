<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DropDown list</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
body{
top:0px; 
width:100%;
height: auto;
min-height: 100% !important;
position:absolute;
background-color:pink;
background-image:url('images/bgg6.jpg');
background-position:center;
background-repeat:repeat;
background-size:cover; 
}
td{
font-size:20px;
padding:10px;
width:220px;
}
select,input{
height:35px;
width:100%;
font-size:15px;
}
</style>
</head>
<body>
<center><b><font size="5" color="#cc3300">Please fill the following details to upload your reports</font></b></center>
<div id="dv1" align="center" style="font-size: large;">
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
<tr><td>Department :</td><td><select id="d1" name="dept" required >
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
       url : 'p_uploadReport1.jsp',
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
