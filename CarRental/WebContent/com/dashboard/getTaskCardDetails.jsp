<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<% 
JSONObject objown = new JSONObject();
JSONObject objother = new JSONObject();
Connection conn=null;
String userid = request.getParameter("userid")==null || request.getParameter("userid").equals("")?"0":request.getParameter("userid").trim(); 
try{

	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql = "select 'own' type, act_status, count(*) val from an_taskcreation where close_status=0 and utype!='app'  and act_status!='Confirmed' and ass_user='"+userid+"' group by act_status union all select 'others' type, act_status, count(*) val from an_taskcreation where close_status=0 and utype!='app' and act_status!='Confirmed' and ass_user!='"+userid+"' and userid='"+userid+"' group by act_status";
	ResultSet rs = stmt.executeQuery(strsql); 
	String ownarr="", otherarr="", type=""; 
	JSONArray jsonarr = new JSONArray();
	while(rs.next()){
		type = rs.getString("type");
		if(type.equalsIgnoreCase("own")){
			objown.put(rs.getString("act_status"), rs.getString("val"));
		}else{
			objother.put(rs.getString("act_status"), rs.getString("val"));
		}  
	}
	System.out.println(objown+"==="+objother);  
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(objown+"####"+objother);        
%>