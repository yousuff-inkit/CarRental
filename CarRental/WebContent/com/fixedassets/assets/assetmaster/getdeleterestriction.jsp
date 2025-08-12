<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
    String srno=request.getParameter("srno")==null || request.getParameter("srno").equals("")?"0":request.getParameter("srno"); 
 	Connection conn = null;
 	ClsConnection ClsConnection=new ClsConnection();
try{
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select if(purdate=depr_date,1,0) status from my_fixm where sr_no='"+srno+"'";
	//System.out.println("strSql6"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	if(rs.next()) {
		val=rs.getInt("status");
  		} 
	
	stmt.close();
	conn.close();

	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>