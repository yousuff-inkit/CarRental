<%@page import="com.finance.transactions.multiplecashpurchase.ClsMCPIMExcelImport"%>
<%@page import="com.common.ClsCommon"%>
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
	 	String docNo=request.getParameter("docNo")==null || request.getParameter("docNo")==""?"0":request.getParameter("docNo");
	 	
	 	ClsMCPIMExcelImport mdp = new ClsMCPIMExcelImport();      
	 	//System.out.println("IN");
		int val=mdp.ExcelImport(docNo);  
		response.getWriter().print(val);   

	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
