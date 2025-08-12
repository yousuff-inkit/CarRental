<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int val = 0;
		
		String strSql2 = "SELECT * FROM im_vendor";    
		ResultSet rs2 = stmt.executeQuery(strSql2);
		if(rs2.next()){
			val =0;
		}else{
			val =1;
		}  
		
		String strSql1 = "SELECT * FROM im_vendor c LEFT JOIN my_clcatm sm ON sm.cat_name=c.category WHERE sm.doc_no IS NULL and c.category!=''";    
		ResultSet rs1 = stmt.executeQuery(strSql1);
		if(rs1.next()){
			val =1;
		}
		
		response.getWriter().print(val);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>   