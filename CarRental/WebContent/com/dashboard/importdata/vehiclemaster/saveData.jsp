<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsVehicleExcelImport"%>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsVehicleExcelCSVImport"%>
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
		String strSql = "select substring_index(path,'.',-1) filetype from my_fileattach where doc_no='"+docNo+"' and dtype='VHM'";
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			filetype=rs.getString("filetype");
		}
		
		if(filetype.equalsIgnoreCase("csv")) {
			
			ClsVehicleExcelCSVImport emp = new ClsVehicleExcelCSVImport();
			//val=emp.ExcelImport(docNo);
			
		} else {
	 		
			ClsVehicleExcelImport emp = new ClsVehicleExcelImport();
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
  
