<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>;
<%@page import="javax.servlet.http.HttpSession"%>;

<%
Connection conn=null;
int driverconfig=0,invruleoveride=0,rentalagentdocno=0;
String rentalagent="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strrentalagent="select method from  gl_config where field_nme='rentalagmtprintratehide'";
	System.out.println(strrentalagent);
	ResultSet rsrentalagent=stmt.executeQuery(strrentalagent);
	while(rsrentalagent.next()){
		rentalagentdocno=rsrentalagent.getInt("method");
	}
	stmt.close();
	System.out.println("====="+rentalagentdocno);
	response.getWriter().print(rentalagentdocno+"####"+1);  
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}


%>