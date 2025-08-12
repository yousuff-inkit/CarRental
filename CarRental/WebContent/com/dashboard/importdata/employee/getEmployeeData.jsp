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
		
		if(type.equalsIgnoreCase("Account")){
			 strSql = "select doc_no,account fieldid ,description field from my_head where (atype='HR' ) and m_s=0 and doc_no NOT IN (select acno from hr_empm where status=3)"; 
		} else if(type.equalsIgnoreCase("Designation")){
			strSql = "SELECT doc_no fieldid ,desc1 field FROM hr_setdesig where status=3";
		} else if(type.equalsIgnoreCase("Nationality")){
			strSql = "SELECT doc_no fieldid,nation field FROM my_natm order by nation;";
		}else if(type.equalsIgnoreCase("Department")){
			strSql = "Select doc_no fieldid,desc1 field from hr_setdept where status=3;";
		} else if(type.equalsIgnoreCase("PayrollCategory")){
			strSql = "select doc_no fieldid,desc1 field from hr_setpaycat where status=3;";
		}else{}   
		
		System.out.println(type+"====accoun===="+strSql);
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