<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

Connection conn=null;
String result="0";
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
		
		String strsql="select coalesce(method,0) method from gl_config where field_nme='hidetariff'";
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			result=rs.getString("method");
		}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(result+"");
%>
