<%@page import="com.NewSatDownload.SATdownloadActionCosmo"%>
<%@page import="com.NewSatDownload.SATdownloadAction"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno").toString();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
String salikuser=request.getParameter("salikuser")==null?"":request.getParameter("salikuser").toString();
String result="";
String docs="";
try{
	SATdownloadActionCosmo satdao=new SATdownloadActionCosmo();
	result=satdao.process("1",salikuser,"salik","DXB",fleetno,request,session);
	docs=request.getAttribute("xdocs").toString();
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(result+"::"+docs);
%>