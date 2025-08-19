<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%
int dvrid=request.getParameter("driverid")==null || request.getParameter("driverid")==""?0:Integer.parseInt(request.getParameter("driverid").trim().toString());
int userid=request.getParameter("userid")==null || request.getParameter("userid")==""?0:Integer.parseInt(request.getParameter("userid").trim().toString());

ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	
	    Statement stmt=conn.createStatement();  
	  String sql="update my_user set driverid='"+dvrid+"' where doc_no='"+userid+"'";
	  int a=stmt.executeUpdate(sql);
	  if(a>0){
			msg="1";
			conn.commit();
		}

}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(msg);
%>