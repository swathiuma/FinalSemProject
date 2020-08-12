<%@ page import="java.sql.*,java.text.*,java.util.Date,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.css">

</head>
<body>
<div class="fltr">
<%
System.out.println("filter1.jsp START ");
String d=request.getParameter("s_date");
out.println("<input type='hidden' id='s_dt' name='s_dt' value="+d+">");

Date dt=new SimpleDateFormat("yyyy-MM-dd").parse(d);
Calendar calendar = Calendar.getInstance();
calendar.setTime(new Date());
calendar.add(Calendar.DATE, -1);
Date pdate = calendar.getTime();

String table="doctors";
if(dt.before(pdate))
	table="appointments";
out.println("<input type='hidden' id='flag' value="+table+">");

String status="false";

PreparedStatement ps=null;
PreparedStatement ps1=null;
ResultSet rs=null;
ResultSet rs1=null;

String pid=(String)session.getAttribute("p_id");
String query="select a.apt_no,a.date_booked,d.d_dept,a.d_name,a.p_problem,d.avail_from,d.avail_to,a.status from appointments a,doctors d where a.p_id='"+
pid+"' and d.d_name=a.d_name and a.date_booked='"+d+"'";
System.out.println("query="+query);

Connection con=DbConnector.connectToTable();
Connection con1=DbConnector.connectToTable();
ps=con.prepareStatement(query);
rs=ps.executeQuery();

String output="<table id='mytable' padding='5px 5px' align='center'>"+  
"<tr><th width='10%'>Date</th>  "+
"<th width='15%'>Department</th> "+
"<th width='15%'>Doctor Name</th> "+ 
"<th width='40%'>Problem</th> "+
"<th class='dtime'>Doctor Available From</th> "+
"<th class='dtime'>Doctor Available To</th> "+
"<th width='20%'>Status</th>  "+
"<th width='20%'>Cancel Appointment</th>  "+
"</tr>";

	while(rs.next()){
		status="true";
		int apt_no=rs.getInt(1);
		output=output+" <tr>"+
		"<td id='dt'>"+rs.getString(2)+"</td>"+
		"<td>"+rs.getString(3)+"</td>"+
		"<td>"+rs.getString(4)+"</td>"+
		"<td>"+rs.getString(5)+"</td>"+
		"<td>"+rs.getString(6)+"</td>"+
		"<td>"+rs.getString(7)+"</td>"+
		"<td id='st'>"+rs.getString(8)+"</td>"+
		"<td><button style='background-color:#ff3333;color:white; height:25px' type='button' class='btn' id='"+apt_no +"'>Cancel</button></td>"+
		"</tr>" ;
	}

 if(status=="false"){
	output=output+"<tr><td colspan='8' style='color:green;font-weight:bold'><center>No Appointments Found</center></td></tr>";
} 
output+="</table>";
out.println(output);
System.out.println("filter.jsp ENDED..... ");
%>
</div>
</body>
<script>
$(document).ready(function(){
	var s_dt=$("#s_dt").val();
	var date=$.datepicker.formatDate('yy/mm/dd', new Date());
		
  $('#mytable tr').each(function() {
	    var dt = $(this).find("#dt").html();
	    var d1=new Date(dt);
	 	var d = $.datepicker.formatDate('yy/mm/dd',d1);  
	    var stat = $(this).find("#st").html(); 
	    if(stat=="cancelled" | d<date)
	    	{
	    		$(this).find('.btn').hide();
	    	}
	});
  var tb=$("#flag").val();
  if(tb=="appointments")
	  {
  		$('td:nth-child(5),th:nth-child(5)').hide();
  		$('td:nth-child(6),th:nth-child(6)').hide();
	  }
	
	$('.btn').on('click',function(){
		 var id=$(this).attr('id');
		 if(confirm("Are you sure you want to cancel Appointment?")){
			 $.ajax({
				 url: "apt_cancellation.jsp",
				 data:{apt_no:id},
			 	 success: function(data, status, xhr){
			 		$(this).hide();
			 		$(".fltr").load("p_v_filter.jsp?s_date="+s_dt);	
			  }});
		    }
		    else{
		        return false;
		    }
		});
});

</script>
</html>