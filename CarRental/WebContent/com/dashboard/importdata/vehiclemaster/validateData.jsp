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
	 		
	 		if(type.equalsIgnoreCase("Authority")){
	 			selsql = " SELECT * FROM gl_vehauth WHERE authid='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Auth ID is already exists.";  
		 		}
		 		
		 		selsql = " SELECT * FROM gl_vehauth WHERE authname='"+vehdata[1].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs1 = stmt.executeQuery(selsql); 
		 		if(rs1.next()){
		 			validationText = "Authority is already exists.";     
		 		}
	 		}
	 		
	 	   if(type.equalsIgnoreCase("Platecode")){
	 			selsql = " SELECT * FROM gl_vehplate WHERE code_no='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Plate Code is already exists.";
		 		}
		 		
		 		selsql = " SELECT * FROM gl_vehplate WHERE code_name='"+vehdata[1].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs1 = stmt.executeQuery(selsql); 
		 		if(rs1.next()){
		 			validationText = "Name is already exists.";
		 		}
	 		}
	 		
	 	   if(type.equalsIgnoreCase("Brand")){
	 			selsql = " SELECT * FROM gl_vehbrand WHERE brand_name='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Brand is already exists.";
		 		}
	 		}
	 	   
	 	   if(type.equalsIgnoreCase("Model")){
	 			selsql = " SELECT * FROM gl_vehmodel WHERE vtype='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Model is already exists.";
		 		}
	 		}
	 	   
	 	    if(type.equalsIgnoreCase("YOM")){
	 			selsql = " SELECT * FROM gl_yom WHERE yom='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "YOM is already exists.";
		 		}
	 		}
	 	    
	 	    if(type.equalsIgnoreCase("Color")){
	 			selsql = " SELECT * FROM my_color WHERE color='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Color is already exists.";
		 		}
	 		} 
	 	    
	 	   if(type.equalsIgnoreCase("Group")){
	 			selsql = " SELECT * FROM gl_vehgroup WHERE gid='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Group ID is already exists.";
		 		}
	 		} 
	 		 
	 	  if(type.equalsIgnoreCase("Specification")){
	 			selsql = " SELECT * FROM gl_vehspec WHERE name='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Specification is already exists.";
		 		}
	 		} 
	 	  
	 	 if(type.equalsIgnoreCase("Project")){
	 			selsql = " SELECT * FROM gl_project WHERE project_name='"+vehdata[0].trim()+"'";
		 		//System.out.println("selsql===="+selsql);
		 		ResultSet rs = stmt.executeQuery(selsql); 
		 		if(rs.next()){
		 			validationText = "Project is already exists.";
		 		}
	 		} 
	 	 
	 	if(type.equalsIgnoreCase("Dealer")){
 			selsql = " SELECT * FROM my_vendorm WHERE name='"+vehdata[0].trim()+"'";
	 		//System.out.println("selsql===="+selsql);
	 		ResultSet rs = stmt.executeQuery(selsql); 
	 		if(rs.next()){
	 			validationText = "Dealer is already exists.";
	 		}
 		} 
	 	
	 	if(type.equalsIgnoreCase("Insurance")){
 			selsql = " SELECT * FROM gl_vehin WHERE ins_type='"+vehdata[0].trim()+"'";
	 		//System.out.println("selsql===="+selsql);
	 		ResultSet rs = stmt.executeQuery(selsql); 
	 		if(rs.next()){
	 			validationText = "Insurance is already exists.";
	 		}
 		} 
	 	
	 	if(type.equalsIgnoreCase("Finance")){
 			selsql = " SELECT * FROM gl_vehfin WHERE fname='"+vehdata[0].trim()+"'";
	 		//System.out.println("selsql===="+selsql);
	 		ResultSet rs = stmt.executeQuery(selsql); 
	 		if(rs.next()){
	 			validationText = "Finance is already exists.";
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