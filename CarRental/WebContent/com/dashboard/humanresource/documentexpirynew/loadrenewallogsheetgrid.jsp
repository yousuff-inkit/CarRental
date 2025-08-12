<%@page import="com.dashboard.humanresource.documentexpirynew.ClsDocumentExpiryNewDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONArray result=new JSONArray();
try{
	 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");
	
	 ClsDocumentExpiryNewDAO viewDAO= new ClsDocumentExpiryNewDAO();
	 result=viewDAO.renewallogSheetGridLoad(check, docno);
}
catch(Exception e){
	e.printStackTrace();	
}
response.getWriter().write(result+"");
%>