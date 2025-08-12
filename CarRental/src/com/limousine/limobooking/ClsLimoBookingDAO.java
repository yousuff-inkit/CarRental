package com.limousine.limobooking;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoBookingDAO {
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
	public JSONArray getClientData(String id,String clientdoc,String clientname,String clientmobile,String clientlicense,String clientdob) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			String strsql="";
			java.sql.Date sqldate=null;
			if(!clientdoc.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno like '%"+clientdoc+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmobile+"%'";
			}
			if(!clientlicense.equalsIgnoreCase("")){
				sqltest+=" and dr.dlno like '%"+clientlicense+"%'";
			}
			if(!clientdob.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(clientdob);
			}
			if(sqldate!=null){
				sqltest+=" and dr.dob like '%"+sqldate+"%'";
			}
			strsql="select ac.cldocno,ac.refname,ac.per_mob,dr.dlno,dr.dob from my_acbook ac left join gl_drdetails dr on ac.cldocno=dr.cldocno where ac.dtype='CRM' and ac.status=3"+sqltest;
			ResultSet rsclient=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsclient);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	public JSONArray getGuestGridData(String docno,String cldocno,String id) throws SQLException{
		JSONArray guestdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return guestdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,guest,guestcontactno from gl_limoguest where rdocno="+docno+" and cldocno="+cldocno+" and status=3";
			System.out.println("Guest Grid"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			guestdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return guestdata;
	}
	
	public JSONArray getGuestData(String cldocno) throws SQLException{
		JSONArray guestdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,guest,guestcontactno from gl_limoguest where status=3 and cldocno="+cldocno;
			ResultSet rs=stmt.executeQuery(strsql);
			guestdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return guestdata;
	}
	
	public JSONArray getSearchData(String docno,String client,String clientmob,String date,String guest,String id,String branch) throws SQLException{
		JSONArray searchdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return searchdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			
			java.sql.Date sqldate=null;
            if(!docno.equalsIgnoreCase("")){
                sqltest+=" and book.voc_no like '%"+docno+"%'";
            }
            if(!client.equalsIgnoreCase("")){
                sqltest+=" and ac.refname like '%"+client+"%'";
            }
            if(!clientmob.equalsIgnoreCase("")){
                sqltest+=" and ac.per_mob like '%"+clientmob+"%'";
            }
            if(!date.equalsIgnoreCase("")){
                sqldate=objcommon.changeStringtoSqlDate(date);
            }
            if(sqldate!=null){
                sqltest+=" and book.date='"+sqldate+"'";
            }
            if(!guest.equalsIgnoreCase("")){
                sqltest+=" and guest.guest like '%"+guest+"%'";
            }
			
			if(!branch.equalsIgnoreCase("")){
				sqltest+=" and book.brhid="+branch;
			}
			Statement stmt=conn.createStatement();
			
			int isHideTariff=0;
			String isHideTariffSql = "select coalesce(method,0) method from gl_config where field_nme='hidetariff'";
			ResultSet rsisHideTariffSql = stmt.executeQuery(isHideTariffSql);
			if(rsisHideTariffSql.next()) {
				isHideTariff = rsisHideTariffSql.getInt("method");
			}
			
			String addVesselDetails = isHideTariff==1?"book.vesselno,book.vesselname,":"";
			
			
			
			String strsql="select "+addVesselDetails+"coalesce(book.refno,'') refno,book.voc_no,book.locationtype,book.airport,book.flightno,book.hotel,book.roomno,book.desc1 description,book.doc_no,book.date,book.guestno,book.newguest hidchknewguest,ac.refname,ac.cldocno,ac.per_mob,dr.dlno,guest.guest,guest.guestcontactno"+
			" from gl_limobookm book left join gl_limoguest guest on book.guestno=guest.doc_no left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join gl_drdetails dr on (ac.cldocno=dr.cldocno and ac.dtype='CRM') where book.status=3"+sqltest+" group by book.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}
	
	public JSONArray getBrandData() throws SQLException{
		JSONArray branddata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select brd.brand_name brand,brd.doc_no from gl_vehmaster veh left join gl_vehbrand brd on veh.brdid=brd.doc_no where veh.dtype='VEH' and"+
			" veh.statu=3 and veh.limostatus=1 group by brd.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	public JSONArray getGroupData() throws SQLException{
		JSONArray groupData=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="SELECT GID gid, GNAME gname, doc_no docno  FROM gl_vehgroup WHERE STATUS=3";
			ResultSet rs=stmt.executeQuery(strsql);
			groupData=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return groupData;
	}
	
	public JSONArray getModelData(String brandid) throws SQLException{
		JSONArray modeldata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select model.vtype model,model.doc_no from gl_vehmaster veh left join gl_vehmodel model on veh.vmodid=model.doc_no where"+
			" veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 and model.brandid="+brandid+" group by model.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			modeldata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return modeldata;
	}
	
	public JSONArray getTarifDetailData(String tarifmode,String brandid,String modelid,String pickuplocid,String dropofflocid,String blockhrs,String cldocno,String transfertype,String date) throws SQLException{
		JSONArray tarifdata=new JSONArray();
		java.sql.Date sqldate=null;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			 if(!date.equalsIgnoreCase("")){
	                sqldate=objcommon.changeStringtoSqlDate(date);
	         }
			int groupid=0;
		//	System.out.println("Group Query: select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			ResultSet rsgroup=stmt.executeQuery("select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			while (rsgroup.next()) {
				groupid=rsgroup.getInt("groupid");
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
			
			String tunion="";
			String hunion="";
			int clienttariffcount=0;
			
			String getshowrconfig = "";
			if(tarifmode.equalsIgnoreCase("transferGrid")){
				getshowrconfig = "SELECT COUNT(*) total FROM gl_limotariftransfer t LEFT JOIN  gl_limotarifm m ON t.tarifdocno=m.doc_no WHERE '"+sqldate+"' BETWEEN m.validfrom AND m.validto AND m.status=3 AND m.tariftype='Client' AND m.tarifclient="+cldocno+"";
			} else if (tarifmode.equalsIgnoreCase("hoursGrid")) {
				getshowrconfig = "SELECT COUNT(*) total FROM gl_limotarifhours h LEFT JOIN  gl_limotarifm m ON h.tarifdocno=m.doc_no WHERE '"+sqldate+"' BETWEEN m.validfrom AND m.validto AND m.status=3 AND (h.blockhrs="+blockhrs+") AND m.tariftype='Client' AND m.tarifclient="+cldocno+"";
			}			
			System.out.println(getshowrconfig);
			ResultSet rse = stmt.executeQuery(getshowrconfig);
			if(rse.next()) {
				clienttariffcount = rse.getInt("total");
			}
			
			
			if(clienttariffcount<=0) {
				tunion=" select aa.tariffor,aa.gname,aa.dloc dlocation,aa.dropofflocid,aa.ploc plocation,aa.pickuplocid,aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,aa.estdistance,"+
						" aa.esttime,aa.tarif,aa.exdistancerate,aa.extimerate from (select m.tariffor,vg.gname,pl.location ploc,tran.pickuplocid ,dl.location dloc,tran.dropofflocid,m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
						" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on"+
						" tran.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=tran.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=tran.pickuplocid AND pl.status=3 LEFT JOIN gl_cordinates dl ON dl.doc_no=tran.dropofflocid AND dl.status=3 where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" ) aa union all"+
						" select m.tariffor,vg.gname,dl.location dlocation,tran.dropofflocid,pl.location plocation,tran.pickuplocid,m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,tran.doc_no tarifdetaildocno,tran.gid,tran.estdist estdistance,"+
						" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=tran.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=tran.pickuplocid AND pl.status=3 LEFT JOIN gl_cordinates dl ON dl.doc_no=tran.dropofflocid AND dl.status=3 "+
						" where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and m.tariftype='regular' ";
			
				hunion=" select aa.tariffor,aa.gname,aa.plocation,aa.pickuplocid,aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,"+
						" aa.blockhrs,aa.tarif,aa.exhrrate,aa.nighttarif,aa.nightexhrrate from (select m.tariffor,vg.gname,pl.location plocation,hours.locid pickuplocid,m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,hours.doc_no "+
						" tarifdetaildocno,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate,hours.gid from gl_limotarifm m left join "+
						" gl_limotarifhours hours on hours.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=hours.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=hours.locid AND pl.status=3 where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and ( "+
						" hours.blockhrs="+blockhrs+" ) and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" ) aa union all"+
						" select m.tariffor,vg.gname,pl.location plocation,hours.locid pickuplocid, m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,hours.doc_no tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,"+
						" hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join gl_limotarifhours hours on hours.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=hours.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=hours.locid AND pl.status=3 "+
						" where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and ( hours.blockhrs="+blockhrs+") and m.tariftype='regular'";
			}
			
			
			
			String strsql="";
			if(tarifmode.equalsIgnoreCase("transferGrid")){
			strsql= clienttariffcount>0? "select * from (select m.tariffor,vg.gname,dl.location dlocation,tran.dropofflocid,pl.location plocation,tran.pickuplocid,m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1) tariftype,m.tarifclient,tran.doc_no "+
			" tarifdetaildocno,tran.gid,tran.estdist estdistance,tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join"+
			" gl_limotariftransfer tran on tran.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=tran.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=tran.pickuplocid AND pl.status=3 LEFT JOIN gl_cordinates dl ON dl.doc_no=tran.dropofflocid AND dl.status=3 where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and m.tariftype='Client' and m.tarifclient="+cldocno+") zz": "select * from ("+tunion+") zz";	
			}
			else if(tarifmode.equalsIgnoreCase("hoursGrid")){
				strsql=clienttariffcount>0?"select * from (select m.tariffor,vg.gname,pl.location plocation,hours.locid pickuplocid,m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1)  tariftype,m.tarifclient,hours.doc_no "+
				" tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join "+
				" gl_limotarifhours hours on hours.tarifdocno=m.doc_no LEFT JOIN gl_vehgroup vg ON vg.doc_no=hours.gid AND vg.status=3 LEFT JOIN gl_cordinates pl ON pl.doc_no=hours.locid AND pl.status=3 where '"+sqldate+"' between m.validfrom and m.validto and m.status=3 and (hours.blockhrs="+blockhrs+") and m.tariftype='Client' and m.tarifclient="+cldocno+") zz ": "select * from ("+tunion+") zz";
			}
			System.out.println("Tarif Query gridwin: "+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				tarifdata=objcommon.convertToJSON(rs);	
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return tarifdata;
	}


	public JSONArray getTarifData(String tarifmode,String brandid,String modelid,String pickuplocid,String dropofflocid,String blockhrs,String cldocno,String transfertype) throws SQLException{
		JSONArray tarifdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int groupid=0;
		//	System.out.println("Group Query: select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			ResultSet rsgroup=stmt.executeQuery("select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			while (rsgroup.next()) {
				groupid=rsgroup.getInt("groupid");
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
			
			String strsql="";
			if(tarifmode.equalsIgnoreCase("transferGrid")){
			strsql="select * from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1) tariftype,m.tarifclient,tran.gid,tran.doc_no "+
			" tarifdetaildocno,tran.estdist estdistance,tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join"+
			" gl_limotariftransfer tran on tran.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and "+
			" tran.pickuplocid="+pickuplocid+" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all "+
			" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,aa.estdistance,"+
			" aa.esttime,aa.tarif,aa.exdistancerate,aa.extimerate from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on"+
			" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" "+
			" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
			" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,tran.doc_no tarifdetaildocno,tran.gid,tran.estdist estdistance,"+
			" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no  "+
			" where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" and "+
			" tran.dropofflocid="+dropofflocid+") and m.tariftype='regular' and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			}
			else if(tarifmode.equalsIgnoreCase("hoursGrid")){
				strsql="select * from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1)  tariftype,m.tarifclient,hours.doc_no "+
				" tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join "+
				" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" "+
				" and hours.blockhrs="+blockhrs+" and hours.locid in ("+pickuplocid+",0)) and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all"+
				" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,"+
				" aa.blockhrs,aa.tarif,aa.exhrrate,aa.nighttarif,aa.nightexhrrate from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,hours.doc_no "+
				" tarifdetaildocno,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate,hours.gid from gl_limotarifm m left join "+
				" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and "+
				" hours.blockhrs="+blockhrs+" and hours.locid in ("+pickuplocid+",0)) and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
				" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,hours.doc_no tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,"+
				" hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join gl_limotarifhours hours on hours.tarifdocno=m.doc_no "+
				" where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and hours.blockhrs="+blockhrs+"  and hours.locid in ("+pickuplocid+",0)) and m.tariftype='regular'"+
				"  and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			}
			System.out.println("Tarif Query: "+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				tarifdata=objcommon.convertToJSON(rs);	
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return tarifdata;
	}

	public JSONArray getTransferData(String docno,String id) throws SQLException{
		JSONArray transferdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return transferdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select m.description,lg.doc_no guestid,lg.guest guestname,lg.guestcontactno guestcontact,m.pax,m.triptype,m.transfertype,m.doc_no,m.docname,m.pickupdate,m.pickuptime,m.pickuplocid pickuplocationid,m.pickupadress pickupaddress,pickup.location"+
			" pickuplocation,m.dropfflocid dropofflocationid,m.dropoffaddress,dropoff.location dropofflocation,m.brandid,brd.brand_name brand,m.modelid,"+
			" model.vtype model,m.nos,m.tarifdocno,m.gid,m.estdist estdistance,m.esttime,m.tarif,m.exdistrate exdistancerate,m.extimerate,"+
			" if(m.chkothersrvc=1,'true','false') chkothersrvc,'Append' btnappend,gp.gid groupid,m.gid,m.tarifdetaildocno,m.allowance from gl_limobooktransfer m LEFT JOIN gl_limoguest lg ON lg.doc_no=m.guestid AND lg.status=3 left join gl_cordinates pickup on m.pickuplocid=pickup.doc_no left join "+
			" gl_cordinates dropoff on m.dropfflocid=dropoff.doc_no left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on "+
			" m.modelid=model.doc_no left join gl_vehgroup gp on gp.doc_no=m.gid where m.bookdocno="+docno+" and m.status=3";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			transferdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return transferdata;
	}
	public JSONArray getHoursData(String docno,String id) throws SQLException{
		JSONArray hoursdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return hoursdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select m.description,lg.doc_no guestid,lg.guest guestname,lg.guestcontactno guestcontact, m.transfertype,m.days,m.blockhrs,m.doc_no,m.docname,m.pickupdate,m.pickuptime,m.pickuplocid pickuplocationid,m.pickupaddress pickupaddress,pickup.location"+
			" pickuplocation,m.brandid,brd.brand_name brand,m.modelid,model.vtype model,m.nos,m.tarifdocno,gp.gid groupid,m.gid,m.tarif,m.exhrrate,m.nighttarif,"+
			" m.nightexhrrate,if(m.chkothersrvc=1,'true','false') chkothersrvc,'Append' btnappend,m.gid,m.tarifdetaildocno,m.allowance from gl_limobookhours m  LEFT JOIN gl_limoguest lg ON lg.doc_no=m.guestid AND lg.status=3 left join gl_cordinates pickup on m.pickuplocid=pickup.doc_no "+
			" left join gl_vehbrand brd on m.brandid=brd.doc_no left join gl_vehmodel model on m.modelid=model.doc_no left join gl_vehgroup gp on m.gid=gp.doc_no where m.bookdocno="+docno+" and m.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			hoursdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return hoursdata;
	}
	public JSONArray getOtherSrvcData(String docno,String id) throws SQLException{
		JSONArray othersrvcdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return othersrvcdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int counter=0;
			ResultSet rscount=stmt.executeQuery("select count(*) counter from gl_limobooksrvc where bookdocno="+docno+" and status=3");
			while(rscount.next()){
				counter=rscount.getInt("counter");
			}
			String strsql="";
			if(counter>0){
				strsql="select srvc.doc_no,srvc.docname,srvc.typedocno detaildocno,srvc.greetdate,srvc.greettime,srvc.greettarifdocno,greet.greetrate"+
				" greettarif,srvc.vipdate,srvc.viptime,srvc.viptarifdocno,vip.viprate viptarif,srvc.boquedate,srvc.boquetime,srvc.boquetarifdocno,"+
				" boque.boquerate boquetarif,srvc.airportid,air.airport from gl_limobooksrvc srvc left join gl_limoextrasrvctarifd greet on"+
				" (srvc.greettarifdocno=greet.doc_no) left join gl_limoextrasrvctarifd vip on (srvc.viptarifdocno=vip.doc_no) left join"+
				" gl_limoextrasrvctarifd boque on (srvc.boquetarifdocno=boque.doc_no) left join gl_airport air on srvc.airportid=air.doc_no"+
				" where srvc.bookdocno="+docno+" and srvc.status=3";
			}
			else{
				strsql="select tran.doc_no detaildocno,tran.docname from gl_limobooktransfer tran where tran.bookdocno="+docno+" and tran.status=3 and tran.chkothersrvc=1 "+
						" union all select hours.doc_no detaildocno,hours.docname from gl_limobookhours hours where hours.bookdocno="+docno+" and hours.status=3 and hours.chkothersrvc=1 ";				
			}

			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			othersrvcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return othersrvcdata;
	}
	public JSONArray getAirportData(String airportindex) throws SQLException{
		JSONArray airportdata=new JSONArray();
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(airportindex.equalsIgnoreCase("")){
				strsql="select doc_no,airport from gl_airport where status=3";
			}
			else{
				strsql="select doc_no,airport from gl_airport where doc_no not in ("+airportindex+") and status=3";
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			airportdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return airportdata;
	}
	public JSONArray getAllAirportData() throws SQLException{
		JSONArray airportdata=new JSONArray();
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			strsql="select doc_no,airport from gl_airport where status=3";
			
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			airportdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return airportdata;
	}
	public JSONArray getBillingData(String docno,String id) throws SQLException{
		JSONArray billingdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return billingdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select billto,billmode,billper from gl_limobookbill where bookdocno="+docno+" and status=3";
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			billingdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return billingdata;
	}
	
	public int insert(Date sqldate, String hidclient, String hidguest,String guest, String guestcontactno, String hidchknewguest,
			HttpSession session, String mode, String formdetailcode,String brchName,String desc,String airport,String flightno,String hotel,
			String roomno,String cmbloctype,ClsLimoBookingAction masteraction) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("Inside dao - Booking master dml");    
		Connection conn=null;
		int docno=0;
		int vocno=0;
		try{
			
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int guestdocno=0;
			if(hidchknewguest.equalsIgnoreCase("1")){
				Statement stmt=conn.createStatement();
				
				ResultSet rsguestmaxdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) maxguestdoc from gl_limoguest");
				while(rsguestmaxdoc.next()){
					guestdocno=rsguestmaxdoc.getInt("maxguestdoc");
				}
				ResultSet rse = stmt.executeQuery("select coalesce(method,0) config from gl_config where field_nme='guestdetailview'");
				int met = 0;
				if(rse.next()){
				    met = rse.getInt("config");
				}
				
				if(!(met==1) && !guest.trim().equalsIgnoreCase("")){
				    int guestinsert=stmt.executeUpdate("insert into gl_limoguest(doc_no,guest,guestcontactno,status,cldocno)values("+guestdocno+",'"+guest+"','"+guestcontactno+"',3,"+hidclient+")");
				}
				hidguest=guest.trim().equalsIgnoreCase("")?"0":guestdocno+"";
			}
			if(hidguest.equalsIgnoreCase("")){
				hidguest="0";
			}
			String refno=masteraction.getRefno().trim();
			String vesselname = masteraction.getVesselname().trim();
			String vesselno = masteraction.getVesselno().trim();
			
			vesselname = vesselname.equalsIgnoreCase("") || vesselname.equalsIgnoreCase("undefined") || vesselname==null?"":vesselname;
			vesselno = vesselno.equalsIgnoreCase("") || vesselno.equalsIgnoreCase("undefined") || vesselno==null?"":vesselno;
			refno=refno.equalsIgnoreCase("") || refno.equalsIgnoreCase("undefined") || refno==null?"":refno;
			CallableStatement stmtBooking =conn.prepareCall("{call limoBookingMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtBooking.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtBooking.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtBooking.setDate(1, sqldate);
	        stmtBooking.setString(2, hidclient);
	        stmtBooking.setString(3, hidguest);
	        stmtBooking.setString(4, brchName);
	        stmtBooking.setString(5, session.getAttribute("USERID").toString());
	        stmtBooking.setString(6, session.getAttribute("COMPANYID").toString());
	        stmtBooking.setString(7, hidchknewguest);
	        stmtBooking.setString(8, mode);
	        stmtBooking.setString(9, formdetailcode);
	        stmtBooking.setString(11, desc);
	        stmtBooking.setString(12, airport);
	        stmtBooking.setString(13, flightno);
	        stmtBooking.setString(14, hotel);
	        stmtBooking.setString(15, roomno);
	        stmtBooking.setString(16, cmbloctype);
			stmtBooking.executeQuery();
			docno=stmtBooking.getInt("docNo");
			vocno=stmtBooking.getInt("voucher");
			session.setAttribute("LIMOBOOKVOCNO", vocno>0?vocno:0);
			if(docno<=0){
				return 0;
			}
			else{
				int isHideTariff=0;
				String isHideTariffSql = "select coalesce(method,0) method from gl_config where field_nme='hidetariff'";
				ResultSet rsisHideTariffSql = stmtBooking.executeQuery(isHideTariffSql);
				if(rsisHideTariffSql.next()) {
					isHideTariff = rsisHideTariffSql.getInt("method");
				}
				
				String updateVessel="";
				
				if(isHideTariff==1) {
					updateVessel = ", vesselno='"+vesselno+"', vesselname='"+vesselname+"'";
				}
				
				String strupdate="update gl_limobookm set refno='"+refno+"' "+updateVessel+" where doc_no="+docno;
				int update=conn.createStatement().executeUpdate(strupdate);
				if(update<0){
					return 0;
				}
				conn.commit();
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return docno;
	}

	public boolean edit(int docno, Date sqldate, String hidclient,
			String hidguest, String guest, String guestcontactno,
			String hidchknewguest, HttpSession session, String mode,
			String formdetailcode, String brchName,String desc,String airport,String flightno,String hotel,String roomno,String cmbloctype,ClsLimoBookingAction masteraction) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int guestdocno=0;
			if(hidchknewguest.equalsIgnoreCase("1")){
				Statement stmt=conn.createStatement();
				ResultSet rsguestmaxdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) maxguestdoc from gl_limoguest");
				while(rsguestmaxdoc.next()){
					guestdocno=rsguestmaxdoc.getInt("maxguestdoc");
				}
				ResultSet rse = stmt.executeQuery("select coalesce(method,0) config from gl_config where field_nme='guestdetailview'");
                int met = 0;
                if(rse.next()){
                    met = rse.getInt("config");
                }
                
                if(!(met==1) && !guest.trim().equalsIgnoreCase("")){
				int guestinsert=stmt.executeUpdate("insert into gl_limoguest(doc_no,guest,guestcontactno,status,cldocno)values("+guestdocno+",'"+guest+"','"+guestcontactno+"',3,"+hidclient+")");
                }
				hidguest=guest.trim().equalsIgnoreCase("")?"0":guestdocno+"";
			}
			if(hidguest.equalsIgnoreCase("")){
				hidguest="0";
			}
			String refno=masteraction.getRefno().trim();
			String vesselname = masteraction.getVesselname().trim(); //topzeed
			String vesselno = masteraction.getVesselno().trim(); //topzeed
			
			vesselname = vesselname.equalsIgnoreCase("") || vesselname.equalsIgnoreCase("undefined") || vesselname==null?"":vesselname;
			vesselno = vesselno.equalsIgnoreCase("") || vesselno.equalsIgnoreCase("undefined") || vesselno==null?"":vesselno;
			refno=refno.equalsIgnoreCase("") || refno.equalsIgnoreCase("undefined") || refno==null?"":refno;
			System.out.println("Guest id:"+hidguest);
			CallableStatement stmtBooking =conn.prepareCall("{call limoBookingMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtBooking.setInt(10, docno);
			stmtBooking.setDate(1, sqldate);
	        stmtBooking.setString(2, hidclient);
	        stmtBooking.setString(3, hidguest);
	        stmtBooking.setString(4, brchName);
	        stmtBooking.setString(5, session.getAttribute("USERID").toString());
	        stmtBooking.setString(6, session.getAttribute("COMPANYID").toString());
	        stmtBooking.setString(7, hidchknewguest);
	        stmtBooking.setString(8, mode);
	        stmtBooking.setString(9, formdetailcode);
	        stmtBooking.setString(11, desc);
	        stmtBooking.setString(12, airport);
	        stmtBooking.setString(13, flightno);
	        stmtBooking.setString(14, hotel);
	        stmtBooking.setString(15, roomno);
	        stmtBooking.setString(16, cmbloctype);
	        stmtBooking.setString(17, "0");
			int val=stmtBooking.executeUpdate();
			if(val<0){
				return false;
			}
			else{
				int isHideTariff=0;
				String isHideTariffSql = "select coalesce(method,0) method from gl_config where field_nme='hidetariff'";
				ResultSet rsisHideTariffSql = stmtBooking.executeQuery(isHideTariffSql);
				if(rsisHideTariffSql.next()) {
					isHideTariff = rsisHideTariffSql.getInt("method");
				}
				
				String updateVessel="";
				
				if(isHideTariff==1) {
					updateVessel = ", vesselno='"+vesselno+"', vesselname='"+vesselname+"'";
				}
				String strupdate="update gl_limobookm set refno='"+refno+"' "+updateVessel+" where doc_no="+docno;
				int update=conn.createStatement().executeUpdate(strupdate);
				if(update<0){
					return false;
				}
				else{
					//Updating in Mgmt
					String strupdatemgmt="update gl_limomanagement set guest=(SELECT guest FROM gl_limoguest WHERE doc_no="+hidguest+" AND STATUS=3),client=(SELECT refname FROM my_acbook WHERE cldocno="+hidclient+" AND dtype='CRM' AND STATUS=3),remarks='"+desc+"',refno='"+refno+"' where docno="+docno;
					int updatemgmt=conn.createStatement().executeUpdate(strupdatemgmt);
					if(updatemgmt<0){
						return false;
					}
				}
				conn.commit();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public int delete(int docno, Date sqldate, String hidclient,
			String hidguest, String guest, String guestcontactno,
			String hidchknewguest, HttpSession session, String mode,
			String formdetailcode, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int guestdocno=0;
			
			if(hidguest.equalsIgnoreCase("")){
				hidguest="0";
			}
			
			String sqlValidation = "SELECT COUNT(*) tot FROM gl_limobookm m LEFT JOIN gl_limomanagement g ON m.doc_no=g.docno WHERE m.doc_no="+docno+" AND !(g.bstatus<2 OR g.bstatus=9)";
            ResultSet rs = conn.createStatement().executeQuery(sqlValidation);
            if(rs.next()) {
                int status = rs.getInt("tot");
                if(status>0) {
                    return -1;
                }
            }
			
			CallableStatement stmtBooking =conn.prepareCall("{call limoBookingMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtBooking.setInt(10, docno);
			stmtBooking.setDate(1, sqldate);
	        stmtBooking.setString(2, hidclient);
	        stmtBooking.setString(3, hidguest);
	        stmtBooking.setString(4, brchName);
	        stmtBooking.setString(5, session.getAttribute("USERID").toString());
	        stmtBooking.setString(6, session.getAttribute("COMPANYID").toString());
	        stmtBooking.setString(7, hidchknewguest);
	        stmtBooking.setString(8, mode);
	        stmtBooking.setString(9, formdetailcode);
	        stmtBooking.setString(11, "");
	        stmtBooking.setString(12, "");
	        stmtBooking.setString(13, "");
	        stmtBooking.setString(14, "");
	        stmtBooking.setString(15, "");
	        stmtBooking.setString(16, "");
	        stmtBooking.setString(17, "0");
			int val=stmtBooking.executeUpdate();
			if(val<0){
				return 0;
			}
			else{
				conn.commit();
				return 1;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public boolean insertTarif(int docno, ArrayList<String> transferarray, ArrayList<String> hoursarray, HttpSession session, String mode) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("Inside insertTarif");
		//for(int i=0;i<transferarray.size();i++) System.out.println(transferarray.get(i));
		Connection conn=null;
		int transdocno=0;
		int hoursdocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String brhid=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			String logmode=mode.equalsIgnoreCase("A")?"A":"E";
		//	System.out.println("Mode - "+logmode);
			int cldocno=0;
			String getClient = "select cldocno from gl_limobookm where doc_no="+docno;
			ResultSet rsgc = stmt.executeQuery(getClient);
			if(rsgc.next()) {
				cldocno=rsgc.getInt("cldocno");
			}
			
			//String strdeletetransfer="delete from gl_limobooktransfer where bookdocno="+docno;
			//int deletetransfer=stmt.executeUpdate(strdeletetransfer);
			for(int i=0;i<transferarray.size();i++){
				//System.out.println(transferarray.get(i));
				String arr[]=transferarray.get(i).split("::");
			//	System.out.println(arr[14]+"//"+arr[15]+"//"+arr[16]+"//"+arr[17]+"//"+arr[18]+"//"+arr[19]);
				if(!arr[1].equalsIgnoreCase("") && !arr[1].equalsIgnoreCase("undefined") && arr[1]!=null){
					java.sql.Date pickupdate=null;
					if(arr[1].length()==10){
						pickupdate=objcommon.changeStringtoSqlDate(arr[1]);
					}
					else{
						pickupdate=objcommon.changetstmptoSqlDate(arr[1]);
					}
					
					
					
					String isPresent = "select * from gl_limobooktransfer where bookdocno="+docno+" and docname='"+arr[0]+"'";
					ResultSet rsisPresent=stmt.executeQuery(isPresent);
					boolean docPresent = false;
					while(rsisPresent.next()) {
						transdocno=rsisPresent.getInt("doc_no");
						docPresent=true;
					}
					
					int guestdocno=0;
					String hidguest="";
					
					System.out.println("guest - "+arr.length);
					if(arr[23].trim().equalsIgnoreCase("")||arr[23].trim().equalsIgnoreCase("0")){
						ResultSet rsguestcheck = stmt.executeQuery("select doc_no docno from gl_limoguest where guest='"+arr[24].trim()+"' and guestcontactno='"+arr[25].trim()+"'");
						System.out.println("select doc_no docno from gl_limoguest where guest='"+arr[24].trim()+"' and guestcontactno='"+arr[25].trim()+"'");
						if(rsguestcheck.next() && !arr[24].trim().equalsIgnoreCase("")) {
							guestdocno=rsguestcheck.getInt("docno");
						}
						if(guestdocno==0) {
							ResultSet rsguestmaxdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) maxguestdoc from gl_limoguest");
							while(rsguestmaxdoc.next()){
								guestdocno=rsguestmaxdoc.getInt("maxguestdoc");
							}
							ResultSet rse = stmt.executeQuery("select coalesce(method,0) config from gl_config where field_nme='guestdetailview'");
			                int met = 0;
			                if(rse.next()){
			                    met = rse.getInt("config");
			                }
			                
			                if(!(met==1) && !arr[24].trim().equalsIgnoreCase("")){
							int guestinsert=stmt.executeUpdate("insert into gl_limoguest(doc_no,guest,guestcontactno,status,cldocno)values("+guestdocno+",'"+arr[24]+"','"+arr[25]+"',3,"+cldocno+")");
			                }
			            }
						hidguest=arr[24].trim().equalsIgnoreCase("")?"0":guestdocno+"";
					} else {
						hidguest=arr[23];
					}
					
					if(docPresent) {
						String updateTransfer="UPDATE gl_limobooktransfer SET pickupdate='"+pickupdate+"', pickuptime='"+arr[2]+"',pickuplocid='"+arr[3]+"', pickupadress='"+arr[4]+"',dropfflocid='"+arr[5]
								+"',dropoffaddress='"+arr[6]+"',brandid='"+arr[7]+"',modelid='"+arr[8]+"',tarifdocno='"+((arr[10].equalsIgnoreCase("") && !arr[10].equalsIgnoreCase("undefined") && arr[10]!=null)?"0":arr[10])+"',gid='"+((arr[12].equalsIgnoreCase("") && !arr[12].equalsIgnoreCase("undefined") && arr[12]!=null)?"0":arr[12])+"',nos='"+arr[9]+"',chkothersrvc='"+arr[11]+"',tarifdetaildocno='"+((arr[13].equalsIgnoreCase("") && !arr[13].equalsIgnoreCase("undefined") && arr[13]!=null)?"0":arr[13])+
								"',transfertype='"+arr[14]+"',estdist='"+((arr[15].equalsIgnoreCase("") && !arr[15].equalsIgnoreCase("undefined") && arr[15]!=null)?"0":arr[15])+"',tarif='"+((arr[17].equalsIgnoreCase("") && !arr[17].equalsIgnoreCase("undefined") && arr[17]!=null)?"0":arr[17])
								+"',exdistrate='"+((arr[18].equalsIgnoreCase("") && !arr[18].equalsIgnoreCase("undefined") && arr[18]!=null)?"0":arr[18])+"',extimerate='"+((arr[19].equalsIgnoreCase("") && !arr[19].equalsIgnoreCase("undefined") && arr[19]!=null)?"0":arr[19])+"' WHERE bookdocno="+docno+" AND docname='"+arr[0]+"'";
						int uTransfer=stmt.executeUpdate(updateTransfer);
						if(uTransfer<=0){
							return false;
						}
					} else {
						
						
						CallableStatement stmtBooking =conn.prepareCall("{call limoBookingDetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtBooking.setInt(1, docno);  // bookdocno
						stmtBooking.setString(2, arr[0]);  //docname
						stmtBooking.setDate(3,pickupdate); //pickupdate
						stmtBooking.setString(4, arr[2]); //pickuptime
						stmtBooking.setString(5, arr[3]); //pickuplocid
						stmtBooking.setString(6, arr[4]); //pickupaddress
						stmtBooking.setString(7, arr[5]); //dropofflocid
						stmtBooking.setString(8, arr[6]); //dropoffaddress
						stmtBooking.setString(9, (arr[7].equalsIgnoreCase("") && !arr[7].equalsIgnoreCase("undefined") && arr[7]!=null)?"0":arr[7]); //brandid
						stmtBooking.setString(10, (arr[8].equalsIgnoreCase("") && !arr[8].equalsIgnoreCase("undefined") && arr[8]!=null)?"0":arr[8]); //modelid
						stmtBooking.setString(11, arr[9]); //nos
						stmtBooking.setString(12, (arr[10].equalsIgnoreCase("") && !arr[10].equalsIgnoreCase("undefined") && arr[10]!=null)?"0":arr[10]); //tarifdocno
						stmtBooking.setString(13, arr[11]); //chkothersrvc
						stmtBooking.setString(14, (arr[12].equalsIgnoreCase("") && !arr[12].equalsIgnoreCase("undefined") && arr[12]!=null)?"0":arr[12]); //gid
						stmtBooking.setString(15, "transfer"); //tarifmode
						stmtBooking.setString(16, "0"); //blockhrs
						stmtBooking.setString(17, (arr[13].equalsIgnoreCase("") && !arr[13].equalsIgnoreCase("undefined") && arr[13]!=null)?"0":arr[13]); //tariffdetaildoc
						stmtBooking.registerOutParameter(18, java.sql.Types.INTEGER); //doc_No
						stmtBooking.setString(19, arr[14]); //transfertype
						stmtBooking.setString(20, (arr[15].equalsIgnoreCase("") && !arr[15].equalsIgnoreCase("undefined") && arr[15]!=null)?"0":arr[15]); //estdist
						stmtBooking.setString(21, arr[16]); //esttime
						stmtBooking.setString(22, (arr[17].equalsIgnoreCase("") && !arr[17].equalsIgnoreCase("undefined") && arr[17]!=null)?"0":arr[17]); //tarif
						stmtBooking.setString(23, (arr[18].equalsIgnoreCase("") && !arr[18].equalsIgnoreCase("undefined") && arr[18]!=null)?"0":arr[18]); //exdistrate
						stmtBooking.setString(24, (arr[19].equalsIgnoreCase("") && !arr[19].equalsIgnoreCase("undefined") && arr[19]!=null)?"0":arr[19]); //extimerate
						stmtBooking.setString(25, "0"); //hrtarif
						stmtBooking.setString(26, "0"); //exhrrate
						stmtBooking.setString(27, "0"); //nighttarif
						stmtBooking.setString(28, "0"); //nightexhrrate
						stmtBooking.executeQuery();
						transdocno=stmtBooking.getInt("docNo");
						if(transdocno<=0){
							return false;
						}
					}
					String triptype="";
					if(arr.length==20 || arr[20].equalsIgnoreCase("") || arr[20]==null || arr[20].equalsIgnoreCase("undefined")){
						triptype="Transfer";
					}
					else{
						triptype=arr[20];
					}
					int triptypedocno=0,triptypetax=0;
					if(!triptype.equalsIgnoreCase("")){
						String strtriptype="select doc_no,triptype,taxable from gl_limotriptype where status=3 and triptype='"+triptype+"'";
						ResultSet rstriptype=stmt.executeQuery(strtriptype);
						while(rstriptype.next()){
							triptypedocno=rstriptype.getInt("doc_no");
							triptypetax=rstriptype.getInt("taxable");
						}
					}
					String pax=arr[21].trim();
					String allowance=arr[22].trim();
					pax=pax.equalsIgnoreCase("undefined") || pax.equalsIgnoreCase("") || pax==null?"0":pax;
					String strupdatetransfer="update gl_limobooktransfer set description='"+arr[26].trim()+"',guestid="+hidguest+", allowance="+allowance+", pax="+pax+",triptypedocno="+triptypedocno+",triptypetax="+triptypetax+",triptype='"+triptype+"',detailupdate=if(tarifdocno>0,1,0) where doc_no="+transdocno;
					System.out.println(strupdatetransfer);
					int updatetransfer=stmt.executeUpdate(strupdatetransfer);
					if(updatetransfer<0){
						return false;
					}
				}
			}
		//	String strdeletehours="delete from gl_limobookhours where bookdocno="+docno;
		//	int deletehours=stmt.executeUpdate(strdeletehours);
			
			for(int i=0;i<hoursarray.size();i++){
				//System.out.println("Dao Hours array data //"+hoursarray.get(i));
				String arr[]=hoursarray.get(i).split("::");
				if(!arr[1].equalsIgnoreCase("") && !arr[1].equalsIgnoreCase("undefined") && arr[1]!=null){
					java.sql.Date pickupdate=objcommon.changeStringtoSqlDate(arr[1]);
					
					
					String isPresent = "select * from gl_limobookhours where bookdocno="+docno+" and docname='"+arr[0]+"'";
					ResultSet rsisPresent=stmt.executeQuery(isPresent);
					boolean docPresent = false;
					while(rsisPresent.next()) {
						hoursdocno=rsisPresent.getInt("doc_no");
						docPresent=true;
					}
					

					int guestdocno=0;
					String hidguest="";
					
					
					System.out.println("guest - "+arr[19]);
					
					if(arr[19].trim().equalsIgnoreCase("")||arr[19].trim().equalsIgnoreCase("0")){
						ResultSet rsguestcheck = stmt.executeQuery("select doc_no docno from gl_limoguest where guest='"+arr[20].trim()+"' and guestcontactno='"+arr[21].trim()+"'");
						System.out.println("select doc_no docno from gl_limoguest where guest='"+arr[20].trim()+"' and guestcontactno='"+arr[21].trim()+"'");
						if(rsguestcheck.next() && !arr[20].trim().equalsIgnoreCase("")) {
							guestdocno=rsguestcheck.getInt("docno");
						}
						if(guestdocno==0) {
							ResultSet rsguestmaxdoc=stmt.executeQuery("select coalesce(max(doc_no)+1,1) maxguestdoc from gl_limoguest");
							while(rsguestmaxdoc.next()){
								guestdocno=rsguestmaxdoc.getInt("maxguestdoc");
							}
							ResultSet rse = stmt.executeQuery("select coalesce(method,0) config from gl_config where field_nme='guestdetailview'");
			                int met = 0;
			                if(rse.next()){
			                    met = rse.getInt("config");
			                }
			                
			                if(!(met==1) && !arr[20].trim().equalsIgnoreCase("")){
							int guestinsert=stmt.executeUpdate("insert into gl_limoguest(doc_no,guest,guestcontactno,status,cldocno)values("+guestdocno+",'"+arr[20]+"','"+arr[21]+"',3,"+cldocno+")");
			                }
			           }
						hidguest=arr[20].trim().equalsIgnoreCase("")?"0":guestdocno+"";
					} else {
						hidguest=arr[19];
					}
					
					/*
					 * if(arr[19].equalsIgnoreCase("")||arr[19].equalsIgnoreCase("0")){ ResultSet
					 * rsguestmaxdoc=stmt.
					 * executeQuery("select coalesce(max(doc_no)+1,1) maxguestdoc from gl_limoguest"
					 * ); while(rsguestmaxdoc.next()){
					 * guestdocno=rsguestmaxdoc.getInt("maxguestdoc"); } int guestinsert=stmt.
					 * executeUpdate("insert into gl_limoguest(doc_no,guest,guestcontactno,status)values("
					 * +guestdocno+",'"+arr[20]+"','"+arr[21]+"',3)"); hidguest=guestdocno+""; }
					 * else { hidguest=arr[19]; }
					 */
					
					if(docPresent) {
						String updateTransfer="UPDATE gl_limobookhours SET blockhrs='"+arr[11].trim()+"', pickupdate='"+pickupdate+"', pickuptime='"+arr[2].trim()+"',pickuplocid='"+arr[3].trim()+"', pickupaddress='"+arr[4].trim()
								+"',brandid='"+arr[5].trim()+"',modelid='"+arr[6].trim()+"',nos='"+arr[7].trim()+"',tarifdocno='"+((arr[8].trim().equalsIgnoreCase("") && !arr[8].equalsIgnoreCase("undefined") && arr[8]!=null)?"0":arr[8].trim())
								+"',gid='"+((arr[10].trim().equalsIgnoreCase("") && !arr[10].equalsIgnoreCase("undefined") && arr[10]!=null)?"0":arr[10].trim())+"',chkothersrvc='"+arr[9].trim()+"',tarifdetaildocno='"+((arr[12].trim().equalsIgnoreCase("") && !arr[12].equalsIgnoreCase("undefined") && arr[12]!=null)?"0":arr[12].trim())
								+"',transfertype='"+arr[13].trim()+"',tarif='"+((arr[14].trim().equalsIgnoreCase("") && !arr[14].equalsIgnoreCase("undefined") && arr[14]!=null)?"0":arr[14].trim())+"',exhrrate='"+((arr[15].trim().equalsIgnoreCase("") && !arr[15].equalsIgnoreCase("undefined") && arr[15]!=null)?"0":arr[15].trim())+"',nighttarif='"+((arr[16].trim().equalsIgnoreCase("") && !arr[16].equalsIgnoreCase("undefined") && arr[16]!=null)?"0":arr[16].trim())+"',nightexhrrate='"+((arr[17].trim().equalsIgnoreCase("") && !arr[17].equalsIgnoreCase("undefined") && arr[17]!=null)?"0":arr[17].trim())+"' WHERE  bookdocno='"+docno+"' AND docname='"+arr[0].trim()+"'";
						int uTransfer=stmt.executeUpdate(updateTransfer);
						if(uTransfer<=0){
							return false;
						}
					} else {
						CallableStatement stmtBooking =conn.prepareCall("{call limoBookingDetailDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtBooking.setInt(1, docno);
						stmtBooking.setString(2, arr[0].trim());
						stmtBooking.setDate(3,pickupdate);
						stmtBooking.setString(4, arr[2].trim());
						stmtBooking.setString(5, arr[3].trim());
						stmtBooking.setString(6, arr[4].trim());
						stmtBooking.setString(7, "0");
						stmtBooking.setString(8, "0");
						stmtBooking.setString(9, arr[5].trim());
						stmtBooking.setString(10, arr[6].trim());
						stmtBooking.setString(11, arr[7].trim());
						stmtBooking.setString(12, (arr[8].trim().equalsIgnoreCase("") && !arr[8].equalsIgnoreCase("undefined") && arr[8]!=null)?"0":arr[8].trim());
						stmtBooking.setString(13, arr[9].trim());
						stmtBooking.setString(14, (arr[10].trim().equalsIgnoreCase("") && !arr[10].equalsIgnoreCase("undefined") && arr[10]!=null)?"0":arr[10].trim());
						stmtBooking.setString(15, "hours");
						stmtBooking.setString(16, arr[11].trim());
						stmtBooking.setString(17, (arr[12].trim().equalsIgnoreCase("") && !arr[12].equalsIgnoreCase("undefined") && arr[12]!=null)?"0":arr[12].trim());
						stmtBooking.registerOutParameter(18, java.sql.Types.INTEGER);
						stmtBooking.setString(19, arr[13].trim());
						stmtBooking.setString(20, "0");
						stmtBooking.setString(21, "0");
						stmtBooking.setString(22, "0");
						stmtBooking.setString(23, "0");
						stmtBooking.setString(24, "0");
						stmtBooking.setString(25, (arr[14].trim().equalsIgnoreCase("") && !arr[14].equalsIgnoreCase("undefined") && arr[14]!=null)?"0":arr[14].trim());
						stmtBooking.setString(26, (arr[15].trim().equalsIgnoreCase("") && !arr[15].equalsIgnoreCase("undefined") && arr[15]!=null)?"0":arr[15].trim());
						stmtBooking.setString(27, (arr[16].trim().equalsIgnoreCase("") && !arr[16].equalsIgnoreCase("undefined") && arr[16]!=null)?"0":arr[16].trim());
						stmtBooking.setString(28, (arr[17].trim().equalsIgnoreCase("") && !arr[17].equalsIgnoreCase("undefined") && arr[17]!=null)?"0":arr[17].trim());
						stmtBooking.executeQuery();
						hoursdocno=stmtBooking.getInt("docNo");
						if(hoursdocno<=0){
							return false;
						}
					}
					String allowance = arr[18].trim();
					String strupdatetransfer="update gl_limobookhours set description='"+arr[22].trim()+"',guestid="+hidguest+",allowance="+allowance+" where doc_no="+hoursdocno;
					System.out.println(strupdatetransfer);
					int updatetransfer=stmt.executeUpdate(strupdatetransfer);
					if(updatetransfer<0){
						return false;
					}
					
				}
			}
			if(mode.equalsIgnoreCase("A")){
				String bookinsert="insert into gl_limomanagement( docno, bstatus, job, client, guest, clientid, guestid, brhid, type, blockhrs, pickupdate, pickuptime,"
						+" plocation, paddress, dlocation, daddress, brand, model, fname, fno, nos, tdocno,triptype,groupname,tarifdocno,tarifdetaildocno,pax,bookuserid,refno,remarks,description)"
						+" select * from (select m.doc_no,1,lt.docname,a.refname,g.guest,m.cldocno,lt.guestid,m.brhid,'Transfer',0 blockhrs,lt.pickupdate,lt.pickuptime,l.location picklocation,lt.pickupadress,ld.location,lt.dropoffaddress,brd.brand_name brand, model.vtype model, if(locationtype='flight',M.airport,hotel),"
						+" if(locationtype='flight',flightno,roomno),lt.nos,lt.doc_no ddocno,lt.triptype,grp.gname,lt.tarifdocno,lt.tarifdetaildocno,lt.pax,m.userid,m.refno,m.desc1,lt.description from gl_limobookm m"
						+" left join my_acbook a on m.cldocno=a.cldocno and a.dtype='crm'"
						+" left join gl_limobooktransfer lt on m.doc_no=lt.bookdocno"
						+" left join gl_cordinates l on (lt.pickuplocid=l.doc_no)"
						+" left join gl_cordinates ld on (lt.dropfflocid=ld.doc_no)"
						+" left join gl_limoguest g on g.doc_no=lt.guestid left join gl_vehbrand brd on (lt.brandid=brd.doc_no)"
						+" left join gl_vehmodel model on (lt.modelid=model.doc_no) left join gl_vehgroup grp on (lt.gid=grp.doc_no) where lt.doc_no is not null"
						+" union all select m.doc_no,1,lt.docname,a.refname,g.guest,m.cldocno,lt.guestid,m.brhid,'Limo',lt.blockhrs,lt.pickupdate,lt.pickuptime,l.location picklocation,"
						+" lt.pickupaddress,'' location,'' dropoffaddress,brd.brand_name brand, model.vtype model, if(locationtype='flight',M.airport,hotel),"
						+" if(locationtype='flight',flightno,roomno),lt.nos,lt.doc_no ddcono,'' triptype,grp.gname,lt.tarifdocno,lt.tarifdetaildocno,'',m.userid,m.refno,m.desc1,lt.description from gl_limobookm m"
						+" left join my_acbook a on m.cldocno=a.cldocno and a.dtype='crm'"
						+" left join gl_limobookhours lt on m.doc_no=lt.bookdocno"
						+" left join gl_cordinates l on (lt.pickuplocid=l.doc_no)"
						+" left join gl_limoguest g on g.doc_no=lt.guestid left join gl_vehbrand brd on (lt.brandid=brd.doc_no)"
						+" left join gl_vehmodel model on (lt.modelid=model.doc_no) left join gl_vehgroup grp on (lt.gid=grp.doc_no) where lt.doc_no is not null) a where doc_no='"+docno+"' order by a.doc_no";
				int bval=stmt.executeUpdate(bookinsert);
				if(bval<=0){
					return false;
				}
			}
			else{
				String strgetdata="select * from ("+
				" select m.doc_no bookdocno,tran.docname,if(mgmt.job is null,0,1) mgmtexist from gl_limobookm m left join gl_limobooktransfer tran on (m.doc_no=tran.bookdocno) left join gl_limomanagement mgmt on"+
				" (tran.bookdocno=mgmt.docno and tran.docname=mgmt.job) where m.status<>7 union all"+
				" select m.doc_no bookdocno,hrs.docname,if(mgmt.job is null,0,1) mgmtexist from gl_limobookm m left join gl_limobookhours hrs on (m.doc_no=hrs.bookdocno) left join gl_limomanagement mgmt on"+
				" (hrs.bookdocno=mgmt.docno and hrs.docname=mgmt.job) where m.status<>7) a where a.bookdocno="+docno+" and a.docname is not null";
				System.out.println(strgetdata);
				ResultSet rsgetdata=stmt.executeQuery(strgetdata);
				ArrayList<String> mgmtarray=new ArrayList<>();
				while(rsgetdata.next()){
					mgmtarray.add(rsgetdata.getString("bookdocno")+"::"+rsgetdata.getString("docname")+"::"+rsgetdata.getString("mgmtexist"));
				}
				for(int z=0;z<mgmtarray.size();z++){
					if(mgmtarray.get(z).split("::")[2].equalsIgnoreCase("1")){
						if(mgmtarray.get(z).split("::")[1].charAt(0)=='T'){
							//Transfer
							String strupdatemgmt="update gl_limomanagement mgmt left join gl_limobooktransfer lt on (lt.bookdocno=mgmt.docno and lt.docname=mgmt.job)"+
							" left join gl_cordinates l on (lt.pickuplocid=l.doc_no) left join gl_cordinates ld on (lt.dropfflocid=ld.doc_no)"+
							" left join gl_vehbrand brd on (lt.brandid=brd.doc_no) left join gl_vehmodel model on (lt.modelid=model.doc_no)"+
							" left join gl_vehgroup grp on (lt.gid=grp.doc_no) left join gl_limoguest g on g.doc_no=lt.guestid "+
							" left join gl_limobookm m on m.doc_no=mgmt.docno"+
							" set mgmt.type='Transfer',mgmt.pickupdate=lt.pickupdate,mgmt.pickuptime=lt.pickuptime,mgmt.plocation=l.location,"+
							" mgmt.paddress=lt.pickupadress,mgmt.dlocation=ld.location,mgmt.daddress=lt.dropoffaddress,mgmt.triptype=lt.triptype,"+
							" mgmt.brand=brd.brand_name,mgmt.model=model.vtype,mgmt.groupname=grp.gname,mgmt.tarifdocno=lt.tarifdocno,mgmt.tarifdetaildocno=lt.tarifdetaildocno"+
							" ,mgmt.pax=lt.pax,mgmt.refno=m.refno,mgmt.remarks=m.desc1 ,mgmt.guestid=lt.guestid,mgmt.description=lt.description,mgmt.guest=g.guest "+
							" where lt.doc_no is not null and mgmt.docno="+mgmtarray.get(z).split("::")[0]+" and mgmt.job='"+mgmtarray.get(z).split("::")[1]+"'";
							System.out.println("1:"+strupdatemgmt);
							int updatemgmt=stmt.executeUpdate(strupdatemgmt);
							if(updatemgmt<0){
								return false;
							}
						}
						else if(mgmtarray.get(z).split("::")[1].charAt(0)=='L'){
							//Limo
							String strupdatemgmt="update gl_limomanagement mgmt left join gl_limobookhours lt on (lt.bookdocno=mgmt.docno and lt.docname=mgmt.job)"+
							" left join gl_cordinates l on (lt.pickuplocid=l.doc_no) "+
							" left join gl_vehbrand brd on (lt.brandid=brd.doc_no) left join gl_vehmodel model on (lt.modelid=model.doc_no)"+
							" left join gl_vehgroup grp on (lt.gid=grp.doc_no) left join gl_limoguest g on g.doc_no=lt.guestid "+
							" left join gl_limobookm m on m.doc_no=mgmt.docno"+
							" set mgmt.type='Limo',mgmt.blockhrs=lt.blockhrs,mgmt.pickupdate=lt.pickupdate,mgmt.pickuptime=lt.pickuptime,mgmt.plocation=l.location,"+
							" mgmt.paddress=lt.pickupaddress,mgmt.triptype='',mgmt.brand=brd.brand_name,mgmt.model=model.vtype,"+
							" mgmt.groupname=grp.gname,mgmt.tarifdocno=lt.tarifdocno,mgmt.tarifdetaildocno=lt.tarifdetaildocno,mgmt.refno=m.refno,mgmt.remarks=m.desc1,mgmt.guestid=lt.guestid,mgmt.description=lt.description,mgmt.guest=g.guest where lt.doc_no is not null and mgmt.docno="+mgmtarray.get(z).split("::")[0]+" and mgmt.job='"+mgmtarray.get(z).split("::")[1]+"'";
							System.out.println("2:"+strupdatemgmt);
							int updatemgmt=stmt.executeUpdate(strupdatemgmt);
							if(updatemgmt<0){
								return false;
							}
						}
					}
					else{
						if(mgmtarray.get(z).split("::")[1].charAt(0)=='T'){
							//Transfer
							String strupdatemgmt="insert into gl_limomanagement( docno, bstatus, job, client, guest, clientid, guestid, brhid, type, blockhrs, pickupdate, pickuptime,"
									+" plocation, paddress, dlocation, daddress, brand, model, fname, fno, nos, tdocno,triptype,groupname,tarifdocno,tarifdetaildocno,pax,bookuserid,refno,remarks,description)"
									+" select * from (select m.doc_no,1,lt.docname,a.refname,g.guest,m.cldocno,m.guestno,m.brhid,'Transfer',0 blockhrs,lt.pickupdate,lt.pickuptime,l.location picklocation,lt.pickupadress,ld.location,lt.dropoffaddress,brd.brand_name brand, model.vtype model, if(locationtype='flight',M.airport,hotel),"
									+" if(locationtype='flight',flightno,roomno),lt.nos,lt.doc_no ddocno,lt.triptype,grp.gname,lt.tarifdocno,lt.tarifdetaildocno,lt.pax,m.userid,m.refno,m.desc1,lt.description from gl_limobookm m"
									+" left join my_acbook a on m.cldocno=a.cldocno and a.dtype='crm'"
									+" left join gl_limobooktransfer lt on m.doc_no=lt.bookdocno"
									+" left join gl_cordinates l on (lt.pickuplocid=l.doc_no)"
									+" left join gl_cordinates ld on (lt.dropfflocid=ld.doc_no)"
									+" left join gl_limoguest g on g.doc_no=m.guestno left join gl_vehbrand brd on (lt.brandid=brd.doc_no)"
									+" left join gl_vehmodel model on (lt.modelid=model.doc_no) left join gl_vehgroup grp on (lt.gid=grp.doc_no) where lt.doc_no is not null) a where doc_no='"+docno+"' and a.docname='"+mgmtarray.get(z).split("::")[1]+"' order by a.doc_no";
							System.out.println("3:"+strupdatemgmt);
							int updatemgmt=stmt.executeUpdate(strupdatemgmt);
							if(updatemgmt<0){
								return false;
							}
						}
						else if(mgmtarray.get(z).split("::")[1].charAt(0)=='L'){
							//Transfer
							String strupdatemgmt="insert into gl_limomanagement( docno, bstatus, job, client, guest, clientid, guestid, brhid, type, blockhrs, pickupdate, pickuptime,"
									+" plocation, paddress, dlocation, daddress, brand, model, fname, fno, nos, tdocno,triptype,groupname,tarifdocno,tarifdetaildocno,pax,bookuserid,refno,remarks,description)"
									+" select * from (select m.doc_no,1,lt.docname,a.refname,g.guest,m.cldocno,m.guestno,m.brhid,'Limo',lt.blockhrs,lt.pickupdate,lt.pickuptime,l.location picklocation,"
									+" lt.pickupaddress,'' location,'' dropoffaddress,brd.brand_name brand, model.vtype model, if(locationtype='flight',M.airport,hotel),"
									+" if(locationtype='flight',flightno,roomno),lt.nos,lt.doc_no ddcono,'' triptype,grp.gname,lt.tarifdocno,lt.tarifdetaildocno,'',m.userid,m.refno,m.desc1,lt.description from gl_limobookm m"
									+" left join my_acbook a on m.cldocno=a.cldocno and a.dtype='crm'"
									+" left join gl_limobookhours lt on m.doc_no=lt.bookdocno"
									+" left join gl_cordinates l on (lt.pickuplocid=l.doc_no)"
									+" left join gl_limoguest g on g.doc_no=m.guestno left join gl_vehbrand brd on (lt.brandid=brd.doc_no)"
									+" left join gl_vehmodel model on (lt.modelid=model.doc_no) left join gl_vehgroup grp on (lt.gid=grp.doc_no) where lt.doc_no is not null) a where doc_no='"+docno+"' and a.docname='"+mgmtarray.get(z).split("::")[1]+"' order by a.doc_no";
							System.out.println("4:"+strupdatemgmt);
							int updatemgmt=stmt.executeUpdate(strupdatemgmt);
							if(updatemgmt<0){
								return false;
							}
						}
					}
				}
			}
			//System.out.println("bookinsert====="+bookinsert);      
			
			String strinsertlog="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+","+brhid+",'LBK',now(),"+userid+",'"+logmode+"')";
			int loginsert=stmt.executeUpdate(strinsertlog);
			if(loginsert<=0){
				return false;
			}
			conn.commit();
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public boolean insertSrvc(int docno, ArrayList<String> srvcarray, ArrayList<String> billarray) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int maindocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String type="";
			int deletesrvcval=stmt.executeUpdate("delete from gl_limobooksrvc where bookdocno="+docno+" and status=3");
			for(int i=0;i<srvcarray.size();i++){
				String arr[]=srvcarray.get(i).split("::");
				if(String.valueOf(arr[0].trim().charAt(0)).equalsIgnoreCase("T")){
					type="transfer";
				}
				else if(String.valueOf(arr[0].trim().charAt(0)).equalsIgnoreCase("L")){
					type="hours";
				}
				java.sql.Date greetdate=null,vipdate=null,boquedate=null;
				if(!arr[3].trim().equalsIgnoreCase("") && !arr[3].trim().equalsIgnoreCase("undefined") && arr[3].trim()!=null && !arr[3].trim().equalsIgnoreCase("null")){
					greetdate=objcommon.changetstmptoSqlDate(arr[3].trim());
				}
				if(!arr[6].trim().equalsIgnoreCase("") && !arr[6].equalsIgnoreCase("undefined") && arr[6]!=null && !arr[6].equalsIgnoreCase("null")){
					vipdate=objcommon.changetstmptoSqlDate(arr[6].trim());
				}
				if(!arr[9].trim().equalsIgnoreCase("") && !arr[6].equalsIgnoreCase("undefined") && arr[9]!=null && !arr[9].equalsIgnoreCase("null")){
					boquedate=objcommon.changetstmptoSqlDate(arr[9].trim());
				}
				if(!arr[2].trim().equalsIgnoreCase("") && !arr[2].equalsIgnoreCase("undefined") && arr[2]!=null){
				CallableStatement stmtBooking =conn.prepareCall("{call limoBookingSrvcDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtBooking.registerOutParameter(19, java.sql.Types.INTEGER);
				stmtBooking.setInt(1, docno);
				stmtBooking.setString(2, arr[0].trim());
				stmtBooking.setString(3, type);
				stmtBooking.setString(4, arr[1].trim());
				stmtBooking.setString(5, arr[2].trim());
				stmtBooking.setDate(6, greetdate);
				stmtBooking.setString(7, arr[4].trim().equalsIgnoreCase("") || arr[4].trim().equalsIgnoreCase("undefined") || arr[4]==null?"":arr[4].trim());
				System.out.println(arr[5].trim());
				stmtBooking.setString(8, arr[5].trim().equalsIgnoreCase("") || arr[5].trim().equalsIgnoreCase("undefined")?null:arr[5].trim());
				stmtBooking.setDate(9, vipdate);
				stmtBooking.setString(10, arr[7].trim().equalsIgnoreCase("") || arr[7].trim().equalsIgnoreCase("undefined") || arr[7]==null?"":arr[7].trim());
				stmtBooking.setString(11, arr[8].trim().equalsIgnoreCase("") || arr[8].trim().equalsIgnoreCase("undefined")?null:arr[8].trim());
				stmtBooking.setDate(12, boquedate);
				stmtBooking.setString(13, arr[10].trim().equalsIgnoreCase("") || arr[10].trim().equalsIgnoreCase("undefined") || arr[10]==null?"":arr[10].trim());
				stmtBooking.setString(14, arr[11].trim().equalsIgnoreCase("") || arr[11].trim().equalsIgnoreCase("undefined") || arr[11].equalsIgnoreCase("1")?null:arr[11].trim());
				stmtBooking.setString(15,"srvc");
				stmtBooking.setString(16,"0");
				stmtBooking.setString(17,"0");
				stmtBooking.setString(18,"0");
				stmtBooking.executeQuery();
				maindocno=stmtBooking.getInt("docNo");
				if(maindocno<=0){
					return false;
				}
				}
			}
			int billdocno=0;
			int deletebillval=stmt.executeUpdate("delete from gl_limobookbill where bookdocno="+docno+" and status=3");
			for(int i=0;i<billarray.size();i++){
			    System.out.println(billarray.get(i));
				String arr[]=billarray.get(i).split("::");
				if(!arr[0].trim().equalsIgnoreCase("") && !arr[0].trim().equalsIgnoreCase("undefined") && arr[0]!=null && !arr[0].trim().equalsIgnoreCase("null")){
					CallableStatement stmtBooking =conn.prepareCall("{call limoBookingSrvcDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtBooking.registerOutParameter(19, java.sql.Types.INTEGER);
					stmtBooking.setInt(1, docno);
					stmtBooking.setString(2, "0");
					stmtBooking.setString(3, "0");
					stmtBooking.setString(4, "0");
					stmtBooking.setString(5, "0");
					stmtBooking.setDate(6, null);
					stmtBooking.setString(7, "0");
					stmtBooking.setString(8, "0");
					stmtBooking.setDate(9, null);
					stmtBooking.setString(10, "0");
					stmtBooking.setString(11, "0");
					stmtBooking.setDate(12, null);
					stmtBooking.setString(13, "0");
					stmtBooking.setString(14, "0");
					stmtBooking.setString(15,"bill");
					stmtBooking.setString(16,arr[0].equalsIgnoreCase("") || arr[0].equalsIgnoreCase("undefined") || arr[0]==null?"":arr[0]);
					stmtBooking.setString(17,arr[1].equalsIgnoreCase("") || arr[1].equalsIgnoreCase("undefined") || arr[1]==null?"":arr[1]);
					stmtBooking.setString(18,arr[2].equalsIgnoreCase("") || arr[2].equalsIgnoreCase("undefined") || arr[2]==null?"":arr[2]);
					stmtBooking.executeQuery();
					billdocno=stmtBooking.getInt("docNo");
					if(billdocno<=0){
						return false;
					}
				}
			}
			conn.commit();
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray getSrvcTarifData(String airportid) throws SQLException{
		JSONArray srvcdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,greetrate greet,viprate vip,boquerate boque from gl_limoextrasrvctarifd where doc_no=(select max(doc_no) from "+
			" gl_limoextrasrvctarifd where status=3 and airportid="+airportid+")";
			ResultSet rs=stmt.executeQuery(strsql);
			srvcdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return srvcdata;
	}

	public int insertBill(int val, ArrayList<String> billarray)throws SQLException {
		// TODO Auto-generated method stub
		int billdocno=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			int deletebillval=stmt.executeUpdate("delete from gl_limobookbill where bookdocno="+val+" and status=3");
			for(int i=0;i<billarray.size();i++){
				String arr[]=billarray.get(i).split("::");
				if(arr.length>0 && !arr[0].equalsIgnoreCase("") && !arr[0].equalsIgnoreCase("undefined") && arr[0]!=null && !arr[0].equalsIgnoreCase("null")){
					CallableStatement stmtBooking =conn.prepareCall("{call limoBookingSrvcDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmtBooking.registerOutParameter(19, java.sql.Types.INTEGER);
					stmtBooking.setInt(1, val);
					stmtBooking.setString(2, "0");
					stmtBooking.setString(3, "0");
					stmtBooking.setString(4, "0");
					stmtBooking.setString(5, "0");
					stmtBooking.setDate(6, null);
					stmtBooking.setString(7, "0");
					stmtBooking.setString(8, "0");
					stmtBooking.setDate(9, null);
					stmtBooking.setString(10, "0");
					stmtBooking.setString(11, "0");
					stmtBooking.setDate(12, null);
					stmtBooking.setString(13, "0");
					stmtBooking.setString(14, "0");
					stmtBooking.setString(15,"bill");
					stmtBooking.setString(16,arr[0].equalsIgnoreCase("") || arr[0].equalsIgnoreCase("undefined") || arr[0]==null?"":arr[0]);
					stmtBooking.setString(17,arr[1].equalsIgnoreCase("") || arr[1].equalsIgnoreCase("undefined") || arr[1]==null?"":arr[1]);
					stmtBooking.setString(18,arr[2].equalsIgnoreCase("") || arr[2].equalsIgnoreCase("undefined") || arr[2]==null?"":arr[2]);
					stmtBooking.executeQuery();
					billdocno=stmtBooking.getInt("docNo");
					if(billdocno<=0){
						return 0;
					}
				}
			}
			conn.commit();
			return billdocno;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}

	public String getLimoDateAdd(String pickupdate,int id)throws SQLException {
		// TODO Auto-generated method stub
		String strdate="";
		java.sql.Date sqldate=null;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			if(!pickupdate.equalsIgnoreCase("") && !pickupdate.equalsIgnoreCase("undefined") && pickupdate!=null && id==1){
				sqldate=objcommon.changetstmptoSqlDate(pickupdate);
			}
			if(!pickupdate.equalsIgnoreCase("") && !pickupdate.equalsIgnoreCase("undefined") && pickupdate!=null && id==2){
				sqldate=objcommon.changeStringtoSqlDate(pickupdate);
			}
			String str="";
			if(id==1){
				str="select DATE_FORMAT('"+sqldate+"', '%d.%m.%Y') limodate";
			}
			else if(id==2){
				str="select DATE_FORMAT(date_add('"+sqldate+"',interval 1 day), '%d.%m.%Y') limodate";
			}
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				strdate=rs.getString("limodate");
			}
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return strdate;
	}

	public boolean insertGuest(int val, ArrayList<String> guestarray, HttpSession session, String mode) throws SQLException {
		Connection conn=null;
		int maindocno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String type="";
			String dno="";
			boolean failedupdate=false;
			if(guestarray.size()>0) {
				int deletesrvcval=stmt.executeUpdate("delete from gl_limoguest where rdocno="+val+" and status=3");
			}
			for(int i=0;i<guestarray.size();i++){
				String maxdocno="select coalesce(max(doc_no)+1,1) docno  from gl_limoguest";
				ResultSet rs = stmt.executeQuery(maxdocno);
				if(rs.next()) {
					dno=rs.getString("docno");
				}
				String arr[]=guestarray.get(i).split("::");
				String ins = "insert into gl_limoguest ( doc_no,cldocno,rdocno,guest,guestcontactno) values ("+dno+","+arr[0].trim()+","+val+",'"+arr[2].trim()+"','"+arr[3].trim()+"')"; 
				System.out.println(ins);
				int executeUpdate = stmt.executeUpdate(ins);
				if(executeUpdate<=0) {
					failedupdate=true;
				}
				
			}
			if(!failedupdate) {
				conn.commit();
				return true;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	
}
