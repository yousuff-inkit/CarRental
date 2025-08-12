<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
 	  Connection conn = null;  
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int docno=0;
	String strSql2 = "select coalesce(max(doc_no)+1,0) docno from hr_empm";  
 //System.out.println("---1-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);
	while(rs1.next()) {
		docno=rs1.getInt("docno");
 		} 
	stmt.close();
	conn.close();

	response.getWriter().print(docno);   
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>