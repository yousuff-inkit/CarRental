<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int insurcompconfig=0;
	String strsql="select method from gl_config where field_nme='RAGInsurComp'";
	ResultSet rsinsurcompconfig=stmt.executeQuery(strsql);
	while(rsinsurcompconfig.next()){
		insurcompconfig=rsinsurcompconfig.getInt("method");
	}
	JSONArray insurcomparray=new JSONArray();
	if(insurcompconfig==1){
		String strgetinsurcomp="SELECT ac.cldocno,ac.refname FROM my_acbook ac LEFT JOIN my_clcatm cat ON ac.catid=cat.doc_no WHERE"+ 
		" ac.dtype='CRM' AND ac.status=3 AND cat.insurance=1";
		ResultSet rsgetinsurcomp=stmt.executeQuery(strgetinsurcomp);
		while(rsgetinsurcomp.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("cldocno",rsgetinsurcomp.getString("cldocno"));
			objtemp.put("refname",rsgetinsurcomp.getString("refname"));
			insurcomparray.add(objtemp);
		}	
	}
	
	
	String strquarterly="select method from gl_config where field_nme='InvQuarterly'";
	ResultSet rsquarterly=stmt.executeQuery(strquarterly);
	int invQuarterly=0;
	while(rsquarterly.next()){
		invQuarterly=rsquarterly.getInt("method");
	}
	
	int lpoconfig=0;
	String strlpoconfig="select method from gl_config where field_nme='LPOValidate'";
	ResultSet rslpoconfig=stmt.executeQuery(strlpoconfig);
	while(rslpoconfig.next()){
		lpoconfig=rslpoconfig.getInt("method");
	}
	
	int actualclientconfig=0;
	String stractualclient="select method from gl_config where field_nme='RAGActualClient'";
	ResultSet rsactualclient=stmt.executeQuery(stractualclient);
	while(rsactualclient.next()) {
		actualclientconfig=rsactualclient.getInt("method");
	}
	
	JSONArray enqtypearray=new JSONArray();
	String strenqtype="SELECT doc_no docno,txtname refname FROM cm_enqsource WHERE STATUS=3";
	ResultSet rsenqtype=stmt.executeQuery(strenqtype);
	while(rsenqtype.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno", rsenqtype.getString("docno"));
		objtemp.put("refname", rsenqtype.getString("refname"));
		enqtypearray.add(objtemp);
	}
	
	int excessinsurconfig=0;
	String strexcessinsurconfig="select method from gl_config where field_nme='RAExcessInsur'";
	ResultSet rsexcessinsurconfig=stmt.executeQuery(strexcessinsurconfig);
	while(rsexcessinsurconfig.next()){
		excessinsurconfig=rsexcessinsurconfig.getInt("method");
	}
	objdata.put("enqtypedata",enqtypearray);
	objdata.put("LPOValidate",lpoconfig);
	objdata.put("InvQuarterly",invQuarterly);
	objdata.put("insurcomparray",insurcomparray);
	objdata.put("RAGInsurComp",insurcompconfig);
	objdata.put("RAGInsurExcess",excessinsurconfig);
	
	objdata.put("actualclientconfig",actualclientconfig);
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
