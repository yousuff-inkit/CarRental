<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	String checkoutdate=request.getParameter("checkoutdate")==null?"":request.getParameter("checkoutdate");
	String checkouttime=request.getParameter("checkouttime")==null?"":request.getParameter("checkouttime");
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	
	java.sql.Date sqlcheckoutdate=null;
	if(checkoutdate!=null && !checkoutdate.trim().equalsIgnoreCase("") && !checkoutdate.trim().equalsIgnoreCase("undefined")){
		sqlcheckoutdate=objcommon.changeStringtoSqlDate(checkoutdate);
	}
	
	
	String strupdate="update hr_punchatt set checkoutdate='"+sqlcheckoutdate+"',checkouttime='"+checkouttime+"',status=0 where doc_no="+docno;
	System.out.println(strupdate);
	int update=stmt.executeUpdate(strupdate);
	if(update<=0){
		errorstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>