package com.dashboard.humanresource.leavepayrollposting;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.common.ClsCommonHR;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsLeavePayrollPostingDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(String mainbranch, Date payrollPostedDate, double txtdrtotal, String txtremarks, String txtselectedemployees, Date upToDate, ArrayList<String> postingarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		 Connection conn  = null;
		 int docno = 0,docNo=0;
	     int trno = 0;
	     ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
	     
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				System.out.println(postingarray.size());
		        /*Inserting into my_jvma and my_jvtran*/
				docno=jvt.insert(payrollPostedDate,"JVT".concat("-25"), "LPP", "Leave Payroll posted for Emp #"+txtselectedemployees+"# as JVT on "+payrollPostedDate+" - "+txtremarks,txtdrtotal, txtdrtotal, postingarray, session, request);
				System.out.println(docno);
				trno=Integer.parseInt(request.getAttribute("tranno").toString());
			    /*Inserting my_jvma and my_jvtran Ends*/
				System.out.println("line 49---"+txtselectedemployees);
				if(docno>0){
					  String[] numbersArray = txtselectedemployees.split(",");
				        
				        // Step 2: Use a Set to store unique numbers
					  Set<String> uniqueNumbersSet = new LinkedHashSet<>();
				        for (String number : numbersArray) {
				            uniqueNumbersSet.add(number.trim());
				        }
				        // Step 3: Convert the set back to a list
				        List<String> uniqueNumbersList = new ArrayList<>(uniqueNumbersSet);
				        
				        // Step 4: Join the list elements with commas to form the final string
				       // txtselectedemployees  = String.join(",", uniqueNumbersList); - java version issue 
				        
				        StringBuilder sb = new StringBuilder();
                        for (String s : uniqueNumbersList) {
                            if (sb.length() > 0) {
                                sb.append(",");
                            }
                            sb.append(s);
                        }
                        txtselectedemployees = sb.toString();
				        
				        System.out.println("line 60---"+txtselectedemployees);
					String[] empIDs=txtselectedemployees.split(",");
					int employeeIDsLength=empIDs.length;
						
			       /*Updating hr_payrolld*/
					for (int i = 0; i < employeeIDsLength; i++) {
						String employees=empIDs[i];	
						
						if(!(employees.trim().equalsIgnoreCase(""))){
							 String sql1="";
								 sql1="update hr_payroll p,hr_payrolld d set d.leaveposted="+trno+" where (p.doc_no=d.rdocno) and d.leaveposted=0 and MONTH(p.date)=MONTH('"+upToDate+"') and YEAR(p.date)=YEAR('"+upToDate+"')  and d.empid="+empIDs[i]+"";
								 System.out.println(sql1);
								 int data= stmtBPO.executeUpdate(sql1);
								 System.out.println(data);
								 if(data<=0){
								    stmtBPO.close();
									conn.close();
									System.out.println("payroll table update not worked");
									return 0;
								}
							}
					}
					/*Updating hr_payrolld Ends*/
					
				    String sql="select coalesce(max(doc_no)+1,1) doc_no from hr_blpp";
			        ResultSet resultSet = stmtBPO.executeQuery(sql);
			  
			        while (resultSet.next()) {
					   docNo=resultSet.getInt("doc_no");
			        }
			        
			        /*Inserting hr_bmpp*/
				     String sql2="insert into hr_blpp(doc_no, date, postedtrno, postedtype, postedno, postedemp, postingDate, brhid, userid) values("+docNo+", '"+payrollPostedDate+"', '"+trno+"','JVT' , "+docno+", '"+txtselectedemployees+"', LAST_DAY(DATE_SUB('"+upToDate+"', INTERVAL 1 DAY)), '"+branch+"', '"+userid+"')";
//				     System.out.println("-------------- "+sql2);
				     int data1= stmtBPO.executeUpdate(sql2);
					 if(data1<=0){
						
						    stmtBPO.close();
							conn.close();
							return 0;
						}
					 /*Inserting hr_bmpp Ends*/
					 
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','LPP',now(),'"+userid+"','A')";
					 int datas= stmtBPO.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBPO.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBPO.close();
					conn.close();
					return docno;
				}else{
					
				}
			stmtBPO.close();
			conn.close();	
		 } catch(Exception e){
				e.printStackTrace();	
				System.out.println("Entered Catch block");
			    jvt.delete(docno, "JVT".concat("-8"), trno, session);
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}
	
	public JSONArray leavePayrollGridReloading(String branch,String uptodate,String category,String check) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	
	        	java.sql.Date sqlUpToDate=null;
	        	   
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		           
		        String sql="";
		       
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        	if(!((branch.equalsIgnoreCase("")))){
		        	  sql+=" and p.brhid="+branch+"";
		        	}
	    		}
		        
		        if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		        	sql+=" and m.pay_catid='"+category+"'";
			    }
		        
		        String sqlalwid = "(SELECT  alwid FROM hr_setallowance sa LEFT JOIN hr_payleaved pd ON pd.alwid=sa.doc_no WHERE levid=1 AND rdocno IN (m.`pay_catid`))";
		        
		       sql = "select DATE_FORMAT(p.date,'%b %Y') dates,d.daystopay,d.leave1 annualleave,if(0 in "+sqlalwid+",ROUND(((d.basic/d.daystopay)*d.leave1),0),0) basicsalary,if(1 in "+sqlalwid+",ROUND(((d.allowance1/d.daystopay)*d.leave1),0),0) hra,if(2 in "+sqlalwid+",ROUND(((d.allowance2/d.daystopay)*d.leave1),0),0) ta,if(3 in "+sqlalwid+",ROUND(((d.allowance3/d.daystopay)*d.leave1),0),0) oa,"
		    	   + "round(d.grosssalary,0) grosssalary,round(d.netsalary,0) netsalary,d.remarks,d.rdocno,"
		    	   + "d.empId employeedocno,m.codeno employeeid,m.name employeename,m.pay_catid empcatid from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on "
		    	   + "d.empid=m.doc_no left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) where p.status=3 AND d.leave1>0 and d.status=3 and d.leaveposted=0 and t.payroll_processed=1 and t.payroll_confirmed=1 and "
		    	   + "MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"')"+sql+"";
		       System.out.println("==="+sql);
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
			  conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
    }
	
	
public JSONArray leavePayrollPostingJVGridLoading(String branch,String uptodate,String category,String employees,String postDate,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	
	        	java.sql.Date sqlUpToDate=null;
	        	   
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
		        
		        ArrayList analysisrowarray= new ArrayList();
		        ArrayList<ArrayList<String>> employeeAccountsJVProcessed= new ArrayList<ArrayList<String>>();
		        
		       double amount=0.00;
		       double roundOffValues=0.00,roundOffValues1=0.00,roundOffValuesDiff=0.00;
		      
			   String sql = "";
		       
			   /* Taking Basic & Allowances*/
		       sql = "select a.alwid,sum(a.allowanceamount) allowanceamount,a.acno allowanceacno,a.atype allowancetype,a.account allowanceaccount,a.description allowanceaccountname,a.currencytype allowancecurrencytype,"
		    		+ "a.curid allowancecurrencyid,a.rate allowancerate,a.costtype,a.costcode from (select ac.alwid,ac.costtype,ac.costcode,CASE WHEN ac.alwid=0 THEN ROUND(((d.basic/d.daystopay)*d.leave1),0) WHEN ac.alwid=1 THEN ROUND(((d.allowance1/d.daystopay)*d.leave1),0) WHEN ac.alwid=2 THEN ROUND(((d.allowance2/d.daystopay)*d.leave1),0) WHEN ac.alwid=3 THEN ROUND(((d.allowance3/d.daystopay)*d.leave1),0) ELSE ROUND(0.00,0) END AS allowanceamount,ac.acno,"
		    		+ "h.atype,h.account,h.description,h.curid,h.rate,c.type currencytype,d.empId from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on d.empid=m.doc_no left join "
		       		+ "hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join (select max(doc_no) docno,catid from hr_paycode where revdate<='"+sqlUpToDate+"' group by catid) a on a.catid=m.pay_catid left join hr_paycodeac ac "
		       		+ "on a.docno=ac.rdocno left join my_head h on ac.acno=h.doc_no left join my_curr c on h.curid=c.doc_no where p.status=3 and d.status=3 and t.payroll_processed=1 and d.leaveposted=0 and t.payroll_confirmed=1 "
		       		+ "and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"') and d.empid in ("+employees+") AND ac.alwid IN (SELECT  alwid FROM hr_setallowance sa LEFT JOIN hr_payleaved pd ON pd.alwid=sa.doc_no WHERE levid=1 AND rdocno IN (SELECT pay_catid FROM hr_empm WHERE doc_no IN ("+employees+") GROUP BY pay_catid) GROUP BY alwid) order by m.doc_no,ac.alwid,m.pay_catid ) as a group by a.acno,a.alwid having allowanceamount!=0";
		       System.out.println("===== "+sql);
		        ResultSet resultSet = stmtBPO.executeQuery(sql);
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet.getString("allowanceacno"));
					temp.add(resultSet.getString("allowancetype"));
					temp.add(resultSet.getString("allowanceaccount"));
					temp.add(resultSet.getString("allowanceaccountname"));
					temp.add("0.00");
					temp.add(resultSet.getString("allowanceamount"));
					temp.add(String.valueOf(resultSet.getDouble("allowanceamount")*resultSet.getDouble("allowancerate")));
					temp.add("Leave salary expenses paid through payroll "+postDate);
					temp.add(resultSet.getString("allowancecurrencyid"));temp.add(resultSet.getString("allowancecurrencytype"));
					temp.add(resultSet.getString("allowancerate"));
					temp.add("-1");
					temp.add(resultSet.getString("costtype"));
					temp.add(resultSet.getString("costcode"));
					
					roundOffValues+=(resultSet.getDouble("allowanceamount"));
					amount += (resultSet.getDouble("allowanceamount")*resultSet.getDouble("allowancerate"));
					employeeAccountsJVProcessed.add(temp);
				}
				/* Taking Basic & Allowances Ends*/
				
		        
		        /* Inserting a Rounding Value Array */
			        String sqlRoundOff = "select m.codeno,m.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type currencytype,m.costtype,m.costcode from my_account m left join my_head h on m.acno=h.doc_no "
					    	 + "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join ( select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
			        		 + "coalesce(toDate,curdate())>='"+sqlUpToDate+"' and frmDate<='"+sqlUpToDate+"' group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.codeno='HREXPENSE2LEAVESALARYEXPENSEACCOUNT'";
			        System.out.println("sqlRoundOff===== "+sqlRoundOff);
			        ResultSet resultSetRoundOff = stmtBPO.executeQuery(sqlRoundOff);
	
				    while(resultSetRoundOff.next()){
				    	ArrayList<String> temp7=new ArrayList<String>();
					    
					    temp7.add(resultSetRoundOff.getString("acno"));
					    temp7.add(resultSetRoundOff.getString("atype"));
					    temp7.add(resultSetRoundOff.getString("account"));
					    temp7.add(resultSetRoundOff.getString("description"));
					    temp7.add(String.valueOf(roundOffValues));
						temp7.add("0.00");
						temp7.add(String.valueOf(amount));
						temp7.add("Leave salary expenses paid through payroll "+postDate);
						temp7.add(resultSetRoundOff.getString("curid"));
						temp7.add(resultSetRoundOff.getString("currencytype"));
						temp7.add(resultSetRoundOff.getString("rate"));
						temp7.add("1");
						temp7.add(resultSetRoundOff.getString("costtype"));
						temp7.add(resultSetRoundOff.getString("costcode"));
						
						employeeAccountsJVProcessed.add(temp7);
				    }
		
		        /* Inserting a Rounding Value Array Ends*/
		        
				analysisrowarray.addAll(employeeAccountsJVProcessed);
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
			  conn.close();   
	     } catch(Exception e) {
		      e.printStackTrace();
		      conn.close();
	     } finally {
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray convertRowAnalysisArrayToJSON(ArrayList rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			String rows=rowsAnalysisList.get(i).toString();
			rows=rows.replace("[", "").replace("]", "").trim();
			String[] rowsValue=rows.split(",");
			
			obj.put("docno",rowsValue[0]);
			obj.put("type",rowsValue[1]);
			obj.put("account",rowsValue[2]);
			obj.put("accountname",rowsValue[3]);
			obj.put("debit",rowsValue[4]);
			obj.put("credit",rowsValue[5]);
			obj.put("baseamount",rowsValue[6]);
			obj.put("description",rowsValue[7]);
			obj.put("currencyid",rowsValue[8]);
			obj.put("currencytype",rowsValue[9]);
			obj.put("rate",rowsValue[10]);
			obj.put("id",rowsValue[11]);
			obj.put("costtype",rowsValue[12]);
			obj.put("costcode",rowsValue[13]);
			
			jsonArray.add(obj);

		}
		return jsonArray;
		}
}
