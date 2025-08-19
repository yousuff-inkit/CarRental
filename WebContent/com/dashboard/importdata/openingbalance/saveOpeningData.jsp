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
 
      if(type.equalsIgnoreCase("Confirm")){

    	  String  str="",str1="",str2="",str3="",str4="",str5="",str6="";  
			
		 	     str1="select coalesce(max(trno),0) trno from my_trno ";
				// System.out.println("str1============="+str1);
				
                 int trno=0;
				 ResultSet rs=stmt.executeQuery(str1);
				 while(rs.next()) {
					 trno=rs.getInt("trno");
				 }
				 
			    str2="insert into my_trno(userno,trtype,brhid,edate,transid,trno) "
			 		+ "select 1,'OPN', brhid,now(),doc_no ,@trno:=@trno+1 srno from "
			 		+ "(select distinct accountno doc_no,1 brhid	 from im_openbalance a ) a  ,(select  @trno:=(select coalesce(max(trno),0) trno from my_trno))b   ";
				// System.out.println("str2============="+str2);
				 val = stmt.executeUpdate(str2);
			 
			    if(val>0){
					 str3="insert into my_jvtran(tr_no, acno, dramount, rate, curId, out_amount, duedate, clearedon, trtype,  id, "
					 		+ "ref_row, brhid,description, yrId, cldocno, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status) "
					 		+ "select t.trno,h.doc_no accountno,(a.debit-a.credit),h.rate,h.curid,0,null,null,1,if((a.debit-a.credit) <0,-1,1) ,if(srno='',0,srno)  srno,1 brhid,concat('INV NO: ',coalesce(a.doc_no,0),' ',coalesce(date(a.date),'')) description, "
					 		+ "0,h.cldocno,a.date,'OPN',0,cast(replace((a.debit-a.credit),',','') as decimal(15,2)), if(srno='',0,srno) srno,0,'',1,3 "
					 		+ "from im_openbalance a inner join my_trno t on t.transid=a.accountno and t.trno>"+trno+" left join my_head h on a.accountno=h.account "
					 		+ "order by trno";
					// System.out.println("str3============="+str3);
					val = stmt.executeUpdate(str3);
			    }
			    
			    if(val>0){
			    str4= "insert into my_opnbal(acno, brhId, srno, tr_no, amount, baseamount, curid, rate, total, description, doc_no, date, atype, tranid, debitTotal, creditTotal, status, Basetotal) "
			 		+ "select acno,brhid,tranid,tr_no,dramount,dramount,curid,rate,dramount,description,doc_no,date,'GL',tranid, "
			 		+ "if(dramount>0,dramount,0),if(dramount<0,dramount,0),3,ldramount from my_jvtran where dtype='opn' and tr_no >"+trno+"";
				 //System.out.println("str4============="+str4);
				 val =  stmt.executeUpdate(str4);
			    }
			    
		  if(val>0){
			  String clinsert3 = "TRUNCATE im_openbalance";
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