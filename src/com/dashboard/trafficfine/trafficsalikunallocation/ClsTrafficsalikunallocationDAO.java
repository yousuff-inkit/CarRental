package com.dashboard.trafficfine.trafficsalikunallocation;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;
public class ClsTrafficsalikunallocationDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray salikgrid(String load,String fromdate,String todate,String chkdatails) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
		  java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
        Connection conn = null;
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			if(chkdatails.equalsIgnoreCase("1")) {
				
				 sql=" select   s.doc_no docno,s.sr_no srno,coalesce(ac.refname,sa.sal_name) refname,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
 						+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' WHEN s.rtype in ('ST') then 'STAFF' else  st.st_desc end as 'dtypedesc',  "
 						+ "	case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
 						+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',s.regno,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction, "
 						+ " s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans "
 						+ " from gl_salik s   left join gl_ragmt ragmt on  (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
 						+ "	left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC'))left join gl_status st on s.rtype=st.Status  "
 						+ "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
 						+ "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type where s.isallocated=0 and s.inv_no!=0 and s.status not in (0,3) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
				
				
			}else {
				 sql=" select   s.doc_no docno,s.sr_no srno,coalesce(ac.refname,sa.sal_name) refname,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
 						+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT'  WHEN s.rtype in ('ST') then 'STAFF' else  st.st_desc end as 'dtypedesc',  "
 						+ "	case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
 						+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',s.regno,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction, "
 						+ " s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans "
 						+ " from gl_salik s   left join gl_ragmt ragmt on  (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
 						+ "	left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC'))  left join gl_status st on s.rtype=st.Status  "
 						+ "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
 						+ "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type where s.isallocated=1 and s.inv_no=0 and s.status in (0,3) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
			}			
		//System.out.println("-------Unallocate Salik GRID ----"+sql);	
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
     		stmt.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
	public   JSONArray trafficgrid(String load,String fromdate,String todate,String chkdatails) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        String sqltest="";
	
		  java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
        Connection conn = null;
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();   
			ClsTrafficfineDAO trafficcommon=new ClsTrafficfineDAO();
			double govfees=trafficcommon.getGovFees(conn);
			int govfeesparking=trafficcommon.getGovFeesParking(conn);
	        String strgovfeesparking="";
	        if(govfeesparking>0){
	    
	        	strgovfeesparking="  or trim(fine_source) like '%RTA(Parking Fine)%' or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source) like '%RTA PARKING FINE%' or trim(fine_source) like '%Bus Lanes Fines%' or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'  or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%'";
	        }
	        
	        String sql="";
	        if(chkdatails.equalsIgnoreCase("1")) {
				
				sql=" select  t.doc_no docno,t.sr_no srno,if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno, case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
     						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT'  WHEN t.rtype in ('ST') then 'STAFFs' else  st.st_desc end as 'dtypedesc',  "
     						+ "	case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
     						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno, coalesce(ac.refname,sa.sal_name) refname, "
     						+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if((t.fine_source like '%DUBAI%' "+strgovfeesparking+" ) && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source,vh.code_name,t.inv_desc description,coalesce(t.desc1,'') trafficdesc "
     					+ " from gl_traffic t   left join gl_ragmt ragmt on  (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
     						+ "	left join gl_lagmt  lagmt on  (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC'))  left join gl_status st on t.rtype=st.Status  left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type "
     						+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=0 and t.inv_no!=0 and t.status not in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";
     		
	        }else {
	        	
	        	sql=" select  t.doc_no docno,t.sr_no srno,if(ac.ser_default=0,ac.per_trafficharge,0) trafficsrvc,veh.ch_no,t.tcno, case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
 						+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT'  WHEN t.rtype in ('ST') then 'STAFF' else  st.st_desc end as 'dtypedesc',  "
 						+ "	case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
 						+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno, coalesce(ac.refname,sa.sal_name) refname, "
 						+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,time,t.location, convert(coalesce(if((t.fine_source like '%DUBAI%' "+strgovfeesparking+" ) && "+govfees+">0,t.amount+"+govfees+",t.amount),''),char(100)) amount,fine_source,vh.code_name,t.inv_desc description,coalesce(t.desc1,'') trafficdesc "
 					+ " from gl_traffic t   left join gl_ragmt ragmt on  (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
 						+ "	left join gl_lagmt  lagmt on  (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  left join gl_vehplate vh on vh.doc_no=t.pcolor left join my_acbook ac on ac.doc_no=t.emp_id and ac.dtype=t.emp_type  left join my_salesman sa on sa.doc_no=t.emp_id and sa.sal_type=t.emp_type "
 						+ "  left join gl_vehmaster veh on t.fleetno=veh.fleet_no where t.isallocated=1 and t.inv_no=0 and t.status in (0,3) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 		
	        }
		//System.out.println("-------Unallocate traffic GRID ----"+sql);	
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
     		stmt.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
	
	
	
	

}
