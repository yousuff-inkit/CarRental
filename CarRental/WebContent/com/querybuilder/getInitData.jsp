<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Getting Databases
	String strdb="SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE schema_name NOT IN ('information_schema','performance_schema','sys')";
	JSONArray dbarray=new JSONArray();
	ResultSet rsdb=stmt.executeQuery(strdb);
	while(rsdb.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("dbname",rsdb.getString("schema_name"));
		dbarray.add(objtemp);
	}
	
	objdata.put("dblist", dbarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>