<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String doc_no=request.getParameter("commentdocno")==null?"":request.getParameter("commentdocno");
String clear=request.getParameter("clear")==null?"":request.getParameter("clear");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	//System.out.println("hi");
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	 String strsql="";

	if(doc_no!="")
	{
		  strsql="update hr_workcomments set clear='"+clear+"' where doc_no='"+doc_no+"' ";	
		 // System.out.println("update==========="+strsql);
	}

	//System.out.println("wa_comments==========="+strsql);
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