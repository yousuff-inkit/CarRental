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
	 	Statement stmtEMP = conn.createStatement();
	 	String upsql = "", insql="";
	 	
	 	if(type.equalsIgnoreCase("Account")){
	 		
	 		String veharr[] = vehdataarr.split(",");
		 	
	 		if(process.equalsIgnoreCase("update")){
	 			String description = "", doc_no = "";
	 			String selsql = "SELECT description, doc_no  FROM my_head WHERE doc_no='"+docno+"'";
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				description = selrs.getString("description");       
	 				doc_no = selrs.getString("doc_no");     
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {    
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_employee SET name = '"+description+"' WHERE name='"+vehdata[0].trim()+"'";
			 		//System.out.println("upsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			//System.out.println("veharr.length===="+veharr.length);
	 			for (int i = 0; i < veharr.length; i++) {  
			 		String vehdata[] = veharr[i].split("::");
			 		insql ="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
					 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
					 		+ "grplevel, gr_type, agroup, lApply, cmpid,OLDCODENO) "
					 		+ "select  if(e.brhid='',1,e.brhid) brhid, UPPER('"+vehdata[0].trim()+"'),0 M_S,301 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,ROUND(@doc_no:=@doc_no+1,0) doc_no, "
					 		+ "curdate() date,'HR' ATYPE,0,ROUND(@doc_no:=@doc_no,0) account, "
					 		+ "'EMP' dtype,concat('.',1081,'.',@doc_no) alevel,1081 grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid,e.codeNo OLDCODENO from im_employee e left join my_head h on upper(h.description)=upper(trim(e.name)) and h.den=301 ,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where e.name='"+vehdata[0].trim()+"' and h.doc_no is null";  
			 		//System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);   
			 		
			 		upsql = " UPDATE im_employee c left join my_head m on upper(m.description)=upper(c.name) SET name=UPPER(m.description) WHERE c.name='"+vehdata[0].trim()+"'";
			 		//System.out.println("upsql===="+upsql);  
			 		val = stmt.executeUpdate(upsql); 
			 	}  
	 		}else{}  
	 	}
	 	
       if(type.equalsIgnoreCase("Designation")){
	 		//System.out.println(type);
	 		String veharr[] = vehdataarr.split(",");
		 	
	 		if(process.equalsIgnoreCase("update")){
	 			
	 			String designed = "", desgid = "";
	 			String selsql = "SELECT desc1, doc_no detid FROM hr_setdesig WHERE doc_no='"+docno+"'";
	 			//System.out.println("selsql===="+selsql);
	 			ResultSet selrs = stmt.executeQuery(selsql);
	 			while(selrs.next()){
	 				designed= selrs.getString("desc1");  
	 				desgid = selrs.getString("detid");  
	 			}
	 			
	 			for (int i = 0; i < veharr.length; i++) {    
			 		String vehdata[] = veharr[i].split("::");
			 		upsql = " UPDATE im_employee SET desig= '"+designed+"' WHERE REPLACE(REPLACE(desig, CONCAT(CHAR(194), CHAR(160)), ''), ' ', '')=replace('"+vehdata[0].trim()+"',' ','')";   
			 		//System.out.println("detsql===="+upsql);
			 		val = stmt.executeUpdate(upsql);     
			 	}
	 		}if(process.equalsIgnoreCase("save")){
	 			for (int i = 0; i < veharr.length; i++) {  
			 		String vehdata[] = veharr[i].split("::");
			 		insql = "insert into hr_setdesig( doc_no, brhId, desc1, remarks, date, status)  SELECT coalesce(max(doc_no)+1,1), 1, UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[0].trim()+"'), curdate(), 3 FROM hr_setdesig "; 
			 	    //System.out.println("insql===="+insql);  
			 		val = stmt.executeUpdate(insql);   
			 		
			 		upsql = " UPDATE im_employee c left join hr_setdesig m on upper(m.desc1)=upper(c.desig) SET c.desig=m.desc1 WHERE c.desig='"+vehdata[0].trim()+"'";  
			 		//System.out.println("epdetsql===="+upsql);  
			 		val = stmt.executeUpdate(upsql); 
			 	}   
	 		}else{}  
	 	}

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
	 		upsql = " UPDATE im_employee SET nationality = '"+nation+"' WHERE nationality='"+vehdata[0].trim()+"'";
	 		//System.out.println("upsql===="+upsql);
	 		val = stmt.executeUpdate(upsql);     
	 	}
		}if(process.equalsIgnoreCase("save")){
			//System.out.println("veharr.length===="+veharr.length);
			for (int i = 0; i < veharr.length; i++) {  
	 		String vehdata[] = veharr[i].split("::");
	 		insql = "insert into my_natm(nation)   VALUES(UPPER('"+vehdata[0].trim()+"'))";  
	 		//System.out.println("insql===="+insql);  
	 		val = stmt.executeUpdate(insql);   
	 		
	 		upsql = " UPDATE im_employee c left join my_natm m on upper(m.nation)=upper(c.nationality) SET c.nationality=UPPER(m.nation)  WHERE c.nationality='"+vehdata[0].trim()+"'";
	 		//System.out.println("====upsql===="+upsql);
	 		stmt.executeUpdate(upsql); 
	 	}
		}else{}  
		
	}
      
      
       if(type.equalsIgnoreCase("Department")){
  		
  		String veharr[] = vehdataarr.split(",");
   	
  		if(process.equalsIgnoreCase("update")){
  			String desc = "", docid = "";
   			String selsql = "SELECT desc1 dept, doc_no docid FROM hr_setdept  WHERE doc_no='"+docno+"'";
   			//System.out.println("dpt===="+selsql);
   			ResultSet selrs = stmt.executeQuery(selsql);
   			while(selrs.next()){
   				desc = selrs.getString("dept");     
   				docid = selrs.getString("docid");     
   			}
  			
  			for (int i = 0; i < veharr.length; i++) {    
  	 		String vehdata[] = veharr[i].split("::");
  	 		upsql = " UPDATE im_employee SET dept = '"+desc+"' WHERE dept='"+vehdata[0].trim()+"'";
  	 		//System.out.println("upsql===="+upsql);
  	 		val = stmt.executeUpdate(upsql);     
  	 	}
  		}if(process.equalsIgnoreCase("save")){
  			//System.out.println("veharr.length===="+veharr.length);
  			for (int i = 0; i < veharr.length; i++) {  
  	 		String vehdata[] = veharr[i].split("::");
  	 		insql = "insert into hr_setdept(doc_no, brhId, desc1, remarks, date, status) SELECT coalesce(max(doc_no)+1,1), 1, UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[0].trim()+"'), curdate(), 3 FROM hr_setdept ";  
  	 		//System.out.println("insql===="+insql);     
  	 		val = stmt.executeUpdate(insql);   
  	 		
  	 		upsql = " UPDATE im_employee c left join hr_setdept m on upper(m.desc1)=upper(c.dept) SET c.dept=UPPER(m.desc1)  WHERE c.dept='"+vehdata[0].trim()+"'";
  	 		//System.out.println("====upsql===="+upsql);
  	 		stmt.executeUpdate(upsql); 
  	 	}    
  		}else{}  
  		
  	} 
      
      if(type.equalsIgnoreCase("PayrollCategory")){
  		
  		String veharr[] = vehdataarr.split(",");
   	
  		if(process.equalsIgnoreCase("update")){
  			String nation = "", nationid = "";
   			String selsql = "SELECT desc1 paycat, doc_no docid FROM hr_setpaycat WHERE doc_no='"+docno+"'";
   			ResultSet selrs = stmt.executeQuery(selsql);
   			while(selrs.next()){
   				nation = selrs.getString("paycat");     
   				nationid = selrs.getString("docid");     
   			}
  			
  			for (int i = 0; i < veharr.length; i++) {    
  	 		String vehdata[] = veharr[i].split("::");
  	 		upsql = " UPDATE im_employee SET pay_cat = '"+nation+"' WHERE nationality='"+vehdata[0].trim()+"'";
  	 		//System.out.println("upsql===="+upsql);
  	 		val = stmt.executeUpdate(upsql);     
  	 	}
  		}if(process.equalsIgnoreCase("save")){
  			//System.out.println("veharr.length===="+veharr.length);
  			for (int i = 0; i < veharr.length; i++) {     
  	 		String vehdata[] = veharr[i].split("::");
  	 		insql = "insert into hr_setpaycat(doc_no, brhId, desc1, remarks, date, status) SELECT coalesce(max(doc_no)+1,1), 1, UPPER('"+vehdata[0].trim()+"'), UPPER('"+vehdata[0].trim()+"'), curdate(), 3 FROM hr_setpaycat ";  
  	 		//System.out.println("insql===="+insql);  
  	 		val = stmt.executeUpdate(insql);   
  	 		
  	 		upsql = " UPDATE im_employee c left join hr_setpaycat m on upper(m.desc1)=upper(c.pay_cat) SET c.pay_cat=UPPER(m.desc1)  WHERE c.pay_cat='"+vehdata[0].trim()+"'";
  	 		//System.out.println("====upsql===="+upsql);
  	 		stmt.executeUpdate(upsql); 
  	 	}
  		}else{}  
  		
  	} 
      
      if(type.equalsIgnoreCase("Confirm")){

    	  String clinsert1 = "insert into hr_empm(brhid,date, codeNo, name,  dtjoin, acno, acc_curid, pmaddr, praddr, pmmob, prmob, pmemail, premail, "
	    			+ " city, state, pincode, nationality, religion, nairport, pob,  dob, dtype, nationId, cmpId, mstatus, Gender, status, fatherName, "
	    			+ "  motherName, bloodGroup, age, grpNo, spouseName, others, curId, active, calendar,est_code,  "
	    			+ " curbrhid,  catId,  agent_id,desc_id, dept_id, pay_catid, "
	    			+ "    costperhour,salary_paid, travels, terminal_benefits, "
	    			+ "     empuserlink,emp_id,co_name) "
	    			+ "select if(a.brhid='' ,1,a.brhid) brhid,curdate() date,a.codeno codeNo,a.name name,if(a.dtjoin='null',null, dtjoin) dtjoin,h.doc_no acno,1 acc_curid, "
	    			+ " pmaddr, praddr, pmmob, prmob, pmemail, premail, city,state, pincode, nationality, religion,a.nearest nairport,a.pob,if(dob='null',null,dob) dob, "
	    			+ " 'EMP' dtype,n.doc_no nation,1 cmp, mstatus,if(gender='MALE','M','F') Gender,3 status, fatherName, "
	    			+ " motherName, bloodGroup, if(age='',0,age) age,0 grpNo, spouseName,a.id others,1 curr,1 active,0 calendar,est_code,  "
	    			+ " 0 curbrhid,0 category,if(agent='WPS','1','2') agent, "
	    			+ "  d.doc_no desig,dt.doc_no dept,pt.doc_no pay_catid, "
	    			+ "'0.0000' costperhour,if(dtjoin='null',null,DATE_ADD(dtjoin,INTERVAL -1 DAY) )salary_paid, if(travels='',0.00,travels) travels, if(dtjoin='null',null,DATE_ADD(dtjoin,INTERVAL -1 DAY) )terminal_benefits,  "
	    			+ " 0 empuserlink,employee_id ,cmp from im_employee a   "
	    			+ "left join my_head h on h.OLDCODENO=a.codeNo and trim(h.description)=trim(a.name) and h.den=301 "
	    			+ " left join my_natm n on trim(n.nation)=trim(a.nationality) "
	    			+ " left join hr_setdept dt on trim(dt.desc1)=trim(a.dept) "
	    			+ " left join hr_setpaycat pt on trim(pt.desc1)=trim(a.pay_cat) "
	    			+ " left join hr_setdesig d on trim(a.desig)=trim(d.desc1)  ";
    	  System.out.println("clinsert1============="+clinsert1);
		  val = stmt.executeUpdate(clinsert1); 

		  if(val!=0){  
			  String strins1="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='VISA') DOCID,doc_idno_visa ,if(VISSUEDATE='null' or VISSUEDATE='',NULL,VISSUEDATE) VISSUEDATE,if(VEXPDATE='null' or VEXPDATE='',NULL,VEXPDATE) VEXPDATE,VPLACEOFISSUE,'','VISA' "
						+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_visa is not null ";
				 System.out.println("strins1============="+strins1);
				 stmtEMP.executeUpdate(strins1);

				 String strins2="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
					+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='PASSPORT') DOCID,DOC_IDNO_PASSPORT,if(PISSUEDATE='null' or PISSUEDATE='',NULL,PISSUEDATE) PISSUEDATE,if(PEXPDATE='null' or PEXPDATE='',NULL,PEXPDATE) PEXPDATE,PPLACEOFISSUE,'','PASSPORT' "
					+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where DOC_IDNO_PASSPORT is not null ";
				 System.out.println("strins2============="+strins2);
				 stmtEMP.executeUpdate(strins2);
	
				 String strins3="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
						+ " SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='EMIRATES') DOCID,doc_idno_EMIRATESid,if(EISSUEDATE='null' or EISSUEDATE='',NULL,EISSUEDATE) EISSUEDATE,if(EEXPDATE='null' or EEXPDATE='' ,NULL,EEXPDATE) EEXPDATE,EPLACEOFISSUE,'','EMIRATES' "
						+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_EMIRATESid is not null ";
				 System.out.println("strins3============="+strins3);
				 stmtEMP.executeUpdate(strins3);
	
				 String strins4="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
						+ " "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='LABOUR') DOCID,doc_idno_labourcard,if(LISSUEDATE='null' or LISSUEDATE='',NULL,LISSUEDATE) LISSUEDATE,if(LEXPDATE='null' or LEXPDATE='',NULL,LEXPDATE) LEXPDATE,LPLACEOFISSUE,'','LABOUR CARD' "
						+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_labourcard is not null ";
				 System.out.println("strins4============="+strins4);
				 stmtEMP.executeUpdate(strins4);
	
				 
				 String strins8="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='MEDICAL') DOCID,doc_idno_medicalcard,if(MISSUEDATE='null' or MISSUEDATE='',NULL,MISSUEDATE) MISSUEDATE,if(MEXPIRYDATE='null' or MEXPIRYDATE='',NULL,MEXPIRYDATE) MEXPIRYDATE,MPLACEOFISSUE,'','MEDICAL CARD' "
						+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_MEDICALCARD is not null ";
				 System.out.println("strins8============="+strins8);
				 stmtEMP.executeUpdate(strins8);

				 
				 String strins9="INSERT INTO HR_EMPDOC( rdocno, docId, docIdnum ,ISSDT,expdt,placeofiss,location,remarks) "
							+ " "
							+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setdoc where desc1='LICENCE') DOCID,doc_idno_LICENSE,if(LIISSUEDATE='null' or LIISSUEDATE='',NULL,LIISSUEDATE) LIISSUEDATE,if(LIEXPDATE='null' or LIEXPDATE='',NULL,LIEXPDATE) LIEXPDATE,LIPLACEOFISSUE,'','LICENCE' "
							+ "  FROM  im_employee  E LEFT JOIN HR_EMPM M ON E.id=M.others where doc_idno_license is not null ";
					 System.out.println("strins9============="+strins9);
					 stmtEMP.executeUpdate(strins9);

			 
					 String strins5="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
					+ "SELECT M.DOC_NO RDOCNO,0 a,0 b,E.BASIC_SALARY FROM  im_employee  E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=0 where em.rdocno is null order by m.doc_no ";
				 System.out.println("strins5============="+strins5);
				 stmtEMP.executeUpdate(strins5);
	
				 String strins51="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='HRA') a,'ALC' b,E.HRA FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='HRA') where em.rdocno is null and e.hra!='' order by m.doc_no  ";
				System.out.println("strins51============="+strins51);
				stmtEMP.executeUpdate(strins51);
	
				String strins52="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='TA') a,'ALC' b,E.TA FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='TA') where em.rdocno is null and e.TA!='' order by m.doc_no   ";
				System.out.println("strins52============="+strins52);
				stmtEMP.executeUpdate(strins52);
	
				String strins53="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='OT') a,'ALC' b,E.OTHERS FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='OT') where em.rdocno is null and e.OTHERS!='' order by m.doc_no ";
				System.out.println("strins53============="+strins53);
				stmtEMP.executeUpdate(strins53);
	
				String strins54="INSERT INTO HR_EMPSAL( rdocno, awlId, refdtype, addition) "
						+ "SELECT M.DOC_NO RDOCNO,(select doc_no from hr_setallowance where code='CAR ALLOWANCE') a,'ALC' b,E.CARALLOWANCE FROM im_employee E LEFT JOIN HR_EMPM M ON M.OTHERS=E.id left join  HR_EMPSAL em on em.rdocno=m.doc_no and em.awlid=(select doc_no from hr_setallowance where code='CAR ALLOWANCE') where em.rdocno is null and e.CARALLOWANCE!='' order by m.doc_no  ";
				System.out.println("strins54============="+strins54);
				stmtEMP.executeUpdate(strins54);
	
				String strins6="insert into hr_incrm ( doc_no, date, dtype, month, year, empId, upto, deptId, catId, desigId, RefDocNo, status, brhid, revised, revdeptId, revcatId, "
						+ "revdesigId, userId, cmpId, onHold, remarks) "
						+ "select @doc_no:=@doc_no+1, coalesce(dtjoin,curdate()) dtjoin,'EMP' dtype , month(dtjoin), year(dtjoin),doc_no,dtjoin,  dept_id, pay_catid, desc_id, "
						+ "1 RefDocNo,3 status, if(brhid='',1,brhid) brhid,0 revised,0 revdeptId,0 revcatId,0 revdesigId,1 userId,1 cmpId,0 onHold,'EMPLOYEE MASTER' remarks from hr_empm ,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from hr_incrm)) m   ";
				 System.out.println("strins6============="+strins6);
				 stmtEMP.executeUpdate(strins6);
	
				 String strins7="insert into hr_incrd (sr_no,  rdocno, awlId, refdtype, addition, deduction, statutorydeduction, revadd, revded, revstatded,  "
						+ "remarks)  "
						+ "select coalesce(s.awlId,0) awlId,i.doc_no,s.awlId,s.refdtype,s.addition, s.deduction,s.statutorydeduction,s.addition,0.0000 revded,  "
						+ "0.0000 revstatded,0 remarks from hr_empsal s  "
						+ "left join hr_incrm i on i.empid=s.rdocno "; 
				 System.out.println("strins7============="+strins7);
				 stmtEMP.executeUpdate(strins7);
		  }
		  
		  if(val>0){
			  String clinsert3 = "TRUNCATE im_employee";
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