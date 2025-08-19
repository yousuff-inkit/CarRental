<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmenupath="select menu_name menuname,doc_type dtype,func path from my_menu where doc_type in ('LQT','LEC')";
	ResultSet rsgetmenupath=stmt.executeQuery(strgetmenupath);
	JSONArray menuarray=new JSONArray();
	while(rsgetmenupath.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("menuname", rsgetmenupath.getString("menuname"));
		objtemp.put("dtype",rsgetmenupath.getString("dtype"));
		objtemp.put("path",rsgetmenupath.getString("path"));
		String actionpath="";
		if(rsgetmenupath.getString("dtype").equalsIgnoreCase("LQT")){
			actionpath="com/operations/marketing/leasequotation/leaseQuotationView.action";
		}
		else if(rsgetmenupath.getString("dtype").equalsIgnoreCase("LEC")){
			actionpath="com/operations/marketing/leasecalculatoralfahim/leaseCalculatorAlFahimView.action";
		}
		objtemp.put("actionpath",actionpath);
		menuarray.add(objtemp);
	}
	objdata.put("menudata",menuarray);
	
	int leaseappdocno=0;
	int leasecalcdocno=0;
	String strleaseapp="select coalesce(agmt.larefdocno,0) appdocno,coalesce(app.refdocno,0) calcdocno from gl_lagmt agmt left join gl_leaseappm app on agmt.larefdocno=app.doc_no where agmt.doc_no="+docno;
	ResultSet rsleaseapp=stmt.executeQuery(strleaseapp);
	while(rsleaseapp.next()){
		leaseappdocno=rsleaseapp.getInt("appdocno");
		leasecalcdocno=rsleaseapp.getInt("calcdocno");
	}
	objdata.put("leaseappdocno",leaseappdocno);
	objdata.put("leasecalcdocno",leasecalcdocno);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>