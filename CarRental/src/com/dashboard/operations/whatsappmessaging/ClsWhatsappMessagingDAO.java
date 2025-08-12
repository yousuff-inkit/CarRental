package com.dashboard.operations.whatsappmessaging;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWhatsappMessagingDAO  {
	ClsConnection ClsConnection=new ClsConnection();  

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray detailGridLoad(String id, String group) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		if(!id.equals("1")) {
			return RESULTDATA;
		}
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    String sql="", sqltest="";
			    if(!group.equals("") && group!=null) {
			    	sqltest=" and ac.groups='"+group+"'";   
			    }
			   
			    sql = "select b.status,ac.cldocno, ac.refname, ac.per_mob mobno, c.category, h.account acno, ac.groups from my_acbook ac left join my_head h on h.doc_no=ac.acno "
			    		  + "left join my_clcatm c on c.doc_no=ac.catid and c.dtype='crm' left join (select status, mobno from wa_blocklist where status=1 "
			    		  + "group by mobno) b on b.mobno=ac.per_mob where ac.dtype='CRM' and ac.status<>7"+sqltest+"";   
			    
			    ResultSet resultSet = stmtStaff.executeQuery(sql);   
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtStaff.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	 public JSONArray groupdetails() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select groups,cldocno,refname from my_acbook where status=3 and dtype='CRM' and groups is not null group by groups"; 
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
}