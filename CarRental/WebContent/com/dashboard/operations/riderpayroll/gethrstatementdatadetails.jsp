SELECT description,account FROM my_head WHERE doc_no=2092
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String account="";
String acname="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String acno=request.getParameter("acno");
	String asql = "SELECT description,account FROM my_head WHERE doc_no="+acno;
	System.out.println(asql);
	ResultSet rs=stmt.executeQuery(asql);
	while(rs.next()){
		account=rs.getString("account");
		acname=rs.getString("description");
	}
	System.out.println(acname);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
out.clear(); 
response.getWriter().write(account+ "::" +acname);
%>