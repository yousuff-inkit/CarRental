package com.dashboard.audit.driveruserlink;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDriverUserLink  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray driverLinkGridLoading(String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!check.equalsIgnoreCase("1")) {  
			return RESULTDATA;   
		}
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    String sql = " select u.doc_no docno,u.user_name username,d.sal_name driver from my_user u left join my_salesman d on d.doc_no=u.driverid and d.sal_type='DRV' ";
				    ResultSet resultSet = stmtSUL.executeQuery(sql);
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    stmtSUL.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray userDetails(String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		 if(!chk.equalsIgnoreCase("1")) {
			 return RESULTDATA;    
		 }
		Connection conn = null;
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    	
			    String sql = " select sal_name name,doc_no docno from my_salesman where sal_type='DRV' ";  
			    ResultSet resultSet = stmtSUL.executeQuery(sql);
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
			    stmtSUL.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
}