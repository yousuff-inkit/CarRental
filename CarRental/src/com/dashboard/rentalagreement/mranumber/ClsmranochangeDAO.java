package com.dashboard.rentalagreement.mranumber;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsmranochangeDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray salesmanchangedetails() throws SQLException {
	     JSONArray RESULTDATA=new JSONArray();
	     
	     Connection conn =null;
	     try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				
				String sql="select sal_name,doc_no from my_salm where status=3";
				//System.out.println("-------salesman---------"+sql);
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
	 public JSONArray fleetdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
				//System.out.println("-------fleet---------"+sql);
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
 public JSONArray detailedgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String salesman,String type,String outchk,String inchk,String catid) throws SQLException {
//System.out.println(salesman);
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
  	
   //	System.out.println("hjbf"+salesmandoc);
 	String sqltest="",sqltestdate="",sqltest1="";
 	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA") || status.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and r.clstatus='"+status+"' ";
 	}
 	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA") || cldocno.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and a.cldocno='"+cldocno+"' ";
 	}
 	/*if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA") || fleet.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and r.fleet_no='"+fleet+"' ";
 	}*/
 	if(!(salesman.equalsIgnoreCase("") || salesman.equalsIgnoreCase("NA") || salesman.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and r.salid='"+salesman+"' ";
 	}
 	
 	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA") || type.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and t.rentaltype='"+type+"' ";
 	}
 	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA") || catid.equalsIgnoreCase("NULL"))){
 		sqltest=sqltest+" and a.catid='"+catid+"' ";
 	}
 	
 	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			sqltest+=" and r.brhid="+brnchval+"";
		}
 	
	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA") || fleet.equalsIgnoreCase("NULL"))){
	 		sqltest1=sqltest1+" and r.fleet_no='"+fleet+"' ";
	 	}
 	
 	/*if(inchk.equalsIgnoreCase("IN"))
 	{
 		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 		
 	}
 	else
 	{*/
 		
 		sqltestdate+="	and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 	/*}*/
 	
 		String sqlreptest="";
      sqlreptest+="and  rep.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 	
 	Connection conn =  null;
 	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
				int data=0;
				Statement stmt=conn.createStatement();
				String strsql="select method from gl_config where field_nme='MRAnoreplacement'";
				//System.out.println("config========="+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					data=rs.getInt("method");
				}
				
				String sqlreplacementquery="";
         		if(data==1) {
         			if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA") || fleet.equalsIgnoreCase("NULL"))){
         				sqlreptest=sqlreptest+" and rep.ofleetno='"+fleet+"' ";
         		 	}
         		 	
         			sqlreplacementquery="UNION ALL SELECT @s:=@s+1 SL,'REPLACEMENT' reftypes,rep.doc_no Docno,r.voc_no 'RA NO',rep.referenceno  'PO NO', rep.ofleetno Fleet,v.FLNAME 'Fleet Name',v.reg_no 'Reg NO',r.ofleet_no 'Contract Fleet',v1.reg_no 'Contract Reg No',a.refname 'Client Name',  a.contactperson 'Contact Person', cdr.name 'Driver',a.per_mob 'Mob NO',t.rentaltype 'Rental Type',  r.ddate 'Due Date',r.dtime 'DueTime',  convert(coalesce(r.refno,''),char(30)) 'Ref No',r.mrano 'Manual RA',  ur.user_name 'Open User', ms.sal_name 'Salesman' , tc.rate Rent,tc.cdw CDW,  coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and  rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) 'Inv Rent',  coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and  rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) 'Inv CDW' "
         					+ " from gl_vehreplace rep left join gl_ragmt r on (rep.rtype='RAG' and rep.rdocno=r.doc_no) "
         					+ "left join gl_vehmaster v on rep.ofleetno=v.fleet_no  left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'  left join gl_vehgroup g on g.doc_no=v.vgrpid left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7 left join gl_vehbrand br  on br.doc_no=v.brdid  left join gl_vehmodel mo on  mo.doc_no=v.vmodid left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no   left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3  left join gl_drdetails cdr on cdr.dr_id=dr.drid  left join my_user ur on ur.doc_no=r.userid left join my_salm ms on ms.doc_no=r.salid ,(SELECT @s:= 0) AS s  where r.status=3   " +sqltest+ "	"+sqlreptest+"  group by rep.doc_no";
         		}
         		
         		
         		String sql =" select @i:=@i+1 slno, a.* from(select  @s:=@s+1 SL,'RENTAL AGREEMENT' reftypes,r.doc_no Docno,r.voc_no 'RA NO',r.mrano 'PO NO',r.fleet_no Fleet,v.FLNAME 'Fleet Name',"
         				+ "v.reg_no 'Reg NO',r.ofleet_no 'Contract Fleet',v1.reg_no 'Contract Reg No',"
         				+ "a.refname 'Client Name',  a.contactperson 'Contact Person', cdr.name 'Driver',"
         				+ "a.per_mob 'Mob NO',t.rentaltype 'Rental Type',  r.ddate 'Due Date',r.dtime 'DueTime',"
         				+ "  convert(coalesce(r.refno,''),char(30)) 'Ref No',r.mrano 'Manual RA',"
         				+ "  ur.user_name 'Open User', ms.sal_name 'Salesman' , tc.rate Rent,tc.cdw CDW,"
         				+ "  coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1 and  rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) 'Inv Rent',"
         				+ "  coalesce((select invoiced from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17 and  rowno=(select max(rowno) from gl_rcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) 'Inv CDW'  from gl_ragmt r	left join gl_vehmaster v on r.fleet_no=v.fleet_no  left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'  left join gl_vehgroup g on g.doc_no=v.vgrpid"
         				+ " left join  gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5 "
         				+ " left join  gl_rtarif tc on tc.rdocno=r.doc_no and tc.rstatus=7"
         				+ " left join gl_vehbrand br  on br.doc_no=v.brdid "
         				+ " left join gl_vehmodel mo on  mo.doc_no=v.vmodid"
         				+ " left join gl_vehmaster v1 on r.ofleet_no=v1.fleet_no"
         				+ "   left join gl_rdriver dr on dr.rdocno=r.doc_no and dr.status=3"
         				+ "  left join gl_drdetails cdr on cdr.dr_id=dr.drid "
         				+ " left join my_user ur on ur.doc_no=r.userid left join my_salm ms on ms.doc_no=r.salid ,"
         				+ "(SELECT @s:= 0) AS s  where r.status=3     " +sqltest+ " "+sqltest1+" "+sqltestdate+" group by r.doc_no "+sqlreplacementquery+")a,(select @i:=0)c";
         		
         	
      // System.out.println("----sssss grid load----"+sql);
             
         		ResultSet resultSet = stmtVeh.executeQuery(sql);
         		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
         		// System.out.println("--------"+RESULTDATA);
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
 
 public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
 public JSONArray catnamesearchdetails() throws SQLException {

	  JSONArray RESULTDATA=new JSONArray();

   Connection conn=null;
		try {
				  conn = ClsConnection.getMyConnection();
				Statement stmtVeh5 = conn.createStatement ();
       	
				String  tarifsql=("select cat_name,doc_no from my_clcatm where dtype='CRM' and status=3;");
				//System.out.println("----------------catname--------------"+tarifsql);
				
				ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh5.close();
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
