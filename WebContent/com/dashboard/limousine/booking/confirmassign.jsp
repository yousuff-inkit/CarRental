<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");

Connection conn=null;
int errorstatus=0;
try{
	if(!bookdocno.equalsIgnoreCase("")){
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strsql="update gl_limomanagement set isassignconfirm=1 where docno="+bookdocno+" and job='"+docname+"'";
		System.out.println(strsql);
		int value=stmt.executeUpdate(strsql);	
		if(value>0){
			errorstatus=1;
		}
		if(errorstatus==1){
			conn.commit();
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>