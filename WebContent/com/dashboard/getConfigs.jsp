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
	String strpendingcount="select method from gl_config where field_nme='BIPendingCount'";
	ResultSet rspendingcount=stmt.executeQuery(strpendingcount);
	int pendingcountconfig=0;
	while(rspendingcount.next()){
		pendingcountconfig=rspendingcount.getInt("method");
	}
	objconfig.put("pendingcountconfig",pendingcountconfig);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objconfig+"");
%>
