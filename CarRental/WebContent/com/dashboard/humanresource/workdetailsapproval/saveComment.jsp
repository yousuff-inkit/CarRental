<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String costcode=request.getParameter("costcode")==null?"":request.getParameter("costcode");
String costtype=request.getParameter("costtype")==null?"":request.getParameter("costtype");
String dbname=request.getParameter("dbname")==null?"":request.getParameter("dbname");
String empid=request.getParameter("empid")==null?"":request.getParameter("empid");
String date=request.getParameter("ddate")==null?"":request.getParameter("ddate");
String year=request.getParameter("year")==null?"":request.getParameter("year");
String month=request.getParameter("month")==null?"":request.getParameter("month");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	//System.out.println("hi");
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	if(comment!="")
	{
	
	 String strsql="insert into hr_workcomments( comments,costcode, costtype, dbname, empid, date)values('"+comment+"','"+costcode+"','"+costtype+"','"+dbname+"','"+empid+"','"+year+'-'+month+'-'+date+"')";

	//System.out.println("wa_comments==========="+strsql);
	int insertval=stmt.executeUpdate(strsql);
	if(insertval>0){
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
response.getWriter().write(msg);
%>