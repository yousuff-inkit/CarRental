package com.dashboard.limousine.booking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoBookingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getFleetData() throws SQLException{
		JSONArray fleetdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			// TO list all the fleet regardless of the in/out status - topzeed
            String onlyInSql = " veh.status='IN' and";
            
            String isOnlySQL = "select coalesce(method,0) method from gl_config where field_nme = 'allowallfleet'";
            ResultSet rsisOnlySQL=stmt.executeQuery(isOnlySQL);
            if(rsisOnlySQL.next()) {
                onlyInSql = rsisOnlySQL.getInt("method")==1?"":onlyInSql;
            }
            // 
            String strsql="select veh.fleet_no,convert(concat(fleet_no,' - ',veh.reg_no,' - ',veh.flname),char(250)) flname from gl_vehmaster veh where veh.statu=3 and "+onlyInSql+" veh.limostatus=1";
			ResultSet rs=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return fleetdata;
	}
	public JSONArray gridData(String branch,String id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and bm.brhid="+branch+"";  
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and bm.pickupdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and bm.pickupdate<='"+sqltodate+"'";
			}
			
			int isHideTariff=0;
			String isHideTariffSql = "select coalesce(method,0) method from gl_config where field_nme='hidetariff'";
			ResultSet rsisHideTariffSql = stmt.executeQuery(isHideTariffSql);
			if(rsisHideTariffSql.next()) {
				isHideTariff = rsisHideTariffSql.getInt("method");
			}
			
			String isac = "";
			String isColumnAvailable="SELECT COUNT(*) count FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'gl_limomanagement' AND COLUMN_NAME = 'isassignconfirm' AND TABLE_SCHEMA = DATABASE()";
			ResultSet rsica = stmt.executeQuery(isColumnAvailable);
			if(rsica.next()) {
				System.out.println(rsica.getString("count"));
				isac = rsica.getInt("count")>0?"bm.isassignconfirm,":"";
			}
			
			String vesselDetails= isHideTariff==1?"lb.vesselname, lb.vesselno,":"";
			
			
		   /* String strsql="select "+vesselDetails+"usr.user_name bookuser,bm.bstatus, bm.multivehassign,CONCAT('GW-',b.code,DATE_FORMAT(lb.date,'%Y'),LPAD(bm.`docno`, 6, '0')) bookingno, round(bm.vendoramount,2) vendoramount,round(bm.vendordiscount,2) vendordiscount,round(bm.vendornetamount,2) vendornetamount,bm.assigntype,bm.refno,bm.triptype,bm.otherdetails,bm.pax,concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) regdetails,coalesce(bm.remarks,'') bookremarks,coalesce(bm.drivername,'') drivername,coalesce(bm.groupname,'') groupname,bm.tarifdocno,bm.tarifdetaildocno,if(date_format(now(),'%Y-%m-%d')=bm.pickupdate,1,0) datval,bm.rowno, coalesce(bm.docno,0) docno, coalesce(lb.voc_no,0) vocno, bm.brhid, bm.job, bm.client, bm.clientid, bm.guest, bm.guestid,"
		    		+ " bm.type, st.name status, bm.blockhrs, bm.pickupdate, bm.pickuptime,bm.plocation pickuplocation,bm.paddress pickupaddress,"
		    		+ " bm.dlocation dropofflocation,bm.daddress dropoffaddress, bm.brand, bm.model, bm.fname, bm.fno, bm.nos, coalesce(bm.tdocno,0) tdocno, bm.remarks "
		    		+ " from gl_limomanagement bm INNER JOIN my_brch b ON bm.`brhid`=b.`BRANCH` INNER JOIN gl_limobookm lb ON lb.`doc_no`=bm.`docno` left join gl_limostatusdet st on st.doc_no=bm.bstatus left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no left join my_user usr on bm.bookuserid=usr.doc_no where lb.status=3 and bm.confirm=0  "+sqltest+" order by pickupdate,pickuptime asc ";*/
		    
		    /*String strsql="select "+vesselDetails+"usr.user_name bookuser,bm.bstatus, bm.multivehassign,CONCAT('GW-',b.code,DATE_FORMAT(lb.date,'%Y'),LPAD(bm.`docno`, 6, '0')) bookingno, round(bm.vendoramount,2) vendoramount,round(bm.vendordiscount,2) vendordiscount,round(bm.vendornetamount,2) vendornetamount,bm.assigntype,bm.refno,bm.triptype,bm.otherdetails,bm.pax,concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) regdetails,coalesce(bm.remarks,'') bookremarks,coalesce(mv.drivername,'') drivername,coalesce(bm.groupname,'') groupname,bm.tarifdocno,bm.tarifdetaildocno,if(date_format(now(),'%Y-%m-%d')=bm.pickupdate,1,0) datval,bm.rowno, coalesce(bm.docno,0) docno, coalesce(lb.voc_no,0) vocno, bm.brhid, bm.job, bm.client, bm.clientid, bm.guest, bm.guestid,"
                    + " bm.type, st.name status, bm.blockhrs, bm.pickupdate, bm.pickuptime,bm.plocation pickuplocation,bm.paddress pickupaddress,"
                    + " bm.dlocation dropofflocation,bm.daddress dropoffaddress, bm.brand, bm.model, bm.fname, bm.fno, bm.nos, coalesce(bm.tdocno,0) tdocno, bm.remarks "
                    + " from gl_limomanagement bm INNER JOIN my_brch b ON bm.`brhid`=b.`BRANCH` INNER JOIN gl_limobookm lb ON lb.`doc_no`=bm.`docno` LEFT JOIN (\r\n" + 
                    "SELECT GROUP_CONCAT(sm.sal_name) drivername,bookingno,jobname FROM gl_multivehassign mv LEFT JOIN my_salesman sm ON sm.doc_no=mv.drvid AND sm.sal_type='DRV' GROUP BY bookingno,jobname) mv ON mv.bookingno=bm.docno AND mv.jobname=bm.job  left join gl_limostatusdet st on st.doc_no=bm.bstatus left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no left join my_user usr on bm.bookuserid=usr.doc_no where lb.status=3 and bm.confirm=0  "+sqltest+" order by pickupdate,pickuptime asc ";
   */
		      String strsql="select COALESCE(tar.tarif,0) tariff,coalesce(concat(lb.airport,' - ',lb.flightno),'') flightdetails, coalesce(concat(lb.hotel,' - ',lb.roomno),'') hoteldetails,gst.guest allguest,"+vesselDetails+isac+"usr.user_name bookuser,coalesce(extd.boquerate,0) babyseat,bm.bstatus, bm.multivehassign,CONCAT('GW-',b.code,DATE_FORMAT(lb.date,'%Y'),LPAD(bm.`docno`, 6, '0')) bookingno, round(bm.vendoramount,2) vendoramount,round(bm.vendordiscount,2) vendordiscount,round(bm.vendornetamount,2) vendornetamount,bm.assigntype,bm.refno,bm.triptype,bm.otherdetails,bm.pax,concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) regdetails,coalesce(bm.remarks,'') bookremarks,coalesce(ref.refname,mv.drivername,'') drivername,coalesce(bm.groupname,'') groupname,bm.tarifdocno,bm.tarifdetaildocno,if(date_format(now(),'%Y-%m-%d')=bm.pickupdate,1,0) datval,bm.rowno, coalesce(bm.docno,0) docno, coalesce(lb.voc_no,0) vocno, bm.brhid, bm.job, bm.client, bm.clientid, bm.guest, bm.guestid,"
	                    + " bm.type, st.name status, bm.blockhrs, bm.pickupdate, bm.pickuptime,bm.plocation pickuplocation,bm.paddress pickupaddress,"
	                    + " bm.dlocation dropofflocation,bm.daddress dropoffaddress, bm.brand, bm.model, bm.fname, bm.fno, bm.nos, coalesce(bm.tdocno,0) tdocno, bm.remarks,lb.desc1 description,bm.description jobdescription "
	                    + " from gl_limomanagement bm LEFT JOIN gl_limobooksrvc lbs ON lbs.`bookdocno`=bm.docno AND lbs.docname=bm.job left join (SELECT GROUP_CONCAT(guest,'-',guestcontactno) guest,rdocno FROM gl_limoguest WHERE STATUS=3 GROUP BY rdocno) gst ON gst.rdocno=bm.docno LEFT JOIN gl_limoextrasrvctarifd extd ON lbs.`boquetarifdocno`=extd.doc_no  AND extd.status=3 INNER JOIN my_brch b ON bm.`brhid`=b.`BRANCH` INNER JOIN gl_limobookm lb ON lb.`doc_no`=bm.`docno` LEFT JOIN (\r\n" + 
	                    "SELECT GROUP_CONCAT(sm.sal_name) drivername,bookingno,jobname FROM gl_multivehassign mv LEFT JOIN my_salesman sm ON sm.doc_no=mv.drvid AND sm.sal_type='DRV' GROUP BY bookingno,jobname) mv ON mv.bookingno=bm.docno AND mv.jobname=bm.job  left join gl_limostatusdet st on st.doc_no=bm.bstatus left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no LEFT JOIN (SELECT t.bookdocno,t.docname,ac.refname FROM gl_limobooktransfer t INNER JOIN my_acbook ac ON t.assignedvendor=ac.cldocno AND ac.dtype='VND' AND ac.status=3 UNION ALL SELECT t.bookdocno,t.docname,ac.refname FROM gl_limobookhours t INNER JOIN my_acbook ac ON t.assignedvendor=ac.cldocno AND ac.dtype='VND' AND ac.status=3) ref ON bm.docno=ref.bookdocno AND bm.job=ref.docname LEFT JOIN (SELECT t.bookdocno,t.docname, t.estdist,t.`esttime`,t.tarif,t.exdistrate,t.allowance, 0 exhrrate,0 nighttarif,0 nightexhrrate FROM gl_limobooktransfer t  UNION ALL SELECT t.bookdocno,t.docname, 0 estdist, 0 esttime ,t.tarif,0 exdistrate,t.allowance,t.exhrrate,t.nighttarif,t.nightexhrrate FROM gl_limobookhours t ) tar ON bm.docno=tar.bookdocno AND bm.job=tar.docname left join my_user usr on bm.bookuserid=usr.doc_no where lb.status=3 and bm.confirm=0  "+sqltest+" order by pickupdate,pickuptime asc ";
	   
			
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	}  
	public JSONArray gridExcel(String branch,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",sqltransferbranch="",sqlhoursbranch="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and bm.brhid="+branch+"";  
			}
		    String strsql="select date_format(bm.pickupdate,'%d.%m.%Y') 'Pickup date', bm.pickuptime 'Pickup time',coalesce(bm.otherdetails,'') 'Other Details',coalesce(bm.fname,'') 'Fleet Name',"+
			" concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) 'Fleet',coalesce(bm.drivername,'') 'Driver',coalesce(bm.pax,'') 'PAX',"+
		    " coalesce(bm.groupname,'') 'Group',coalesce(bm.bookremarks,'') 'Booking Remarks',bm.paddress 'Pickup address',bm.daddress 'Dropoff address',"+
			" coalesce(bm.guest,'') 'Guest',coalesce(bm.client,'') 'Client',coalesce(bm.triptype,'') 'Trip Type',bm.docno 'Doc No',bm.job 'Job',bm.type 'Type', st.name 'Status',"+
			" bm.plocation 'Pickup Location',bm.dlocation 'Dropoff Location',bm.remarks 'Remarks' from "+
			" gl_limomanagement bm left join gl_limostatusdet st on st.doc_no=bm.bstatus  left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no  where bm.confirm=0 "+sqltest+"";
		                        
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToEXCEL(rs);  
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	}
	public JSONArray getDriverData()throws SQLException{      
		JSONArray driverdata=new JSONArray();
		Connection conn=null;
		try{
			String sqltest="";
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();        
			String strsql="select doc_no,sal_name name,lic_no license,date,mobile from my_salesman where sal_type='DRV' and status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rs);   
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}
	public JSONArray searchuser(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select user_name user,doc_no from my_user";  
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
	public JSONArray loadflwupgrid(String docno) throws SQLException{ 
		JSONArray data=new JSONArray(); 
		Connection conn=null; 
		java.sql.Date edates = null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement(); 
		
		String strsql="select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
		//System.out.println("flwp--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
		data=objcommon.convertToJSON(rs);   
		} 
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
     return data;
  }
	
	
	
	public JSONArray getGuestGridData(String docno) throws SQLException {
		
			JSONArray data=new JSONArray(); 
			Connection conn=null; 
			try{
				conn=objconn.getMyConnection(); 
				Statement stmt=conn.createStatement(); 
				String sql = "select doc_no,guest,guestcontactno from gl_limoguest where rdocno="+docno;
				System.out.println("Jobexpense SQL = "+sql);
				ResultSet rs=stmt.executeQuery(sql);
				data=objcommon.convertToJSON(rs);   
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				conn.close(); 
			}
			return data;
		}
	
	
	public JSONArray loadJobExpenseGrid(String bookno, String job) throws SQLException {
		
		System.out.println(bookno+"  "+job);
			JSONArray data=new JSONArray(); 
			Connection conn=null; 
			try{
				conn=objconn.getMyConnection(); 
				Statement stmt=conn.createStatement(); 
				String sql = "SELECT ROUND(COALESCE(amount,0),2) amount, `desc` description, DATE_FORMAT(exp.date,'%d-%m-%Y') DATE, cm.mode,COALESCE(ct.mode,'') cardtype,exp.chqno chqno, IF(exp.paytype=3,exp.chqdate,'') chqdate  FROM gl_jobexp `exp` LEFT JOIN my_cardm cm ON cm.doc_no=exp.paytype AND cm.dtype='mode' LEFT JOIN my_cardm ct ON exp.cardtype=ct.doc_no AND ct.dtype='card' WHERE exp.bookno='"+bookno+"' AND exp.job='"+job+"'";
				System.out.println("Jobexpense SQL = "+sql);
				ResultSet rs=stmt.executeQuery(sql);
				data=objcommon.convertToJSON(rs);   
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				conn.close(); 
			}
			return data;
		}
	
		public JSONArray loadmultivehassignment(String bookno, String job) throws SQLException {
		
			System.out.println(bookno+"  "+job);
			JSONArray data=new JSONArray(); 
			Connection conn=null; 
			try{
				conn=objconn.getMyConnection(); 
				Statement stmt=conn.createStatement(); 
				String sql = "SELECT ma.addition, ma.drvid, ms.sal_name driver, ma.bookingno, ma.jobname, ma.fleetno, vm.FLNAME vehname, vm.REG_NO regno,CASE WHEN ma.bookingstatus=6 THEN 'Trip Started' when ma.bookingstatus=3 then 'Job Accepted' when ma.bookingstatus=5 then 'Waiting For Guest' WHEN ma.bookingstatus=7 THEN 'Trip Ended' WHEN ma.bookingstatus=8 THEN 'No Show' WHEN ma.bookingstatus=2 THEN 'Job Assigned' WHEN ma.bookingstatus=5 THEN 'Waiting for guest'  ELSE 'Cancelled' END AS status  from gl_multivehassign ma left join gl_vehmaster vm on vm.FLEET_NO=ma.fleetno and vm.statu=3 left join my_salesman ms on ms.doc_no=ma.drvid and ms.status=3 and ms.sal_type='DRV' where ma.bookingno='"+bookno+"' AND ma.jobname='"+job+"'";
				System.out.println("loadmultivehassignment SQL = "+sql);
				ResultSet rs=stmt.executeQuery(sql);
				data=objcommon.convertToJSON(rs);   
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				conn.close(); 
			}
			return data;
		}
	
	
	public JSONArray pendingGrid(String userid) throws SQLException{  
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();     
			        
			String strsql="select  us.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user us on us.doc_no=t.userid left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
			//System.out.println("pendingGrid--->>>"+strsql);                                 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
	public JSONArray getVendorData() throws SQLException {
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String strsql="select cldocno vendorid,refname vendor from my_acbook where dtype='VND' and status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
}