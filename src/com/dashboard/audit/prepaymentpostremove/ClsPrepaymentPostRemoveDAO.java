package com.dashboard.audit.prepaymentpostremove;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPrepaymentPostRemoveDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getJvData(String id, String branch, String fromdate, String todate) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		try {
			conn = objconn.getMyConnection();
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
	        }
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = objcommon.changeStringtoSqlDate(todate);
	        }
			
			String sqlfilters = "";
			if (!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")) {
				sqlfilters += " and m.brhId=" + branch;
			}

			if(!(sqlFromDate==null)){
				sqlfilters+=" and m.date>='"+sqlFromDate+"'";
		    }
	        
	        if(!(sqlToDate==null)){
	        	sqlfilters+=" and m.date<='"+sqlToDate+"'";
		    }
	        
			Statement stmt = conn.createStatement();
			String strsql = "SELECT m.doc_no,m.date,m.description,if(d.dramount<0,(d.dramount*-1),d.dramount) amount,if(d.ldramount<0,(d.ldramount*-1),d.ldramount) localamount,t.description accountname,c.code currency,"
        			+ "(select GROUP_CONCAT(h.description) from my_jvtran d left join my_head h on d.acno=h.doc_no where d.tr_no=m.tr_no) reference,m.brhid,m.tr_no FROM my_jvma m left join my_jvtran d on "
        			+ "(m.tr_no=d.tr_no  and d.ref_row=1) left join my_head t on d.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where m.status=3 and m.dtype ='JVT' and m.refid=4 "+sqlfilters;
   
			ResultSet rs = stmt.executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getJvDetailData(String docno, String brhid, String id) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String joins=objcommon.getFinanceVocTablesJoins(conn);
			String casestatement=objcommon.getFinanceVocTablesCase(conn);
			
			String strsql = "select a.date, a.desc1, a.aa, a.postacno, a.account, a.accountname, a.acno, a.paccount, a.paccountname, "+casestatement+"a.branch, a.description,a.transtype, a.posteddate, a.dramount, a.postamount, a.pendamount from ("
					+ "select m.date,m.desc1,m.tranid aa,m.postacno,he.account,he.description accountname,he.doc_no acno,pe.account paccount,pe.description paccountname,jv.doc_no transNo,b.branchname branch,jv.description,"  
					+ "jv.dtype transtype,d.date posteddate,coalesce(d.amount,0) dramount,abs(m.amount) postamount,(select m.amount-postamount) pendamount,m.brhid from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join "
					+ "my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no "
					+ "where jv.status=3 and m.brhid="+brhid+" and d.jvtrno in (select tr_no from my_jvtran where doc_no="+docno+" and brhid="+brhid+" and dtype='jvt')) a"+joins;
			
			ResultSet rs = stmt.executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}
	
}
