package com.dashboard.operations.ridermgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRiderMgmtDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getRiderData(String brhid,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			
			String sqlfilters="";
			if(brhid!=null && !brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("undefined")) {
				sqlfilters+=" and emp.brhid="+brhid;
			}
			String strsql="select coalesce(st.refname,'') empstatus,coalesce(rl.doc_no,0) riderdocno,coalesce(nrm.doc_no,0) nrmdocno,sal.doc_no saldocno,rl.clientacno,ac.refname assignedrefname,coalesce(nrm.clstatus,0) movclstatus,veh.fleet_no assignedfleetno,veh.flname assignedflname,br.doc_no brhid,br.branchname,emp.doc_no empdocno,emp.codeno empid,emp.name empname,emp.pmmob empmobile,emp.emp_id,dsg.doc_no desigdocno,dsg.desc1 empdesig from hr_empm emp \r\n" + 
			" left join hr_setdesig dsg on emp.desc_id=dsg.doc_no\r\n" + 
			" left join my_brch br on emp.brhid=br.doc_no "+
			" LEFT JOIN my_salesman sal ON emp.acno=sal.acc_no "+
			" left join (select max(doc_no) maxdocno,saldocno,saltype from gl_riderlog where clstatus=0 group by saldocno) maxr on sal.doc_no=maxr.saldocno and sal.sal_type=maxr.saltype "+
			" left join gl_riderlog rl on maxr.maxdocno=rl.doc_no "+
			" left join gl_nrm nrm on rl.nrmdocno=nrm.doc_no "+
			" left join gl_vehmaster veh on nrm.fleet_no=veh.fleet_no "+
			" left join gl_riderstatus st on sal.riderstatus=st.code"+
			" left join my_acbook ac on rl.clientacno=ac.acno where emp.status=3 "+sqlfilters;
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
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
