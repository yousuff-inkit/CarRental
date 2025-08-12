<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtdocno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
String insurcompdays=request.getParameter("insurcompdays")==null?"":request.getParameter("insurcompdays");
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
String errormsg="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	int clstatus=0,chkinsurcomp=0,insurcompconfig=0;
	
	String stragmt="select clstatus,chkinsurcomp from gl_ragmt where doc_no="+agmtdocno;
	ResultSet rsagmt=stmt.executeQuery(stragmt);
	while(rsagmt.next()){
		clstatus=rsagmt.getInt("clstatus");
		chkinsurcomp=rsagmt.getInt("chkinsurcomp");
	}
	if(clstatus==1){
		errorstatus=1;
		errormsg="Agreement Closed";
	}
	
	String strupdate="update gl_ragmt set insurcompdays="+insurcompdays+" where doc_no="+agmtdocno;
	int update=stmt.executeUpdate(strupdate);
	if(update<0){
		errorstatus=1;
		errormsg="Not Updated";
	}
	
	if(errorstatus==0){
		conn.commit();
	}
	objdata.put("errorstatus", errorstatus);
	objdata.put("errormsg",errormsg);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
