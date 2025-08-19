
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsCommon commonDAO=new ClsCommon();
ClsConnection connDAO= new ClsConnection();
String userid=session.getAttribute("USERID").toString();
String branch=request.getParameter("branch");
	String valfleet=request.getParameter("valfleet");
	String docnos=request.getParameter("docnos");
	String clientid=request.getParameter("clientid");

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

	 
    conn = connDAO.getMyConnection();
    conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	
	
		
				   String upsql1="select * from my_jvtran where rdocno='"+docnos+"' and  rtype='LAG' and status=3 " ;		   
					//System.out.println("--------upsql1---------"+upsql1)	;	  
				   ResultSet reSet = stmt.executeQuery(upsql1);   
				   
					
				   
				   while(reSet.next()) {
				    	
					  // System.out.println("--------first---------")	;	  
				    	val=1;
					  
				    }	
				  
				   String strrep="select count(*) itemcount from gl_vehreplace where rtype='LAG' and rdocno="+docnos+" and status=3";
				   ResultSet rsrepcount=stmt.executeQuery(strrep);
				   int repcount=0;
				   while(rsrepcount.next()){
					   repcount=rsrepcount.getInt("itemcount");
				   }
				   if(repcount>0){
					val=1;
				   }
				   
				   String strcust="select count(*) itemcount from gl_vehcustody where rtype='LAG' and rdocno="+docnos+" and status=3";
				   ResultSet rscustcount=stmt.executeQuery(strcust);
				   int custcount=0;
				   while(rscustcount.next()){
					   custcount=rsrepcount.getInt("itemcount");
				   }
				   if(custcount>0){
					val=1;
				   }
             String upsql2=" select * from gl_vmove where repno!=0 and rdocno='"+docnos+"' and rdtype='LAG' and fleet_no='"+valfleet+"' " ;		   
          //   System.out.println("-------upsql2-------"+upsql2)	;	   
				   ResultSet reSet2 = stmt.executeQuery(upsql2);   
				   
					
				   
				   while(reSet2.next()) {
					  
					 //  System.out.println("--------sec---------")	;	  
					 
				    	val=1;
					  
				    }	
				       
				   
		
			//System.out.println("--------val---------"+val)	;	      	   
		
		 if(val==1)
		 {
		 
		 }
		 else
		 {
			 
		     String upsql3=" delete from gl_vmove where  rdocno='"+docnos+"' and rdtype='LAG'" ;		   
		 	 // System.out.println("--------upsql3----"+upsql3);
			int aaa = stmt.executeUpdate(upsql3);   
			
		    String upsql4=" update  gl_vehmaster set status='IN',tran_code='RR' where   fleet_no='"+valfleet+"' " ;		   
		 	 //  System.out.println("--------upsql4----"+upsql4);   
		   int a1 = stmt.executeUpdate(upsql4);   
			
		   String upsql5=" update  gl_lagmt set status=7,clstatus=1 where   doc_no='"+docnos+"' " ;		   
	 	  // System.out.println("--------upsql5----"+upsql5);  
		   int a2 = stmt.executeUpdate(upsql5);  
		
		   Statement stmtac=conn.createStatement();
			String strac="update my_acbook set lostatus=if(lostatus=0,0,lostatus-1)  where cldocno="+clientid+" and dtype='CRM'";
//			System.out.println("Acbook str:"+strac);
			int acval=stmtac.executeUpdate(strac);
			if(acval<0){
				System.out.println("////////////////my_acbook Error/////////////");
				conn.close();
			}
			String strlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docnos+","+branch+",'LAG',now(),"+userid+",'D')";
			int logval=stmt.executeUpdate(strlog);
			if(logval<0){
				System.out.println("////////////////Log Error/////////////");
				conn.close();
			}
		 }
		 if(val==1)
		 {
			 conn.close();
			 response.getWriter().print(val); 
		 }
		 else
		 {	
			 conn.commit();
			 conn.close();
			  response.getWriter().print(val);  
		 }
	 	  
	 }
	 catch(Exception e){
		conn.close();
			
		}
	 finally{
		 conn.close();
	 }

	%>
