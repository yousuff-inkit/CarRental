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
 
	String refno=request.getParameter("refno");
	String docno=request.getParameter("docno");
	String type=request.getParameter("type");
	
	String upsql=null;
	int val=0;
	Connection conn=null;
	ClsConnection ClsConnection=new ClsConnection();


	try{
		System.out.println(type.equalsIgnoreCase("RES")+"=="+type+"=="+type.equals("RES"));
		conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement ();
		if(type.equalsIgnoreCase("TER")){
		 upsql="update  hr_payeost set status=7 where rdocno='"+docno+"' and sr_no='"+refno+"'";
		} else if (type.equalsIgnoreCase("RES")){
			System.out.println("Entered");
		 upsql="update  hr_payeosr set status=7 where rdocno='"+docno+"' and sr_no='"+refno+"'";
		} else if (type.equalsIgnoreCase("LEV")){
			System.out.println("Entered");
		 upsql="update  hr_payeosl set status=7 where rdocno='"+docno+"' and sr_no='"+refno+"'";
		}else{
			System.out.println("IN");
		}
 	 	System.out.println("TYPE--------"+type); 
		System.out.println("DELETE PAYEOStr SQL=="+upsql);
		val= stmt.executeUpdate(upsql);
		 
		 upsql="update  hr_payeos  set status=7 where rdocno='"+docno+"' and refno='"+refno+"' and type='"+type+"'";
		 System.out.println("DELETE PAYEOS SQL=="+upsql);
		 val= stmt.executeUpdate(upsql);
	
		 response.getWriter().print(val);
	 
	 	stmt.close();
	 	conn.close();
	   } catch(Exception e){
			e.printStackTrace();
			conn.close();
	   }
	
%>
