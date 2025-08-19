package com.dashboard.accounts.applyingcorrection;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsApplyingcorrectionDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	  if(!(check.equalsIgnoreCase("1"))){
		  return RESULTDATA1;
	  }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmt = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.mail1 email,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmt.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	public JSONArray griddetails(String check,String branchval,String atype,String acno) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	  if(!(check.equalsIgnoreCase("1"))){
		  return RESULTDATA1;
	  }
	  
	  String sqltest="";
   	if(!(branchval.equalsIgnoreCase("a") || branchval.equalsIgnoreCase("")  || branchval.equalsIgnoreCase("0") || branchval.equalsIgnoreCase("NA")  )) {
   		sqltest= "and j.brhid='"+branchval+"' ";
   	}
   	
 	if(!(atype.equalsIgnoreCase("")))
	{
		sqltest+=" and  h.atype='"+atype+"' ";	
	}
 	if(!(acno.equalsIgnoreCase("")))
	{
		sqltest+=" and  h.doc_no='"+acno+"' ";	
	}
   		
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmt = conn.createStatement();
			
		       
				String sql = "select sum(dramount) amount ,  sum(dramount- out_amount)damount,sum(out_amount) outamount ,acno account,count(*),h.atype type,h.doc_no doc_no ,h.description acname from my_jvtran j left join my_head h on j.acno=h.doc_no where   h.den in (340,255) and  status=3 "+sqltest+" group by acno having amount!=damount";
				
				ResultSet resultSet1 = stmt.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
