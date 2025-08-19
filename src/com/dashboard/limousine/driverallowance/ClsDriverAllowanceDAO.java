package com.dashboard.limousine.driverallowance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDriverAllowanceDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getAssignListData(String fromdate,String todate,String type,String driver,String branch,String id) throws SQLException{
		JSONArray assigndata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return assigndata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			String sqltransferbranch="";
			String sqlhoursbranch="";
			String sqltransferstatus="";
			String sqlhoursstatus="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				/*sqltest+=" and book.brhid="+branch;*/
				sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
				sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
			}
			if(sqlfromdate!=null){
				sqltest+=" and book.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and book.date<='"+sqltodate+"'";
			}
			if(!driver.equalsIgnoreCase("")){
				sqltest+=" and sal.sal_type='DRV' and sal.doc_no="+driver;
			}
			sqltransferstatus+=" and ma.bookingstatus>=7 and tran.masterstatus>=3 and tran.masterstatus<>4";
			sqlhoursstatus+=" and ma.bookingstatus>=7 and hours.masterstatus>=3 and hours.masterstatus<>4";
			
			int isShowMultiAssign=0;
			String sqlCheckMultiAssign = "select coalesce(method,0) method from gl_config where field_nme='showmultivehassign'";
			ResultSet rscm = stmt.executeQuery(sqlCheckMultiAssign);
			if(rscm.next()) {
				isShowMultiAssign=rscm.getInt("method");
			}
			
			if(type.equalsIgnoreCase("Transfer")){	
				if(isShowMultiAssign==1) {
					strsql = "SELECT CONVERT(CONCAT(veh.fleet_no,' - ',veh.flname),CHAR(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno, book.cldocno,book.guestno,tran.doc_no detaildocno,veh.brdid brandid,veh.vmodid modelid,tran.docname,ac.refname,guest.guest,'Transfer' TYPE,NULL blockhrs,tran.pickupdate, tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,  model.vtype model,tran.nos,tran.allowance FROM gl_limobookm book INNER JOIN gl_limobooktransfer tran ON (book.doc_no=tran.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=tran.bookdocno AND ma.jobname=tran.docname LEFT JOIN gl_vehmaster veh ON ma.fleetno=veh.fleet_no LEFT JOIN my_acbook ac ON  (book.cldocno=ac.cldocno AND ac.dtype='CRM') LEFT JOIN gl_limoguest guest ON (book.guestno=guest.doc_no) LEFT JOIN gl_cordinates pickup ON  (tran.pickuplocid=pickup.doc_no) LEFT JOIN gl_cordinates dropoff ON (tran.dropfflocid=dropoff.doc_no) LEFT JOIN gl_vehbrand brd ON veh.brdid=brd.doc_no  LEFT JOIN gl_vehmodel model ON (veh.vmodid=model.doc_no) LEFT JOIN my_salesman sal ON (ma.drvid=sal.doc_no AND sal.sal_type='DRV')  WHERE book.status=3 and tran.jvno=0 "+sqltest+sqltransferbranch+sqltransferstatus;
				} else {
					strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,"+
							" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
							" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
							" model.vtype model,tran.nos,tran.allowance from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) LEFT JOIN  gl_multivehassign ma ON ma.bookingno=tran.bookdocno AND ma.jobname=tran.docname left join my_acbook ac on "+
							" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
							" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
							" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
							" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3  and tran.jvno=0 "+sqltest+sqltransferbranch+sqltransferstatus;
				}
			}
			else if(type.equalsIgnoreCase("Limo")){
				if(isShowMultiAssign==1) {
					strsql ="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno," + 
							" book.guestno,hours.doc_no detaildocno,veh.brdid brandid,veh.vmodid modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate," + 
							" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model," + 
							" hours.nos,hours.allowance FROM gl_limobookm book INNER JOIN gl_limobookhours hours ON (book.doc_no=hours.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=hours.bookdocno AND ma.jobname=hours.docname LEFT JOIN gl_vehmaster veh ON ma.fleetno=veh.fleet_no  LEFT JOIN my_acbook ac ON (book.cldocno=ac.cldocno AND  ac.dtype='CRM') LEFT JOIN gl_limoguest guest ON (book.guestno=guest.doc_no) LEFT JOIN gl_cordinates pickup ON (hours.pickuplocid=pickup.doc_no) LEFT JOIN  gl_vehbrand brd ON (veh.brdid=brd.doc_no) LEFT JOIN gl_vehmodel model ON (veh.vmodid=model.doc_no) LEFT JOIN my_salesman sal ON  (ma.drvid=sal.doc_no AND sal.sal_type='DRV') WHERE book.status=3 and hours.jvno=0 "+sqltest+sqlhoursbranch+sqlhoursstatus;
				} else {
					strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
							" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
							" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
							" hours.nos from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=hours.bookdocno AND ma.jobname=hours.docname left join my_acbook ac on (book.cldocno=ac.cldocno and "+
							" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
							" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no)  left join my_salesman sal on "+
							" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 and hours.jvno=0 "+
							" "+sqltest+sqlhoursbranch+sqlhoursstatus;
				}
			}
			else{
				if(isShowMultiAssign==1) {
					strsql="SELECT CONVERT(CONCAT(veh.fleet_no,' - ',veh.flname),CHAR(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno, book.cldocno,book.guestno,tran.doc_no detaildocno,veh.brdid brandid,veh.vmodid modelid,tran.docname,ac.refname,guest.guest,'Transfer' TYPE,NULL blockhrs,tran.pickupdate, tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,  model.vtype model,tran.nos,tran.allowance FROM gl_limobookm book INNER JOIN gl_limobooktransfer tran ON (book.doc_no=tran.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=tran.bookdocno AND ma.jobname=tran.docname LEFT JOIN gl_vehmaster veh ON ma.fleetno=veh.fleet_no LEFT JOIN my_acbook ac ON  (book.cldocno=ac.cldocno AND ac.dtype='CRM') LEFT JOIN gl_limoguest guest ON (book.guestno=guest.doc_no) LEFT JOIN gl_cordinates pickup ON  (tran.pickuplocid=pickup.doc_no) LEFT JOIN gl_cordinates dropoff ON (tran.dropfflocid=dropoff.doc_no) LEFT JOIN gl_vehbrand brd ON veh.brdid=brd.doc_no  LEFT JOIN gl_vehmodel model ON (veh.vmodid=model.doc_no) LEFT JOIN my_salesman sal ON (ma.drvid=sal.doc_no AND sal.sal_type='DRV')  WHERE book.status=3 and tran.jvno=0 "+sqltest+sqltransferbranch+sqltransferstatus+" union all "+
							" select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
							" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
							" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
							" hours.nos,hours.allowance FROM gl_limobookm book INNER JOIN gl_limobookhours hours ON (book.doc_no=hours.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=hours.bookdocno AND ma.jobname=hours.docname LEFT JOIN gl_vehmaster veh ON ma.fleetno=veh.fleet_no  LEFT JOIN my_acbook ac ON (book.cldocno=ac.cldocno AND  ac.dtype='CRM') LEFT JOIN gl_limoguest guest ON (book.guestno=guest.doc_no) LEFT JOIN gl_cordinates pickup ON (hours.pickuplocid=pickup.doc_no) LEFT JOIN  gl_vehbrand brd ON (veh.brdid=brd.doc_no) LEFT JOIN gl_vehmodel model ON (veh.vmodid=model.doc_no) LEFT JOIN my_salesman sal ON  (ma.drvid=sal.doc_no AND sal.sal_type='DRV') WHERE book.status=3 and hours.jvno=0 "+
							" "+sqltest+sqlhoursbranch+sqlhoursstatus;
				} else {
					strsql="select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
							" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
							" model.vtype model,tran.nos,tran.allowance from gl_limobookm book inner join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=tran.bookdocno AND ma.jobname=tran.docname left join my_acbook ac on "+
							" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
							" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
							" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_salesman sal on (tran.assigneddriver=sal.doc_no and sal.sal_type='DRV') "+
							" left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no where book.status=3 and tran.jvno=0 "+sqltest+sqltransferbranch+sqltransferstatus+" union all "+
							" select convert(concat(veh.fleet_no,' - ',veh.flname),char(50)) fleet,veh.reg_no,sal.sal_name driver,book.doc_no bookdocno,book.cldocno,"+
							" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
							" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
							" hours.nos,hours.allowance from gl_limobookm book inner join gl_limobookhours hours on (book.doc_no=hours.bookdocno) LEFT JOIN gl_multivehassign ma ON ma.bookingno=hours.bookdocno AND ma.jobname=hours.docname left join my_acbook ac on (book.cldocno=ac.cldocno and "+
							" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
							" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_salesman sal on "+
							" (hours.assigneddriver=sal.doc_no and sal.sal_type='DRV') left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no where book.status=3 and hours.jvno=0 "+
							" "+sqltest+sqlhoursbranch+sqlhoursstatus;
				}
				
			}
			System.out.println("Assign Sql:"+strsql);
			ResultSet rsassign=stmt.executeQuery(strsql);
			assigndata=objcommon.convertToJSON(rsassign);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return assigndata;
	}
	
	public JSONArray getDriver(String id) throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_code,sal_name,lic_no,lic_exp_dt,authority,mobile mobno from my_salesman where status=3 and sal_type='DRV'";
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
}
