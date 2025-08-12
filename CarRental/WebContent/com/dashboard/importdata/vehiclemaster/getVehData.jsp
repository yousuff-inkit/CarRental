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
		
		if(type.equalsIgnoreCase("BRAND")){
			 strSql = "select brand_name field, doc_no fieldid from gl_vehbrand where status=3"; 
		}else if(type.equalsIgnoreCase("MODEL")){
			strSql = "select vtype field, doc_no fieldid from gl_vehmodel where status=3"; 
		}else if(type.equalsIgnoreCase("AUTHORITY")){
			strSql = "select concat(authid,' - ',authname) field, doc_no fieldid from gl_vehauth where status=3";  
		}else if(type.equalsIgnoreCase("PLATECODE")){
			strSql = "select code_no field, doc_no fieldid from gl_vehplate where status=3";
		}else if(type.equalsIgnoreCase("YOM")){
			strSql = "select yom field, doc_no fieldid from gl_yom"; 
		}else if(type.equalsIgnoreCase("COLOR")){
			strSql = "select color field, doc_no fieldid from my_color where status=3"; 
		}else if(type.equalsIgnoreCase("Group")){
			strSql = "select gname field, doc_no fieldid from gl_vehgroup where status=3"; 
		}else if(type.equalsIgnoreCase("Specification")){
			strSql = "select name field, doc_no fieldid from gl_vehspec where status=3"; 
		}else if(type.equalsIgnoreCase("Project")){
			strSql = "select project_name field, doc_no fieldid from gl_project where status=3"; 
		}else if(type.equalsIgnoreCase("Dealer")){
			strSql = "select name field, doc_no fieldid from my_vendorm where status=3"; 
		}else if(type.equalsIgnoreCase("Insurace")){
			strSql = "select inname field, doc_no fieldid from gl_vehin where status=3"; 
		}else if(type.equalsIgnoreCase("Finance")){
			strSql = "select fname field, doc_no fieldid from gl_vehfin where status=3"; 
		}else{}  
		System.out.println(type+"====VehDetails===="+strSql);
		if(!strSql.equals("")){ 
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				field+=rs.getString("field")+",";		
				fieldid+=rs.getString("fieldid")+",";
		    } 
			if(!fieldid.equals("")){
				field=field.substring(0, field.length()>0?field.length()-1:0);
				fieldid=fieldid.substring(0, fieldid.length()>0?fieldid.length()-1:0);   
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