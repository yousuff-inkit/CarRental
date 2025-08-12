<%@page import="com.dashboard.limousine.jobclose.ClsLimoJobCloseDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String searchdate=request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
String searchdocno=request.getParameter("searchdocno")==null?"":request.getParameter("searchdocno");
String searchclient=request.getParameter("searchclient")==null?"":request.getParameter("searchclient");
String searchguest=request.getParameter("searchguest")==null?"":request.getParameter("searchguest");
String id=request.getParameter("id")==null?"":request.getParameter("id");

JSONArray data=new JSONArray();
ClsLimoJobCloseDAO dao=new ClsLimoJobCloseDAO();
if(id.equalsIgnoreCase("1")){
		data=dao.getBookSearchData(branch,searchdate,searchdocno,searchclient,searchguest,id);
}
response.getWriter().write(data+"");
%>