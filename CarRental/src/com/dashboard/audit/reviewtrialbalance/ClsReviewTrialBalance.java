package com.dashboard.audit.reviewtrialbalance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsReviewTrialBalance  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray reviewTrialBalanceGridLoading(String branch,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		int amtdec=Integer.parseInt(session.getAttribute("AMTDEC").toString());
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtRTB = conn.createStatement();
			    String sql = "";String joins="";String casestatement="";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
			    
			    joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
			    

				sql = "select a.date,a.transtype,"+casestatement+"a.branchname,a.description,round(sum(a.debit),"+amtdec+") debit,round(sum(a.credit),"+amtdec+") credit,a.reason,a.tr_no  from (select j.date,j.dtype transtype,j.doc_no transNo,b.branchname,j.description,if(j.ldramount>0,j.ldramount*j.id,0) debit,if(j.ldramount<0,j.ldramount*j.id,0) credit,CASE WHEN h.account is null THEN 'Account No is Unavailable' WHEN coalesce(h.grpno,0)=0 THEN 'Account Group is Unavailable' WHEN coalesce(h.alevel,0)=0 THEN 'Account Group is Unavailable' WHEN h.m_s=1 THEN 'Main Account Transactions' ELSE 'Other Issues' END AS reason,h.account,h.grpno,h.m_s,j.tr_no,j.ldramount,j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_brch b on j.brhid=b.doc_no where j.status=3  and (h.account is null or coalesce(h.grpno,0)=0 or coalesce(h.alevel,0)=0 or h.m_s=1) union all select j.date,j.dtype transtype,j.doc_no transNo,b.branchname,j.description,if(sum(round(j.ldramount,"+amtdec+"))>0,sum(round(j.ldramount,"+amtdec+"))*j.id,0) debit,if(sum(round(j.ldramount,"+amtdec+"))<0,sum(round(j.ldramount,"+amtdec+"))*j.id,0) credit,'Transaction not tallying' reason,h.account,h.grpno,h.m_s,j.tr_no,j.ldramount,j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_brch b on j.brhid=b.doc_no where j.dtype !='opn' and j.status=3 group by j.tr_no having sum(round(j.ldramount,"+amtdec+"))!=0 "+sql+") a"+joins+" group by a.tr_no";
				
				System.out.println("First Grid :"+sql);

			    ResultSet resultSet = stmtRTB.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtRTB.close();
			    conn.close();
		  }catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray reviewTrialBalanceSubGridLoading(String trno,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtRTB = conn.createStatement();
			    String joins="";String casestatement="";
			    
			    joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
			    
				String sql = "select a.date,a.transtype,"+casestatement+"a.branchname,a.account,a.description,round(a.debit,2) debit,round(a.credit,2) credit,a.reason  from ("
			    	+ "select j.date,j.dtype transtype,j.doc_no transNo,b.branchname,j.description,if(j.ldramount>0,j.ldramount*j.id,0) debit,if(j.ldramount<0,j.ldramount*j.id,0) credit,"
			    	+ "CASE WHEN h.account is null THEN 'Account No is Unavailable' WHEN coalesce(h.grpno,0)=0 THEN 'Account Group is Unavailable' WHEN coalesce(h.alevel,0)=0 THEN 'Account Group is Unavailable' WHEN h.m_s=1 THEN 'Main Account Transactions' ELSE '' END AS reason,"
			    	+ "h.account,h.grpno,h.m_s,j.brhid,j.tr_no from my_jvtran j left join my_head h on j.acno=h.doc_no left join my_brch b on j.brhid=b.doc_no where j.status=3 "
			    	+ "and j.tr_no="+trno+") a"+joins+"";
			    
			    System.out.println("second Grid :"+sql);
				ResultSet resultSet = stmtRTB.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtRTB.close();
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