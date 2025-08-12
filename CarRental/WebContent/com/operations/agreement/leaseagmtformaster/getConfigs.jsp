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
	int invQuarterly=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='InvQuarterly'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		invQuarterly=rs.getInt("method");
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
	
	objdata.put("enqtypedata",enqtypearray);
	objdata.put("InvQuarterly",invQuarterly);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>