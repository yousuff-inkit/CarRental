<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strcat="SELECT cat_name refname,doc_no docno FROM my_clcatm WHERE dtype='CRM' AND STATUS=3";
	ResultSet rscat=stmt.executeQuery(strcat);
	JSONArray catarray=new JSONArray();
	while(rscat.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno", rscat.getString("docno"));
		objtemp.put("refname", rscat.getString("refname"));
		catarray.add(objtemp);
	}
	objdata.put("catdata", catarray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>