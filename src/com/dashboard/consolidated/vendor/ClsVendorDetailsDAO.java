package com.dashboard.consolidated.vendor;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVendorDetailsDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	public JSONArray vendorList(String check) throws SQLException {
		Connection conn = null;
		JSONArray RESULTDATA = new JSONArray();
		if(!(check.equalsIgnoreCase("load"))){
			return RESULTDATA;
		}
		try {
			conn = connDAO.getMyConnection();
			Statement stmtVND = conn.createStatement();
			Statement stmt1 = conn.createStatement ();
			int srno=1;
			
			 String dbListQuery = "SELECT distinct dbname, compname FROM alintercomp.my_intrcomp m";
		        ResultSet dbResultSet = stmt1.executeQuery(dbListQuery);

		        while (dbResultSet.next()) {
		            String dbname = dbResultSet.getString("dbname");   
		            String compname = dbResultSet.getString("compname");

		            String Sql = "SELECT bc.branchname branch,category,cl.doc_no,cl.codeno,refname,per_mob,sal_name,concat(cl.address,'  ',cl.address2) as address, "
							+ "mail1,vt.desc1 type,trnnumber,cl.acno account,h.description accountgroup,cl.period creditperiodmin,cl.period2 creditperiodmax,cl.credit creditlimit "
							+ "FROM "+dbname+".my_acbook CL left JOIN "+dbname+".my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='VND' left join "+dbname+".my_salesman s on (cl.sal_id=s.doc_no) and sal_type='SLA' "
							+ "left join "+dbname+".my_vndtax vt on vt.doc_no=cl.type left join "+dbname+".my_head h on h.doc_no=cl.acc_group left join "+dbname+".my_brch bc on bc.doc_no=cl.brhid where cl.dtype='VND'";
					//System.out.println("vendor====== "+Sql);
			ResultSet resultSet = stmtVND.executeQuery(Sql);
			//RESULTDATA = commonDAO.convertToJSON(resultSet);
			while(resultSet.next()){
                JSONObject objsub=new JSONObject();
                objsub.put("category", resultSet.getString("category"));
				objsub.put("doc_no", resultSet.getString("doc_no"));
                objsub.put("codeno", resultSet.getString("codeno"));
                objsub.put("refname", resultSet.getString("refname"));
				objsub.put("per_mob", resultSet.getString("per_mob"));
                objsub.put("sal_name", resultSet.getString("sal_name"));
                objsub.put("mail1", resultSet.getString("mail1"));
                objsub.put("type", resultSet.getString("type"));
				objsub.put("trnnumber", resultSet.getString("trnnumber"));
                objsub.put("account", resultSet.getString("account"));
                objsub.put("accountgroup", resultSet.getString("accountgroup"));
				objsub.put("creditperiodmin", resultSet.getString("creditperiodmin"));
                objsub.put("creditperiodmax", resultSet.getString("creditperiodmax"));
                objsub.put("slno", srno);
                objsub.put("creditlimit", resultSet.getString("creditlimit"));
				objsub.put("compname", compname);
                objsub.put("branch", resultSet.getString("branch"));
                RESULTDATA.add(objsub);
                srno++;
			}
			
		        }
			stmtVND.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}
		
}
