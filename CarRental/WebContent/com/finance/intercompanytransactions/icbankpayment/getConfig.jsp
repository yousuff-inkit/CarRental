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
	response.getWriter().print(clone);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>