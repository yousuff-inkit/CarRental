<%@page import="java.sql.ResultSet"%>
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
	String clientacno=request.getParameter("clientacno")==null?"":request.getParameter("clientacno");
	String clientuid=request.getParameter("clientuid")==null?"":request.getParameter("clientuid");
	String riderdocno=request.getParameter("riderdocno")==null?"":request.getParameter("riderdocno");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	
	conn.setAutoCommit(false);
	
	Statement stmt=conn.createStatement();
	
	if(riderdocno.equalsIgnoreCase("")||riderdocno.equalsIgnoreCase("0")){
		String strmaxdocno="select coalesce(max(doc_no),0)+1 maxdocno from gl_riderlog";
		int maxdocno=0;
		ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
		while(rsmaxdocno.next()) {
			maxdocno=rsmaxdocno.getInt("maxdocno");
		}
		String strinsert="insert into gl_riderlog(doc_no,saldocno,saltype,date)values("+maxdocno+","+saldocno+",'STF',CURDATE())";
		int insert=stmt.executeUpdate(strinsert);
		if(insert>0){
			riderdocno=maxdocno+"";
		}
	}
	
	String strupdatelog="update gl_riderlog set clientacno="+clientacno+",clientuid='"+clientuid+"' where doc_no="+riderdocno;
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