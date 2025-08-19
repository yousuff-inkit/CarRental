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
	
		String strsql="select brd.brand_name brand,brd.doc_no from gl_vehmaster veh inner join gl_vehbrand brd on veh.brdid=brd.doc_no where veh.dtype='VEH' and"+
				" veh.statu=3 and veh.limostatus=1 group by brd.doc_no";
		System.out.println("Brand====>"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray locdata=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("doc_no"));
			objtemp.put("brand",rs.getString("brand"));
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
