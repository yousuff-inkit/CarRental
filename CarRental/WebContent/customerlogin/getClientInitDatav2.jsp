x<%@page import="com.dashboard.ClsDashBoardNewDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
JSONObject objrenewal=new JSONObject();
JSONObject objinsurtype=new JSONObject();
JSONObject objcontactperson=new JSONObject();
JSONObject objpolicyno=new JSONObject();
JSONObject objchartdata=new JSONObject();
JSONObject objlivefleets=new JSONObject();
ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO();
String refname="",mobile="",email="",acno="",pdcinhand="",subreciept="",accsum="",invoicelst="",docexp="",atchmt="";
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientacno=request.getParameter("clientacno")==null?"":request.getParameter("clientacno");
//currentDateMinus6Months

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	 
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("") && todate!=null){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	java.sql.Date sqldate=null;
	java.sql.Date currentDate=null;
	java.sql.Date currentDateMinus6Months=null;
	//String cldocno=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();

	
	 //LocalDate currentDate =sqltodate.toLocalDate();
     //LocalDate currentDateMinus6Months = currentDate.minusMonths(6);
    
	String strsql="select date_sub(curdate(),interval 6 month) lastsixmonthdate,curdate() sqldate,coalesce(refname,'') refname,coalesce(per_mob,'') mobile,coalesce(mail1,'') email,acno from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		refname=rs.getString("refname");
		mobile=rs.getString("mobile");
		email=rs.getString("email");
		acno=rs.getString("acno");
		sqldate=rs.getDate("sqldate");
		currentDateMinus6Months=rs.getDate("lastsixmonthdate");
		currentDate=rs.getDate("sqldate");
	}
	 
 String strgetcarddata = "select(select format(coalesce(sum(round(a.ldramount,2)),0),2) from(select b.*,coalesce(format(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,CASE WHEN a.transType in ('INV','INS','INT') THEN m.voc_no WHEN a.transType in ('VPU') THEN vp.voc_no WHEN a.transType in ('VPD') THEN vd.voc_no WHEN a.transType in ('NPA') THEN np.voc_no WHEN a.transType in ('VSI') THEN vs.voc_no ELSE a.transno END AS 'transno',b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between '"+currentDateMinus6Months+"' and  '"+sqltodate+"' and trtype!=1  and t.acno= "+acno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+currentDateMinus6Months+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+currentDateMinus6Months+"' and t.dtype='OPN') or (t.date< '"+currentDateMinus6Months+"'))  and t.acno= "+acno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid  left join gl_invm m on (a.transno=m.doc_no and a.brhid=m.brhid and a.transType in ('INV','INS','INT'))  left join gl_vpurm vp on (a.transno=vp.doc_no and a.brhid=vp.brhid and a.transType in ('VPU'))  left join gl_vpurdirm vd on (a.transno=vd.doc_no and a.brhid=vd.brhid and a.transType in ('VPD'))  left join gl_nonpoolveh np on (a.transno=np.doc_no and a.transType in ('NPA'))  left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and a.transType in ('VSI')) order by trdate,TRANSNO) b,(select @i:=0) as i)a)accsum, "
				+ "	(select format(coalesce(sum(a.total),0),2) from(select sum(d.total) total from gl_invm m  inner join gl_invd d on m.doc_no=d.rdocno where doc_no = (select max(doc_no) from gl_invm  where status=3  and acno='"+acno+"'))a)invoicelst,  "
		        + " (select coalesce(count(*),0) from(select sm.sal_name,aa.document,aa.expirydate,aa.dr_id sr_no,aa.cldocno,aa.name,ac.refname refname,ac.per_mob,ac.brhid,aa.visa_exp,CONVERT(aa.fdate,CHAR(100)) followupdate,CONVERT(concat(' Client : ',coalesce(ac.refname,' '), ' * ','Ref. Detail  : ',coalesce(aa.name,' '),' * ','Mobile No. : ' ,coalesce(ac.per_mob,' '),' * ','Document : ', coalesce(aa.document,' '),' * ','Expiry Date : ', DATE_FORMAT(coalesce(aa.expirydate,' '),'%d-%m-%Y')),CHAR(1000)) clientinfo from  (select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,d.led visa_exp  from gl_drdetails d    left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.led <='"+sqltodate+"'   union  select  coalesce(bb.fdate,'') fdate,'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,d.pass_exp  from gl_drdetails d    left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.pass_exp <='"+sqltodate+"'   union select  coalesce(bb.fdate,'') fdate,'ID Expired' document,d.visa_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,d.visa_exp  from gl_drdetails d  left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.visa_exp <= '"+sqltodate+"'    union   select coalesce(bb.fdate,'') fdate,'Trade Licence Expired' document,b.contract_upto expirydate,0 sr_no,b.cldocno,coalesce(b.contractno,'') name,b.contract_upto  from my_acbook b left join gl_drdetails d on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,cldocno from gl_bcde group by cldocno) a on a.cldocno=b.cldocno left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and b.dtype='crm'  and b.contract_upto <= '"+sqltodate+"') aa  left join my_acbook ac on ac.cldocno=aa.cldocno and ac.dtype='crm' left join my_salm sm on sm.doc_no=ac.sal_id  left join gl_lagmt la on ac.cldocno=la.cldocno and la.clstatus=0  left join gl_ragmt ra on ac.cldocno=ra.cldocno and ra.clstatus=0 left join gl_rdriver rd on (ra.doc_no=rd.rdocno and  aa.dr_id=rd.drid)  and rd.status=3  left join gl_ldriver ld on (la.doc_no=ld.rdocno and aa.dr_id=ld.drid and ld.status=3 ) where 1=1  and ac.acno="+acno+"   and (rd.rdocno is not null or ld.rdocno is not null)  )a)docexp,"
	            +" (select coalesce(count(*),0) from(select * from my_fileattach where doc_no="+acno+" and dtype='CRM')a ) atchmt";
 
//System.out.println("---get init count---"+strgetcarddata);
	ResultSet rscarddata=stmt.executeQuery(strgetcarddata);
	while(rscarddata.next()){
		
		accsum=rscarddata.getString("accsum");
		invoicelst=rscarddata.getString("invoicelst");
		docexp=rscarddata.getString("docexp");
		atchmt=rscarddata.getString("atchmt");
		
		
	}
	//objchartdata=dao.getChartCountData(cldocno,conn);
	objchartdata=dao.getFleetDistChartData(acno);
	objlivefleets=dao.getFleetSalesChartData(acno);
	
	ArrayList<String> helpdeskarray=new ArrayList();
	int helpdeskserial=1;
	
	objpolicyno.put("helpdeskdata", helpdeskarray);
	//System.out.println(objpolicyno);
	
	
	//gets client corresponding vehicles  
	String strgetveh="select concat(veh.REG_NO,' ',plt.CODE_NAME,' ',veh.FLNAME) refname,veh.FLEET_NO fleetno from gl_ragmt agmt"+ 
	" left join gl_vehmaster veh on (agmt.fleet_no=veh.FLEET_NO)"+ 
	" left join gl_vehplate plt on veh.pltid=plt.doc_no where agmt.cldocno="+cldocno+" and agmt.clstatus=0 and agmt.status=3 union all"+
	" select concat(veh.REG_NO,' ',plt.CODE_NAME,' ',veh.FLNAME) refname,veh.FLEET_NO fleetno from gl_lagmt agmt"+ 
	" left join gl_vehmaster veh on (if(agmt.tmpfleet=0,agmt.perfleet,agmt.tmpfleet)=veh.FLEET_NO)"+ 
	" left join gl_vehplate plt on veh.pltid=plt.doc_no"+
	" where agmt.cldocno="+cldocno+" and agmt.clstatus=0 and agmt.status=3";
	//System.out.println(strgetveh);
	ResultSet rsgetveh=stmt.executeQuery(strgetveh);
	JSONArray veharray=new JSONArray();
	while(rsgetveh.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("fleetno",rsgetveh.getString("fleetno"));
		objtemp.put("refname",rsgetveh.getString("refname"));
		veharray.add(objtemp);
	}
	
	String strgettype="select name refname,doc_no docno from cm_cuscalltype where status=3";
	ResultSet rsgettype=stmt.executeQuery(strgettype);
	JSONArray typearray=new JSONArray();
	while(rsgettype.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgettype.getString("docno"));
		objtemp.put("refname",rsgettype.getString("refname"));
		typearray.add(objtemp);
	}
	String strgetfeed="select date_format(m.date,'%d.%m.%Y') date,m.doc_no docno,m.fleetno,m.regno,m.calledBy,m.calledByMob mobile,m.callDateTime datetime,ct.name typename,m.callType type,"+
	" m.callPlace place,m.remarks,coalesce(st.name,'') statusname from cm_cuscallm m"+ 
	" left join cm_cuscallstatus st on m.statusid=st.srno "+
	" left join cm_cuscalltype ct on m.callType=ct.doc_no and ct.status=3"+ 
	" where m.status=3 and m.cldocno="+cldocno;
	ResultSet rsgetfeed=stmt.executeQuery(strgetfeed);
	JSONArray feedarray=new JSONArray();
	while(rsgetfeed.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetfeed.getString("docno"));
		objtemp.put("regno",rsgetfeed.getString("regno"));
		objtemp.put("fleetno",rsgetfeed.getString("fleetno"));
		objtemp.put("calledby",rsgetfeed.getString("calledby"));
		objtemp.put("mobile",rsgetfeed.getString("mobile"));
		objtemp.put("datetime",rsgetfeed.getString("datetime"));
		objtemp.put("date",rsgetfeed.getString("date"));
		objtemp.put("typename",rsgetfeed.getString("typename"));		
		objtemp.put("type",rsgetfeed.getString("type"));
		objtemp.put("place",rsgetfeed.getString("place"));
		objtemp.put("remarks",rsgetfeed.getString("remarks"));
		objtemp.put("statusname",rsgetfeed.getString("statusname"));
		feedarray.add(objtemp);
	}
	
	objpolicyno.put("feedvehdata",veharray);
	objpolicyno.put("feedtypedata",typearray);
	objpolicyno.put("feeddata",feedarray);
	objpolicyno.put("acchartdata", dao.getAccountChart(currentDate,currentDateMinus6Months,acno,conn));
	//System.out.println(objpolicyno.get("acchartdata"));
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
//System.out.println(refname+" :: "+mobile+" :: "+email+" :: "+acno+" :: "+pdcinhand+" :: "+subreciept+" :: "+accsum+" :: "+invoicelst+" :: "+docexp+" :: "+atchmt+" :: "+objrenewal+" :: "+objinsurtype+" :: "+objcontactperson+" :: "+objpolicyno+" :: "+objchartdata+" :: "+objlivefleets);
response.getWriter().write(refname+" :: "+mobile+" :: "+email+" :: "+acno+" :: "+pdcinhand+" :: "+subreciept+" :: "+accsum+" :: "+invoicelst+" :: "+docexp+" :: "+atchmt+" :: "+objrenewal+" :: "+objinsurtype+" :: "+objcontactperson+" :: "+objpolicyno+" :: "+objchartdata+" :: "+objlivefleets);
%>