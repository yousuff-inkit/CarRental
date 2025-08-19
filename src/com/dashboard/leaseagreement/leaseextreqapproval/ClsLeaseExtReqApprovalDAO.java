package com.dashboard.leaseagreement.leaseextreqapproval;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaseExtReqApprovalDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	 public  JSONArray loadSubGridData(String doc) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;   
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
					
				String sqldata = "select  m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_blagmt m "
						+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+doc+"' and m.bibpid= "
					    + "(select rowno  from gl_bibp where bibdid=(select doc_no from gl_bibd where description='LA Extension Request' and process='Follow-Up')) and m.status=3 group by m.doc_no order by m.fdate desc";
				//System.out.println("detail==="+sqldata); 
				 resultSet= stmt.executeQuery (sqldata);
				 RESULTDATA=cmn.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}

	    public JSONArray getBankAccount(String id) throws SQLException
	    {
	    JSONArray bankdata=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return bankdata;
	    }
	    Connection conn=null;
	    try{
	    	conn=ClsConnection.getMyConnection();
	    	Statement stmt=conn.createStatement();
	    	String strsql="select t.doc_no,t.account,t.description from my_head t left join my_curr c on t.curid=c.doc_no "
	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	        	  + "where coalesce(toDate,curdate())>=CURDATE() and frmDate<=CURDATE() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	        	  + "where t.atype='GL' and t.m_s=0 and t.den=305";
	    	ResultSet rs=stmt.executeQuery(strsql);
	    	bankdata=cmn.convertToJSON(rs);
	    	stmt.close();
	    }
	    catch(Exception e){
	    	e.printStackTrace();
	    }
	    finally{
	    	conn.close();
	    }
	    return bankdata;
	    }

	    public JSONArray getPytProcessData(String docno,String pytstartdate,String pytadvance,String pytbalance,String pytmonthno,String id) throws SQLException{
	    	JSONArray processdata=new JSONArray();
	    	//System.out.println(docno+"::"+pytstartdate+"::"+pytadvance+"::"+pytbalance+"::"+pytmonthno+"::"+id);
	    	if(!id.equalsIgnoreCase("1")){
	    		return processdata;
	    	}
	    	Connection conn=null;
	    	try{
	    		conn=ClsConnection.getMyConnection();
	    		Statement stmt=conn.createStatement();
	    		java.sql.Date sqlstartdate=null;
	    		if(!pytstartdate.equalsIgnoreCase("")){
	    			sqlstartdate=cmn.changeStringtoSqlDate(pytstartdate);
	    		}
	    		double tempbalance=Double.parseDouble(pytbalance);
	    		double tempmonthno=Double.parseDouble(pytmonthno);
	    		double averageamt=tempbalance/tempmonthno;
	    		//System.out.println(averageamt);
	    		String strinsert="";
	    		conn.setAutoCommit(false);
	    		int errorstatus=0;
	    		String strdelete="delete from gl_leasepytcalcext where rdocno="+docno+" and status=3";
	    		int deleteval=stmt.executeUpdate(strdelete);
	    		for(int k=0;k<Integer.parseInt(pytmonthno);k++){
					/*
					 * if(i==0){ if(Double.parseDouble(pytadvance)>0.0){
					 * strinsert="insert into gl_leasepytcalcext(rdocno,date,amount)values("+docno+
					 * ",'"+sqlstartdate+"',"+pytadvance+")"; k++; }
					 * 
					 * if(!strinsert.equalsIgnoreCase("")){ int val=stmt.executeUpdate(strinsert);
					 * if(val<=0){ errorstatus=1; return processdata; } } }
					 */
	    				/*ResultSet rs=stmt.executeQuery("select date from gl_leasepytcalc where srno=(select max(srno) from gl_leasepytcalc where rdocno="+docno+")");
	    				while(rs.next()){
	    					sqlstartdate=rs.getDate("date");
	    				}*/
	    				if(averageamt>0.0){
	    					strinsert="insert into gl_leasepytcalcext(rdocno,date,amount)values("+docno+",date_add('"+sqlstartdate+"',interval "+(k)+" month),"+averageamt+")";	
	    					//System.out.println("INSERT---->"+strinsert);
							if(!strinsert.equalsIgnoreCase("")){
								int val=stmt.executeUpdate(strinsert);
								if(val<=0){
									errorstatus=1;
									return processdata;
								}	
							}
						}
	    			
	    			
	    			
	    		}
	    		if(errorstatus==0){
	    			conn.commit();
	    		}
	    		String strsql="select srno detaildocno,date,amount,bpvno,chequeno from gl_leasepytcalcext where rdocno="+docno+" and status=3";
				//System.out.println("SELECT---->"+strsql);

	    		ResultSet rs2=stmt.executeQuery(strsql);
	    		processdata=cmn.convertToJSON(rs2);
	    	}
	    	catch(Exception e){
	    		e.printStackTrace();
	    	}
	    	finally{
	    		conn.close();
	    	}
	    	return processdata;
	    }
	    
	    
	    public JSONArray getChequeData(String rdocno,String id) throws SQLException{
	    	JSONArray chequedata=new JSONArray();
	    	if(!id.equalsIgnoreCase("2") || rdocno.equalsIgnoreCase("")){
	    		return chequedata;
	    	}
	    	Connection conn=null;
	    	try{
	    		conn=ClsConnection.getMyConnection();
	    		Statement stmt=conn.createStatement();
	    		String strsql="select srno detaildocno,date,amount,bpvno,chequeno from gl_leasepytcalcext where rdocno="+rdocno+" and status=3";
	    		ResultSet rs2=stmt.executeQuery(strsql);
	    		chequedata=cmn.convertToJSON(rs2);
	    		stmt.close();
	    	}
	    	catch(Exception e){
	    		e.printStackTrace();
	    	}
	    	finally{
	    		conn.close();
	    	}
	    	return chequedata;
	    	
	    }
	    
	    
	    public  JSONArray tariffratereload(HttpSession session,String docno) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		    Enumeration<String> Enumeration = session.getAttributeNames();
		    int a=0;
		    while(Enumeration.hasMoreElements()){
		     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
		      a=1;
		     }
		    }
		    if(a==0){
		  return RESULTDATA;
		     }
	 
	        String brnch=session.getAttribute("BRANCHID").toString();
	        Connection conn=null;
			try {
					  conn = ClsConnection.getMyConnection();
					Statement stmtVeh5 = conn.createStatement ();
	            	
					String  tarifsql=("select apc,rdocno,rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,chaufchg,chaufexchg from gl_ltarif where rdocno='"+docno+"'  order by rstatus");
					//System.out.println("------------------------------"+tarifsql);
					
					ResultSet resultSet = stmtVeh5.executeQuery (tarifsql);
					RESULTDATA=cmn.convertToJSON(resultSet);
					stmtVeh5.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }



}
