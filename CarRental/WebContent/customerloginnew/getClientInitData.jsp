<%@page import="customerloginnew.ClsCustomerLoginnewDAO"%>   
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
String refname="";
JSONObject objservice=new JSONObject(); 
JSONObject objsurvey=new JSONObject(); 
ClsCustomerLoginnewDAO dao=new ClsCustomerLoginnewDAO(); 
String userid=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="select coalesce(user_name,'') refname from my_user where doc_no="+userid+"";
	//System.out.println("getclient------"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);     
	while(rs.next()){
		refname=rs.getString("refname");
	}
	
}      
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(refname+" :: "+userid);    
%>