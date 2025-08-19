package com.dashboard.leaseagreement.driverremovelog;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsdriverRemovelogDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public  JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno) throws SQLException {

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
        		sqltest+=" and if(r.perfleet=0,r.tmpfleet,r.perfleet) like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	 
 
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				 
				String sql=("select r.voc_no,r.doc_no,if(r.perfleet=0,r.tmpfleet,r.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt r left join gl_vehmaster v on v.fleet_no=if(r.perfleet=0,r.tmpfleet,r.perfleet) "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.clstatus=0 and r.status=3 "+sqltest+" group by doc_no");
				
		//	System.out.println("------sql------"+sql);
				
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
	
	public   JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select r.cldocno,a.refname from gl_lagmt r left join  my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM'  where r.clstatus=0 and  r.status=3 and a.dtype='CRM' group by r.cldocno";
		
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
	
	 public  JSONArray driverlist(String branchval,String fromdate,String todate,String cldocno,String agmtNo) throws SQLException {

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
				 
				
	            		String sql ="	select agmt.doc_no,agmt.voc_no,if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet) fleet_no,r.brhid,v.flname,r.cldocno,r.srno,\r\n"
	            				+ "  a.refname,dr.name drname,DATE_FORMAT(bl.edate, \"%d.%m.%Y\")edate,usr.user_name username from gl_biblog bl\r\n"
	            				+ "inner join  gl_ldriver r on bl.doc_no=r.srno\r\n"
	            				+ "inner join gl_lagmt agmt on r.rdocno=agmt.doc_no\r\n"
	            				+ "inner join my_acbook a on agmt.cldocno=a.cldocno and a.dtype='CRM'\r\n"
	            				+ "inner join gl_drdetails dr on dr.dr_id=r.drid\r\n"
	            				+ "left join gl_vehmaster v on  v.fleet_no=if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)\r\n"
	            				+ "left join my_user usr on bl.userid=usr.doc_no\r\n"
	            				+ "where bl.dtype='BLDR' and date(edate)>= '"+sqlfromdate+"'and  date(edate)<= '"+sqltodate+"' "+sqltest +"   group by r.srno order by bl.edate \r\n";
	            			 
	            	 System.out.println(""+sql);
	              
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
	    


}
