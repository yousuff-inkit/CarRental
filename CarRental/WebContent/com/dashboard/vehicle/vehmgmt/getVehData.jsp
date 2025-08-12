<%@page import="com.dashboard.vehicle.vehmgmt.ClsVehMgmtDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%
JSONArray data=new JSONArray();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
try{
	ClsVehMgmtDAO dao=new ClsVehMgmtDAO();
	data=dao.getVehicleData(id, brhid);	
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(data+"");
%>