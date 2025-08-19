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
	 		
	 		if(type.equalsIgnoreCase("Nationality")){
	 			selsql = " SELECT * FROM my_natm WHERE nation='"+vehdata[0].trim()+"'";
		 		System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Nationality Already Exists.";
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