<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int discountconfig=0;
	String strsql="select method from gl_config where field_nme='discountLimitDetails'";
	ResultSet rsdiscountconfig=stmt.executeQuery(strsql);
	while(rsdiscountconfig.next()){
		discountconfig=rsdiscountconfig.getInt("method");
	}

	System.out.println("discountconfig : "+discountconfig);
	objdata.put("actualclientconfig",discountconfig);
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
