
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

	String drid=request.getParameter("drid").trim();
	String type=request.getParameter("type").trim();
	String status=request.getParameter("status").trim();
	String rdocno=request.getParameter("rdocno").trim();

	
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
	
	if(type.equalsIgnoreCase("RA") && status.equalsIgnoreCase("ACTIVE"))
	{
		upsql="update  gl_rdriver  set status=7 where drid='"+drid+"' and rdocno='"+rdocno+"'";
	}
	else if((type.equalsIgnoreCase("RA") && status.equalsIgnoreCase("INACTIVE")))
	{
		upsql="update  gl_rdriver  set status=3 where drid='"+drid+"' and rdocno='"+rdocno+"' ";

	}
	else if((type.equalsIgnoreCase("LA") && status.equalsIgnoreCase("ACTIVE")))
	{
		upsql="update  gl_ldriver  set status=7 where drid='"+drid+"' and rdocno='"+rdocno+"' ";

	}
	else if((type.equalsIgnoreCase("LA") && status.equalsIgnoreCase("INACTIVE")))
	{
		upsql="update  gl_ldriver  set status=3 where drid='"+drid+"' and rdocno='"+rdocno+"' ";

	}
	//System.out.println("updatesql============"+upsql);
		 val= stmt.executeUpdate(upsql);
		 
		 
		
		
	
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 }
	 catch(Exception e){

			conn.close();
			e.printStackTrace();
		}
	    
	
	%>
