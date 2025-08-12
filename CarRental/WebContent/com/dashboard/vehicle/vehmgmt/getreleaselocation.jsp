<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.saleofvehicle.vehiclestatuschange.ClsFleetStatusChangeDAO"%>
<%@page import="com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleDAO"%>
<%@page import="com.common.*"%>
<%	
Connection conn=null;
JSONObject objdata=new JSONObject();
String brch=request.getParameter("brch")==null?"":request.getParameter("brch");

 
try{

	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	JSONArray vehcountarray=new JSONArray();
	String sqlfilters="";
	if(!brch.equalsIgnoreCase("") && !brch.equalsIgnoreCase("0") && !brch.equalsIgnoreCase("a")) {
		sqlfilters+=" and brhid='"+brch+"' ";
	}
	JSONArray tbrlocarray=new JSONArray();
	String tbrloc = "select loc_name refname,doc_no docno from my_locm where status<>7 "+sqlfilters+" ";
	//System.out.println("tbrloc------"+tbrloc);
	ResultSet rstbrloc=stmt.executeQuery(tbrloc);
	while(rstbrloc.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rstbrloc.getString("docno"));
		objtemp.put("refname", rstbrloc.getString("refname"));
		tbrlocarray.add(objtemp);
	}
	objdata.put("tbrlocdata", tbrlocarray);
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