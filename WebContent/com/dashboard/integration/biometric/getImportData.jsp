<%@page import="com.dashboard.integration.biometric.ClsBiometricDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%
	
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
	String brhid = request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String id = request.getParameter("id")==null?"":request.getParameter("id");
	
	try{
		ClsBiometricDAO dao=new ClsBiometricDAO();
		JSONArray data=dao.getBiometricData(fromdate, todate, brhid, id);
		response.getWriter().write(data+"");
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>