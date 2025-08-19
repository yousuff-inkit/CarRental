<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%
	Connection conn = null;
    String process = request.getParameter("process")==null?"":request.getParameter("process").toString(); 
    String vehdataarr = request.getParameter("dataarr")==null?"":request.getParameter("dataarr").toString(); 
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").toString(); 
    String type = request.getParameter("type")==null?"":request.getParameter("type").toString(); 
	int val=0;
	//System.out.println("vehdataarrses===="+vehdataarr);
	try{
		ClsConnection connDAO = new ClsConnection();  
		conn = connDAO.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
 
	 	String upsql = "", insql="";
	 	
	 	if(type.equalsIgnoreCase("Salesman")){
	 		
	 		String veharr[] = vehdataarr.split(",");
		 	
	 		if(process.equalsIgnoreCase("update")){
	 			String salesman = "", salid = "";
	 			String selsql = "SELECT sal_name, doc_no salid FROM my_salm WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				salesman = selrs.getString("sal_name");     
	 				salid = selrs.getString("salid");     
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {    
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_client SET salesman = '"+salesman+"', salid = '"+salid+"' WHERE salesman='"+vehdata[0].trim()+"'";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			//System.out.println("veharr.length===="+veharr.length);
	 			for (int i = 0; i < veharr.length; i++) {  
			 		String vehdata[] = veharr[i].split("::");
			 		insql = "insert into my_salm(SAL_ID, SAL_NAME, DATE, status, acc_no)   VALUES(UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[1].trim()+"'), CURDATE(), 3, '"+vehdata[2].trim()+"')";  
			 		//System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);   
			 		
			 		upsql = " UPDATE im_client c left join my_salm m on upper(m.sal_name)=upper(c.salesman) SET salesman=UPPER(m.sal_name), c.salid = m.doc_no  WHERE c.salesman='"+vehdata[1].trim()+"'";
			 		//System.out.println("upsql===="+upsql);  
			 		val = stmt.executeUpdate(upsql); 
			 	}  
	 		}else{}  
	 	}
	 	
       if(type.equalsIgnoreCase("Category")){
	 		
	 		String veharr[] = vehdataarr.split(",");
		 	
	 		if(process.equalsIgnoreCase("update")){
	 			String category = "", catid = "";
	 			String selsql = "SELECT cat_name, doc_no catid FROM my_clcatm WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				category = selrs.getString("cat_name");  
	 				catid = selrs.getString("catid");  
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {    
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_client SET category='"+category+"', catid = '"+catid+"' WHERE category='"+vehdata[0].trim()+"'";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			//System.out.println("veharr.length===="+veharr.length);
	 			for (int i = 0; i < veharr.length; i++) {  
			 		String vehdata[] = veharr[i].split("::");
			 		insql = "insert into my_clcatm(dtype, Category, Cat_name, DATE, status, acc_group)   VALUES('CRM', UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[1].trim()+"'), CURDATE(), 3, '"+vehdata[2].trim()+"')";  
			 		//System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);   
			 		
			 		upsql = " UPDATE im_client c left join my_clcatm m on upper(m.Cat_name)=upper(c.category) SET c.category=m.Cat_name, c.catid=m.doc_no WHERE c.category='"+vehdata[1].trim()+"'";  
			 		//System.out.println("upsql===="+upsql);  
			 		val = stmt.executeUpdate(upsql); 
			 	}
	 		}else{}  
	 	}

      if(type.equalsIgnoreCase("Area")){
		
		String veharr[] = vehdataarr.split(",");
 	
		if(process.equalsIgnoreCase("update")){
			String area="", areaid="";
			String selsql = "SELECT area, doc_no areaid FROM my_area WHERE doc_no='"+docno+"'";
			//System.out.println("selsql===="+selsql);    
			ResultSet selrs = stmt.executeQuery(selsql);
			while(selrs.next()){
				area = selrs.getString("area");     
				areaid = selrs.getString("areaid");     
			}
			
			for (int i = 0; i < veharr.length; i++) {    
	 		String vehdata[] = veharr[i].split("::");
	 		upsql = " UPDATE im_client SET areaname='"+area+"', areaid='"+areaid+"' WHERE areaname='"+vehdata[0].trim()+"'";
	 		//System.out.println("upsql===="+upsql);
	 		val = stmt.executeUpdate(upsql);     
	 	}
		}if(process.equalsIgnoreCase("save")){
			//System.out.println("veharr.length===="+veharr.length);
			for (int i = 0; i < veharr.length; i++) {  
	 		String vehdata[] = veharr[i].split("::");
	 		insql = "insert into my_area(area, zone, region, po_box, DATE)   VALUES(UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[1].trim()+"'), UPPER('"+vehdata[2].trim()+"'), UPPER('"+vehdata[2].trim()+"'), CURDATE())"; 
	 		//System.out.println("insql===="+insql);  
	 		val = stmt.executeUpdate(insql);   
	 		
	 		upsql = " UPDATE im_client c left join my_area m on upper(m.area)=upper(c.areaname) SET c.areaname=m.area, c.areaid=m.doc_no WHERE c.areaname='"+vehdata[0].trim()+"'";
	 		//System.out.println("upsql===="+upsql);  
	 		val = stmt.executeUpdate(upsql); 
	 	}
		}else{}  
		
	}
      
      if(type.equalsIgnoreCase("Confirm")){

    	  String clinsert1 = "INSERT INTO my_head(brhid, description, m_s, den, curid, rate, dr, tr_no, cflow, doc_no, "
			 		+ "date, atype, cldocno,account, dtype, alevel, grpno, "
			 		+ "grplevel, gr_type, agroup, lapply, cmpid) "
			 		+ "SELECT  1 brhid, refname,0 m_s,340 den,1 curid,1 rate,1 dr,0 tr_no,0 cflow,@doc_no:=@doc_no+1, "
			 		+ "curdate() date,'AR' atype,@cldocno:=@cldocno+1,@doc_no:=@doc_no, "
			 		+ "'CRM' dtype,concat('.',acc_group,'.',@doc_no),acc_group grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid FROM (SELECT DISTINCT refname,d.acc_group FROM im_client e LEFT JOIN my_head h ON trim(h.description)=trim(e.refname) AND h.den=340 left join my_clcatm  d ON trim(d.category)=trim(e.category) WHERE e.refname!='' AND h.doc_no IS NULL)a ,(SELECT  @doc_no:=(SELECT COALESCE(MAX(doc_no),0) doc_no FROM my_head))b ,(SELECT  @cldocno:=(SELECT COALESCE(MAX(cldocno),0) cldocno FROM my_acbook WHERE dtype='CRM'))c  ";
    	  //System.out.println("clinsert1============="+clinsert1);
		  val = stmt.executeUpdate(clinsert1); 

		  if(val>0){
			  String clinsert2 = "INSERT INTO my_acbook(cldocno, refname,address,com_mob, per_mob,opt_mob,area,area_id,  doc_no, atype, acno,fax1,fax2,web1,mail1,"
				 		+ "codeno, dtype,  date,curid,contactperson,  catid, brhid, cmpid,taxid, acc_group,  status,tax,nontax,trnnumber,type,"
				 		+ "old_docno,sal_id) "
				 		+ "SELECT h.cldocno,h.description ,address,per_mob, per_mob,opt_mob,areaname,a.doc_no, h.cldocno,1,h.doc_no,fax1,fax2,web1,mail1,"
				 		+ "h.cldocno,'CRM',CURDATE(),1,contactperson,m.doc_no catid,1,1,1 taxid, m.acc_group,3,1,IF(nontax='',0,nontax) nontax,trnnumber,1,id,s.doc_no sal_id FROM im_client b "
				 		+ " LEFT JOIN my_head h ON TRIM(h.description)=TRIM(b.refname) AND h.den=340 "
				 		+ " LEFT JOIN my_area a ON TRIM(a.area)=TRIM(b.areaname)"
				 		+ " LEFT JOIN my_salm s ON TRIM(s.sal_name)=TRIM(b.salesman)"
				 		+ "LEFT JOIN my_clcatm m ON TRIM(m.category)=TRIM(b.category) ";
			 //System.out.println("clinsert2============="+clinsert2);
			 val = stmt.executeUpdate(clinsert2); 
		  }
		  
		  if(val>0){
			  String clinsert3 = "TRUNCATE im_client";
			  stmt.executeUpdate(clinsert3); 
		  }
	  }
      
      if(val>0){
    	  conn.commit();
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