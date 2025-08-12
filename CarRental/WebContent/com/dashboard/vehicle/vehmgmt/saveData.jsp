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
int errorstatus=0;

JSONObject objdata=new JSONObject();

ClsConnection ClsConnection=new ClsConnection();

ClsCommon objcommon=new ClsCommon();

Connection conn=ClsConnection.getMyConnection();
try{

	Statement stmt = conn.createStatement ();
	
	String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	String time=request.getParameter("time")==null?"":request.getParameter("time");
	String status=request.getParameter("status")==null?"":request.getParameter("status");
	String savecode=request.getParameter("savecode")==null?"":request.getParameter("savecode");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String trancode=request.getParameter("trancode")==null?"":request.getParameter("trancode");
	String reason=request.getParameter("reason")==null?"":request.getParameter("reason");
	
	String inscompany=request.getParameter("inscompany")==null?"":request.getParameter("inscompany");
	String instype=request.getParameter("instype")==null?"":request.getParameter("instype");
	String insdate=request.getParameter("insdate")==null?"":request.getParameter("insdate");
	String policyno=request.getParameter("policyno")==null?"":request.getParameter("policyno");
	String insremarks=request.getParameter("insremarks")==null?"":request.getParameter("insremarks");
	String insexpdate=request.getParameter("insexpdate")==null?"":request.getParameter("insexpdate");
	
	String regremarks=request.getParameter("regremarks")==null?"":request.getParameter("regremarks");
	String regdate=request.getParameter("regdate")==null?"":request.getParameter("regdate");
	String regsexpdate=request.getParameter("regsexpdate")==null?"":request.getParameter("regsexpdate");
	
	
	
	String reldate=request.getParameter("reldate")==null?"":request.getParameter("reldate");
	String reltime=request.getParameter("reltime")==null?"":request.getParameter("reltime");
	String rentsts=request.getParameter("rentsts")==null?"":request.getParameter("rentsts");
	String relkm=request.getParameter("relkm")==null?"":request.getParameter("relkm");
	String relfuel=request.getParameter("relfuel")==null?"":request.getParameter("relfuel");
	String relloc=request.getParameter("relloc")==null?"":request.getParameter("relloc");
	String relbrch=request.getParameter("relbrch")==null?"":request.getParameter("relbrch");
	String doc_no=request.getParameter("doc_no")==null?"":request.getParameter("doc_no");
	
	
	int insert=0;
		
	if(savecode.equalsIgnoreCase("VSC")){
		ClsFleetStatusChangeDAO dao=new ClsFleetStatusChangeDAO();
		java.sql.Date sqlbasedate=null;
		if(!date.equalsIgnoreCase("")){
			sqlbasedate=objcommon.changeStringtoSqlDate(date);
		}
		insert=dao.insert(sqlbasedate, time, Integer.parseInt(fleetno), trancode, status, reason, session, "A", "VSC", brhid);
		if(insert<=0){
			errorstatus=1;
		}
	}else if(savecode.equalsIgnoreCase("TBR")){
		
		ClsVehicleDAO daos=new ClsVehicleDAO();
		
		java.sql.Date sqlreldate=null;
		if(!reldate.equalsIgnoreCase("")){
			sqlreldate=objcommon.changeStringtoSqlDate(reldate);
		}
		insert=daos.release(Integer.parseInt(fleetno),relbrch,relloc,Integer.parseInt(relkm),relfuel,Integer.parseInt(doc_no),session,"R",rentsts,sqlreldate,reltime); 
		//System.out.println(Integer.parseInt(fleetno)+"==="+relbrch+"==="+relloc+"==="+relkm+"==="+relfuel+"==="+Integer.parseInt(doc_no)+"==="+rentsts+"==="+sqlreldate+"==="+reltime); 
		
				if(insert<=0){
			errorstatus=1;
		}
	}
	else if(savecode.equalsIgnoreCase("RS")){
		
	String sqllimo="";
		if(status.equalsIgnoreCase("LM")){
			sqllimo+=",limostatus=1";
		}
		
	    String upsql="update gl_vehmaster set renttype='"+status+"'"+sqllimo+"  where fleet_no='"+fleetno+"' ";
	    insert=stmt.executeUpdate(upsql);
	    //System.out.println("RS update query---------"+upsql);
	    if(insert<=0){
			errorstatus=1;
		}
			
		}
	
	
	else if(savecode.equalsIgnoreCase("EXP")){
		
		int docval=0;
		
if(!(regdate.equalsIgnoreCase(""))){
	
	
	java.sql.Date sqlregsexpdate=null;
	if(!regsexpdate.equalsIgnoreCase("")){
		sqlregsexpdate=objcommon.changeStringtoSqlDate(regsexpdate);
	}
	
	java.sql.Date sqlregdate=null;
	if(!regdate.equalsIgnoreCase("")){
		sqlregdate=objcommon.changeStringtoSqlDate(regdate);
	}
	
	String upsql="update gl_vehmaster set reg_exp='"+sqlregdate+"'  where fleet_no='"+fleetno+"' ";
	insert=stmt.executeUpdate(upsql);
   // System.out.println("Exp reg query---------"+upsql);
    
    String upsqlss="select coalesce(max(doc_no)+1,1) doc_no from gl_vregexp";
	   ResultSet resultSet = stmt.executeQuery(upsqlss);
	   
	    if (resultSet.next()) {
	    	docval=resultSet.getInt("doc_no");
	    }
		  
		upsql="insert into gl_vregexp (doc_no,fleetno, expirydt, renewdt, remarks)values('"+docval+"','"+fleetno+"','"+sqlregsexpdate+"','"+sqlregdate+"', '"+regremarks+"') ";
		 insert= stmt.executeUpdate(upsql);
	 
     upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docval+",'"+brhid+"','BVRG',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 int aaa= stmt.executeUpdate(upsql);
   
}

if(!(insdate.equalsIgnoreCase(""))){
	
	java.sql.Date sqlinsdate=null;
	if(!insdate.equalsIgnoreCase("")){
		sqlinsdate=objcommon.changeStringtoSqlDate(insdate);
	}
	
	java.sql.Date sqlinsexpdate=null;
	if(!insexpdate.equalsIgnoreCase("")){
		sqlinsexpdate=objcommon.changeStringtoSqlDate(insexpdate);
	}
	
	 String upsql="update gl_vehmaster set pno='"+policyno+"',ins_comp='"+inscompany+"',ins_exp='"+sqlinsdate+"',itype='"+instype+"' where fleet_no='"+fleetno+"' ";
	    insert=stmt.executeUpdate(upsql);
	   // System.out.println("Exp ins query---------"+upsql);
	    
	    String upsqlss="select coalesce(max(doc_no)+1,1) doc_no from gl_vinsexp";
		   ResultSet resultSet = stmt.executeQuery(upsqlss);
		   
		    if (resultSet.next()) {
		    	docval=resultSet.getInt("doc_no");
		    }	 
	
	upsql="insert into gl_vinsexp (doc_no,fleetno, expirydt, renewdt, remarks)values('"+docval+"','"+fleetno+"','"+sqlinsexpdate+"','"+sqlinsdate+"', '"+insremarks+"') ";
	
	 insert= stmt.executeUpdate(upsql);
	 
	 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docval+",'"+brhid+"','BVIS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 
	 int aaa= stmt.executeUpdate(upsql);
	
}
	   
		    if(insert<=0){
				errorstatus=1;
			}
				
			}
	}
	


catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
//System.out.println("errorstatus----"+errorstatus+"--------"+"objdata-----"+objdata);
%>