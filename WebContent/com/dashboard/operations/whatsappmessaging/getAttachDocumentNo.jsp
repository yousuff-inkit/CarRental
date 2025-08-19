<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;

	try{
		String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String docno="0";
		
		String sql = "select coalesce(max(doc_no)+1,1) doc_no from my_fileattach where dtype='WAM'";
		ResultSet resultSet = stmt.executeQuery(sql);          
		while(resultSet.next()) {
			docno=resultSet.getString("doc_no");
		}
		
		response.getWriter().write(docno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>