package com.dashboard.humanresource.linemanagerassign;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLinemanagerassignDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray empUserLinkGridLoading(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
          try {  
                conn = ClsConnection.getMyConnection();
                Statement stmtSUL = conn.createStatement();
                
                if(check.equalsIgnoreCase("1")) {
                
                    String sql = "";
                    
                 
                    sql = "select m.codeNo code,m.name,m.pmemail email,m.pmmob mobile,m.doc_no docno,h.account,m.linemanager linedocno,cm.grpcode linemgr from hr_empm m left join my_head h on m.acno=h.doc_no left join my_user u on m.empuserlink=u.doc_no left join cm_serteamm cm on cm.doc_no=m.linemanager where m.status=3";
                   // System.out.println("gridsql=============>"+sql);
                    ResultSet resultSet = stmtSUL.executeQuery(sql);
                                
                    RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                }
                
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
    
	
	public JSONArray userDetails() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			 	  String  sql = "select m.doc_no doc_no,m.grpcode groupcode from cm_serteamm m where m.status=3";
				   // System.out.println("empsearch========"+sql);
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