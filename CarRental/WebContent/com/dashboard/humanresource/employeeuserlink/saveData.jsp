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
		
		String empid=request.getParameter("empid");
		String userdocno=request.getParameter("userdocno");
		String rpttype=request.getParameter("rpttype");
	    
		String sql=null;
		int val=0;
	
		 /*Linking emp with User */
		 if(rpttype.equalsIgnoreCase("1")) {
    	 	sql="update hr_empm set empuserlink="+userdocno+" where status<>7 and doc_no="+empid+"";
     	 	val= stmt.executeUpdate(sql);
     	 	
     	 	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+empid+"','"+session.getAttribute("BRANCHID").toString()+"','BSUL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
   	 	    int data= stmt.executeUpdate(sql);
		 }
		 /*Linking emp with User Ends*/
		 
		 /*Remove Linking emp with User */
		 if(rpttype.equalsIgnoreCase("2")) {
    	 	sql="update hr_empm set empuserlink=0 where status<>7 and doc_no="+empid+"";
     	 	val= stmt.executeUpdate(sql);
     	 	
     	 	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+empid+"','"+session.getAttribute("BRANCHID").toString()+"','BSUL',now(),'"+session.getAttribute("USERID").toString()+"','D')";
   	 	    int data= stmt.executeUpdate(sql);
		 }
		 /*Remove Linking emp with User Ends*/
		 				
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
