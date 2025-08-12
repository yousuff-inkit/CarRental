<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%
String month=request.getParameter("month")==null?"0":request.getParameter("month");
String year=request.getParameter("year")==null?"0":request.getParameter("year");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
Connection conn=null;
JSONArray data=new JSONArray();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	if(id.equalsIgnoreCase("1")){
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String str="SELECT @i:=@i+1 sl,logm.doc_no logdocno,logm.userid,usr.USER_NAME username,logm.message,logm.logtype,logm.logdate FROM my_ftalog logm LEFT JOIN my_user usr ON logm.userid=usr.DOC_NO,(SELECT @i:=0) i where logm.monthno="+month+" and logm.yearno="+year;	
		ResultSet rs=stmt.executeQuery(str);
		data=objcommon.convertToJSON(rs);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
response.getWriter().write(data+"");
%>