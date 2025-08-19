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
		
		String strSql4 = "SELECT * FROM im_client";    
		ResultSet rs4 = stmt.executeQuery(strSql4);
		if(rs4.next()){
			val =0;
		}else{
			val =1;
		} 
		
		String strSql1 = "SELECT * FROM im_client c LEFT JOIN my_salm sm ON sm.sal_name=c.salesman WHERE sm.doc_no IS NULL and c.salesman!=''";    
		ResultSet rs1 = stmt.executeQuery(strSql1);
		if(rs1.next()){
			val =1;
		}
		
		String strSql2 = "SELECT * FROM im_client c LEFT JOIN my_clcatm sm ON sm.cat_name=c.category WHERE sm.doc_no IS NULL and c.category!=''";    
		ResultSet rs2 = stmt.executeQuery(strSql2);
		if(rs2.next()){
			val =1;
		}
		
		String strSql3 = "SELECT * FROM im_client c LEFT JOIN my_area sm ON sm.area=c.areaname WHERE sm.doc_no IS NULL and c.areaname!=''";    
		ResultSet rs3 = stmt.executeQuery(strSql3);
		if(rs3.next()){
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