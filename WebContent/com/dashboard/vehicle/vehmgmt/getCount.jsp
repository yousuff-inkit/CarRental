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
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");


 
try{

	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	JSONArray vehcountarray=new JSONArray();
	String sqlfilters="";
	if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")) {
		sqlfilters+=" and a_br='"+brhid+"' ";
	}
	String strvehcount="SELECT COUNT(*) itemcount,st.status,st.st_desc refname  FROM gl_vehmaster veh LEFT JOIN gl_status st ON veh.TRAN_CODE=st.STATUS WHERE veh.STATU=3 AND veh.fstatus<>'Z' "+sqlfilters+" GROUP BY tran_code";
	//System.out.println("Count-----"+strvehcount);
	ResultSet rsvehcount=stmt.executeQuery(strvehcount);
	while(rsvehcount.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("itemcount", rsvehcount.getString("itemcount"));
		objtemp.put("status", rsvehcount.getString("status"));
		objtemp.put("refname", rsvehcount.getString("refname"));
		vehcountarray.add(objtemp);
	}
	
	
	objdata.put("vehcountdata", vehcountarray);
	
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