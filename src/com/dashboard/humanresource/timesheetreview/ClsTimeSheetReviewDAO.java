package com.dashboard.humanresource.timesheetreview;

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
	
	public int insert(String cmbbranch, String cmbyear, String cmbmonth, HttpSession session, HttpServletRequest request, 
			String mode,String date,String cmbempcategory,String txtemployeedocno,String txtprojecttypeid,String txtprojectid,String hidchckorderbyemployee,String hidchckorderbycosttype,String hidchckorderbycostid) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
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
			Statement stmtBTSR6 = conn.createStatement();
            Statement stmtcnfrm = conn.createStatement();
            
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
    	    
    	    
    	    java.sql.Date sqlDate1=null;
            
            date.trim();
            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
            {
                sqlDate1 = ClsCommon.changeStringtoSqlDate(date);
            }
            
  String sql111="",sql222="",sql333="",sql444="",sql555="";
            
            if(!(cmbyear.equalsIgnoreCase("0")) && !(cmbyear.equalsIgnoreCase(""))){
                sql111=sql111+" and YEAR(m.date)='"+cmbyear+"'";
            }
            
            if(!(cmbmonth.equalsIgnoreCase("0")) && !(cmbmonth.equalsIgnoreCase(""))){
                sql111=sql111+" and MONTH(m.date)='"+cmbmonth+"'";
            }
            
            if(sqlDate1!=null){
                sql222=sql222+" and date='"+sqlDate1+"'";
                sql333=sql333+" and m.date='"+sqlDate1+"'";
            }
            
            if(!(cmbempcategory.equalsIgnoreCase("0")) && !(cmbempcategory.equalsIgnoreCase(""))){
                sql444=sql444+" and e.pay_catid='"+cmbempcategory+"'";
            }
            
            if(!(txtemployeedocno.equalsIgnoreCase("0")) && !(txtemployeedocno.equalsIgnoreCase(""))){
                sql444=sql444+" and m.empid='"+txtemployeedocno+"'";
            }
            
            if(!(txtprojecttypeid.equalsIgnoreCase("0")) && !(txtprojecttypeid.equalsIgnoreCase(""))){
                sql444=sql444+" and m.costtype='"+txtprojecttypeid+"'";
            }
            
            if(!(txtprojectid.equalsIgnoreCase("0")) && !(txtprojectid.equalsIgnoreCase(""))){
                sql444=sql444+" and m.costcode='"+txtprojectid+"'";
            }
            
            if(!(hidchckorderbyemployee.equalsIgnoreCase("0")) && !(hidchckorderbyemployee.equalsIgnoreCase(""))){
                sql555+=",m.empid";
            }
            
            if(!(hidchckorderbycosttype.equalsIgnoreCase("0")) && !(hidchckorderbycosttype.equalsIgnoreCase(""))){
                sql555+=",m.costtype";
            }
            
            if(!(hidchckorderbycostid.equalsIgnoreCase("0")) && !(hidchckorderbycostid.equalsIgnoreCase(""))){
                sql555+=",m.costcode";
            }
          
            ArrayList<String> timesheetreviewarray= new ArrayList<String>();
            
            
            sql = "select a.dtjoin,rtrim(ltrim(CONVERT(a.date,CHAR(500))))  date, rtrim(ltrim(a.empdocno)) empdocno , rtrim(ltrim(a.empid)) empid, rtrim(ltrim(a.empname)) empname,rtrim(ltrim(a.costgroup)) costgroup, rtrim(ltrim(a.costtype)) costtype, rtrim(ltrim(a.costcodename)) costcodename, rtrim(ltrim(a.costcode)) costcode, rtrim(ltrim(a.normal)) normal, rtrim(ltrim(a.hrs)) hrs, rtrim(ltrim((a.normal-a.ot-a.hot))) actualnormal,rtrim(ltrim(CONVERT(if(round((a.normal-a.ot-a.hot)*60,2)=0,' ', " 
                    + "if(LENGTH(SEC_TO_TIME((a.normal-a.ot-a.hot)*60))=8,SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,6))),CHAR(100)))) actualhrs, rtrim(ltrim(a.ot)) ot, rtrim(ltrim(a.othrs))othrs, a.hot,a.hothrs, rtrim(ltrim(a.normalhrs)) normalhrs, rtrim(ltrim(a.overtimehrs)) overtimehrs, "
                    + "rtrim(ltrim(a.holidayovertimehrs)) holidaytimehrs, rtrim(ltrim(a.editbtn)) editbtn, rtrim(ltrim(a.confirm)) confirm, rtrim(ltrim(a.confirmed)) confirmed from  ( "
                    + "select e.dtjoin,m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS costcodename,"
                    + "m.costcode,sum(m.normal) normal,CONVERT(if(round(sum(m.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,6))),CHAR(100)) hrs,"
                    + "sum(m.ot) ot,CONVERT(if(round(sum(m.ot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.ot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,6))),CHAR(100)) othrs,"  
                    + "sum(m.hot) hot,CONVERT(if(round(sum(m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.hot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,6))),CHAR(100)) hothrs,"
                    + "m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm,m.confirm confirmed from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on "
                    + "m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3 "
                    + "and YEAR(m.date)='"+cmbyear+"' and MONTH(m.date)='"+cmbmonth+"'"+sql333+""+sql444+" group by m.date,m.empid union all "
                    + "select l.dtjoin,l.date,l.empdocno,l.empid,l.empname,l.costgroup,l.costtype,l.costcodename,l.costcode,l.normal,l.hrs,l.ot,l.othrs,l.hot,l.hothrs,l.normalhrs,l.overtimehrs,l.holidayovertimehrs,l.editbtn,CASE WHEN substring_index(l.empname, ' - ',-1)='Holiday' "
                    + "Then 0 WHEN substring_index(l.empname, ' - ',-1)='Leave' Then 0 ELSE l.confirm END AS confirm,l.confirmed from ( "
                    + "select s.dtjoin,a.date,s.empdocno,s.empid,CONCAT(s.empname,(CASE WHEN DAY(a.date)=1 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date1),'') " 
                    + "WHEN DAY(a.date)=2 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date2),'') "
                    + "WHEN DAY(a.date)=3 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date3),'') " 
                    + "WHEN DAY(a.date)=4 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date4),'') " 
                    + "WHEN DAY(a.date)=5 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date5),'') " 
                    + "WHEN DAY(a.date)=6 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date6),'') " 
                    + "WHEN DAY(a.date)=7 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date7),'') " 
                    + "WHEN DAY(a.date)=8 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date8),'') " 
                    + "WHEN DAY(a.date)=9 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date9),'') " 
                    + "WHEN DAY(a.date)=10 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date10),'') " 
                    + "WHEN DAY(a.date)=11 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date11),'') " 
                    + "WHEN DAY(a.date)=12 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date12),'') " 
                    + "WHEN DAY(a.date)=13 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date13),'') " 
                    + "WHEN DAY(a.date)=14 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date14),'') " 
                    + "WHEN DAY(a.date)=15 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date15),'') " 
                    + "WHEN DAY(a.date)=16 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date16),'') " 
                    + "WHEN DAY(a.date)=17 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date17),'') " 
                    + "WHEN DAY(a.date)=18 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date18),'') " 
                    + "WHEN DAY(a.date)=19 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date19),'') " 
                    + "WHEN DAY(a.date)=20 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date20),'') " 
                    + "WHEN DAY(a.date)=21 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date21),'') " 
                    + "WHEN DAY(a.date)=22 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date22),'') " 
                    + "WHEN DAY(a.date)=23 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date23),'') " 
                    + "WHEN DAY(a.date)=24 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date24),'') " 
                    + "WHEN DAY(a.date)=25 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date25),'') " 
                    + "WHEN DAY(a.date)=26 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date26),'') " 
                    + "WHEN DAY(a.date)=27 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date27),'') " 
                    + "WHEN DAY(a.date)=28 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date28),'') " 
                    + "WHEN DAY(a.date)=29 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date29),'') " 
                    + "WHEN DAY(a.date)=30 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date30),'') " 
                    + "WHEN DAY(a.date)=31 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date31),'') ELSE '' END)) empname," 
                    + "s.costgroup,s.costtype,s.costcodename,s.costcode,s.normal,s.hrs,s.ot,s.othrs,s.hot,s.hothrs,s.normalhrs,s.overtimehrs,s.holidayovertimehrs,s.editbtn,s.confirm,s.confirmed from ( "
                    + "select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from (select 0 as num union all select 1 union all "
                    + "select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all "
                    + "select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all "
                    + "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all select 4 union all "  
                    + "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+cmbyear+"-"+cmbmonth+"-01') and YEAR(date)=YEAR('"+cmbyear+"-"+cmbmonth+"-01')"+sql222+") a, " 
                    + "(select m.date,e.doc_no empdocno,e.codeno empid,e.name empname,'' costgroup,'' costtype,'' costcodename,'' costcode,0 normal,'' hrs,0 ot,'' othrs,0 hot,'' hothrs,'' normalhrs,'' overtimehrs,'' holidayovertimehrs,"
                    + "'ADD' editbtn,CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),0,0),CHAR(50)) confirm,t.date1,t.date2,t.date3,t.date4,t.date5,"
                    + "t.date6,t.date7,t.date8,t.date9,t.date10,t.date11,t.date12,t.date13,t.date14,t.date15,t.date16,t.date17,t.date18,t.date19,t.date20,t.date21,t.date22,t.date23,t.date24,t.date25,t.date26,t.date27,t.date28,t.date29,t.date30,t.date31,m.confirm confirmed,e.dtjoin "
                    + "from hr_empm e left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) left join hr_timesheethrs m on (e.doc_no=m.empid and m.status=3 and YEAR(m.date)='"+cmbyear+"' and MONTH(m.date)='"+cmbmonth+"'"+sql333+" ) "
                    + "left join hr_timesheet t on (e.doc_no=t.empid and t.year='"+cmbyear+"' and t.month='"+cmbmonth+"') where e.active=1 and e.status=3 and c.timesheet=1 and MONTH(dtjoin)<='"+cmbmonth+"' and YEAR(dtjoin)<='"+cmbyear+"' "+sql444+" ) s group by a.date,s.empdocno ) l ) a group by a.date,a.empdocno "
                    + "  having a.date>=dtjoin order by a.empdocno,a.date";
            // Unable to confirm total leave condition changed(CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),1,0),CHAR(50)) confirm)
           //System.out.println(" === confirm check grid ==== "+sql);         
            ResultSet rsconfirm = stmtcnfrm.executeQuery(sql);
            String empdocno="",date1="",costtype="",costcode="",hrs="",othrs="",hothrs="";

          
             while (rsconfirm.next()) {
              
               empdocno=rsconfirm.getString("empdocno");
               date1=rsconfirm.getString("date");
               costtype=rsconfirm.getString("costtype");
               costcode=rsconfirm.getString("costcode");
               hrs=rsconfirm.getString("hrs");
               othrs=rsconfirm.getString("othrs");
               hothrs=rsconfirm.getString("hothrs");
              
               timesheetreviewarray.add(empdocno+" :: "+date1+" :: "+costtype+" :: "+costcode+" :: "+hrs+" :: "+othrs+" :: "+hothrs);
               
           }
          // System.out.println("timesheetreviewarray---"+timesheetreviewarray);
           for(int i=0;i< timesheetreviewarray.size();i++){
				String[] timesheetreview=timesheetreviewarray.get(i).split("::");
				
				 if(!timesheetreview[0].equalsIgnoreCase("undefined") && !timesheetreview[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date sqlDate=(timesheetreview[1].trim().equalsIgnoreCase("undefined") || timesheetreview[1].trim().equalsIgnoreCase("NaN") || timesheetreview[1].trim().equalsIgnoreCase("") ||  timesheetreview[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate2(timesheetreview[1].trim()));
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
					//	 System.out.println("==== sql9 == "+sql9);
						 stmtBTSR4.executeUpdate(sql9);
					}
		    	     
				}
			}
           
           String sqlrs="select empid, fromdate, todate, halfday, halfdaydate, leavetype,description from hr_leaverequest where  ((month(fromdate) ='"+cmbmonth+"' and year(fromdate)='"+cmbyear+"') or (month(todate) ='"+cmbmonth+"' and year(todate)='"+cmbyear+"')) and confirm=1 and status=3";
           //System.out.println("lv req qury------ "+sqlrs);
           ResultSet rsl = stmtBTSR5.executeQuery(sqlrs);
           int empid=0,halfday=0;
           String description="",leavetype="";
           java.sql.Date sqlFromDate=null,sqlToDate=null,sqlHalfDayDate=null;
           
           while (rsl.next()) {
               empid=rsl.getInt("empid");
               sqlFromDate=rsl.getDate("fromdate");
               sqlToDate=rsl.getDate("todate");
               halfday=rsl.getInt("halfday");
               sqlHalfDayDate=rsl.getDate("halfdaydate");
               leavetype=rsl.getString("leavetype");
               description=rsl.getString("description");
          
           
           ArrayList<String> requestedarray=new ArrayList<String>();
           
           /*Selecting Requested Dates*/
           String sql112="select DATE_FORMAT(requested_date,'%d.%m.%Y') requested_date from "
                   + " (select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) requested_date from "
                   + " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,"
                   + " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,"
                   + " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,"
                   + " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,"
                   + " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v"
                   + " where requested_date between '"+sqlFromDate+"' and '"+sqlToDate+"'";
           //System.out.println("req date select-----------"+sql112);
           ResultSet resultSet1=stmtBTSR6.executeQuery(sql112);

           while(resultSet1.next()){
               requestedarray.add(resultSet1.getString("requested_date"));
           }
           /*Selecting Requested Dates Ends*/
           
           if(requestedarray.size()>0){
           
           for(int j=0;j<requestedarray.size();j++){
             
               int day=0,attendancedate=0,alreadyAttendance=0;
               String dayofday="0",month="0",year="0";
               double totleave1=0.00,totleave2=0.00,totleave3=0.00,totleave4=0.00,totleave5=0.00,totleave6=0.00;
               java.sql.Date sqlRequestedDate=ClsCommon.changeStringtoSqlDate(requestedarray.get(j));
               
               String sql21="select DAY('"+sqlRequestedDate+"') days,DATE_FORMAT('"+sqlRequestedDate+"','%d') dayofday,DATE_FORMAT('"+sqlRequestedDate+"','%m') months,YEAR('"+sqlRequestedDate+"') years";
               //System.out.println("req date 2------------"+sql21);
               ResultSet resultSet21=stmtBTSR6.executeQuery(sql21);

               while(resultSet21.next()){
                   day=resultSet21.getInt("days");
                   dayofday=resultSet21.getString("dayofday");
                   month=resultSet21.getString("months");
                   year=resultSet21.getString("years");
               }
           
           int marknewattendance=0;String sqltotalsub="",leave="",sqltotaladd="";
           String sql9="select refno,alpha from hr_timesheetset where reftype='L' and doc_no="+leavetype+"";
          //System.out.println("tymsheet rv---------"+sql9);
           ResultSet resultSet7 = stmtBTSR6.executeQuery(sql9);
           while (resultSet7.next()) {
               marknewattendance=resultSet7.getInt("refno");
               leave=resultSet7.getString("alpha");

           }
           
           if(halfday==1 && (sqlHalfDayDate.compareTo(sqlRequestedDate)==0)) {
               marknewattendance=Integer.parseInt(marknewattendance+"2");
           }
          
         /* if(attendancedate!=1 && attendancedate!=2) {
               if(attendancedate==3 && totleave1!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave1=(tot_leave1-1)";
               } else if(attendancedate==4 && totleave2!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave2=(tot_leave2-1)";
               } else if(attendancedate==5 && totleave3!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave3=(tot_leave3-1)";
               } else if(attendancedate==6 && totleave4!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave4=(tot_leave4-1)";
               } else if(attendancedate==7 && totleave5!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave5=(tot_leave5-1)";
               } else if(attendancedate==8 && totleave6!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave6=(tot_leave6-1)";
               } else if(attendancedate==32 && totleave1!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave1=(tot_leave1-0.5)";
               } else if(attendancedate==42 && totleave2!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave2=(tot_leave2-0.5)";
               } else if(attendancedate==52 && totleave3!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave3=(tot_leave3-0.5)";
               } else if(attendancedate==62 && totleave4!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave4=(tot_leave4-0.5)";
               } else if(attendancedate==72 && totleave5!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave5=(tot_leave5-0.5)";
               } else if(attendancedate==82 && totleave6!=0) {
                   sqltotalsub=sqltotalsub+",tot_leave6=(tot_leave6-0.5)";
               }
           }
           
           if(marknewattendance==3) {
               sqltotaladd=sqltotaladd+",tot_leave1=(tot_leave1+1)";
           } else if(marknewattendance==4) {
               sqltotaladd=sqltotaladd+",tot_leave2=(tot_leave2+1)";
           } else if(marknewattendance==5) {
               sqltotaladd=sqltotaladd+",tot_leave3=(tot_leave3+1)";
           } else if(marknewattendance==6) {
               sqltotaladd=sqltotaladd+",tot_leave4=(tot_leave4+1)";
           } else if(marknewattendance==7) {
               sqltotaladd=sqltotaladd+",tot_leave5=(tot_leave5+1)";
           } else if(marknewattendance==8) {
               sqltotaladd=sqltotaladd+",tot_leave6=(tot_leave6+1)";
           } else if(marknewattendance==32) {
               sqltotaladd=sqltotaladd+",tot_leave1=(tot_leave1+0.5)";
           } else if(marknewattendance==42) {
               sqltotaladd=sqltotaladd+",tot_leave2=(tot_leave2+0.5)";
           } else if(marknewattendance==52) {
               sqltotaladd=sqltotaladd+",tot_leave3=(tot_leave3+0.5)";
           } else if(marknewattendance==62) {
               sqltotaladd=sqltotaladd+",tot_leave4=(tot_leave4+0.5)";
           } else if(marknewattendance==72) {
               sqltotaladd=sqltotaladd+",tot_leave5=(tot_leave5+0.5)";
           } else if(marknewattendance==82) {
               sqltotaladd=sqltotaladd+",tot_leave6=(tot_leave6+0.5)";
           }
           */
         //  String sql10="UPDATE hr_timesheet  SET date"+day+"="+marknewattendance+""+sqltotalsub+""+sqltotaladd+" WHERE payroll_processed=0 and empId="+empid+" and year=Year('"+sqlRequestedDate+"') and month=MONTH('"+sqlRequestedDate+"' "+sql444+")";
           String sql10="UPDATE hr_timesheet   m left join hr_empm e on e.doc_no=m.empid  left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) SET m.date"+day+"="+marknewattendance+""+sqltotalsub+""+sqltotaladd+" WHERE m.payroll_processed=0 and m.empId="+empid+" and m.year=Year('"+sqlRequestedDate+"') and m.month=MONTH('"+sqlRequestedDate+"') "+sql444+"  ";
           //   System.out.println("timesheet update-----"+sql10);
              int data21 = stmtBTSR6.executeUpdate(sql10);
               }   
          } 
       }  
           String sqlto="";
           if(!(cmbempcategory.equalsIgnoreCase("0")) && !(cmbempcategory.equalsIgnoreCase(""))){
               sqlto=sqlto+" and m.pay_catid='"+cmbempcategory+"'";
           }
           
           if(!(txtemployeedocno.equalsIgnoreCase("0")) && !(txtemployeedocno.equalsIgnoreCase(""))){
               sqlto=sqlto+" and m.doc_no='"+txtemployeedocno+"'";
           }
           
           
           
       /*    String sqltots = "select m.doc_no employeedocno,m.codeno employeeid,"
                   + "coalesce((if(s.doc_no=1,1,0)+if(s1.doc_no=1,1,0)+if(s2.doc_no=1,1,0)+if(s3.doc_no=1,1,0)+if (s4.doc_no=1,1,0)+if(s5.doc_no=1,1,0)+if(s6.doc_no=1,1,0)+if(s7.doc_no=1,1,0)+if(s8.doc_no=1,1,0) +if(s9.doc_no=1,1,0)+if(s10.doc_no=1,1,0)+if(s11.doc_no=1,1,0)+if(s12.doc_no=1,1,0)+if(s13.doc_no=1,1,0) +if(s14.doc_no=1,1,0)+if(s15.doc_no=1,1,0)+if(s16.doc_no=1,1,0)+if(s17.doc_no=1,1,0)+if(s18.doc_no=1,1,0) +if(s19.doc_no=1,1,0)+if(s20.doc_no=1,1,0)+if(s21.doc_no=1,1,0)+if(s22.doc_no=1,1,0)+if(s23.doc_no=1,1,0)+if(s24.doc_no=1,1,0)+if(s25.doc_no=1,1,0)+if(s26.doc_no=1,1,0)+if(s27.doc_no=1,1,0)+if(s28.doc_no=1,1,0)+ if(s29.doc_no=1,1,0)+if(s30.doc_no=1,1,0))+(if(s.refno=32,0.5,0)+if(s1.refno=32,0.5,0)+if(s2.refno=32,0.5,0)+if(s3.refno=32,0.5,0)+if (s4.refno=32,0.5,0)+if(s5.refno=32,0.5,0)+if(s6.refno=32,0.5,0)+if(s7.refno=32,0.5,0)+if(s8.refno=32,0.5,0) +if(s9.refno=32,0.5,0)+if(s10.refno=32,0.5,0)+if(s11.refno=32,0.5,0)+if(s12.refno=32,0.5,0)+if(s13.refno=32,0.5,0) +if(s14.refno=32,0.5,0)+if(s5.refno=32,0.5,0)+if(s16.refno=32,0.5,0)+if(s17.refno=32,0.5,0)+if(s18.refno=32,0.5,0) +if(s19.refno=32,0.5,0)+if(s20.refno=32,0.5,0)+if(s21.refno=32,0.5,0)+if(s22.refno=32,0.5,0)+if(s23.refno=32,0.5,0)+if(s24.refno=32,0.5,0)+if(s25.refno=32,0.5,0)+if(s26.refno=32,0.5,0)+if(s27.refno=32,0.5,0)+if(s28.refno=32,0.5,0)+ if(s29.refno=32,0.5,0)+if(s30.refno=32,0.5,0)),0) leave1total, "
                   + "coalesce((if(s.doc_no=2,1,0)+if(s1.doc_no=2,1,0)+if(s2.doc_no=2,1,0)+if(s3.doc_no=2,1,0)+if (s4.doc_no=2,1,0)+if(s5.doc_no=2,1,0)+if(s6.doc_no=2,1,0)+if(s7.doc_no=2,1,0)+if(s8.doc_no=2,1,0) +if(s9.doc_no=2,1,0)+if(s10.doc_no=2,1,0)+if(s11.doc_no=2,1,0)+if(s12.doc_no=2,1,0)+if(s13.doc_no=2,1,0) +if(s14.doc_no=2,1,0)+if(s15.doc_no=2,1,0)+if(s16.doc_no=2,1,0)+if(s17.doc_no=2,1,0)+if(s18.doc_no=2,1,0) +if(s19.doc_no=2,1,0)+if(s20.doc_no=2,1,0)+if(s21.doc_no=2,1,0)+if(s22.doc_no=2,1,0)+if(s23.doc_no=2,1,0)+if(s24.doc_no=2,1,0)+if(s25.doc_no=2,1,0)+if(s26.doc_no=2,1,0)+if(s27.doc_no=2,1,0)+if(s28.doc_no=2,1,0)+ if(s29.doc_no=2,1,0)+if(s30.doc_no=2,1,0))+(if(s.refno=42,0.5,0)+if(s1.refno=42,0.5,0)+if(s2.refno=42,0.5,0)+if(s3.refno=42,0.5,0)+if (s4.refno=42,0.5,0)+if(s5.refno=42,0.5,0)+if(s6.refno=42,0.5,0)+if(s7.refno=42,0.5,0)+if(s8.refno=42,0.5,0) +if(s9.refno=42,0.5,0)+if(s10.refno=42,0.5,0)+if(s11.refno=42,0.5,0)+if(s12.refno=42,0.5,0)+if(s13.refno=42,0.5,0) +if(s14.refno=42,0.5,0)+if(s5.refno=42,0.5,0)+if(s16.refno=42,0.5,0)+if(s17.refno=42,0.5,0)+if(s18.refno=42,0.5,0) +if(s19.refno=42,0.5,0)+if(s20.refno=42,0.5,0)+if(s21.refno=42,0.5,0)+if(s22.refno=42,0.5,0)+if(s23.refno=42,0.5,0)+if(s24.refno=42,0.5,0)+if(s25.refno=42,0.5,0)+if(s26.refno=42,0.5,0)+if(s27.refno=42,0.5,0)+if(s28.refno=42,0.5,0)+ if(s29.refno=42,0.5,0)+if(s30.refno=42,0.5,0)),0) leave2total, "
                   + "coalesce((if(s.doc_no=3,1,0)+if(s1.doc_no=3,1,0)+if(s2.doc_no=3,1,0)+if(s3.doc_no=3,1,0)+if (s4.doc_no=3,1,0)+if(s5.doc_no=3,1,0)+if(s6.doc_no=3,1,0)+if(s7.doc_no=3,1,0)+if(s8.doc_no=3,1,0) +if(s9.doc_no=3,1,0)+if(s10.doc_no=3,1,0)+if(s11.doc_no=3,1,0)+if(s12.doc_no=3,1,0)+if(s13.doc_no=3,1,0) +if(s14.doc_no=3,1,0)+if(s15.doc_no=3,1,0)+if(s16.doc_no=3,1,0)+if(s17.doc_no=3,1,0)+if(s18.doc_no=3,1,0) +if(s19.doc_no=3,1,0)+if(s20.doc_no=3,1,0)+if(s21.doc_no=3,1,0)+if(s22.doc_no=3,1,0)+if(s23.doc_no=3,1,0)+if(s24.doc_no=3,1,0)+if(s25.doc_no=3,1,0)+if(s26.doc_no=3,1,0)+if(s27.doc_no=3,1,0)+if(s28.doc_no=3,1,0)+ if(s29.doc_no=3,1,0)+if(s30.doc_no=3,1,0))+(if(s.refno=52,0.5,0)+if(s1.refno=52,0.5,0)+if(s2.refno=52,0.5,0)+if(s3.refno=52,0.5,0)+if (s4.refno=52,0.5,0)+if(s5.refno=52,0.5,0)+if(s6.refno=52,0.5,0)+if(s7.refno=52,0.5,0)+if(s8.refno=52,0.5,0) +if(s9.refno=52,0.5,0)+if(s10.refno=52,0.5,0)+if(s11.refno=52,0.5,0)+if(s12.refno=52,0.5,0)+if(s13.refno=52,0.5,0) +if(s14.refno=52,0.5,0)+if(s5.refno=52,0.5,0)+if(s16.refno=52,0.5,0)+if(s17.refno=52,0.5,0)+if(s18.refno=52,0.5,0) +if(s19.refno=52,0.5,0)+if(s20.refno=52,0.5,0)+if(s21.refno=52,0.5,0)+if(s22.refno=52,0.5,0)+if(s23.refno=52,0.5,0)+if(s24.refno=52,0.5,0)+if(s25.refno=52,0.5,0)+if(s26.refno=52,0.5,0)+if(s27.refno=52,0.5,0)+if(s28.refno=52,0.5,0)+ if(s29.refno=52,0.5,0)+if(s30.refno=52,0.5,0)),0) leave3total, "
                   + "coalesce((if(s.doc_no=4,1,0)+if(s1.doc_no=4,1,0)+if(s2.doc_no=4,1,0)+if(s3.doc_no=4,1,0)+if (s4.doc_no=4,1,0)+if(s5.doc_no=4,1,0)+if(s6.doc_no=4,1,0)+if(s7.doc_no=4,1,0)+if(s8.doc_no=4,1,0) +if(s9.doc_no=4,1,0)+if(s10.doc_no=4,1,0)+if(s11.doc_no=4,1,0)+if(s12.doc_no=4,1,0)+if(s13.doc_no=4,1,0) +if(s14.doc_no=4,1,0)+if(s15.doc_no=4,1,0)+if(s16.doc_no=4,1,0)+if(s17.doc_no=4,1,0)+if(s18.doc_no=4,1,0) +if(s19.doc_no=4,1,0)+if(s20.doc_no=4,1,0)+if(s21.doc_no=4,1,0)+if(s22.doc_no=4,1,0)+if(s23.doc_no=4,1,0)+if(s24.doc_no=4,1,0)+if(s25.doc_no=4,1,0)+if(s26.doc_no=4,1,0)+if(s27.doc_no=4,1,0)+if(s28.doc_no=4,1,0)+ if(s29.doc_no=4,1,0)+if(s30.doc_no=4,1,0))+(if(s.refno=62,0.5,0)+if(s1.refno=62,0.5,0)+if(s2.refno=62,0.5,0)+if(s3.refno=62,0.5,0)+if (s4.refno=62,0.5,0)+if(s5.refno=62,0.5,0)+if(s6.refno=62,0.5,0)+if(s7.refno=62,0.5,0)+if(s8.refno=62,0.5,0) +if(s9.refno=62,0.5,0)+if(s10.refno=62,0.5,0)+if(s11.refno=62,0.5,0)+if(s12.refno=62,0.5,0)+if(s13.refno=62,0.5,0) +if(s14.refno=62,0.5,0)+if(s5.refno=62,0.5,0)+if(s16.refno=62,0.5,0)+if(s17.refno=62,0.5,0)+if(s18.refno=62,0.5,0) +if(s19.refno=62,0.5,0)+if(s20.refno=62,0.5,0)+if(s21.refno=62,0.5,0)+if(s22.refno=62,0.5,0)+if(s23.refno=62,0.5,0)+if(s24.refno=62,0.5,0)+if(s25.refno=62,0.5,0)+if(s26.refno=62,0.5,0)+if(s27.refno=62,0.5,0)+if(s28.refno=62,0.5,0)+ if(s29.refno=62,0.5,0)+if(s30.refno=62,0.5,0)),0) leave4total, "
                   + "coalesce((if(s.doc_no=5,1,0)+if(s1.doc_no=5,1,0)+if(s2.doc_no=5,1,0)+if(s3.doc_no=5,1,0)+if (s4.doc_no=5,1,0)+if(s5.doc_no=5,1,0)+if(s6.doc_no=5,1,0)+if(s7.doc_no=5,1,0)+if(s8.doc_no=5,1,0) +if(s9.doc_no=5,1,0)+if(s10.doc_no=5,1,0)+if(s11.doc_no=5,1,0)+if(s12.doc_no=5,1,0)+if(s13.doc_no=5,1,0) +if(s14.doc_no=5,1,0)+if(s15.doc_no=5,1,0)+if(s16.doc_no=5,1,0)+if(s17.doc_no=5,1,0)+if(s18.doc_no=5,1,0) +if(s19.doc_no=5,1,0)+if(s20.doc_no=5,1,0)+if(s21.doc_no=5,1,0)+if(s22.doc_no=5,1,0)+if(s23.doc_no=5,1,0)+if(s24.doc_no=5,1,0)+if(s25.doc_no=5,1,0)+if(s26.doc_no=5,1,0)+if(s27.doc_no=5,1,0)+if(s28.doc_no=5,1,0)+ if(s29.doc_no=5,1,0)+if(s30.doc_no=5,1,0))+(if(s.refno=72,0.5,0)+if(s1.refno=72,0.5,0)+if(s2.refno=72,0.5,0)+if(s3.refno=72,0.5,0)+if (s4.refno=72,0.5,0)+if(s5.refno=72,0.5,0)+if(s6.refno=72,0.5,0)+if(s7.refno=72,0.5,0)+if(s8.refno=72,0.5,0) +if(s9.refno=72,0.5,0)+if(s10.refno=72,0.5,0)+if(s11.refno=72,0.5,0)+if(s12.refno=72,0.5,0)+if(s13.refno=72,0.5,0) +if(s14.refno=72,0.5,0)+if(s5.refno=72,0.5,0)+if(s16.refno=72,0.5,0)+if(s17.refno=72,0.5,0)+if(s18.refno=72,0.5,0) +if(s19.refno=72,0.5,0)+if(s20.refno=72,0.5,0)+if(s21.refno=72,0.5,0)+if(s22.refno=72,0.5,0)+if(s23.refno=72,0.5,0)+if(s24.refno=72,0.5,0)+if(s25.refno=72,0.5,0)+if(s26.refno=72,0.5,0)+if(s27.refno=72,0.5,0)+if(s28.refno=72,0.5,0)+ if(s29.refno=72,0.5,0)+if(s30.refno=72,0.5,0)),0) leave5total, "
                   + "coalesce((if(s.doc_no=6,1,0)+if(s1.doc_no=6,1,0)+if(s2.doc_no=6,1,0)+if(s3.doc_no=6,1,0)+if (s4.doc_no=6,1,0)+if(s5.doc_no=6,1,0)+if(s6.doc_no=6,1,0)+if(s7.doc_no=6,1,0)+if(s8.doc_no=6,1,0) +if(s9.doc_no=6,1,0)+if(s10.doc_no=6,1,0)+if(s11.doc_no=6,1,0)+if(s12.doc_no=6,1,0)+if(s13.doc_no=6,1,0) +if(s14.doc_no=6,1,0)+if(s15.doc_no=6,1,0)+if(s16.doc_no=6,1,0)+if(s17.doc_no=6,1,0)+if(s18.doc_no=6,1,0) +if(s19.doc_no=6,1,0)+if(s20.doc_no=6,1,0)+if(s21.doc_no=6,1,0)+if(s22.doc_no=6,1,0)+if(s23.doc_no=6,1,0)+if(s24.doc_no=6,1,0)+if(s25.doc_no=6,1,0)+if(s26.doc_no=6,1,0)+if(s27.doc_no=6,1,0)+if(s28.doc_no=6,1,0)+ if(s29.doc_no=6,1,0)+if(s30.doc_no=6,1,0))+(if(s.refno=82,0.5,0)+if(s1.refno=82,0.5,0)+if(s2.refno=82,0.5,0)+if(s3.refno=82,0.5,0)+if (s4.refno=82,0.5,0)+if(s5.refno=82,0.5,0)+if(s6.refno=82,0.5,0)+if(s7.refno=82,0.5,0)+if(s8.refno=82,0.5,0) +if(s9.refno=82,0.5,0)+if(s10.refno=82,0.5,0)+if(s11.refno=82,0.5,0)+if(s12.refno=82,0.5,0)+if(s13.refno=82,0.5,0) +if(s14.refno=82,0.5,0)+if(s5.refno=82,0.5,0)+if(s16.refno=82,0.5,0)+if(s17.refno=82,0.5,0)+if(s18.refno=82,0.5,0) +if(s19.refno=82,0.5,0)+if(s20.refno=82,0.5,0)+if(s21.refno=82,0.5,0)+if(s22.refno=82,0.5,0)+if(s23.refno=82,0.5,0)+if(s24.refno=82,0.5,0)+if(s25.refno=82,0.5,0)+if(s26.refno=82,0.5,0)+if(s27.refno=82,0.5,0)+if(s28.refno=82,0.5,0)+ if(s29.refno=82,0.5,0)+if(s30.refno=82,0.5,0)),0) leave6total, " 
                   + "coalesce((if(s.doc_no=7,1,0)+if(s1.doc_no=7,1,0)+if(s2.doc_no=7,1,0)+if(s3.doc_no=7,1,0)+if (s4.doc_no=7,1,0)+if(s5.doc_no=7,1,0)+if(s6.doc_no=7,1,0)+if(s7.doc_no=7,1,0)+if(s8.doc_no=7,1,0) +if(s9.doc_no=7,1,0)+if(s10.doc_no=7,1,0)+if(s11.doc_no=7,1,0)+if(s12.doc_no=7,1,0)+if(s13.doc_no=7,1,0) +if(s14.doc_no=7,1,0)+if(s15.doc_no=7,1,0)+if(s16.doc_no=7,1,0)+if(s17.doc_no=7,1,0)+if(s18.doc_no=7,1,0) +if(s19.doc_no=7,1,0)+if(s20.doc_no=7,1,0)+if(s21.doc_no=7,1,0)+if(s22.doc_no=7,1,0)+if(s23.doc_no=7,1,0)+if(s24.doc_no=7,1,0)+if(s25.doc_no=7,1,0)+if(s26.doc_no=7,1,0)+if(s27.doc_no=7,1,0)+if(s28.doc_no=7,1,0)+ if(s29.doc_no=7,1,0)+if(s30.doc_no=7,1,0))+(if(s.refno=102,0.5,0)+if(s1.refno=102,0.5,0)+if(s2.refno=102,0.5,0)+if(s3.refno=102,0.5,0)+if (s4.refno=102,0.5,0)+if(s5.refno=102,0.5,0)+if(s6.refno=102,0.5,0)+if(s7.refno=102,0.5,0)+if(s8.refno=102,0.5,0) +if(s9.refno=102,0.5,0)+if(s10.refno=102,0.5,0)+if(s11.refno=102,0.5,0)+if(s12.refno=102,0.5,0)+if(s13.refno=102,0.5,0) +if(s14.refno=102,0.5,0)+if(s5.refno=102,0.5,0)+if(s16.refno=102,0.5,0)+if(s17.refno=102,0.5,0)+if(s18.refno=102,0.5,0) +if(s19.refno=102,0.5,0)+if(s20.refno=102,0.5,0)+if(s21.refno=102,0.5,0)+if(s22.refno=102,0.5,0)+if(s23.refno=102,0.5,0)+if(s24.refno=102,0.5,0)+if(s25.refno=102,0.5,0)+if(s26.refno=102,0.5,0)+if(s27.refno=102,0.5,0)+if(s28.refno=102,0.5,0)+ if(s29.refno=102,0.5,0)+if(s30.refno=102,0.5,0)),0) leave7total "
                   + "from "
                   + "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+cmbyear+"' and t.month='"+cmbmonth+"' left join hr_timesheetset s on s.refno=t.date1 "
                   + "left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 "
                   + "left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 " 
                   + "left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 "
                   + "left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on "
                   + "s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset "
                   + "s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join "
                   + "hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 "
                   + "left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 "
                   + "left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 "  
                   + "left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 "
                   + "left join hr_timesheetset s30 on s30.refno=t.date31  left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) where m.status=3 and m.dtjoin<=LAST_DAY('"+cmbyear+"-"+cmbmonth+"-01') "+sqlto+"order by CAST(m.codeno  AS UNSIGNED)";  
          System.out.println("totselect-------"+sqltots);
           ResultSet rstot = stmtBTSR6.executeQuery(sqltots);
           int employeedocno=0,employeeid=0;
           String leave1total="",leave2total="",leave3total="",leave4total="",leave5total="",leave6total="",leave7total="";
           while (rstot.next()) {
               employeedocno=rstot.getInt("employeedocno");
               employeeid=rstot.getInt("employeeid");
               leave1total=rstot.getString("leave1total");
               leave2total=rstot.getString("leave2total");
               leave3total=rstot.getString("leave3total");
               leave4total=rstot.getString("leave4total");
               leave5total=rstot.getString("leave5total");
               leave6total=rstot.getString("leave6total");
               leave7total=rstot.getString("leave7total");
               
             String sqlupdate="UPDATE hr_timesheet SET tot_leave1="+leave1total+",tot_leave2="+leave2total+",tot_leave3="+leave3total+",tot_leave4="+leave4total+",tot_leave5="+leave5total+",tot_leave6="+leave6total+",tot_leave7="+leave7total+" WHERE payroll_processed=0 and empId="+employeeid+" and year="+cmbyear+" and month="+cmbmonth+"";
            System.out.println("sqlupdate---------"+sqlupdate);
             ResultSet rsup = stmtBTSR6.executeQuery(sqlupdate);
             }*/
               
             String sqlupdate=" update hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+cmbyear+"' and t.month='"+cmbmonth+"' left join hr_timesheetset s on s.refno=t.date1 left join hr_timesheetset s1 on s1.refno=t.date2 left join hr_timesheetset s2 on s2.refno=t.date3 left join hr_timesheetset s3 on s3.refno=t.date4 left join hr_timesheetset s4 on s4.refno=t.date5 left join hr_timesheetset s5 on s5.refno=t.date6 left join hr_timesheetset s6 on s6.refno=t.date7 left join hr_timesheetset s7 on s7.refno=t.date8 left join hr_timesheetset s8 on s8.refno=t.date9 left join hr_timesheetset s9 on s9.refno=t.date10 left join hr_timesheetset s10 on s10.refno=t.date11 left join hr_timesheetset s11 on s11.refno=t.date12 left join hr_timesheetset s12 on s12.refno=t.date13 left join hr_timesheetset s13 on s13.refno=t.date14 left join hr_timesheetset s14 on s14.refno=t.date15 left join hr_timesheetset s15 on s15.refno=t.date16 left join hr_timesheetset s16 on s16.refno=t.date17 left join hr_timesheetset s17 on s17.refno=t.date18 left join hr_timesheetset s18 on s18.refno=t.date19 left join hr_timesheetset s19 on s19.refno=t.date20 left join hr_timesheetset s20 on s20.refno=t.date21 left join hr_timesheetset s21 on s21.refno=t.date22 left join hr_timesheetset s22 on s22.refno=t.date23 left join hr_timesheetset s23 on s23.refno=t.date24 left join hr_timesheetset s24 on s24.refno=t.date25 left join hr_timesheetset s25 on s25.refno=t.date26 left join hr_timesheetset s26 on s26.refno=t.date27 left join hr_timesheetset s27 on s27.refno=t.date28 left join hr_timesheetset s28 on s28.refno=t.date29 left join hr_timesheetset s29 on s29.refno=t.date30 left join hr_timesheetset s30 on s30.refno=t.date31 left join hr_paycode c on (m.pay_catid=c.catid and c.status=3) "
                     + "set tot_leave1=coalesce((if(s.doc_no=1,1,0)+if(s1.doc_no=1,1,0)+if(s2.doc_no=1,1,0)+if(s3.doc_no=1,1,0)+if (s4.doc_no=1,1,0)+if(s5.doc_no=1,1,0)+if(s6.doc_no=1,1,0)+if(s7.doc_no=1,1,0)+if(s8.doc_no=1,1,0) +if(s9.doc_no=1,1,0)+if(s10.doc_no=1,1,0)+if(s11.doc_no=1,1,0)+if(s12.doc_no=1,1,0)+if(s13.doc_no=1,1,0) +if(s14.doc_no=1,1,0)+if(s15.doc_no=1,1,0)+if(s16.doc_no=1,1,0)+if(s17.doc_no=1,1,0)+if(s18.doc_no=1,1,0) +if(s19.doc_no=1,1,0)+if(s20.doc_no=1,1,0)+if(s21.doc_no=1,1,0)+if(s22.doc_no=1,1,0)+if(s23.doc_no=1,1,0)+if(s24.doc_no=1,1,0)+if(s25.doc_no=1,1,0)+if(s26.doc_no=1,1,0)+if(s27.doc_no=1,1,0)+if(s28.doc_no=1,1,0)+ if(s29.doc_no=1,1,0)+if(s30.doc_no=1,1,0))+(if(s.refno=32,0.5,0)+if(s1.refno=32,0.5,0)+if(s2.refno=32,0.5,0)+if(s3.refno=32,0.5,0)+if (s4.refno=32,0.5,0)+if(s5.refno=32,0.5,0)+if(s6.refno=32,0.5,0)+if(s7.refno=32,0.5,0)+if(s8.refno=32,0.5,0) +if(s9.refno=32,0.5,0)+if(s10.refno=32,0.5,0)+if(s11.refno=32,0.5,0)+if(s12.refno=32,0.5,0)+if(s13.refno=32,0.5,0) +if(s14.refno=32,0.5,0)+if(s5.refno=32,0.5,0)+if(s16.refno=32,0.5,0)+if(s17.refno=32,0.5,0)+if(s18.refno=32,0.5,0) +if(s19.refno=32,0.5,0)+if(s20.refno=32,0.5,0)+if(s21.refno=32,0.5,0)+if(s22.refno=32,0.5,0)+if(s23.refno=32,0.5,0)+if(s24.refno=32,0.5,0)+if(s25.refno=32,0.5,0)+if(s26.refno=32,0.5,0)+if(s27.refno=32,0.5,0)+if(s28.refno=32,0.5,0)+ if(s29.refno=32,0.5,0)+if(s30.refno=32,0.5,0)),0), "
                     + "tot_leave2=coalesce((if(s.doc_no=2,1,0)+if(s1.doc_no=2,1,0)+if(s2.doc_no=2,1,0)+if(s3.doc_no=2,1,0)+if (s4.doc_no=2,1,0)+if(s5.doc_no=2,1,0)+if(s6.doc_no=2,1,0)+if(s7.doc_no=2,1,0)+if(s8.doc_no=2,1,0) +if(s9.doc_no=2,1,0)+if(s10.doc_no=2,1,0)+if(s11.doc_no=2,1,0)+if(s12.doc_no=2,1,0)+if(s13.doc_no=2,1,0) +if(s14.doc_no=2,1,0)+if(s15.doc_no=2,1,0)+if(s16.doc_no=2,1,0)+if(s17.doc_no=2,1,0)+if(s18.doc_no=2,1,0) +if(s19.doc_no=2,1,0)+if(s20.doc_no=2,1,0)+if(s21.doc_no=2,1,0)+if(s22.doc_no=2,1,0)+if(s23.doc_no=2,1,0)+if(s24.doc_no=2,1,0)+if(s25.doc_no=2,1,0)+if(s26.doc_no=2,1,0)+if(s27.doc_no=2,1,0)+if(s28.doc_no=2,1,0)+ if(s29.doc_no=2,1,0)+if(s30.doc_no=2,1,0))+(if(s.refno=42,0.5,0)+if(s1.refno=42,0.5,0)+if(s2.refno=42,0.5,0)+if(s3.refno=42,0.5,0)+if (s4.refno=42,0.5,0)+if(s5.refno=42,0.5,0)+if(s6.refno=42,0.5,0)+if(s7.refno=42,0.5,0)+if(s8.refno=42,0.5,0) +if(s9.refno=42,0.5,0)+if(s10.refno=42,0.5,0)+if(s11.refno=42,0.5,0)+if(s12.refno=42,0.5,0)+if(s13.refno=42,0.5,0) +if(s14.refno=42,0.5,0)+if(s5.refno=42,0.5,0)+if(s16.refno=42,0.5,0)+if(s17.refno=42,0.5,0)+if(s18.refno=42,0.5,0) +if(s19.refno=42,0.5,0)+if(s20.refno=42,0.5,0)+if(s21.refno=42,0.5,0)+if(s22.refno=42,0.5,0)+if(s23.refno=42,0.5,0)+if(s24.refno=42,0.5,0)+if(s25.refno=42,0.5,0)+if(s26.refno=42,0.5,0)+if(s27.refno=42,0.5,0)+if(s28.refno=42,0.5,0)+ if(s29.refno=42,0.5,0)+if(s30.refno=42,0.5,0)),0), "
                     + "tot_leave3=coalesce((if(s.doc_no=3,1,0)+if(s1.doc_no=3,1,0)+if(s2.doc_no=3,1,0)+if(s3.doc_no=3,1,0)+if (s4.doc_no=3,1,0)+if(s5.doc_no=3,1,0)+if(s6.doc_no=3,1,0)+if(s7.doc_no=3,1,0)+if(s8.doc_no=3,1,0) +if(s9.doc_no=3,1,0)+if(s10.doc_no=3,1,0)+if(s11.doc_no=3,1,0)+if(s12.doc_no=3,1,0)+if(s13.doc_no=3,1,0) +if(s14.doc_no=3,1,0)+if(s15.doc_no=3,1,0)+if(s16.doc_no=3,1,0)+if(s17.doc_no=3,1,0)+if(s18.doc_no=3,1,0) +if(s19.doc_no=3,1,0)+if(s20.doc_no=3,1,0)+if(s21.doc_no=3,1,0)+if(s22.doc_no=3,1,0)+if(s23.doc_no=3,1,0)+if(s24.doc_no=3,1,0)+if(s25.doc_no=3,1,0)+if(s26.doc_no=3,1,0)+if(s27.doc_no=3,1,0)+if(s28.doc_no=3,1,0)+ if(s29.doc_no=3,1,0)+if(s30.doc_no=3,1,0))+(if(s.refno=52,0.5,0)+if(s1.refno=52,0.5,0)+if(s2.refno=52,0.5,0)+if(s3.refno=52,0.5,0)+if (s4.refno=52,0.5,0)+if(s5.refno=52,0.5,0)+if(s6.refno=52,0.5,0)+if(s7.refno=52,0.5,0)+if(s8.refno=52,0.5,0) +if(s9.refno=52,0.5,0)+if(s10.refno=52,0.5,0)+if(s11.refno=52,0.5,0)+if(s12.refno=52,0.5,0)+if(s13.refno=52,0.5,0) +if(s14.refno=52,0.5,0)+if(s5.refno=52,0.5,0)+if(s16.refno=52,0.5,0)+if(s17.refno=52,0.5,0)+if(s18.refno=52,0.5,0) +if(s19.refno=52,0.5,0)+if(s20.refno=52,0.5,0)+if(s21.refno=52,0.5,0)+if(s22.refno=52,0.5,0)+if(s23.refno=52,0.5,0)+if(s24.refno=52,0.5,0)+if(s25.refno=52,0.5,0)+if(s26.refno=52,0.5,0)+if(s27.refno=52,0.5,0)+if(s28.refno=52,0.5,0)+ if(s29.refno=52,0.5,0)+if(s30.refno=52,0.5,0)),0) , "
                     + "tot_leave4=coalesce((if(s.doc_no=4,1,0)+if(s1.doc_no=4,1,0)+if(s2.doc_no=4,1,0)+if(s3.doc_no=4,1,0)+if (s4.doc_no=4,1,0)+if(s5.doc_no=4,1,0)+if(s6.doc_no=4,1,0)+if(s7.doc_no=4,1,0)+if(s8.doc_no=4,1,0) +if(s9.doc_no=4,1,0)+if(s10.doc_no=4,1,0)+if(s11.doc_no=4,1,0)+if(s12.doc_no=4,1,0)+if(s13.doc_no=4,1,0) +if(s14.doc_no=4,1,0)+if(s15.doc_no=4,1,0)+if(s16.doc_no=4,1,0)+if(s17.doc_no=4,1,0)+if(s18.doc_no=4,1,0) +if(s19.doc_no=4,1,0)+if(s20.doc_no=4,1,0)+if(s21.doc_no=4,1,0)+if(s22.doc_no=4,1,0)+if(s23.doc_no=4,1,0)+if(s24.doc_no=4,1,0)+if(s25.doc_no=4,1,0)+if(s26.doc_no=4,1,0)+if(s27.doc_no=4,1,0)+if(s28.doc_no=4,1,0)+ if(s29.doc_no=4,1,0)+if(s30.doc_no=4,1,0))+(if(s.refno=62,0.5,0)+if(s1.refno=62,0.5,0)+if(s2.refno=62,0.5,0)+if(s3.refno=62,0.5,0)+if (s4.refno=62,0.5,0)+if(s5.refno=62,0.5,0)+if(s6.refno=62,0.5,0)+if(s7.refno=62,0.5,0)+if(s8.refno=62,0.5,0) +if(s9.refno=62,0.5,0)+if(s10.refno=62,0.5,0)+if(s11.refno=62,0.5,0)+if(s12.refno=62,0.5,0)+if(s13.refno=62,0.5,0) +if(s14.refno=62,0.5,0)+if(s5.refno=62,0.5,0)+if(s16.refno=62,0.5,0)+if(s17.refno=62,0.5,0)+if(s18.refno=62,0.5,0) +if(s19.refno=62,0.5,0)+if(s20.refno=62,0.5,0)+if(s21.refno=62,0.5,0)+if(s22.refno=62,0.5,0)+if(s23.refno=62,0.5,0)+if(s24.refno=62,0.5,0)+if(s25.refno=62,0.5,0)+if(s26.refno=62,0.5,0)+if(s27.refno=62,0.5,0)+if(s28.refno=62,0.5,0)+ if(s29.refno=62,0.5,0)+if(s30.refno=62,0.5,0)),0), "
                     + "tot_leave5=coalesce((if(s.doc_no=5,1,0)+if(s1.doc_no=5,1,0)+if(s2.doc_no=5,1,0)+if(s3.doc_no=5,1,0)+if (s4.doc_no=5,1,0)+if(s5.doc_no=5,1,0)+if(s6.doc_no=5,1,0)+if(s7.doc_no=5,1,0)+if(s8.doc_no=5,1,0) +if(s9.doc_no=5,1,0)+if(s10.doc_no=5,1,0)+if(s11.doc_no=5,1,0)+if(s12.doc_no=5,1,0)+if(s13.doc_no=5,1,0) +if(s14.doc_no=5,1,0)+if(s15.doc_no=5,1,0)+if(s16.doc_no=5,1,0)+if(s17.doc_no=5,1,0)+if(s18.doc_no=5,1,0) +if(s19.doc_no=5,1,0)+if(s20.doc_no=5,1,0)+if(s21.doc_no=5,1,0)+if(s22.doc_no=5,1,0)+if(s23.doc_no=5,1,0)+if(s24.doc_no=5,1,0)+if(s25.doc_no=5,1,0)+if(s26.doc_no=5,1,0)+if(s27.doc_no=5,1,0)+if(s28.doc_no=5,1,0)+ if(s29.doc_no=5,1,0)+if(s30.doc_no=5,1,0))+(if(s.refno=72,0.5,0)+if(s1.refno=72,0.5,0)+if(s2.refno=72,0.5,0)+if(s3.refno=72,0.5,0)+if (s4.refno=72,0.5,0)+if(s5.refno=72,0.5,0)+if(s6.refno=72,0.5,0)+if(s7.refno=72,0.5,0)+if(s8.refno=72,0.5,0) +if(s9.refno=72,0.5,0)+if(s10.refno=72,0.5,0)+if(s11.refno=72,0.5,0)+if(s12.refno=72,0.5,0)+if(s13.refno=72,0.5,0) +if(s14.refno=72,0.5,0)+if(s5.refno=72,0.5,0)+if(s16.refno=72,0.5,0)+if(s17.refno=72,0.5,0)+if(s18.refno=72,0.5,0) +if(s19.refno=72,0.5,0)+if(s20.refno=72,0.5,0)+if(s21.refno=72,0.5,0)+if(s22.refno=72,0.5,0)+if(s23.refno=72,0.5,0)+if(s24.refno=72,0.5,0)+if(s25.refno=72,0.5,0)+if(s26.refno=72,0.5,0)+if(s27.refno=72,0.5,0)+if(s28.refno=72,0.5,0)+ if(s29.refno=72,0.5,0)+if(s30.refno=72,0.5,0)),0), "
                     + "tot_leave6=coalesce((if(s.doc_no=6,1,0)+if(s1.doc_no=6,1,0)+if(s2.doc_no=6,1,0)+if(s3.doc_no=6,1,0)+if (s4.doc_no=6,1,0)+if(s5.doc_no=6,1,0)+if(s6.doc_no=6,1,0)+if(s7.doc_no=6,1,0)+if(s8.doc_no=6,1,0) +if(s9.doc_no=6,1,0)+if(s10.doc_no=6,1,0)+if(s11.doc_no=6,1,0)+if(s12.doc_no=6,1,0)+if(s13.doc_no=6,1,0) +if(s14.doc_no=6,1,0)+if(s15.doc_no=6,1,0)+if(s16.doc_no=6,1,0)+if(s17.doc_no=6,1,0)+if(s18.doc_no=6,1,0) +if(s19.doc_no=6,1,0)+if(s20.doc_no=6,1,0)+if(s21.doc_no=6,1,0)+if(s22.doc_no=6,1,0)+if(s23.doc_no=6,1,0)+if(s24.doc_no=6,1,0)+if(s25.doc_no=6,1,0)+if(s26.doc_no=6,1,0)+if(s27.doc_no=6,1,0)+if(s28.doc_no=6,1,0)+ if(s29.doc_no=6,1,0)+if(s30.doc_no=6,1,0))+(if(s.refno=82,0.5,0)+if(s1.refno=82,0.5,0)+if(s2.refno=82,0.5,0)+if(s3.refno=82,0.5,0)+if (s4.refno=82,0.5,0)+if(s5.refno=82,0.5,0)+if(s6.refno=82,0.5,0)+if(s7.refno=82,0.5,0)+if(s8.refno=82,0.5,0) +if(s9.refno=82,0.5,0)+if(s10.refno=82,0.5,0)+if(s11.refno=82,0.5,0)+if(s12.refno=82,0.5,0)+if(s13.refno=82,0.5,0) +if(s14.refno=82,0.5,0)+if(s5.refno=82,0.5,0)+if(s16.refno=82,0.5,0)+if(s17.refno=82,0.5,0)+if(s18.refno=82,0.5,0) +if(s19.refno=82,0.5,0)+if(s20.refno=82,0.5,0)+if(s21.refno=82,0.5,0)+if(s22.refno=82,0.5,0)+if(s23.refno=82,0.5,0)+if(s24.refno=82,0.5,0)+if(s25.refno=82,0.5,0)+if(s26.refno=82,0.5,0)+if(s27.refno=82,0.5,0)+if(s28.refno=82,0.5,0)+ if(s29.refno=82,0.5,0)+if(s30.refno=82,0.5,0)),0), "
                     + "tot_leave7=coalesce((if(s.doc_no=7,1,0)+if(s1.doc_no=7,1,0)+if(s2.doc_no=7,1,0)+if(s3.doc_no=7,1,0)+if (s4.doc_no=7,1,0)+if(s5.doc_no=7,1,0)+if(s6.doc_no=7,1,0)+if(s7.doc_no=7,1,0)+if(s8.doc_no=7,1,0) +if(s9.doc_no=7,1,0)+if(s10.doc_no=7,1,0)+if(s11.doc_no=7,1,0)+if(s12.doc_no=7,1,0)+if(s13.doc_no=7,1,0) +if(s14.doc_no=7,1,0)+if(s15.doc_no=7,1,0)+if(s16.doc_no=7,1,0)+if(s17.doc_no=7,1,0)+if(s18.doc_no=7,1,0) +if(s19.doc_no=7,1,0)+if(s20.doc_no=7,1,0)+if(s21.doc_no=7,1,0)+if(s22.doc_no=7,1,0)+if(s23.doc_no=7,1,0)+if(s24.doc_no=7,1,0)+if(s25.doc_no=7,1,0)+if(s26.doc_no=7,1,0)+if(s27.doc_no=7,1,0)+if(s28.doc_no=7,1,0)+ if(s29.doc_no=7,1,0)+if(s30.doc_no=7,1,0))+(if(s.refno=102,0.5,0)+if(s1.refno=102,0.5,0)+if(s2.refno=102,0.5,0)+if(s3.refno=102,0.5,0)+if (s4.refno=102,0.5,0)+if(s5.refno=102,0.5,0)+if(s6.refno=102,0.5,0)+if(s7.refno=102,0.5,0)+if(s8.refno=102,0.5,0) +if(s9.refno=102,0.5,0)+if(s10.refno=102,0.5,0)+if(s11.refno=102,0.5,0)+if(s12.refno=102,0.5,0)+if(s13.refno=102,0.5,0) +if(s14.refno=102,0.5,0)+if(s5.refno=102,0.5,0)+if(s16.refno=102,0.5,0)+if(s17.refno=102,0.5,0)+if(s18.refno=102,0.5,0) +if(s19.refno=102,0.5,0)+if(s20.refno=102,0.5,0)+if(s21.refno=102,0.5,0)+if(s22.refno=102,0.5,0)+if(s23.refno=102,0.5,0)+if(s24.refno=102,0.5,0)+if(s25.refno=102,0.5,0)+if(s26.refno=102,0.5,0)+if(s27.refno=102,0.5,0)+if(s28.refno=102,0.5,0)+ if(s29.refno=102,0.5,0)+if(s30.refno=102,0.5,0)),0) "
                     + "where m.status=3 "+sqlto+" "; 
            // System.out.println("sqlupdate---------"+sqlupdate);
             int rsup = stmtBTSR6.executeUpdate(sqlupdate);
               
               
          
           
           
           String sql101="select coalesce(max(doc_no)+1,1) doc_no from hr_btsr";
		     ResultSet resultSet10 = stmtBTSR6.executeQuery(sql101);
		  
		     while (resultSet10.next()) {
		    	  docno=resultSet10.getInt("doc_no");
		    	  
		     }
		     
		     
		     /*Updating hr_timesheethrs*/
		   //  String sql11="UPDATE hr_timesheethrs SET confirm=1 WHERE status=3 and confirm=0 and MONTH(date)='"+cmbmonth+"' and YEAR(date)='"+cmbyear+"' ";
		     String sql11="UPDATE hr_timesheethrs m left join hr_empm e on e.doc_no=m.empid and m.status=3 left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) SET confirm=1 WHERE m.status=3 and m.confirm=0 and MONTH(m.date)='"+cmbmonth+"' and YEAR(m.date)='"+cmbyear+"' "+sql444+" ";
	           
		    // System.out.println("==== confirrm 1 == "+sql11);
		     int data1= stmtBTSR6.executeUpdate(sql11);
			 if(data1<=0){
			     stmtBTSR6.close();
					conn.close();
					return 0;
				}
			 /*Updating hr_timesheethrs Ends*/
			 
			/*Inserting hr_btsr*/
		     String sql12="insert into hr_btsr(doc_no, date, employeeIds, brhid, userid) values("+docno+",now(),'"+selectedemployees+"',"+branch+","+userid+")";
		  // System.out.println("bstr insert------"+sql12);
		     int data2= stmtBTSR6.executeUpdate(sql12);
			 if(data2<=0){
			     stmtBTSR6.close();
					conn.close();
					return 0;
				}
			 /*Inserting hr_btsr Ends*/
				 
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BTSR',now(),'"+userid+"','E')";
			//System.out.println("biblog insert-------"+sqls);
			int datas= stmtBTSR6.executeUpdate(sqls);
			 if(datas<=0){
			     stmtBTSR6.close();
				    conn.close();
					return 0;
				}
			
			 conn.commit();
			 stmtBTSR1.close();
			 stmtBTSR2.close();
			 stmtBTSR3.close();
			 stmtBTSR4.close();
			 stmtBTSR5.close();
			 stmtBTSR6.close();
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
	
	public JSONArray timeSheetReviewGridLoading(String year, String month, String date, String category, String employee, String projecttype, String projectid, String orderbydate,
		String orderbyemployee, String orderbycosttype, String orderbycostid, String rptType, String check) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
	    Connection conn=null;
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBTSR = conn.createStatement();
			
		        java.sql.Date sqlDate=null;
	    	    
		        date.trim();
	            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	            {
	        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
	            }
		        
		        String sql = "",sql1="",sql2="",sql3="",sql4="",sql5="";
				
	    	    if(!(year.equalsIgnoreCase("0")) && !(year.equalsIgnoreCase(""))){
		            sql1=sql1+" and YEAR(m.date)='"+year+"'";
		        }
	    	    
	    	    if(!(month.equalsIgnoreCase("0")) && !(month.equalsIgnoreCase(""))){
		            sql1=sql1+" and MONTH(m.date)='"+month+"'";
		        }
	    	    
	    	    if(sqlDate!=null){
	    	    	sql2=sql2+" and date='"+sqlDate+"'";
	    	    	sql3=sql3+" and m.date='"+sqlDate+"'";
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
	    	    	
	    	    	/*sql = "select a.date,r.empdocno,r.empid,r.empname,if(a.date=r.date,r.costgroup,'') costgroup,if(a.date=r.date,r.costtype,'') costtype,if(a.date=r.date,r.costcodename,'') costcodename," 
	    	    		+ "if(a.date=r.date,r.costcode,'') costcode,if(a.date=r.date,r.normal,0) normal,if(a.date=r.date,r.hrs,'') hrs,if(a.date=r.date,r.ot,0) ot,if(a.date=r.date,r.othrs,'') othrs," 
	    	    		+ "if(a.date=r.date,r.hot,0) hot,if(a.date=r.date,r.hothrs,'') hothrs,if(a.date=r.date,r.normalhrs,'') normalhrs,if(a.date=r.date,r.overtimehrs,'') overtimehrs,"
	    	    		+ "if(a.date=r.date,r.holidayovertimehrs,'') holidayovertimehrs,if(a.date=r.date,r.editbtn,'ADD') editbtn,if(a.date=r.date,'0','1') confirm from ( "
	    	    		
	    	    		+ "select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+year+"-"+month+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from ("
	    	    		+ "select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all "
	    	    		+ "select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all "
	    	    		+ "select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all "  
	    	    		+ "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+year+"-"+month+"-01') and YEAR(date)=YEAR('"+year+"-"+month+"-01')"+sql2+") a,"  
	    	    		
	    	    		+"(select m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costtype END,CHAR(1000)) AS costcodename,"
	    	    		+ "m.costcode,sum(m.normal) normal,CONVERT(if(round(sum(m.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,6))),CHAR(100)) hrs,"
	    	    		+ "sum(m.ot) ot,CONVERT(if(round(sum(m.ot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.ot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,6))),CHAR(100)) othrs,"
	    	    		+ "sum(m.hot) hot,CONVERT(if(round(sum(m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.hot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,6))),CHAR(100)) hothrs,"
	    	    		+ "m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on m.costtype=f.costtype "
	    	    		+ "left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3 and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+""+sql4+" "
	    	    		+ "group by m.date,m.empid) r group by a.date,r.empid UNION ALL " 
	    	    			
	    	    		+ "select a.date,s.* from ( select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+year+"-"+month+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from ("
	    	    		+ "select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all "
	    	    		+ "select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all "
	    	    		+ "select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all select 4 union all "
	    	    		+ "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all "  
	    	    		+ "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+year+"-"+month+"-01') and YEAR(date)=YEAR('"+year+"-"+month+"-01')"+sql2+") a,"  
	    	    			
	    	    		+"(select e.doc_no empdocno,e.codeno empid,e.name empname,'' costgroup,'' costtype,'' costcodename,'' costcode,0 normal,'' hrs,0 ot,'' othrs,0 hot,'' hothrs,'' normalhrs,'' overtimehrs,'' holidayovertimehrs,'' editbtn,'1' confirm from "
	    	    		+ "hr_empm e left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) left join hr_timesheethrs m on (e.doc_no=m.empid and m.status=3 and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+") " 
	    	    		+ "where e.active=1 and e.status=3 and c.timesheet=1"+sql4+" and m.empid is null) s order by empdocno";*/
	    	    	
	    	    	
	    	    	/*sql = "select CONVERT(a.date,CHAR(500)) date, a.empdocno, a.empid, a.empname, a.costgroup, a.costtype, a.costcodename, a.costcode, a.normal, a.hrs, a.ot, a.othrs, a.hot,a.hothrs, a.normalhrs, a.overtimehrs, "
	    	    		+ "a.holidayovertimehrs, a.editbtn, a.confirm from ( "
	    	    		+ "select m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costtype END,CHAR(1000)) AS costcodename,"
	    	    		+ "m.costcode,sum(m.normal) normal,CONVERT(if(round(sum(m.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,6))),CHAR(100)) hrs,"
	    	    		+ "sum(m.ot) ot,CONVERT(if(round(sum(m.ot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.ot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,6))),CHAR(100)) othrs,"  
	    	    		+ "sum(m.hot) hot,CONVERT(if(round(sum(m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.hot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,6))),CHAR(100)) hothrs,"
	    	    		+ "m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on "
	    	    		+ "m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3 "
	    	    		+ "and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+""+sql4+" group by m.date,m.empid union all "
	    	    		+ "select a.date,s.empdocno,s.empid,s.empname,s.costgroup,s.costtype,s.costcodename,s.costcode,s.normal,s.hrs,s.ot,s.othrs,s.hot,s.hothrs,s.normalhrs,s.overtimehrs,s.holidayovertimehrs,s.editbtn,s.confirm from ( "
	    	    		+ "select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+year+"-"+month+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from (select 0 as num union all select 1 union all "
	    	    		+ "select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all "
	    	    		+ "select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all "
	    	    		+ "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all select 4 union all "  
	    	    		+ "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+year+"-"+month+"-01') and YEAR(date)=YEAR('"+year+"-"+month+"-01')"+sql2+") a, " 
	    	    		+ "(select m.date,e.doc_no empdocno,e.codeno empid,e.name empname,'' costgroup,'' costtype,'' costcodename,'' costcode,0 normal,'' hrs,0 ot,'' othrs,0 hot,'' hothrs,'' normalhrs,'' overtimehrs,'' holidayovertimehrs,"
	    	    		+ "'ADD' editbtn,'1' confirm from hr_empm e left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) left join hr_timesheethrs m on (e.doc_no=m.empid and m.status=3 and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+" ) "
	    	    		+ "where e.active=1 and e.status=3 and c.timesheet=1"+sql4+" ) s group by a.date,s.empdocno ) a group by a.date,a.empdocno order by a.empdocno,a.date";*/
	    	    	
	    	    	sql = "select a.dtjoin,CONVERT(a.date,CHAR(500)) date, a.empdocno, a.empid, a.empname, a.costgroup, a.costtype, a.costcodename, a.costcode, a.normal, a.hrs, (a.normal-a.ot-a.hot) actualnormal,CONVERT(if(round((a.normal-a.ot-a.hot)*60,2)=0,' ',"
	    	    			+ "if(LENGTH(SEC_TO_TIME((a.normal-a.ot-a.hot)*60))=8,SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,6))),CHAR(100)) actualhrs, a.ot, a.othrs, a.hot,a.hothrs, a.normalhrs, a.overtimehrs, "
		    	    		+ "a.holidayovertimehrs, a.editbtn, a.confirm, a.confirmed from ( "
		    	    		+ "select e.dtjoin,m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS costcodename,"
		    	    		+ "m.costcode,sum(m.normal) normal,CONVERT(if(round(sum(m.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,6))),CHAR(100)) hrs,"
		    	    		+ "sum(m.ot) ot,CONVERT(if(round(sum(m.ot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.ot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,6))),CHAR(100)) othrs,"  
		    	    		+ "sum(m.hot) hot,CONVERT(if(round(sum(m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.hot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,6))),CHAR(100)) hothrs,"
		    	    		+ "m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm,m.confirm confirmed from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on "
		    	    		+ "m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3 "
		    	    		+ "and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+""+sql4+" group by m.date,m.empid union all "
		    	    		+ "select l.dtjoin,l.date,l.empdocno,l.empid,l.empname,l.costgroup,l.costtype,l.costcodename,l.costcode,l.normal,l.hrs,l.ot,l.othrs,l.hot,l.hothrs,l.normalhrs,l.overtimehrs,l.holidayovertimehrs,l.editbtn,CASE WHEN substring_index(l.empname, ' - ',-1)='Holiday' "
		    	    		+ "Then 0 WHEN substring_index(l.empname, ' - ',-1)='Leave' Then 0 ELSE l.confirm END AS confirm,l.confirmed from ( "
		    	    		+ "select s.dtjoin,a.date,s.empdocno,s.empid,CONCAT(s.empname,(CASE WHEN DAY(a.date)=1 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date1),'') " 
		    	    		+ "WHEN DAY(a.date)=2 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date2),'') "
		    	    		+ "WHEN DAY(a.date)=3 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date3),'') " 
		    	    		+ "WHEN DAY(a.date)=4 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date4),'') " 
		    	    		+ "WHEN DAY(a.date)=5 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date5),'') " 
		    	    		+ "WHEN DAY(a.date)=6 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date6),'') " 
		    	    		+ "WHEN DAY(a.date)=7 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date7),'') " 
		    	    		+ "WHEN DAY(a.date)=8 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date8),'') " 
		    	    		+ "WHEN DAY(a.date)=9 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date9),'') " 
		    	    		+ "WHEN DAY(a.date)=10 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date10),'') " 
		    	    		+ "WHEN DAY(a.date)=11 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date11),'') " 
		    	    		+ "WHEN DAY(a.date)=12 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date12),'') " 
		    	    		+ "WHEN DAY(a.date)=13 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date13),'') " 
		    	    		+ "WHEN DAY(a.date)=14 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date14),'') " 
		    	    		+ "WHEN DAY(a.date)=15 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date15),'') " 
		    	    		+ "WHEN DAY(a.date)=16 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date16),'') " 
		    	    		+ "WHEN DAY(a.date)=17 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date17),'') " 
		    	    		+ "WHEN DAY(a.date)=18 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date18),'') " 
		    	    		+ "WHEN DAY(a.date)=19 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date19),'') " 
		    	    		+ "WHEN DAY(a.date)=20 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date20),'') " 
		    	    		+ "WHEN DAY(a.date)=21 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date21),'') " 
		    	    		+ "WHEN DAY(a.date)=22 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date22),'') " 
		    	    		+ "WHEN DAY(a.date)=23 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date23),'') " 
		    	    		+ "WHEN DAY(a.date)=24 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date24),'') " 
		    	    		+ "WHEN DAY(a.date)=25 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date25),'') " 
		    	    		+ "WHEN DAY(a.date)=26 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date26),'') " 
		    	    		+ "WHEN DAY(a.date)=27 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date27),'') " 
		    	    		+ "WHEN DAY(a.date)=28 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date28),'') " 
		    	    		+ "WHEN DAY(a.date)=29 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date29),'') " 
		    	    		+ "WHEN DAY(a.date)=30 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date30),'') " 
		    	    		+ "WHEN DAY(a.date)=31 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date31),'') ELSE '' END)) empname," 
		    	    		+ "s.costgroup,s.costtype,s.costcodename,s.costcode,s.normal,s.hrs,s.ot,s.othrs,s.hot,s.hothrs,s.normalhrs,s.overtimehrs,s.holidayovertimehrs,s.editbtn,s.confirm,s.confirmed from ( "
		    	    		+ "select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+year+"-"+month+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from (select 0 as num union all select 1 union all "
		    	    		+ "select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all "
		    	    		+ "select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all "
		    	    		+ "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all select 4 union all "  
		    	    		+ "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+year+"-"+month+"-01') and YEAR(date)=YEAR('"+year+"-"+month+"-01')"+sql2+") a, " 
		    	    		+ "(select m.date,e.doc_no empdocno,e.codeno empid,e.name empname,'' costgroup,'' costtype,'' costcodename,'' costcode,0 normal,'' hrs,0 ot,'' othrs,0 hot,'' hothrs,'' normalhrs,'' overtimehrs,'' holidayovertimehrs,"
		    	    		+ "'ADD' editbtn,CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),0,0),CHAR(50)) confirm,t.date1,t.date2,t.date3,t.date4,t.date5,"
		    	    		+ "t.date6,t.date7,t.date8,t.date9,t.date10,t.date11,t.date12,t.date13,t.date14,t.date15,t.date16,t.date17,t.date18,t.date19,t.date20,t.date21,t.date22,t.date23,t.date24,t.date25,t.date26,t.date27,t.date28,t.date29,t.date30,t.date31,m.confirm confirmed,e.dtjoin "
		    	    		+ "from hr_empm e left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) left join hr_timesheethrs m on (e.doc_no=m.empid and m.status=3 and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+" ) "
		    	    		+ "left join hr_timesheet t on (e.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"') where e.active=1 and e.status=3 and c.timesheet=1 and MONTH(dtjoin)<='"+month+"' and YEAR(dtjoin)<='"+year+"' "+sql4+" ) s group by a.date,s.empdocno ) l ) a group by a.date,a.empdocno "
		    	    		+ "  having a.date>=dtjoin order by a.empdocno,a.date";
	    	    	// Unable to confirm total leave condition changed(CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),1,0),CHAR(50)) confirm)
	    	    	//System.out.println(" === 1 ==== "+sql);         
	    	    } else if(rptType.equalsIgnoreCase("2")){
	    	    	
	    	    	sql = "select m.intime,m.outtime,m.rowno,m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS costcodename,"
    					+ "m.costcode,m.normal,CONVERT(if(round(m.normal*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(m.normal*60))=8,SUBSTRING(SEC_TO_TIME(m.normal*60),1,5),SUBSTRING(SEC_TO_TIME(m.normal*60),1,6))),CHAR(100)) hrs,"
    					+ "CONVERT(if(round((m.normal-m.ot-coalesce(m.hot,0))*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((m.normal-m.ot-coalesce(m.hot,0))*60))=8,SUBSTRING(SEC_TO_TIME((m.normal-m.ot-coalesce(m.hot,0))*60),1,5),SUBSTRING(SEC_TO_TIME((m.normal-m.ot-coalesce(m.hot,0))*60),1,6))),CHAR(100)) actualnormalhrs,m.ot,"
	    	    		+ "CONVERT(if(round(m.ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(m.ot*60))=8,SUBSTRING(SEC_TO_TIME(m.ot*60),1,5),SUBSTRING(SEC_TO_TIME(m.ot*60),1,6))),CHAR(100)) othrs,m.hot,"
    					+ "CONVERT(if(round(m.hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(m.hot*60))=8,SUBSTRING(SEC_TO_TIME(m.hot*60),1,5),SUBSTRING(SEC_TO_TIME(m.hot*60),1,6))),CHAR(100)) hothrs,m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm,m.confirm confirmed "
	    	    		+ "from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) "  
    					+ "left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where  status=3 and timesheet=1 group by catid) c on  c.catid=e.pay_catid "
    					+ "where m.status=3 and e.status=3"+sql1+""+sql3+""+sql4+" order by m.date"+sql5+"";
	    	    	
	    	    	/*CONVERT(if(round((m.normal-m.ot-m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((m.normal-m.ot-m.hot)*60))=8,SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,6))),CHAR(100))
	    	    	 * */
    	    	//System.out.println(" === 2 ==== "+sql);
	    	    }
				//System.out.println("gridload--------"+sql);
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
	public JSONArray timeSheetReviewExcelData(String year, String month, String date, String category, String employee, String projecttype, String projectid, String orderbydate,
			String orderbyemployee, String orderbycosttype, String orderbycostid, String rptType, String check) throws SQLException {
			
			JSONArray RESULTDATA=new JSONArray();
			
			if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
			
		    Connection conn=null;
		
		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtBTSR = conn.createStatement();
				
			        java.sql.Date sqlDate=null;
		    	    
			        date.trim();
		            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		            {
		        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
		            }
			        
			        String sql = "",sql1="",sql2="",sql3="",sql4="",sql5="";
					
		    	    if(!(year.equalsIgnoreCase("0")) && !(year.equalsIgnoreCase(""))){
			            sql1=sql1+" and YEAR(m.date)='"+year+"'";
			        }
		    	    
		    	    if(!(month.equalsIgnoreCase("0")) && !(month.equalsIgnoreCase(""))){
			            sql1=sql1+" and MONTH(m.date)='"+month+"'";
			        }
		    	    
		    	    if(sqlDate!=null){
		    	    	sql2=sql2+" and date='"+sqlDate+"'";
		    	    	sql3=sql3+" and m.date='"+sqlDate+"'";
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
		    	    	
		    	    	sql = "select CONVERT(a.date,CHAR(500)) date, a.empid, a.empname 'Employee', a.hrs 'Entered Hours', CONVERT(if(round((a.normal-a.ot-a.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((a.normal-a.ot-a.hot)*60))=8,SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((a.normal-a.ot-a.hot)*60),1,6))),CHAR(100)) 'Actual Hours', "
		    	    			+ "a.othrs 'OT Hours',a.hothrs 'HOT Hours' from ( "
		    	    		+ "select m.date,m.empid empdocno,e.codeno empid,e.name empname,f.costgroup,m.costtype,CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS costcodename,"
		    	    		+ "m.costcode,sum(m.normal) normal,CONVERT(if(round(sum(m.normal)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.normal)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.normal)*60),1,6))),CHAR(100)) hrs,"
		    	    		+ "sum(m.ot) ot,CONVERT(if(round(sum(m.ot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.ot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.ot)*60),1,6))),CHAR(100)) othrs,"  
		    	    		+ "sum(m.hot) hot,CONVERT(if(round(sum(m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(sum(m.hot)*60))=8,SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME(sum(m.hot)*60),1,6))),CHAR(100)) hothrs,"
		    	    		+ "m.normalhrs,m.othrs overtimehrs,m.hothrs holidayovertimehrs,'EDIT' editbtn,'0' confirm,m.confirm confirmed from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on "
		    	    		+ "m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3 "
		    	    		+ "and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+""+sql4+" group by m.date,m.empid union all "
		    	    		+ "select l.date,l.empdocno,l.empid,l.empname,l.costgroup,l.costtype,l.costcodename,l.costcode,l.normal,l.hrs,l.ot,l.othrs,l.hot,l.hothrs,l.normalhrs,l.overtimehrs,l.holidayovertimehrs,l.editbtn,CASE WHEN substring_index(l.empname, ' - ',-1)='Holiday' "
		    	    		+ "Then 0 WHEN substring_index(l.empname, ' - ',-1)='Leave' Then 0 ELSE l.confirm END AS confirm,l.confirmed from ( "
		    	    		+ "select a.date,s.empdocno,s.empid,CONCAT(s.empname,(CASE WHEN DAY(a.date)=1 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date1),'') " 
		    	    		+ "WHEN DAY(a.date)=2 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date2),'') "
		    	    		+ "WHEN DAY(a.date)=3 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date3),'') " 
		    	    		+ "WHEN DAY(a.date)=4 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date4),'') " 
		    	    		+ "WHEN DAY(a.date)=5 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date5),'') " 
		    	    		+ "WHEN DAY(a.date)=6 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date6),'') " 
		    	    		+ "WHEN DAY(a.date)=7 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date7),'') " 
		    	    		+ "WHEN DAY(a.date)=8 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date8),'') " 
		    	    		+ "WHEN DAY(a.date)=9 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date9),'') " 
		    	    		+ "WHEN DAY(a.date)=10 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date10),'') " 
		    	    		+ "WHEN DAY(a.date)=11 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date11),'') " 
		    	    		+ "WHEN DAY(a.date)=12 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date12),'') " 
		    	    		+ "WHEN DAY(a.date)=13 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date13),'') " 
		    	    		+ "WHEN DAY(a.date)=14 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date14),'') " 
		    	    		+ "WHEN DAY(a.date)=15 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date15),'') " 
		    	    		+ "WHEN DAY(a.date)=16 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date16),'') " 
		    	    		+ "WHEN DAY(a.date)=17 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date17),'') " 
		    	    		+ "WHEN DAY(a.date)=18 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date18),'') " 
		    	    		+ "WHEN DAY(a.date)=19 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date19),'') " 
		    	    		+ "WHEN DAY(a.date)=20 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date20),'') " 
		    	    		+ "WHEN DAY(a.date)=21 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date21),'') " 
		    	    		+ "WHEN DAY(a.date)=22 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date22),'') " 
		    	    		+ "WHEN DAY(a.date)=23 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date23),'') " 
		    	    		+ "WHEN DAY(a.date)=24 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date24),'') " 
		    	    		+ "WHEN DAY(a.date)=25 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date25),'') " 
		    	    		+ "WHEN DAY(a.date)=26 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date26),'') " 
		    	    		+ "WHEN DAY(a.date)=27 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date27),'') " 
		    	    		+ "WHEN DAY(a.date)=28 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date28),'') " 
		    	    		+ "WHEN DAY(a.date)=29 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date29),'') " 
		    	    		+ "WHEN DAY(a.date)=30 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date30),'') " 
		    	    		+ "WHEN DAY(a.date)=31 THEN COALESCE((select CONCAT(' - ',name) from hr_timesheetset where (reftype in ('L','H') or alpha='H') and refno=s.date31),'') ELSE '' END)) empname," 
		    	    		+ "s.costgroup,s.costtype,s.costcodename,s.costcode,s.normal,s.hrs,s.ot,s.othrs,s.hot,s.hothrs,s.normalhrs,s.overtimehrs,s.holidayovertimehrs,s.editbtn,s.confirm,s.confirmed from ( "
		    	    		+ "select  DATE_FORMAT(date,'%Y-%m-%d') as date from ( select  DATE_ADD('"+year+"-"+month+"-01', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date from (select 0 as num union all select 1 union all "
		    	    		+ "select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n1, (select 0 as num union all select 1 union all select 2 union all "
		    	    		+ "select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1  union all select 2 union all select 3 union all "
		    	    		+ "select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3  union all select 4 union all "  
		    	    		+ "select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4  ) a where MONTH(date)=MONTH('"+year+"-"+month+"-01') and YEAR(date)=YEAR('"+year+"-"+month+"-01')"+sql2+") a, " 
		    	    		+ "(select m.date,e.doc_no empdocno,e.codeno empid,e.name empname,'' costgroup,'' costtype,'' costcodename,'' costcode,0 normal,'' hrs,0 ot,'' othrs,0 hot,'' hothrs,'' normalhrs,'' overtimehrs,'' holidayovertimehrs,"
		    	    		+ "'ADD' editbtn,CONVERT(if(((t.tot_leave1+t.tot_leave2+t.tot_leave3+t.tot_leave4+t.tot_leave5+t.tot_leave6+t.tot_leave7+t.tot_leave8+t.tot_leave9+t.tot_leave10)=0 or t.date1 is null),1,0),CHAR(50)) confirm,t.date1,t.date2,t.date3,t.date4,t.date5,"
		    	    		+ "t.date6,t.date7,t.date8,t.date9,t.date10,t.date11,t.date12,t.date13,t.date14,t.date15,t.date16,t.date17,t.date18,t.date19,t.date20,t.date21,t.date22,t.date23,t.date24,t.date25,t.date26,t.date27,t.date28,t.date29,t.date30,t.date31,m.confirm confirmed "
		    	    		+ "from hr_empm e left join hr_paycode c on (e.pay_catid=c.catid and c.status=3) left join hr_timesheethrs m on (e.doc_no=m.empid and m.status=3 and YEAR(m.date)='"+year+"' and MONTH(m.date)='"+month+"'"+sql3+" ) "
		    	    		+ "left join hr_timesheet t on (e.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"') where e.active=1 and e.status=3 and c.timesheet=1 and MONTH(dtjoin)>='"+month+"' and YEAR(dtjoin)>='"+year+"' "+sql4+" ) s group by a.date,s.empdocno ) l ) a group by a.date,a.empdocno "
		    	    		+ "order by a.empdocno,a.date";
		    	    	
		    	    } else if(rptType.equalsIgnoreCase("2")){
		    	    	
		    	    	sql = "select m.rowno,m.date,e.codeno 'Emp. ID',e.name 'Employee',f.costgroup 'Cost Type',CONVERT(CASE WHEN m.costtype=1 THEN c1.description WHEN m.costtype=6 THEN c2.flname ELSE m.costcode END,CHAR(1000)) AS  'Cost ID',m.normalhrs 'Entered Hours',"
		    	    		+ "CONVERT(if(round((m.normal-m.ot-m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((m.normal-m.ot-m.hot)*60))=8,SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,6))),CHAR(100)) 'Normal Hrs',"
		    	    		+ "m.othrs 'OT Hours',m.hothrs 'HOT Hours' "
		    	    		+ "from hr_timesheethrs m left join hr_empm e on (m.empid=e.doc_no and e.active=1) left join my_costunit f on m.costtype=f.costtype left join my_ccentre c1 on (m.costcode=c1.doc_no and m.costtype=1) "  
	    					+ "left join gl_vehmaster c2 on (m.costcode=c2.fleet_no and m.costtype=6) where m.status=3 and e.status=3"+sql1+""+sql3+""+sql4+" order by m.date"+sql5+"";
		    	    	
		    	    }
					
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
