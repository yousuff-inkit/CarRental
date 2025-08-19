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
	
		String strsql="select doc_no,location from gl_cordinates where status=3";
		//System.out.println("strsqlloactio====>"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray locdata=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("doc_no"));
			objtemp.put("location",rs.getString("location"));
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
