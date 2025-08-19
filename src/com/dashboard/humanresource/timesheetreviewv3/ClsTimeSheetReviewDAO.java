package com.dashboard.humanresource.timesheetreviewv3;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTimeSheetReviewDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String cmbbranch, String cmbyear, String cmbmonth, ArrayList<String> timesheetreviewarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {
		
		Connection conn  = null;
		  
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			 
			Statement stmtBTSR = conn.createStatement();
			Statement stmtBTSR1 = conn.createStatement();
			Statement stmtBTSR2 = conn.createStatement();
			Statement stmtBTSR3 = conn.createStatement();
			Statement stmtBTSR4 = conn.createStatement();
			Statement stmtBTSR5 = conn.createStatement();
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
	        
			int docno=0;String totaldays="0";String selectedemployees="";
			 
	        ArrayList<String> weeklyoffarray=new ArrayList<>();
	        ArrayList<String> employeearray=new ArrayList<>();
	        
	             
    	    String sql1="",weekoff="",checkweekoff="0";
    	    String[] weekoffs=null;
    	    
    	    String sql = "select woff from hr_paycode where status=3 and timesheet=1";
    	    ResultSet resultSet = stmtBTSR.executeQuery(sql);
    	    
    	    while(resultSet.next()){
    	    	weekoff=resultSet.getString("woff");
    	    }
    	    
    	    if(weekoff.trim().contains(",")){
    	    	checkweekoff="1";
				weekoffs = weekoff.split(",");
			}
    	    
    	    if(checkweekoff.equalsIgnoreCase("0")){
    	    	
    	    	
    	    	sql1="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY) between "
    	    		+ "'"+cmbyear+"-"+cmbmonth+"-01' and '"+cmbyear+"-"+cmbmonth+"-31' and DAYOFWEEK(DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";
    	    	
    	    	ResultSet resultSet1 = stmtBTSR.executeQuery(sql1);
	    	    
	    	    while(resultSet1.next()){
	    	    	weeklyoffarray.add(resultSet1.getString("holidaysofmonth"));
	    	    }
    	    }else if(checkweekoff.equalsIgnoreCase("1")){
    	    	
    	    	for(int k=0;k<(weekoff.length()-1);k++){
    	    	
    	    	sql1="select row+1  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
	    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY) between "
	    	    		+ "'"+cmbyear+"-"+cmbmonth+"-01' and '"+cmbyear+"-"+cmbmonth+"-31' and DAYOFWEEK(DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";

	    	    	ResultSet resultSet1 = stmtBTSR.executeQuery(sql1);
		    	    
		    	    while(resultSet1.next()){
		    	    	weeklyoffarray.add(resultSet1.getString("holidaysofmonth"));
		    	    }
		    	    
    	    	}
    	    }
    	    
    	    String sql2="select m.doc_no,m.codeno,t.year,t.month from hr_empm m left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) left join hr_timesheet t on "
    	    		+ "(m.doc_no=t.empid and t.year='"+cmbyear+"' and t.month='"+cmbmonth+"') where m.status=3 and c.timesheet=1 and (t.year is null or t.month is null) and "
    	    		+ "m.dtjoin<=LAST_DAY('"+cmbyear+"-"+cmbmonth+"-01')";
    	    ResultSet resultSet2 = stmtBTSR.executeQuery(sql2);
    	    
    	    while(resultSet2.next()){
    	    	employeearray.add(resultSet2.getString("doc_no"));
    	    }
    	    
			String sql3="select DAY(LAST_DAY('"+cmbyear+"-"+cmbmonth+"-01')) totaldays";
    	    ResultSet resultSet3 = stmtBTSR.executeQuery(sql3);
    	    
    	    while(resultSet3.next()){
    	    	totaldays = resultSet3.getString("totaldays");
    	    }
			
    	    String attendance="",attendance1="";
    	    for(int e=0;e<employeearray.size();e++){
    	    	
				   String sql4="INSERT INTO hr_timesheet(empId, year, month, totdays, brhid) VALUES("+employeearray.get(e)+", "+cmbyear+", "+cmbmonth+", "+totaldays+", "+branch+")";
				   stmtBTSR.executeUpdate(sql4);
    	    	
    	    for (int l = 1; l <= Integer.parseInt(totaldays); l++) {
    	    	attendance="1"; attendance1="1";
    	    	
    	    	for(int j=0;j<weeklyoffarray.size();j++){
    	    		if(l==(Integer.parseInt(weeklyoffarray.get(j)))) {
    	    			attendance="2";
    	    		}
    	    	}
    	    
    	        if(!(attendance1.equalsIgnoreCase("1") && attendance.equalsIgnoreCase("2"))){
    	        	attendance=attendance1;
			    }
    	        
    	        String sql5="UPDATE hr_timesheet SET date"+l+"="+attendance+" WHERE payroll_processed=0 and empId="+employeearray.get(e)+" and year="+cmbyear+" and month="+cmbmonth+"";
//    	       System.out.println("first update "+sql5);
    	        stmtBTSR.executeUpdate(sql5);
    	        
    	      }
    	    
    	    }
			
    	    for(int i=0;i< timesheetreviewarray.size();i++){
				String[] timesheetreview=timesheetreviewarray.get(i).split("::");
				
				 if(!timesheetreview[0].equalsIgnoreCase("undefined") && !timesheetreview[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date sqlDate=(timesheetreview[1].trim().equalsIgnoreCase("undefined") || timesheetreview[1].trim().equalsIgnoreCase("NaN") || timesheetreview[1].trim().equalsIgnoreCase("") ||  timesheetreview[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(timesheetreview[1].trim()));
					 String workingTime ="0:00";int attendanceOT=0;
					 
					 String sql6 = "select c.whrs from hr_empm m left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) where m.active=1 and m.status=3 and c.timesheet=1 and m.doc_no='"+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()+"'";
		    	     ResultSet resultSet6 = stmtBTSR1.executeQuery(sql6);
			    	    
		    	     while(resultSet6.next()){
		    	    	 workingTime = resultSet6.getString("whrs");
		    	     }
		    	        
		    	     String normalTime = (timesheetreview[4].trim().equalsIgnoreCase("undefined") || timesheetreview[4].trim().equalsIgnoreCase("NaN") || timesheetreview[4].trim().equalsIgnoreCase("") ||timesheetreview[4].trim().isEmpty()?"0:00":timesheetreview[4].trim()).toString();
					 String otTime = (timesheetreview[5].trim().equalsIgnoreCase("undefined") || timesheetreview[5].trim().equalsIgnoreCase("NaN") || timesheetreview[5].trim().equalsIgnoreCase("") ||timesheetreview[5].trim().isEmpty()?"0:00":timesheetreview[5].trim()).toString();
					 String hotTime = (timesheetreview[6].trim().equalsIgnoreCase("undefined") || timesheetreview[6].trim().equalsIgnoreCase("NaN") || timesheetreview[6].trim().equalsIgnoreCase("") ||timesheetreview[6].trim().isEmpty()?"0:00":timesheetreview[6].trim()).toString();
					 
					 String[] workingHour=workingTime.split(":");
					 String[] normalHour=normalTime.split(":");
					 String[] OverTimeHours= otTime.split(":");
					 String[] hotTimeHours= hotTime.split(":");
//					 System.out.println("ottime = "+otTime+"== overtiehours = "+OverTimeHours[1]);
//					 System.out.println("hottime = "+hotTime+"== hottimehours = "+hotTimeHours[1]);
					 
					 int overTimeInHours= (Integer.parseInt(OverTimeHours[0]) * 60)+ Integer.parseInt(OverTimeHours[1]); 
					 int hotTimeInHours=(Integer.parseInt(hotTimeHours[0]) * 60)+ Integer.parseInt(hotTimeHours[1]);
					 int workingHourInHour = (Integer.parseInt(workingHour[0]) * 60)+ Integer.parseInt(workingHour[1]); 
					 int normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]); 
					 
					 if(!(selectedemployees.contains((timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()))) {
						 if(i==0) {
							 selectedemployees = (timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString();
						 } else {
							 selectedemployees += ","+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString();
						 }
					 }
					 
					 /*
					  * Holiday and overtime Calculation during salary processing 
					  * commented for city expert
					  *  
					  * *if(normalHourInHour>workingHourInHour) {
						 
						 attendanceOT=(normalHourInHour-workingHourInHour);
						 String day="1",workingOrHoliday="1";
						 int overTime=0,holidayOverTime=0;
						 
						 String sql7 = "select DAY('"+sqlDate+"') daySelected";
			    	     ResultSet resultSet7 = stmtBTSR2.executeQuery(sql7);
				    	    
			    	     while(resultSet7.next()){
			    	    	 day = resultSet7.getString("daySelected");
			    	     }
			    	     
			    	     String sql8 = "SELECT date"+day+" lastValue,tot_ot,tot_hot from hr_timesheet WHERE payroll_processed=0  and year='"+cmbyear+"' and month='"+cmbmonth+"' and empid='"+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()+"'";
			    	     ResultSet resultSet8 = stmtBTSR3.executeQuery(sql8);
			    	     while(resultSet8.next()){
			    	    	 workingOrHoliday = resultSet8.getString("lastValue");
			    	    	 overTime = resultSet8.getInt("tot_ot");
			    	    	 holidayOverTime = resultSet8.getInt("tot_hot");
			    	     }
			    	     
			    	     if(workingOrHoliday.equalsIgnoreCase("2")){
			    	    	 holidayOverTime = holidayOverTime + attendanceOT;
			    	     } else {
			    	    	 overTime = overTime + attendanceOT;
			    	     }
			    	     
						 String sql9="UPDATE hr_timesheet SET date"+day+"="+attendanceOT+",tot_ot="+overTime+",tot_hot='"+holidayOverTime+"' WHERE payroll_processed=0 and empId='"+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()+"' and year='"+cmbyear+"' and month='"+cmbmonth+"'";
						 stmtBTSR4.executeUpdate(sql9);
			    	        
					 }*/
					 
					 
					 String day="1",workingOrHoliday="1";
					 int overTime=0,holidayOverTime=0;
					 String sql7 = "select DAY('"+sqlDate+"') daySelected";
		    	     ResultSet resultSet7 = stmtBTSR2.executeQuery(sql7);
			    	    
		    	     while(resultSet7.next()){
		    	    	 day = resultSet7.getString("daySelected");
		    	     }
		    	     // if(overTimeInHours!=0 || hotTimeInHours!=0){
		    	     if(overTimeInHours>10 || hotTimeInHours>10){
		    	    	 String sql8 = "SELECT date"+day+" lastValue,tot_ot,tot_hot from hr_timesheet WHERE payroll_processed=0  and year='"+cmbyear+"' and month='"+cmbmonth+"' and empid='"+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()+"'";
			    	     ResultSet resultSet8 = stmtBTSR3.executeQuery(sql8);
			    	     while(resultSet8.next()){
			    	    	 workingOrHoliday = resultSet8.getString("lastValue");
			    	    	 overTime = resultSet8.getInt("tot_ot");
			    	    	 holidayOverTime = resultSet8.getInt("tot_hot");
			    	     }
			    	     
			    	     if(workingOrHoliday.equalsIgnoreCase("2")){
			    	    	 holidayOverTime = holidayOverTime + hotTimeInHours ;
			    	     } else {
			    	    	 overTime = overTime + overTimeInHours ;
			    	     }
			    	     
			    	     int time=overTimeInHours==0?hotTimeInHours:overTimeInHours;
						 String sql9="UPDATE hr_timesheet SET date"+day+"="+time+",tot_ot="+overTime+",tot_hot='"+holidayOverTime+"' WHERE payroll_processed=0 and empId='"+(timesheetreview[0].trim().equalsIgnoreCase("undefined") || timesheetreview[0].trim().equalsIgnoreCase("NaN") || timesheetreview[0].trim().equalsIgnoreCase("") ||timesheetreview[0].trim().isEmpty()?"0":timesheetreview[0].trim()).toString()+"' and year='"+cmbyear+"' and month='"+cmbmonth+"'";
						 //System.out.println("==== sql9 == "+sql9);
						 stmtBTSR4.executeUpdate(sql9);
					}
		    	     
				}
			}
    	    
    	     String sql10="select coalesce(max(doc_no)+1,1) doc_no from hr_btsr";
		     ResultSet resultSet10 = stmtBTSR5.executeQuery(sql10);
		  
		     while (resultSet10.next()) {
		    	  docno=resultSet10.getInt("doc_no");
		     }
		     
		     
		     /*Updating hr_timesheethrs*/
		     String sql11="UPDATE hr_timesheethrs SET confirm=1 WHERE status=3 and confirm=0 and MONTH(date)='"+cmbmonth+"' and YEAR(date)='"+cmbyear+"'";
		     int data1= stmtBTSR5.executeUpdate(sql11);
			 if(data1<=0){
				 	stmtBTSR5.close();
					conn.close();
					return 0;
				}
			 /*Updating hr_timesheethrs Ends*/
			 
			/*Inserting hr_btsr*/
		     String sql12="insert into hr_btsr(doc_no, date, employeeIds, brhid, userid) values("+docno+",now(),'"+selectedemployees+"',"+branch+","+userid+")";
		     int data2= stmtBTSR5.executeUpdate(sql12);
			 if(data2<=0){
				 	stmtBTSR5.close();
					conn.close();
					return 0;
				}
			 /*Inserting hr_btsr Ends*/
				 
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BTSR',now(),'"+userid+"','E')";
			 int datas= stmtBTSR5.executeUpdate(sqls);
			 if(datas<=0){
				 	stmtBTSR5.close();
				    conn.close();
					return 0;
				}
			
			 conn.commit();
			 stmtBTSR1.close();
			 stmtBTSR2.close();
			 stmtBTSR3.close();
			 stmtBTSR4.close();
			 stmtBTSR5.close();
			 conn.close();
			 return docno;
		
	 } catch(Exception e){	
		 	conn.close();
		 	e.printStackTrace();	
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String category) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBTSR = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase(""))){
	                sql=sql+" and m.codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase(""))){
	             sql=sql+" and m.name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and m.pmmob like '%"+contact+"%'";
	            }
	            if(!(category.equalsIgnoreCase(""))){
	                sql=sql+" and m.pay_catid = '"+category+"'";
	            }
	            
				sql = "select m.doc_no,m.codeno,UPPER(m.name) name,m.pmmob from hr_empm m left join hr_setpaycat c on (m.pay_catid=c.doc_no and c.status=3) where m.active=1 and m.status=3 and c.timesheet=1"+sql;
				
				ResultSet resultSet = stmtBTSR.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBTSR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray timeSheetReviewGridLoading(String fromdate, String todate, String category, String employee, String projecttype, String projectid, String orderbydate,
		String orderbyemployee, String orderbycosttype, String orderbycostid, String rptType, String check) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
	    Connection conn=null;
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBTSR = conn.createStatement();
			
		        java.sql.Date sqlfromdate=null,sqltodate=null;
				   
		        String sql = "",sql4="",sql5="" ,sqltest="";
			 
		        if((!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("0") && !fromdate.equalsIgnoreCase("undefined"))){
			    	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			    }
			    if((!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("0") && !todate.equalsIgnoreCase("undefined"))){
			    	sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
			  
	    	    
	    	    
	    	    if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		            sql4=sql4+" and e.pay_catid='"+category+"'";
		        }
	    	    
	    	    if(!(employee.equalsIgnoreCase("0")) && !(employee.equalsIgnoreCase(""))){
		            sql4=sql4+" and m.empid='"+employee+"'";
		        }
	    	    
	    	    if(!(projecttype.equalsIgnoreCase("0")) && !(projecttype.equalsIgnoreCase(""))){
		            sql4=sql4+" and m.costtype='"+projecttype+"'";
		        }
	    	    
	    	    if(!(projectid.equalsIgnoreCase("0")) && !(projectid.equalsIgnoreCase(""))){
		            sql4=sql4+" and m.costcode='"+projectid+"'";
		        }
	    	    
	    	    if(!(orderbyemployee.equalsIgnoreCase("0")) && !(orderbyemployee.equalsIgnoreCase(""))){
		            sql5+=",m.empid";
		        }
	    	    
	    	    if(!(orderbycosttype.equalsIgnoreCase("0")) && !(orderbycosttype.equalsIgnoreCase(""))){
		            sql5+=",m.costtype";
		        }
	    	    
	    	    if(!(orderbycostid.equalsIgnoreCase("0")) && !(orderbycostid.equalsIgnoreCase(""))){
		            sql5+=",m.costcode";
		        }
	    	    
	    	    if(rptType.equalsIgnoreCase("1")){
	    	    	
	    	    	sql = "select m.date date,m.empid empid,e.name empname,m.costperhour costperhrs,ac.refname client,ROUND(COALESCE((((((EXTRACT(HOUR FROM m.intime)*60)+(EXTRACT(MINUTE FROM m.intime)))/60)*m.costperhour)),2,0))totcost,m.intime hrs from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) left join cm_srvcontrm cs on (m.costcode=cs.doc_no and cs.costtype=m.costtype and cs.brhid=m.brhid) left join my_acbook ac on cs.cldocno=ac.cldocno and ac.dtype='CRM' where m.status=3 and e.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sql4+" group by m.date,m.empid ";
	    	    	// Unable to confirm total leave condition changed(CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),1,0),CHAR(50)) confirm)
	    	    	//System.out.println(" === 1 ==== "+sql);         
		    	    } else if(rptType.equalsIgnoreCase("2")){
		    	    	
		    	    	sql = "select m.rowno,m.costcode,m.costtype,m.empid empdocno,m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs, m.date date,m.empid empid,e.name empname,m.costperhour costperhrs,m.description description,m.normalhrs,m.intime,m.outtime,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS costcodename,f.costgroup,ac.refname client,ROUND(COALESCE((((((EXTRACT(HOUR FROM m.intime)*60)+(EXTRACT(MINUTE FROM m.intime)))/60)*m.costperhour)),2,0)) totcost,'EDIT' editbtn,'0' confirm,m.confirm confirmed  from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) left join cm_srvcontrm cs on (m.costcode=cs.doc_no and cs.costtype=m.costtype and cs.brhid=m.brhid) left join my_acbook ac on cs.cldocno=ac.cldocno and ac.dtype='CRM' where m.status=3 and e.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sql4+" ";       

		    	    	/*CONVERT(if(round((m.normal-m.ot-m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((m.normal-m.ot-m.hot)*60))=8,SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,6))),CHAR(100))
	    	    	 * */
    	    	//System.out.println(" === 2 ==== "+sql);
	    	    }
	    	    System.out.println(" === sql ==== "+sql);  
				ResultSet resultSet = stmtBTSR.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtBTSR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	 
	public int timeSheetUpdate(Connection conn,java.sql.Date date,String empdocno,String normalhrs,String intime,String outtime,String costtype,String costcode,String inrowno) throws SQLException {
		
			int val=0;
			int val2=0;
			int flag=0;
			
			Statement stmtBHTS=conn.createStatement();
			Statement stmtBHTS1=conn.createStatement();
		try{
			
			 val2=stmtBHTS1.executeUpdate("update hr_timesheethrs set normal=0,ot=0, hot=0 where status=3 and date='"+date+"' and empid="+empdocno+""); 
			
			 String normalTime ="";
			 String otTime ="00:00"; //(timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") || timesheet[5].trim()==null ||timesheet[5].trim().isEmpty()?"0:00":timesheet[5].trim()).toString();
			 String hotTime ="00:00";// (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") || timesheet[6].trim()==null ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
			 String rowno="";
			 
			 int normalHourInHour = 0; 
			 int otInHour = 0;
			 int hotInHour = 0;
			 int normalhours= 0;
			 
			 
			 /*Holidays & Ramdan Deduction Hrs*/
			 String method="0",ramdanDedHrs="0";
			 int ramdanWhrs=0,actualWhrs=0,ramdanDeduction=0,holidayWorked=0;
			 java.sql.Date sqlHolidayDate=null;
			 
			 String sqls ="select CONCAT(YEAR('"+date+"'),'-',if(LENGTH(MONTH('"+date+"'))=1,CONCAT('0',MONTH('"+date+"')),MONTH('"+date+"')),'-',if(LENGTH(row+1)=1,CONCAT('0',row+1),row+1))  as holidaysofmonth from ( "
					 + "SELECT @row := @row + 1 as row FROM ( select 0 union all select 1 union all select 3 union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all "
					 + "select 3 union all select 4 union all select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY) between "
					 + "DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH) and LAST_DAY('"+date+"') and DAYOFWEEK(DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY))="
					 + "(if(((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
					 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+")+1)>7,1,"
					 + "((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid where m.status=3 and c.status=3 "
					 + "and c.timesheet=1 and m.doc_no="+empdocno+")+1)))";
			 ResultSet resultSets = stmtBHTS.executeQuery(sqls);
			 while (resultSets.next()) {
				 sqlHolidayDate=resultSets.getDate("holidaysofmonth");
				 if(sqlHolidayDate.compareTo(date) == 0){
					 holidayWorked=1;
					 break;
				 }
				 
				 if(holidayWorked==1){
					 break;
				 }
			 }
			 
			 Statement stmtBHTS2 = conn.createStatement();
			 Statement stmtBHTS3 = conn.createStatement();
			 
			 String sql1="select * from hr_setholidayhrsd where status=3 and date='"+date+"'";
			 ResultSet resultSet1 = stmtBHTS.executeQuery(sql1);
			 while (resultSet1.next()) {
				 holidayWorked=1;
				 String sql2="select * from hr_setholidayhrsm where status=3 and '"+date+"' between fromdate and todate and deduction=1";
				 ResultSet resultSet2 = stmtBHTS2.executeQuery(sql2);
				 while (resultSet2.next()) {
					 ramdanDeduction=1;
					 String sql3="select method,round(value,0) ramdanhrsded from gl_config where field_nme='HRRamdanDedHrs'";
					 ResultSet resultSet3 = stmtBHTS3.executeQuery(sql3);
					 while (resultSet3.next()) {
						 method=resultSet3.getString("method");
						 ramdanDedHrs=resultSet3.getString("ramdanhrsded");
					 }
					 
				 }
		     }
			 
			 /* 
			  * local holiday normal hrs move to holiday overtime
			  */
			 
			 Statement stmtholiday=conn.createStatement();
			 Statement stmtholiday2=conn.createStatement();
			 String sqlholiday="select DAY('"+date+"') day";
			 ResultSet resultSetholiday = stmtholiday.executeQuery(sqlholiday);
			 while (resultSetholiday.next()) {
				 String sqlholiday2="select * from hr_timesheet where empid=102 and date"+resultSetholiday.getString("day")+"=9 and date"+resultSetholiday.getString("day")+"=9 and month('"+date+"')=month and year('"+date+"')=YEAR ";
//				 System.out.println("======= "+sqlholiday2);
				 ResultSet resultSetHoliday2 = stmtholiday2.executeQuery(sqlholiday2);
				 while (resultSetHoliday2.next()) {
					 holidayWorked=1;	 
				 }
//				 System.out.println("======= "+holidayWorked);
		     }
			 
			 /*Holidays & Ramdan Deduction Hrs ends*/
			
			 String rowsqls="select normalhrs,rowno from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" ";
			 Statement rowstmt=conn.createStatement();
			 ResultSet rowrs = rowstmt.executeQuery(rowsqls);
			 while (rowrs.next()) {
				 if(rowrs.getString("rowno").equalsIgnoreCase(""+inrowno+"")){
					 normalTime = (normalhrs.trim().equalsIgnoreCase("undefined") || normalhrs.trim().equalsIgnoreCase("NaN") || normalhrs.trim().equalsIgnoreCase("") || normalhrs.trim()==null ||normalhrs.trim().isEmpty()?"0:00":normalhrs.trim()).toString();
					 if(!(normalTime.equalsIgnoreCase("null"))) {
						 String[] normalHour=normalTime.split(":");
						 normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
						 normalhours = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
					 } else {
						 normalTime="00:00";
					 }
					 
					 rowno=inrowno;
				 }else{
					 String[] normalHour=rowrs.getString("normalhrs").split(":");
					 normalHourInHour=(Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
					 normalhours=(Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
					 rowno=rowrs.getString("rowno");
				 }
				 
				 
				 /*Ramdan Deduction Hrs*/
				 if(method.equalsIgnoreCase("1") && ramdanDeduction==1){
					 
					 String sql4s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+"";
					 ResultSet resultSet4s = stmtBHTS.executeQuery(sql4s);
					 while (resultSet4s.next()) {
						 normalHourInHour=resultSet4s.getInt("workedhrs");
					 }
					 
					 String sql4="select ((if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))))-("+ramdanDedHrs+")) ramdanwhrs from "
							 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
					 ResultSet resultSet4 = stmtBHTS.executeQuery(sql4);
					 while (resultSet4.next()) {
						 ramdanWhrs=resultSet4.getInt("ramdanwhrs");
					 }
					 
					 if(holidayWorked==1) {
						 
						 if(normalHourInHour>ramdanWhrs){
							 otInHour=normalHourInHour-ramdanWhrs;
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 /*otTime=hours+":"+minutes;*/
							 otTime=hours+":"+String.format("%02d", minutes);
						 }
					 } else {
						 
						 if(normalHourInHour>ramdanWhrs){
							 hotInHour=normalHourInHour-ramdanWhrs;
							 int hours = hotInHour / 60;
							 int minutes = hotInHour % 60;
							 //hotTime=hours+":"+minutes;
							 hotTime=hours+":"+String.format("%02d", minutes);
						 }
						 
					 }
					 
				 }
				 /*Ramdan Deduction Hrs Ends*/
				 
				 /*Holiday Hrs*/
				 if(holidayWorked==1 && ramdanDeduction==0) {
					 
					 String sql5s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+"";
					 ResultSet resultSet5s = stmtBHTS.executeQuery(sql5s);
					 while (resultSet5s.next()) {
						 normalHourInHour=resultSet5s.getInt("workedhrs");
					 }
					 
					 String sql5="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
							 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
					 ResultSet resultSet5 = stmtBHTS.executeQuery(sql5);
					 while (resultSet5.next()) {
						 actualWhrs=resultSet5.getInt("whrs");
					 }
					 
					 hotInHour=normalHourInHour;
					 int hours = hotInHour / 60;
					 int minutes = hotInHour % 60;
					 //hotTime=hours+":"+minutes;
					 hotTime=hours+":"+String.format("%02d", minutes);
					 
					 
				 }
				 /*Holiday Hrs*/
				 
				 
				 /*Over Time Hrs*/
				 if(holidayWorked==0 && ramdanDeduction==0) {
					 
					 String sql6s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+" ";
					 
//					 System.out.println(sql6s);
					 
					 ResultSet resultSet6s = stmtBHTS.executeQuery(sql6s);
					 while (resultSet6s.next()) {
						 normalHourInHour=resultSet6s.getInt("workedhrs");
					 }
					 
					 String sql6="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
							 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
					 ResultSet resultSet6 = stmtBHTS.executeQuery(sql6);
					 while (resultSet6.next()) {
						 actualWhrs=resultSet6.getInt("whrs");
					 }
					   
					 if(normalHourInHour>actualWhrs){
						 otInHour=normalHourInHour-actualWhrs;
						 int hours = otInHour / 60;
						 int minutes = otInHour % 60;
						 /*otTime=hours+":"+minutes;*/
						 otTime=hours+":"+String.format("%02d", minutes);
					 }
					 
				 }
				 /*Over Time Hrs*/
				 
				 if(rowrs.getString("rowno").equalsIgnoreCase(""+inrowno+"")){
//					 System.out.println("first--"+normalTime+"---"+otTime+"---"+hotTime+"--"+normalHourInHour+"--"+otInHour+"--"+hotInHour+"--");
					 String sql="update hr_timesheethrs set intime='"+intime+"', outtime='"+outtime+"', normalhrs='"+normalTime+"', othrs='"+otTime+"', hothrs='"+hotTime+"', normal='"+normalhours+"', ot='"+otInHour+"', hot='"+hotInHour+"' where status=3 and rowno='"+rowno+"'";
			    	 val= stmtBHTS1.executeUpdate(sql);
				 }else{
//					 System.out.println("second--"+normalTime+"---"+otTime+"---"+hotTime+"--"+normalHourInHour+"--"+otInHour+"--"+hotInHour+"--");
					 String sql="update hr_timesheethrs set othrs='"+otTime+"', hothrs='"+hotTime+"', normal='"+normalhours+"', ot='"+otInHour+"', hot='"+hotInHour+"' where status=3 and rowno='"+rowno+"'";
			    	 val= stmtBHTS1.executeUpdate(sql);
				 }
				 
			 }
			     stmtBHTS.close();
		    	 stmtBHTS1.close();
				 stmtBHTS2.close();
				 stmtBHTS3.close();
				 
				 if(val==0 && val2==0){
					 flag=1;
				 }
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return flag;
	}
	
	public int timeSheetDelete(Connection conn,java.sql.Date date,String empdocno,String inrowno) throws SQLException {
		
		int val=0;
		int val2=0;
		int val3=0;
		int flag=0;
		Statement stmtBHTS=conn.createStatement();
		Statement stmtBHTS1=conn.createStatement();
		
	try{
		 val2=stmtBHTS1.executeUpdate("delete from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno="+inrowno);
		 
		 val3=stmtBHTS1.executeUpdate("update hr_timesheethrs set normal=0,ot=0, hot=0 where status=3 and date='"+date+"' and empid="+empdocno+""); 
		
//		 String normalTime ="";
		 String otTime ="00:00"; //(timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") || timesheet[5].trim()==null ||timesheet[5].trim().isEmpty()?"0:00":timesheet[5].trim()).toString();
		 String hotTime ="00:00";// (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") || timesheet[6].trim()==null ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
		 String rowno="";
		 
		 int normalHourInHour = 0; 
		 int otInHour = 0;
		 int hotInHour = 0;
		 int normalhours= 0;
		 
		 
		 /*Holidays & Ramdan Deduction Hrs*/
		 String method="0",ramdanDedHrs="0";
		 int ramdanWhrs=0,actualWhrs=0,ramdanDeduction=0,holidayWorked=0;
		 java.sql.Date sqlHolidayDate=null;
		 
		 String sqls ="select CONCAT(YEAR('"+date+"'),'-',if(LENGTH(MONTH('"+date+"'))=1,CONCAT('0',MONTH('"+date+"')),MONTH('"+date+"')),'-',if(LENGTH(row+1)=1,CONCAT('0',row+1),row+1))  as holidaysofmonth from ( "
				 + "SELECT @row := @row + 1 as row FROM ( select 0 union all select 1 union all select 3 union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all "
				 + "select 3 union all select 4 union all select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY) between "
				 + "DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH) and LAST_DAY('"+date+"') and DAYOFWEEK(DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY))="
				 + "(if(((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
				 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+")+1)>7,1,"
				 + "((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid where m.status=3 and c.status=3 "
				 + "and c.timesheet=1 and m.doc_no="+empdocno+")+1)))";
		 ResultSet resultSets = stmtBHTS.executeQuery(sqls);
		 while (resultSets.next()) {
			 sqlHolidayDate=resultSets.getDate("holidaysofmonth");
			 if(sqlHolidayDate.compareTo(date) == 0){
				 holidayWorked=1;
				 break;
			 }
			 
			 if(holidayWorked==1){
				 break;
			 }
		 }
		 
		 Statement stmtBHTS2 = conn.createStatement();
		 Statement stmtBHTS3 = conn.createStatement();
		 
		 String sql1="select * from hr_setholidayhrsd where status=3 and date='"+date+"'";
		 ResultSet resultSet1 = stmtBHTS.executeQuery(sql1);
		 while (resultSet1.next()) {
			 holidayWorked=1;
			 String sql2="select * from hr_setholidayhrsm where status=3 and '"+date+"' between fromdate and todate and deduction=1";
			 ResultSet resultSet2 = stmtBHTS2.executeQuery(sql2);
			 while (resultSet2.next()) {
				 ramdanDeduction=1;
				 String sql3="select method,round(value,0) ramdanhrsded from gl_config where field_nme='HRRamdanDedHrs'";
				 ResultSet resultSet3 = stmtBHTS3.executeQuery(sql3);
				 while (resultSet3.next()) {
					 method=resultSet3.getString("method");
					 ramdanDedHrs=resultSet3.getString("ramdanhrsded");
				 }
				 
			 }
	     }
		 /*Holidays & Ramdan Deduction Hrs ends*/
		
		 String rowsqls="select normalhrs,rowno from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" ";
		 Statement rowstmt=conn.createStatement();
		 ResultSet rowrs = rowstmt.executeQuery(rowsqls);
		 while (rowrs.next()) {
			 
				 String[] normalHour=rowrs.getString("normalhrs").split(":");
				 normalHourInHour=(Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
				 normalhours=(Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
				 rowno=rowrs.getString("rowno");
			 
			 /*Ramdan Deduction Hrs*/
			 if(method.equalsIgnoreCase("1") && ramdanDeduction==1){
				 
				 String sql4s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+"";
				 ResultSet resultSet4s = stmtBHTS.executeQuery(sql4s);
				 while (resultSet4s.next()) {
					 normalHourInHour=resultSet4s.getInt("workedhrs");
				 }
				 
				 String sql4="select ((if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))))-("+ramdanDedHrs+")) ramdanwhrs from "
						 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
						 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
				 ResultSet resultSet4 = stmtBHTS.executeQuery(sql4);
				 while (resultSet4.next()) {
					 ramdanWhrs=resultSet4.getInt("ramdanwhrs");
				 }
				 
				 if(holidayWorked==1) {
					 
					 if(normalHourInHour>ramdanWhrs){
						 otInHour=normalHourInHour-ramdanWhrs;
						 int hours = otInHour / 60;
						 int minutes = otInHour % 60;
						 /*otTime=hours+":"+minutes;*/
						 otTime=hours+":"+String.format("%02d", minutes);
					 }
				 } else {
					 
					 if(normalHourInHour>ramdanWhrs){
						 hotInHour=normalHourInHour-ramdanWhrs;
						 int hours = hotInHour / 60;
						 int minutes = hotInHour % 60;
						 //hotTime=hours+":"+minutes;
						 hotTime=hours+":"+String.format("%02d", minutes);
					 }
					 
				 }
				 
			 }
			 /*Ramdan Deduction Hrs Ends*/
			 
			 /*Holiday Hrs*/
			 if(holidayWorked==1 && ramdanDeduction==0) {
				 
				 String sql5s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+"";
				 ResultSet resultSet5s = stmtBHTS.executeQuery(sql5s);
				 while (resultSet5s.next()) {
					 normalHourInHour=resultSet5s.getInt("workedhrs");
				 }
				 
				 String sql5="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
						 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
						 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
				 ResultSet resultSet5 = stmtBHTS.executeQuery(sql5);
				 while (resultSet5.next()) {
					 actualWhrs=resultSet5.getInt("whrs");
				 }
				 
				 hotInHour=normalHourInHour;
				 int hours = hotInHour / 60;
				 int minutes = hotInHour % 60;
				 //hotTime=hours+":"+minutes;
				 hotTime=hours+":"+String.format("%02d", minutes);
				 
				 
			 }
			 /*Holiday Hrs*/
			 
			 
			 /*Over Time Hrs*/
			 if(holidayWorked==0 && ramdanDeduction==0) {
				 
				 String sql6s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+empdocno+" and rowno!="+rowno+" ";
				 
//				 System.out.println(sql6s);
				 
				 ResultSet resultSet6s = stmtBHTS.executeQuery(sql6s);
				 while (resultSet6s.next()) {
					 normalHourInHour=resultSet6s.getInt("workedhrs");
				 }
				 
				 String sql6="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
						 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
						 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+empdocno+"";
				 ResultSet resultSet6 = stmtBHTS.executeQuery(sql6);
				 while (resultSet6.next()) {
					 actualWhrs=resultSet6.getInt("whrs");
				 }
				   
				 if(normalHourInHour>actualWhrs){
					 otInHour=normalHourInHour-actualWhrs;
					 int hours = otInHour / 60;
					 int minutes = otInHour % 60;
					 /*otTime=hours+":"+minutes;*/
					 otTime=hours+":"+String.format("%02d", minutes);
				 }
				 
			 }
			 /*Over Time Hrs*/
			 
			 
//				 System.out.println("second--"+normalTime+"---"+otTime+"---"+hotTime+"--"+normalHourInHour+"--"+otInHour+"--"+hotInHour+"--");
				 String sql="update hr_timesheethrs set othrs='"+otTime+"', hothrs='"+hotTime+"', normal='"+normalhours+"', ot='"+otInHour+"', hot='"+hotInHour+"' where status=3 and rowno='"+rowno+"'";
		    	 val= stmtBHTS1.executeUpdate(sql);
			 
			 
		 }
		     stmtBHTS.close();
	    	 stmtBHTS1.close();
			 stmtBHTS2.close();
			 stmtBHTS3.close();
			 
			 if(val==0 && val2==0 && val3==0){
				 flag=1;
			 }
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	return flag;
}
}
