<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String strSql = "select method from gl_config where field_nme='rentalrecieptsubtype'";
			ResultSet rs = stmt.executeQuery(strSql);
			
			String method="";
			while(rs.next()) {
				method=rs.getString("method");
					} 
			String strSqdiscount = "select method from gl_config where field_nme='discountconfig'";
			ResultSet rsdiscountconfig = stmt.executeQuery(strSqdiscount);
			
			String methoddiscountconfig="";
			while(rsdiscountconfig.next()) {
				methoddiscountconfig=rsdiscountconfig.getString("method");
					} 
			//System.out.println("met ==="+method+"####"+methoddiscountconfig);
			response.getWriter().write(method+"####"+methoddiscountconfig);
			
			stmt.close();
			conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  