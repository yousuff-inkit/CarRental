<%@page import="com.dashboard.limousine.jobclose.ClsLimoJobCloseDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String clientid=request.getParameter("clientid")==null?"":request.getParameter("clientid");
String ispickupbased=request.getParameter("ispickupbased")==null?"0":request.getParameter("ispickupbased");
String id=request.getParameter("id")==null?"":request.getParameter("id");

JSONArray data=new JSONArray();
ClsLimoJobCloseDAO dao=new ClsLimoJobCloseDAO();
if(id.equalsIgnoreCase("1")){
	data=dao.getJobData(fromdate, todate, bookdocno, branch, clientid, ispickupbased, id);
}
response.getWriter().write(data+"");
%>