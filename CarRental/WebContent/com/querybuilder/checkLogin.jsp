<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String mysqlpassword=request.getParameter("mysqlpassword")==null?"":request.getParameter("mysqlpassword");
String mysqlusername=request.getParameter("mysqlusername")==null?"":request.getParameter("mysqlusername");
int errorstatus=-1;
JSONObject objdata=new JSONObject();
try{
	String jdbcurl="jdbc:mysql://localhost:3306/mysql";
	Connection connection = DriverManager.getConnection(jdbcurl, mysqlusername, mysqlpassword);
	errorstatus=0;
	connection.close();
}
catch(Exception e){
	e.printStackTrace();
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>