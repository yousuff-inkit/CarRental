<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
String driverid = request.getParameter("driverid")==null?"0":request.getParameter("driverid");
String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
String clientaccount = request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount");
String check = request.getParameter("check")==null?"0":request.getParameter("check");

JSONArray data=new JSONArray();
ClsClientDAO dao=new ClsClientDAO();
if(check.equalsIgnoreCase("1")){
	data=dao.clientSearch(session,clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check);
}
response.getWriter().write(data+"");
%>