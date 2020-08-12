<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient History</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
.heading{
top:0px;
height:105px;
width:100%;
background:#ff8000;
color: white;
font-size:190%;
position:absolute; 
padding:0;
}
.bdy1{
position:absolute;
top:110px ;
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
#bt,#bt1{
height:30px;
font-size:20px;
width:150px;
float: right;
background-color:#00b33c;
color:white;
cursor:pointer;
} 
a{
color:white;
text-decoration:none;
}
th,td{
height:30px;
width:30%;
font-size:20px;
padding:10px;
}
table,th,td{
border:1px solid black;
 border-collapse: collapse;
 }
 th{
  color:#cc3300;
 }
</style>
</head>
<body>
<%
System.out.println("d_patientHistory.jsp START");
String p_id=request.getParameter("p_id");
String d_name=(String)session.getAttribute("doctor_name");
String d_dept=(String)session.getAttribute("doctor_dept");

String query="select * from "+d_dept+" where p_id="+p_id+" ORDER by date DESC";
Connection con=DbConnector.connectToTable();
PreparedStatement ps=con.prepareStatement(query);
ResultSet rs=ps.executeQuery();
String st="false";
if(rs.next())
{
	st="true";
	String p_n=rs.getString("p_name");
	session.removeAttribute("patient_id");
	session.removeAttribute("patient_name");
	session.setAttribute("patient_name",p_n);
	session.setAttribute("patient_id",p_id);
	
%>

<div class="heading">
<p style="float:left"><b>&nbsp;PatientName : <%=p_n%></b><br/>
&nbsp;<b>Patient Id : <%=p_id%>&nbsp;&nbsp;</b></p><br/>
<p><button id="bt1" type="submit">Close&nbsp;&nbsp;</button></p>
</div>
<div class="bdy1"><button id="bt" type="submit" onclick="location.href='#'">AddDetails</button><br><br>

<input type="hidden" id="dname" name="datebook" value="<%=d_dept%>">
<table align="center" width="200px">

<% 
ResultSetMetaData rsmd = rs.getMetaData();
int count=rs.getMetaData().getColumnCount();
out.println("<tr><th>"+rsmd.getColumnName(2)+"</th>");
for(int i=6;i<=count;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
out.println("</tr>");
do{
	out.println("<tr><td>&nbsp;"+rs.getDate(2)+"&nbsp;</td>");
	for(int j=6;j<=count;j++)
	{
		String s=rs.getString(j);
		if(s==null)
			s="";
		out.println("<td>"+s+"</td>");
	}
	out.println("</tr>");
}while(rs.next());
%>
</table>
</div>
<%
}
else{
	out.println("<h1 align='center'>Patient History not Found.<br>Please Register</h1>");
} 
System.out.println("d_patientHistory.jsp ENDED......");
%>
</body>
<script>
$(document).ready(function(){
	
	$('#bt1').on('click',function(){
		window.location.href="doctorPortal.jsp";
	});
	 $('#bt').on('click',function(){
		var d_dept=$("#dname").val();
		if(d_dept=="cardiology")
		{
			$('#bt').hide();
			$('.bdy1').load('CARDIOLOGY.html');
		}
		else if(d_dept=="ent")
			{
			$('#bt').hide();
			$('.bdy1').load('ENT.html');
			}
		else if(d_dept=="dermatology")
			{
			$('#bt').hide();
			$('.bdy1').load('DERMATOLOGY.html');
			}
		else if(d_dept=="orthopedic")
			{
			$('#bt').hide();
			$('.bdy1').load('ORTHOPEDIC.html');
			}
		else if(d_dept=="psychiatry")
			{
			$('#bt').hide();
			$('.bdy1').load('PSYCHIATRY.html');
			}		
		
	}); 
	 
	
});
</script>
</html>