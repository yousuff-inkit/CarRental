<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
 

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
/* 	JSONArray vehcountarray=new JSONArray();
	String strvehcount="SELECT COUNT(*) itemcount,st.status,st.st_desc refname  FROM gl_vehmaster veh LEFT JOIN gl_status st ON veh.TRAN_CODE=st.STATUS WHERE veh.STATU=3 AND veh.fstatus<>'Z' GROUP BY tran_code";
	System.out.println("Count-----"+strvehcount);
	ResultSet rsvehcount=stmt.executeQuery(strvehcount);
	while(rsvehcount.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("itemcount", rsvehcount.getString("itemcount"));
		objtemp.put("status", rsvehcount.getString("status"));
		objtemp.put("refname", rsvehcount.getString("refname"));
		vehcountarray.add(objtemp);
	} */
	
	JSONArray brancharray=new JSONArray();
	/*String strbranch="SELECT doc_no docno,branchname refname  FROM my_brch WHERE STATUS=3";
	ResultSet rsbranch=stmt.executeQuery(strbranch);
	while(rsbranch.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsbranch.getString("docno"));
		objtemp.put("refname", rsbranch.getString("refname"));
		brancharray.add(objtemp);
	}*/
	
	String strgetbranch=" select b.branchname refname,b.doc_no docno,u.permission from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
	+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
	+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";
	ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
	int cnt=0;
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();
		 if(cnt==0 && rsgetbranch.getString("permission").equalsIgnoreCase("0")){
			objtemp.put("refname","All");
			objtemp.put("docno","0");
			brancharray.add(objtemp);
			cnt=1;
		} 
		objtemp=new JSONObject();
		objtemp.put("refname",rsgetbranch.getString("refname"));
		objtemp.put("docno",rsgetbranch.getString("docno"));
		brancharray.add(objtemp);
	}
	JSONArray vehstatusarray=new JSONArray();
	String strvehstatus="select status docno,st_desc refname from gl_status where statu=1";
	ResultSet rsvehstatus=stmt.executeQuery(strvehstatus);
	while(rsvehstatus.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsvehstatus.getString("docno"));
		objtemp.put("refname", rsvehstatus.getString("refname"));
		vehstatusarray.add(objtemp);
	}
	
	
	JSONArray inscompanyarray=new JSONArray();
	String inscmpystatus="select inname refname,doc_no docno from gl_vehin  where status<>7";
//System.out.println("inscompny------"+inscmpystatus);
	ResultSet rsinscmpystatus=stmt.executeQuery(inscmpystatus);
	while(rsinscmpystatus.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsinscmpystatus.getString("docno"));
		objtemp.put("refname", rsinscmpystatus.getString("refname"));
		inscompanyarray.add(objtemp);
	}
	
	JSONArray tbrbrancharray=new JSONArray();
	String tbrbranch = "select branchname refname,doc_no docno from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'";
	//System.out.println("tbrbranch------"+tbrbranch);
	ResultSet rstbrbranch=stmt.executeQuery(tbrbranch);
	while(rstbrbranch.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rstbrbranch.getString("docno"));
		objtemp.put("refname", rstbrbranch.getString("refname"));
		tbrbrancharray.add(objtemp);
	}
	
	
	
	objdata.put("statuschangedata", vehstatusarray);
	objdata.put("branchdata", brancharray);
	//objdata.put("vehcountdata", vehcountarray);
	objdata.put("inscompanydata", inscompanyarray);
	objdata.put("tbrbranchdata", tbrbrancharray);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
response.getWriter().write(objdata+"");
//System.out.println("objdata------"+objdata);
%>