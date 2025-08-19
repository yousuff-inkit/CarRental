package com.dashboard.operations.riderpayroll;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;

import net.sf.json.JSONArray;

public class ClsRiderPayrollDAO {
	 ClsConnection ClsConnection = new ClsConnection();
	    ClsCommon ClsCommon = new ClsCommon();
	    
	    public HashMap<String, Object> getPrintParameters(String docNo,String brch,String month,String year) throws SQLException{
	    	HashMap<String, Object> params = new HashMap<String, Object>();
	    	 Connection conn = null;
	    	 try {
		            conn = ClsConnection.getMyConnection();
		            Statement stmt = conn.createStatement();
		            
		            String join="";
		            String pradj="0"; 
		            String chk = "select rider_id, sum(adjustments) adjustment from my_rip where month="+((Integer.parseInt(month)-1)<=0?12:(Integer.parseInt(month)-1))+" and year="+((Integer.parseInt(month)-1)<=0?Integer.parseInt(year)-1:year)+" group by rider_id";
		            ResultSet rs = stmt.executeQuery(chk);
		            if(rs.next()) {
		            	join = "left join (select rider_id, sum(adjustments) adjustment from my_rip where month="+((Integer.parseInt(month)-1)<=0?12:(Integer.parseInt(month)-1))+" and year="+((Integer.parseInt(month)-1)<=0?Integer.parseInt(year)-1:year)+" group by rider_id) rp on rp.rider_id=m.rider_id";
		            	pradj="COALESCE(rp.adjustment,0)";		
		            }
		            
		            
	                ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
	                double govfees=trafficcommon.getGovFees(conn);
	                int govfeesparking=trafficcommon.getGovFeesParking(conn);
	                String strgovfeesparking="";
	                if(govfeesparking>0){
	            
	                    strgovfeesparking="  or trim(fine_source) like '%RTA(Parking Fine)%' or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source) like '%RTA PARKING FINE%' or trim(fine_source) like '%Bus Lanes Fines%' or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'  or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%'";
	                }
		            
	                String sql = "SELECT round(coalesce(m.adminfeecom,0),2) adminfee, m.reason,coalesce(fin.fineamount,0) ofine,coalesce(slk.salikamount,0) osalik, round(m.nsalary,2) nsalary,m.vehicletype,m.ispayroll,"+pradj+" prevadjustment,emp.brhid,h.doc_no acno,h.curid , coalesce(h.rate,0) rate,m.adjustments,m.remarks,m.doc_no,m.month,m.year,m.rider_id,m.rider_name,m.pickupcnt, m.dropoffcnt, m.pickupcancl, m.dropoffcancl, 0 pickuppay, 0 dropoffpay, round(m.operatorfeerider,2) total, round(m.coddeductions,2) coddeductions, round(m.orderissuedeductions,2) orderissuedeductions,round(m.operatorfeerider  - m.coddeductions - m.orderissuedeductions,2) salaries,round(coalesce(if((m.isupdated<>0 or m.salik<>0 ),m.salik,slk.salikamount),0),2) salik,round(coalesce(if((m.isupdated<>0 or m.fine<>0 ),m.fine,fin.fineamount),0),2) fine, round(m.extrasimused,2) extrasimused,round(m.insurance,2) insurance,round(coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0),2) advance,round(m.rtaclass,2) rtaclass,round(m.labourcard,2) labourcard,round(m.llogns,2) llogns,round(m.fineperformance,2) fineperformance,round(coalesce(if((m.isupdated<>0 or m.salik<>0),m.salik,slk.salikamount),0)+coalesce(if((m.isupdated<>0 or m.fine<>0),m.fine,fin.fineamount),0)+m.extrasimused+m.insurance+coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0)+m.rtaclass+m.labourcard+m.llogns+m.fineperformance+m.nsalary,2) totdeductions,round(m.operatorfeerider + m.adjustments  -( m.coddeductions+m.orderissuedeductions+coalesce(if((m.isupdated<>0 or m.salik<>0),m.salik,slk.salikamount),0)+coalesce(if((m.isupdated<>0 or m.fine<>0),m.fine,fin.fineamount),0)+m.extrasimused+m.insurance+coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0)+m.rtaclass+m.labourcard+m.llogns+m.fineperformance+"+pradj+"+m.nsalary),2) netsalary FROM my_rip m "+join+" LEFT JOIN (SELECT l.doc_no maxdocno,l.clientuid,l.saltype,l.saldocno FROM gl_riderlog l JOIN (SELECT MAX(doc_no) maxdocno,saldocno FROM gl_riderlog WHERE clstatus=0 GROUP BY saldocno ) j ON l.doc_no= j.maxdocno AND l.saldocno=j.saldocno) rl ON m.rider_id=rl.clientuid LEFT JOIN  my_salesman sal ON rl.saldocno=sal.doc_no AND sal.sal_type=rl.saltype LEFT JOIN hr_empm emp ON emp.acno=sal.acc_no LEFT JOIN (SELECT hm.empid,SUM(hd.amount) amount FROM hr_eadvm hm LEFT JOIN hr_eadvd hd ON hd.rdocno=hm.doc_no WHERE MONTH(hd.date)="+month+" AND YEAR(hd.date)="+year+" AND hm.status=3 GROUP BY hm.empid) ea ON ea.empid=emp.doc_no LEFT JOIN (SELECT COALESCE(SUM(amount),0) salikamount,emp_id,emp_type,sal_date FROM gl_salik WHERE MONTH(sal_date)="+month+" AND YEAR(sal_date)="+year+" GROUP BY emp_id)slk ON slk.emp_id=sal.doc_no AND slk.emp_type=rl.saltype LEFT JOIN (SELECT COALESCE(SUM(convert(coalesce(if((fine_source like '%DUBAI%' "+strgovfeesparking+" ) && "+govfees+">0"
	                        +",amount+"+govfees+",amount),''),char(100))),0) fineamount,emp_id,emp_type,traffic_date FROM gl_traffic WHERE MONTH(traffic_date)="+month+" AND YEAR(traffic_date)="+year+" GROUP BY emp_id)fin ON fin.emp_id=sal.doc_no AND fin.emp_type=rl.saltype LEFT JOIN my_head h ON emp.acno=h.doc_no AND h.atype='HR' where m.doc_no="+docNo+" and m.year="+year+" and m.month="+month+" and m.brchid='"+brch+"'";
	                //        System.out.println("Rider PAyroll slip - "+sql);
		            ResultSet resultSet = stmt.executeQuery(sql);
		            
		            if(resultSet.next()) {
		            	params.put("riderid", resultSet.getString("rider_id"));
		            	params.put("empname", resultSet.getString("rider_name"));
		            	params.put("pickupcount", resultSet.getString("pickupcnt"));
		            	params.put("dropoffcount", resultSet.getString("dropoffcnt"));
		            	params.put("totalearnings", resultSet.getString("total"));
		            	params.put("cod", resultSet.getString("coddeductions"));
		            	params.put("clawback", resultSet.getString("orderissuedeductions"));
		            	params.put("salac", resultSet.getString("salaries"));
		            	params.put("fine", resultSet.getString("fine"));
		            	params.put("salik", resultSet.getString("salik"));
		            	params.put("insurance", resultSet.getString("insurance"));
		            	params.put("esu", resultSet.getString("extrasimused"));
		            	params.put("advance", resultSet.getString("advance"));
		            	params.put("lastmonthneg", resultSet.getString("nsalary"));
		            	params.put("rtafee", resultSet.getString("rtaclass"));
		            	params.put("labourcard", resultSet.getString("labourcard"));
		            	params.put("others", resultSet.getString("llogns"));
		            	params.put("gdeduction", resultSet.getString("totdeductions"));
		            	params.put("netsalary", resultSet.getString("netsalary"));
		            	params.put("remarks", resultSet.getString("remarks"));
		            	params.put("reason", resultSet.getString("reason"));
		            	params.put("type", resultSet.getString("vehicletype"));
		            	params.put("fineperformance", resultSet.getString("fineperformance"));
		            	params.put("adminfee", resultSet.getString("adminfee"));
		            } 
		            
		            
		            sql="select b.doc_no brhid,b.branchname,b.address brchaddress,"
			                + "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
			                + "b.cmpid=c.doc_no where b.doc_no="+brch+" group by brhid";
		            ResultSet resultSets = stmt.executeQuery(sql);
		    		
		    		while(resultSets.next()){
		    			params.put("company",resultSets.getString("company"));
		    			params.put("address",resultSets.getString("address"));
		    			params.put("tel",resultSets.getString("tel"));
		    			params.put("branch",resultSets.getString("branchname"));
		    		}
		            
		            
		    		// Parse inputs (assumed to be Strings like "04" and "2025")
		    		int y = Integer.parseInt(year);
		    		int m = Integer.parseInt(month) - 1; // Calendar months are 0-based

		    		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd.MM.yyyy");
		    		SimpleDateFormat periodFormatter = new SimpleDateFormat("MMM-yyyy");

		    		// First date of the month
		    		Calendar cal1 = Calendar.getInstance();
		    		cal1.set(y, m, 1);
		    		String firstDateStr = dateFormatter.format(cal1.getTime());

		    		// Last date of the month
		    		Calendar cal2 = Calendar.getInstance();
                    cal2.set(y, m, 1); // Set to 1st of the correct month first
                    cal2.set(Calendar.DAY_OF_MONTH, cal2.getActualMaximum(Calendar.DAY_OF_MONTH)); // Then set to last day
                    String lastDateStr = dateFormatter.format(cal2.getTime());

		    		// Period (e.g., Apr-2025)
		    		String period = periodFormatter.format(cal1.getTime());

		    		// Specific date: 15th of the month
		    		Calendar specific = Calendar.getInstance();
		    		specific.set(y, m, 15);
		    		String releaseDate = dateFormatter.format(specific.getTime());
		            
		            params.put("rdate",releaseDate);
		            params.put("period", period);
		            params.put("salaryperiod", firstDateStr+" to "+lastDateStr);
		            params.put("printname", "PAY SLIP");
		            
		            
		            
		            //System.out.println(RESULTDATA);
		            stmt.close();

		            conn.close();

		        } catch (Exception e) {
		            e.printStackTrace();
		            conn.close();
		        }
	    	return params;
	    	 
	    }
	    
	    
	    
	    
	    public JSONArray getGridData(String docNo,String brch,String id,String year,String month) throws SQLException {
	        JSONArray RESULTDATA = new JSONArray();

	        Connection conn = null;
	        if (!(id.equalsIgnoreCase("1"))) {
	            return RESULTDATA;
	        }

	        try {
	            conn = ClsConnection.getMyConnection();
	            Statement stmt = conn.createStatement();
	            
	            String join="";
	            String pradj="0"; 
	            String chk = "select rider_id, sum(adjustments) adjustment from my_rip where month="+((Integer.parseInt(month)-1)<=0?12:(Integer.parseInt(month)-1))+" and year="+((Integer.parseInt(month)-1)<=0?Integer.parseInt(year)-1:year)+" group by rider_id";
	            ResultSet rs = stmt.executeQuery(chk);
	            if(rs.next()) {
	            	join = "left join (select rider_id, sum(adjustments) adjustment from my_rip where month="+((Integer.parseInt(month)-1)<=0?12:(Integer.parseInt(month)-1))+" and year="+((Integer.parseInt(month)-1)<=0?Integer.parseInt(year)-1:year)+" group by rider_id) rp on rp.rider_id=m.rider_id";
	            	pradj="COALESCE(rp.adjustment,0)";		
	            }
	            
	            
                ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
                double govfees=trafficcommon.getGovFees(conn);
                int govfeesparking=trafficcommon.getGovFeesParking(conn);
                String strgovfeesparking="";
                
                double trfsrvchg=0;
                double slksrvchg=0;
                
                String trfsrvchgsql="select value from gl_config where field_nme='trafficsrvemp' and method=1";
                ResultSet rstrfsrvchgsql = stmt.executeQuery(trfsrvchgsql);
                if(rstrfsrvchgsql.next()) {
                    trfsrvchg=rstrfsrvchgsql.getDouble("value");
                }
                
                String slksrvchgsql="select value from gl_config where field_nme='saliksrvemp' and method=1";
                ResultSet rsslksrvchgsql = stmt.executeQuery(slksrvchgsql);
                if(rsslksrvchgsql.next()) {
                    slksrvchg=rsslksrvchgsql.getDouble("value");
                }
                
                
                if(govfeesparking>0){
            
                    strgovfeesparking="  or trim(fine_source) like '%RTA(Parking Fine)%' or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source) like '%RTA PARKING FINE%' or trim(fine_source) like '%Bus Lanes Fines%' or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'  or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%'";
                }
	            
                String sql = "SELECT  m.reason,coalesce(fin.fineamount,0) ofine,coalesce(slk.salikamount,0) osalik, m.nsalary,m.vehicletype,m.ispayroll,"+pradj+" prevadjustment,emp.brhid,h.account acid,h.doc_no acno,h.curid , coalesce(h.rate,0) rate,m.adjustments,m.remarks,m.doc_no,m.month,m.year,m.rider_id,m.rider_name,m.pickupcnt, m.dropoffcnt, m.pickupcancl, m.dropoffcancl, 0 pickuppay, 0 dropoffpay, m.operatorfeerider total, m.coddeductions , m.orderissuedeductions,m.operatorfeerider  - m.coddeductions - m.orderissuedeductions salaries, coalesce(if((m.isupdated<>0 or m.salik<>0 ),m.salik,slk.salikamount),0) salik,coalesce(if((m.isupdated<>0 or m.fine<>0 ),m.fine,fin.fineamount),0) fine, m.extrasimused, m.insurance,coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0) advance,m.rtaclass,m.labourcard,m.llogns,m.fineperformance, coalesce(if((m.isupdated<>0 or m.salik<>0),m.salik,slk.salikamount),0)+coalesce(if((m.isupdated<>0 or m.fine<>0),m.fine,fin.fineamount),0)+m.extrasimused+m.insurance+coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0)+m.rtaclass+m.labourcard+m.llogns+m.fineperformance+m.nsalary totdeductions, m.operatorfeerider + m.adjustments  -( m.coddeductions+m.orderissuedeductions+coalesce(if((m.isupdated<>0 or m.salik<>0),m.salik,slk.salikamount),0)+coalesce(if((m.isupdated<>0 or m.fine<>0),m.fine,fin.fineamount),0)+m.extrasimused+m.insurance+coalesce(if((m.isupdated<>0 or m.advance<>0),m.advance,ea.amount),0)+m.rtaclass+m.labourcard+m.llogns+m.fineperformance+"+pradj+"+m.nsalary) netsalary FROM my_rip m "+join+" LEFT JOIN (SELECT l.doc_no maxdocno,l.clientuid,l.saltype,l.saldocno FROM gl_riderlog l JOIN (SELECT MAX(doc_no) maxdocno,saldocno FROM gl_riderlog WHERE clstatus=0 GROUP BY saldocno ) j ON l.doc_no= j.maxdocno AND l.saldocno=j.saldocno) rl ON m.rider_id=rl.clientuid LEFT JOIN  my_salesman sal ON rl.saldocno=sal.doc_no AND sal.sal_type=rl.saltype LEFT JOIN hr_empm emp ON emp.acno=sal.acc_no LEFT JOIN (SELECT hm.empid,SUM(hd.amount) amount FROM hr_eadvm hm LEFT JOIN hr_eadvd hd ON hd.rdocno=hm.doc_no WHERE MONTH(hd.date)="+month+" AND YEAR(hd.date)="+year+" AND hm.status=3 GROUP BY hm.empid) ea ON ea.empid=emp.doc_no LEFT JOIN (SELECT COALESCE(SUM(amount+"+slksrvchg+"),0) salikamount,emp_id,emp_type,sal_date FROM gl_salik WHERE MONTH(sal_date)="+month+" AND YEAR(sal_date)="+year+" GROUP BY emp_id)slk ON slk.emp_id=sal.doc_no AND slk.emp_type=rl.saltype LEFT JOIN (SELECT COALESCE(SUM(convert(coalesce(if((fine_source like '%DUBAI%' "+strgovfeesparking+" ) && "+govfees+">0"
                        +",amount+"+govfees+"+"+trfsrvchg+",amount+"+trfsrvchg+"),''),char(100))),0) fineamount,emp_id,emp_type,traffic_date FROM gl_traffic WHERE MONTH(traffic_date)="+month+" AND YEAR(traffic_date)="+year+" GROUP BY emp_id)fin ON fin.emp_id=sal.doc_no AND fin.emp_type=rl.saltype LEFT JOIN my_head h ON emp.acno=h.doc_no AND h.atype='HR' where m.year="+year+" and m.month="+month+" and m.brchid='"+brch+"'";
                        System.out.println("Rider PAyroll Grid - "+sql);
	            ResultSet resultSet = stmt.executeQuery(sql);
	            RESULTDATA = ClsCommon.convertToJSON(resultSet);
	            //System.out.println(RESULTDATA);
	            stmt.close();

	            conn.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	            conn.close();
	        }
	        return RESULTDATA;
	    }
}
