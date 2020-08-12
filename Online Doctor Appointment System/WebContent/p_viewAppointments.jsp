<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>  
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.css">  
<style>
div td
{
height:30px;
font-size:17px;
text-align:center;
}
#order_table th{
height:25px;
color:#cc3300; 
font-size:20px;
text-align:center;
}
div table,th,td{
border:1px solid black;
 border-collapse: collapse;
 }
 label,input{
 font-size:15px;
 }
</style>
           
</head>
<body>
<%
System.out.println("p_viewAppointments.jsp START");
PreparedStatement ps=null;
PreparedStatement ps1=null;
ResultSet rs=null;
ResultSet rs1=null;

String pid=(String)session.getAttribute("p_id");
String query="select a.date_booked,d.d_dept,a.d_name,a.p_problem,a.status from appointments a,doctors d where a.p_id='"+
pid+"' and d.d_name=a.d_name ORDER BY date_booked DESC";
Connection con=DbConnector.connectToTable();
ps=con.prepareStatement(query);
rs=ps.executeQuery();
Connection con1=DbConnector.connectToTable();

%>
<div align="center" id="dt_select">
<label><b>Select Date : </b></label>
<input type="date" id="apt_date" name="datebook">
<input type="submit" id="send" value="Submit">
</div>
<br>
<div id="order_table">  
       <table align="center" class="table table-bordered">  
        <tr>  
             <th width="10%">Date</th>  
             <th width="10%">Department</th>
             <th width="15%">DoctorName</th>  
             <th width="37%">Problem</th> 
             <th >Status</th>  
             <th width="2%" style="display:none;"></th>
        </tr>  
<%
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>
<td style="display:none;"></td>
</tr>
<%
}
System.out.println("p_viewAppointments.jsp ENDED.......");
%>
</table>
</div>
</body>
<script>
$(document).ready(function(){
	/* $.datepicker.setDefaults({  
        dateFormat: 'yy-mm-dd'   
    }); 
	$(function(){  
        $("#apt_date").datepicker();         
    });  */
	
	$('#send').click(function(){
		var bookdate=$("#apt_date").val();
		var db=bookdate;
		if(bookdate!='')
			{
		       $.ajax({
		 		 url:"p_v_filter.jsp",
				 method:"post",
				 data:{s_date:db},
				 success:function(data)
				 {
				 $('#order_table').html(data);
				 }
				 });
			}
		else{
			alert("Please select Date");
		}
	});
	
});
</script>
</html>