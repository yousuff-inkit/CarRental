<%@page import="com.common.ClsCommon"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String fleetlist=request.getParameter("fleetlist")==null?"0":request.getParameter("fleetlist");
String date=request.getParameter("date")==null?"0":request.getParameter("date");
System.out.println(fleetlist);

String [] fleetArray = fleetlist.split(",");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
	String dt=sdf.format(new java.util.Date());
	java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(date);
	JSONArray obarray=new JSONArray();
	
	for(int i=0;i<fleetArray.length;i++){
		String strgetacno="SELECT m.fleet_no fleetno,CASE WHEN MONTH(vmin.DATE)=MONTH('"+sqlDate+"') AND YEAR(vmin.DATE)=YEAR('"+sqlDate+"') AND tran_code<>'FS' THEN DAY('"+sqlDate+"')-DAY(vmin.date)+1 WHEN tran_code='FS' THEN DAY(vmax.date)-if(MONTH('"+sqlDate+"')=MONTH(vmin.date) and YEAR('"+sqlDate+"')=YEAR(vmin.date),DAY(vmin.date),DAY(DATE_FORMAT('"+sqlDate+"', '%Y-%m-01')))+1 ELSE DAY(LAST_DAY('"+sqlDate+"')) END AS days FROM gl_vehmaster m LEFT JOIN (SELECT MIN(din) `date`,fleet_no FROM gl_vmove WHERE fleet_no="+fleetArray[i]+") vmin ON vmin.fleet_no=m.fleet_no LEFT JOIN (SELECT MAX(`date`) `date`,fleet_no FROM gl_vmove WHERE fleet_no="+fleetArray[i]+") vmax ON vmax.fleet_no=m.fleet_no WHERE m.fleet_no="+fleetArray[i];

		System.out.println(strgetacno);
		ResultSet rsgetbranch=stmt.executeQuery(strgetacno);
		int cnt=0;
		while(rsgetbranch.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("fleetno",rsgetbranch.getString("fleetno"));
			objtemp.put("totaldays",rsgetbranch.getString("days"));
			obarray.add(objtemp);
		}
	}
   	objdata.put("obdata",obarray);
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