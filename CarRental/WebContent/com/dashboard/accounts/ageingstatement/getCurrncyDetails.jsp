<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>


<%

String upToDate = request.getParameter("uptoDate")==null?"0":request.getParameter("uptoDate").trim();
String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
String branch = request.getParameter("branch")==null?"0":request.getParameter("branch").trim();

System.out.println("Date :"+upToDate+"Acc no :"+acno+"Type :"+atype+"Branch :"+branch);
	Connection conn = null;
	ClsCommon ClsCommon=new ClsCommon();
	java.sql.Date sqlUpToDate = null;
	if(!(upToDate.equalsIgnoreCase("undefined")) && !(upToDate.equalsIgnoreCase("")) && !(upToDate.equalsIgnoreCase("0"))){
		sqlUpToDate = ClsCommon.changeStringtoSqlDate(upToDate);
	 }
	try {

		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		String strSql1 = "SELECT CODE,SUM(advance) advance,SUM(balance) balance,ROUND(COALESCE(SUM(balance),0)-COALESCE(SUM(advance),0),2) total FROM(SELECT ag.code,ag.accno,NAME 'account_name',CONVERT(IF(SUM(t7+u6)<0,ROUND((SUM(t7+u6)*-1),2),0),CHAR(50)) 'advance',CONVERT(IF(SUM(t7+u6)>0,ROUND((SUM(t7+u6)),2),''),CHAR(50)) 'balance',ag.acno 'account',ag.brhid 'branch_id' FROM (SELECT d.code,d.accno,d.name,d.acno,d.brhid,d.doc_no,CONVERT(IF(d.bal<0,ROUND((d.bal),2),''),CHAR(50)) U6,IF(d.bal>0,d.bal,0) t7 FROM  (SELECT c.code,j.acno,j.brhid,h.description NAME,h.account accno,SUM(dramount) - COALESCE(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(DAY,CAST(j.date AS DATETIME),CAST('"+sqlUpToDate+"' AS DATETIME)) duedys FROM my_jvtran j INNER JOIN my_head h ON j.acno=h.doc_no LEFT JOIN my_curr c ON c.doc_no=h.curid LEFT JOIN (SELECT ap_trid,o.tranid,SUM(COALESCE(amount,0)) amount FROM my_outd o INNER JOIN my_jvtran j ON j.tranid=o.tranid WHERE j.date<='"+sqlUpToDate+"' GROUP BY ap_trid ) o ON j.tranid=o.ap_trid WHERE j.status=3 AND h.atype='"+atype+"' AND j.date<='"+sqlUpToDate+"'  AND j.id > 0 GROUP BY j.tranid HAVING bal<>0 UNION ALL SELECT c.code,j.acno,j.brhid,h.description NAME,h.account accno,SUM(dramount)- COALESCE(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(DAY,CAST(j.date AS DATETIME),CAST('"+sqlUpToDate+"' AS DATETIME)) duedys FROM my_jvtran j INNER JOIN my_head h ON j.acno=h.doc_no LEFT JOIN my_curr c ON c.doc_no=h.curid LEFT JOIN (SELECT ap_trid,o.tranid,SUM(COALESCE(amount,0)) amount FROM my_outd o INNER JOIN my_jvtran j ON j.tranid=o.ap_trid WHERE j.date<='"+sqlUpToDate+"'GROUP BY tranid) o ON j.tranid=o.tranid WHERE j.status=3 AND h.atype='"+atype+"' AND j.date<='"+sqlUpToDate+"' AND j.id < 0 GROUP BY j.tranid HAVING bal<>0) d) ag GROUP BY acno )a WHERE 1=1 GROUP BY CODE";
		System.out.println("SQL"+strSql1);
		ResultSet rs1 = stmt.executeQuery(strSql1);
		System.out.println("SQL"+strSql1);
		int AED = 0;
		int CAD=0;
		int CHF=0;
		int EUR=0;
		int USD=0;
		int method=0;
		while (rs1.next()) {
			if(rs1.getString("CODE").equals("AED")){
				AED = rs1.getInt("total");

			}else if(rs1.getString("CODE").equals("CAD")){
				CAD = rs1.getInt("total");
			}else if(rs1.getString("CODE").equals("CHF")){
				CHF = rs1.getInt("total");
			}else if(rs1.getString("CODE").equals("EUR")){
				EUR = rs1.getInt("total");
			}else if(rs1.getString("CODE").equals("USD")){
				USD = rs1.getInt("total");
			}
			
			
		}
		String configSql="SELECT method FROM gl_config WHERE field_nme ='acAgngStamtCurr'";
		ResultSet confrs = stmt.executeQuery(configSql);
		if(confrs.next()){
			method=confrs.getInt("method");
		}
		response.getWriter().print(AED+"####"+CAD+"####"+CHF+"####"+EUR+"####"+USD+"####"+method);
		stmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
%>