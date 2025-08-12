<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.posting.manualapplyingnew.ClsMAPPExcelImport"%>
<%@page import="com.finance.posting.manualapplyingnew.ClsMAPPExcelCSVImport"%>     
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
		String strSql = "select substring_index(path,'.',-1) filetype from my_fileattach where doc_no='"+docNo+"' and dtype='MAPPE'";    
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			filetype=rs.getString("filetype");
		}
		System.out.println("======= "+filetype);      
		if(filetype.equalsIgnoreCase("csv")) {
			
			ClsMAPPExcelCSVImport jvt = new ClsMAPPExcelCSVImport();    
			val=jvt.ExcelImport(docNo);
			
		} else {
	 		
			ClsMAPPExcelImport jvt = new ClsMAPPExcelImport();  
			val=jvt.ExcelImport(docNo);
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
  
