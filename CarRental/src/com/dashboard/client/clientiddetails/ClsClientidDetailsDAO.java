package com.dashboard.client.clientiddetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientidDetailsDAO {
	
	
		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();

		
		public JSONArray clientiddetgrid(String client,String check) throws SQLException {
			
			JSONArray RESULTDATA=new JSONArray();
	        if(!(check.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtCRM = conn.createStatement();
					String sql = "",sql1="";
					
					String sqltest="";
					   if(!(client.equalsIgnoreCase("0")) && !(client.equalsIgnoreCase(""))){
				            sqltest=sqltest+" and ac.cldocno = '"+client+"'";
				        }
					 
					   int iddocno=0;
					   String idname="";
					   sql1="select doc_no,name from my_iddetail where status=3";
					 //  System.out.println("--iddetail query--"+sql1);
					   ArrayList<String> idarray = new ArrayList<String>();
					   ResultSet rs1=stmtCRM.executeQuery(sql1);
					   while (rs1.next()) {
						   
						 iddocno = rs1.getInt("doc_no");
						 idname = rs1.getString("name");
						 idarray.add(iddocno+"");
					  }
					    
					  String sqljoin="",sqlselect="";
					  for (int i = 0; i < idarray.size(); i++) {
						  String id=idarray.get(i);
						  String alias="aa"+i;
						  sqljoin+=" left join (select name,cldocno,d.no,d.validdt from my_iddetail m left join my_cliddet d on m.doc_no=d.refid where m.doc_no="+id+" group by cldocno) "+alias+" on "+alias+".cldocno=ac.cldocno";  
						  sqlselect+=",concat(coalesce("+alias+".no,''),case when coalesce(date_format("+alias+".validdt,'%d.%m.%Y'),'')<>'' then ' ,Till ' else '' end,coalesce(date_format("+alias+".validdt,'%d.%m.%Y'),'')) id"+(i+1);
					  
					  }
					  
					sql+="select ac.acno acno,ac.doc_no doc_no,ac.refname clname"+sqlselect+" from my_acbook ac "+sqljoin+" where ac.dtype='CRM' and status=3 "+sqltest+" ";
							
					//System.out.println("--CLIENT DET GRID--"+sql);
					ResultSet resultSet = stmtCRM.executeQuery(sql); 
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
		
		
		 public JSONArray clentdetails() throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn =null;
		        try {
					 conn = ClsConnection.getMyConnection();
					 Statement stmtCRM = conn.createStatement ();
					
					String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' ";
					 ResultSet resultSet = stmtCRM.executeQuery(sql);
		        	
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
		 			
					stmtCRM.close();
		 			conn.close();
		       
			} catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
		
		
}




