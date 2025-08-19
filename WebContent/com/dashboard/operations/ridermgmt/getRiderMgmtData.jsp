<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.dashboard.operations.ridermgmt.ClsRiderMgmtDAO"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
try{
	ClsRiderMgmtDAO dao=new ClsRiderMgmtDAO();
	JSONArray data=dao.getRiderData(brhid, id);
	response.getWriter().write(data+"");
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().write(new JSONArray()+"");
}
%>