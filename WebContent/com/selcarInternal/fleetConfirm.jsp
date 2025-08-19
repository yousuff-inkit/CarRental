<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.selcarInternal.ClsAndroid" %>
  
  
<%	
	
JSONArray jsonArray = new JSONArray();
String result="false";
String fleetchk="0";
	try{
		
		ClsAndroid and=new ClsAndroid();
		String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
		String regno=request.getParameter("reg_no")==null?"":request.getParameter("reg_no").toString();
		String type=request.getParameter("type")==null?"":request.getParameter("type").toString();
		String drvid=request.getParameter("drvid")==null?"":request.getParameter("drvid").toString();
		System.out.println("======type==== "+type+"===drvid==="+drvid);
		//String del_KM=request.getParameter("del_KM");
		  fleetchk=and.searchcheck(fleetno,regno,drvid,type);
	//System.out.println("======result==== "+jsonArray);
	}
	catch(Exception e){
	 	e.printStackTrace();
	 	
	}
	
	
     response.getWriter().write(fleetchk);
  %>
  
