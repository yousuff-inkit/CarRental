<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.Arrays"%>
<%
	ClsConnection ClsConnection = new ClsConnection();

	String userid = session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString(); 
	Connection conn = null;    
 	int val = 0;
 	try{
 		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String roles = "";
		String strSql1 = "SELECT COALESCE(description,0) roles FROM gl_config WHERE field_nme='CNRefundRequestUserRole'";
		ResultSet rs = stmt.executeQuery(strSql1);
		while(rs.next()){
			roles = rs.getString("roles");
		}
		
		if (roles != null && !roles.isEmpty()) {
			String strSql2 = "SELECT * FROM my_user WHERE role_id in("+roles+") and doc_no='"+userid+"'";  
			ResultSet rs2 = stmt.executeQuery(strSql2);
			if(rs2.next()){
				if(rs2.getString("role_id").equalsIgnoreCase("1")){
					val = 1;	
				}else if(rs2.getString("role_id").equalsIgnoreCase("34")){
					val = 2;	
				}
				
			}
			System.out.println(strSql2);
		}
		System.out.println("val==="+val);
		response.getWriter().print(val);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
	%>