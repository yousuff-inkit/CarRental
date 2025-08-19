<%@page import="com.common.ClsCommon"%>
<%@page import="com.humanresource.transactions.attendance.ClsATTNExcelImport"%>
<%@page import="com.humanresource.transactions.attendance.ClsATTNExcelCSVImport"%> 
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	try{
	//	System.out.println("savedata chk-------");
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
	 	String docNo=request.getParameter("docNo");
		//System.out.println("savedata chk-------"+docNo);
		String month=request.getParameter("month");
	 	String year=request.getParameter("year");
	 	String department=request.getParameter("department");
	 	String category=request.getParameter("category");
	 	String empId=request.getParameter("empId");
	 	String employeebranchchk=request.getParameter("employeebranchchk");
	 	String brhid=request.getParameter("brhid");
	 	String day=request.getParameter("day");
	 	int val=0;
	 	
	 	Statement stmt = conn.createStatement();
	 	
	 	String filetype="";
		String strSql = "select substring_index(path,'.',-1) filetype from my_fileattach where doc_no='"+docNo+"' and dtype='ATTN'";
	//	 System.out.println(" my_fileattach--->>>"+strSql);  
         
		
		
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			filetype=rs.getString("filetype");
		}
		
		if(filetype.equalsIgnoreCase("csv")) {
			
			ClsATTNExcelCSVImport attn = new ClsATTNExcelCSVImport();
			val=attn.ExcelImport(docNo,year,month);
			
		} else {
	 		
			ClsATTNExcelImport attn = new ClsATTNExcelImport();
			val=attn.ExcelImport(docNo,year,month);  
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
  
