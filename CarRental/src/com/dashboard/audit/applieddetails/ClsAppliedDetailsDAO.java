package com.dashboard.audit.applieddetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAppliedDetailsDAO {
	ClsConnection ClsConnection = new ClsConnection();

	ClsCommon ClsCommon = new ClsCommon();

	public JSONArray appliedGridLoading(String fromdate, String todate, String branch, String atype, String accountno,
			String check) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if (!(check.equalsIgnoreCase("1"))) {
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String xsql = "", sqltest = "";
			String condition = "";
			String joins = "";
			String casestatement = "";

			joins = ClsCommon.getFinanceVocTablesJoins(conn);
			casestatement = ClsCommon.getFinanceVocTablesCase(conn);

			if (!(atype == null || atype.equalsIgnoreCase(""))) {
				if (atype.equalsIgnoreCase("AP")) {
					condition = " and t1.dramount > 0";
				} else if (atype.equalsIgnoreCase("AR")) {
					condition = " and t1.dramount < 0";
				}
			}

			if (!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase(""))
					&& !(fromdate.equalsIgnoreCase("0"))) {
				sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
			}
			if (!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase(""))
					&& !(todate.equalsIgnoreCase("0"))) {
				sqltodate = ClsCommon.changeStringtoSqlDate(todate);
			}
			if ((!(sqlfromdate == null)) && (!(sqltodate == null))) {
				sqltest += " and t1.date between '" + sqlfromdate + "' and '" + sqltodate + "' ";
			}

			if (!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))) {
				sqltest += " and t1.brhId=" + branch + "";
			}

			/* Removed condition and out_amount != 0 */


			/*xsql = "select a.*," + casestatement
					+ "'0' dummy from (Select t.transno ttransno,t.dtype ttranstype,t.description tdescription,t.date tdate,(t.dramount*t.id) ttramt,d.amount tapplying,((t.dramount*t.id)-(t.out_amount*t.id)) tbalance,t.out_amount*t.id tout_amount,t.tranid ttranid,t.acno tacno,t.curId tcurrency,t.brhid tbrhid,t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t1.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transtype,t1.curid currency,t1.rate,t1.description,"
					+ "if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- "
					+ "if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),' * ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),' * ','Doc Type : ' ,"
					+ "coalesce(t1.dtype),' * ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),' * ','Applied : ', coalesce(if(t1.out_amount<0,"
					+ "round((t1.out_amount*-1),2),round(t1.out_amount,2))),"
					+ "' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from "
					+ "my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join my_outd d on d.tranid=t1.tranid left join (select "
					+ casestatement
					+ " a.brhid, a.dtype, a.description,a.date,a.dramount,a.id,a.out_amount,a.tranid,a.acno,a.curId from (select dtype transType, brhid, tr_no, tranid, doc_no transno, description,date,dramount,id,out_amount,acno,curId,dtype from my_jvtran) a "
					+ joins + ") t on d.ap_trid=t.tranid where t1.status=3 and t1.acno=" + accountno + "" + condition
					+ "  " + "" + sqltest + ") a" + joins + "";*/
		  
	//		xsql = "select ttranstype, tdescription, tdate, ttramt, tapplying,round( ttramt-tapplying,2) tbalance, tout_amount, ttranid, tacno, tcurrency, tbrhid, max(if(id=1,transno,0)) transno, acno, tr_no, tranid, date, brhid, out_amount, transtype, currency, rate, description, tramt, applied, balance, applyinfo, max(if(id=2,transno,0)) ttransno, dummy from(select a.slno,a.id,  a.ttranstype, a.tdescription, a.tdate, a.ttramt, a.tapplying, a.tbalance, a.tout_amount, a.ttranid, a.tacno, a.tcurrency, a.tbrhid, a.acno, a.tr_no, a.tranid, a.date, a.brhid, a.out_amount, a.transtype, a.currency, a.rate, a.description, a.tramt, a.applied, a.balance, a.applyinfo, "+casestatement+"'0' dummy from (select @i:=@i+1 slno, a.* from(Select 1 id, t.doc_no ttransno,t.dtype ttranstype,t.description tdescription,t.date tdate,(t.dramount*t.id) ttramt,d.amount tapplying,((t.dramount*t.id)-(t.out_amount*t.id)) tbalance,t.out_amount*t.id tout_amount,t.tranid ttranid,t.acno tacno,t.curId tcurrency,t.brhid tbrhid, t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t1.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transtype,t1.curid currency,t1.rate,t1.description,if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),'  ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),'  ','Doc Type : ' ,coalesce(t1.dtype),'  ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),'  ','Applied : ', coalesce(if(t1.out_amount<0,round((t1.out_amount*-1),2),round(t1.out_amount,2))),' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join my_outd d on d.tranid=t1.tranid left join my_jvtran t on d.ap_trid=t.tranid where t1.status=3 and t1.acno='"+accountno+"' "+condition+" "+sqltest+")a, (select @i:=0)c union all select @j:=@j+1 slno, a.* from(Select 2 id, t.doc_no ttransno,t.dtype ttranstype,t.description tdescription,t.date tdate,(t.dramount*t.id) ttramt,d.amount tapplying,((t.dramount*t.id)-(t.out_amount*t.id)) tbalance,t.out_amount*t.id tout_amount,t.tranid ttranid,t.acno tacno,t.curId tcurrency,t.brhid tbrhid, t.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t.dtype transtype,t1.curid currency,t1.rate,t1.description,if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),'  ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),'  ','Doc Type : ' ,coalesce(t1.dtype),'  ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),'  ','Applied : ', coalesce(if(t1.out_amount<0,round((t1.out_amount*-1),2),round(t1.out_amount,2))),' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join my_outd d on d.tranid=t1.tranid left join my_jvtran t on d.ap_trid=t.tranid where t1.status=3 and t1.acno='"+accountno+"' "+condition+" "+sqltest+")a, (select @j:=0)c ) a "+joins+")b group by slno";
			xsql = "select max(if(id=1,transno,0)) transno,transtype,date,description,tramt,applied,balance,applyinfo,max(if(id=2,transno,0))  ttransno,ttranstype,tdate,tdescription,ttramt,tapplying,round( ttramt-tapplying,2) tbalance  from(select a.slno,a.id,  a.ttranstype, a.tdescription, a.tdate, a.ttramt, a.tapplying, a.tbalance, a.tout_amount, a.ttranid, a.tacno, a.tcurrency, a.tbrhid, a.acno, a.tr_no, a.tranid, a.date, a.brhid, a.out_amount, a.transtype, a.currency, a.rate, a.description, a.tramt, a.applied, a.balance, a.applyinfo, "+casestatement+"'0' dummy from (select @i:=@i+1 slno, a.* from(Select 1 id, t.doc_no ttransno,t.dtype ttranstype,t.description tdescription,t.date tdate,(t.dramount*t.id) ttramt,d.amount tapplying,((t.dramount*t.id)-(t.out_amount*t.id)) tbalance,t.out_amount*t.id tout_amount,t.tranid ttranid,t.acno tacno,t.curId tcurrency,t.brhid tbrhid, t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t1.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transtype,t1.curid currency,t1.rate,t1.description,if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),'  ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),'  ','Doc Type : ' ,coalesce(t1.dtype),'  ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),'  ','Applied : ', coalesce(if(t1.out_amount<0,round((t1.out_amount*-1),2),round(t1.out_amount,2))),' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join my_outd d on d.tranid=t1.tranid left join my_jvtran t on d.ap_trid=t.tranid where t1.status=3 and t1.acno='"+accountno+"' "+condition+" "+sqltest+")a, (select @i:=0)c union all select @j:=@j+1 slno, a.* from(Select 2 id, t.doc_no ttransno,t.dtype ttranstype,t.description tdescription,t.date tdate,(t.dramount*t.id) ttramt,d.amount tapplying,((t.dramount*t.id)-(t.out_amount*t.id)) tbalance,t.out_amount*t.id tout_amount,t.tranid ttranid,t.acno tacno,t.curId tcurrency,t.brhid tbrhid, t.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,t.brhid,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t.dtype transtype,t1.curid currency,t1.rate,t1.description,if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,convert(concat(' Doc No : ',coalesce(t1.doc_no),'  ','Date  : ',coalesce(DATE_FORMAT(t1.date,'%d-%m-%Y')),'  ','Doc Type : ' ,coalesce(t1.dtype),'  ','Amount : ', coalesce(if(t1.dramount<0,round((t1.dramount*-1),2),round(t1.dramount,2))),'  ','Applied : ', coalesce(if(t1.out_amount<0,round((t1.out_amount*-1),2),round(t1.out_amount,2))),' * ','Balance : ', coalesce(round(((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))),2))),char(1000)) applyinfo from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join my_outd d on d.tranid=t1.tranid left join my_jvtran t on d.ap_trid=t.tranid where t1.status=3 and t1.acno='"+accountno+"' "+condition+" "+sqltest+")a, (select @j:=0)c ) a "+joins+")b group by slno";
		       
			//System.out.println("xsql grid details7==" + xsql);
			ResultSet resultSet = stmtMAD.executeQuery(xsql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtMAD.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}
	

	public JSONArray accountDetails(String type, String account, String partyname, String contact, String chk)
			throws SQLException {
		Connection conn = null;
		JSONArray RESULTDATA1 = new JSONArray();

		try {
			String sql = null;
			String condition = "";
			String sql1 = "";

			if (type.equalsIgnoreCase("AR")) {
				condition = "and a.dtype='CRM'";
			} else if (type.equalsIgnoreCase("AP")) {
				condition = "and a.dtype='VND'";
			}

			if (!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))) {
				sql1 = sql1 + " and t.account like '%" + account + "%'";
			}
			if (!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))) {
				sql1 = sql1 + " and t.description like '%" + partyname + "%'";
			}
			if (!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))) {
				sql1 = sql1 + " and a.per_mob like '%" + contact + "%'";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
					+ "" + condition + " left join my_curr c on t.curid=c.doc_no where t.atype='" + type
					+ "' and a.status<>7 and t.m_s=0" + sql1;

			if (chk.equalsIgnoreCase("1")) {
				ResultSet resultSet1 = stmtMAD.executeQuery(sql);
				RESULTDATA1 = ClsCommon.convertToJSON(resultSet1);
			} else {
				stmtMAD.close();
				conn.close();
				return RESULTDATA1;
			}
			stmtMAD.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA1;
	}
}
