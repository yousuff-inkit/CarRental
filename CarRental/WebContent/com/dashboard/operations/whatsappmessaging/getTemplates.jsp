<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select name, mediaid doc_no from wa_template where status='APPROVED'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String template="";
		String templateid="";
		while(rs.next()) {
			template+=rs.getString("name")+",";		
			templateid+=rs.getString("doc_no")+",";
	  	} 
		
		template=template.substring(0, template.length()>0?template.length()-1:0);
		
		response.getWriter().print(template+"####"+templateid);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>