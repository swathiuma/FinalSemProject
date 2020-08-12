<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/jquerysession.js"></script> 

</head>
<body>
<div id="bdy2">
<%
System.out.println("d_patientRegister.jsp START");
String d_dept=(String)session.getAttribute("doctor_dept");
session.removeAttribute("patient_id");
session.removeAttribute("patient_name");
String pid=request.getParameter("p_id");
String flag="exist";
String cond="p_id="+pid;
String pname="";

ResultSet rs=DbConnector.getDataFromTable(d_dept,cond);
if(rs.next())
{
	flag="exist"; 
}
else
{
	flag="noexist";	
	ResultSet rs1=DbConnector.getDataFromTable("patients", "p_id="+pid);
	if(rs1.next())
	{
	session.setAttribute("patient_id",pid);
	pname=rs1.getString(2);
	session.setAttribute("patient_name",pname);
	}
	else{
		flag="noreg";
		out.println("<h1>This Patient Id doesn't exist</h1>");
		
	}
}
System.out.println("d_patientRegister.jsp ENDED......");
%>
<input type="hidden" id="ipt"  value="<%=flag%>">
<input type="hidden" id="dname"  value="<%=d_dept%>">
<input type="hidden" id="pname"  value="<%=pname%>">
</div>

</body>
<script>
$(document).ready(function(){
	var fg=$("#ipt").val();
	/* alert(fg); */
	if(fg=="exist")
	{
		alert("Patient no is already registered");
		var url = "doctorPortal.jsp";
	    $(location).attr('href',url);
	}
	if(fg=="noexist")
	{
		var pn=$("#pname").val();
		if(confirm("Verify whether Patient Name is :"+pn))
		{		
			var d_dept=$("#dname").val(); 
			if(d_dept=="cardiology")
			{	
				$('#bdy2').load('CARDIOLOGY.html'); 	
			}
			if(d_dept=="ent")
			{
				$('#bdy2').load('ENT.html');
			}
			if(d_dept=="dermatology")
			{
				$('#bdy2').load('DERMATOLOGY.html');
			}
			if(d_dept=="orthopedic")
			{
				$('#bdy2').load('ORTHOPEDIC.html');
			}
			if(d_dept=="psychiatry")
			{
				$('#bdy2').load('PSYCHIATRY.html');
			} 
	   }
	   else
	   {
			var url = "doctorPortal.jsp";
		    $(location).attr('href',url);
	   }
	}	
});
</script>
</html>