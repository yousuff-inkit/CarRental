<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();  
	Connection conn = null;
	String dtype = request.getParameter("dtype")==null?"":request.getParameter("dtype").trim();
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select letterformat name,doc_no from cm_letter where status=3 and dtype='"+dtype+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("name")+",";  
					sr+=rs.getString("doc_no")+",";     
		} 
		if(!pro.equalsIgnoreCase("")){  
			String procc[]=pro.split(",");
			String brnId[]=sr.split(",");
			
			pro=pro.substring(0, pro.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		response.getWriter().write(sr+"####"+pro);
		
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