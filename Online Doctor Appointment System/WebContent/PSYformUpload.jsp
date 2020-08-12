<%@ page import="java.sql.*,java.util.Date,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

long millis=System.currentTimeMillis();  
java.sql.Date date=new java.sql.Date(millis); 
Connection con1=DbConnector.connectToTable();
Connection con2=DbConnector.connectToTable();
PreparedStatement ps1=null;
PreparedStatement ps2=null;
ResultSet rs1=null;
ResultSet rs2=null;

String s_id=(String)session.getAttribute("patient_id");
int p_id=Integer.parseInt(s_id); 
String p_name=(String)session.getAttribute("patient_name");
String d_name=(String)session.getAttribute("doctor_name");
String query1="select max(psy_aptno) from psychiatry";
String query2="insert into psychiatry values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

ps1=con1.prepareStatement("select max(psy_aptno) from psychiatry");
rs1=ps1.executeQuery();
int apt_no=1;
if(rs1.next())
{
	apt_no=rs1.getInt(1);
	apt_no++;
}

ps2=con2.prepareStatement(query2);
ps2.setInt(1,apt_no);
ps2.setDate(2,date);
ps2.setInt(3,p_id); 
ps2.setString(4,p_name);
ps2.setString(5,d_name);
for(int i=1,j=6;i<=9;i++,j++)
{
ps2.setString(j,request.getParameter("psy"+i));
}
int k=ps2.executeUpdate();
if(k>0)
	System.out.println(" successfully uploaded psy details..");
else
	out.println(" not successfully uploaded psychiatric details..");


%>
</body>
<script>
var k=<%=k%>;
if(k==1)
	{
    alert("details uploaded");
	window.location.href="d_patientHistory.jsp?p_id="+<%=p_id%>;
	}
</script>
</html>