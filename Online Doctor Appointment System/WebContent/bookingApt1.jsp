<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>

<div id="dv2" align="center" style="font-size: large;">
<%
PreparedStatement pst = null;
try
{
	Connection conn = DbConnector.connectToTable();
	String dpt=request.getParameter("sel_dept");
	String sql = "SELECT d_name FROM doctors WHERE d_dept='"+dpt+"'";
	pst = conn.prepareStatement(sql);
	ResultSet rst = pst.executeQuery(); 
%>
<table>
<tr><td>Doctor :</td><td><select id="d2" name="dc" onchange="myFunction()">
<option value="0">select doctor</option>
<%
	while(rst.next())
	{
	String doct = rst.getString("d_name");
	out.println(" <option value='"+doct+"'>"+doct+"</option>");
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
<!-- </form> -->
</table>
</div>
<div id="dv3"></div>
<script>
$(document).ready(function(){
$("#d2").change(function () {
    var selectedValue = $(this).val();
   
   $.ajax({
       type : 'post',
       url : 'bookingApt2.jsp',
       data: {sel_doc:selectedValue},
       success : function(data) {
          console.log(data);
          $('#dv3').html(data);
       }
       
   }); 
});
});
</script>
</body>
</html>
