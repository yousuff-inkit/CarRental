<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%
    String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	   
	String strSql = "select rowno from gl_vpurdetm where rdocno="+masterdoc_no;
	ResultSet rs = stmt.executeQuery(strSql);
	if(rs.next()) {
		val=1;
 	} 
	
	String strSql2 = "select rowno from gl_vpurd where flstatus>0 and rdocno="+masterdoc_no;
	ResultSet rs2 = stmt.executeQuery(strSql2);
	if(rs2.next()) {
		val=1;
 	} 
	
	stmt.close();
	conn.close();
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>