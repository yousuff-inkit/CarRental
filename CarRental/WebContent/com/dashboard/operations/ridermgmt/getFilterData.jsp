<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strclient="SELECT ac.cldocno,ac.refname,ac.acno FROM my_acbook ac LEFT JOIN my_clcatm cat ON ac.catid=cat.DOC_NO WHERE ac.STATUS=3 AND cat.servicestatus=1";
	JSONArray clientarray=new JSONArray();
	ResultSet rsclient=stmt.executeQuery(strclient);
	while(rsclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("acno", rsclient.getString("acno"));
		objtemp.put("refname", rsclient.getString("refname"));
		clientarray.add(objtemp);
	}
	objdata.put("clientdata", clientarray);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>