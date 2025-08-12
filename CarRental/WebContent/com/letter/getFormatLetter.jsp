<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();  
	Connection conn = null;
	String formatid = request.getParameter("formatid")==null || request.getParameter("formatid").equals("")?"0":request.getParameter("formatid").trim();
	String docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno").trim();
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select coalesce(lettercontent,'') lettercontent from cm_letter where doc_no='"+formatid+"'";
		System.out.println("lettercontentsql==="+strSql);  
		ResultSet rs = stmt.executeQuery(strSql);
		String lettercontent="", content="";
		while(rs.next()) {
			lettercontent = rs.getString("lettercontent").replaceAll("document", docno);
		} 
		if(!lettercontent.equals("")){ 
			 
			ResultSet rs1 = stmt.executeQuery(lettercontent);
			while(rs1.next()) {
				content = rs1.getString("content");    
			}  
		}
		System.out.println("content==="+content);  
		response.getWriter().print(content);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		if(conn!=null){    
			conn.close();
		}
	}
  %>