<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int method=0;
	String strshowfuturedate="select method from gl_config where field_nme='showInvFutureDate'";
	ResultSet rsshowfuturedate=conn.createStatement().executeQuery(strshowfuturedate);
	while(rsshowfuturedate.next()){
		method=rsshowfuturedate.getInt("method");
	}
	objdata.put("invfuturedate",method);
	response.getWriter().write(objdata+"");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>