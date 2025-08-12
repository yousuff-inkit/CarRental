package com.dashboard.rectification.clientchange;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsClientchangeDAO {
	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray clientchangeData(HttpSession session,int id,String fromdate,String todate, String agmttype,String branch,String client) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			 String  sql = "", sqltest = "";
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
			 
		    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
		    String sqlbr="";
		      if(!(branch.equalsIgnoreCase(""))) {
		    	  sqlbr="and r.brhid="+branch+"";
		    	  
		      }
		      String sqlclient="";
		      if(!(client.equalsIgnoreCase(""))) {
		    	  sqlclient="and r.cldocno="+client+"";
		    	  
		      }
		   if(agmttype.equalsIgnoreCase("RAG")) {  
		    sql=" select r.date,r.doc_no,r.voc_no,r.brhid,b.branchname branch,'RAG' type,concat('Fleet: ',veh.fleet_no,' - ','Reg.No: ',veh.reg_no) vehdet,ac.cldocno,ac.refname client,s.sal_name salesman,rf.rentaltype renttype,round(rf1.rate,2) tarifrate "
		    		+" From gl_ragmt r  left join gl_rtarif rf on rf.rdocno=r.doc_no and rf.rstatus=5  left join gl_rtarif rf1 on rf1.rdocno=r.doc_no and rf1.rstatus=7 "
		    		+"  left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' join my_head h on h.doc_no=ac.acno "
		    		+" left join gl_vehmaster veh on r.fleet_no=veh.fleet_no left join my_brch b on b.doc_no=r.brhid left join my_salm s on s.doc_no=r.salid "  
		    		+" where r.status=3 and r.date>='"+sqlfromdate+"' and r.date<='"+sqltodate+"' and r.clstatus=0 "+sqlbr+"  "+sqlclient+" group by r.doc_no";
		 
		    }else if(agmttype.equalsIgnoreCase("LAG")) {
			    sql=" select r.date,r.doc_no,r.voc_no,r.brhid,b.branchname branch,'LAG' type,concat('Fleet: ',coalesce(r.tmpfleet,r.perfleet),' - ','Reg.No: ',veh.reg_no) vehdet,ac.cldocno,ac.refname client,s.sal_name salesman,'' renttype,round(rf.rate,2) tarifrate "
			    		+" From gl_lagmt r  left join gl_ltarif rf on rf.rdocno=r.doc_no "
			    		+"  left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' join my_head h on h.doc_no=ac.acno "
			    		+" left join gl_vehmaster veh on coalesce(r.tmpfleet,r.perfleet)=veh.fleet_no left join my_brch b on b.doc_no=r.brhid left join my_salm s on s.doc_no=r.salid "  
			    		+" where r.status=3 and r.date>='"+sqlfromdate+"' and r.date<='"+sqltodate+"' and r.clstatus=0 "+sqlbr+" "+sqlclient+" group by r.doc_no";
			 
			    } 
		  // System.out.println("===client change grid sql===="+sql);       
			ResultSet resultSet1 = stmt.executeQuery(sql);       
			RESULTDATA1=objcommon.convertToJSON(resultSet1); 

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray clientSearch() throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			 String  sql = "", sqltest = "";
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 
			
		    sql=" select ac.cldocno, ac.refname refname from my_acbook ac where ac.dtype='CRM' and ac.status=3 ";
		 //    System.out.println("===client search sql===="+sql);       
			ResultSet resultSet1 = stmt.executeQuery(sql);       
			RESULTDATA1=objcommon.convertToJSON(resultSet1); 

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

}


