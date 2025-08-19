package com.dashboard.humanresource.employeeinactive;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeInactiveDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray employeeListGridLoading(String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 
			 	 String sql = "";
			 	sql="select @i:=@i+1 id,a.* from ( select m.terminated_date terdt,m.doc_no docno, m.codeno empid,m.name,des.desc1 designation,dep.desc1 department,cat.desc1 category,m.dtjoin,m.pmaddr address,if(m.active=1,'ACTIVE','TERMINATED') status,m.pmmob mobile,m.pmemail email,m.dob,m.gender,m.brhid from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join my_brch mb on m.brhid=mb.doc_no ) a,(SELECT @i:= 0) as i";
			 	
			 	System.out.println(" ====grid loading ==== "+sql);
		    	   
				
				ResultSet resultSet = stmtEMP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
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
 
