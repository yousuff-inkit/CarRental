<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int val = 0;
		
		String strSql0 = "SELECT * FROM im_vehicle";    
		ResultSet rs0 = stmt.executeQuery(strSql0);
		if(rs0.next()){
			val =0;
		}else{
			val =1;
		} 
		
		String strSql1 = "SELECT * FROM im_vehicle veh LEFT JOIN gl_vehauth au ON TRIM(UPPER(veh.authority))=TRIM(UPPER(au.authname)) WHERE au.doc_no IS NULL and veh.authority!=''";    
		ResultSet rs1 = stmt.executeQuery(strSql1);
		if(rs1.next()){
			val =1;
		}
		
		String strSql2 = "SELECT * FROM im_vehicle veh left join gl_vehplate au on TRIM(UPPER(au.code_name))=TRIM(UPPER(veh.platecode)) WHERE au.doc_no IS NULL and veh.platecode!=''";    
		ResultSet rs2 = stmt.executeQuery(strSql2);
		if(rs2.next()){
			val =1;
		}
		
		String strSql3 = "SELECT * FROM im_vehicle veh left join gl_vehbrand au on TRIM(UPPER(veh.brand_name))=TRIM(UPPER(au.brand_name)) WHERE au.doc_no IS NULL and veh.brand_name!=''";    
		ResultSet rs3 = stmt.executeQuery(strSql3);
		if(rs3.next()){
			val =1;
		} 
		
		String strSql4 = "SELECT * FROM im_vehicle veh left join gl_vehmodel au on TRIM(UPPER(veh.model))=TRIM(UPPER(au.vtype)) WHERE au.doc_no IS NULL and veh.model!=''";    
		ResultSet rs4 = stmt.executeQuery(strSql4);
		if(rs4.next()){
			val =1;
		} 
		
		String strSql5 = "SELECT * FROM im_vehicle veh left join gl_yom au on TRIM(UPPER(veh.yom))=TRIM(UPPER(au.yom)) WHERE au.doc_no IS NULL and veh.yom!=''";    
		ResultSet rs5 = stmt.executeQuery(strSql5);
		if(rs5.next()){
			val =1;
		} 
		
		String strSql6 = "SELECT * FROM im_vehicle veh left join my_color au on TRIM(UPPER(veh.color))=TRIM(UPPER(au.color)) WHERE au.doc_no IS NULL and veh.color!=''";    
		ResultSet rs6 = stmt.executeQuery(strSql6);
		if(rs6.next()){
			val =1;
		}    
		
		String strSql7 = "SELECT * FROM im_vehicle veh left join gl_vehgroup au on TRIM(UPPER(veh.group_name))=TRIM(UPPER(au.gname)) WHERE au.doc_no IS NULL and veh.group_name!=''";    
		ResultSet rs7 = stmt.executeQuery(strSql7);
		if(rs7.next()){
			val =1;
		}
		
		String strSql8 = "SELECT * FROM im_vehicle veh left join gl_vehspec au on TRIM(UPPER(veh.spec))=TRIM(UPPER(au.name)) WHERE au.doc_no IS NULL and veh.spec!=''";    
		ResultSet rs8 = stmt.executeQuery(strSql8);
		if(rs8.next()){
			val =1;
		}
		
		String strSql9 = "SELECT * FROM im_vehicle veh left join gl_project au on TRIM(UPPER(veh.project))=TRIM(UPPER(au.project_name)) WHERE au.doc_no IS NULL and veh.project!=''";    
		ResultSet rs9 = stmt.executeQuery(strSql9);
		if(rs9.next()){
			val =1;
		}
		
		String strSql10 = "SELECT * FROM im_vehicle veh left join my_vendorm au on TRIM(UPPER(veh.dealer))=TRIM(UPPER(au.name)) WHERE au.doc_no IS NULL and veh.dealer!=''";    
		ResultSet rs10 = stmt.executeQuery(strSql10);
		if(rs10.next()){
			val =1;
		}
		
		String strSql11 = "SELECT * FROM im_vehicle veh left join gl_vehfin au on TRIM(UPPER(veh.financier))=TRIM(UPPER(au.fname)) WHERE au.doc_no IS NULL and veh.financier!=''";    
		ResultSet rs11 = stmt.executeQuery(strSql11);
		if(rs11.next()){
			val =1;
		}
		
		String strSql12 = "SELECT * FROM im_vehicle veh left join gl_vehin au on TRIM(UPPER(veh.ins_type))=TRIM(UPPER(au.inname)) WHERE au.doc_no IS NULL and veh.ins_type!=''";    
		ResultSet rs12 = stmt.executeQuery(strSql12);
		if(rs12.next()){
			val =1;
		}
		
		response.getWriter().print(val);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>   