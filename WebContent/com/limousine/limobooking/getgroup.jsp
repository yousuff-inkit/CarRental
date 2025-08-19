<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONArray gridarray=new JSONArray();
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
		String strsql="SELECT GID gid, GNAME gname, doc_no docno  FROM gl_vehgroup WHERE STATUS=3";
		//System.out.println("group====>"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray locdata=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("docno"));
			objtemp.put("group",rs.getString("gid"));
			locdata.add(objtemp);
		}
		objdata.put("locdata",locdata);  
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(objdata+"");
%>
