<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==""?"0":request.getParameter("docno");
String clear=request.getParameter("clear")==""?"0":request.getParameter("clear");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	//System.out.println("hi");
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	 String strsql="" ,strsql1="";String dat="";
	
  strsql="update hr_workcomments set clear='"+clear+"' where doc_no='"+docno+"' ";	
			//System.out.println("clearupdate=========="+strsql);

		  int insertval=stmt.executeUpdate(strsql);
			if(insertval>0){
				conn.commit();
			
	 
}
		 // System.out.println("update==========="+strsql);
	

	//System.out.println("wa_comments==========="+strsql);
	
	
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>