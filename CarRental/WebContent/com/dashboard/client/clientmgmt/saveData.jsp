
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
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String creditmin=request.getParameter("creditmin")==null || request.getParameter("creditmin").equalsIgnoreCase("")?"0":request.getParameter("creditmin");
		String creditmax=request.getParameter("creditmax")==null || request.getParameter("creditmax").equalsIgnoreCase("")?"0":request.getParameter("creditmax");
		String creditlimit=request.getParameter("creditlimit")==null || request.getParameter("creditlimit").equalsIgnoreCase("")?"0":request.getParameter("creditlimit");
		String salid=request.getParameter("salid")==null || request.getParameter("salid").equalsIgnoreCase("")?"0":request.getParameter("salid");
		String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").equalsIgnoreCase("")?"0":request.getParameter("cldocno");
		String branchid=request.getParameter("brhid")==null || request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid");
		String val=request.getParameter("val")==null || request.getParameter("val").equalsIgnoreCase("")?"0":request.getParameter("val");
		String process=request.getParameter("process")==null?"":request.getParameter("process");
 
		int temp = 0, activity = 0;
		//System.out.println("process==="+process);
		if(process.equalsIgnoreCase("Blocked")){
			String sql="update my_acbook set pcase = 1 where dtype = 'CRM' and cldocno = '"+cldocno+"'";
			//System.out.println("sql==="+sql);
			temp = stmt.executeUpdate(sql); 
			
			if(temp>0){
				  String upsql = "insert into gl_bdis (change_status, rdtype,  bibpid, casedate, status, date, userid, cldocno)values(1, 'CMT', '5',  curdate(), 3, now(), '"+session.getAttribute("USERID").toString()+"', '"+cldocno+"') ";
				  stmt.executeUpdate(upsql);
			}  
			
			activity = 1;
		}else if(process.equalsIgnoreCase("Unblocked")){
			String sql="update my_acbook set pcase = 0 where dtype = 'CRM' and cldocno = '"+cldocno+"'";
			//System.out.println("sql==="+sql);
			temp = stmt.executeUpdate(sql); 	  
			
			if(temp>0){
				  String upsql = "insert into gl_bdis (change_status, rdtype,  bibpid, casedate, status, date, userid, cldocno)values(1, 'CMT', '5',  curdate(), 7, now(), '"+session.getAttribute("USERID").toString()+"', '"+cldocno+"') ";
				  stmt.executeUpdate(upsql);
			} 
			
			activity = 2;  
		}else{}
		
		
		 if(val.equals("1")){
			String sql="update my_acbook set  period='"+creditmin+"', period2='"+creditmax+"', credit='"+creditlimit+"' where dtype='CRM' and cldocno='"+cldocno+"'";
			//System.out.println("sql==="+sql);
			temp = stmt.executeUpdate(sql); 	
		 }
		 
		 if(val.equals("2")){
				String sql="update my_acbook set sal_id='"+salid+"' where dtype='CRM' and cldocno='"+cldocno+"'";
				//System.out.println("sql==="+sql);  
				temp = stmt.executeUpdate(sql); 	
		  }
		
		 if(temp>0){
			  String sql1 = "insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY, activity) values ('"+cldocno+"','"+branchid+"','CMT',now(),'"+session.getAttribute("USERID").toString()+"','A', "+activity+")";
			  stmt.executeUpdate(sql1); 
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
