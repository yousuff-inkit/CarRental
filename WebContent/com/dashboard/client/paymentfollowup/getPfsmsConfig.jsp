<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();  
		String method="0";
		String strSql = "select method from gl_config where field_nme='paymentFollowUpSmsBtn'";
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
				method=rs.getString("method"); 
	  		} 
		stmt.close();
		conn.close();
		response.getWriter().print(method);
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>