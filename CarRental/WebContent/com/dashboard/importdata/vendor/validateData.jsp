<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	String vehdataarr = request.getParameter("dataarr")==null?"":request.getParameter("dataarr").toString();
	String type = request.getParameter("type")==null?"":request.getParameter("type").toString();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String veharr[] = vehdataarr.split(",");
		String selsql = "", validationText = "";
		for (int i = 0; i < veharr.length; i++) {    
	 		String vehdata[] = veharr[i].split("::");
	 		
	 		if(type.equalsIgnoreCase("Category")){
	 			selsql = " SELECT * FROM my_clcatm WHERE cat_name='"+vehdata[1].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Category Already Exists.";
		 		}
	 		}
	 		
	 	}   
		 
		response.getWriter().print(validationText);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>   