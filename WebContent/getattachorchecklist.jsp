<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String dtype = request.getParameter("dtype");
		
		String strSql = "select coalesce(count(*),0) isPresent from my_checklist where dtype='"+dtype+"' and status=3";
		System.out.println(strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String count="";
		while(rs.next()) {
			count=rs.getInt("isPresent")>0?"1":"0";
		} 
		response.getWriter().write(count);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>