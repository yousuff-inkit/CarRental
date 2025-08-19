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
	 	String docNo=request.getParameter("docNo");
	 	String brchid=request.getParameter("brchid");
	 	String year=request.getParameter("year");
	 	String month=request.getParameter("month");
	 	int val=0;
	 	
	 	Statement stmt = conn.createStatement();
	 	
	 	String filetype="";
		String strSql = "select substring_index(path,'.',-1) filetype from my_fileattach where doc_no='"+docNo+"' and dtype='RIIP'";
		System.out.println("strsql : "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			filetype=rs.getString("filetype");
		}
		System.out.println("filetype : "+filetype);
		
		ClsExcelImport excelDAO = new ClsExcelImport();
		
		if(filetype.equalsIgnoreCase("csv")) {
			System.out.println("Entered if");
			val=excelDAO.ExcelImportCSV(docNo,brchid,year,month);
			
		} else {
			System.out.println("Entered else");
			val=excelDAO.ExcelImport(docNo,brchid,year,month);
			
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
  
