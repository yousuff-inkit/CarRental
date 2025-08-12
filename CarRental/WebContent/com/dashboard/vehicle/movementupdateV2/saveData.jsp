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
String indate=request.getParameter("indate")==null?"":request.getParameter("indate").trim();
String intime=request.getParameter("intime")==null?"":request.getParameter("intime").trim();
String inkm=request.getParameter("inkm")==null?"":request.getParameter("inkm").trim();
String infuel=request.getParameter("infuel")==null?"":request.getParameter("infuel").trim();
String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno").trim();
String rdocno=request.getParameter("rdocno")==null?"":request.getParameter("rdocno").trim();
String rdtype=request.getParameter("rdtype")==null?"":request.getParameter("rdtype").trim();

JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqloutdate=null,sqlindate=null;
	if(!outdate.equalsIgnoreCase("") && !outdate.equalsIgnoreCase("undefined")){
		sqloutdate=objcommon.changeStringtoSqlDate(outdate);
	}
	if(!indate.equalsIgnoreCase("") && !indate.equalsIgnoreCase("undefined")){
		sqlindate=objcommon.changeStringtoSqlDate(indate);
	}
	int repno=0;
	String movtrancode="",movstatus="";
	java.sql.Date sqloldoutdate=null,sqloldindate=null;
	String oldouttime="",oldintime="",oldoutfuel="",oldinfuel="";
	double oldoutkm=0.0,oldinkm=0.0;
	String strgetmovdata="select repno,status,trancode,dout,tout,kmout,fout,din,tin,kmin,fin from gl_vmove where doc_no="+movdocno;
	ResultSet rsgetmovdata=stmt.executeQuery(strgetmovdata);
	while(rsgetmovdata.next()){
		repno=rsgetmovdata.getInt("repno");
		movtrancode=rsgetmovdata.getString("trancode").trim();
		movstatus=rsgetmovdata.getString("status").trim();
		sqloldoutdate=rsgetmovdata.getDate("dout");
		oldouttime=rsgetmovdata.getString("tout").trim();
		oldoutkm=rsgetmovdata.getDouble("kmout");
		oldoutfuel=rsgetmovdata.getString("fout").trim();
		sqloldindate=rsgetmovdata.getDate("din");
		oldintime=rsgetmovdata.getString("tin").trim();
		oldinkm=rsgetmovdata.getDouble("kmin");
		oldinfuel=rsgetmovdata.getString("fin").trim();
	}
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String strloginsert="insert into gl_movupdatelog(movdocno ,userid ,logged ,rdtype,rdocno ,oldoutdate ,oldouttime ,oldoutkm ,oldoutfuel ,oldindate,oldintime,oldinkm ,oldinfuel ,newoutdate,newouttime ,newoutkm ,newoutfuel ,newindate ,newintime,newinkm ,newinfuel ) values("+movdocno+","+userid+",now(),'"+rdtype+"',"+rdocno+",'"+sqloldoutdate+"','"+oldouttime+"',"+oldoutkm+","+oldoutfuel+",'"+sqloldindate+"','"+oldintime+"',"+oldinkm+","+oldinfuel+",'"+sqloutdate+"','"+outtime+"',"+outkm+","+outfuel+",'"+sqlindate+"','"+intime+"',"+inkm+","+infuel+")";
	int loginsert=stmt.executeUpdate(strloginsert);
	if(loginsert<=0){
		errorstatus=1;
	}
	/* String strgetlastkm="select inkm from gl_vmove where doc_no=(select parent from gl_vmove where doc_no="+movdocno+")";
	double lastinkm=0.0;
	ResultSet rslastkm=stmt.executeQuery(strgetlastkm);
	while(rslastkm.next()){
		lastinkm=rslastkm.getDouble("inkm");
	} */
	String strgettotal="select TIMESTAMPDIFF(minute, '"+sqloutdate+" "+outtime+"', '"+sqloutdate+" "+outtime+"') AS totaltime, "+inkm+"-"+outkm+" totalkm,"+infuel+"-"+outfuel+" totalfuel";
	System.out.println(strgettotal);
	ResultSet rsgettotal=stmt.executeQuery(strgettotal);
	double totaltime=0.0,totalkm=0.0,totalfuel=0.0;
	while(rsgettotal.next()){
		totalkm=rsgettotal.getDouble("totalkm");
		totaltime=rsgettotal.getDouble("totaltime");
		totalfuel=rsgettotal.getDouble("totalfuel");
	}
	String strmovupdate="update gl_vmove set dout='"+sqloutdate+"',tout='"+outtime+"',kmout="+outkm+",fout="+outfuel+",din='"+sqlindate+"',tin='"+intime+"',kmin="+inkm+",fin="+infuel+",ttime="+totaltime+",tkm="+totalkm+",tfuel="+totalfuel+" where doc_no="+movdocno;
	System.out.println(strmovupdate);
	int movupdate=stmt.executeUpdate(strmovupdate);
	if(movupdate<=0){
		errorstatus=1;
		System.out.println("Mov Update Error");
		System.out.println(strmovupdate);
	}
	
	if(rdtype.equalsIgnoreCase("RAG") || rdtype.equalsIgnoreCase("LAG")){
		//Getting the last row corresponding to rdocno,rdtype
		int maxrdocno=0;
		String strmaxrdocno="select max(doc_no) maxrdocno from gl_vmove where rdocno="+rdocno+" and rdtype='"+rdtype+"'";
		ResultSet rsmaxrdocno=stmt.executeQuery(strmaxrdocno);
		while(rsmaxrdocno.next()){
			maxrdocno=rsmaxrdocno.getInt("maxrdocno");
		}
		System.out.println(movdocno+"::"+maxrdocno);
		//Checking Agreement is Closed
		
		String strgetclose="";
		if(rdtype.equalsIgnoreCase("RAG")){
			strgetclose="select clstatus from gl_ragmt where doc_no="+rdocno;
		}
		else if(rdtype.equalsIgnoreCase("LAG")){
			strgetclose="select clstatus from gl_lagmt where doc_no="+rdocno;
		}
		System.out.println(strgetclose);
		ResultSet rsgetclose=stmt.executeQuery(strgetclose);
		int clstatus=0;
		while(rsgetclose.next()){
			clstatus=rsgetclose.getInt("clstatus");
		}
		
		if(clstatus==1){
			//Checking if Agreement has collection
			String strgetcollect="";
			if(rdtype.equalsIgnoreCase("RAG")){
				strgetcollect="select colstatus from gl_ragmtclosem where agmtno="+rdocno;
			}
			else if(rdtype.equalsIgnoreCase("LAG")){
				strgetcollect="select colstatus from gl_lagmtclosem where agmtno="+rdocno;
			}
			System.out.println(strgetcollect);
			int collectstatus=0;
			ResultSet rsgetcollect=stmt.executeQuery(strgetcollect);
			while(rsgetcollect.next()){
				collectstatus=rsgetcollect.getInt("colstatus");
			}
			if(Integer.parseInt(movdocno)==maxrdocno){
				//Agreement Closed and Last Row is selected
				String strupdateagmtclose="";
				if(collectstatus==1){
					//Updating Collection and In Details
					if(rdtype.equalsIgnoreCase("RAG")){
						strupdateagmtclose="update gl_ragmtclosem set colkm="+outkm+",colfuel="+outfuel+",coltime='"+outtime+"',coldate='"+sqloutdate+"',inkm="+inkm+",infuel="+infuel+",intime='"+intime+"',indate='"+sqlindate+"' where agmtno="+rdocno;
					}
					else if(rdtype.equalsIgnoreCase("LAG")){
						strupdateagmtclose="update gl_lagmtclosem set colkm="+outkm+",colfuel="+outfuel+",coltime='"+outtime+"',coldate='"+sqloutdate+"',inkm="+inkm+",infuel="+infuel+",intime='"+intime+"',indate='"+sqlindate+"' where agmtno="+rdocno;
					}
				}
				else{
					if(rdtype.equalsIgnoreCase("RAG")){
						strupdateagmtclose="update gl_ragmtclosem set inkm="+inkm+",infuel="+infuel+",intime='"+intime+"',indate='"+sqlindate+"' where agmtno="+rdocno;
					}
					else if(rdtype.equalsIgnoreCase("LAG")){
						strupdateagmtclose="update gl_lagmtclosem set inkm="+inkm+",infuel="+infuel+",intime='"+intime+"',indate='"+sqlindate+"' where agmtno="+rdocno;
					}
				}
				
				int updateagmtclose=stmt.executeUpdate(strupdateagmtclose);
				if(updateagmtclose<0){
					errorstatus=1;
				}
			}
		}
		else if(clstatus==0){
			int deldocno=0;
			String deltrancode="";
			String strdeldocno="select min(doc_no) deldocno from gl_vmove where rdocno="+rdocno+" and rdtype='"+rdtype+"'";
			ResultSet rsdeldocno=stmt.executeQuery(strdeldocno);
			while(rsdeldocno.next()){
				
				deldocno=rsdeldocno.getInt("deldocno");
			}
			String strdeltrancode="select trancode from gl_vmove where doc_no="+deldocno;
			ResultSet rsdeltrancode=stmt.executeQuery(strdeltrancode);
			while(rsdeltrancode.next()){
				deltrancode=rsdeltrancode.getString("trancode");
			}
			if(deldocno==Integer.parseInt(movdocno) && deltrancode.trim().equalsIgnoreCase("DL")){
				//Updating Agreement Delivery Details
				if(rdtype.trim().equalsIgnoreCase("RAG")){
					String strupdate="update gl_ragmt set odate='"+sqloutdate+"',otime='"+outtime+"',okm="+outkm+",ofuel="+outfuel+" where doc_no="+rdocno+" and status=3";
					int agmtupdate=stmt.executeUpdate(strupdate);
					if(agmtupdate<=0){
						errorstatus=1;
					}
				}
				else if(rdtype.trim().equalsIgnoreCase("LAG")){
					String strupdate="update gl_lagmt set outdate='"+sqloutdate+"',outtime='"+outtime+"',outkm="+outkm+",outfuel="+outfuel+" where doc_no="+rdocno+" and status=3";
					int agmtupdate=stmt.executeUpdate(strupdate);
					if(agmtupdate<=0){
						errorstatus=1;
					}
				}
			}
		}
	}
	
	ClsMovementUpdateDAO updatedao=new ClsMovementUpdateDAO();
	if(repno>0){
		boolean replacestatus=updatedao.updateReplacement(repno,conn,movdocno,movstatus,movtrancode);
		if(replacestatus==false){
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