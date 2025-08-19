<%@page import="net.sf.json.JSONObject"%>
<%
int errorstatus=0;
JSONObject objdata=new JSONObject();
try{
	session.invalidate();
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>