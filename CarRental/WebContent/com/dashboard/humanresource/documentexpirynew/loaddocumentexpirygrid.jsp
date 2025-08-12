<%@page import="com.dashboard.humanresource.documentexpirynew.ClsDocumentExpiryNewDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONArray resultarray=new JSONArray();
try{
	 String branch = request.getParameter("brch")==null?"0":request.getParameter("brch");
	 String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");
	
	
	 ClsDocumentExpiryNewDAO viewDAO= new ClsDocumentExpiryNewDAO();
	 resultarray=viewDAO.documentsExpiryGridLoading(branch, uptodate, check);
}
catch(Exception e){
	e.printStackTrace();	
}
response.getWriter().write(resultarray+"");
%>