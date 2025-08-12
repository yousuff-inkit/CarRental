<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
	try{
		conn= ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String strSql = "select method from gl_config where field_nme='hideterminationbenefits'";
		ResultSet rs = stmt.executeQuery(strSql);
		int method=0;
		if(rs.next()) {		
			method=rs.getInt("method");
	  	} 
	
		stmt.close();
		conn.close();
		System.out.println(method);
		response.getWriter().write(method+"");
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	}
%>