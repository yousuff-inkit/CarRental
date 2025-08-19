package com.humanresource.transactions.employeeadvances;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsEmployeeAdvancesDAO {
	ClsConnection clsConnection=new ClsConnection();

	ClsCommon clsCommon=new ClsCommon();

	ClsEmployeeAdvancesBean deductionScheduleBean = new ClsEmployeeAdvancesBean();
	
	public int insert(String formdetailcode, Date deductionsScheduleDate,String txtemployeerefno, int txtemployeedocno, double txtamount,int txtinstnos, Date startingDate, 
			double txtinstamt,String txtdescription, ArrayList<String> deductionschedulearray,ClsEmployeeAdvancesAction employeeAction,HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		int total = 0;
		try{
			conn=clsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			java.util.Date currentDate = new java.util.Date();
			java.sql.Date sqldatecurrent=null;
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
			String formattedDate = dateFormat.format(currentDate);
			sqldatecurrent= clsCommon.changeStringtoSqlDate(formattedDate);
			
			Double erate = 0.0;
			String eacno = "";
			String ecurid = "";
			Double crate = 0.0;
			String cacno = "";
			String ccurid = "";
			int trno=0;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtDSC = conn.prepareCall("{CALL HR_employeeadvancesDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtDSC.registerOutParameter(12, java.sql.Types.INTEGER);
			
			stmtDSC.setDate(1,deductionsScheduleDate);
			stmtDSC.setInt(2,txtemployeedocno);
			stmtDSC.setString(3,txtemployeerefno);
			stmtDSC.setString(4,txtdescription);
			stmtDSC.setDouble(5,txtamount);
			stmtDSC.setInt(6,txtinstnos);
			stmtDSC.setDate(7,startingDate);
			stmtDSC.setString(8,formdetailcode);
			stmtDSC.setString(9,company);
			stmtDSC.setString(10,branch);
			stmtDSC.setString(11,userid);
			stmtDSC.setString(13,mode);
			stmtDSC.setString(14,employeeAction.getTxtfromdocno()+"");
			int datas=stmtDSC.executeUpdate();
			if(datas<=0){
				stmtDSC.close();
				conn.close();
				return 0;
			}
			int docno=stmtDSC.getInt("docNo");

			String getempacdetails = "SELECT doc_no,rate,curid FROM my_head WHERE doc_no=(SELECT acno FROM hr_empm WHERE doc_no="+txtemployeedocno+" AND dtype='EMP')";
			ResultSet rss = stmtDSC.executeQuery(getempacdetails);
			if(rss.next()) {
				eacno = rss.getString("doc_no");
				ecurid = rss.getString("curid");
				erate = rss.getDouble("rate");
			}
			String getcacdetails = "SELECT doc_no,rate,curid FROM my_head WHERE doc_no="+employeeAction.getTxtfromdocno();
			ResultSet rsse = stmtDSC.executeQuery(getcacdetails);
			if(rsse.next()) {
				cacno = rsse.getString("doc_no");
				ccurid = rsse.getString("curid");
				crate = rsse.getDouble("rate");
			}
			
			ArrayList<String> parsedArray = new ArrayList<String>();
			
			 parsedArray.add(eacno+"::"+"Employee Advances of date - "+deductionsScheduleDate+"::"+ecurid+"::"+erate+"::"+txtamount*1+"::"+txtamount*1*erate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"JVT");
	    	 parsedArray.add(cacno+"::"+"Employee Advances of date - "+deductionsScheduleDate+"::"+ccurid+"::"+crate+"::"+txtamount*-1+"::"+txtamount*-1*crate+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"JVT");

			 ClsJournalVouchersDAO clsJournalVouchersDAO= new ClsJournalVouchersDAO();
		     int res = clsJournalVouchersDAO.insert(sqldatecurrent,"JVT".concat("-25"), "EPA", "Employee Advances posted for date - "+deductionsScheduleDate+" as JVT on "+sqldatecurrent, txtamount , txtamount , parsedArray, session, request);
		     trno=Integer.parseInt(request.getAttribute("tranno").toString());
		     if(res>0){
				 String update = "update hr_eadvm set tr_no="+trno+" where doc_no="+docno;
				 stmtDSC.executeUpdate(update);
			 }
			
			
			deductionScheduleBean.setTxtdeductionscheduledocno(docno);
			if (docno > 0) {
				
				/*Insertion to hr_addschd*/
				int insertData=insertion(conn, docno, deductionschedulearray, session,mode);
				if(insertData<=0){
					stmtDSC.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_addschd Ends*/
			}
				
				conn.commit();
				stmtDSC.close();
				conn.close();
				return docno;
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	}
	
	public boolean edit(int txtdeductionscheduledocno,String formdetailcode, Date deductionsScheduleDate,String txtemployeerefno, int txtemployeedocno, 
			double txtamount, int txtinstnos, Date startingDate, double txtinstamt,String txtdescription, ArrayList<String> deductionschedulearray, ClsEmployeeAdvancesAction employeeAdvancesAction,
			HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		Connection conn = null;
		int applydelete=0;
		int total = 0;
		 try{
			    conn=clsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				java.util.Date currentDate = new java.util.Date();
				java.sql.Date sqldatecurrent=null;
				SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
				String formattedDate = dateFormat.format(currentDate);
				sqldatecurrent= clsCommon.changeStringtoSqlDate(formattedDate);
				
				Double erate = 0.0;
				String eacno = "";
				String ecurid = "";
				Double crate = 0.0;
				String cacno = "";
				String ccurid = "";
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				int trno = 0;
				int jvdocno = 0;
					 
					 
					 CallableStatement stmtDSC = conn.prepareCall("{CALL HR_employeeadvancesDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						stmtDSC.setInt(12, txtdeductionscheduledocno);						
						stmtDSC.setDate(1,deductionsScheduleDate);
						stmtDSC.setInt(2,txtemployeedocno);
						stmtDSC.setString(3,txtemployeerefno);
						stmtDSC.setString(4,txtdescription);
						stmtDSC.setDouble(5,txtamount);
						stmtDSC.setInt(6,txtinstnos);
						stmtDSC.setDate(7,startingDate);
						stmtDSC.setString(8,formdetailcode);
						stmtDSC.setString(9,company);
						stmtDSC.setString(10,branch);
						stmtDSC.setString(11,userid);
						stmtDSC.setString(13,mode);
						stmtDSC.setString(14,employeeAdvancesAction.getTxtfromdocno()+"");
						System.out.println(stmtDSC);
						int datas=stmtDSC.executeUpdate();
						if(datas<=0){
							stmtDSC.close();
							conn.close();
							return false;
						}
						
						String getTrno="SELECT m.tr_no,jv.doc_no FROM hr_eadvm m LEFT JOIN my_jvma jv ON jv.tr_no=m.tr_no WHERE m.doc_no="+txtdeductionscheduledocno;
						System.out.println(getTrno);
						ResultSet rsgt = stmtDSC.executeQuery(getTrno);
						if(rsgt.next()) {
							trno=rsgt.getInt("tr_no");
							jvdocno=rsgt.getInt("doc_no");
						}
			    String getempacdetails = "SELECT doc_no,rate,curid FROM my_head WHERE doc_no=(SELECT acno FROM hr_empm WHERE doc_no="+txtemployeedocno+" AND dtype='EMP')";
				ResultSet rss = stmtDSC.executeQuery(getempacdetails);
				if(rss.next()) {
					eacno = rss.getString("doc_no");
					ecurid = rss.getString("curid");
					erate = rss.getDouble("rate");
				}
				String getcacdetails = "SELECT doc_no,rate,curid FROM my_head WHERE doc_no="+employeeAdvancesAction.getTxtfromdocno();
				ResultSet rsse = stmtDSC.executeQuery(getcacdetails);
				if(rsse.next()) {
					cacno = rsse.getString("doc_no");
					ccurid = rsse.getString("curid");
					crate = rsse.getDouble("rate");
				}
				
				ArrayList<String> parsedArray = new ArrayList<String>();
				
				 parsedArray.add(eacno+"::"+"Employee Advances of date - "+deductionsScheduleDate+"::"+ecurid+"::"+erate+"::"+txtamount*1+"::"+txtamount*1*erate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"JVT");
		    	 parsedArray.add(cacno+"::"+"Employee Advances of date - "+deductionsScheduleDate+"::"+ccurid+"::"+crate+"::"+txtamount*-1+"::"+txtamount*-1*crate+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"JVT");
		    	 
		    	 
		    	 
				 ClsJournalVouchersDAO clsJournalVouchersDAO= new ClsJournalVouchersDAO();
				 boolean res = clsJournalVouchersDAO.edit(jvdocno, "JVT", deductionsScheduleDate, "EPA", "Employee Advances posted for date - "+deductionsScheduleDate+" as JVT on "+sqldatecurrent, trno, txtamount, txtamount, parsedArray, session);
			   //  int res = clsJournalVouchersDAO.insert(sqldatecurrent,"JVT".concat("-25"), "EPA", "Employee Advances posted for date - "+deductionsScheduleDate+" as JVT on "+sqldatecurrent,txtamount,txtamount, parsedArray, session, request);
				// trno=Integer.parseInt(request.getAttribute("tranno").toString());
			     
			     String sql2=("DELETE FROM hr_eadvd WHERE rdocno="+txtdeductionscheduledocno);
				 int data2 = stmtDSC.executeUpdate(sql2);
			    
			    int docno=txtdeductionscheduledocno;
			    deductionScheduleBean.setTxtdeductionscheduledocno(docno);
				if (docno > 0) {
				
					/*Insertion to hr_addschd*/
					int insertData=insertion(conn, docno, deductionschedulearray, session,mode);
					if(insertData<=0){
						stmtDSC.close();
						conn.close();
						return false;
					}
					/*Insertion to hr_addschd Ends*/
					
					/*Inserting into datalog*/
					String sql1=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtdeductionscheduledocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
					int data1 = stmtDSC.executeUpdate(sql1);
					/*Inserting into datalog Ends*/
					
					JSONObject jsobj = new JSONObject();
					jsobj = clsCommon.JVTotalCheck(conn, trno);
					 String validmsg = jsobj.getString("validmsg");      
					 total = jsobj.getInt("value");
					 if(total == 0){
						conn.commit();
						stmtDSC.close();
						conn.close();
						return true;
					 }else{
						 System.out.println("*=*=*=*= NOT SAVED *=*=*=*="+validmsg);    
						 stmtDSC.close();
					    return false;
				    }
				}
				stmtDSC.close();
			    conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
		return false;
	}
	
	public boolean delete(int txtdeductionscheduledocno, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null; 
		
		try{
				conn=clsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtDSC = conn.createStatement();
				
				int applydelete = 0;
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int trno = 0;
				String gettrno = "select tr_no from hr_eadvm where doc_no="+txtdeductionscheduledocno;
				ResultSet rse = stmtDSC.executeQuery(gettrno);
				if(rse.next()) {
					trno = rse.getInt("tr_no");
				}
				
				 ClsApplyDelete applyDelete = new ClsApplyDelete();
					applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
					if(applydelete<0){
						System.out.println("*** ERROR IN APPLY DELETE ***");
						stmtDSC.close();
						conn.close();
						return false;
					}
				
				 /*Status change in my_jvtran*/
				 String sql7=("update my_jvtran set STATUS=7 where doc_no="+txtdeductionscheduledocno+" and TR_NO="+trno+"");
				 int resultSet4 = stmtDSC.executeUpdate(sql7);
				/*Status change in my_jvtran Ends*/

				
				 /*Status change in my_jvtran*/
				 String sql=("update hr_eadvm set STATUS=7 where doc_no="+txtdeductionscheduledocno+"");
				 int data = stmtDSC.executeUpdate(sql);
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtdeductionscheduledocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtDSC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				 int docno=txtdeductionscheduledocno;
				 deductionScheduleBean.setTxtdeductionscheduledocno(docno);
				 
				if (docno > 0) {
					conn.commit();
					stmtDSC.close();
				    conn.close();
					return true;
				}	
				stmtDSC.close();
			    conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
		return false;
	}
	
	public JSONArray deductionScheduleGridReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = clsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				String sqlnew=("select rowno sr_no,date,amount,posted,postedtrno,srno rowno from hr_eadvd where rdocno="+docNo+"");
				System.out.println(sqlnew);
				ResultSet resultSet = stmtDSC.executeQuery (sqlnew);
                
				RESULTDATA=clsCommon.convertToJSON(resultSet);
				
				stmtDSC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray deductionScheduleGrid(String date,String txtamount, String txtinstnos,String txtinstamt) throws SQLException {
        JSONArray jsonArray = new JSONArray();
        
        Connection conn = null; 
        
		try {
				conn = clsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		        	xdate = clsCommon.changeStringtoSqlDate(date);
		        	fdate = clsCommon.changeStringtoSqlDate(date);
		        }
		        
		        String xsql="";
		        String cmbfrequency="2";
		        String txtdueafter="1";
		        
				xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				do							
				{	
					++xsrno;
					if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;
					
					int sr_no= xsrno;							
					int actualNoOfInst=xsrno;
					
					amount=((xtotal+Double.parseDouble(txtinstamt))>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):Double.parseDouble(txtinstamt));
					xtotal+=amount;
					
					//setting values to grid
					JSONObject obj = new JSONObject();
					obj.put("sr_no",String.valueOf(sr_no));

					if(!(xdate==null)){
						obj.put("date",xdate.toString());
					}
					obj.put("amount",String.valueOf(amount));
					obj.put("posted",0);
					obj.put("postedtrno",0);
					
					jsonArray.add(obj);
					
					if(xtotal>=Double.parseDouble(txtamount)) break;
					//if (Integer.parseInt(txtinstnos)>0 && xsrno==Integer.parseInt(txtinstnos) && MyLib.getSum(txtamount, xtotal*-1, 2)>0)
					//{
						//preBrowse.cache.setData("Amount",MyLib.getSum(preBrowse.cache.getDouble("Amount"),
							//	MyLib.getSum(txtamount, xtotal*-1, 2),2));
								
                    //	xtotal+=MyLib.getSum(txtamount, xtotal*-1, 2);
					//}
					
					ResultSet rs = stmtDSC.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+fdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+fdate+"')))) fdate ");
					if(rs.next()) xdate=rs.getDate("fdate");
					
					rs.close();
			}while(true);
				
			
				stmtDSC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsonArray;
    }
	
	public JSONArray employeeDetailsSearch(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String dob,String employeebranchchk,String brhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
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
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDateofBirth=null;
       
        dob.trim();
        if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
        {
        	sqlDateofBirth = clsCommon.changeStringtoSqlDate(dob);
        }
        
        String sqltest="";
        
        if(!(empname.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.name like '%"+empname+"%'";
        }
        if(!(mob.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) like '%"+mob+"%'";
        }
        if(!(employeedesignation.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.desc_id like '%"+employeedesignation+"%'";
        }
        if(!(employeedepartment.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.dept_id like '%"+employeedepartment+"%'";
        }
        if(!(empid.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.emp_id like '%"+empid+"%'";
        }
        if(!(sqlDateofBirth==null)){
        	sqltest=sqltest+" and m.dob='"+sqlDateofBirth+"'";
        } 
           
     try {
    	   conn = clsConnection.getMyConnection();
    	   Statement stmtEMP = conn.createStatement();
    	   
    	   if(employeebranchchk.equalsIgnoreCase("1")){    
           	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0"))){  
           		sqltest=sqltest+" and m.brhid='"+brhid+"'";    
           	}
           }
    	   
	       ResultSet resultSet = stmtEMP.executeQuery("select m.name,if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) mob,dg.desc1 designation,dp.desc1 department,"  
	       	  + "m.dob,DATE_FORMAT(m.salary_paid,'%d.%m.%Y') hidsalary,m.codeno emp_id,m.doc_no,convert(concat(' Employee : ',coalesce(m.emp_id),' - ',coalesce(m.name), ' * ','Mobile  : ',coalesce(if(m.prmob is null,m.pmmob,"
	    	  + "if(m.prmob=' ',m.pmmob,m.prmob))),' * ','Designation : ' ,coalesce(dg.desc1),' * ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_empm m "
	       	  + "left join hr_setdesig dg on m.desc_id=dg.doc_no left join hr_setdept dp on m.dept_id=dp.doc_no where m.status=3 and m.dtype='EMP'"+sqltest+"  order by m.name"); 
	       
	       RESULTDATA=clsCommon.convertToJSON(resultSet);
	       stmtEMP.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	public JSONArray dscMainSearch(HttpSession session,String empname,String docNo,String date,String amount,String employeebranchchk,String brhid,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
           if(!id.equals("1")){
         return RESULTDATA;
            }
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        sqlDate = clsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
        }
        if(!(empname.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and e.name like '%"+empname+"%'";
        }
        if(!(amount.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.amount like '%"+amount+"%'";
        }
        if(!(sqlDate==null)){
        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
	    } 
        if(employeebranchchk.equalsIgnoreCase("1")){    
        	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0")) && !(brhid.equalsIgnoreCase("a"))){  
        		sqltest=sqltest+" and m.brhid='"+brhid+"'";    
        	}
        }    
     try {
	       conn = clsConnection.getMyConnection();
	       Statement stmtDSC = conn.createStatement();
	       
	       ResultSet resultSet = stmtDSC.executeQuery("select m.date,m.doc_no,m.amount,e.name from hr_eadvm m left join hr_empm e on m.empid=e.doc_no where m.brhid="+branch+" and m.dtype='EPA' "  
	       	+ "and m.status<>7" +sqltest);
	       System.out.println("select m.date,m.doc_no,m.amount,e.name from hr_eadvm m left join hr_empm e on m.empid=e.doc_no where m.brhid="+branch+" and m.dtype='EPA' "  
	       	+ "and m.status<>7" +sqltest);
	       RESULTDATA=clsCommon.convertToJSON(resultSet);
	       
	       stmtDSC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsEmployeeAdvancesBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		 ClsEmployeeAdvancesBean deductionScheduleBean = new ClsEmployeeAdvancesBean();
			
			Connection conn = null;
			
			try {
				conn = clsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				String branch = session.getAttribute("BRANCHID").toString();
				System.out.println("select t.atype,t.account,t.description descc,t.doc_no accno,m.curId,m.rate,m.date,m.refno,round(m.amount,2) amount,m.instno,m.stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
						+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
						+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_eadvm m left join my_head t on m.acno=t.doc_no left join my_curr cr on m.curId=cr.doc_no left join hr_empm e "
						+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='EPA' and "
						+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo);
				ResultSet resultSet = stmtDSC.executeQuery ("select t.atype,t.account,t.description descc,t.doc_no accno,0 curId,0 rate,m.date,m.refno,round(m.amount,2) amount,m.instno,m.stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
					+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
					+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_eadvm m left join my_head t on m.acno=t.doc_no left join my_curr cr on 0=cr.doc_no left join hr_empm e "
					+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='EPA' and "
					+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo);
					while (resultSet.next()) {
						deductionScheduleBean.setTxtdeductionscheduledocno(docNo);
						deductionScheduleBean.setDeductionScheduleDate(resultSet.getDate("date").toString());
						deductionScheduleBean.setTxtemployeerefno(resultSet.getString("refno"));
						deductionScheduleBean.setTxtemployeedetails(resultSet.getString("empinfo"));
						deductionScheduleBean.setTxtemployeedocno(resultSet.getInt("empdocno"));
					
						deductionScheduleBean.setTxtfromdocno(resultSet.getInt("accno"));
						deductionScheduleBean.setTxtfromaccid(resultSet.getString("account"));
						deductionScheduleBean.setTxtfromaccname(resultSet.getString("descc"));
						deductionScheduleBean.setTxtfromrate(resultSet.getDouble("rate"));
						deductionScheduleBean.setTxtamount(resultSet.getDouble("amount"));
						deductionScheduleBean.setTxtinstnos(resultSet.getInt("instno"));
						deductionScheduleBean.setTxtinstamt(resultSet.getDouble("amount"));
						deductionScheduleBean.setStartDate(resultSet.getString("stdate").toString());
						deductionScheduleBean.setTxtdescription(resultSet.getString("description"));

				}
			  stmtDSC.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return deductionScheduleBean;
			}
	 
	 
	 public ClsEmployeeAdvancesBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsEmployeeAdvancesBean bean = new ClsEmployeeAdvancesBean();
		 Connection conn = null;
		 
		try {
			conn = clsConnection.getMyConnection();
			Statement stmtDSC = conn.createStatement();
			
			int trno=0,empid=0;
			
			String headersql="select if(m.dtype='DSC','Deduction Schedule','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_addschm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='EPA' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtDSC.executeQuery(headersql);
			//System.out.println("print header--->"+headersql);
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}
			
			String sqls="select DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.refno,round(m.amount,2) amount,m.instno,m.doc_no,DATE_FORMAT(m.stdate ,'%d-%m-%Y') stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
					+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
					+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_addschm m left join hr_empm e "
					+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='EPA' and "
					+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtDSC.executeQuery(sqls);
			//System.out.println("print body1--->"+sqls);
			while(resultSets.next()){
				
				/*bean.setLblvoucherno(resultSets.getString("empdocno"));*/
				
				bean.setDeductionScheduleDate(resultSets.getString("date"));
				bean.setTxtemployeedetails(resultSets.getString("empinfo"));
				bean.setTxtdeductionscheduledocno(resultSets.getInt("doc_no"));
				bean.setTxtemployeerefno(resultSets.getString("refno"));
				bean.setTxtamount(resultSets.getInt("amount"));
				bean.setTxtinstnos(resultSets.getInt("instno"));
				bean.setStartDate(resultSets.getString("stdate"));
				bean.setTxtdescription(resultSets.getString("description"));
				
				/*bean.setLbldesignation(resultSets.getString("designation"));
				bean.setLbldepartment(resultSets.getString("department"));
				bean.setLblcategory(resultSets.getString("category"));
				bean.setLbldateofjoin(resultSets.getString("dtjoin"));
				bean.setLblappraisaldt(resultSets.getString("appraisal"));
				bean.setLblnotifydate(resultSets.getString("notify"));
				bean.setLbldebittotal(resultSets.getString("totalAmount"));
				bean.setLblcredittotal(resultSets.getString("totalAmount"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
				empid=resultSets.getInt("empid");*/
			}
			
			String sqtab="select rowno as srno,date,amount from hr_addschd where rdocno="+docNo+"";
				
			ResultSet resultsettab = stmtDSC.executeQuery(sqtab);
			//System.out.println("print tab--->"+sqtab);
			while(resultsettab.next()){
				
				/*bean.setLblvoucherno(resultSets.getString("empdocno"));*/
				bean.setSrno(resultsettab.getInt("srno"));
				bean.setDate(resultsettab.getString("date"));
				bean.setAmount(resultsettab.getInt("amount"));
				
				/*bean.setLbldesignation(resultSets.getString("designation"));
				bean.setLbldepartment(resultSets.getString("department"));
				bean.setLblcategory(resultSets.getString("category"));
				bean.setLbldateofjoin(resultSets.getString("dtjoin"));
				bean.setLblappraisaldt(resultSets.getString("appraisal"));
				bean.setLblnotifydate(resultSets.getString("notify"));
				bean.setLbldebittotal(resultSets.getString("totalAmount"));
				bean.setLblcredittotal(resultSets.getString("totalAmount"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");*/
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select a.acno,if(a.debit=0,'  ',round(a.debit,2)) debit,if(a.credit=0,'  ',round(a.credit,2)) credit,t.account,t.description codeno from hr_terminationaccountd a left join my_head t "
				    + "on a.acno=t.doc_no where a.empid="+empid+" and a.tr_no="+trno+" and a.rdocno="+docNo+"";
			
			ResultSet resultSet1 = stmtDSC.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
			 
			sql2 = "select description terminations,round(gratuity,2) gratuity,round(leavesalary,2) leavesalary,round(travels,2) travel from hr_terminationd where empid="+empid+" and tr_no="+trno+" and rdocno="+docNo+"";
				 
			ResultSet resultSet2 = stmtDSC.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("terminations")+"::"+resultSet2.getString("gratuity")+"::"+resultSet2.getString("leavesalary")+"::"+resultSet2.getString("travel");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_terminationm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='HTRE' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtDSC.executeQuery(sql3);
			
			while(resultSet3.next()){
				/*bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));*/
			}
		
			stmtDSC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 
	 
	
	 public int insertion(Connection conn,int docno,ArrayList<String> deductionschedulearray,HttpSession session,String mode) throws SQLException{
		     
		  try{
			  Statement stmtDSC1 = conn.createStatement();
			  
			  /*Deduction Schedule Grid Saving*/
				int data=0;
				for(int i=0;i< deductionschedulearray.size();i++){
				String[] deductionschedule=deductionschedulearray.get(i).toString().split("::");
				
				if(!deductionschedule[2].equalsIgnoreCase("undefined") && !deductionschedule[2].equalsIgnoreCase("NaN")){
					
					java.sql.Date distributionDate=null;
					
					if(!((deductionschedule[1].toString()) == null)){
						distributionDate = clsCommon.changetstmptoSqlDate((deductionschedule[1].equalsIgnoreCase("undefined") || deductionschedule[1].equalsIgnoreCase("NaN") || deductionschedule[1].isEmpty()?0:deductionschedule[1]).toString());
					}
				
					String sql="insert into hr_eadvd(rdocno, rowno, date, amount, posted ,postedtrno) values ("+docno+","+(i+1)+",'"+distributionDate+"','"+(deductionschedule[2].trim().equalsIgnoreCase("undefined") || deductionschedule[2].trim().equalsIgnoreCase("NaN") || deductionschedule[2].trim().equalsIgnoreCase("") || deductionschedule[2].trim().isEmpty()?0:deductionschedule[2].trim())+"','"+(deductionschedule[3].trim().equalsIgnoreCase("undefined") || deductionschedule[3].trim().equalsIgnoreCase("NaN") || deductionschedule[3].trim().equalsIgnoreCase("") || deductionschedule[3].trim().isEmpty()?0:deductionschedule[3].trim())+"','"+(deductionschedule[3].trim().equalsIgnoreCase("undefined") || deductionschedule[5].trim().equalsIgnoreCase("NaN") || deductionschedule[5].trim().equalsIgnoreCase("") || deductionschedule[5].trim().isEmpty()?0:deductionschedule[5].trim())+"')";

				    data = stmtDSC1.executeUpdate(sql);
				 }
					if(data<=0){
						stmtDSC1.close();
						conn.close();
						return 0;
					}
				}
				/*Deduction Schedule Grid Saving Ends*/
				
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

	public ArrayList<String> getPrintdetails(int docno, HttpSession session) {
		
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn = null;
		// String brhid=session.getAttribute("BRANCHID").toString();
		try {
			 conn = clsConnection.getMyConnection();
			Statement stmtinv = conn.createStatement ();
			String strSqldetail="";
		strSqldetail="select rowno as srno,DATE_FORMAT(date ,'%d-%m-%Y') date,amount from hr_eadvd where rdocno="+docno+" ";
		

		ResultSet rsdetail=stmtinv.executeQuery(strSqldetail);
		
		int rowcount=1;

		while(rsdetail.next()){

				String temp="";
				
				temp=rsdetail.getString("srno")+"::"+rsdetail.getString("date")+"::"+rsdetail.getString("amount");

				arr.add(temp);
				rowcount++;

		
			
	}
		stmtinv.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return arr;

	}
	
public JSONArray accountsDetails(HttpSession session,String dtype,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = clsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
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
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           String den= "";
	           
	            if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV") || dtype.equalsIgnoreCase("EPA")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("ICCP") || dtype.equalsIgnoreCase("ICCR")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("ICBP") || dtype.equalsIgnoreCase("ICBR")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("PC") || dtype.equalsIgnoreCase("ICPC") || dtype.equalsIgnoreCase("MCP")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BRCN") || dtype.equalsIgnoreCase("UCP")){
					den="305";
				}
				else if(dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("RRP")){
					den="305";
				}
	          		else if(dtype.equalsIgnoreCase("UCR") || dtype.equalsIgnoreCase("MCP")){
					den="305";
				}
				
	           java.sql.Date sqlDate=null;
		       
	           if(check.equalsIgnoreCase("1")){
	        	   
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = clsCommon.changeStringtoSqlDate(date);
	           }
	            
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        	
		        /*sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
            		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
            		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='"+den+"'"+sqltest;*/
		        	
	        	sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,cb.type from my_head t left join my_curr c on t.curid=c.doc_no "
	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	        	  + "where t.atype='GL' and t.m_s=0 and t.den='"+den+"'"+sqltest;
		        System.out.println("===== "+sql);
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=clsCommon.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

}
