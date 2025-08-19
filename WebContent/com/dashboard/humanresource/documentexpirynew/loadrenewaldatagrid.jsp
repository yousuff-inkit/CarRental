<%@page import="com.dashboard.humanresource.documentexpirynew.ClsDocumentExpiryNewDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONArray result=new JSONArray();
try{
	 String doct = request.getParameter("doct")==null?"0":request.getParameter("doct");
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");
	
	System.out.println("Entered"+ " " +doct+" check ="+check);
	 ClsDocumentExpiryNewDAO viewDAO= new ClsDocumentExpiryNewDAO();
	 result=viewDAO.renewalGridLoad(check,doct);
}
catch(Exception e){
	e.printStackTrace();	
}
response.getWriter().write(result+"");
%>