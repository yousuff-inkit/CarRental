<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.dashboard.ClsDashBoardNewDAO"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String grouptype=request.getParameter("grouptype")==null?"":request.getParameter("grouptype");
String widgetname=request.getParameter("widgetname")==null?"":request.getParameter("widgetname");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsDashBoardNewDAO dao=new ClsDashBoardNewDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="";
	
	JSONArray brancharray=new JSONArray();
	String strbranch="SELECT doc_no docno,branchname refname FROM my_brch WHERE STATUS=3";
	ResultSet rsbranch=stmt.executeQuery(strbranch);
	while(rsbranch.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsbranch.getString("docno"));
		objtemp.put("refname",rsbranch.getString("refname"));
		brancharray.add(objtemp);
	}
	objdata.put("branchdata", brancharray);
	
	
	if(widgetname.equalsIgnoreCase("fleetutillist")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		JSONArray fleetutilarray=dao.getFleetUtilizeData(conn,grouptype,sqlfromdate,sqltodate);
		objdata.put("fleetutilizedata",fleetutilarray);
	}
	else if(widgetname.equalsIgnoreCase("revenuelist")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		String strgroupby="";
		String sqltest="";
		if(sqlfromdate!=null){
			sqltest+=" and inv.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and inv.date<='"+sqltodate+"'";
		}
		if(grouptype.equalsIgnoreCase("salesman")){
			strgroupby=" group by sal.doc_no";
		}
		else if(grouptype.equalsIgnoreCase("category")){
			strgroupby=" group by cat.doc_no";
		}
		String strrevenuelist="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,round(sum(a.dailytotal),2) daily,"+
		" round(sum(a.weeklytotal),2) weekly,round(sum(a.monthlytotal),2) monthly,round(sum(a.leasetotal),2) lease from (select agmt.doc_no,agmt.cldocno,if(rtf.rentaltype='Daily',"+
		" sum(invd.total),0) dailytotal,if(rtf.rentaltype='Weekly',sum(invd.total),0) weeklytotal,if(rtf.rentaltype='Monthly',sum(invd.total),0) "+
		" monthlytotal,0.0 leasetotal from gl_invm inv left join (select sum(total) total,rdocno from gl_invd group by rdocno) invd on (inv.doc_no=invd.rdocno) "+
		" left join gl_ragmt agmt on (inv.rano=agmt.doc_no) left join gl_rtarif rtf on (agmt.doc_no=rtf.rdocno and rtf.rstatus=5) where "+
		" inv.ratype='RAG' "+sqltest+" group by agmt.doc_no union all"+
		" select agmt.doc_no,agmt.cldocno,0.0 dailytotal,0.0 weeklytotal,0.0 monthlytotal,sum(invd.total) leasetotal from gl_invm inv left join (select sum(total) total,rdocno from gl_invd group by rdocno) invd on (inv.doc_no=invd.rdocno) "+
		" left join gl_lagmt agmt on (inv.rano=agmt.doc_no) left join gl_ltarif rtf on (agmt.doc_no=rtf.rdocno) where "+
		" inv.ratype='LAG' "+sqltest+" group by agmt.doc_no) a left join my_acbook ac on (a.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on "+
		" ac.sal_id=sal.doc_no left join my_clcatm cat on ac.catid=cat.doc_no"+strgroupby;
		JSONArray revenuelistarray=new JSONArray();
		ResultSet rsrevenuelist=stmt.executeQuery(strrevenuelist);
		while(rsrevenuelist.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("description",grouptype.equalsIgnoreCase("salesman")?rsrevenuelist.getString("salesman"):rsrevenuelist.getString("category"));
			objtemp.put("daily",rsrevenuelist.getString("daily"));
			objtemp.put("monthly",rsrevenuelist.getString("monthly"));
			objtemp.put("weekly",rsrevenuelist.getString("weekly"));
			objtemp.put("lease",rsrevenuelist.getString("lease"));
			revenuelistarray.add(objtemp);
		}
		objdata.put("revenuelistdata",revenuelistarray);
	}
	else if(widgetname.equalsIgnoreCase("revenuecomplist")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		java.sql.Date sqlfromdate2=null,sqltodate2=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		String fromdate2=request.getParameter("fromdate2")==null?"":request.getParameter("fromdate2");
		String todate2=request.getParameter("todate2")==null?"":request.getParameter("todate2");
		sqlfromdate2=objcommon.changeStringtoSqlDate(fromdate2);
		sqltodate2=objcommon.changeStringtoSqlDate(todate2);
		String strgroupby="";
		if(grouptype.equalsIgnoreCase("salesman")){
			strgroupby=" group by sal.doc_no";
		}
		else if(grouptype.equalsIgnoreCase("category")){
			strgroupby=" group by cat.doc_no";
		}
		String strrevenuelist="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Daily' and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"',invd.total,0.0)),2) prevdaily,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Weekly' and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"',invd.total,0.0)),2) prevweekly,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Monthly' and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"',invd.total,0.0)),2) prevmonthly,"+
		" round(sum(if(inv.ratype='LAG' and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate+"',invd.total,0.0)),2) prevlease,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Daily' and inv.date>='"+sqlfromdate2+"' and inv.date<='"+sqltodate2+"',invd.total,0.0)),2) currentdaily,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Weekly' and inv.date>='"+sqlfromdate2+"' and inv.date<='"+sqltodate2+"',invd.total,0.0)),2) currentweekly,"+
		" round(sum(if(inv.ratype='RAG' and rtf.rentaltype='Monthly' and inv.date>='"+sqlfromdate2+"' and inv.date<='"+sqltodate2+"',invd.total,0.0)),2) currentmonthly,"+
		" round(sum(if(inv.ratype='LAG' and inv.date>='"+sqlfromdate2+"' and inv.date<='"+sqltodate2+"',invd.total,0.0)),2) currentlease"+
		" from gl_invm inv left join gl_invd invd on (inv.doc_no=invd.rdocno) left join gl_ragmt rag on (inv.ratype='RAG' and inv.rano=rag.doc_no) left join gl_rtarif rtf on (rag.doc_no=rtf.rdocno and rtf.rstatus=5) left join gl_lagmt lag on (inv.ratype='LAG' and inv.rano=lag.doc_no) left join gl_ltarif ltf on (lag.doc_no=ltf.rdocno) left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on (ac.sal_id=sal.doc_no) left join my_clcatm cat on (ac.catid=cat.doc_no) where inv.status=3 and inv.date>='"+sqlfromdate+"' and inv.date<='"+sqltodate2+"'"+strgroupby;
		JSONArray revenuelistarray=new JSONArray();
		ResultSet rsrevenuelist=stmt.executeQuery(strrevenuelist);
		while(rsrevenuelist.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("description",grouptype.equalsIgnoreCase("salesman")?rsrevenuelist.getString("salesman"):rsrevenuelist.getString("category"));
			objtemp.put("prevdaily",rsrevenuelist.getString("prevdaily"));
			objtemp.put("prevmonthly",rsrevenuelist.getString("prevmonthly"));
			objtemp.put("prevweekly",rsrevenuelist.getString("prevweekly"));
			objtemp.put("prevlease",rsrevenuelist.getString("prevlease"));
			objtemp.put("currentdaily",rsrevenuelist.getString("currentdaily"));
			objtemp.put("currentmonthly",rsrevenuelist.getString("currentmonthly"));
			objtemp.put("currentweekly",rsrevenuelist.getString("currentweekly"));
			objtemp.put("currentlease",rsrevenuelist.getString("currentlease"));
			revenuelistarray.add(objtemp);
		}
		objdata.put("revenuecomplistdata",revenuelistarray);
	}
	else if(widgetname.equalsIgnoreCase("collectlist")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		String strgroupby="";
		String sqltest="";
		if(sqlfromdate!=null){
			sqltest+=" and agmt.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and agmt.date<='"+sqltodate+"'";
		}
		if(grouptype.equalsIgnoreCase("salesman")){
			strgroupby=" group by sal.doc_no";
		}
		else if(grouptype.equalsIgnoreCase("category")){
			strgroupby=" group by cat.doc_no";
		}
		String strgetcollectlist="select coalesce(sal.sal_name,'') salesman,coalesce(cat.cat_name,'') category,round(sum(a.cheque),2) cheque,"+
				" round(sum(a.card),2) card,round(sum(a.cash),2) cash from ("+
				" select if(pyt.paytype=3,pyt.amount,0) cheque,if(pyt.paytype=2,pyt.amount,0) card,"+
				" if(pyt.paytype=1,pyt.amount,0) cash, agmt.cldocno from gl_rentreceipt pyt left join gl_ragmt agmt on"+
				" (pyt.aggno=agmt.doc_no and pyt.rtype='RAG') where agmt.status=3  "+sqltest+" union all"+
				" select if(pyt.paytype=3,pyt.amount,0) cheque,if(pyt.paytype=2,pyt.amount,0) card,"+
				" if(pyt.paytype=1,pyt.amount,0) cash, agmt.cldocno from gl_rentreceipt pyt left join gl_lagmt agmt on"+
				" (pyt.aggno=agmt.doc_no and pyt.rtype='LAG') where agmt.status=3 "+sqltest+") a left join my_acbook ac on "+
				" (a.cldocno=ac.cldocno and ac.dtype='CRM')  left join my_salm sal on ac.sal_id=sal.doc_no left join"+
				" my_clcatm cat on ac.catid=cat.doc_no "+strgroupby;
		ResultSet rsgetcollectlist=stmt.executeQuery(strgetcollectlist);
		JSONArray collectlistarray=new JSONArray();
		while(rsgetcollectlist.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("description",grouptype.equalsIgnoreCase("salesman")?rsgetcollectlist.getString("salesman"):rsgetcollectlist.getString("category"));
			objtemp.put("cheque",rsgetcollectlist.getString("cheque"));
			objtemp.put("cash",rsgetcollectlist.getString("cash"));
			objtemp.put("card",rsgetcollectlist.getString("card"));
			collectlistarray.add(objtemp);
		}
		objdata.put("collectlistdata",collectlistarray);
	}
	else if(widgetname.trim().equalsIgnoreCase("salikstatus")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		
		String sqlfilters="";
		sqlfilters+=" and s.sal_date>='"+sqlfromdate+"' and s.sal_date<='"+sqltodate+"'";
		String countselect="";
		for(int i=0;i<brancharray.size();i++){
			JSONObject objbranch=brancharray.getJSONObject(i);
			if(countselect.trim().equalsIgnoreCase("")){
				countselect+=" sum(case when veh.brhid="+objbranch.getString("docno")+" then 1 else 0 end) branch"+i;
			}
			else{
				countselect+=",sum(case when veh.brhid="+objbranch.getString("docno")+" then 1 else 0 end) branch"+i;
			}
		}
		JSONArray salikarray=new JSONArray();
		String strsalik="SELECT "+countselect+",'Allocated' statusname FROM gl_salik s LEFT JOIN gl_vehmaster veh ON (s.Fleetno=veh.FLEET_NO AND veh.STATU<>7) WHERE s.isallocated=1 AND s.inv_no=0 AND s.status IN (0,3) "+sqlfilters+" UNION ALL"+
		" SELECT "+countselect+",'Invoiced' statusname FROM gl_salik s"+ 
		" LEFT JOIN gl_vehmaster veh ON (s.Fleetno=veh.FLEET_NO AND veh.STATU<>7)"+
		" INNER JOIN gl_invm m ON m.doc_no=s.inv_no INNER JOIN(SELECT SUM(dramount-out_amount) t ,acno,tr_no FROM my_jvtran"+
		" WHERE dtype IN('INV','INT','INS') GROUP BY tr_no,acno HAVING t!=0)j ON m.tr_no=j.tr_no AND m.acno=j.acno "+
		" WHERE s.isallocated=1 AND s.inv_no>0 AND s.status IN (1) "+sqlfilters+" UNION ALL"+
		
		" SELECT "+countselect+",'Recieved' statusname FROM gl_salik s"+ 
		" LEFT JOIN gl_vehmaster veh ON (s.Fleetno=veh.FLEET_NO AND veh.STATU<>7)"+
		" INNER JOIN gl_invm m ON  m.doc_no=s.inv_no INNER JOIN(SELECT SUM(dramount-out_amount) t ,acno,tr_no FROM my_jvtran"+ 
		" WHERE dtype IN('INV','INT','INS') GROUP BY tr_no,acno HAVING t=0)j ON m.tr_no=j.tr_no AND m.acno=j.acno "+
		" WHERE s.isallocated=1 AND s.inv_no>0 AND s.status IN (1) "+sqlfilters;
	//	System.out.println("salikstatus--"+strsalik);
		ResultSet rssalik=stmt.executeQuery(strsalik);
		while(rssalik.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("statusname", rssalik.getString("statusname"));
			for(int i=0;i<brancharray.size();i++){
				JSONObject objbranch=brancharray.getJSONObject(i);
				objtemp.put("branch"+i, rssalik.getString("branch"+i));
			}
			salikarray.add(objtemp);
		}
		objdata.put("salikstatusdata", salikarray);
	}
	else if(widgetname.trim().equalsIgnoreCase("trafficstatus")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		
		String sqlfilters="";
		sqlfilters+=" and t.TRAFFIC_DATE>='"+sqlfromdate+"' and t.TRAFFIC_DATE<='"+sqltodate+"'";
		String countselect="";
		for(int i=0;i<brancharray.size();i++){
			JSONObject objbranch=brancharray.getJSONObject(i);
			if(countselect.trim().equalsIgnoreCase("")){
				countselect+=" sum(case when veh.brhid="+objbranch.getString("docno")+" then 1 else 0 end) branch"+i;
			}
			else{
				countselect+=",sum(case when veh.brhid="+objbranch.getString("docno")+" then 1 else 0 end) branch"+i;
			}
		}
		JSONArray trafficarray=new JSONArray();
		String strtraffic="SELECT "+countselect+",'Allocated' statusname from gl_traffic t LEFT JOIN gl_vehmaster veh ON (t.Fleetno=veh.FLEET_NO AND veh.STATU<>7) "+
		" where t.isallocated=1 and t.inv_no=0 and t.status in (0,3) "+sqlfilters+" UNION ALL"+
		" SELECT "+countselect+",'Invoiced' statusname from gl_traffic t LEFT JOIN gl_vehmaster veh ON (t.Fleetno=veh.FLEET_NO AND veh.STATU<>7)"+
		" where t.isallocated=1 and t.inv_no>0 and t.status in (1) "+sqlfilters+" UNION ALL"+
		" SELECT "+countselect+",'Recieved' statusname from gl_traffic  t"+
		" LEFT JOIN gl_vehmaster veh ON (t.Fleetno=veh.FLEET_NO AND veh.STATU<>7)"+
		" inner join gl_invm m on    m.doc_no=t.inv_no and t.inv_type='INV' inner join (select sum(amount) amt,rdocno from gl_invd"+ 
		" where chid in (9,15) group by rdocno) d on m.doc_no=d.rdocno inner join "+
		" my_jvtran j on (j.dtype in ('INV','INT','INS') and m.tr_no=j.tr_no and m.acno=j.acno)"+
		" where (j.dramount-j.out_amount)=0    and t.isallocated=1 and t.inv_no>0  "+
		" and t.status in (1) "+sqlfilters;
		//System.out.println("trafficstatus--"+strtraffic);
		ResultSet rstraffic=stmt.executeQuery(strtraffic);
		while(rstraffic.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("statusname", rstraffic.getString("statusname"));
			for(int i=0;i<brancharray.size();i++){
				JSONObject objbranch=brancharray.getJSONObject(i);
				objtemp.put("branch"+i, rstraffic.getString("branch"+i));
			}
			trafficarray.add(objtemp);
		}
		objdata.put("trafficstatusdata", trafficarray);
	
	}else if(widgetname.trim().equalsIgnoreCase("bookingflupstatus")){
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		
	JSONArray bookingfluparray=new JSONArray();

	String strbookingflup="select ROUND(@i:=@i+1 ,0) slno,a.* from(select convert(if(b.delivery=1,round(b.delchg,2),''),char(50)) delchg,b.voc_no docno,convert(if(b.fleet_no='0','',b.fleet_no),char(20)) fleet_no,b.grpid,b.delivery,b.chuef,DATE_FORMAT(bv.fdate, '%d.%m.%Y') fdate,b.cldocno,b.brhid, b.DOC_NO , DATE_FORMAT(b.date, '%d.%m.%Y') date,  b.REFNO, if(b.REFTYPE='DIR','Direct',if(b.REFTYPE='ONL','Online','Quotation')) type,b.REFTYPE,"
			+ "b.CONTACTNO mob ,b.remarks,b.rtype, DATE_FORMAT(b.frmdate, '%d.%m.%Y') frmdate,b.frmtime,DATE_FORMAT(b.todate, '%d.%m.%Y') todate,concat(br.brand_name,' ',mo.vtype) brmodel,"
			+ "a.refname name from  gl_bookingm b left join gl_vehmodel mo on mo.doc_no=b.modid "
			+ "  left join gl_vehbrand br on br.doc_no=b.brdid left join gl_quotm q on q.doc_no=b.refno "
			+ " left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'   "
			+ "left join (select max(s.doc_no) doc_no,rdocno from gl_bvbr s group by  rdocno) s on(s.rdocno=b.doc_no) left join "
			+ "gl_bvbr bv on s.doc_no=bv.doc_no where b.status=3 and b.rano<=0 and b.clstatus<2 and b.DATE <='"+sqltodate+"')a,(select @i:=0)b" ;
	//System.out.println("bookingflupstatus--"+strbookingflup);
	ResultSet rsbookingflup=stmt.executeQuery(strbookingflup);
	while(rsbookingflup.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("slno", rsbookingflup.getString("slno"));
		objtemp.put("docno", rsbookingflup.getString("docno"));
		objtemp.put("fleet_no", rsbookingflup.getString("fleet_no"));
		objtemp.put("brmodel", rsbookingflup.getString("brmodel"));
		objtemp.put("name", rsbookingflup.getString("name"));
		objtemp.put("rtype", rsbookingflup.getString("rtype"));
		objtemp.put("frmdate", rsbookingflup.getString("frmdate"));
		objtemp.put("todate", rsbookingflup.getString("todate"));
		
		bookingfluparray.add(objtemp);
	}
	objdata.put("bookingflupdata", bookingfluparray);
	}
	
	
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
//System.out.println(objdata);
response.getWriter().write(objdata+"");
%>