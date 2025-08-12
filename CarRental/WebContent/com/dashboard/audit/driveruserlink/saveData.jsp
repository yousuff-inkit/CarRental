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
		
		String driverid=request.getParameter("driverid")==null || request.getParameter("driverid").equalsIgnoreCase("")?"0":request.getParameter("driverid");
		String userdocno=request.getParameter("userdocno")==null || request.getParameter("userdocno").equalsIgnoreCase("")?"0":request.getParameter("userdocno");
	    
		String sql=null;
		int val=0;
	
		 /*Linking Salesman with User */
		 
    	 	sql="update my_user set driverid="+driverid+" where doc_no="+userdocno+"";  
    	 	System.out.println(sql);
    	 	val= stmt.executeUpdate(sql);
     	 	
     	 	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+userdocno+"','"+session.getAttribute("BRANCHID").toString()+"','DUL',getdate(),'"+session.getAttribute("USERID").toString()+"','A')";
   	 	    int data= stmt.executeUpdate(sql);
		 
		 /*Linking Salesman with User Ends*/
		 				
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
