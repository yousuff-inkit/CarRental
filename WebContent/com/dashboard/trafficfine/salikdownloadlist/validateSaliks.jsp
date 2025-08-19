<%@page import="com.NewSatDownload.SATdownloadDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
int errorstatus=0;
JSONObject objdata=new JSONObject();
try{
	SATdownloadDAO dao=new SATdownloadDAO();
	boolean status=dao.multipleDBSalikInsert();
	if(status==false){
		errorstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");

%>