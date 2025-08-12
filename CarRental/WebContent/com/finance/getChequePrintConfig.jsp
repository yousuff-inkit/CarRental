<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%

Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();  
	int val=0;
	String strSql = "select coalesce(method,0) method from gl_config where field_nme = 'CHEQUEPRINTCONFIG'";      
	//System.out.println("strSql--------->>"+strSql);      
	ResultSet rs = stmt.executeQuery(strSql);   
    if(rs.next()) {       
		val=rs.getInt("method"); 
	}
	stmt.close();
	conn.close();  

	response.getWriter().print(val);         
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>   