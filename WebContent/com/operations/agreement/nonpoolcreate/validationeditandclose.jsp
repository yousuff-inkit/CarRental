<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
try{
	String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");
	String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date datein=null;
	String timein="";
	int outstatus=0;
	int isedit=0;
	String sql="select count(*) count from gl_vmove where fleet_no="+fleetno+" and status='OUT'";
	ResultSet rs=stmt.executeQuery(sql);
	while(rs.next()){
	outstatus = rs.getInt("count");		
	}
	
	String sqledit="SELECT IF(doc_no=(SELECT MAX(doc_no) FROM gl_vmove),0,1) res FROM gl_vmove WHERE rdocno ="+rdocno+" AND rdtype='NPV'";
	ResultSet rssqledit=stmt.executeQuery(sqledit);
	while(rssqledit.next()){
	isedit = rssqledit.getInt("res");		
	}

	stmt.close();
	conn.close();
	System.out.println(isedit+"::"+outstatus);
	response.getWriter().write(isedit+"::"+outstatus);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>