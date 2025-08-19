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
	double value=0.0;
	String strsql="select method,coalesce(value,0) value from gl_config where field_nme='VehDefaultDeprPercent'";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	while(rs.next()){
		method=rs.getInt("method");
		value=rs.getDouble("value");
	}
	objdata.put("defaultdeprconfig",method);
	objdata.put("defaultdeprpercent",value);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>



 	 