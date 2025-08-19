package com.dashboard.accounts.distributionmapping;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDistributionmappingDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray gridDetails(String chk,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
      if(!(chk.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        String sqltest="";

		
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

					String sql="select coalesce(d.branch1,'')br1,coalesce(d.branch2,'')br2,coalesce(d.branch3,'')br3,coalesce(d.branch4,'')br4,coalesce(d.branch5,'')br5,coalesce(d.branch6,'')br6, "
            				  + "account account,description description,doc_no docno from my_head h left join my_dsmp d on d.acno=h.doc_no where h.gr_type='"+type+"' and h.den not in(340,255,301)";
            		//System.out.println("-----------Grid Load-----------"+sql);
            		 ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
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
