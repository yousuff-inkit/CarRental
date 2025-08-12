<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

Connection conn=null;
JSONArray gridarray=new JSONArray();
JSONObject objdata=new JSONObject();


String tarifmode = request.getParameter("tarifmode")==null?"0":request.getParameter("tarifmode"); 
String brandid = request.getParameter("brandid")==null || request.getParameter("brandid").equals("")?"0":request.getParameter("brandid"); 
String modelid = request.getParameter("modelid")==null || request.getParameter("modelid").equals("")?"0":request.getParameter("modelid"); 
String group = request.getParameter("groupid")==null || request.getParameter("groupid").equals("")?"0":request.getParameter("groupid"); 
String pickuplocid = request.getParameter("pickuplocid")==null || request.getParameter("pickuplocid").equals("")?"0":request.getParameter("pickuplocid"); 
String dropofflocid = request.getParameter("dropofflocid")==null || request.getParameter("dropofflocid").equals("")?"0":request.getParameter("dropofflocid"); 
String blockhrs = request.getParameter("blockhrs")==null || request.getParameter("blockhrs").equals("")?"0":request.getParameter("blockhrs"); 
String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno"); 
String transfertype = request.getParameter("transfertype")==null?"0":request.getParameter("transfertype"); 
System.out.println("--------In--------");

try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int groupid=0;
	
	int groupConfig=0;
	
	ResultSet rsGroupConfig = stmt.executeQuery("select coalesce(method,0) method from gl_config where field_nme='groupbased'");
	while (rsGroupConfig.next()){
		groupConfig=rsGroupConfig.getInt("method");
	}
	
	if(groupConfig==1){
		groupid=Integer.parseInt(group);
	} else {
		ResultSet rsgroup=stmt.executeQuery("select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
		while (rsgroup.next()) {
			groupid=rsgroup.getInt("groupid");
		}
	}
	
		int clientcatid=0;
		String clientcatname="";
		String clientname="";
		String strclientcategory="select cat.doc_no,cat.cat_name,ac.refname from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.cldocno="+cldocno+" and ac.dtype='CRM';";
		System.out.println("CLIENT CATEGORY"+strclientcategory);
		ResultSet rsclientcat=stmt.executeQuery(strclientcategory);
		while(rsclientcat.next()){
			clientcatid=rsclientcat.getInt("doc_no");
			clientcatname=rsclientcat.getString("cat_name");
			clientname=rsclientcat.getString("refname");
		}
		
		JSONArray transferData = new JSONArray();  
		JSONArray limoData = new JSONArray();
		
		String strsql="";
		
		if(tarifmode.equalsIgnoreCase("transferGrid")){
			strsql="select doc_no, validto, tariftype, tarifclient, gid, tarifdetaildocno, round(estdistance,2) estdistance, esttime, round(tarif,2) tarif, round(exdistancerate,2) exdistancerate, round(extimerate,2) extimerate,round(allowance,2) allowance  from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1) tariftype,m.tarifclient,tran.gid,tran.doc_no "+
			" tarifdetaildocno,round(tran.estdist,2) estdistance,tran.esttime,round(tran.tarif,2) tarif,round(tran.exdistrate,2) exdistancerate,round(tran.extimerate,2) extimerate,tran.allowance from gl_limotarifm  m left join"+
			" gl_limotariftransfer tran on tran.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and "+
			" tran.pickuplocid="+pickuplocid+" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all "+
			" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.tarifclient,aa.gid,aa.doc_no tarifdetaildocno,aa.estdistance,"+
			" aa.esttime,aa.tarif,aa.exdistancerate,aa.extimerate,aa.allowance from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate,tran.allowance from gl_limotarifm m left join gl_limotariftransfer tran on"+
			" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" "+
			" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
			" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,tran.gid,tran.doc_no tarifdetaildocno,tran.estdist estdistance,"+
			" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate,tran.allowance from gl_limotarifm  m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no  "+
			" where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" and "+
			" tran.dropofflocid="+dropofflocid+") and m.tariftype='regular' and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			
			System.out.println("GET Tarif Docno Transfer Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("estdistance",rs.getString("estdistance"));
	            objtemp.put("esttime",rs.getString("esttime"));
				objtemp.put("tarif",rs.getString("tarif"));
				objtemp.put("allowance",rs.getString("allowance"));
				objtemp.put("exdistancerate",rs.getString("exdistancerate"));
				objtemp.put("extimerate",rs.getString("extimerate"));
				objtemp.put("gid",rs.getString("gid"));
				objtemp.put("docno",rs.getString("doc_no"));
				objtemp.put("tarifdetaildocno",rs.getString("tarifdetaildocno"));
				objtemp.put("tarifdetail",rs.getString("doc_no")+" - "+rs.getString("tarifclient"));
				transferData.add(objtemp);
			}
		}

        if(tarifmode.equalsIgnoreCase("hoursGrid")){
			strsql="select doc_no, validto, tariftype, tarifclient, tarifdetaildocno, gid, blockhrs,round(tarif,2) tarif,round(exhrrate,2) exhrrate,round(nighttarif,2) nighttarif,round(nightexhrrate,2) nightexhrrate,round(allowance,2) allowance from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1)  tariftype,m.tarifclient,hours.doc_no "+
			" tarifdetaildocno,hours.gid,hours.blockhrs,round(hours.tarif,2) tarif,round(hours.exhrrate,2) exhrrate,round(hours.nighttarif,2) nighttarif,round(hours.nightexhrrate,2) nightexhrrate,hours.allowance from gl_limotarifm  m left join "+
			" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" "+
			" and hours.blockhrs="+blockhrs+" and hours.locid in ("+pickuplocid+",0)) and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all"+
			" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.tarifclient,aa.doc_no tarifdetaildocno,aa.gid,"+
			" aa.blockhrs,aa.tarif,aa.exhrrate,aa.nighttarif,aa.nightexhrrate,aa.allowance from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,hours.doc_no "+
			" tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate,hours.allowance from gl_limotarifm m left join "+
			" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and "+
			" hours.blockhrs="+blockhrs+" and hours.locid in ("+pickuplocid+",0)) and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
			" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,hours.doc_no tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,"+
			" hours.exhrrate,hours.nighttarif,hours.nightexhrrate,hours.allowance from gl_limotarifm  m left join gl_limotarifhours hours on hours.tarifdocno=m.doc_no "+
			" where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and hours.blockhrs="+blockhrs+"  and hours.locid in ("+pickuplocid+",0)) and m.tariftype='regular'"+
			"  and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			
			System.out.println("GET Tarif Docno Limo Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("exhrrate",rs.getString("exhrrate"));
				objtemp.put("nighttarif",rs.getString("nighttarif"));
				objtemp.put("docno",rs.getString("doc_no"));
				objtemp.put("tarif",rs.getString("tarif"));
				objtemp.put("allowance",rs.getString("allowance"));
				objtemp.put("nightexhrrate",rs.getString("nightexhrrate"));
				objtemp.put("gid",rs.getString("gid"));
				objtemp.put("tarifdetaildocno",rs.getString("tarifdetaildocno"));
				objtemp.put("tarifdetail",rs.getString("doc_no")+" - "+rs.getString("tarifclient"));
				limoData.add(objtemp);
			}
		}
		objdata.put("transferData", transferData);  
		objdata.put("limoData", limoData);            
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(objdata+"");
%>
