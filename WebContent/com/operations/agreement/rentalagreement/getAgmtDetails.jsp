<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtdocno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	int clstatus=0,chkinsurcomp=0,insurcompconfig=0;
	
	String strconfig="select method from gl_config where field_nme='RAGInsurComp'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		insurcompconfig=rsconfig.getInt("method");
	}
	
	if(insurcompconfig==1){
		String stragmt="select clstatus,chkinsurcomp from gl_ragmt where doc_no="+agmtdocno;
		ResultSet rsagmt=stmt.executeQuery(stragmt);
		while(rsagmt.next()){
			clstatus=rsagmt.getInt("clstatus");
			chkinsurcomp=rsagmt.getInt("chkinsurcomp");
		}
	}
	
	objdata.put("clstatus", clstatus);
	objdata.put("chkinsurcomp",chkinsurcomp);
	objdata.put("insurcompconfig",insurcompconfig);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
