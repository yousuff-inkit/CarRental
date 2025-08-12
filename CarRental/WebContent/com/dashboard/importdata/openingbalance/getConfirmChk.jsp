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
		
		String strSql4 = "SELECT * FROM im_openbalance";    
		ResultSet rs4 = stmt.executeQuery(strSql4);
		if(rs4.next()){
			val = 0;
		}else{
			val = 1;
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