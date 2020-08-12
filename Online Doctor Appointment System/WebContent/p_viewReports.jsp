<%@ page import="java.sql.*,java.util.*,java.io.*,com.webapp.DbConnector" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
img{
align:center;
width:450px;
height:400px;
}
img:hover{
width:600px;
height:600px;
}
.btn1,.btn2{
width:50px;
height:30px;
}
</style>
</head>
<body>
<h3>Your Reports & Prescriptions </h3>
<%
String base64Image[]=new String[5];
String msg="",pre="";
int id=Integer.parseInt(request.getParameter("r_id"));
ResultSet rs=DbConnector.getDataFromTable("p_reports","r_id="+id);
rs.next();
%>
<table>
<tr><td>Date : </td><td><%=rs.getString("date") %></td></tr>
<tr><td>Doctor : </td><td><%=rs.getString("d_name") %></td></tr>
<%
if(rs.getString("prescription")==null)
{
	pre=" Yet doctor has not given any prescription";
}
else{
	pre=rs.getString("prescription");
}
int i=9;
while(i<14)
{
 Blob image=rs.getBlob(i);
 if(image!=null)
 {
InputStream inputStream=image.getBinaryStream();
ByteArrayOutputStream outputStream=new ByteArrayOutputStream();
byte[] buffer=new byte[4096];
int bytesRead=-1;
while((bytesRead=inputStream.read(buffer))!=-1)
{
	outputStream.write(buffer,0,bytesRead);
}
byte[] imageBytes=outputStream.toByteArray();
base64Image[i-9]=Base64.getEncoder().encodeToString(imageBytes);
//out.println("<img src='data:image/jpeg;base64,"+base64Image[i-4]+"' alt='Base64 encoded image' width='150' height='150'/>");
 }
 i++;
}
%>
<tr><td>Your message : </td><td><%=rs.getString("message")%></td></tr>
<tr><td>Prescription : </td><td><%=pre%></td></tr>
<tr><td></td><td></td></tr>
</table><br><br>
<b>Your Uploaded reports :</b>
<%
int j=0;
while(j<5 && base64Image[j]!=null)
{
%>
	<img class='opaque' src="data:image/jpeg;base64,<%=base64Image[j]%>" alt="Base64 encoded image" />
<%
	j++;
}
%>
<button class="btn1" onclick="plusDivs(-1)">&#10094;</button>&emsp;&emsp;&emsp;&emsp;
<button class="btn2" onclick="plusDivs(1)">&#10095;</button>
</body>
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("opaque");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>
</html>