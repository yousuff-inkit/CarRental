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
		
		String strSql4 = "SELECT * FROM im_employee";    
		ResultSet rs4 = stmt.executeQuery(strSql4);
		if(rs4.next()){
			val =0;
		}else{
			val =1;
		}  
		
		String strSql1 = "SELECT * FROM im_employee c LEFT JOIN my_head sm ON sm.description=c.name WHERE sm.doc_no IS NULL and c.name!=''";   
		System.out.println("strSql1====>"+strSql1);
		ResultSet rs1 = stmt.executeQuery(strSql1);
		if(rs1.next()){
			val =1;
		}
		
		String strSql2 = "SELECT * FROM im_employee c LEFT JOIN hr_setdesig sm ON sm.desc1=c.desig WHERE sm.doc_no IS NULL and c.desig!=''";    
		System.out.println("strSql2====>"+strSql2);
		ResultSet rs2 = stmt.executeQuery(strSql2);
		if(rs2.next()){
			val =1;
		}
		
		String strSql3 = "SELECT * FROM im_employee c LEFT JOIN my_natm sm ON sm.nation=c.nationality WHERE sm.doc_no IS NULL and c.nationality!=''";    
		System.out.println("strSql3====>"+strSql3);
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