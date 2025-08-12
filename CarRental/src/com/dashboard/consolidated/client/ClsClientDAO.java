package com.dashboard.consolidated.client;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
  public JSONArray clientListGridLoading(String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	if(!(check.equalsIgnoreCase("load"))){
		return RESULTDATA;
	}
	Connection conn = null;

	
	  try {
		     conn = ClsConnection.getMyConnection();
		    Statement stmtCRM = conn.createStatement ();
		    Statement stmt1 = conn.createStatement ();
		    int srno=1; 
		    
		    String dbListQuery = "SELECT distinct dbname, compname FROM alintercomp.my_intrcomp m";
	        ResultSet dbResultSet = stmt1.executeQuery(dbListQuery);

	        while (dbResultSet.next()) {
	            String dbname = dbResultSet.getString("dbname"); 
	            String compname = dbResultSet.getString("compname");
	            
	            String clsql="SELECT bc.branchname branch,cl.per_salikrate salcharge,cl.per_trafficharge trafcharge,h.account,cat.acc_group,tx.desc1 taxcat,cl.credit,cl.period,cl.period2,cat.category,refname,cl.cldocno,per_mob,sal_name,"
			    		+" concat(coalesce(cl.address,''),'  ',coalesce(cl.address2,'')) as address,mail1,if(invc_method=1,'Month End','Period') "
			    		+" invc_method, if(del_charges=0,'No','Yes') del_charges,trnnumber,if(cl.advance=0,'No','Yes') advance,mclb.type ctype,mclb.cardno cno,mclb.exp_date expdate,dr.name drname,cl.date cldate"
			    		+" FROM "+dbname+".my_acbook CL left JOIN "+dbname+".my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join "+dbname+".my_salm s on cl.sal_id=s.doc_no"
			    		+" left join "+dbname+".my_head h on cl.acno=h.doc_no left join "+dbname+".my_cltax tx on cl.taxid=tx.doc_no  left join (select min(sr_no) srno,rdocno,type,cardno from "+dbname+".my_clbankdet where 1=1 group by rdocno order by sr_no) clb  on clb.rdocno=cl.cldocno  left join "+dbname+".my_clbankdet mclb  on clb.srno=mclb.sr_no left join (select min(dr_id) dr_id,cldocno,name from "+dbname+".gl_drdetails where dtype='CRM' group by cldocno order by dr_id)drd on drd.cldocno=cl.cldocno left join "+dbname+".gl_drdetails dr on dr.dr_id=drd.dr_id  left join "+dbname+".my_brch bc on bc.doc_no=cl.brhid where cl.dtype='CRM' and cl.status=3";
			    //System.out.println("list====== "+clsql);
		    ResultSet resultSet = stmtCRM.executeQuery (clsql);
		    
		    //RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    while(resultSet.next()){
                JSONObject objsub=new JSONObject();
                objsub.put("category", resultSet.getString("category"));
				objsub.put("cldocno", resultSet.getString("cldocno"));
                objsub.put("refname", resultSet.getString("refname"));
                objsub.put("per_mob", resultSet.getString("per_mob"));
                objsub.put("sal_name", resultSet.getString("sal_name"));
                objsub.put("address", resultSet.getString("address"));
                objsub.put("mail1", resultSet.getString("mail1"));
                objsub.put("invc_method", resultSet.getString("invc_method"));
                objsub.put("del_charges", resultSet.getString("del_charges"));
                objsub.put("trnnumber", resultSet.getString("trnnumber"));
                objsub.put("advance", resultSet.getString("advance"));
                objsub.put("account", resultSet.getString("account"));
				objsub.put("acc_group", resultSet.getString("acc_group"));
                objsub.put("credit", resultSet.getString("credit"));
                objsub.put("period", resultSet.getString("period"));
                objsub.put("period2", resultSet.getString("period2"));
                objsub.put("taxcat", resultSet.getString("taxcat"));
                objsub.put("ctype", resultSet.getString("ctype"));
                objsub.put("cno", resultSet.getString("cno"));
                objsub.put("expdate", resultSet.getString("expdate"));
                objsub.put("drname", resultSet.getString("drname"));
                objsub.put("salcharge", resultSet.getString("salcharge"));
				objsub.put("cldate", resultSet.getString("cldate"));
				objsub.put("trafcharge", resultSet.getString("trafcharge"));
				objsub.put("slno", srno);
				objsub.put("compname", compname);
                objsub.put("branch", resultSet.getString("branch"));
                RESULTDATA.add(objsub);
                srno++;
            }
	        }
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
