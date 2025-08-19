package com.dashboard.operations.employeesponsor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;

import net.sf.json.JSONArray;

public class ClsEmployeeSponsorDAO {

	 ClsConnection ClsConnection = new ClsConnection();
	 ClsCommon ClsCommon = new ClsCommon();
	 
	 public JSONArray getEmployeeData(String brhid,String id) throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return data;
			}
			Connection conn=null;
			try {
				conn=ClsConnection.getMyConnection();
				
				String sqlfilters="";
				if(brhid!=null && !brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("undefined") && !brhid.trim().equalsIgnoreCase("0")) {
					sqlfilters+=" and emp.brhid="+brhid;
				}
				String strsql="SELECT coalesce(cl.doc_no,0) vendorid,coalesce(cl.refname,'') vendor,COALESCE(rl.clientuid,'') riderid,COALESCE(rl.doc_no,0) riderdocno,sal.doc_no saldocno,br.doc_no brhid,emp.doc_no empdocno,emp.codeno empid,emp.name empname,emp.pmmob empmobile,emp.emp_id,dsg.doc_no desigdocno,dsg.desc1 empdesig FROM hr_empm emp LEFT JOIN hr_setdesig dsg ON emp.desc_id=dsg.doc_no LEFT JOIN my_brch br ON emp.brhid=br.doc_no LEFT JOIN my_salesman sal ON emp.acno=sal.acc_no LEFT JOIN (SELECT MAX(doc_no) maxdocno,saldocno,saltype FROM gl_riderlog WHERE clstatus=0 GROUP BY saldocno) maxr ON sal.doc_no=maxr.saldocno AND sal.sal_type=maxr.saltype LEFT JOIN gl_riderlog rl ON maxr.maxdocno=rl.doc_no LEFT JOIN my_acbook ac ON rl.clientacno=ac.acno left join my_velink vl on emp.doc_no=vl.employeeid and vl.status=3 left join my_acbook CL on cl.doc_no=vl.vendorid and cl.dtype='VND' WHERE emp.status=3 "+sqlfilters;
				//System.out.println(strsql);
				ResultSet rs=conn.createStatement().executeQuery(strsql);
				data=ClsCommon.convertToJSON(rs);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			finally {
				if(conn!=null && !conn.isClosed()) {
					conn.close();
				}
			}
			
			return data;
		}
	 
	 public JSONArray getTariffData(String id) throws SQLException{
		 JSONArray data=new JSONArray();
		 if(!id.equalsIgnoreCase("1")) {
			 return data;
		 }
		 Connection conn=null;
		 try {
			 conn=ClsConnection.getMyConnection();
			 String strsql="SELECT vl.doc_no,cl.refname vendor, vl.vendorid, vl.monthlyratecar, vl.pickupratebike, vl.droppoffratebike, vl.description from my_vtariff vl left join my_acbook CL on cl.doc_no=vl.vendorid and cl.dtype='VND' where vl.status=3";
			 ResultSet rs=conn.createStatement().executeQuery(strsql);
			 data=ClsCommon.convertToJSON(rs);
		 }
		 catch(Exception e) {
			 e.printStackTrace();
		 }
		 finally {
			 if(conn!=null && !conn.isClosed()) {
				 conn.close();
			 }
		 }
		 
		 return data;
	 }
	
	
}
