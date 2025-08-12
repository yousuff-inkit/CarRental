<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode").toString();
Connection conn=null;
JSONArray gridarray=new JSONArray();
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
		String strsql="select doc_no,triptype,taxable from gl_limotriptype where status=3";
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray triparray=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("doc_no",rs.getString("doc_no"));
			objtemp.put("triptype",rs.getString("triptype"));
			objtemp.put("taxable", rs.getString("taxable"));
			triparray.add(objtemp);
		}
		objdata.put("triptypedata",triparray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
