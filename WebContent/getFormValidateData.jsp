<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
String dtype=request.getParameter("formcode")==null?"":request.getParameter("formcode");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	JSONArray masterarray=new JSONArray();
	
	//Checking Tables Exist
	String tblmaster="",tbldet="";
	String strcheckmaster="show tables like '%my_validatem%'";
	ResultSet rscheckmaster=stmt.executeQuery(strcheckmaster);
	while(rscheckmaster.next()){
		tblmaster=rscheckmaster.getString(1);
	}
	
	String strcheckdet="show tables like '%my_validated%'";
	ResultSet rscheckdet=stmt.executeQuery(strcheckdet);
	while(rscheckdet.next()){
		tbldet=rscheckdet.getString(1);
	}
	
	if(tblmaster.trim().equalsIgnoreCase("my_validatem") && tbldet.trim().equalsIgnoreCase("my_validated")){
		String strmaster="SELECT dtype,fieldid,fieldtype,validtypeid,label,tabindex FROM my_validatem WHERE STATUS=3 AND dtype='"+dtype+"' order by seqno";
		ResultSet rsmaster=stmt.executeQuery(strmaster);
		while(rsmaster.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("dtype", rsmaster.getString("dtype"));
			objtemp.put("fieldid", rsmaster.getString("fieldid"));
			objtemp.put("fieldtype", rsmaster.getString("fieldtype"));
			objtemp.put("validtypeid", rsmaster.getString("validtypeid"));
			objtemp.put("label", rsmaster.getString("label"));
			objtemp.put("tabindex", rsmaster.getString("tabindex"));
			masterarray.add(objtemp);
		}
		
		for(int i=0;i<masterarray.size();i++){
			JSONObject item=masterarray.getJSONObject(i);
			JSONArray detarray=new JSONArray();
			
			String validtypeid=item.getString("validtypeid");
			
			String strdet="SELECT validtype,COALESCE(VALUE,0) VALUE,msg FROM my_validated WHERE doc_no IN ("+validtypeid+") AND STATUS=3";
			ResultSet rsdet=stmt.executeQuery(strdet);
			while(rsdet.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("validtype", rsdet.getString("validtype"));
				objtemp.put("value", rsdet.getString("value"));
				objtemp.put("msg", rsdet.getString("msg"));
				detarray.add(objtemp);
			}
			
			item.put("detdata", detarray);
		}
	}
	
	
	objdata.put("validatedata", masterarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>