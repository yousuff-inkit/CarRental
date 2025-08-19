<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<% 
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int cnoapply=0;
	String strsql="select method from gl_config where field_nme='CNOApply'";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	while(rs.next()){
		cnoapply=rs.getInt("method");
	}
	objdata.put("CNOApply",cnoapply);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
