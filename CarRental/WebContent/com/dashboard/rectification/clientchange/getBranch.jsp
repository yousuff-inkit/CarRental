<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select b.doc_no,b.branchname from my_brch b where b.status=3 ";   
	//System.out.println("branch detailsss--------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);      
		String branch="", brhid="";
		while(rs.next()) {
			branch+=rs.getString("branchname")+",";
			brhid+=rs.getString("doc_no")+","; 
	    }
		
		if(!branch.equals("")){
			branch=branch.substring(0, branch.length()>0?branch.length()-1:0); 
		}
		
		response.getWriter().write(branch+"####"+brhid);            
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
