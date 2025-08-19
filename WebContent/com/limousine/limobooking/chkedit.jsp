<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

ClsConnection objconn=new ClsConnection();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String count = "0";
	String str="SELECT COUNT(*) count FROM gl_limomanagement WHERE bstatus>3 AND docno="+docno;
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		count = rs.getString("count");
	}
	stmt.close();
	response.getWriter().write(count);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>