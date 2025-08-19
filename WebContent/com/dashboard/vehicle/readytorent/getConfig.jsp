<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql1 = "select method from gl_config where field_nme='fleetStatusOVerAll'";
		ResultSet rs1 = stmt.executeQuery(strSql1);
		int method1=0;
		while(rs1.next()) {
			method1=rs1.getInt("method");
		}   
	
	
		
		response.getWriter().print(method1);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  