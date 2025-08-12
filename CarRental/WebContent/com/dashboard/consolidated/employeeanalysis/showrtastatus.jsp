<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();
	java.sql.Date sqlDate=null;


	int val=0;
	Statement stmt=conn.createStatement();
	String strsql="Select method from gl_config where field_nme='rtastatusshow'";
	ResultSet rs = stmt.executeQuery(strsql) ;
	if(rs.next()){
		val = rs.getInt("method");
	}
	System.out.println(val);
	response.getWriter().print(val);
	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();	
	}finally{
	   conn.close();
	}
%>
