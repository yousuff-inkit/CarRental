<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
conn=objconn.getMyConnection();
try{
	
	int vehsaleinvfuturedate=0;
	String strsql="select method from gl_config where field_nme='vehSaleInvFutureDate'";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	while(rs.next()){
		vehsaleinvfuturedate=rs.getInt("method");
	}
	
	int vsinopurchasecost=0;
	strsql="select method from gl_config where field_nme='VSIPurchaseCostIgnore'";
	rs=conn.createStatement().executeQuery(strsql);
	while(rs.next()){
		vsinopurchasecost=rs.getInt("method");
	}
	
	int forceDate=0;
	String strsql2="select method from gl_config where field_nme='forceDate'";
	ResultSet rs2=conn.createStatement().executeQuery(strsql2);
	while(rs2.next()){
		forceDate=rs2.getInt("method");
	}
	objdata.put("vsinopurchasecost",vsinopurchasecost);
	objdata.put("vehsaleinvfuturedate",vehsaleinvfuturedate);
	objdata.put("forceDate",forceDate);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>