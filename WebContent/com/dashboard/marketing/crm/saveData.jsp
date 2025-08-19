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
<%@page import="com.email.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null; 

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();    
	 	String qottrno=request.getParameter("qottrno")==null || request.getParameter("qottrno").trim()==""?"0":request.getParameter("qottrno").trim();
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();  
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String siteid=request.getParameter("siteid")==null || request.getParameter("siteid").trim()==""?"0":request.getParameter("siteid").trim();
		String route=request.getParameter("route")==null || request.getParameter("route").trim()==""?"":request.getParameter("route").trim();
		String gpsx=request.getParameter("gpsx")==null || request.getParameter("gpsx").trim()==""?"":request.getParameter("gpsx").trim();
		String gpsy=request.getParameter("gpsy")==null || request.getParameter("gpsy").trim()==""?"":request.getParameter("gpsy").trim();
		String desc=request.getParameter("desc")==null || request.getParameter("desc").trim()==""?"":request.getParameter("desc").trim();
		String saldocno=request.getParameter("saldocno")==null?"":request.getParameter("saldocno").trim();
		String salname=request.getParameter("salname")==null?"":request.getParameter("salname").trim();  
		String proname=request.getParameter("proname")==null?"":request.getParameter("proname").trim();
		String prdocno=request.getParameter("prdocno")==null?"":request.getParameter("prdocno").trim();
		String prname=request.getParameter("prname")==null?"":request.getParameter("prname").trim();
		String checklistarray=request.getParameter("checklist")==null?"":request.getParameter("checklist").trim();
		String date=request.getParameter("date")==null?"":request.getParameter("date").trim();
		String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").trim(); 
		String rdtype=request.getParameter("rdtype")==null?"":request.getParameter("rdtype").trim(); 
		String reason=request.getParameter("reason")==null || request.getParameter("reason")==""?"0":request.getParameter("reason").trim();   
		String enqprocess=request.getParameter("enqprocess")==null?"":request.getParameter("enqprocess").trim();   
	//	System.out.println("process--->>>"+processid+"===docno==="+docno);       
		String clname=request.getParameter("clname")==null?"":request.getParameter("clname").trim();   
		String type=request.getParameter("type")==null?"":request.getParameter("type").trim();   
		String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname").trim();   
		String address=request.getParameter("address")==null?"":request.getParameter("address").trim();   
		String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile").trim();   
		String email=request.getParameter("email")==null?"":request.getParameter("email").trim();   

		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		if(processid.equalsIgnoreCase("Lease Price Request Followup")){
			java.sql.Date sqlDate=null;
		    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
			     sqlDate=ClsCommon.changeStringtoSqlDate(date);
			}
			if(enqprocess.equalsIgnoreCase("2")){ 
				 String upsql1="update gl_lprm set dropped=1 where doc_no='"+docno+"'";             
				 //System.out.println("upsql1--->>>"+upsql1);   
				 val= stmt.executeUpdate(upsql1);  
				   sql="insert into gl_benq (date, rdocno, bibpid, fdate, name, remarks, userid, status)values(now(),'"+docno+"',16,'"+sqlDate+"','"+clname+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3) ";

				 System.out.println("followup=="+sql);
				 val= stmt.executeUpdate(sql);
				 if(val>0) { 
					 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','BENQ',now(),'"+session.getAttribute("USERID").toString()+"','A')";

					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
			}else{
				  sql="insert into gl_benq (date, rdocno, bibpid, fdate, name, remarks, userid, status)values(now(),'"+docno+"',15,'"+sqlDate+"','"+clname+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3) ";

					 System.out.println("followup=="+sql);
					 val= stmt.executeUpdate(sql);
					 if(val>0) { 
						 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','BENQ',now(),'"+session.getAttribute("USERID").toString()+"','A')";

						 //System.out.println("logsql--->>>"+logsql);  
						 val= stmt.executeUpdate(logsql);        
					 }
			}
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Client Update")){
			 System.out.println("Client Update--->>>"+clientname);  

	    	 if(clientname!="")
	    	 {
	    		 String upsql="update gl_lprm set name='"+clientname+"' where doc_no='"+docno+"'";       
				 System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
	    	 }
	    	 if(address!="")
	    	 {
	    		 String upsql1="update gl_lprm set com_add1='"+address+"' where doc_no='"+docno+"'";       
				 System.out.println("upsql--->>>"+upsql1);
				 val= stmt.executeUpdate(upsql1);
	    	 }
	    	 if(mobile!="")
	    	 {
	    		 String upsql2="update gl_lprm set  mob='"+mobile+"' where doc_no='"+docno+"'";       
				 System.out.println("upsql--->>>"+upsql2);
				 val= stmt.executeUpdate(upsql2);
	    	 }
	    	 if(email!="")
	    	 {
	    		 String upsql3="update gl_lprm set  email='"+email+"' where doc_no='"+docno+"'";       
				 System.out.println("upsql--->>>"+upsql3);
				 val= stmt.executeUpdate(upsql3);
	    	 }
			
			 if(val>0) { 
				 String logsql="insert into gl_biblog(doc_no, brhid, userid, entry, edate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','E',now())";
				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";  
			 }
		}else{}      
		 
		if(temp.equalsIgnoreCase("1")){  
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
