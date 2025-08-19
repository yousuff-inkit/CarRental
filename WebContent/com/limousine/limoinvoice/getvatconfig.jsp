<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<% 
JSONObject objconfig=new JSONObject();
Connection conn=null;
try{

	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strvatconfig="SELECT coalesce(method,0) method FROM gl_config WHERE field_nme='novatforservices'";
	ResultSet rsstrvatconfig=stmt.executeQuery(strvatconfig);
	int vatconfig=0;
	while(rsstrvatconfig.next()){
		vatconfig=rsstrvatconfig.getInt("method");
	}
	objconfig.put("vatconfig",vatconfig);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objconfig+"");
%>
