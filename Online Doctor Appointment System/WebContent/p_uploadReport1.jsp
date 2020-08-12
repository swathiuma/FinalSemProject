<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
#st,#st1{
width:100px;
}
</style>
</head>
<body>

<div id="dv2" align="center" style="font-size: large;">

<%

PreparedStatement pst = null;
try
{
	Connection conn = DbConnector.connectToTable();
	String dpt=request.getParameter("sel_dept");
	String sql = "SELECT * FROM doctors WHERE d_dept='"+dpt+"'";
	pst = conn.prepareStatement(sql);
	ResultSet rst = pst.executeQuery(); 
%>
<form id="imageUploadForm" action="ReportUploadServlet" method="post" enctype="multipart/form-data">
<table>
<tr><td>Doctor :</td><td><select name="doc" required>
<option value="">select doctor</option>
<%
	while(rst.next())
	{
		int id=rst.getInt("d_id");
	 	String doct = rst.getString("d_name");
		out.println(" <option value='"+id+"'>"+doct+"</option>");
	}
%>
</select></td></tr>
<tr><td>Message : </td><td><textarea rows="10" cols="30" name="msg"></textarea></td></tr>
<tr><td>Images : </td><td><input type="file" id="image" name="photos" multiple required>
<span id="msg">Maximum 5 photos can be uploaded</span></td></tr>
<tr><td><input type="submit" id="st1" value="Submit"></td>
<td><input type="reset" id="st" value="Cancel"></td></tr>
<input type="hidden" name="pid" value=<%=session.getAttribute("p_id") %>>
<input type="hidden" name="pname" value=<%=session.getAttribute("p_name") %>>
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

<script>
 $(document).ready(function(){ 
		$('#image').on("change", function() {
	    if ($("#image")[0].files.length > 5) {
	        alert("You can select only 5 images");
	        $('#image').val("");
	    } 
	}); 
});
</script>


</body>
</html>
