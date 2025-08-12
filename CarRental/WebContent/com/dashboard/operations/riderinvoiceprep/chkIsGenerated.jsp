<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
	String brchid=request.getParameter("brchid");
	String year=request.getParameter("year");
	String month=request.getParameter("month");

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String count="0";
		
		String sql = "select count(*) count from my_rip where issrs>0 and brchid='"+brchid+"' and year="+year+" and month="+month;
		ResultSet resultSet = stmt.executeQuery(sql);
		while(resultSet.next()) {
			count=resultSet.getString("count");
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
  