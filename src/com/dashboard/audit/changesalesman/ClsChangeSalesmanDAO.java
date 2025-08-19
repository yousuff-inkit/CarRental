package com.dashboard.audit.changesalesman;
        
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsChangeSalesmanDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
		 
	  public JSONArray contractGridLoad(int id,String fromdate,String todate,String salid) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			if(id!=1){  
				return RESULTDATA;
			}
			Connection conn = null;

			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			  try {
				     conn = objconn.getMyConnection();
				    Statement stmtCRM = conn.createStatement ();
				    String sqltest="";
				    if(!fromdate.equals("") && fromdate!=null){
				    	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				    }
				    if(!todate.equals("") && todate!=null){
				    	sqltodate=objcommon.changeStringtoSqlDate(todate);
				    }
				    if(salid!=null && !salid.equals("")){
				    	sqltest+=" and CL.sal_id='"+salid+"'";
				    }
				    
				    String clsql="SELECT cl.per_salikrate salcharge,cl.per_trafficharge trafcharge,h.account,cat.acc_group,tx.desc1 taxcat,cl.credit,cl.period,cl.period2,cat.category,refname,cl.cldocno,per_mob,sal_name,"
				    		+" concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,if(invc_method=1,'Month End','Period') "
				    		+" invc_method, if(del_charges=0,'No','Yes') del_charges,trnnumber"
				    		+" FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no"
				    		+" left join my_head h on cl.acno=h.doc_no left join my_cltax tx on cl.taxid=tx.doc_no where cl.dtype='CRM' and cl.status=3"+sqltest+"";
				   // System.out.println("list====== "+clsql);
				    ResultSet resultSet = stmtCRM.executeQuery (clsql);
				    
				    RESULTDATA=objcommon.convertToJSON(resultSet);
				    
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
}