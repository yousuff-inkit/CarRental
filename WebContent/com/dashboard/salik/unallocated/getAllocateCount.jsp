<%@page import="net.sf.json.JSONObject"%>
<%

JSONObject objdata=new JSONObject();
String currentcount=session.getAttribute("SALIKALLOCATECOUNT")==null?"0":session.getAttribute("SALIKALLOCATECOUNT").toString();
objdata.put("currentcount",currentcount);
response.getWriter().write(objdata+"");
%>