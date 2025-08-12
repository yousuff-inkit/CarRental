<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int clone=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='clone'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		clone=rs.getInt("method");
	}
	String currncySql="select method from gl_config where field_nme='currencyConfig' ";
	//System.out.println("currncy====>"+currncySql);
	int clone1=0;
	rs=stmt.executeQuery(currncySql);
	while(rs.next()){
		clone1=rs.getInt("method");
		System.out.println("Test+++ "+clone1);
	}
	response.getWriter().print(clone+"####"+clone1);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>