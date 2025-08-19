package com.dashboard.operations.whatsapptemplate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWhatsappTemplateDAO  {
	ClsConnection ClsConnection=new ClsConnection();  

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray detailGridLoad(String id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		if(!id.equals("1")) {
			return RESULTDATA;
		}
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    String sql="", sqltest="";
			   
			    sql = "SELECT w.doc_no, DATE_FORMAT(w.entrydate,'%d.%m.%Y') createddate, w.name templatename, w.headertext, w.bodytext, w.footertext, w.lang language,"
			    	  + " w.status, w.category, w.mediaid, w.whatsappid, u.user_name createduser FROM wa_template w LEFT JOIN my_user u ON u.doc_no=w.userid";
			    //System.out.println("sql--->>>"+sql);
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
}