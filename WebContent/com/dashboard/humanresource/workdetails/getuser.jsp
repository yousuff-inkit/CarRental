<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%
ClsConnection ClsConnection=new ClsConnection();
String userid=session.getAttribute("USERID").toString().trim();

 	Connection conn =null;
	try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select codeNo,name,doc_no from hr_empm where empuserlink="+userid+"";
	System.out.println("strsql===Userrrrrrrrrrrrr"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String userlink="";
	String id="";
	String name="";
	String docno="";

	while(rs.next()) {
		id+=rs.getString("codeNo");
		name+=rs.getString("name");
		docno+=rs.getString("doc_no");

  		} 

	stmt.close();
	conn.close();
		response.getWriter().write(id+"***"+name+"***"+docno);

	
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	%>
  
