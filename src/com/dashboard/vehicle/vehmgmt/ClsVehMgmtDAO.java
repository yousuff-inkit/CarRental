package com.dashboard.vehicle.vehmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsVehMgmtDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVehicleData(String id,String brhid) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqlfilters="";
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")) {
				sqlfilters+=" and m.a_br="+brhid;
			}
			String strsql="SELECT m.VGRPID groupid,m.a_br brchgrid,m.fstatus fstatus ,m.doc_no doc_no,m. reg_exp regexpdate, m.INS_EXP insexpdate,vm.trancode movtrancode,vm.din,vm.tin,vm.kmin,m.status,m.tran_code,CASE WHEN m.ins_exp<=CURDATE() THEN 1 ELSE 0 END chkinsurexpiry,CASE WHEN m.reg_exp<=CURDATE() THEN 1 ELSE 0 END chkregexpiry,CONCAT(COALESCE(auth.authid,''),' ',m.reg_no,' ',COALESCE(plt.code_name,'')) vehiclenum,COALESCE(auth.authname,'') authority,COALESCE(plt.code_name,'') platecode,CONVERT((SELECT DATEDIFF(m.ins_exp,CURDATE())),CHAR(20)) AS days,\r\n" + 
					"br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,COALESCE(vm.din,vm.dout) dates,vm.kmin CUR_KM,m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype,\r\n" + 
					" l.LOC_NAME,g.gname,c.color,b.brand_name,m.ch_no,CASE WHEN vm.fin='0.000' THEN 'Level 0/8' WHEN vm.fin='0.125' THEN 'Level 1/8' WHEN vm.fin='0.250' \r\n" + 
					" THEN 'Level 2/8' WHEN vm.fin='0.375'  THEN 'Level 3/8' WHEN vm.fin='0.500' THEN 'Level 4/8' \r\n" + 
					" WHEN vm.fin='0.625' THEN 'Level 5/8'  WHEN vm.fin='0.750' THEN 'Level 6/8' WHEN vm.fin='0.875' \r\n" + 
					"  THEN 'Level 7/8' WHEN vm.fin='1.000' THEN 'Level 8/8'   END AS 'C_FUEL'\r\n" + 
					"   FROM gl_vehmaster m  \r\n" + 
					" LEFT JOIN gl_vehgroup g ON g.doc_no=m.VGRPID  LEFT JOIN my_color c ON(m.clrid=c.doc_no) \r\n" + 
					" LEFT JOIN gl_vehbrand b ON(m.brdid=b.doc_no) LEFT JOIN gl_vehauth auth ON m.authid=auth.doc_no LEFT JOIN gl_vehplate plt ON m.pltid=plt.doc_no LEFT JOIN gl_yom Y ON y.doc_no=m.yom\r\n" + 
					"LEFT JOIN my_brch br ON m.A_BR=br.DOC_NO \r\n" + 
					"LEFT JOIN (SELECT MAX(doc_no) maxdocno,fleet_no FROM gl_vmove GROUP BY fleet_no) vmax ON m.FLEET_NO=vmax.fleet_no\r\n" + 
					"LEFT JOIN gl_vmove vm ON vm.doc_no=vmax.maxdocno\r\n" + 
					"LEFT JOIN my_locm l ON m.a_loc=l.doc_no\r\n" + 
					" WHERE m.STATU=3 AND m.FSTATUS<>'Z' "+sqlfilters+" order by m.doc_no ";
			//System.out.println("gridload--"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
				
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	
	public JSONArray vehmovementSearch(String fleetno,String fromdate,String todate,String ready) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
        
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

       
     	Connection conn = null;
     	
		try {
				 conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
         if(ready.equalsIgnoreCase("ready"))
         {
        	 
        	 
        	 String sql="select outbr.branchname outbranch,inbr.branchname inbranch,outloc.loc_name outlocation,inloc.loc_name inlocation,CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as  'rdocno'  , "
        	 		+ " v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,coalesce(vm.flname,'') flname ,coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ "CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join my_brch outbr on "
						+ " (v.obrhid=outbr.doc_no) left join my_brch inbr on (v.ibrhid=inbr.doc_no) left join my_locm outloc on "
						+ " (v.olocid=outloc.doc_no) left join my_locm inloc on (v.ilocid=inloc.doc_no) left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no  and vm.statu=3) "
						+ " left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG' "
									+ " left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG' "
						+ "where v.fleet_no='"+fleetno+"'  ORDER BY v.doc_no DESC   limit 15;";
       //System.out.println("----gird readty------"+sql);
         		ResultSet resultSet = stmtVeh.executeQuery(sql);
         		 RESULTDATA=objcommon.convertToJSON(resultSet);
  				stmtVeh.close();
  			//	 return RESULTDATA;
        	 
        	 
         }
				
         else
         {
        	 
      	 String sqltest="";
 	    	
      	int val=0;
        	 
        	String testsql="select count(*) val from gl_vmove v  where v.fleet_no='"+fleetno+"' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
        	
    		ResultSet res1 = stmtVeh.executeQuery(testsql);
    		 
    		if(res1.next())
    		{
    			
    			 val=(res1.getInt("val"));
    			
    		}
    		 
    		if(val>0)
    			{
     	    		sqltest=sqltest+" and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc ;";
    			
    		     }
    		
    		
    		else
    		{
    			sqltest=sqltest+" order by v.doc_no desc limit 15; ";
    		}
    		
 
				String sql="select outbr.branchname outbranch,inbr.branchname inbranch,outloc.loc_name outlocation,inloc.loc_name inlocation, CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as  'rdocno' "
						+ ", CASE  WHEN v.emp_type='CRM' THEN (select refname from my_acbook where cldocno=v.emp_id and dtype='CRM')   "
        	 		   + " WHEN v.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=v.emp_id and sal_type='DRV') "
        	 		    + " WHEN v.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=v.emp_id and sal_type='STF')   END as 'empname' , v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype, "
        	 		    + " coalesce(vm.flname,'') flname ,coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ " CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join my_brch outbr on "
						+ " (v.obrhid=outbr.doc_no) left join my_brch inbr on (v.ibrhid=inbr.doc_no) left join my_locm outloc on "
						+ " (v.olocid=outloc.doc_no) left join my_locm inloc on (v.ilocid=inloc.doc_no) left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG' "
						+ " left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG' left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no and vm.statu=3) "
						+ "where v.fleet_no='"+fleetno+"' "+sqltest;
			//	System.out.println("-------gridloads-----"+sql);
        	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=objcommon.convertToJSON(resultSet);
            
     				stmtVeh.close();
     				
            	
         }
         conn.close();
		

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close(); 
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray searchmasterTariff(String brnchval,String group) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
            		String sql="select if(m.tariftype='CORPORATE',concat(m.tariftype,' ',ca.cat_name),m.tariftype) tariftype,m.doc_no from gl_tarifm m left join gl_tarifd m1  "
            				+ "on m.doc_no=m1.doc_no   left join my_clcatm ca on ca.doc_no=m.clientid  "
            				+ " where current_date between M.validfrm and M.validto AND m1.gid='"+group+"'  and m.status<>7 "
            				+ "    group by m.doc_no;";
            
            	//System.out.println("---RTR TARIFF GRID sql---"+sql);
            		
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=objcommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray tariffSearch(String groupname,String docval,String branch,String id) throws SQLException {


	  	 JSONArray RESULTDATA=new JSONArray();
	  	   
	  	Connection conn = null;
	  	 if(!(id.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
			
			try {
					 conn = objconn.getMyConnection();
					Statement stmtVeh6 = conn.createStatement ();
					String tasql= ("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater, "
							+ "m1.cooler,m1.oinschg,m1.chaufchg,m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm m "
							+ " inner join gl_tarifd m1 on m.doc_no=m1.doc_no right join gl_tlistm m2 on m1.renttype=m2.rentaltype where m.doc_no='"+docval+"'  "
							+ " and m1.gid='"+groupname+"' and  m2.Status=1 order by m2.doc_no;");
			//	System.out.println("---RTR TARIFF SHOW GRID sql-------"+tasql);
					
					ResultSet resultSet = stmtVeh6.executeQuery(tasql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtVeh6.close();
					conn.close();
			}
			catch(Exception e){
				conn.close();
			}
	       return RESULTDATA;
	   }   
}
