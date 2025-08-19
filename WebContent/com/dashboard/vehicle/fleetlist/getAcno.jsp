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
	String strgetacno=" select acno from my_account where codeno='FLEET ACCOUNT'";
	System.out.println(strgetacno);
	ResultSet rsgetbranch=stmt.executeQuery(strgetacno);
	JSONArray obarray=new JSONArray();
	int cnt=0;
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();

		
		objtemp.put("acno",rsgetbranch.getString("acno"));
		
		obarray.add(objtemp);
	}
	objdata.put("obdata",obarray);

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