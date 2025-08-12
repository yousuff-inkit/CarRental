<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
try{
	
	String saldocno=request.getParameter("saldocno")==null?"":request.getParameter("saldocno");
	String status=request.getParameter("status")==null?"":request.getParameter("status");
	String riderdocno=request.getParameter("riderdocno")==null?"":request.getParameter("riderdocno");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	
	conn.setAutoCommit(false);
	
	Statement stmt=conn.createStatement();
	
	String strupdatelog="update my_salesman set riderstatus='"+status+"' where sal_type='STF' and doc_no="+saldocno;
	System.out.println(strupdatelog);
	int updatelog=stmt.executeUpdate(strupdatelog);
	if(updatelog>0){
		conn.commit();
	}
	else{
		errorstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>