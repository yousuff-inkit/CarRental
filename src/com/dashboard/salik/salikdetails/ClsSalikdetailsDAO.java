package com.dashboard.salik.salikdetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalikdetailsDAO

{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray fleetdetails(String fleetno,String flname,String regno,String id) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn =null;  
        try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			
			String sqlfilters="";
			if(!fleetno.trim().equalsIgnoreCase("")) {
				sqlfilters+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!flname.trim().equalsIgnoreCase("")) {
				sqlfilters+=" and veh.flname like '%"+flname+"%'";
			}
			if(!regno.trim().equalsIgnoreCase("")) {
				sqlfilters+=" and veh.reg_no like '%"+regno+"%'";
			}
			String sql=" SELECT fleet_no,reg_no,flname,auth.AUTHNAME authority,plt.CODE_NAME platecode,veh.salik_tag saliktag FROM gl_vehmaster veh \r\n" + 
					" LEFT JOIN gl_vehauth auth ON veh.authid=auth.doc_no\r\n" + 
					" LEFT JOIN gl_vehplate plt ON veh.pltid=plt.doc_no WHERE statu=3 "+sqlfilters;
		 		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				conn.close();
       
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        finally{
        	conn.close();
        }
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray postingDetails(String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
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
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
		
				//commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu

            	/*	String sql="select count(*) VALUE,'Posted' status,'POS' relodestatus from gl_salik  " + 
            				"  where postdocno>0 and isallocated=1 and inv_no>0 and status in (1) and  DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";  
            		
            	*/
			    String sql="select count(*) VALUE,'Posted' status,'POS' relodestatus from gl_salik  " + 
                        "  where postdocno>0 and isallocated=1 and inv_no>0 and status!=7 and  DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";  
            
            	//	System.out.println("------------"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	public  JSONArray subDetails(String fromdate,String todate,String id,String chkincrecv,String fleetno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
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
				Statement stmtVeh = conn.createStatement (); 
				//Getting Salik Tag
				
				String sqlfilters="",sqlfilters1="";
				if(!fleetno.trim().equalsIgnoreCase("")) {
					String strsaliktag="select salik_tag from gl_vehmaster where fleet_no="+fleetno;
					ResultSet rssaliktag=conn.createStatement().executeQuery(strsaliktag);
					
					while(rssaliktag.next()) {
						sqlfilters+=" and tagno="+rssaliktag.getString("salik_tag");
						sqlfilters1+=" and s.tagno="+rssaliktag.getString("salik_tag");
					}
				}
				
				
				
				// UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced
		
            	/*	String sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik where isallocated=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') aa union all  "
            				+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik where isallocated=1 and inv_no=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') union all "
            				+ " (select count(*) VALUE,'Invoiced' status,'AIN' relodestatus from gl_salik where isallocated=1 and inv_no>0 and status in (1) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"') "
            						+ "union all \r\n" + 
            						" (select count(*) value,'Received' status ,'RES' relodestatus from gl_salik  s inner join gl_invm m on \r\n" + 
            						"        m.doc_no=s.inv_no    inner join (select sum(amount) amt,rdocno from gl_invd where chid in (8,14) \r\n" + 
            						"        group by rdocno) d on m.doc_no=d.rdocno    inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno \r\n" + 
            						"            where (j.dramount-j.out_amount)=0  	and s.isallocated=1 and s.inv_no>0 \r\n" + 
            						"       and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d')  between '"+sqlfromdate+"' and  '"+sqltodate+"')  ";
        
*/
	/* String sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik"
						+ " where isallocated=0 and status in (0,3) and salik_date between '"+sqlfromdate+"' and  '"+sqltodate+"') aa "
						+ "union all"
						+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik "
						+ "where isallocated=1 and inv_no=0 and status in (0,3) and salik_date between '"+sqlfromdate+"' and  '"+sqltodate+"' )"
						+ " union all"
						+ " select sum(total) value,'Invoiced' status,'AIN' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
						+ "inner join gl_invm m on m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran"
						+ " where dtype in('INV','INT','INS') group by tr_no,acno having t!=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
						+ "where s.isallocated=1 and s.inv_no>0 and s.status in (1) and s.salik_date between '"+sqlfromdate+"' and  '"+sqltodate+"'  group by inv_no,inv_type) d "
						+ "union all "
						+ "select sum(total) value,'Received' status,'RES' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
						+ "inner join gl_invm m on  m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran "
						+ "where dtype in('INV','INT','INS') group by tr_no,acno having t=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
						+ "where s.isallocated=1 and s.inv_no>0 and s.status in (1) and s.salik_date between '"+sqlfromdate+"' and  '"+sqltodate+"'  group by inv_no,inv_type) d";
		*/
				String sql=null;
			
				//commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu
			/*	if(chkincrecv.equalsIgnoreCase("1")){
			        	
			       
sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik"
						+ " where isallocated=0 and status in (0,3) and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+") aa "
						+ "union all"
						+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik "
						+ "where isallocated=1 and inv_no=0 and status in (0,3) and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+")"
						+ " union all"
						+ " select coalesce(sum(total),0) value,'Invoiced' status,'AIN' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
						+ "inner join gl_invm m on m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran"
						+ " where dtype in('INV','INT','INS') group by tr_no,acno having t!=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
						+ "where s.isallocated=1 and s.inv_no>0 and s.status in (1) and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" group by inv_no,inv_type) d "
						+ "union all "
						+ "select coalesce(sum(total),0) value,'Received' status,'RES' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
						+ "inner join gl_invm m on  m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran "
						+ "where dtype in('INV','INT','INS') group by tr_no,acno having t=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
						+ "where s.isallocated=1 and s.inv_no>0 and s.status in (1) and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" group by inv_no,inv_type) d";
	
			        }
				 else{
					 sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik"
								+ " where isallocated=0 and status in (0,3) and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+" ) aa "
								+ "union all"
								+ " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik "
								+ "where isallocated=1 and inv_no=0 and status in (0,3) and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+" )"
								+ " union all"
								+ " select coalesce(sum(total),0) value,'Invoiced' status,'AIN' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
								+ "where s.isallocated=1 and s.inv_no!=0 and s.status in (1) and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" ) d ";
			 
					 
				 }*/
				
				if(chkincrecv.equalsIgnoreCase("1")){
                    
	                   
				    sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik"
				                            + " where isallocated=0 and status!=7 and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+") aa "
				                            + "union all"
				                            + " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik "
				                            + "where isallocated=1 and inv_no=0 and status!=7 and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+")"
				                            + " union all"
				                            + " select coalesce(sum(total),0) value,'Invoiced' status,'AIN' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
				                            + "inner join gl_invm m on m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran"
				                            + " where dtype in('INV','INT','INS') group by tr_no,acno having t!=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
				                            + "where s.isallocated=1 and s.inv_no>0 and s.status!=7 and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" group by inv_no,inv_type) d "
				                            + "union all "
				                            + "select coalesce(sum(total),0) value,'Received' status,'RES' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
				                            + "inner join gl_invm m on  m.doc_no=s.inv_no inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran "
				                            + "where dtype in('INV','INT','INS') group by tr_no,acno having t=0)j on m.tr_no=j.tr_no and m.acno=j.acno "
				                            + "where s.isallocated=1 and s.inv_no>0 and s.status!=7 and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" group by inv_no,inv_type) d";
				        
				                        }
				                     else{
				                         sql="select * from (select count(*) value,'Un Allocated' status,'UAL' relodestatus  from gl_salik"
				                                    + " where isallocated=0 and status!=7 and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+" ) aa "
				                                    + "union all"
				                                    + " (select count(*) VALUE,'Allocated(Not Invoiced )' status,'ANI' relodestatus from gl_salik "
				                                    + "where isallocated=1 and inv_no=0 and status!=7 and sal_date>='"+sqlfromdate+"' and  sal_date<='"+sqltodate+"' "+sqlfilters+" )"
				                                    + " union all"
				                                    + " select coalesce(sum(total),0) value,'Invoiced' status,'AIN' relodestatus from (select inv_no,inv_type,count(*) total from gl_salik s "
				                                    + "where s.isallocated=1 and s.inv_no!=0 and s.status!=7 and s.sal_date>='"+sqlfromdate+"' and  s.sal_date<='"+sqltodate+"' "+sqlfilters1+" ) d ";
				                 
				                         
				                     }
 //  System.out.println("=====sql===="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public  JSONArray masterdetails(String code,String fromdate,String todate,String chkincrecv,String fleetno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
	
        Connection conn = null;
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
     	
		try {
				 conn = ClsConnection.getMyConnection();
				  Statement stmtVeh = conn.createStatement ();  // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced
		
				  String sqlfilters="",sqlfilters1="";
					if(!fleetno.trim().equalsIgnoreCase("")) {
						String strsaliktag="select salik_tag from gl_vehmaster where fleet_no="+fleetno;
						ResultSet rssaliktag=conn.createStatement().executeQuery(strsaliktag);
						
						while(rssaliktag.next()) {
							sqlfilters+=" and tagno="+rssaliktag.getString("salik_tag");
							sqlfilters1+=" and s.tagno="+rssaliktag.getString("salik_tag");
						}
					}
		if(code.equalsIgnoreCase("UAL"))
		{
		    //commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu

            		/*String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,s.regno,s.tagno,coalesce(s.fleetno,'') fleetno, salik_date ,salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no,s.trans from gl_salik s "
            				+ " left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid"
            				+ " where s.isallocated=0 and s.status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;
            	 */
		    String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,s.regno,s.tagno,coalesce(s.fleetno,'') fleetno, salik_date ,salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no,s.trans from gl_salik s "
                            + " left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid"
                            + " where s.isallocated=0 and s.status!=7 and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;
              
            		// System.out.println("==1===UAL===="+sql);
               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     	
		}
		
		else if(code.equalsIgnoreCase("ANI"))
		{
     				
/*     				String sql="select s.regno,s.tagno,s.fleetno, s.salik_date ,s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.ra_no from gl_salik s  "
     						+ " where isallocated=1 and inv_no=0 and status in (0,3) and DATE_FORMAT(salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";*/
			
		  //commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu

				/*String sql=" select  coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,coalesce(ac.refname,sa.sal_name) refname,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
 						+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',  "
 						+ "	case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
 						+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',s.regno,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction, "
 						+ " s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans "
 						+ " from gl_salik s  left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid left join gl_ragmt ragmt on  (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
 						+ "	left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
 						+ "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
 						+ "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type where s.isallocated=1 and s.inv_no=0 and s.status in (0,3) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;
			*/
		    String sql=" select  coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,coalesce(ac.refname,sa.sal_name) refname,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
                    + " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',  "
                    + " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
                    + " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',s.regno,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,s.direction, "
                    + " s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans "
                    + " from gl_salik s  left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid left join gl_ragmt ragmt on  (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
                    + " left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
                    + "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
                    + "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type where s.isallocated=1 and s.inv_no=0 and s.status!=7  and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;
        
        
			
			
     	        //   System.out.println("===2==ANI===="+sql);
               		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
		}
		
		else if(code.equalsIgnoreCase("AIN"))
		{
			
			 String chkinvno="";
			 if(chkincrecv.equalsIgnoreCase("1")){
				// System.out.println("11=="+chkincrecv);
				 chkinvno=" inner join(select sum(dramount-out_amount) t ,acno,tr_no FROM my_jvtran "
					+ "where dtype in('INV','INT','INS') group by tr_no,acno having t!=0)j on m.tr_no=j.tr_no and m.acno=j.acno ";
			 }
			 else if(chkincrecv.equalsIgnoreCase("0")){
				 //System.out.println("22=="+chkincrecv);
				 chkinvno=" ";
			 }
			 
	          //commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu

           /*  String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' "
					+ "when   s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',"
					+ "case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when   s.rtype in ('LA','LC') then lagmt.voc_no else s.ra_no"
					+ " end as 'rano', s.regno,   coalesce(ac.refname,sa.sal_name) refname,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,"
					+ "s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans   from gl_salik s left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid "
					+ " left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) "
					+ "left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status "
					+ "left join gl_invm m on m.doc_no=s.inv_no "+chkinvno
					+ "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
					+ "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type "
					+ "where s.isallocated=1 and s.inv_no!=0 and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d')"
					+ " between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlfilters1;
		*/
			 
			  String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' "
	                    + "when   s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc',"
	                    + "case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when   s.rtype in ('LA','LC') then lagmt.voc_no else s.ra_no"
	                    + " end as 'rano', s.regno,   coalesce(ac.refname,sa.sal_name) refname,s.tagno,s.fleetno,s.salik_date ,s.salik_time,s.location,"
	                    + "s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans   from gl_salik s left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid "
	                    + " left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) "
	                    + "left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status "
	                    + "left join gl_invm m on m.doc_no=s.inv_no "+chkinvno
	                    + "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
	                    + "left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type "
	                    + "where s.isallocated=1 and s.inv_no!=0 and s.status!=7 and DATE_FORMAT(s.salik_date,'%Y-%m-%d')"
	                    + " between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlfilters1;

           // System.out.println("===AIN===="+sql);
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
		else if(code.equalsIgnoreCase("RES"))
		{
	 
			
		/*	
			String sql="select  j.out_amount,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano' ,  "
					+ " s.regno,    coalesce(ac.refname,sa.sal_name) refname,     s.tagno,s.fleetno,  s.salik_date ,s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans  "
					+ " from gl_salik s   left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=s.inv_no  "
					+ "inner join (select sum(amount) amt,rdocno from gl_invd where chid in (8,14) group by rdocno) d on m.doc_no=d.rdocno \r\n"  
					+ " inner join my_jvtran j on m.tr_no=j.tr_no and m.acno=j.acno    left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type    "
					+ "    left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type     where (j.dramount-j.out_amount)=0 and s.isallocated=1 and s.inv_no>0 and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d') between '"+sqlfromdate+"' and  '"+sqltodate+"' ";

*/

            //commented exsisted code to make status!=7 instead of status in( ) on 16-05-2025 by madhu

/*String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,if(j.out_amount>s.amount,s.amount,j.out_amount) out_amount,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') "
					+ "then 'RENTAL AGRREMENT' when   s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when   s.rtype in ('LA','LC')  then lagmt.voc_no else"
					+ " s.ra_no end as 'rano' ,   s.regno,    coalesce(ac.refname,sa.sal_name) refname,     s.tagno,s.fleetno,  s.salik_date ,"
					+ "s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans   from gl_salik s left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid  "
					+ "left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))   "
					+ "left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) "
					+ "left join gl_status st on s.rtype=st.Status   left join gl_invm m on m.doc_no=s.inv_no "
					+ "inner join(select sum(dramount-out_amount) t ,acno,tr_no,out_amount FROM my_jvtran "
					+ "where dtype in('INV','INT','INS') group by tr_no,acno having t=0) j on m.tr_no=j.tr_no and m.acno=j.acno "
					+ "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
					+ " left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type  "
					+ "where s.isallocated=1 and s.inv_no>0 and s.status in (1) and DATE_FORMAT(s.salik_date,'%Y-%m-%d')"
					+ " between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;	
	*/
		    String sql="select coalesce(plc.code_name,'') platecode,CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,if(j.out_amount>s.amount,s.amount,j.out_amount) out_amount,m.voc_no invno,coalesce(s.inv_type,'') invtype,case when s.rtype in  ('RA','RD','RW','RF','RM') "
                    + "then 'RENTAL AGRREMENT' when   s.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
                    + " case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when   s.rtype in ('LA','LC')  then lagmt.voc_no else"
                    + " s.ra_no end as 'rano' ,   s.regno,    coalesce(ac.refname,sa.sal_name) refname,     s.tagno,s.fleetno,  s.salik_date ,"
                    + "s.salik_time,  s.location,s.direction,s.source,convert(coalesce(s.amount,''),char(100)) amount,s.trans   from gl_salik s left join gl_vehmaster veh on veh.fleet_no=s.fleetno left join gl_vehplate plc on plc.doc_no=veh.pltid and plc.authid=veh.authid  "
                    + "left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))   "
                    + "left join gl_lagmt  lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) "
                    + "left join gl_status st on s.rtype=st.Status   left join gl_invm m on m.doc_no=s.inv_no "
                    + "inner join(select sum(dramount-out_amount) t ,acno,tr_no,out_amount FROM my_jvtran "
                    + "where dtype in('INV','INT','INS') group by tr_no,acno having t=0) j on m.tr_no=j.tr_no and m.acno=j.acno "
                    + "left join my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type "
                    + " left join my_salesman sa on sa.doc_no=s.emp_id and sa.sal_type=s.emp_type  "
                    + "where s.isallocated=1 and s.inv_no>0 and s.status!=7 and DATE_FORMAT(s.salik_date,'%Y-%m-%d')"
                    + " between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfilters1;   
    
		    //System.out.println("-----RES-----"+sql);

       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}
/*		else if(code.equalsIgnoreCase("POS")) // 
		{
			String sql="select regno, fleetno ,source, ticket_no ,traffic_date ,location, convert(coalesce(amount,''),char(100)) amount  from gl_traffic   "
					+ " where isallocated=1 and inv_no>0 and status in (1);";
			
			
			String sql="select   t.postdocno,m.voc_no invno,coalesce(t.inv_type,'') invtype,case when t.rtype in  ('RA','RD','RW','RF','RM') then 'RENTAL AGRREMENT' when  "
					+ " t.rtype in ('LA','LC') then 'LEASE AGRREMENT' else  st.st_desc end as 'dtypedesc', "
					+ " case when t.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
					+ " t.rtype in ('LA','LC')  then lagmt.voc_no else t.ra_no end as 'rano',t.regno,  "
					+ " t.fleetno ,t.source, t.ticket_no ,t.traffic_date ,t.location, convert(coalesce(t.amount,''),char(100)) amount  "
					+ " from gl_traffic t   left join gl_ragmt ragmt on (t.ra_no=ragmt.doc_no and t.rtype in ('RA','RD','RW','RF','RM'))  "
					+ " left join gl_lagmt  lagmt on (t.ra_no=lagmt.doc_no and t.rtype in ('LA','LC')) left join gl_status st on t.rtype=st.Status  "
					+ " left join gl_invm m on m.doc_no=t.inv_no  where t.postdocno>0 and t.isallocated=1 and t.inv_no>0 and t.status in (1) and TRAFFIC_DATE between   '"+sqlfromdate+"' and  '"+sqltodate+"' ";
			////System.out.println("-----asdasd--sssssss----"+sql);
			 
       		ResultSet resultSet = stmtVeh.executeQuery(sql);
    		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
		}		
            	*/
        conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
