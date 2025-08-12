<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String amount="0";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String acno=request.getParameter("acno");
	String sql = "SELECT SUM(round(dramount,2)) amount FROM my_jvtran WHERE acno="+acno+" AND STATUS=3";
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
		amount=rs.getString("amount");
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(amount);
%>