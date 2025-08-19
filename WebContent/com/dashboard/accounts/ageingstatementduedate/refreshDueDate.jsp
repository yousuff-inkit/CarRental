<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	String dueDateUpdate="update  my_jvtran j inner join my_acbook a on j.acno=a.acno " + 
			"set j.duedate= date_add( j.date , interval coalesce(a.period2,0) day) " + 
			"where j.status=3 and dramount-out_amount<>0";
	int update=conn.createStatement().executeUpdate(dueDateUpdate);
	if(update<=0){
		errorstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>