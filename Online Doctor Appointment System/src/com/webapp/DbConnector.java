package com.webapp;
import java.sql.*;
public class DbConnector {
	public static ResultSet getDataFromTable(String table){
		String driverName="com.mysql.cj.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/hospital";
		String user="root";
		String pwd="sairam";
		ResultSet rs=null;
		try{
			Class.forName(driverName);
			Connection con=DriverManager.getConnection(url,user,pwd);
			Statement stmt=con.createStatement();
			System.out.println("select * from "+table);
			rs=stmt.executeQuery("select * from "+table);
		}
		catch (Exception ex) {
			System.out.println(ex);
		}		
		return rs;

	}
	public static ResultSet getDataFromTable(String table,String cond){
		String driverName="com.mysql.cj.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/hospital";
		String user="root";
		String pwd="sairam";
		ResultSet rs1=null;
		try{
			Class.forName(driverName);
			Connection con=DriverManager.getConnection(url,user,pwd);
			Statement stmt=con.createStatement();
			System.out.println("select * from "+table+" where "+cond);
			rs1=stmt.executeQuery("select * from "+table+" where "+cond);
		}
		catch (Exception ex) {
			System.out.println(ex);
		}		
		return rs1;

	}
	public static Connection connectToTable()
	{
		String driverName="com.mysql.cj.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/hospital";
		String user="root";
		String pwd="sairam";
		Connection con=null;
		try{
			Class.forName(driverName);
			con=DriverManager.getConnection(url,user,pwd);
		}
		catch (Exception ex) {
			System.out.println(ex);
		}
		return con;
	}
	
}
