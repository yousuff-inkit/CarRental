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
String cldocnos = request.getParameter("cldocnos")==null || request.getParameter("cldocnos").equals("")?"0":request.getParameter("cldocnos");
String group = request.getParameter("group")==null || request.getParameter("group").equals("")?"":request.getParameter("group");
String type = request.getParameter("type")==null || request.getParameter("type").equals("")?"":request.getParameter("type");
Connection conn=null;
int aaa=0;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String sql="";
	if(type.equalsIgnoreCase("ADD")){
	     sql="update my_acbook set groups=upper('"+group+"') where cldocno in("+cldocnos.substring(0, cldocnos.length()-1)+")";  
	}else{
		 sql="update my_acbook set groups='' where cldocno in("+cldocnos.substring(0, cldocnos.length()-1)+")";
	}   
	//System.out.println("sql---->>>"+sql);      
	aaa= stmt.executeUpdate(sql);   
	
	response.getWriter().print(aaa);
	
	stmt.close();
	conn.close();
}
catch(Exception e){
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>