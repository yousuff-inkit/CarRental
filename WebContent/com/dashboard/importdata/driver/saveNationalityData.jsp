<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%
	Connection conn = null;
    String process = request.getParameter("process")==null?"":request.getParameter("process").toString(); 
    String vehdataarr = request.getParameter("dataarr")==null?"":request.getParameter("dataarr").toString(); 
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").toString(); 
    String type = request.getParameter("type")==null?"":request.getParameter("type").toString(); 
	int val=0;
	System.out.println("vehdataarrses===="+vehdataarr);
	try{
		ClsConnection connDAO = new ClsConnection();  
		conn = connDAO.getMyConnection();
	 	Statement stmt = conn.createStatement();
 
	 	String upsql = "", insql="";
	 	
	 	if(type.equalsIgnoreCase("Nationality")){
	 		
	 		String veharr[] = vehdataarr.split(",");
		 	
	 		if(process.equalsIgnoreCase("update")){
	 			String nation = "", nationid = "";
	 			String selsql = "SELECT nation, doc_no nationid FROM my_natm WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				nation = selrs.getString("nation");     
	 				nationid = selrs.getString("nationid");     
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {    
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_driver SET nationality = '"+nation+"' WHERE nationality='"+vehdata[0].trim()+"'";
			 		System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			System.out.println("veharr.length===="+veharr.length);
	 			for (int i = 0; i < veharr.length; i++) {  
			 		String vehdata[] = veharr[i].split("::");
			 		insql = "insert into my_natm(nation)   VALUES(UPPER('"+vehdata[0].trim()+"'))";  
			 		System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);   
			 		
			 		upsql = " UPDATE im_driver c left join my_natm m on upper(m.nation)=upper(c.nationality) SET c.nationality=UPPER(m.nation)  WHERE c.nationality='"+vehdata[0].trim()+"'";
			 		System.out.println("upsql===="+upsql);  
			 		val = stmt.executeUpdate(upsql); 
			 	}  
	 		}else{}  
	 		
	 	}
	 	
	 	
	 	if(type.equalsIgnoreCase("Confirm")){

	 		String selsql = "  select @dr_id:=@dr_id+1 dr_id,drivername,nationality,mobileno,dlno,licenseissuedfrom,if(licenseissueddate='' or licenseissueddate='null',NULL,licenseissueddate) licenseissueddate,if(dob='' or dob='null',NULL,dob) dob,doc_no,licensetype,passportno,if(passportexpiry='' or passportexpiry='null',NULL,passportexpiry) passportexpiry,idno,if(idexpiry='' or idexpiry='null',NULL,idexpiry) idexpiry,dtype,srno from"
                    + "(select distinct drivername,1,d.nationality,d.mobileno,d.dlno,d.licenseissuedfrom,d.licenseissueddate,d.dob, "
                    + "c.doc_no,d.licensetype,d.passportno,d.passportexpiry,d.idno,d.idexpiry,'CRM' dtype,d.srno from im_driver d "
                    + "left join my_acbook c on d.clientdocno=c.cldocno left join gl_drdetails g on g.name=d.drivername where g.dr_id is null and d.drivername!='' )h,(select @dr_id:=(select coalesce(max(dr_id),0) dr_id from gl_drdetails)) b "; 
	 		        System.out.println("Confirm===="+selsql);  
                    ResultSet rs = stmt.executeQuery(selsql); 
					while(rs.next()){
						PreparedStatement prestmt = conn.prepareStatement("INSERT INTO gl_drdetails (dr_id, name, branch, nation, mobno, dlno, issfrm, issdate, dob, doc_no, ltype, "
			                    +"cldocno, passport_no, pass_exp, visano, visa_exp, dtype, sr_no) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");  
						prestmt.setInt(1, rs.getInt("dr_id")); 
						prestmt.setString(2, rs.getString("drivername"));  
						prestmt.setInt(3, 1);  
						prestmt.setString(4, rs.getString("nationality"));  
						prestmt.setString(5, rs.getString("mobileno"));  
						prestmt.setString(6, rs.getString("dlno"));  
						prestmt.setString(7, rs.getString("licenseissuedfrom"));  
						prestmt.setDate(8, rs.getDate("licenseissueddate"));  
						prestmt.setDate(9, rs.getDate("dob"));  
						prestmt.setString(10, rs.getString("doc_no"));  
						prestmt.setString(11, rs.getString("licensetype")); 
						prestmt.setString(12, rs.getString("doc_no"));  
						prestmt.setString(13, rs.getString("passportno"));  
						prestmt.setDate(14, rs.getDate("passportexpiry")); 
						prestmt.setString(15, rs.getString("idno")); 
						prestmt.setDate(16, rs.getDate("idexpiry"));
                        prestmt.setString(17, rs.getString("dtype")); 
                        prestmt.setString(18, rs.getString("srno"));  
						val = prestmt.executeUpdate();
					}
			
			  
			  if(val>0){
				  String clinsert3 = "TRUNCATE im_driver";
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