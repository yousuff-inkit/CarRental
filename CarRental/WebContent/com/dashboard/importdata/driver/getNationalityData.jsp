<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
    String type = request.getParameter("type")==null?"":request.getParameter("type").toString(); 
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "", fieldid = "", field = "";    
		
		if(type.equalsIgnoreCase("Nationality")){
			 strSql = "select doc_no fieldid, nation field from my_natm"; 
		}else{}  
		if(!strSql.equals("")){ 
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				field+=rs.getString("field")+"$$$$";		
				fieldid+=rs.getString("fieldid")+"$$$$";  
		    } 
			if(!fieldid.equals("")){
				field=field.substring(0, field.length()>0?field.length()-4:0);
				fieldid=fieldid.substring(0, fieldid.length()>0?fieldid.length()-4:0);   
			}
		}
		response.getWriter().print(fieldid+"####"+field);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>   