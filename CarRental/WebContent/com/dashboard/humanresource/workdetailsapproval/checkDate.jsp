<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%
ClsConnection ClsConnection=new ClsConnection();
String docno=request.getParameter("docno");
String db=request.getParameter("db");
String trno=request.getParameter("trno");


 	Connection conn =null;
	try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select min(plannedon) plannedon,max(inactivedate) inactivedate from "+db+".cm_srvassign where empid="+docno+" and refdocno="+trno+"  ";
	System.out.println("strsql---------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String startdate="";
	String enddate="";

	while(rs.next()) {
		startdate=rs.getString("plannedon");
		enddate=rs.getString("inactivedate");

  		} 

	stmt.close();
	conn.close();
		response.getWriter().write(startdate+"***"+enddate);

	
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	%>
  
