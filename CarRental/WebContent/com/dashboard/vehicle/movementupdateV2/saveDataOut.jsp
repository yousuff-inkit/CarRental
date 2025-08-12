<%@page import="com.dashboard.vehicle.movementupdate.ClsMovementUpdateDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").trim();
String outdate=request.getParameter("outdate")==null?"":request.getParameter("outdate").trim();
String outtime=request.getParameter("outtime")==null?"":request.getParameter("outtime").trim();
String outkm=request.getParameter("outkm")==null?"":request.getParameter("outkm").trim();
String outfuel=request.getParameter("outfuel")==null?"":request.getParameter("outfuel").trim();
String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno").trim();
String rdocno=request.getParameter("rdocno")==null?"":request.getParameter("rdocno").trim();
String rdtype=request.getParameter("rdtype")==null?"":request.getParameter("rdtype").trim();

JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsMovementUpdateDAO updatedao=new ClsMovementUpdateDAO();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String branchval=session.getAttribute("BRANCHID").toString();
	java.sql.Date sqloutdate=null;
	if(!outdate.equalsIgnoreCase("")){
		sqloutdate=objcommon.changeStringtoSqlDate(outdate);
	}
	
	Statement stmt=conn.createStatement();
	java.sql.Date sqloldoutdate=null;
	String oldouttime="",oldoutfuel="";
	double oldoutkm=0.0;
	int repno=0;
	String movstatus="",movtrancode="";
	String strgetmovdata="select repno,trancode,dout,tout,kmout,fout,status from gl_vmove where doc_no="+movdocno;
	ResultSet rsgetmovdata=stmt.executeQuery(strgetmovdata);
	while(rsgetmovdata.next()){
		movstatus=rsgetmovdata.getString("status");
		movtrancode=rsgetmovdata.getString("trancode");
		repno=rsgetmovdata.getInt("repno");
		
		sqloldoutdate=rsgetmovdata.getDate("dout");
		oldouttime=rsgetmovdata.getString("tout").trim();
		oldoutkm=rsgetmovdata.getDouble("kmout");
		oldoutfuel=rsgetmovdata.getString("fout").trim();
	}
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String strloginsert="insert into gl_movupdatelog(movdocno ,userid ,logged ,rdtype,rdocno ,oldoutdate ,oldouttime ,oldoutkm ,oldoutfuel,newoutdate,newouttime ,newoutkm ,newoutfuel) values("+movdocno+","+userid+",now(),'"+rdtype+"',"+rdocno+",'"+sqloldoutdate+"','"+oldouttime+"',"+oldoutkm+","+oldoutfuel+",'"+sqloutdate+"','"+outtime+"',"+outkm+","+outfuel+")";
	int loginsert=stmt.executeUpdate(strloginsert);
	if(loginsert<=0){
		errorstatus=1;
	}
	CallableStatement	movement = conn.prepareCall("{CALL moveUpdateDML(?,?,?,?,?,?,?,?,?,?,?)}");
	movement.setString(1,fleetno);
	movement.setDate(2,sqloutdate);
	movement.setString(3,outtime);
	movement.setString(4,outkm);
	movement.setString(5,outfuel);
	movement.setDate(6,null);
	movement.setString(7,"");
	movement.setString(8,"");
	movement.setString(9,"");
	movement.setString(10,"OUT");
	movement.setString(11,movdocno);
	System.out.println("----movement----"+movement);
	int res=movement.executeUpdate();    
	if(res<=0){
		errorstatus=1;
	}
	
	if(repno>0){
		boolean replacestatus=updatedao.updateReplacement(repno,conn,movdocno,movstatus,movtrancode);
		if(replacestatus==false){
			errorstatus=1;
		}
	}
	
	if(res>0){
		Statement stmt1=conn.createStatement();
		String sqlsave="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+movdocno+",1,'BVMU',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		int logvalue=stmt1.executeUpdate(sqlsave);
		if(logvalue<=0){
			errorstatus=1;
		}
	} 
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");

%>