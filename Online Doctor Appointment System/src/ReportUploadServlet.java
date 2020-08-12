

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.webapp.DbConnector;


@WebServlet("/ReportUploadServlet")
@MultipartConfig(maxFileSize = 16177215)
public class ReportUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public ReportUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String doc=request.getParameter("doc");
		int did=Integer.parseInt(doc);
		
		String msg=request.getParameter("msg");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
	    Date date = new Date();  
	    
	    String pid=request.getParameter("pid");
	    int pi=Integer.parseInt(pid);
	    String pn=request.getParameter("pname");
	    
		InputStream inputStream = null; 
		List<Part> fileParts=request.getParts().stream().collect(Collectors.toList());
		//List<Part> fileParts=request.getParts().stream().filter(part->"image".equals(part.getName())).collect(Collectors.toList());
		Connection conn = DbConnector.connectToTable();
		String message = null; 
		int rid=0;
		
		try {
			ResultSet rs1=DbConnector.getDataFromTable("doctors","d_id="+did);
			rs1.next();
		    String dn=rs1.getString("d_name");
		   
		    PreparedStatement ps=conn.prepareStatement("select max(r_id) from p_reports");
		    ResultSet rs=ps.executeQuery();
		    rs.next();
		    rid=rs.getInt(1);
		    rid++;
            
            String sql = "INSERT INTO p_reports(r_id,date,p_id,p_name,d_id,d_name,message,image1,image2,image3,image4,image5) values (?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, rid);
            stmt.setString(2,formatter.format(date));
            stmt.setInt(3,pi);
            stmt.setString(4,pn);
            stmt.setString(5,doc);
            stmt.setString(6, dn);
            stmt.setString(7,msg);
            int i=8;
            for(Part filePart:fileParts)
            {
            	String ty=filePart.getContentType();
            	if(filePart!=null && ty!=null && ty.startsWith("image/") && i<13)
            	{
            		System.out.println("filename="+filePart.getName());
        		    System.out.println("filesize="+filePart.getSize());
        		    System.out.println("file type="+filePart.getContentType());
        		    inputStream = filePart.getInputStream();
        		    stmt.setBlob(i, inputStream);
        		    i++;
            	}
            }
            while(i<13)
            {
            	stmt.setBlob(i,(Blob)null);
            	i++;
            }
            int row = stmt.executeUpdate();
            if (row > 0) {
                message = "Your Reports are uploaded to doctor";
            }
		}
		catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } 
		 finally {
	            if (conn != null) {
	                // closes the database connection
	                try {
	                    conn.close();
	                } catch (SQLException ex) {
	                    ex.printStackTrace();
	                }
	            }
	            // sets the message in request scope
	            request.setAttribute("Message", message);
	             
	            // forwards to the message page
	            getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
	        }
	}

}
