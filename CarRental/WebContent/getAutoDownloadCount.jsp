<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
try{
	String curdownload=session.getAttribute("CURDOWNLOAD")==null?"":session.getAttribute("CURDOWNLOAD").toString();
	String salikdocno=session.getAttribute("SALIKDOCNO")==null?"":session.getAttribute("SALIKDOCNO").toString();
	String trafficdocno=session.getAttribute("TRAFFICDOCNO")==null?"":session.getAttribute("TRAFFICDOCNO").toString();
	
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	JSONArray salikarray=new JSONArray();
	JSONArray trafficarray=new JSONArray();
	if(!salikdocno.trim().equalsIgnoreCase("")){
		//String strsalikcount="select salik_user downloaduser,count(*) itemcount from gl_Salik where doc_no in ("+salikdocno+") and isallocated=0 group by salik_user";
		String strsalikcount="SELECT web.username downloaduser,COALESCE(sc.itemcount,0) itemcount FROM gl_webid web"+ 
		" LEFT JOIN (SELECT COUNT(*) itemcount,salik_user FROM gl_salik WHERE doc_no IN ("+salikdocno+") AND isallocated=0 GROUP BY salik_user) sc ON web.username=sc.salik_user"+
		" WHERE web.remarks='Salik'";
		//System.out.println(strsalikcount);
		ResultSet rssalik=stmt.executeQuery(strsalikcount);
		while(rssalik.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("user",rssalik.getString("downloaduser"));
			objtemp.put("itemcount",rssalik.getString("itemcount"));
			salikarray.add(objtemp);
		}
	}
	
	if(!trafficdocno.trim().equalsIgnoreCase("")){
		//String strtrafficcount="select tcno downloaduser,count(*) itemcount from gl_traffic where doc_no in ("+trafficdocno+") and isallocated=0 group by tcno";
		String strtrafficcount="SELECT web.username downloaduser,COALESCE(sc.itemcount,0) itemcount FROM gl_webid web"+ 
		" LEFT JOIN (SELECT COUNT(*) itemcount,tcno FROM gl_traffic WHERE doc_no IN ("+trafficdocno+") AND isallocated=0 GROUP BY tcno) sc ON web.tcno=sc.tcno"+
		" WHERE web.remarks='Traffic Fines'";
		//System.out.println(strtrafficcount);
		ResultSet rstraffic=stmt.executeQuery(strtrafficcount);
		while(rstraffic.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("user",rstraffic.getString("downloaduser"));
			objtemp.put("itemcount",rstraffic.getString("itemcount"));
			trafficarray.add(objtemp);
		}
	}
	
	objdata.put("salikdata",salikarray);
	objdata.put("trafficdata",trafficarray);
	objdata.put("curdownload",curdownload);
}
catch(Exception e){
	e.printStackTrace();
	objdata.put("errormsg", e.getMessage());
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>