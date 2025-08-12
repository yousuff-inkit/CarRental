<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strclient="SELECT category,cl.doc_no,cl.codeno,refname,per_mob,sal_name,CONCAT(address,'  ',address2) AS address,mail1,vt.desc1 TYPE,trnnumber,cl.acno account,h.description accountgroup,cl.period creditperiodmin,cl.period2 creditperiodmax,cl.credit creditlimit FROM my_acbook CL LEFT JOIN my_clcatm cat ON cl.catid=cat.doc_no AND cat.dtype='VND' LEFT JOIN my_salesman s ON (cl.sal_id=s.doc_no) AND sal_type='SLA' LEFT JOIN my_vndtax vt ON vt.doc_no=cl.type LEFT JOIN my_head h ON h.doc_no=cl.acc_group WHERE cl.dtype='VND'";
	JSONArray vendorarray=new JSONArray();
	ResultSet rsclient=stmt.executeQuery(strclient);
	while(rsclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno", rsclient.getString("doc_no"));
		objtemp.put("refname", rsclient.getString("refname"));
		vendorarray.add(objtemp);
	}
	objdata.put("vendordata", vendorarray);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>