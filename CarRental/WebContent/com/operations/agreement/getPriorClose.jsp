<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
System.out.println("Status:Close");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	int method=0;
	double value=0.0;
	int agmtinvaudit=0;
	strsql="select method,value from gl_config where field_nme='Prior closing'";
	if(!strsql.equalsIgnoreCase("")){
		System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			method=rs.getInt("method");
			value=rs.getDouble("value");
		}
	}
	String strdefaultdate="select method,field_nme from gl_config where field_nme in ('defaultAgmtDates','AgmtCloseSAT')";
	ResultSet rsdefaultdate=stmt.executeQuery(strdefaultdate);
	int defaultdate=0,agmtSAT=0;
	while(rsdefaultdate.next()){
		if(rsdefaultdate.getString("field_nme").trim().equalsIgnoreCase("defaultAgmtDates")){
			defaultdate=rsdefaultdate.getInt("method");	
		}
		else if(rsdefaultdate.getString("field_nme").trim().equalsIgnoreCase("AgmtCloseSAT")){
			agmtSAT=rsdefaultdate.getInt("method");
		}
		
	}
	
	String stragmtinvaudit="select method from gl_config where field_nme='AgmtInvAudit'";
	ResultSet rsagmtinvaudit=stmt.executeQuery(stragmtinvaudit);
	while(rsagmtinvaudit.next()){
		agmtinvaudit=rsagmtinvaudit.getInt("method");
	}
	stmt.close();
	response.getWriter().write(method+"***"+value+"***"+defaultdate+"***"+agmtSAT+"***"+agmtinvaudit);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>
