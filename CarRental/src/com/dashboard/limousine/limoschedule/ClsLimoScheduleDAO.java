package com.dashboard.limousine.limoschedule;

import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.google.gson.Gson;

public class ClsLimoScheduleDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray getSearchData(String branch,String id,String date,String enddate) throws SQLException{
		JSONArray searchdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return searchdata;
		}
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			String sqltest="";
			
			java.sql.Date sqldate=null;
			java.sql.Date sqlenddate=null;
           
            if(!date.equalsIgnoreCase("")){
                sqldate=ClsCommon.changeStringtoSqlDate(date);
            }
            
            if(!enddate.equalsIgnoreCase("")){
                sqlenddate=ClsCommon.changeStringtoSqlDate(enddate);
            }
			
			if(!branch.equalsIgnoreCase("")){
				if(branch.equalsIgnoreCase("a")) {

				} else {
					sqltest+=" and book.brhid="+branch;
				}
				
			}
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(book.refno,'') refno,book.voc_no vocno,book.locationtype,book.airport,book.flightno,book.hotel,book.roomno,book.desc1 description,book.doc_no docno,book.date,book.guestno,book.newguest hidchknewguest,ac.refname,ac.cldocno,ac.per_mob,dr.dlno,guest.guest,guest.guestcontactno"+
			" from gl_limobookm book left join gl_limoguest guest on book.guestno=guest.doc_no left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join gl_drdetails dr on (ac.cldocno=dr.cldocno and ac.dtype='CRM') where book.status=3 and book.date between '"+sqldate+"' and '"+sqlenddate+"' "+sqltest+" group by book.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=ClsCommon.convertToJSON(rs);
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
	
	
	public JSONArray getTarifData(String tarifmode,String brandid,String modelid,String pickuplocid,String dropofflocid,String blockhrs,String cldocno,String transfertype) throws SQLException{
		JSONArray tarifdata=new JSONArray();
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			int groupid=0;
			System.out.println("-----____-----"+tarifmode);
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
				tarifdata=ClsCommon.convertToJSON(rs);	
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
	
	
	public JSONArray scheduleMultipleBooking(HttpSession session, String date, String enddate, String time, String noofvisit, String serviceterm,
			String days, String alternatedays, String daynos, int id, String schdetails) throws SQLException{           
		
		
		JSONArray jsonArray = new JSONArray();
		if(id==0){
			return jsonArray;
		}

		Gson gson = new Gson();
	        // Convert JSON string to Map
	        Type typej = new com.google.gson.reflect.TypeToken<Map<String, String>>(){}.getType();
	        Map<String, String> schmap = gson.fromJson(schdetails, typej);

		
		Connection conn = null; 
		try {
			java.sql.Date xdate=null;
			java.sql.Date fdate=null;
			java.sql.Date endsdate=null;
            String day="",dates="";
			int xsrno=0;
			date.trim();
			if(alternatedays.equalsIgnoreCase("1")) {
				serviceterm="ALTERNATIVE";
			}  else {
				serviceterm="Daily";
			}
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				xdate = ClsCommon.changeStringtoSqlDate(date);
				fdate = ClsCommon.changeStringtoSqlDate(date);  
			}

			enddate.trim();
			if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
				endsdate = ClsCommon.changeStringtoSqlDate(enddate);
			}

			String xsql="";

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();  
			Statement stmt2 = conn.createStatement();  
            int duelen=0;
            System.out.println("serviceterm="+serviceterm);
            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; //checking if its monthly or daily or weekly
			String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
			System.out.println("strsql1==="+strsql1);   
			ResultSet rs1 = stmt.executeQuery(strsql1);  
			while(rs1.next()) {
				duelen=rs1.getInt("duelen");
			}
			int noofv=0;
			if(!noofvisit.equalsIgnoreCase("undefined")) {
				duelen=Integer.parseInt(noofvisit)-1;
			}else {
				noofvisit="0";
			}
			
			if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
				duelen=duelen/2; 
				xsql=2 + type;
			}else {
				xsql=1 + type;
			}
			//System.out.println(days+"=days===serviceterm="+serviceterm); 
			//System.out.println("noofvisit="+noofvisit);
			int t2=0,a1=0,a2=1,a3=0;
			//t2= Integer.parseInt(noofvisit)<=0?1:Integer.parseInt(noofvisit);  
			int cond=0;
			int occurence=0;
			if(duelen>0) {
				cond=1;
				occurence=duelen;
			}
			t2=1;
			System.out.println("Occurence=="+occurence+"    "+duelen);
			do							
			{	
				if (xsrno>duelen) break;

				JSONObject obj = new JSONObject();
				if(xsrno>duelen) break; 
				
				if(!alternatedays.equalsIgnoreCase("1") && serviceterm.equalsIgnoreCase("DAILY")) {                
					//System.out.println("=IN 1=");  
					int t1=1;    
					String sqltst="";   
					if(!days.equalsIgnoreCase("8")) {     
						 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";  
					}
					if(!daynos.equalsIgnoreCase("0")) {
						 sqltst+=" and DAY(a.DATE) in("+daynos+")";     
					}
					String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
				    System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()) {
						xdate=rs.getDate("date"); 
						System.out.println(cond+"xdate="+xdate+"    "+occurence);
						if(cond>0) {
							if(occurence<0) break;
							while(!(xdate==null)){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";        
								System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
								}
								System.out.println(schmap.get("dropoffloc"));
								if(t1 <= t2) {      
									obj.put("pickupdate",dates);
									obj.put("pickuptime",time); 
									obj.put("pickuplocation",schmap.get("pickuploc"));
									obj.put("pickuplocationid",schmap.get("pickuplocid"));
									obj.put("pickupaddress",schmap.get("pickupad"));
									obj.put("dropofflocation",schmap.get("dropoffloc"));
									obj.put("dropofflocationid",schmap.get("dropofflocid"));
									obj.put("dropoffaddress",schmap.get("dropoffad"));
									obj.put("transfertype",schmap.get("type"));
									obj.put("triptype",schmap.get("triptype"));
									obj.put("brand",schmap.get("brand"));
									obj.put("brandid",schmap.get("brandid"));
									obj.put("model",schmap.get("model"));
									obj.put("modelid",schmap.get("modelid"));
									obj.put("nos",schmap.get("nos"));
									obj.put("pax",schmap.get("pax"));
									obj.put("tarifdocno",schmap.get("tariffdocno"));
									obj.put("blockhrs",schmap.get("blockhours"));
									obj.put("exhrrate",schmap.get("exhourrate"));
									obj.put("nighttarif",schmap.get("nighttariff"));
									obj.put("nightexhrrate",schmap.get("nightextrahour"));
									obj.put("exdistancerate",schmap.get("extradistancerate"));
									obj.put("extimerate",schmap.get("extratimerate"));
									obj.put("gid",schmap.get("gid"));
									obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
									obj.put("day",day);
									jsonArray.add(obj);
									t1++;
									occurence--;
								}else { 
									t1 = 1;
									break;
								}
							}
							
							
						} else {
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";        
								System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
								}
								if(t1 <= t2) {      
									obj.put("pickupdate",dates);
									obj.put("pickuptime",time); 
									obj.put("pickuplocation",schmap.get("pickuploc"));
									obj.put("pickuplocationid",schmap.get("pickuplocid"));
									obj.put("pickupaddress",schmap.get("pickupad"));
									obj.put("dropofflocation",schmap.get("dropoffloc"));
									obj.put("dropofflocationid",schmap.get("dropofflocid"));
									obj.put("dropoffaddress",schmap.get("dropoffad"));
									obj.put("transfertype",schmap.get("type"));
									obj.put("triptype",schmap.get("triptype"));
									obj.put("brand",schmap.get("brand"));
									obj.put("brandid",schmap.get("brandid"));
									obj.put("model",schmap.get("model"));
									obj.put("modelid",schmap.get("modelid"));
									obj.put("nos",schmap.get("nos"));
									obj.put("pax",schmap.get("pax"));
									obj.put("tarifdocno",schmap.get("tariffdocno"));
									obj.put("blockhrs",schmap.get("blockhours"));
									obj.put("exhrrate",schmap.get("exhourrate"));
									obj.put("nighttarif",schmap.get("nighttariff"));
									obj.put("nightexhrrate",schmap.get("nightextrahour"));
									obj.put("exdistancerate",schmap.get("extradistancerate"));
									obj.put("extimerate",schmap.get("extratimerate"));
									obj.put("gid",schmap.get("gid"));
									obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
									obj.put("day",day);
									jsonArray.add(obj);
									t1++;
									
								}else { 
									t1 = 1;
									break;
								}
							}
						}
					}
					rs.close();
					break;   
				}else if(alternatedays.equalsIgnoreCase("1")){    
					System.out.println("=IN 4="); 
					if(cond>0) {
						while(!(xdate==null)){
							//System.out.println("=a2="+a2);   
							
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') a1";       
							System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date"); 
								a1 = rs2.getInt("a1");     
							}
							if((a1 == a3) && (a2 <= t2)) {         
								obj.put("pickupdate",dates);
								obj.put("pickuptime",time); 
								obj.put("pickuplocation",schmap.get("pickuploc"));
								obj.put("pickuplocationid",schmap.get("pickuplocid"));
								obj.put("pickupaddress",schmap.get("pickupad"));
								obj.put("dropofflocation",schmap.get("dropoffloc"));
								obj.put("dropofflocationid",schmap.get("dropofflocid"));
								obj.put("dropoffaddress",schmap.get("dropoffad"));
								obj.put("transfertype",schmap.get("type"));
								obj.put("triptype",schmap.get("triptype"));
								obj.put("brand",schmap.get("brand"));
								obj.put("brandid",schmap.get("brandid"));
								obj.put("model",schmap.get("model"));
								obj.put("modelid",schmap.get("modelid"));
								obj.put("nos",schmap.get("nos"));
								obj.put("pax",schmap.get("pax"));
								obj.put("tarifdocno",schmap.get("tariffdocno"));
								obj.put("blockhrs",schmap.get("blockhours"));
								obj.put("exhrrate",schmap.get("exhourrate"));
								obj.put("nighttarif",schmap.get("nighttariff"));
								obj.put("nightexhrrate",schmap.get("nightextrahour"));
								obj.put("exdistancerate",schmap.get("extradistancerate"));
								obj.put("extimerate",schmap.get("extratimerate"));
								obj.put("gid",schmap.get("gid"));
								obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
								obj.put("day",day);
								jsonArray.add(obj);
							}else if(a1 != a3) {  
								a2=1;   
								obj.put("pickupdate",dates);
								obj.put("pickuptime",time);
								obj.put("pickuplocation",schmap.get("pickuploc"));
								obj.put("pickuplocationid",schmap.get("pickuplocid"));
								obj.put("pickupaddress",schmap.get("pickupad"));
								obj.put("dropofflocation",schmap.get("dropoffloc"));
								obj.put("dropofflocationid",schmap.get("dropofflocid"));
								obj.put("dropoffaddress",schmap.get("dropoffad"));
								obj.put("transfertype",schmap.get("type"));
								obj.put("triptype",schmap.get("triptype"));
								obj.put("brand",schmap.get("brand"));
								obj.put("brandid",schmap.get("brandid"));
								obj.put("model",schmap.get("model"));
								obj.put("modelid",schmap.get("modelid"));
								obj.put("nos",schmap.get("nos"));
								obj.put("pax",schmap.get("pax"));
								obj.put("tarifdocno",schmap.get("tariffdocno"));
								obj.put("blockhrs",schmap.get("blockhours"));
								obj.put("exhrrate",schmap.get("exhourrate"));
								obj.put("nighttarif",schmap.get("nighttariff"));
								obj.put("nightexhrrate",schmap.get("nightextrahour"));
								obj.put("exdistancerate",schmap.get("extradistancerate"));
								obj.put("extimerate",schmap.get("extratimerate"));
								obj.put("gid",schmap.get("gid"));
								obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
								obj.put("day",day);
								jsonArray.add(obj);
							}else {
								a2=1;   
								break;
							}
							if(cond>0) occurence--;
							a2++; 
							a3 = a1; 
							
						}
					} else {
						if(cond>0 && occurence<=0) {
							a2=1;
							break;
							
						}
						while(!(xdate==null) || !(endsdate.after(xdate))){
							//System.out.println("=a2="+a2);   
							
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') a1";       
							System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date"); 
								a1 = rs2.getInt("a1");     
							}
							if((a1 == a3) && (a2 <= t2)) {         
								obj.put("pickupdate",dates);
								obj.put("pickuptime",time); 
								obj.put("pickuplocation",schmap.get("pickuploc"));
								obj.put("pickuplocationid",schmap.get("pickuplocid"));
								obj.put("pickupaddress",schmap.get("pickupad"));
								obj.put("dropofflocation",schmap.get("dropoffloc"));
								obj.put("dropofflocationid",schmap.get("dropofflocid"));
								obj.put("dropoffaddress",schmap.get("dropoffad"));
								obj.put("transfertype",schmap.get("type"));
								obj.put("triptype",schmap.get("triptype"));
								obj.put("brand",schmap.get("brand"));
								obj.put("brandid",schmap.get("brandid"));
								obj.put("model",schmap.get("model"));
								obj.put("modelid",schmap.get("modelid"));
								obj.put("nos",schmap.get("nos"));
								obj.put("pax",schmap.get("pax"));
								obj.put("tarifdocno",schmap.get("tariffdocno"));
								obj.put("blockhrs",schmap.get("blockhours"));
								obj.put("exhrrate",schmap.get("exhourrate"));
								obj.put("nighttarif",schmap.get("nighttariff"));
								obj.put("nightexhrrate",schmap.get("nightextrahour"));
								obj.put("exdistancerate",schmap.get("extradistancerate"));
								obj.put("extimerate",schmap.get("extratimerate"));
								obj.put("gid",schmap.get("gid"));
								obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
								obj.put("day",day);
								jsonArray.add(obj);
							}else if(a1 != a3) {  
								a2=1;   
								obj.put("pickupdate",dates);
								obj.put("pickuptime",time); 
								obj.put("pickuplocation",schmap.get("pickuploc"));
								obj.put("pickuplocationid",schmap.get("pickuplocid"));
								obj.put("pickupaddress",schmap.get("pickupad"));
								obj.put("dropofflocation",schmap.get("dropoffloc"));
								obj.put("dropofflocationid",schmap.get("dropofflocid"));
								obj.put("dropoffaddress",schmap.get("dropoffad"));
								obj.put("transfertype",schmap.get("type"));
								obj.put("triptype",schmap.get("triptype"));
								obj.put("brand",schmap.get("brand"));
								obj.put("brandid",schmap.get("brandid"));
								obj.put("model",schmap.get("model"));
								obj.put("modelid",schmap.get("modelid"));
								obj.put("nos",schmap.get("nos"));
								obj.put("pax",schmap.get("pax"));
								obj.put("tarifdocno",schmap.get("tariffdocno"));
								obj.put("blockhrs",schmap.get("blockhours"));
								obj.put("exhrrate",schmap.get("exhourrate"));
								obj.put("nighttarif",schmap.get("nighttariff"));
								obj.put("nightexhrrate",schmap.get("nightextrahour"));
								obj.put("exdistancerate",schmap.get("extradistancerate"));
								obj.put("extimerate",schmap.get("extratimerate"));
								obj.put("gid",schmap.get("gid"));
								obj.put("tarifdetaildocno",schmap.get("tarifdetaildocno"));
								obj.put("day",day);
								jsonArray.add(obj);
							}else {
								a2=1;   
								break;
							}
							a2++; 
							a3 = a1; 
							
						}
					}
					
					String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
					System.out.println("sql="+sql);          
	                ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()) xdate=rs.getDate("fdate");     
					rs.close(); 
					
				}
				xsrno++;
			}while(true); 
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		System.out.println(jsonArray);
		return jsonArray;
	}
}
