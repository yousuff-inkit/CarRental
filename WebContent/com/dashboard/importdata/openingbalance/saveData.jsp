<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.importdata.openingbalance.ClsOpeningBalanceExcelImport"%>
<%@page import="com.dashboard.importdata.openingbalance.ClsOpeningBalanceExcelCSVImport"%>
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
	 	String docNo=request.getParameter("docNo");
	 	int val=0;
	 	
	 	Statement stmt = conn.createStatement();
	 	
	 	String filetype="";
		String strSql = "select substring_index(path,'.',-1) filetype from my_fileattach where doc_no='"+docNo+"' and dtype='OPB'";
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			filetype=rs.getString("filetype");
		}
		
		if(filetype.equalsIgnoreCase("csv")) {
			
			ClsOpeningBalanceExcelCSVImport emp = new ClsOpeningBalanceExcelCSVImport();
			val=emp.ExcelImport(docNo);
			
		} else {
	 		
			ClsOpeningBalanceExcelImport emp = new ClsOpeningBalanceExcelImport();
			val=emp.ExcelImport(docNo);
		}

		response.getWriter().print(val);

	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
