package com.dashboard.operations.cnrefundrequest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCNRefundRequestDAO {
	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray cnrefundData(HttpSession session,int id,String fromdate,String todate, String apprtype) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			 String  sql = "", sqltest = "";
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
			 
		    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
		    String sqltest1="";
		      if(apprtype.equalsIgnoreCase("3")) {
		    	  sqltest1=" and cr.status=1 and cr.apprrefno!=0 ";
		    	  
		      }else {
		    	  sqltest1=" and cr.status="+apprtype+" and cr.apprrefno=0 ";

		      }
		     String upsql = "UPDATE gl_cnrefundreq SET status=1 WHERE gmapproval=1 and finalapproval=1 and status!=1";
			 stmt.executeUpdate(upsql);
			 
		    sql="SELECT * FROM(SELECT coalesce(rm.indate ,lm.indate) indate,sm.sal_name, if(cr.status=1 and cr.apprrefno!=0 ,5,if(cr.gmapproval=1 and cr.finalapproval = 0,3,if(cr.finalapproval = 1  and cr.gmapproval = 1 ,4,cr.status))) statusid,if(cr.agmttype='RAG', 'Rental', 'Lease') agmttype,if(cr.agmttype='RAG', ra.brhid, la.brhid) brhid,ac.acno, h.account, ua.user_name appruser, cr.description, cr.doc_no, date_format(cr.entrydate,'%Y-%m-%d') edate, ac.refname client, ac.cldocno, IF(cr.agmttype='RAG', ra.voc_no, la.voc_no) agmtvocno,"
			      		+ " cr.agmtdocno, cr.agmttype agmttypeid, cr.type, ROUND(cr.amount,2) amount, CASE WHEN cr.status = 1 and cr.apprrefno!=0 THEN 'Document Created' WHEN cr.gmapproval = 1 and cr.finalapproval = 1 THEN 'Final Approved' WHEN cr.gmapproval = 1  and cr.finalapproval = 0  THEN 'GM Approved'   WHEN cr.status=2 THEN 'Rejected' ELSE 'Not Approved' END AS status, cr.apprrefno, cr.apprremarks, u.user_name user FROM gl_cnrefundreq cr "
			      		+ "LEFT JOIN my_acbook ac ON ac.cldocno=cr.cldocno AND ac.dtype='CRM' LEFT join gl_ragmt ra ON ra.doc_no=cr.agmtdocno AND cr.agmttype='RAG'  and ra.status=3  "
			      		+ "LEFT JOIN gl_lagmt la ON la.doc_no=cr.agmtdocno AND cr.agmttype='LAG' and la.status=3 LEFT JOIN my_user u ON u.doc_no=cr.userid "
			      		+ " LEFT JOIN my_user ua ON ua.doc_no=cr.appruserid left join my_head h on h.doc_no=ac.acno "
			      		+ " left join my_salm sm on sm.doc_no=ac.sal_id left join gl_ragmtclosem rm on ra.doc_no=rm.agmtno and rm.status=3 left join gl_lagmtclosem lm on la.doc_no=lm.agmtno and lm.status=3 "
			      		+ " WHERE 1=1 "+sqltest1+" )a where edate>='"+sqlfromdate+"' and edate<='"+sqltodate+"'";
		//	System.out.println("===sql===="+sql);       
			ResultSet resultSet1 = stmt.executeQuery(sql);       
			RESULTDATA1=objcommon.convertToJSON(resultSet1); 

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
}
