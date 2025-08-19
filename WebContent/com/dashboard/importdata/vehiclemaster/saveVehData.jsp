<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%
	Connection conn = null;
    String process = request.getParameter("process")==null?"":request.getParameter("process").toString(); 
    String vehdataarr = request.getParameter("dataarr")==null?"":request.getParameter("dataarr").toString(); 
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").toString(); 
    String type = request.getParameter("type")==null?"":request.getParameter("type").toString(); 
	int val=0;
	try{
		ClsConnection connDAO = new ClsConnection();  
		conn = connDAO.getMyConnection();
	 	Statement stmt = conn.createStatement();
 
	 	String upsql = "", insql="";
	 	
	 	if(type.equalsIgnoreCase("Authority")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String authority="";
	 			String selsql = "SELECT authname FROM gl_vehauth WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				authority = selrs.getString("authname");     
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET authority='"+authority+"' WHERE REPLACE(REPLACE(authority, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehauth(AUTHID, AUTHNAME, DATE, STATUS) VALUES(TRIM(UPPER('"+vehdata[0]+"')), TRIM(UPPER('"+vehdata[1]+"')), CURDATE(), 3)"; 
			 		//System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Platecode")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String platecode = "";
	 			String selsql = "SELECT code_name FROM gl_vehplate WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				platecode = selrs.getString("code_name");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET platecode='"+platecode+"' WHERE REPLACE(REPLACE(platecode, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehplate(CODE_NO, CODE_NAME, DATE, AUTH_ID, auth_nme, AUTHID, STATUS) VALUES(TRIM(UPPER('"+vehdata[0]+"')), TRIM(UPPER('"+vehdata[1]+"')), CURDATE(), '"+vehdata[3]+"', '"+vehdata[2]+"', '"+vehdata[3]+"', 3)";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}

	 	if(type.equalsIgnoreCase("Brand")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT brand_name FROM gl_vehbrand WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("brand_name");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET brand_name='"+name+"' WHERE REPLACE(REPLACE(brand_name, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehbrand(brand, brand_name, date, status) VALUES(TRIM(UPPER('"+vehdata[0]+"')), TRIM(UPPER('"+vehdata[0]+"')), CURDATE(), 3)";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Model")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT vtype FROM gl_vehmodel WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("vtype");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET model='"+name+"' WHERE REPLACE(REPLACE(model, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehmodel(vtype, date, brandid, status) VALUES(TRIM(UPPER('"+vehdata[0]+"')), CURDATE(), '"+vehdata[1]+"', 3)";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("YOM")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT yom FROM gl_yom WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("yom");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET yom='"+name+"' WHERE REPLACE(REPLACE(yom, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_yom(yom) VALUES(TRIM(UPPER('"+vehdata[0]+"')))";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Color")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT color FROM my_color WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("color");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET color='"+name+"' WHERE REPLACE(REPLACE(color, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO my_color(codeno, color, status) VALUES(TRIM(UPPER('"+vehdata[0]+"')), TRIM(UPPER('"+vehdata[0]+"')), 3)";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Group")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT gname FROM gl_vehgroup WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("gname");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET group_name='"+name+"' WHERE group_name ='"+vehdata[0].trim()+"'";
			 		//System.out.println("update1===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehgroup(GID, GNAME, date, LEVEL, status, emcrate) VALUES(TRIM(UPPER('"+vehdata[1]+"')), TRIM(UPPER('"+vehdata[0]+"')), curdate(), 0, 3, 150)";
			 		//System.out.println("save1===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Specification")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT name FROM gl_vehspec WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("name");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET spec='"+name+"' WHERE REPLACE(REPLACE(spec, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("update===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_vehspec( name, details, status) VALUES(TRIM(UPPER('"+vehdata[0]+"')), TRIM(UPPER('"+vehdata[0]+"')), 3)";
			 		//System.out.println("save===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Project")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT project_name FROM gl_project WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("project_name");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET project='"+name+"' WHERE REPLACE(REPLACE(project, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="INSERT INTO gl_project( date, cldocno, project_name, dtype, brhid, status) VALUES(curdate() ,TRIM(UPPER('"+vehdata[1]+"')),TRIM(UPPER('"+vehdata[0]+"')),'PRJ',1, 3)";
			 		//System.out.println("insql===="+insql);    
			 		val = stmt.executeUpdate(insql);        
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Dealer")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT name FROM my_vendorm WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("name");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET dealer='"+name+"' WHERE REPLACE(REPLACE(dealer, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		
			 		int acdocno = 0, grpno = 0;
		 			String sql1 = "select coalesce(max(doc_no)+1,1) doc_no,(select doc_no from my_head where den=255 and m_s=1 limit 1) grpno from my_head";   
		 			ResultSet rs1 = stmt.executeQuery(sql1);
		 			while(rs1.next()){
		 				acdocno = rs1.getInt("doc_no");     
		 				grpno = rs1.getInt("grpno");     
		 			}
		 			
		 			String insql2 = "insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
				             +"  date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
				             +"VALUES(1, TRIM(UPPER('"+vehdata[0]+"')), 1, 255, 1, 1, 1, 0, 0, '"+acdocno+"', "
				             +"  curdate(), 'AP', 0, '"+acdocno+"', 'GEN', concat('.','"+grpno+"','.','"+acdocno+"'), '"+grpno+"', 2, 2, 0, 1, 0)";
			 		val = stmt.executeUpdate(insql2);    
			 		if(val>0){
			 			insql ="INSERT INTO my_vendorm(name, date, status, acc_no) VALUES(TRIM(UPPER('"+vehdata[0]+"')), curdate(), 3, '"+acdocno+"')";
				 		System.out.println("insql===="+insql);    
				 		val = stmt.executeUpdate(insql);  
			 		}
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Insurance")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT inname FROM gl_vehin WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("inname");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET ins_type=UPPER('"+name+"') WHERE REPLACE(REPLACE(ins_type, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		
			 		int insurdocNo = 0;
		 			String selsql = "SELECT coalesce(max(doc_no)+1,1) doc_no FROM gl_vehin";  
		 			ResultSet selrs = stmt.executeQuery(selsql);
		 			while(selrs.next()){
		 				insurdocNo = selrs.getInt("doc_no");       
		 			}
		 			
			 		String insursql = "INSERT INTO gl_vehin(doc_no, INNAME, DATE, status, acc_no) VALUES(?, TRIM(UPPER(?)), CURDATE(), 3, ?)";
			 		PreparedStatement pstmt = conn.prepareStatement(insursql);
			 		pstmt.setInt(1, insurdocNo);         // unique doc_no
			 		pstmt.setString(2, vehdata[0]);    // INNAME
			 		pstmt.setString(3, vehdata[1]);    // acc_no
			 		val = pstmt.executeUpdate();     
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Finance")){
	 		String veharr[] = vehdataarr.split(",");
		 	for (int i = 0; i < veharr.length; i++) {
		 		String vehdata[] = veharr[i].split("::");
		 		
		 	}
		 	//System.out.println("vehdataarr===="+vehdataarr);
	 		if(process.equalsIgnoreCase("update")){
	 			String name = "";
	 			String selsql = "SELECT fname FROM gl_vehfin WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				name = selrs.getString("fname");       
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_vehicle SET financier=UPPER('"+name+"') WHERE REPLACE(REPLACE(financier, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {
			 		String vehdata[] = veharr[i].split("::");
			 		
			 		int findocno = 0;
		 			String selsql = "SELECT coalesce(max(doc_no)+1,1) doc_no FROM gl_vehfin";  
		 			ResultSet selrs = stmt.executeQuery(selsql);
		 			while(selrs.next()){
		 				findocno = selrs.getInt("doc_no");       
		 			}
		 			
			 		String finsql = "INSERT INTO gl_vehfin (FID, FNAME, doc_no, DATE, ACC_NO, status) " +
			                "VALUES (TRIM(UPPER(?)), TRIM(UPPER(?)), ?, CURDATE(), ?, ?)";

					 PreparedStatement pstmt = conn.prepareStatement(finsql);  
					 pstmt.setString(1, vehdata[1]); // FID
					 pstmt.setString(2, vehdata[0]); // FNAME
					 pstmt.setInt(3, findocno);   // doc_no
					 pstmt.setString(4, vehdata[2]); // ACC_NO  
					 pstmt.setInt(5, 3);             // status
					 val = pstmt.executeUpdate();  
     
			 	}
	 		}else{}  
	 	}
	 	
	 	if(type.equalsIgnoreCase("Confirm")){

		     String str3 = "insert into my_vendorm( name,date,status)SELECT distinct a.dealer,curdate(),3 FROM im_vehicle A "
		          + "left join  my_head H on H.description=a.dealer and h.atype='AP' "
		          + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO))  "
		          + "left join my_vendorm b on TRIM(UPPER(b.name))=TRIM(UPPER(a.dealer)) "
		          + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.dealer!='' ";
           
		    // System.out.println("str3============="+str3);
		     stmt.executeUpdate(str3);
		 
		
			 String str4 = "insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
	                +"   date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
	                +"    select  1 brhid, financier,1 M_S,612 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
	                +"    curdate() date,'GL' ATYPE,0,@doc_no, 'GEN' dtype,concat('.',(select doc_no from my_head where den=612 and m_s=1 limit 1),'.',@doc_no),"
	                +"  (select doc_no from my_head where den=612 and m_s=1 limit 1) grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid "
	                +"   from im_vehicle e left join my_head h on TRIM(UPPER(h.description))=TRIM(UPPER(e.financier)) and h.den=612 , "
	                +"   (select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where e.financier!='' and h.doc_no is null";  
	           
			 //System.out.println("str4============="+str4);
			 stmt.executeUpdate(str4);

         
	         String str5 = "insert into gl_vehfin(FID, FNAME, DATE, ACC_NO,status)SELECT distinct SUBSTRING(a.financier, 1, 3),a.financier,curdate(),h.doc_no,3 FROM im_vehicle A "
	                 + "left join  my_head H on H.description=a.financier and h.atype='GL' "
	                 + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO)) "
	                 + " left join gl_vehfin b on TRIM(UPPER(b.fname))=TRIM(UPPER(a.financier)) "
	                 + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.financier!=''";
	         
	        // System.out.println("str5============="+str5);
	         stmt.executeUpdate(str5);
			 
			 String str6 = "insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
			       +" date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
			       +"  select  1 brhid, ins_comp,1 M_S,255 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
			       +"  curdate() date,'AP' ATYPE,0,@doc_no, 'GEN' dtype,concat('.',(select doc_no from my_head where den=255 and m_s=1 limit 1),'.',@doc_no), "
			       +"  (select doc_no from my_head where den=255 and m_s=1 limit 1) grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid "
			       +"  from  (select distinct ins_comp from im_vehicle where ins_comp!='') e  left join my_head h on TRIM(UPPER(h.description))=TRIM(UPPER(e.ins_comp)) and h.den=255  , "
			       +"  (select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where h.doc_no is null";
			
	         //System.out.println("str6============="+str6);  
	         stmt.executeUpdate(str6);
			 
			 String str7=" insert into gl_vehin( INNAME,  DATE, status, acc_no)"
			         + "SELECT distinct a.ins_comp,curdate(),3 ,h.doc_no FROM im_vehicle A "
			         + "left join  my_head H on H.description=a.ins_comp "
			         + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO))  "
			         + "left join gl_vehin b on TRIM(UPPER(a.ins_comp))=TRIM(UPPER(b.inname)) "
			         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.ins_comp!=''";
	         //System.out.println("str7============="+str7);
	         stmt.executeUpdate(str7);
			 
	         String str8 = "insert into gl_vehspec(name,status)"
	                 + "SELECT distinct A.spec,3 FROM im_vehicle A "
	                 + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO))  "
	                 + "left join gl_vehspec b on TRIM(UPPER(b.name))=TRIM(UPPER(a.spec)) "
	                 + "WHERE A1.REG_NO IS NULL and b.doc_no is null  and a.spec!=''";
	         
	         //System.out.println("str8============="+str8);
	         stmt.executeUpdate(str8);
	         
	         
	         String str9 = "insert into gl_project(project_name, cldocno,date,status)"
	                 + "SELECT distinct A.project,1,curdate(),3 FROM im_vehicle A "
	                 + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO))  "
	                 + "left join gl_project b on TRIM(UPPER(b.project_name))=TRIM(UPPER(a.project)) "
	                 + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.project!='' "; 
	         //System.out.println("str9============="+str9);
	         stmt.executeUpdate(str9);
	
	         String str10 = "insert into GL_VEHMASTER(doc_no, fleet_no,flname,date,reg_no,yom,fstatus,status,salik_tag,tcno,dlrid,lpo,prch_dte,prch_cost,finid,"
	                 +"  reg_date,depr,reg_exp,itype,ins_comp,ins_exp,pno,eng_no,ch_no,clrid,srvc_km, "
	                 +"  lst_srv,cur_km,c_fuel,renttype,authid,pltid,vgrpid,brdid,vmodid,brhid,statu,a_br,fueltype,tcap,tran_code,comp_id,branded , a_loc)"
	                 + " SELECT @doc_no:=@doc_no+1 docno,@fleet_no:=@fleet_no+1 fleetNo,a.* from(SELECT fleetname,a.date,a.reg_no,y.doc_no yom,'i' fstatus,'in' veh_status,salik_tagno,a.tcno,v.doc_no dealer,if(lpono='',0,lpono) lpono,if(a.purchase_date='null',null,a.purchase_date) purdate,if(purchase_cost='' or purchase_cost is null,0, purchase_cost) purchase_cost,f.doc_no finid, if(a.reg_date='null',null,a.reg_date) reg_date,if(dep_per='' or dep_per is null, 0, dep_per) depr,if(a.reg_expiry='null',null,a.reg_expiry) reg_expiry,a.ins_type,i.doc_no inscomp,if(ins_expiry='null',null,ins_expiry) ins_expiry,policy_no,engine_no,chasis_no,c.doc_no color,if(srvduration_km='',0,srvduration_km) srvduration_km,0 lastsrv_date,if(currentkm='' or currentkm is null, 0, currentkm) currentkm,if(currentfuel='',0,currentfuel) currentfuel, 'a' renttype,coalesce(au.doc_no,0) authid,coalesce(p.doc_no,0) platecode,coalesce(g.doc_no,0) groups,coalesce(b.doc_no,0) brand,coalesce(m.doc_no,0) model,1 br,3 stat,1 abr,if(fuel_type='petrol','p','d') fuel_type,if(fuel_capacity='' or fuel_capacity is null, 0 ,fuel_capacity) fuel_capacity,'in',1 cmpid,'y' brn,1 aloc FROM im_vehicle A "
	                 + "LEFT JOIN GL_veHMASTER A1 ON TRIM(UPPER(A.REG_NO))=TRIM(UPPER(A1.REG_NO)) " 
	                 + "left join gl_yom y on TRIM(UPPER(y.yom))=TRIM(UPPER(A.yom)) "
	                 + "left join my_vendorm v on TRIM(UPPER(v.name))=TRIM(UPPER(A.dealer)) "
	                 + "left join gl_vehfin f on TRIM(UPPER(f.fname))=TRIM(UPPER(a.financier)) "
	                 + "left join gl_vehin i on TRIM(UPPER(a.ins_comp))=TRIM(UPPER(i.inname)) "
	                 + "left join my_color c on TRIM(UPPER(c.color))=TRIM(UPPER(a.color)) "
	                 + "left join gl_project pr on TRIM(UPPER(pr.project_name))=TRIM(UPPER(a.project)) "
	                 + "left join gl_vehauth au on TRIM(UPPER(au.authname))=TRIM(UPPER(a.authority)) "
	                 + "left join gl_vehplate p on TRIM(UPPER(p.code_name))=TRIM(UPPER(a.platecode)) and p.authid=au.doc_no "
	                 + "left join gl_vehgroup g on TRIM(UPPER(g.gname))=TRIM(UPPER(a.group_name)) "
	                 + "left join gl_vehbrand b on TRIM(UPPER(a.brand_name))=TRIM(UPPER(b.brand)) "
	                 + "left join gl_vehmodel m on TRIM(UPPER(a.model))=TRIM(UPPER(m.vtype))  "
	                 + "WHERE A1.REG_NO IS NULL and b.doc_no is NOT null)a,(select @fleet_no:=(select coalesce(max(fleet_no),0) fleet_no from GL_veHMASTER)) m,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from GL_veHMASTER)) k  "; 
	         //System.out.println("str10============="+str10);  
	         val = stmt.executeUpdate(str10);  
	 		
	         if(val>0){
				  String clinsert3 = "TRUNCATE im_vehicle";
				  stmt.executeUpdate(clinsert3); 
			  }
	 	}
	 	
		response.getWriter().print(val);

	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>