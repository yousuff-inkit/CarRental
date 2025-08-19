package com.dashboard.operations.agmtclosereview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgmtCloseReviewDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getAgmtData(String branch,String fromdate,String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(!branch.trim().equalsIgnoreCase("") && !branch.trim().equalsIgnoreCase("a")) {
				sqlfilters+=" and agmtbr.doc_no="+branch;
			}
			if(!fromdate.equalsIgnoreCase("")) {
				java.sql.Date sqlfromdate=null;
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters+=" and base.closedate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")) {
				java.sql.Date sqltodate=null;
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqlfilters+=" and base.closedate<='"+sqltodate+"'";
			}
			
			String strsql="SELECT CASE WHEN base.infuel=0.000 THEN 'Level 0/8' WHEN base.infuel=0.125 THEN 'Level 1/8' WHEN base.infuel=0.250 THEN 'Level 2/8' "+ 
					"  WHEN base.infuel=0.375 THEN 'Level 3/8' WHEN base.infuel=0.500 THEN 'Level 4/8' WHEN base.infuel=0.625 THEN 'Level 5/8'  WHEN base.infuel=0.750 "+ 
					"  THEN 'Level 6/8' WHEN base.infuel=0.875 THEN 'Level 7/8' WHEN base.infuel=1.000 THEN 'Level 8/8'  END as strinfuel,@i:=COALESCE(@i,0)+1 slno,agmtbr.branchname agmtbranch,base.*,ac.cldocno,ac.RefName,veh.flname,CONCAT(auth.AUTHID,' ',veh.REG_NO,' ',plt.CODE_NAME) regdetails FROM (\r\n" + 
					" SELECT agmt.brhid agmtbrhid,m.cldocno,agmt.doc_no,agmt.voc_no,agmt.date agmtdate,m.date closedate,m.indate,m.intime,m.inkm,m.infuel,m.fleet_no,'RAG' agmttype \r\n" + 
					" FROM gl_ragmtclosem m \r\n" + 
					" LEFT JOIN gl_ragmt agmt ON m.agmtno=agmt.doc_no WHERE m.status=3\r\n" + 
					" UNION ALL\r\n" + 
					" SELECT agmt.brhid agmtbrhid,m.cldocno,agmt.doc_no,agmt.voc_no,agmt.date agmtdate,m.date closedate,m.indate,m.intime,m.inkm,m.infuel,m.fleet_no,'LAG' agmttype \r\n" + 
					" FROM gl_lagmtclosem m \r\n" + 
					" LEFT JOIN gl_lagmt agmt ON m.agmtno=agmt.doc_no WHERE m.status=3) base\r\n" + 
					" LEFT JOIN gl_vehmaster veh ON base.fleet_no=veh.FLEET_NO\r\n" + 
					" LEFT JOIN gl_vehplate plt ON veh.PLTID=plt.DOC_NO\r\n" + 
					" LEFT JOIN gl_vehauth auth ON veh.AUTHID=auth.DOC_NO\r\n" + 
					" LEFT JOIN my_acbook ac ON base.cldocno=ac.cldocno AND ac.dtype='CRM'"+
					" left join my_brch agmtbr on base.agmtbrhid=agmtbr.doc_no,(SELECT @i:=0) i where 1=1"+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getInvoiceData(String agmtno,String agmttype,String id) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(agmttype.equalsIgnoreCase("RAG")) {
				sqlfilters=" and m.ratype='RAG' and m.rano="+agmtno+" and m.manual=3";
			}
			else if(agmttype.equalsIgnoreCase("LAG")) {
				sqlfilters=" and m.ratype='LAG' and m.rano="+agmtno+" and m.manual=5";
			}
			String strsql="SELECT @i:=coalesce(@i,0)+1 slno,m.doc_no invdocno,m.voc_no invvocno,m.date,m.fromdate,m.todate,md.description,d.units,d.total amount,d.total auditamt FROM gl_invm m \r\n" + 
					"LEFT JOIN gl_invd d ON m.doc_no=d.rdocno\r\n" + 
					"LEFT JOIN gl_invmode md ON d.chid=md.idno AND md.status=1,(select @i:=0) i \r\n" + 
					"WHERE m.status=3"+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
}
