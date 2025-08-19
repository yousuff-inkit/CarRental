<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);   
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();        
	String strsql="insert into in_comments(bookno,userid,msgdate,msg,jobname)values("+bookdocno+","+userid+",now(),'"+comment+"','"+docname+"')";
	int insertval=stmt.executeUpdate(strsql);     
	
	if(insertval>0){    
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>