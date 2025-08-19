<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%> 
<%@page import="com.connection.ClsConnection"%>
<%
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno").toString();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid"); 

Connection conn=null;
JSONArray gridarray=new JSONArray();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	String strsql="",sqltest="";
	//System.out.println("BRHID-->"+brhid);
	if((brhid.equalsIgnoreCase("null")) || (brhid.equalsIgnoreCase("")) || (brhid.equalsIgnoreCase("a")))
	{
sqltest="";
	}
	else
	{
		sqltest="and base.brhid='"+brhid+"'";

	}
	if(mode.equalsIgnoreCase("1")){
		strsql="select base.*,ac.refname,ac.acno le_clacno from ("+
		" select agmt.doc_no docno,agmt.voc_no vocno,agmt.brhid,if(expirydate is not null, expirydate,date_add(outdate, interval (case when per_name=1 then per_value*12 when per_name=2 then per_value else 0 end) month)) expdate,"+
		" agmt.cldocno,agmt.outdate,agmt.invtodate,ltf.rate,veh.reg_no regno,brd.brand_name brand,model.vtype model,veh.residual_val residualvalue"+
		" ,ext.srno extdocno,ext.reqremarks,ext.totalrent,ext.extno,ext.approvalstatus ,agmt.perfleet,CAST(date_format(ext.edate,'%d.%m.%Y')AS CHAR(50)) date1,date_format(ext.startdt,'%d.%m.%Y') startdt,date_format(ext.extdate,'%d.%m.%Y') extdate,ext.noofmonth,ext.bankacno,ext.residualval newresval,h.description bankname from gl_lagmt agmt"+
		" left join gl_ltarif ltf on agmt.doc_no=ltf.rdocno"+
		" left join gl_vehmaster veh on agmt.tmpfleet=veh.fleet_no or agmt.perfleet=veh.fleet_no"+
		" left join gl_vehbrand brd on veh.brdid=brd.doc_no"+
		" left join gl_vehmodel model on veh.vmodid=model.doc_no"+
		" left join gl_leaseext ext on ext.lano=agmt.doc_no  and approvalstatus!=1 "+
	    " left join my_head h on h.doc_no=ext.bankacno "+
		" where clstatus=0 and outdate is not null) base left join my_acbook ac on base.cldocno=ac.cldocno and ac.dtype='CRM' where base.expdate<=date_add(curdate() , interval 1 month) "+sqltest+" ";
		
	}
	else if(mode.equalsIgnoreCase("2") && !agmtno.equalsIgnoreCase("")){
		strsql="select srno detaildocno,date,amount,bpvno,chequeno from gl_leasepytcalcext where rdocno="+agmtno+" and status=3";
	}
	System.out.println("GridLoad=====>"+strsql);
	if(!strsql.equalsIgnoreCase("")){
		ResultSet rs=stmt.executeQuery(strsql);
		gridarray=objcommon.convertToJSON(rs);	
	}
	
		
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(gridarray+"");
%>