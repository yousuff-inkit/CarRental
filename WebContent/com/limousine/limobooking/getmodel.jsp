<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String brandid=request.getParameter("brand")==null || request.getParameter("brand").equals("")?"0":request.getParameter("brand").toString();
Connection conn=null;
JSONArray gridarray=new JSONArray();
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
		String strsql="select model.vtype model,model.doc_no from gl_vehmaster veh inner join gl_vehmodel model on veh.vmodid=model.doc_no where"+
				" veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 and model.brandid="+brandid+" group by model.doc_no";
		System.out.println("model====>"+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		JSONArray locdata=new JSONArray();
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("doc_no"));
			objtemp.put("model",rs.getString("model"));
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
