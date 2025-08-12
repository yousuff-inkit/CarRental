package com.dashboard.operations.raladriverupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsralaDriverUpdateDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rad) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
     
        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	 
 
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				 
				String sql=null;
				
				if(rad.equalsIgnoreCase("1"))
				{
				sql=	"select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
							+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.clstatus=0 and r.status=3 "+sqltest+" group by doc_no";
				//System.out.println("------rsql------"+sql);

				}
				else
				{
				sql=	("select r.voc_no,r.doc_no,if(r.perfleet=0,r.tmpfleet,r.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt r left join gl_vehmaster v on v.fleet_no=if(r.perfleet=0,r.tmpfleet,r.perfleet) "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.clstatus=0 and r.status=3 "+sqltest+" group by doc_no");
				//System.out.println("------lsql------"+sql);

				}
				
				
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		     
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	public   JSONArray clientDetailsSearch(String rad) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
	    if(rad.equalsIgnoreCase("1"))
	    {
		sql = "select r.cldocno,a.refname from gl_ragmt r left join  my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  where r.clstatus=0 and  r.status=3 and a.dtype='CRM' group by r.cldocno";
	    }
	    else if(rad.equalsIgnoreCase("0"))
	    {
			sql = "select r.cldocno,a.refname from gl_lagmt r left join  my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  where r.clstatus=0 and  r.status=3 and a.dtype='CRM' group by r.cldocno";

	    }
	    	
	    	ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	 public  JSONArray driverlist(String branchval,String fromdate,String todate,String cldocno,String agmtNo,String rad) throws SQLException {

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
	     	
	      	
     	String sqltest="";
 
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.cldocno='"+cldocno+"'";
	    	}
	    	 
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and agmt.doc_no='"+agmtNo+"'";
	    	}
	     
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and agmt.brhid="+branchval+"";
	 		}
	    	
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection(); 
					Statement stmt = conn.createStatement (); 
				 String sql="";
				if(rad.equalsIgnoreCase("1"))
				{
					
				
	            		sql ="	select agmt.doc_no,agmt.voc_no,agmt.fleet_no,r.brhid,v.flname,r.cldocno,r.srno,a.refname,r.status,dr.name drname,agmt.odate outdate, 'RA' type from  gl_ragmt agmt inner join  gl_rdriver r on r.rdocno=agmt.doc_no and r.cldocno=agmt.cldocno " + 
	            				"			 inner join my_acbook a on a.cldocno=agmt.cldocno " + 
	            				"			and a.dtype='CRM' inner join gl_drdetails dr on dr.dr_id=r.drid left join gl_vehmaster v on  v.fleet_no=agmt.fleet_no " + 
	            				"			where agmt.clstatus=0  and agmt.status=3 and r.status=3 and agmt.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"   group by r.srno order by agmt.doc_no   ";
	            			 
	            	 	//System.out.println("RA"+sql);
				}
				else
				{
					sql ="	select agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,r.brhid,v.flname,r.cldocno,r.status,r.srno,a.refname,dr.name drname,agmt.outdate, 'LA' type from  gl_lagmt agmt inner join  gl_ldriver r on r.rdocno=agmt.doc_no and r.cldocno=agmt.cldocno " + 
            				"			 inner join my_acbook a on a.cldocno=agmt.cldocno " + 
            				"			and a.dtype='CRM' inner join gl_drdetails dr on dr.dr_id=r.drid left join gl_vehmaster v on  v.fleet_no=if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) " + 
            				"			where agmt.clstatus=0  and agmt.status=3 and r.status=3 and agmt.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +"   group by r.srno order by agmt.doc_no   ";
            			 
            	 	//System.out.println("LA"+sql);

				}
	            		ResultSet resultSet = stmt.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	            		 stmt.close();
	            	
	          
	            	
  				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
		public  JSONArray driverGridReloading(String docNo,String cldocno,String type,HttpSession session) throws SQLException {
	        
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtCRM = conn.createStatement();
					String branch=session.getAttribute("BRANCHID").toString().trim();
					String sqls="";
					if(type.equalsIgnoreCase("RA"))
							{
						sqls=  "select d.doc_no,d.dr_id,d.name,d.dob,DATE_FORMAT(d.dob,'%d.%m.%Y') AS hiddob,d.nation as nation1,d.mobno,d.passport_no,d.pass_exp,"
								+ "DATE_FORMAT(d.pass_exp,'%d.%m.%Y') AS hidpassexp,d.dlno,d.issdate,DATE_FORMAT(d.issdate,'%d.%m.%Y') AS hidissdate,d.issfrm,d.led,DATE_FORMAT(d.led,'%d.%m.%Y') AS hidled,"
								+ "d.ltype,d.visano,d.visa_exp,DATE_FORMAT(d.visa_exp,'%d.%m.%Y') AS hidvisaexp,CASE WHEN rd.status=3 then 'ACTIVE' WHEN rd.status=7 then 'INACTIVE' END as status,'RA' type,rd.rdocno,rd.srno FROM  gl_rdriver rd left join gl_ragmt r on rd.rdocno=r.doc_no left join gl_drdetails d on d.dr_id=rd.drid where r.cldocno="+cldocno+"  and rd.rdocno="+docNo+"";
							}
					else
					{
						sqls=  "select d.doc_no,d.dr_id,d.name,d.dob,DATE_FORMAT(d.dob,'%d.%m.%Y') AS hiddob,d.nation as nation1,d.mobno,d.passport_no,d.pass_exp,"
								+ "DATE_FORMAT(d.pass_exp,'%d.%m.%Y') AS hidpassexp,d.dlno,d.issdate,DATE_FORMAT(d.issdate,'%d.%m.%Y') AS hidissdate,d.issfrm,d.led,DATE_FORMAT(d.led,'%d.%m.%Y') AS hidled,"
								+ "d.ltype,d.visano,d.visa_exp,DATE_FORMAT(d.visa_exp,'%d.%m.%Y') AS hidvisaexp , CASE WHEN ld.status=3 then 'ACTIVE' WHEN ld.status=7 then 'INACTIVE' END as status,'LA' type,ld.rdocno,ld.srno FROM gl_ldriver ld left join gl_lagmt l on ld.rdocno=l.doc_no left join gl_drdetails d on d.dr_id=ld.drid where l.cldocno="+cldocno+"  and ld.rdocno="+docNo+"";
								
					}
							
					//	System.out.println("divergrid-------------"+sqls);	
					ResultSet resultSet = stmtCRM.executeQuery (sqls);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtCRM.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	    }
		public  JSONArray clientDriverSearch(String clientid,String rentaltype,String aggno) throws SQLException {

			  JSONArray RESULTDATA=new JSONArray();
			         
			  Connection conn=null;
			     
			  try {
			       conn = ClsConnection.getMyConnection();
			       Statement stmtORQ = conn.createStatement();
			       
			       String sqltest="";
				     
				   if(rentaltype.equalsIgnoreCase("RA")){
				    	 sqltest+="  gl_rdriver"; 
				   }
				   
				   else if(rentaltype.equalsIgnoreCase("LA")){
				    	 sqltest+=" gl_ldriver";
				   }
				   int method=0;
				   String condn="";
			       ResultSet rsconfig=stmtORQ.executeQuery("Select method from gl_config where field_nme='ADDINTERNALDRV'");       
				   while (rsconfig.next()) {
					method=rsconfig.getInt("method");
				   }
				   
				   if(method==1){
					   condn=" ((d.cldocno="+clientid+" and d.dtype='crm' ) or d.dtype='drv' ) ";
				   }
				   else {
					   condn=" (d.cldocno="+clientid+" and d.dtype='crm' ) ";
				   }
			       String sqls="SELECT coalesce(s.sal_code,'') code,d.dr_id,d.doc_no,d.name,d.dob,d.nation,d.mobno,d.dlno,d.issdate,d.led,d.ltype,d.issfrm,d.passport_no,"
					       	 + "d.pass_exp,d.visano,d.visa_exp,d.hcdlno,d.hcissdate,d.hcled ,d.cldocno,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age,"
					       	 + "DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear,(select value from gl_config where field_nme='drage') drage ,"
					       	 + "(select value from gl_config where field_nme='licyr') licyr FROM gl_drdetails d left join my_salesman s on s.sal_type=d.dtype and d.doc_no=s.doc_no WHERE "+condn+" and d.dr_id not in (select drid from "+sqltest+" where  rdocno="+aggno+")";
			  //   System.out.println("driversearch"+sqls);
			       ResultSet resultSet = stmtORQ.executeQuery(sqls);
			       
			      RESULTDATA=ClsCommon.convertToJSON(resultSet);
			      
			      stmtORQ.close();
			      conn.close();
			   }
			   catch(Exception e){
			     e.printStackTrace();
			     conn.close();
			   }
			         return RESULTDATA;
			 }


}
