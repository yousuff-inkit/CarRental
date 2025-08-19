<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String catid=request.getParameter("catid")==null?"":request.getParameter("catid");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int creditstatus=0;
	
	if(catid!=null && !catid.equalsIgnoreCase("") && !catid.equalsIgnoreCase("undefined")){
		String strsql="SELECT COALESCE(creditstatus,0) creditstatus FROM my_clcatm WHERE doc_no="+catid;
		ResultSet rs=conn.createStatement().executeQuery(strsql);
		while(rs.next()){
			creditstatus=rs.getInt("creditstatus");
		}	
	}
	
	objdata.put("creditcardstatus",creditstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>