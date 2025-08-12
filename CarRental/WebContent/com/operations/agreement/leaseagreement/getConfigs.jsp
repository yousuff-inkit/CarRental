<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int invQuarterly=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='InvQuarterly'";
	System.out.println("config========="+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		invQuarterly=rs.getInt("method");
	}
	
	objdata.put("InvQuarterly",invQuarterly);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>