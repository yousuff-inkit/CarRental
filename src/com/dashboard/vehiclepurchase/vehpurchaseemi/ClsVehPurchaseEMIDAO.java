package com.dashboard.vehiclepurchase.vehpurchaseemi;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehPurchaseEMIDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray financesearch(String accountno,String accountname,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		         String sqltest="";
		        //  String sql="";
		          
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and acc_no like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and fname like '%"+accountname+"%'";
		          }
		          
		          if(check.equalsIgnoreCase("1"))
		          {
		       /*  String sql="select acc_no,fname,doc_no from gl_vehfin where status=3 "+sqltest;*/
		        	  
		        	  
		        String sql="select h.account acc_no,h.description fname,v.doc_no from gl_vehfin v left join my_head h on h.doc_no=v.acc_no where v.status=3"+sqltest;
		         // System.out.println("sql7==="+sql);
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          } 
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
	
	public JSONArray searchdetails(String branch, String type, String finco, String dealno, String uptodate, String fleetno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="", sqltest2="";  
	        /*	String sqltest1="";	*/
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				 			sqltest+=" and vo.brhid='"+branch+"'";
				} 	
		    		
	  	if(type.equalsIgnoreCase("summary") || type.equalsIgnoreCase("banksummary"))
		    	{
		    		
		    		/*   		
            		String sql="select dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt,round(dt.perintst,2) intst , "
            				+ " dt.dealno,f.fname financiername,f.acc_no account,(select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
            				+ " (select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no) principle, (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue, "
            				+ " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest1, "
            				+ " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle1, "
            				+ "(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue1, "
            				+ " (select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest2, "
            				+ "(select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle2, "
            				+ " (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue2   "
            				+ "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
            				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head h1   on h1.doc_no=dt.bankaccno left join   my_head h2 on h2.doc_no=dt.intstaccno  "
            				+ "   left join my_head h3 on h3.doc_no=dt.loanaccno  left join gl_vpurdetd det on det.rdocno=vo.doc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.refno like 'VPU%'  "
            				+ "left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+"  group by vo.doc_no ";
            		*/
            		/*String sql="select dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt,  "
            		           + "round(dt.perintst,2) intst ,  dt.dealno,hh.description financiername,hh.account account, "
            		           + "(select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
            		           + "(select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no) principle,  "
            		           + "(select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue,  "
            		           + "convert(coalesce((select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) interest1, "
            		           + "convert(coalesce((select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) principle1, "
            		           + "convert(coalesce((select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) pytvalue1, "
            		           + " convert(coalesce((select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) interest2,  "
            		           + " convert(coalesce((select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) principle2,  "
            		           + " convert(coalesce((select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) pytvalue2  "
            		           + "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
            		           + "left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno left join  "
            		           + "my_head h2 on h2.doc_no=dt.intstaccno     left join my_head h3 on h3.doc_no=dt.loanaccno  "
            		           + "left join gl_vpurdetd det on det.rdocno=vo.doc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  "
            		           + " and um.bpvno<>0 and um.refno like 'VPU%'  left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+" "
            		           + "group by vo.doc_no  "; 
*/

/*	  		String sql="select dt.dealno ,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate, "
	  				+ " DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,round(dt.dwnpyt+dt.loanamt,2) totalval, "
	  				+ "round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	  				+ " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	  				+ " round( d.pramt,2) principle2 ,round( d.intstamt,2) interest2,round( d.totamt,2) pytvalue2 "
	  				+ "from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
	  				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no "
	  				+ " left join my_head h1    on h1.doc_no=dt.bankaccno "
	  				+ " left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	  				+ " from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 group by rdocno) det on det.rdocno=vo.doc_no  "
	  				+ " left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt from gl_vpurdetd det "
	  				+ " inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 "
	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no   and m.dtype='bpv' and  m.DATE<='2016-03-14' where (um.bpvno=9999999 or m.doc_no is not null) "
	  				+ " group by rdocno) m on m.rdocno=vo.doc_no left join "
	  				+ " (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' "
	  				+ " and um.bpvno=0 and um.status<>7 group by rdocno) d  on d.rdocno=vo.doc_no where vo.clstatus=1 and vo.status=3 and vo.date<='"+sqlUpToDate+"' "+sqltest+"  group by vo.doc_no";
*/
	  		// System.out.println("=summary=== "+sql);    
	  		
	  		String strgroupby="";
	  		if(type.equalsIgnoreCase("summary")) {
	  			strgroupby=" group by vo.doc_no";
	  		}
	  		else if(type.equalsIgnoreCase("banksummary")) {
	  			strgroupby=" group by dt.bankaccno";
	  		}
	  		
	  		/*String sql="select vd.fleet_no,dt.dealno,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
	  				+ "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,emi,round(dt.dwnpyt+dt.loanamt,2) totalval,"
	  				+ " round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	  				+ " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	  				+ " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2"
	  				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join (select rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join"+
	  				" gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno "
	  				+ "	left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
	  				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
	  				+ " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
	  				+ " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno) "
	  				+ " det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	  				+ " from gl_vpurdetd det  inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "  
	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
	  				+ " (um.bpvno=9999999 or m.doc_no is not null)  group by rdocno ) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
	  				+ " vo.status=3 and vo.date<='"+sqlUpToDate+"'  "+sqltest+" "+strgroupby;*/
	  		
	  		/*query changed on 06-03-2024 for taking refbrchid from gl_vpurd using config*/
	  		
	  		String sql="select vd.fleet_no,dt.dealno,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
	  				+ "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,emi,round(dt.dwnpyt+dt.loanamt,2) totalval,"
	  				+ " round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	  				+ " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	  				+ " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2"
	  				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join(select refbrhid,rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join"+
	  				" gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno "
	  				+ "	left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
	  				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
	  				+ " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
	  				+ " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno) "
	  				+ " det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	  				+ " from gl_vpurdetd det  inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "  
	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
	  				+ " (um.bpvno=9999999 or m.doc_no is not null)  group by rdocno ) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
	  				+ " vo.status=3 and vo.purdate<='"+sqlUpToDate+"'  "+sqltest+" "+strgroupby;
	  		
	        //System.out.println("=summary gridfirst=== "+sql);
	  		ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            	 
		    	}
            	 
 				stmtVeh.close();
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	   public JSONArray searchdetails1(String branch,String type,String finco,String dealno,String uptodate,String fleetno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        try {
	                 conn = ClsConnection.getMyConnection();
	                Statement stmtVeh = conn.createStatement();
	                
	                String sqltest="",sqltest5="",jointype=" LEFT JOIN ";
	            /*  String sqltest1=""; */
	                java.sql.Date sqlUpToDate = null;
	                 
	                if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
	                      sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
	                }
	                
	                if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
	                    sqltest+=" and f.doc_no='"+finco+"'";
	                }   
	                if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
	                    sqltest+=" and  dt.dealno='"+dealno+"'";
	                }   
	                if(!((fleetno.equalsIgnoreCase("")) || (fleetno.equalsIgnoreCase("NA")) || (fleetno.equalsIgnoreCase("0")))){
	                	sqltest5+=" and  vp.fleet_no='"+fleetno+"'";
	                	jointype=" inner JOIN ";
	                }else {
	                	jointype=" LEFT JOIN ";
	                }
	                String configchk="select method from gl_config where field_nme='refbrchidchk'";
	    	  		ResultSet configchkss = stmtVeh.executeQuery(configchk);
	               // System.out.println("configchk---"+configchk);
	               int method=0;
	                while(configchkss.next()) {
	                	method=configchkss.getInt("method");
	                }
	                String  sqltest1="" , sqlbrch="";
	                if(method==1) {
						sqltest1=" left join my_brch b on b.doc_no=vdd.refbrhid ";
						 sqlbrch=" , b.branchname ";
	                if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	                    sqltest1+="  where vdd.refbrhid='"+branch+"'";
	                   
	                }  
	                }else {
	                	 if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	 	                    sqltest+=" and vo.brhid='"+branch+"'";
	 	                } 
	                	
	                }
	                
	                
	        if(type.equalsIgnoreCase("vehwise") )
	                {
	                    
	                    /*          
	                    String sql="select dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt,round(dt.perintst,2) intst , "
	                            + " dt.dealno,f.fname financiername,f.acc_no account,(select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
	                            + " (select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no) principle, (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue, "
	                            + " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest1, "
	                            + " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle1, "
	                            + "(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue1, "
	                            + " (select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest2, "
	                            + "(select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle2, "
	                            + " (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue2   "
	                            + "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
	                            + " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head h1   on h1.doc_no=dt.bankaccno left join   my_head h2 on h2.doc_no=dt.intstaccno  "
	                            + "   left join my_head h3 on h3.doc_no=dt.loanaccno  left join gl_vpurdetd det on det.rdocno=vo.doc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.refno like 'VPU%'  "
	                            + "left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+"  group by vo.doc_no ";
	                    */
	                    /*String sql="select dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt,  "
	                               + "round(dt.perintst,2) intst ,  dt.dealno,hh.description financiername,hh.account account, "
	                               + "(select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
	                               + "(select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no) principle,  "
	                               + "(select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue,  "
	                               + "convert(coalesce((select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) interest1, "
	                               + "convert(coalesce((select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) principle1, "
	                               + "convert(coalesce((select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) pytvalue1, "
	                               + " convert(coalesce((select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) interest2,  "
	                               + " convert(coalesce((select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) principle2,  "
	                               + " convert(coalesce((select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) pytvalue2  "
	                               + "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
	                               + "left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno left join  "
	                               + "my_head h2 on h2.doc_no=dt.intstaccno     left join my_head h3 on h3.doc_no=dt.loanaccno  "
	                               + "left join gl_vpurdetd det on det.rdocno=vo.doc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  "
	                               + " and um.bpvno<>0 and um.refno like 'VPU%'  left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+" "
	                               + "group by vo.doc_no  "; 
	*/

	/*          String sql="select dt.dealno ,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate, "
	                    + " DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,round(dt.dwnpyt+dt.loanamt,2) totalval, "
	                    + "round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	                    + " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	                    + " round( d.pramt,2) principle2 ,round( d.intstamt,2) interest2,round( d.totamt,2) pytvalue2 "
	                    + "from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
	                    + " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no "
	                    + " left join my_head h1    on h1.doc_no=dt.bankaccno "
	                    + " left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	                    + " from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 group by rdocno) det on det.rdocno=vo.doc_no  "
	                    + " left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt from gl_vpurdetd det "
	                    + " inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 "
	                    + " left join  my_chqbm m on um.bpvno=m.doc_no   and m.dtype='bpv' and  m.DATE<='2016-03-14' where (um.bpvno=9999999 or m.doc_no is not null) "
	                    + " group by rdocno) m on m.rdocno=vo.doc_no left join "
	                    + " (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' "
	                    + " and um.bpvno=0 and um.status<>7 group by rdocno) d  on d.rdocno=vo.doc_no where vo.clstatus=1 and vo.status=3 and vo.date<='"+sqlUpToDate+"' "+sqltest+"  group by vo.doc_no";
	*/
	            // System.out.println("=summary=== "+sql);    
	            String strgroupby="";

	            String sql1 = "select method from gl_config where field_nme='tax'";
	            ResultSet rsConfig = stmtVeh.executeQuery(sql1);
	            
	            int configTax=0;
	            while(rsConfig.next()) {
	                configTax=rsConfig.getInt("method");
	            } 

	            String taxper="0";
	            int vndtax=0;
	            
	            if(configTax==1){
	            
	                 
	                
	                            String strSql = "select per from gl_taxmaster where status=3 and type=1 and per>0 and now() between fromdate and todate ";
	                           // System.out.println("==taxpersql "+strSql);
	                            ResultSet rs = stmtVeh.executeQuery(strSql);
	                            
	                            while(rs.next()) {
	                                        taxper=rs.getString("per");
	                                    } 
	                                
	            }
	            
	         
	   
	            
	           /* String sql="select concat(vdd.fleet_no,' - ',veh.reg_no,' - ',veh.flname) fleet_no,dealno, financiername ,account , stdate,enddate,emi,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*totalval,2) totalval,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*dwnpyt,2) dwnpyt, "
	                    +" intst,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle,2) principle ,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest,2) interest , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue,2) pytvalue,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle1,2) principle1 , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest1,2) interest1,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue1,2) pytvalue1, round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle2,2) principle2 , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest2,2) interest2,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue2,2) pytvalue2 from "
	                    + "(select vo.doc_no,vd.fleet_no,dt.dealno,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
	                    + "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,emi,round(dt.dwnpyt+dt.loanamt,2) totalval,"
	                    + " round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	                    + " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	                    + " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2,dt.taxamount "
	                    + " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join (select rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join"+
	                    " gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno "
	                    + " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) " 
	                    + " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
	                    + " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
	                    + " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno) "
	                    + " det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	                    + " from gl_vpurdetd det  inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "  
	                    + " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
	                    + " (um.bpvno=9999999 or m.doc_no is not null)  group by rdocno ) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
	                    + " vo.status=3 and vo.date<='"+sqlUpToDate+"'  "+sqltest+" "+strgroupby+") q1  inner join gl_vpurd vdd on vdd.rdocno=q1.doc_no left join gl_vehmaster veh on (vdd.fleet_no=veh.fleet_no)" ;*/
	           
	            /*query changed on 06-03-2024 for taking refbrchid from gl_vpurd using config*/

	            /*  total to be taken from vpurd only 
	            String sqladd="(vdd.price*("+taxper+"/100))",sqladd1="(vdd.price*(0/100))";
		         
	           String sql="select concat(vdd.fleet_no,' - ',veh.reg_no,' - ',veh.flname) fleet_no,dealno, financiername ,account , stdate,enddate,emi,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*totalval,2) totalval,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*dwnpyt,2) dwnpyt, "
	                    +" intst,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle,2) principle ,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest,2) interest , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue,2) pytvalue,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle1,2) principle1 , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest1,2) interest1,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue1,2) pytvalue1, round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*principle2,2) principle2 , "
	                    +" round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*interest2,2) interest2,round(((if(q1.taxamount>0,"+sqladd+","+sqladd1+")+vdd.price)/totalval)*pytvalue2,2) pytvalue2 from "
	                    + "(select vd.refbrhid,vo.doc_no,vd.fleet_no,dt.dealno,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
	                    + "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,emi,round(dt.dwnpyt+dt.loanamt,2) totalval,"
	                    + " round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
	                    + " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
	                    + " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2,dt.taxamount "
	                    + " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join (select refbrhid,rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join"+
	                    " gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no  group by rdocno) vd on vo.doc_no=vd.rdocno "
	                    + " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) " 
	                    + " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
	                    + " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
	                    + " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno) "
	                    + " det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
	                    + " from gl_vpurdetd det  inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "  
	                    + " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
	                    + " (um.bpvno=9999999 or m.doc_no is not null)  group by rdocno ) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
	                    + " vo.status=3 and vo.date<='"+sqlUpToDate+"'  "+sqltest+" "+strgroupby+") q1  inner join gl_vpurd vdd on vdd.rdocno=q1.doc_no left join gl_vehmaster veh on (vdd.fleet_no=veh.fleet_no) "+sqltest1+"" ;
	             */    
	            String sql="select concat(convert(coalesce(vdd.fleet_no,''),char(40)),' - ',convert(coalesce(veh.reg_no,''),char(40)),' - ',convert(coalesce(veh.flname,''),char(40))) fleet_no,dealno, financiername ,account , stdate,enddate,emi,round((vdd.price/totval)*totalval,2) totalval,round((vdd.price/totval)*dwnpyt,2) dwnpyt,  intst,round((vdd.price/totval)*principle,2) principle ,round((vdd.price/totval)*interest,2) interest ,  round((vdd.price/totval)*pytvalue,2) pytvalue,round((vdd.price/totval)*principle1,2) principle1 ,  round((vdd.price/totval)*interest1,2) interest1, round((vdd.price/totval)*pytvalue1,2) pytvalue1, round((vdd.price/totval)*principle2,2) principle2 ,  round((vdd.price/totval)*interest2,2) interest2,round((vdd.price/totval)*pytvalue2,2) pytvalue2 "+sqlbrch+" from "
                        + "(select vd.refbrhid,vo.doc_no,vd.fleet_no,dt.dealno,hh.description financiername ,hh.account account,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate,  "
                        + "DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') enddate,emi,round(dt.dwnpyt+dt.loanamt,2) totalval,"
                        + " round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.pramt,2) principle ,round( det.intstamt,2) interest , "
                        + " round( det.totamt,2) pytvalue, round( m.pramt,2) principle1 ,round( m.intstamt,2) interest1,round( m.totamt,2) pytvalue1, "
                        + " round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) principle2 ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) interest2,round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) pytvalue2,dt.taxamount,vd.totval  "
                        + " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid"+jointype+"(select refbrhid,rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no, sum(price) totval from gl_vpurd vp left join"+
                        " gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no where 1=1 "+sqltest5+" group by rdocno) vd on vo.doc_no=vd.rdocno "
                        + " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "   
                        + " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
                        + " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
                        + " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno) "
                        + " det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
                        + " from gl_vpurdetd det  inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "  
                        + " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' where "
                        + " (um.bpvno=9999999 or m.doc_no is not null)  group by rdocno ) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
                        + " vo.status=3 and vo.purdate<='"+sqlUpToDate+"'  "+sqltest+" "+strgroupby+") q1  inner join gl_vpurd vdd on vdd.rdocno=q1.doc_no left join gl_vehmaster veh on (vdd.fleet_no=veh.fleet_no) "+sqltest1+"" ;
                  
	            
	            //System.out.println("=summary==vehwise=== "+sql);
	            ResultSet resultSet = stmtVeh.executeQuery(sql);
	                 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	                 
	                }
	                 
	                stmtVeh.close();
	                
	                
	          
	                conn.close();
	        }
	        catch(Exception e){
	            e.printStackTrace();
	            conn.close();
	        }
	        //System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }

	
	 
	public JSONArray searchexceldetails(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	String sqltest1="";	
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
				
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
          	if(type.equalsIgnoreCase("summary"))
		    	{
		    		
		    
		    
		    	

				//dealno financiername account           order by dt.dealno
            		
            	/*	String sql="select dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt,round(dt.perintst,2) intst , "
            				+ " dt.dealno,f.fname financiername,f.acc_no account,(select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
            				+ " (select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no) principle, (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue, "
            				+ " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest1, "
            				+ " (select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle1, "
            				+ "(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue1, "
            				+ " (select sum(intstamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2) interest2, "
            				+ "(select sum(pramt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(amount)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3) principle2, "
            				+ " (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no)-(select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%') pytvalue2   "
            				+ "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
            				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head h1   on h1.doc_no=dt.bankaccno left join   my_head h2 on h2.doc_no=dt.intstaccno  "
            				+ "   left join my_head h3 on h3.doc_no=dt.loanaccno  left join gl_vpurdetd det on det.rdocno=vo.doc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.refno like 'VPU%'  "
            				+ "left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+"  group by vo.doc_no ";
            		
            		
          		
          		String sql="select DATE_FORMAT(dt.stdate,'%d.%m.%Y') 'Start Date', DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') 'End Date', "
          				+ " round(dt.dwnpyt+dt.loanamt,2) 'Value',round(dt.dwnpyt,2) 'Down Pyt',round(dt.perintst,2) '% Interest' , "
          				+ " dt.dealno 'Deal No',hh.description 'Financier Name',hh.account 'Account', "
          				+ " (select round(sum(intstamt),2)  from gl_vpurdetd where rdocno=vo.doc_no  ) 'Finance Taken Interest',  "
          				+ " (select round(sum(pramt),2)  from gl_vpurdetd where rdocno=vo.doc_no) 'Finance Taken Principle',  "
          				+ " (select  round(sum(totamt),2)  from gl_vpurdetd   where rdocno=vo.doc_no) 'Finance Taken value',  "
          				+ " convert(coalesce((select round(sum(amount),2)  from my_unclrchqbd   where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) 'Paid Interest',  "
          				+ " convert(coalesce((select round(sum(amount),2)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) 'Paid Principle', "
          				+ " convert(coalesce((select round(sum(totalamount),2)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) 'Paid value',  "
          				+ " convert(coalesce((select round(sum(intstamt),2)  from gl_vpurdetd where rdocno=vo.doc_no)-(select round(sum(amount),2)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=2),''),char(55)) 'Balance Interest', "
          				+ " convert(coalesce((select round(sum(pramt),2)  from gl_vpurdetd where rdocno=vo.doc_no)-(select round(sum(amount),2)  from my_unclrchqbd where rdocno in (select doc_no from  my_unclrchqbm where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and bpvno<>0) and sr_no=3),''),char(55)) 'Balance Principle', "
          				+ "  convert(coalesce((select round(sum(totamt),2)  from gl_vpurdetd where rdocno=vo.doc_no)-(select round(sum(totalamount),2)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' and bpvno<>0 and refno like 'VPU%'),''),char(55)) 'Balance value'  "
          				+ "  from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)   left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no left join my_head h1  "
          				+ "  on h1.doc_no=dt.bankaccno left join   my_head h2 on h2.doc_no=dt.intstaccno "
          				+ "  left join my_head h3 on h3.doc_no=dt.loanaccno  left join gl_vpurdetd det on det.rdocno=vo.doc_no "
          				+ "  left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.refno like 'VPU%' "
          				+ "  left join my_unclrchqbd ud on ud.rdocno=um.doc_no where vo.clstatus=1 and vo.status=3 "+sqltest+"  group by vo.doc_no";
          		*/
  /*        		String sql="select dt.dealno 'Deal No',hh.description 'Financier Name',hh.account 'Account',DATE_FORMAT(dt.stdate,'%d.%m.%Y') 'Start_Date', "
          				+ " DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') 'End_Date', "
          				+ " round(dt.dwnpyt+dt.loanamt,2) 'Value',round(dt.dwnpyt,2) 'Down Pyt',round(dt.perintst,2) '% Interest', "
          				+ " round(sum(det.pramt),2) p1 ,round(sum(det.intstamt),2) i1,round(sum(det.totamt),2) t1, "
          				+ " round(sum(m.pramt),2) p2 ,round(sum(m.intstamt),2) i2,round(sum(m.totamt),2) t2, "
          				+ " round(sum(d.pramt),2) p3 ,round(sum(d.intstamt),2) i3,round(sum(d.totamt),2) t3 "
          				+ "  from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid "
          				+ "       left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
          				+ "       left join gl_vehfin f on f.doc_no=dt.finaccno "
          				+ "       left join my_head hh on hh.doc_no=f.acc_no "
          				+ "       left join my_head h1    on h1.doc_no=dt.bankaccno "
    	  				+ " left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
    	  				+ " from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 group by rdocno) det on det.rdocno=vo.doc_no  "
          				+ "       left join (select rdocno,pramt,intstamt,totamt from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 WHERE DET.DATE<='"+sqlUpToDate+"' group by rdocno) m"
          				+ "        on m.rdocno=vo.doc_no "
          				+ "       left join (select rdocno,pramt,intstamt,totamt from gl_vpurdetd det inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno=0  and um.status<>7 group by rdocno) d"
          				+ "       on d.rdocno=vo.doc_no"
          				+ "        where vo.clstatus=1 and vo.status=3 and vo.date<='"+sqlUpToDate+"' "+sqltest+"   group by vo.doc_no;";
//          		System.out.println("------exel----"+sql);
*/            		
  
          		
          		String sql="select vo.voc_no 'Doc No',dt.dealno 'Deal No',hh.description 'Financier Name' ,hh.account 'Account',vd.fleet_no 'Fleets',DATE_FORMAT(dt.stdate,'%d.%m.%Y') 'Start_Date', "
          	           + " DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') 'End_Date',round(dt.dwnpyt+dt.loanamt,2) 'Value', "
          	           + "round(dt.dwnpyt,2) 'Down Pyt',round(dt.perintst,2) '% Interest',round( det.emi,2) 'Monthly EMI',round( det.intstamt,2) ' Finance Interest',round( det.pramt,2) 'Finance Principle' , "
          	           + " round( det.totamt,2) 'Finance Value',round( m.intstamt,2) 'Paid Interest', round( m.pramt,2) 'Paid Principle' ,round( m.totamt,2) 'Paid Value', "
          	           + " round( coalesce(det.totamt,0)-coalesce(m.totamt,0),2) 'Bal Value',round(coalesce(det.pramt,0)-coalesce(m.pramt,0),2) 'Bal Principle' ,round( coalesce(det.intstamt,0)-coalesce(m.intstamt,0),2) 'Bal Interest' "
    	  				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join (select rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join"+
    	  				" gl_vehmaster veh on (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno "
    	  				+ "	left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
    	  				+ " left join gl_vehfin f on f.doc_no=dt.finaccno left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1  "
    	  				+ " on h1.doc_no=dt.bankaccno  left join (select det.rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt,totamt emi  "
    	  				+ " from gl_vpurdetd det  inner join gl_vpurm m on det.rdocno=m.doc_no inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.status<>7 and m.brhid=um.brhid group by rdocno ) "
    	  				+ "det on det.rdocno=vo.doc_no   left join (select rdocno,sum(pramt) pramt,sum(intstamt) intstamt,sum(totamt) totamt "
    	  				+ "from gl_vpurdetd det inner join gl_vpurm m1 on det.rdocno=m1.doc_no  inner join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and um.bpvno<>0 and um.status<>7 and m1.brhid=um.brhid "
    	  				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"'  where "
    	  				+ "(um.bpvno=9999999 or m.doc_no is not null)  group by rdocno) m on m.rdocno=vo.doc_no  where vo.clstatus=1 and"
    	  				+ " vo.status=3 and vo.purdate<='"+sqlUpToDate+"'  "+sqltest+"   group by vo.doc_no ";
          		 //System.out.println("summary=="+sql);	
          		 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		    	} 
 				stmtVeh.close();
 				
            	
          
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray searchdetailsdata(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
	        	
		    	
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
		    	
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			 			sqltest+=" and vo.brhid='"+branch+"'";
			 		}	
			   
	          	if(type.equalsIgnoreCase("detail"))
			    	{
			    			    	
	          		

				//dealno financiername account           order by dt.dealno
            		
       /*     		String sql=" select um.bpvno,if(um.bpvno>0,'Paid','Not paid') paid,det.date chqdate,dt.chqname,dt.sectychqno,vo.doc_no,dt.stdate, DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt, "
            				+ "	round(dt.perintst,2) intst ,  dt.dealno,hh.description financiername,f.acc_no account,	(select sum(intstamt) from gl_vpurdetd where rdocno=vo.doc_no  )interest, "
            				+ "	(select sum(pramt) from gl_vpurdetd where rdocno=vo.doc_no) principle,	 (select sum(totamt)  from gl_vpurdetd where rdocno=vo.doc_no) pytvalue, "
            				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0),''),char(50)) interest1, "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0),''),char(50)) principle1, "
            				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0),''),char(50)) pytvalue1, "
            				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0),''),char(50)) interest2,"
            				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0),''),char(50)) principle2,"
            				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0),''),char(50)) pytvalue2"
            				+ "	from gl_vpurdetd det left join gl_vpurm vo on vo.doc_no=det.rdocno	left join gl_vpurdetm dt on dt.rdocno=vo.doc_no left join gl_vehfin f on f.doc_no=dt.finaccno "
            				+ "	left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  and um.refno like 'VPU%'  where  vo.clstatus=1 and vo.status=3 "+sqltest ;
            		
            		
            		*/
	          		
	          		
	          		/*String sql="select um.bpvno,if(um.bpvno>0,'Paid','Not paid') paid,det.date chqdate,dt.chqname,dt.sectychqno,vo.doc_no,dt.stdate,  "
	          				+ " DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,dt.dwnpyt+dt.loanamt totalval,dt.dwnpyt, "
	          				+ "	round(dt.perintst,2) intst ,  dt.dealno,hh.description financiername,hh.account account, "
	          				+ "	convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and um.status<>7),''),char(50)) interest,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) principle,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) pytvalue,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0  and um.status<>7),''),char(50)) interest1,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) principle1,  "
	          				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) pytvalue1,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7),''),char(50)) interest2,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) principle2,  "
	          		        + " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) pytvalue2  "
	          		        + " from gl_vpurdetd det left join gl_vpurm vo on vo.doc_no=det.rdocno  left join gl_vpurdetm dt on dt.rdocno=vo.doc_no  "
	          		        + " left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  and um.status<>7  "
	          		        + "  and um.refno like 'VPU%'  where  vo.clstatus=1 and vo.status=3 and det.date<='"+sqlUpToDate+"' and um.date<='"+sqlUpToDate+"' "+sqltest;*/
	          		
	          		/*String sql="select h1.description bankaccno,if(um.bpvno>0,'Paid','Not paid') paid,det.date chqdate,dt.chqname,det.chqno sectychqno,vo.doc_no,dt.dealno ,hh.description financiername ,hh.account ,dt.stdate,DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,"
	          				+ " round(dt.dwnpyt+dt.loanamt,2) totalval, round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.totamt,2) MonthlyEMI,"
	          				+ " round( det.intstamt,2) interest,round( det.pramt,2) principle , round( det.totamt,2) pytvalue, "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.intstamt,2),0) interest1, "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.pramt,2),0) principle1 , "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.totamt,2),0) pytvalue1,"
	          				+ " round( coalesce(det.totamt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.totamt,2),0) ,2) pytvalue2, "
	          				+ " round(coalesce(det.pramt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.pramt,2),0),2) principle2 "
	          				+ ",round( coalesce(det.intstamt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.intstamt,2),0),2) interest2 "
	          				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join "
	          				+ " (select rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join gl_vehmaster veh on "
	          				+ " (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno 	"
	          				+ " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  left join gl_vehfin f on f.doc_no=dt.finaccno "
	          				+ " left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno  left join  gl_vpurdetd det on det.rdocno=vo.doc_no "
	          				+ " left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and vo.brhid=um.brhid "
	          				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' "
       						+ " where vo.clstatus=1 and um.status<>7 and vo.status=3 and vo.date<='"+sqlUpToDate+"' " +sqltest;*/

          /*query changed on 06-03-2024 for taking refbrchid from gl_vpurd using config*/
	          		String sql="select h1.description bankaccno,if(um.bpvno>0,'Paid','Not paid') paid,det.date chqdate,dt.chqname,det.chqno sectychqno,vo.doc_no,dt.dealno ,hh.description financiername ,hh.account ,dt.stdate,DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month) enddate,"
	          				+ " round(dt.dwnpyt+dt.loanamt,2) totalval, round(dt.dwnpyt,2) dwnpyt,round(dt.perintst,2) intst,round( det.totamt,2) MonthlyEMI,"
	          				+ " round( det.intstamt,2) interest,round( det.pramt,2) principle , round( det.totamt,2) pytvalue, "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.intstamt,2),0) interest1, "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.pramt,2),0) principle1 , "
	          				+ "if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.totamt,2),0) pytvalue1,"
	          				+ " round( coalesce(det.totamt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.totamt,2),0) ,2) pytvalue2, "
	          				+ " round(coalesce(det.pramt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.pramt,2),0),2) principle2 "
	          				+ ",round( coalesce(det.intstamt,0)-if((um.bpvno=9999999 or m.doc_no is not null) and um.bpvno<>0,round( det.intstamt,2),0),2) interest2 "
	          				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join "
	          				+ " (select refbrhid,rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join gl_vehmaster veh on "
	          				+ " (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno 	"
	          				+ " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  left join gl_vehfin f on f.doc_no=dt.finaccno "
	          				+ " left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno  left join  gl_vpurdetd det on det.rdocno=vo.doc_no "
	          				+ " left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and vo.brhid=um.brhid "
	          				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' "
       						+ " where vo.clstatus=1 and um.status<>7 and vo.status=3 and vo.purdate<='"+sqlUpToDate+"' " +sqltest;
	          		
	          //System.out.println("---detail12----"+sql);

            		
           
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            	 
            	 
			    	}
	          	
	          	stmtVeh.close();
 				
            	
          
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray searchexceldetailsdata(String branch,String type,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
	        	
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
				
		    	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
	        	if(type.equalsIgnoreCase("detail"))
				    	{
				    			  	

				//dealno financiername account   order by dt.dealno
            		
/*            	  String sqldet=" select if(um.bpvno>0,'Paid','Not paid') 'Paid',DATE_FORMAT(det.date,'%d/%m/%Y') 'Cheque Date',dt.chqname 'Cheque Name',dt.sectychqno 'Cheque NO', "
            				+ " DATE_FORMAT(dt.stdate,'%d/%m/%Y') 'Start Date', DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d/%m/%Y') 'End Date',round(dt.dwnpyt+dt.loanamt,2) 'Value',round(dt.dwnpyt,2) 'Down Pyt', "
            				+ " round(dt.perintst,2) '% Interest' ,  dt.dealno 'Deal No',hh.description 'Financier Name',hh.account 'Account', "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7),''),char(50)) 'Finance Taken Interest', "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) 'Finance Taken Principle',  "
            				+ " convert(coalesce((select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2  and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3  and um.status<>7),''),char(50)) 'Finance Taken value',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid Interest', "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid Principle',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno<>0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno<>0 and um.status<>7),''),char(50)) 'Paid value' , "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance Interest',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance Principle',  "
            				+ " convert(coalesce((select round(amount,2) from my_unclrchqbd  where rdocno=um.doc_no and sr_no=2 and  um.bpvno=0 and um.status<>7)+(select amount from my_unclrchqbd  where rdocno=um.doc_no and sr_no=3 and  um.bpvno=0 and um.status<>7),''),char(50)) 'Balance value'  "
            				+ " from gl_vpurdetd det left join gl_vpurm vo on vo.doc_no=det.rdocno  left join gl_vpurdetm dt on dt.rdocno=vo.doc_no left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP'  and um.status<>7 and um.refno like 'VPU%' "
            				+ " where  vo.clstatus=1 and vo.status=3 and det.date<='"+sqlUpToDate+"' and um.date<='"+sqlUpToDate+"' "+sqltest ;*/
            		
	        		String sqldet="select vo.voc_no 'Doc No',dt.dealno 'Deal No',hh.description 'Financier Name' ,hh.account 'Account',vd.fleet_no 'Fleets',DATE_FORMAT(dt.stdate,'%d.%m.%Y') 'Start_Date',  DATE_FORMAT(DATE_ADD(dt.stdate,INTERVAL dt.noinstmt month),'%d.%m.%Y') 'End_Date',"
	        				+ " DATE_FORMAT(det.date,'%d/%m/%Y') 'Cheque Date',dt.chqname 'Cheque Name',dt.sectychqno 'Cheque NO', if(um.bpvno>0,'Paid','Not paid') paid, round(dt.dwnpyt+dt.loanamt,2) 'Value', round(dt.dwnpyt,2) 'Down Pyt',round(dt.perintst,2) '% Interest',round( det.totamt,2) 'Monthly EMI',round( det.intstamt,2) ' Finance Interest',round( det.pramt,2) 'Finance Principle' ,  round( det.totamt,2) 'Finance Value', if((um.bpvno=9999999 or m.doc_no is not null),round( det.intstamt,2),0) 'Paid Interest', if((um.bpvno=9999999 or m.doc_no is not null),round( det.pramt,2),0) 'Paid Principle' , if((um.bpvno=9999999 or m.doc_no is not null),round( det.totamt,2),0) 'Paid Value',"
	          				+ " round(coalesce(det.pramt,0)-if((um.bpvno=9999999 or m.doc_no is not null),round( det.pramt,2),0),2) 'Bal Principle' "
	          				+ ",round( coalesce(det.intstamt,0)-if((um.bpvno=9999999 or m.doc_no is not null),round( det.intstamt,2),0),2) 'Bal Interest', "
							+ " round( coalesce(det.totamt,0)-if((um.bpvno=9999999 or m.doc_no is not null),round( det.totamt,2),0) ,2) 'Bal Value' "
	          				+ " from gl_vpurm  vo  left join my_head h on h.doc_no=vo.venid left join "
	          				+ " (select rdocno,convert(group_concat(concat(veh.reg_no,' ',plt.code_name)),Char(1000)) fleet_no from gl_vpurd vp left join gl_vehmaster veh on "
	          				+ " (vp.fleet_no=veh.fleet_no) left join gl_vehplate plt on veh.pltid=plt.doc_no group by rdocno) vd on vo.doc_no=vd.rdocno 	"
	          				+ " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  left join gl_vehfin f on f.doc_no=dt.finaccno "
	          				+ " left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno  left join  gl_vpurdetd det on det.rdocno=vo.doc_no "
	          				+ " left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' and vo.brhid=um.brhid and um.status<>7 "
	          				+ " left join  my_chqbm m on um.bpvno=m.doc_no  and m.brhid=um.brhid  and m.dtype='bpv' and  m.DATE<='"+sqlUpToDate+"' "
       						+ " where vo.clstatus=1 and vo.status=3 and vo.purdate<='"+sqlUpToDate+"' " +sqltest;
            		    
	        		
            		
            		//System.out.println("---detailexcel---sql----"+sqldet);

            		
           
            		ResultSet resultSet = stmtVeh.executeQuery(sqldet);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            	 
				    	}
 				stmtVeh.close();
 				
            	
          
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	
	
	public JSONArray fleetdetails(String branch,String fleetno,String finco,String dealno,String uptodate,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")) {
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	String sqltest1="";	
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		    	
		     	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
		    	/*if(type.equalsIgnoreCase("summary"))
		    	{
		    		
		    		sqltest1+="	order by dt.dealno ";
		    	}
		    	*/

				//dealno financiername account           order by dt.dealno
		    	
		    	
		    	if(fleetno!=null && !fleetno.equalsIgnoreCase("") && !fleetno.equalsIgnoreCase("undefined")) {
		    		sqltest+=" and d.fleet_no="+fleetno;
		    	}
		    	

				String configchk="select method from gl_config where field_nme='refbrchidchk'";
		  		ResultSet configchkss = stmtVeh.executeQuery(configchk);
	           // System.out.println("configchk---"+configchk);
	           int method=0;
	            while(configchkss.next()) {
	            	method=configchkss.getInt("method");
	            }
		    	
	            
	            if(method==1) {
	            	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			 			sqltest+=" and d.refbrhid='"+branch+"'";
			 		}	
	            }else{
	            	
	            	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}
	            }
		    	
		    	/*String sql="select  vo.doc_no,d.price purchaseval,d.fleet_no,veh.flname,veh.reg_no,dt.dealno,hh.description financiername,hh.account account,"
		    			+ " ROUND((d.price/COALESCE(purd.totalpurchase,0))*COALESCE(m.totamt,0),2) amountbal"
		    			//+ "d.price- if(sum(coalesce(um.totalamount,0))=0 ,(d.price-(dt.dwnpyt/a.rowss)),(sum(coalesce(um.totalamount,0))  / dt.loanamt) * (d.price-(dt.dwnpyt/a.rowss))) amountbal "
		    			+ " from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid "
		    			+ " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
		    			+ " left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no "
		    			+ " left join gl_vpurd d on d.rdocno=vo.doc_no     left join gl_vehmaster veh on veh.fleet_no=d.fleet_no"
		    			+ " LEFT JOIN (" + 
		    			"	SELECT det.rdocno,COALESCE(SUM(totamt),0) totamt FROM gl_vpurdetd det " + 
		    			"	INNER JOIN gl_vpurm m1 ON det.rdocno=m1.doc_no " + 
		    			"	INNER JOIN my_unclrchqbm um ON det.bpvno=um.doc_no AND um.dtype='UCP' AND um.bpvno=0 AND um.status<>7 AND m1.brhid=um.brhid " + 
		    			"	LEFT JOIN  my_chqbm m ON um.bpvno=m.doc_no  AND m.brhid=um.brhid  AND m.dtype='bpv' AND  m.DATE<='"+sqlUpToDate+"' " + 
		    			"	WHERE (COALESCE(um.bpvno,0)=0 OR m.doc_no IS NULL)  GROUP BY rdocno ) m ON m.rdocno=vo.doc_no"
		    			+" LEFT JOIN (SELECT SUM(price) totalpurchase,rdocno FROM gl_vpurd GROUP BY rdocno) purd ON purd.rdocno=vo.doc_no "
		    			+ "  where d.flstatus=1 and vo.status=3  and vo.date<='"+sqlUpToDate+"' "+sqltest+" group by d.fleet_no";   	*/	
         
		    	/*query changed on 06-03-2024 for taking refbrchid from gl_vpurd using config*/

		    	String sql="select  vo.doc_no,d.price purchaseval,d.fleet_no,veh.flname,veh.reg_no,dt.dealno,hh.description financiername,hh.account account,"
		    			+ " ROUND((d.price/COALESCE(purd.totalpurchase,0))*COALESCE(m.totamt,0),2) amountbal"
		    			//+ "d.price- if(sum(coalesce(um.totalamount,0))=0 ,(d.price-(dt.dwnpyt/a.rowss)),(sum(coalesce(um.totalamount,0))  / dt.loanamt) * (d.price-(dt.dwnpyt/a.rowss))) amountbal "
		    			+ " from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid "
		    			+ " left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
		    			+ " left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no "
		    			+ " left join gl_vpurd d on d.rdocno=vo.doc_no     left join gl_vehmaster veh on veh.fleet_no=d.fleet_no"
		    			+ " LEFT JOIN (" + 
		    			"	SELECT det.rdocno,COALESCE(SUM(totamt),0) totamt FROM gl_vpurdetd det " + 
		    			"	INNER JOIN gl_vpurm m1 ON det.rdocno=m1.doc_no " + 
		    			"	INNER JOIN my_unclrchqbm um ON det.bpvno=um.doc_no AND um.dtype='UCP' AND um.bpvno=0 AND um.status<>7 AND m1.brhid=um.brhid " + 
		    			"	LEFT JOIN  my_chqbm m ON um.bpvno=m.doc_no  AND m.brhid=um.brhid  AND m.dtype='bpv' AND  m.DATE<='"+sqlUpToDate+"' " + 
		    			"	WHERE (COALESCE(um.bpvno,0)=0 OR m.doc_no IS NULL)  GROUP BY rdocno ) m ON m.rdocno=vo.doc_no"
		    			+" LEFT JOIN (SELECT refbrhid,SUM(price) totalpurchase,rdocno FROM gl_vpurd GROUP BY rdocno) purd ON purd.rdocno=vo.doc_no "
		    			+ "  where d.flstatus=1 and vo.status=3  and vo.purdate<='"+sqlUpToDate+"' "+sqltest+" group by d.fleet_no";
		    	
//    			+ " left join my_head h1   on h1.doc_no=dt.bankaccno left join     my_head h2 on h2.doc_no=dt.intstaccno "
//    			+ " left join my_head h3 on h3.doc_no=dt.loanaccno      left join gl_vpurdetd det on det.rdocno=vo.doc_no"

		    	
		    	/* 		String sql=" select d.price purchaseval,d.fleet_no,veh.flname,veh.reg_no,dt.dealno,hh.description financiername,hh.account account, "
            				+ "(((select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no) and dtype='UCP' "
            				+ " and bpvno<>0 and refno like 'VPU%')/dt.loanamt)*d.price) amountbal "
            				+ "   from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid    left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
            				+ "  left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no   left join my_head h1   on h1.doc_no=dt.bankaccno left join  "
            				+ "  my_head h2 on h2.doc_no=dt.intstaccno    left join my_head h3 on h3.doc_no=dt.loanaccno "
            				+ "  left join gl_vpurdetd det on det.rdocno=vo.doc_no    left join gl_vpurd d on d.rdocno=vo.doc_no  "
            				+ "   left join gl_vehmaster veh on veh.fleet_no=d.fleet_no left join my_unclrchqbm um on det.bpvno=um.doc_no and um.dtype='UCP' "
            				+ " and um.bpvno<>0 and um.refno like 'VPU%'    where d.flstatus=1 and vo.status=3 and d.fleet_no='"+fleetno+"' "+sqltest+" group by d.fleet_no  ";
            		*/
            		
        //  System.out.println("------fleet----"+sql);

            		
           
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	
          
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray fleetexceldetails(String branch,String fleetno,String finco,String dealno,String uptodate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
		    	
	        	String sqltest="";
	        	java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
	        
		    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		 			sqltest+=" and vo.brhid='"+branch+"'";
		 		}	
		     	if(!((finco.equalsIgnoreCase("")) || (finco.equalsIgnoreCase("NA")) || (finco.equalsIgnoreCase("0")))){
		 			sqltest+=" and f.doc_no='"+finco+"'";
		 		}	
		    	if(!((dealno.equalsIgnoreCase("")) || (dealno.equalsIgnoreCase("NA")) || (dealno.equalsIgnoreCase("0")))){
		 			sqltest+=" and  dt.dealno='"+dealno+"'";
		 		}	
		    	/*if(type.equalsIgnoreCase("summary"))
		    	{
		    		
		    		sqltest1+="	order by dt.dealno ";
		    	}
		    	*/

				//dealno financiername account           order by dt.dealno
		    	
		    	
		    	
		    	/*String sql="select  vo.doc_no,d.price purchaseval,d.fleet_no,veh.flname,veh.reg_no,dt.dealno,hh.description financiername,hh.account account,"
		    			+ "d.price- if(sum(coalesce(um.totalamount,0))=0 ,(d.price-(dt.dwnpyt/a.rowss)),(sum(coalesce(um.totalamount,0))  / dt.loanamt) * (d.price-(dt.dwnpyt/a.rowss))) amountbal "
		    			+ "from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid "
		    			+ "left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
		    			+ "left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no "
		    			+ "left join my_head h1   on h1.doc_no=dt.bankaccno left join     my_head h2 on h2.doc_no=dt.intstaccno "
		    			+ "left join my_head h3 on h3.doc_no=dt.loanaccno      left join gl_vpurdetd det on det.rdocno=vo.doc_no"
		    			+ " left join gl_vpurd d on d.rdocno=vo.doc_no     left join gl_vehmaster veh on veh.fleet_no=d.fleet_no"
		    			+ " left join (select totalamount,doc_no from my_unclrchqbm where bpvno!=0 ) um   on det.bpvno=um.doc_no"
		    			+ " left join (select count(*) rowss,rdocno from  gl_vpurd group by rdocno) a on a.rdocno=vo.doc_no"
		    			+ "  where d.flstatus=1 and vo.status=3   and d.fleet_no='"+fleetno+"' and vo.date<='"+sqlUpToDate+"' and det.date<='"+sqlUpToDate+"' "+sqltest+" group by d.fleet_no";   		
        */ 
		    	
		    	String sql="select  d.fleet_no 'Fleet No',veh.flname 'Fleet Name',veh.reg_no 'Reg No',dt.dealno 'Deal No',  "
            				+ " hh.description 'Financier Name',hh.account 'Account', "
		    			+ "  round(d.price,2) 'Purchase Value',d.price- if(sum(coalesce(um.totalamount,0))=0 ,d.price-(dt.dwnpyt/a.rowss),    (sum(coalesce(um.totalamount,0))  / dt.loanamt) * (d.price-(dt.dwnpyt/a.rowss))) 'Balance Amount ' "
		    			+ "    from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid  "
		    			+ "  left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
		    			+ "    left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no  "
		    			+ "  left join my_head h1   on h1.doc_no=dt.bankaccno left join  "
		    			+ "   my_head h2 on h2.doc_no=dt.intstaccno    left join my_head h3 on h3.doc_no=dt.loanaccno  "
		    			+ "    left join gl_vpurdetd det on det.rdocno=vo.doc_no left join gl_vpurd d on d.rdocno=vo.doc_no  "
		    			+ "   left join gl_vehmaster veh on veh.fleet_no=d.fleet_no    left join (select totalamount,doc_no from my_unclrchqbm where bpvno!=0 and status<>7) um "
		    			+ "  on det.bpvno=um.doc_no left join (select count(*) rowss,rdocno from  gl_vpurd group by rdocno) a on a.rdocno=vo.doc_no  "
		    			+ "        where d.flstatus=1 and vo.status=3   and d.fleet_no='"+fleetno+"' and vo.purdate<='"+sqlUpToDate+"' and det.date<='"+sqlUpToDate+"' "+sqltest+" group by d.fleet_no  ";
		    	//System.out.println("------sql----"+sql);
       /*     		
            		String sql="select d.fleet_no 'Fleet No',veh.flname 'Fleet Name',veh.reg_no 'Reg No',dt.dealno 'Deal No',  "
            				+ " hh.description 'Financier Name',hh.account 'Account',round(d.price,2) 'Purchase Value', "
            				+ " round((((select sum(totalamount)  from my_unclrchqbm  where doc_no in (select bpvno from  gl_vpurdetd where rdocno=vo.doc_no)  "
            				+ " and dtype='UCP'  and bpvno<>0 and refno like 'VPU%')/dt.loanamt)*d.price),2) 'Balance Amount '  "
            				+ "  from gl_vpurm vo   left  join my_head h on h.doc_no=vo.venid  "
            				+ "  left join gl_vpurdetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1)  "
            				+ "  left join gl_vehfin f on f.doc_no=dt.finaccno  left join my_head hh on hh.doc_no=f.acc_no  left join my_head h1   on h1.doc_no=dt.bankaccno left join  "
            				+ "   my_head h2 on h2.doc_no=dt.intstaccno    left join my_head h3 on h3.doc_no=dt.loanaccno  "
            				+ "   left join gl_vpurdetd det on det.rdocno=vo.doc_no    left join gl_vpurd d on d.rdocno=vo.doc_no  "
            				+ "     left join gl_vehmaster veh on veh.fleet_no=d.fleet_no   left join my_unclrchqbm um on det.bpvno=um.doc_no  "
            				+ " and um.dtype='UCP'  and um.bpvno<>0 and um.refno like 'VPU%'    where d.flstatus=1 and vo.status=3 and  d.fleet_no='"+fleetno+"' "+sqltest+" group by d.fleet_no  ";
            		
            		*/
            		//System.out.println("------sql----"+sql);

            		
           
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
 				stmtVeh.close();
 				
            	
          
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	public JSONArray fleetseachmove() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            	/*	String sql="select m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet ',m.FLEET_NO,'  ',m.FLNAME,'  ',REG_NO,   ' . ', au.authname,'  ',pl.code_name,' . ', 'YOM  ',y.YOM,'   ',c.color, ' . ','Salik Tag   ', "
            				+ "m.SALIK_TAG,' . ',   'Exp ',' ','Reg : ',m.REG_EXP,'  ' ,'Ins :' ,m.INS_EXP,' . ', 'Insured at  ' , i.inname,' . ', "
            				+ " 'Last Service  ', 'Date : ',m.SRVC_DTE,' ',' KM :',m.SRVC_KM,' . ', 'Warranty ', 'Date :' ,m.WAR,'  ',   'KM :', m.WAR_KM,' . ',  "
            				+ " 'Engine NO  ' ,m.ENG_NO,' . ','Chassis NO ', m.CH_NO),char(1000)) vehinfo  from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID "
            				+ "  left join my_color c on(m.clrid=c.doc_no)   left join gl_yom y on y.doc_no=m.yom "
            				+ "   left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl "
            				+ " on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3";*/
				
			String sql="select m.fleet_no,m.flname,m.reg_no from gl_vpurd d left join gl_vehmaster m on m.fleet_no=d.fleet_no  where d.fleet_no is not null order by d.fleet_no ";
				
            		//System.out.println("fleetsearch"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
          

		}
		catch(Exception e){
		    e.printStackTrace();
			conn.close();	
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public JSONArray dealnoseachmove() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
			String sql="select dealno from gl_vpurdetm";
				
            	//	System.out.println(""+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
          

		}
		catch(Exception e){
		    e.printStackTrace();
			conn.close();	
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
}
