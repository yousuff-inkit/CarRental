<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.Connection"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="com.common.*"%>

<%
Connection conn = null;


int errorstatus=0;
int val=0;
	try {
		String doc_no = request.getParameter("doc_no").toString();
		String atype = request.getParameter("atype").toString();
		int trno = 0;
		ArrayList<String> arAcno = new ArrayList<String>();
		ArrayList<String> apAcno = new ArrayList<String>();
		
		ClsApplyDelete appDel = new ClsApplyDelete();
		ClsConnection connection = new ClsConnection();
		conn = connection.getMyConnection();
		
		Statement stmt = conn.createStatement();
		Statement stmtupd = conn.createStatement();
		
		if(atype.equalsIgnoreCase("AR")){
			arAcno.add(doc_no);
		}else if (atype.equalsIgnoreCase("AP")){
			apAcno.add(doc_no);
		}
		//System.out.println("AR =" + arAcno);
		//System.out.println("AP =" + apAcno);
		String sqlupdate = "";
		
		//AR acno updates
		
		for (int i = 0; i <= arAcno.size() - 1; i++) {
			//System.out.println("=== trno 1 ==== " + arAcno.get(i));
			ArrayList<Integer> arrTrno = new ArrayList<Integer>();
			String sqlselect = "select * from my_jvtran where status=7 and acno="
					+ arAcno.get(i);
			ResultSet rs1 = stmt.executeQuery(sqlselect);
			while (rs1.next()) {
				arrTrno.add(rs1.getInt("tr_no"));
			}

			for (int ii = 0; ii <= arrTrno.size() - 1; ii++) {
				//System.out.println("=== trno ==== " + arrTrno.get(ii));
				appDel.getFinanceApplyDelete(conn, arrTrno.get(ii));
			}

			// 2nd jvtran is missing
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and J1.status=3 and j1.acno="
					+ arAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ " and j.dramount<0 and j.out_amount!=0   and j1.tranid is null ";
			 //System.out.println("sqlupdate1 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid   and J1.status=3 and j1.acno="
					+ arAcno.get(i)
					+ "  where J.status=3  and j.acno="
					+ arAcno.get(i)
					+ "  and j.dramount>0 and j.out_amount!=0   and j1.tranid is null ";
			 //System.out.println("sqlupdate2 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			// 2nd jvtran and 1st jvtran both are same
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid and J1.status=3   and j1.acno="
					+ arAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ " and j.dramount<0 and j.out_amount!=0   and j1.tranid=j.tranid ";
			 //System.out.println("sqlupdate3 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid and J1.status=3  and j1.acno="
					+ arAcno.get(i)
					+ "  where J.status=3  and j.acno="
					+ arAcno.get(i)
					+ "  and j.dramount>0 and j.out_amount!=0   and j1.tranid=j.tranid ";
			 //System.out.println("sqlupdate4 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			//outd amoutn is -ve 
			 sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ " and j.dramount<0 and j.out_amount!=0   and d.amount<0 ";
			 //System.out.println("sqlupdate5 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ "  and j.dramount>0 and j.out_amount!=0   and d.amount<0 ";
			 //System.out.println("sqlupdate6 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate); 
			if(val>0){
				errorstatus=1;
			}
			
			/* sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ " and j.dramount<0 and j.out_amount!=0   and d.amount>0 ";
			 //System.out.println("sqlupdate5 =" + sqlupdate);
			stmtupd.execute(sqlupdate);
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="
					+ arAcno.get(i)
					+ "  and j.dramount>0 and j.out_amount!=0   and d.amount>0 ";
			 //System.out.println("sqlupdate6 =" + sqlupdate);
			stmtupd.execute(sqlupdate); */
			
			// jvtran outamount 0 if not reference in outd
			sqlupdate = "update my_jvtran j left join  my_outd d on j.tranid=d.tranid set out_amount=0 where status=3 and acno="
					+ arAcno.get(i)
					+ "  and dramount<0 and out_amount!=0  and d.tranid is null ";
			//System.out.println("sqlupdate7 =" + sqlupdate);
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
			sqlupdate = "update my_jvtran j left join  my_outd d on j.tranid=d.ap_trid set out_amount=0 where status=3 and acno="
					+ arAcno.get(i)
					+ "  and dramount>0 and out_amount!=0  and d.tranid is null ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("sqlupdate8 =" + sqlupdate);
			
			if(val>0){
				errorstatus=1;
			}
			 
			
			sqlupdate = "update my_jvtran j inner join (select d.tranid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.tranid  where status=3 and acno="
					+ arAcno.get(i)
					+ " and dramount<0 group by d.tranid) o on j.tranid=o.tranid set j.out_amount=o.amt*j.id where status=3 and acno="
					+ arAcno.get(i)
					+ " and dramount<0 and j.out_amount!=o.amt*j.id";
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
			//System.out.println("sqlupdate9 =" + sqlupdate);
			sqlupdate = "update my_jvtran j inner join (select d.ap_trid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.ap_trid  where status=3 and acno="
					+ arAcno.get(i)
					+ " and dramount>0 group by d.ap_trid) o on j.tranid=o.ap_trid set j.out_amount=o.amt*j.id where status=3 and acno="
					+ arAcno.get(i)
					+ " and dramount>0 and j.out_amount!=o.amt*j.id";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("sqlupdate10 =" + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
		}
		
		
		//AP acno updates 
		
		for (int i = 0; i <= apAcno.size() - 1; i++) {
			//System.out.println("=== trno 2==== " + apAcno.get(i));

			ArrayList<Integer> arrTrno = new ArrayList<Integer>();
			String sqlselect = "select * from my_jvtran where status=7 and acno="
					+ apAcno.get(i);
			ResultSet rs1 = stmt.executeQuery(sqlselect);
			while (rs1.next()) {
				arrTrno.add(rs1.getInt("tr_no"));
			}

			for (int ii = 0; ii <= arrTrno.size() - 1; ii++) {
				//System.out.println("=== trno ==== " + arrTrno.get(ii));
				appDel.getFinanceApplyDelete(conn, arrTrno.get(ii));
			}

			// 2nd jvtran is missing
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="
					+ apAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ " and j.dramount>0 and j.out_amount!=0   and j1.tranid is null ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 1==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="
					+ apAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ "  and j.dramount<0 and j.out_amount!=0   and j1.tranid is null ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 2==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
			// 2nd jvtran and 1st jvtran both are same
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid  and j1.acno="
					+ apAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ " and j.dramount>0 and j.out_amount!=0   and j1.tranid=j.tranid ";
			val=stmtupd.executeUpdate(sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid  and j1.acno="
					+ apAcno.get(i)
					+ "  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ "  and j.dramount<0 and j.out_amount!=0   and j1.tranid=j.tranid ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 3==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			
			//outd amoutn is -ve 
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ " and j.dramount>0 and j.out_amount!=0   and d.amount<0 ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 4==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ "  and j.dramount<0 and j.out_amount!=0   and d.amount<0 ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 5==== " + sqlupdate); 
			if(val>0){
				errorstatus=1;
			}
			
			/* sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid  where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ " and j.dramount>0 and j.out_amount!=0   and d.amount>0 ";
			stmtupd.execute(sqlupdate);
			//System.out.println("=== ap 4==== " + sqlupdate);
			
			sqlupdate = "delete d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where J.status=3 and j.acno="
					+ apAcno.get(i)
					+ "  and j.dramount<0 and j.out_amount!=0   and d.amount>0 ";
			stmtupd.execute(sqlupdate);
			//System.out.println("=== ap 5==== " + sqlupdate);
			
 */			
			
			
			// jvtran outamount 0 if not reference in outd
			sqlupdate = "update my_jvtran j left join  my_outd d on j.tranid=d.tranid set out_amount=0 where status=3 and acno="
					+ apAcno.get(i)
					+ "  and dramount>0 and out_amount!=0  and d.tranid is null ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 6==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "update my_jvtran j left join  my_outd d on j.tranid=d.ap_trid set out_amount=0 where status=3 and acno="
					+ apAcno.get(i)
					+ "  and dramount<0 and out_amount!=0  and d.tranid is null ";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap 7==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			

			sqlupdate = "update my_jvtran j inner join (select d.tranid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.tranid  where status=3 and acno="
					+ apAcno.get(i)
					+ " and dramount>0 group by d.tranid) o on j.tranid=o.tranid set j.out_amount=o.amt*j.id where status=3 and acno="
					+ apAcno.get(i)
					+ " and dramount>0 and j.out_amount!=o.amt*j.id";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap up 1==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			
			sqlupdate = "update my_jvtran j inner join (select d.ap_trid,sum(d.amount) amt from my_jvtran j inner join my_outd d on j.tranid=d.ap_trid  where status=3 and acno="
					+ apAcno.get(i)
					+ " and dramount<0 group by d.ap_trid) o on j.tranid=o.ap_trid set j.out_amount=o.amt*j.id where status=3 and acno="
					+ apAcno.get(i)
					+ " and dramount<0 and j.out_amount!=o.amt*j.id";
			val=stmtupd.executeUpdate(sqlupdate);
			//System.out.println("=== ap up 2==== " + sqlupdate);
			if(val>0){
				errorstatus=1;
			}
			

		}
		//System.out.println("errorstatus_______"+errorstatus);
	}catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().print(errorstatus);
	

	%>