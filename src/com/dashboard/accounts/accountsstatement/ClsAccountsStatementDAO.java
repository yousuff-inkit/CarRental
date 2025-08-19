package com.dashboard.accounts.accountsstatement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountsStatementDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String condition="";
	    	    String sql1 = "";
	    	    
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				else if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            if(!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))){
	                sql1=sql1+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
	        	
				if(type.equalsIgnoreCase("AR") || type.equalsIgnoreCase("AP")){
					sql = "select a.per_mob,a.mail1 email,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql1;
				}
				
				if(type.equalsIgnoreCase("GL") || type.equalsIgnoreCase("HR")){
					sql = "select t.doc_no,t.account,t.description,c.code curr from my_head t left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and t.m_s=0"+sql1;
				}
			//	System.out.println("accountsearch==without="+sql);
				if(chk.equalsIgnoreCase("1")){
				//System.out.println("accountsearch=with=="+sql);
					ResultSet resultSet1 = stmtAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray accountsStatement(String branch,String fromdate,String todate,String accdocno,String check,String atype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="", clientJoin="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            	String stragmtconfig="select method from gl_config where field_nme='acStmtAgmtDetails'";
            	int agmtconfig=0;
            	ResultSet rsagmtconfig=stmtAccountStatement2.executeQuery(stragmtconfig);
            	while(rsagmtconfig.next()) {
            		agmtconfig=rsagmtconfig.getInt("method");
            	}
            	String agmtjoin="",agmtselect1="",costcode="",clientname="",costtype="";
            	String strrd="select sum(if(codeno='amtdec',cvalue,0)) amtdesc,sum(if(codeno='curdec',cvalue,0)) curdesc  from my_system;";
            	int amtdesc=0,curdesc=0;
            	ResultSet rsrd=stmtAccountStatement2.executeQuery(strrd);
            	while(rsrd.next()) {
            		amtdesc=rsrd.getInt("amtdesc");
            		curdesc=rsrd.getInt("curdesc");
            	}
            	
            	String strgrtypecond="";
            	String strgrtype="select gr_type  from my_head where doc_no = "+accdocno ;
                int gr_type=0;
                ResultSet rsgrtype=stmtAccountStatement2.executeQuery(strgrtype);
                while(rsgrtype.next()) {
                    gr_type=rsgrtype.getInt("gr_type");
                }
                if(gr_type==4|| gr_type==5){
                    strgrtypecond=" and t.yrid=0 ";
                }
            			
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				casestatement="convert("+casestatement.replace("AS 'transno',", "")+",char(20)) transno,";
				if(atype.equalsIgnoreCase("AR")) {
				if(agmtconfig==1) {
					joins+="LEFT JOIN gl_ragmt rag ON (a.rtype='RAG' AND a.rdocno=rag.doc_no and rag.status=3)\r\n" + 
            				"LEFT JOIN gl_lagmt lag ON (a.rtype='LAG' AND a.rdocno=lag.doc_no and lag.status=3)\r\n" + 
                			"LEFT JOIN (SELECT jobid,tr_no FROM my_costtran cost WHERE costtype=6 GROUP BY tr_no) cost ON (a.tr_no=cost.tr_no)\r\n" + 
                			"LEFT JOIN gl_vehmaster veh ON (cost.jobid=veh.fleet_no and veh.statu=3)\r\n" + 
                			"LEFT JOIN gl_vehplate plt ON veh.pltid=plt.doc_no\r\n" + 
                			"LEFT JOIN gl_vehauth auth ON veh.authid=auth.doc_no";
            		agmtselect1=",CONCAT(auth.AUTHNAME,' ',veh.reg_no,' ',plt.CODE_NAME) regno,a.rtype agmttype,convert(CASE WHEN a.rtype='RAG' THEN rag.voc_no WHEN a.rtype='LAG' THEN lag.voc_no ELSE '' END,char(15)) agmtvocno,\r\n" + 
            				"CASE WHEN a.rtype='RAG' THEN COALESCE(rag.pono,'') WHEN a.rtype='LAG' THEN COALESCE(lag.po,'') ELSE '' END lpono";
            	}else if(agmtconfig==2){
            	    clientJoin+="left join cm_Srvcontrm sr on (a.costcode=sr.doc_no and a.costtype=sr.costtype) left join my_Acbook mc on sr.cldocno=mc.cldocno and mc.dtype=('crm') ";
            	    costcode+="t.costcode costcode,t.costtype costtype,";
            	    clientname+=",mc.refname ";
            	    costtype+=", t.costcode,t.costtype";
            	    
            	    
            	}
			}
				sql = "select "+agmtconfig+" agmtconfig,b.*,coalesce(round(@i:=@i+nettotal,"+amtdesc+"),0) balance,coalesce(round(@j:=@j+nettotalin,2),0) balancein from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),"+amtdesc+") nettotal,round((a.dr+(a.cr)*-1),"+amtdesc+") nettotalin,"+casestatement+"b.branchname"+agmtselect1+" "+clientname+" from (select t.tranid,date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),"+amtdesc+"),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),"+amtdesc+"),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),"+amtdesc+"),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),"+amtdesc+"),''),CHAR(50)) credit,"
						+ "round((t.rate),"+curdesc+") rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,t.rdocno,t.rtype "+costtype+" from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des,"+costcode+" t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType,t.rdocno,t.rtype from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" "+strgrtypecond+" "+
						" union all select 0 tranid,t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,"+costcode+"t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType,t.rdocno,t.rtype "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,t.tranid,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" "+clientJoin+" order by trdate,a.tranid,TRANSNO) b,(select @i:=0) as i,(select @j:=0) as j";
			   System.out.println("AccountstatementGrid====>: "+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountsStatementExcelExport(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.trdate 'Date',b.transtype 'Type',b.transno 'Doc No',b.branchname 'Branch',b.ref_detail 'Ref No',b.description 'Description',b.currency 'Currency',b.rate 'Rate',b.dr 'Debit',b.cr 'Credit',b.debit 'Base Debit',b.credit 'Base Credit',"
						+ "coalesce(round(@i:=@i+nettotal,2),0) 'Balance' from (select a.trdate,a.transtype,a.ref_detail,"+casestatement+"b.branchname,a.description,a.currency,a.rate,a.dr,a.cr,a.debit,a.credit,round((a.debit+(a.credit)*-1),2) nettotal from ("
						+ "select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+"  group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"  order by trdate,TRANSNO) b,(select @i:=0) as i";
				
				ResultSet resultSet = stmtAccountStatement1.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				//stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  ClsAccountsStatementBean getPrint(HttpServletRequest request,int acno,String branch,String fromdate,String todate) throws SQLException {
		ClsAccountsStatementBean bean = new ClsAccountsStatementBean();
		
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtAccountStatement = conn.createStatement();
		String sql="";String mainbranch="";
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
        	mainbranch=branch;        	
		}else{
			//mainbranch="1";
		}
		if(mainbranch.trim().equalsIgnoreCase("")){
		    sql="select b.doc_no brhid,b.branchname,b.address brchaddress,'Statement of Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
	                + "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
	                + "b.cmpid=c.doc_no where b.mainbranch=1 group by brhid";
	        
		}
		else{
		    sql="select b.doc_no brhid,b.branchname,b.address brchaddress,'Statement of Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
	                + "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
	                + "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";
	        
		}
		
		ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLblbranchaddress(resultSet.getString("brchaddress"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			bean.setLblcomptel2(resultSet.getString("tel2"));
			bean.setLblcompwebsite(resultSet.getString("web"));
			bean.setLblcompemail(resultSet.getString("email"));
			if(resultSet.getString("company").equalsIgnoreCase("PAL AUTO GARAGE")&& resultSet.getInt("brhid")!=3){    
	    		   bean.setLblcompname(resultSet.getString("company")+" (Br.)");
	    		  // System.out.println("in");
	    	   }  
		}
		
		String sqls="select c.code,j.acno,coalesce(t.account,'') account,coalesce(t.description,'') description,coalesce(a.period,0) minperiod,coalesce(a.period2,0) maxperiod,coalesce(a.credit,0) creditlimit,coalesce(a.address,'') customeraddress,coalesce(a.mail1,'') customeremail,"
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax from my_jvtran j left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_acbook a on a.acno=t.doc_no where "
				+ "j.acno="+acno+" group by acno";
	//	System.out.println("curfetch==="+sqls);
		ResultSet resultSets = stmtAccountStatement.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setAccountno(resultSets.getString("account"));
			bean.setAccountname(resultSets.getString("description"));
			bean.setAccountaddress(resultSets.getString("customeraddress"));
			bean.setAccountemail(resultSets.getString("customeremail"));
			bean.setAccountmobile(resultSets.getString("customermobile"));
			bean.setAccountphone(resultSets.getString("customertel"));
			bean.setAccountfax(resultSets.getString("customerfax"));
			bean.setCreditperiodmin(resultSets.getString("minperiod"));
			bean.setCreditperiodmax(resultSets.getString("maxperiod"));
			bean.setCreditlimit(resultSets.getString("creditlimit"));
			bean.setCurcode(resultSets.getString("code"));
		}
		
		stmtAccountStatement.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }

	
}
