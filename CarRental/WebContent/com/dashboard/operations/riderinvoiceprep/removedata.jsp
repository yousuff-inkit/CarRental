<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.operations.riderinvoiceprep.ClsExcelImport"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
	 	String brchid=request.getParameter("brchid");
	 	String year=request.getParameter("year");
	 	String month=request.getParameter("month");
	 	int val=0;
	 	
	 	Statement stmt = conn.createStatement(); 
	 	
		String removeDataSql = "DELETE from my_rip where year="+year+" and month="+month+" and brchid='"+brchid+"'";
	//	System.out.println(removeDataSql);
		val = stmt.executeUpdate(removeDataSql);
		System.out.println(val);
		response.getWriter().print(val);

	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
   } finally{
	   conn.close();
   }
%>
  
