package com.dashboard.operations.sponsornipurchase;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsSponsorNIPurchaseDAO {
	 ClsConnection ClsConnection = new ClsConnection();
	 ClsCommon ClsCommon = new ClsCommon();
	 
	 public JSONArray getNIData(String date,String id) throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return data;
			}
			Connection conn=null;
			try {
				conn=ClsConnection.getMyConnection();
				
				java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(date);
		        // Convert to Calendar
		        Calendar calendar = Calendar.getInstance();
		        calendar.setTime(sqlDate);
		        // Get number of days in the month
		        int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		        
		        String isCar = "coalesce(if(mr.vehicletype='Car',(vt.monthlyratecar/"+daysInMonth+")*COALESCE(mr.daysofwork,0),0),0) cartotal,";
		        
		        String isBike = "coalesce(if(mr.vehicletype='Motorbike',coalesce(mr.pickupcnt)*vt.pickupratebike,0),0) putot,coalesce(if(mr.vehicletype='Motorbike',(COALESCE(mr.dropoffcnt,0)*vt.droppoffratebike),0),0) dotot,coalesce(if(mr.vehicletype='Motorbike',(COALESCE(mr.pickupcancl,0)*pickupratebike*-1),0),0) puctot,coalesce(if(mr.vehicletype='Motorbike',(COALESCE(mr.dropoffcancl,0)*vt.droppoffratebike*-1),0),0) doctot,";
				
				String strsql="SELECT "+isCar+isBike+"IF(flog.empdocno IS NULL,0,1) isposted,coalesce((SELECT coalesce(doc_no,0) acno FROM my_head WHERE description='Services of Riders/Drivers'),0) acno,mr.vehicletype,coalesce(vt.monthlyratecar,0) carrate,coalesce(vt.pickupratebike,0) pickupratebike,coalesce(vt.droppoffratebike,0) droppoffratebike,emp.acno empacno,cl.acno acc_no,COALESCE(h.curid,0) curid,COALESCE(h.rate,0)rate,0 taxper,COALESCE(mr.pickupcnt,0) pickupcount,COALESCE(mr.dropoffcnt,0) dropoffcount,COALESCE(mr.pickupcancl,0) pickupcancel,COALESCE(mr.dropoffcancl,0) dropoffcancel,COALESCE(mr.daysofwork,0) daysofwork,coalesce(cl.doc_no,0) vendorid,coalesce(cl.refname,'') vendor,COALESCE(rl.clientuid,'') riderid,COALESCE(rl.doc_no,0) riderdocno,sal.doc_no saldocno,br.doc_no brhid,emp.doc_no empdocno,emp.codeno empid,emp.name empname,emp.pmmob empmobile,emp.emp_id,dsg.doc_no desigdocno,dsg.desc1 empdesig FROM hr_empm emp LEFT JOIN hr_setdesig dsg ON emp.desc_id=dsg.doc_no LEFT JOIN my_brch br ON emp.brhid=br.doc_no LEFT JOIN my_salesman sal ON emp.acno=sal.acc_no LEFT JOIN (SELECT MAX(doc_no) maxdocno,saldocno,saltype FROM gl_riderlog WHERE clstatus=0 GROUP BY saldocno) maxr ON sal.doc_no=maxr.saldocno AND sal.sal_type=maxr.saltype LEFT JOIN gl_riderlog rl ON maxr.maxdocno=rl.doc_no left join my_rip mr ON mr.rider_id=rl.clientuid AND mr.month=MONTH('"+sqlDate+"') AND mr.year=YEAR('"+sqlDate+"') LEFT JOIN my_acbook ac ON rl.clientacno=ac.acno inner join my_velink vl on emp.doc_no=vl.employeeid and vl.status=3 left join my_acbook CL on cl.doc_no=vl.vendorid and cl.dtype='VND' left join my_vtariff vt on vt.vendorid=cl.doc_no and vt.status=3 LEFT JOIN my_head h ON h.doc_no=cl.acno LEFT JOIN my_nipsponsorlog flog ON flog.empdocno=emp.doc_no AND MONTH(flog.date)=MONTH('"+sqlDate+"') AND YEAR(flog.date)=YEAR('"+sqlDate+"') WHERE emp.status=3";
				System.out.println(strsql);
				ResultSet rs=conn.createStatement().executeQuery(strsql);
				data=ClsCommon.convertToJSON(rs);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			finally {
				if(conn!=null && !conn.isClosed()) {
					conn.close();
				}
			}
			
			return data;
		}
}
