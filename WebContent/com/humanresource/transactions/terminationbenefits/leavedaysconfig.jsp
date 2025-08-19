<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsCommon commonDAO = new ClsCommon();
		ClsConnection connDAO = new ClsConnection();
		
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		int method=0;
		String sql = "select coalesce(method,0) method from gl_config where field_nme='annualmeligible'";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			method=rs1.getInt("method");
		} 
		
		response.getWriter().write(method+"");
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  