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
	 	 
	 	 if(type.equalsIgnoreCase("Category")){
		 		
		 		String veharr[] = vehdataarr.split(",");
			 	
		 		if(process.equalsIgnoreCase("update")){
		 			String category = "", catid = "";
		 			String selsql = "SELECT category cat_name, doc_no catid FROM my_clcatm WHERE doc_no='"+docno+"'";
		 			ResultSet selrs = stmt.executeQuery(selsql);
		 			while(selrs.next()){
		 				category = selrs.getString("cat_name");  
		 				catid = selrs.getString("catid");  
		 			}
		 			
		 			for (int i = 0; i < veharr.length; i++) {    
				 		String vehdata[] = veharr[i].split("::");
				 		upsql = " UPDATE im_vendor SET category='"+category+"', catid = '"+catid+"' WHERE category='"+vehdata[0].trim()+"'";
				 		//System.out.println("upsql===="+upsql);
				 		val = stmt.executeUpdate(upsql);     
				 	}
		 		}if(process.equalsIgnoreCase("save")){
		 			//System.out.println("veharr.length===="+veharr.length);
		 			for (int i = 0; i < veharr.length; i++) {  
				 		String vehdata[] = veharr[i].split("::");
				 		insql = "insert into my_clcatm(dtype, Category, Cat_name, DATE, status, acc_group)   VALUES('VND', UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[1].trim()+"'), CURDATE(), 3, '"+vehdata[2].trim()+"')";  
				 		//System.out.println("insql===="+insql);  
				 		val = stmt.executeUpdate(insql);   
				 		
				 		upsql = " UPDATE im_vendor c left join my_clcatm m on upper(m.category)=upper(c.category) SET c.category=m.category  WHERE c.category='"+vehdata[1].trim()+"'";  
				 		//System.out.println("upsql===="+upsql);  
				 		val = stmt.executeUpdate(upsql); 
				 	}
		 		}else{}  
		 	}
	 	
      if(type.equalsIgnoreCase("Confirm")){

    	  String  clinsert1="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
			 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
			 		+ "grplevel, gr_type, agroup, lApply, cmpid) "
			 		+ "select  1 brhid, REFNAME,0 M_S,255 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
			 		+ "curdate() date,'AP' ATYPE,@cldocno:=@cldocno+1,@doc_no:=@doc_no, "
			 		+ "'VND' dtype,concat('.',acc_group,'.',@doc_no),acc_group grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid from (select distinct refname,d.acc_group from  im_vendor e left join my_head h on trim(h.description)=trim(e.refname) and h.den=255 left join my_clcatm  d on trim(d.category)=trim(e.category) where e.refname!='' and h.doc_no is null)a ,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b ,(select  @cldocno:=(select coalesce(max(cldocno),0) cldocno from my_head  where DEN=255))c  ";
		  val = stmt.executeUpdate(clinsert1); 

		  if(val>0){
			  String clinsert2 = "insert into my_acbook(cldocno, RefName,address,com_mob, per_mob,opt_mob,area,area_id,  doc_no, atype, acno,fax1,fax2,web1,mail1,"
				 		+ "codeno, dtype,  date,curId,contactperson,  catid, brhid, cmpid,taxid, acc_group,  status,TAX,NONTAX,TRNNUMBER,TYPE,"
				 		+ "old_docno,SAL_ID) "
				 		+ "select h.cldocno,h.description ,address,per_mob, per_mob,opt_mob,areaname,a.doc_no, h.cldocno,1,h.doc_no,fax1,fax2,web1,mail1,"
				 		+ "h.cldocno,'VND',curdate(),1,contactperson,m.doc_no CATID,1,1,1 TAXID, m.acc_group,3,1,if(nontax='',0,nontax) nontax,TRNnumber,1,id,1 sal_id from im_vendor b "
				 		+ " left join my_head h on trim(h.description)=trim(b.refname) and h.den=255 "
				 		+ " left join my_area a on trim(a.area)=trim(b.areaname)"
				 		+ "left join my_clcatm m on trim(m.category)=trim(b.category) ";
			 //System.out.println("clinsert2============="+clinsert2);  
			 val = stmt.executeUpdate(clinsert2); 
		  }
		  
		  if(val>0){
			  String clinsert3 = "TRUNCATE im_vendor";
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