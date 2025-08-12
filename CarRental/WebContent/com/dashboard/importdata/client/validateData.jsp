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
	 		
	 		if(type.equalsIgnoreCase("salesman")){
	 			selsql = " SELECT * FROM my_salm WHERE sal_name='"+vehdata[1].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Name Already Exists.";
		 		}
		 		
		 		selsql = " SELECT * FROM my_salm WHERE acc_no='"+vehdata[2].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs1 = stmt.executeQuery(selsql); 
		 		if(rs1.next()){
		 			validationText = "Account Already Exists.";  
		 		}
	 		}
	 		
	 		if(type.equalsIgnoreCase("Category")){
	 			selsql = " SELECT * FROM my_clcatm WHERE cat_name='"+vehdata[1].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Category Already Exists.";
		 		}
	 		}
	 		
	 		if(type.equalsIgnoreCase("Area")){
	 			selsql = " SELECT * FROM my_area WHERE area='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Area Already Exists.";
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