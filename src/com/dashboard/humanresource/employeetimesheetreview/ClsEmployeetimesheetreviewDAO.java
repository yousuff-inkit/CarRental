package com.dashboard.humanresource.employeetimesheetreview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeetimesheetreviewDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray gridloading(String check,String year, String month,String hidcmbemp,String hidcmbmanager,String status) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 
			 	 String sql = "",sqls="";
			 	  if(!hidcmbemp.equalsIgnoreCase("")){
	                     sqls+=" and m.doc_no ="+hidcmbemp+" ";
	                 }
			 	  
			 	 if(!hidcmbmanager.equalsIgnoreCase("")){
                     sqls+=" and ee.docnoo ="+hidcmbmanager+"";
                 }
	                 
                 if(status.equalsIgnoreCase("2")){
                     sqls+=" and wd.confirmed =1 and wd.full=wc.confirmcount";
                 }else if(status.equalsIgnoreCase("3")){
                     sqls+=" and wd.confirmed =0";
                 }
                      /* old query */
			 	/*sql="select @i:=@i+1 id,a.* from ( select m.terminated_date tdate,ee.empgroupid,ee.promanager, IF(wd.totbillhrs is null,'NO','YES')tsfilled , wd.tsapproved,wd.totbillhrs,wd.leaveapplied,m.doc_no docno, m.codeno empid,m.name,des.desc1 designation,m.dtjoin from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join my_brch mb on m.brhid=mb.doc_no left join(select confirmed,year,month,costtype,if(confirmed=1,'YES','NO')tsapproved,sum(totdays) totbillhrs,sum(tot_leave1) leaveapplied,empid from hr_workdetails where year="+year+" and month="+month+"  group by empid) wd on wd.empid=m.doc_no left join(select  t.doc_no docnoo,empid,group_concat(distinct empgroupid) empgroupid,group_concat(distinct grpcode) promanager from cm_srvassign s left join cm_serteamm t on t.doc_no=s.empgroupid group by empid) ee on ee.empid=m.doc_no  where 1=1  "+sqls+") a,(SELECT @i:= 0) as i";
*/
                   /* count added query for approval status */
                 /* sql="select @i:=@i+1 id,a.* from ( select case when wd.full=wc.confirmcount then 'YES' when wc.confirmcount< wd.full then 'Partially yes' when wc.confirmcount=0 then 'NO' when wc.confirmcount is null then 'NO' else '' end as tsapproved,wc.confirmcount,wd.full,m.terminated_date tdate,ee.empgroupid,ee.promanager, IF(wd.totbillhrs is null,'NO','YES')tsfilled , wd.leaveapplied,m.doc_no docno, m.codeno empid,m.name,des.desc1 designation,m.dtjoin from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join my_brch mb on m.brhid=mb.doc_no left join(select count(*) full,confirmed,year,month,costtype,sum(totdays) totbillhrs,sum(tot_leave1) leaveapplied,empid from hr_workdetails where year="+year+" and month="+month+"  and costtype!='COST' group by empid) wd on wd.empid=m.doc_no left join(select  t.doc_no docnoo,empid,group_concat(distinct empgroupid) empgroupid,group_concat(distinct grpcode) promanager from cm_srvassign s left join cm_serteamm t on t.doc_no=s.empgroupid group by empid) ee on ee.empid=m.doc_no "
                         +" left join(select empid,count(confirmed) confirmcount  from hr_workdetails where confirmed=1 and year="+year+" and month="+month+"   and costtype!='COST' group by empid) wc on wc.empid=m.doc_no  where 1=1  "+sqls+") a,(SELECT @i:= 0) as i";
*/
                  /* count added for approval status & terminated date should show for selected month */
                 
                 sql="select @i:=@i+1 id,a.* from ( select wd.totbillhrs,case when wd.full=wc.confirmcount then 'YES' when wc.confirmcount< wd.full then 'Partial' when wc.confirmcount=0 then 'NO' when wc.confirmcount is null then 'NO' else '' end as tsapproved,wc.confirmcount,wd.full,m.terminated_date tdate,ee.empgroupid,ee.promanager, IF(wd.totbillhrs is null,'NO','YES')tsfilled , wd.leaveapplied,m.doc_no docno, m.codeno empid,m.name,des.desc1 designation,m.dtjoin from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join my_brch mb on m.brhid=mb.doc_no left join(select count(*) full,confirmed,year,month,costtype,sum(totdays) totbillhrs,sum(tot_leave1) leaveapplied,empid from hr_workdetails where year="+year+" and month="+month+"  and costtype!='COST' group by empid) wd on wd.empid=m.doc_no left join(select  t.doc_no docnoo,empid,group_concat(distinct empgroupid) empgroupid,group_concat(distinct grpcode) promanager from cm_srvassign s left join cm_serteamm t on t.doc_no=s.empgroupid group by empid) ee on ee.empid=m.doc_no "
                         +" left join(select empid,count(confirmed) confirmcount  from hr_workdetails where confirmed=1 and year="+year+" and month="+month+"   and costtype!='COST' group by empid) wc on wc.empid=m.doc_no  where 1=1 and m.status=3 "+sqls+" "
                         + "union all select wd.totbillhrs,case when wd.full=wc.confirmcount then 'YES' when wc.confirmcount< wd.full then 'Partial' when wc.confirmcount=0 then 'NO' when wc.confirmcount is null then 'NO' else '' end as tsapproved,wc.confirmcount,wd.full,m.terminated_date tdate,ee.empgroupid,ee.promanager, IF(wd.totbillhrs is null,'NO','YES')tsfilled , wd.leaveapplied,m.doc_no docno, m.codeno empid,m.name,des.desc1 designation,m.dtjoin from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join my_brch mb on m.brhid=mb.doc_no left join(select count(*) full,confirmed,year,month,costtype,sum(totdays) totbillhrs,sum(tot_leave1) leaveapplied,empid from hr_workdetails where year="+year+" and month="+month+"  and costtype!='COST' group by empid) wd on wd.empid=m.doc_no left join(select  t.doc_no docnoo,empid,group_concat(distinct empgroupid) empgroupid,group_concat(distinct grpcode) promanager from cm_srvassign s left join cm_serteamm t on t.doc_no=s.empgroupid group by empid) ee on ee.empid=m.doc_no "
                         +" left join(select empid,count(confirmed) confirmcount  from hr_workdetails where confirmed=1 and year="+year+" and month="+month+"   and costtype!='COST' group by empid) wc on wc.empid=m.doc_no  where 1=1  and m.status=7 and terminated_date between '"+year+"-"+month+"-01' and '"+year+"-"+month+"-31'  "+sqls+" " 
                         + ")a,(SELECT @i:= 0) as i order by a.docno";

                 
                 
            //  System.out.println(" ====grid loading ==== "+sql);
	 	    	   
				
				ResultSet resultSet = stmtEMP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray employeeDetailsSearch() throws SQLException {
        JSONArray RESULTDATA1=new JSONArray();
   
     
       Connection conn=null;
   
       try {
               conn = ClsConnection.getMyConnection();
               Statement stmtEMP = conn.createStatement();
           
               String sql = "";
               
           
               sql = "select codeno codeno,doc_no docno,UPPER(name) name from hr_empm where status=3 order by name";
               
               ResultSet resultSet1 = stmtEMP.executeQuery(sql);
               
               RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
               
               stmtEMP.close();
               conn.close();
       } catch(Exception e){
           e.printStackTrace();
           conn.close();
       } finally{
           conn.close();
       }
       return RESULTDATA1;
   }
	
	   public JSONArray managerDetailsSearch() throws SQLException {
	        JSONArray RESULTDATA1=new JSONArray();
	   
	     
	       Connection conn=null;
	   
	       try {
	               conn = ClsConnection.getMyConnection();
	               Statement stmtEMP = conn.createStatement();
	           
	               String sql = "";
	               
	           
	               sql = "select  t.doc_no empid,group_concat(distinct t.grpcode) name from cm_srvassign s left join cm_serteamm t on t.doc_no=s.empgroupid where t.status=3 group by t.doc_no";
	               
	               ResultSet resultSet1 = stmtEMP.executeQuery(sql);
	               
	               RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
	               
	               stmtEMP.close();
	               conn.close();
	       } catch(Exception e){
	           e.printStackTrace();
	           conn.close();
	       } finally{
	           conn.close();
	       }
	       return RESULTDATA1;
	   }
 
	   public JSONArray attendanceGridLoading(HttpSession session,String year,String totaldays,String month,String brhid,String emp) throws SQLException {
           
           Connection conn=null;
           JSONArray RESULTDATA=new JSONArray();

           try {
                   conn = ClsConnection.getMyConnection();
                   Statement stmtATTN = conn.createStatement();
                   Statement stmtATTN1 = conn.createStatement();
                   
                   ArrayList<String> employeearray=new ArrayList<>();
                   
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
                      
                      
                      String sqld="select db1,db2 from my_comp";
                       
                       ResultSet rs = stmtATTN.executeQuery(sqld);
                       
                       String db1="";
                       String db2="";
                       while(rs.next()) {
                           db1=rs.getString("db1");
                           db2=rs.getString("db2");
                       }
                      
                      String sqltst="";
                      String branchid=session.getAttribute("BRANCHID").toString();
                     
                           if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0"))){  
                               sqltst=sqltst+" and w.brhid='"+brhid+"'";       
                           
                       }
                           String userid=session.getAttribute("USERID").toString();
                        //   System.out.println("user===="+userid);

                    int docno=0;
                    String sqlteam="",sqlteam1="",sqlteam2="";
                         String sql4="select doc_no from cm_serteamm  where serteamuserlink="+userid;
                            ResultSet rs4 = stmtATTN1.executeQuery(sql4);
                            if(rs4.next())
                            {
                                docno=rs4.getInt("doc_no");
                            }
                
                if(docno>0)
                {
                   
                    
                    sqlteam=" and empgroupid="+docno+"  ";
                    sqlteam1=" union all select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                            + "cast(coalesce(c1.description,'') as char(100)) name, '' site,0 pholiday, w.dbname dbs,"
                            + " coalesce (h.name,'') empname ,w.* from hr_workdetails w  inner join hr_empm h on"
                            + " w.empid=h.doc_no and linemanager="+docno+" "
                            + "left join my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode  "
                            + "where  month='"+month+"' and year='"+year+"' and w.empid='"+emp+"' and w.costtype='COST'  ";
                    sqlteam2=" and cs.empgroupid="+docno+"  ";

                }
                       
                   
  
                
                String sql3="select cs.empid emp,w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                   + "cast(coalesce(a.refname,'') as char(100)) name,  "
                                   + "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                   + "0 pholiday, cs.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
                                       + "inner join (select distinct empid,refdocno,dtype,brhid,empgroupid,dbname from "+db1+".cm_srvassign  where   concat('"+year+"','"+month+"')  between "
                                           + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"')) "+sqlteam+" ) cs"
                                           + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "
                                       
                                           + " left join "+db1+".hr_empm h on w.empid=h.doc_no "
                                           + "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
                                           + "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                           + "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                           + "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                           + "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                           + "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                           + "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'"
                                           + " where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"' and w.dbname='"+db1+"' "+sqlteam2+" and w.costtype!='COST' group by cs.empid,cs.refdocno,cs.dtype "
                                           + " union all  "
                                           + "select cs.empid emp,w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                           + "cast(coalesce(a.refname,'') as char(100)) name,  "
                                           + "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                           + "0 pholiday,cs.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
                                           + "inner join (select distinct empid,refdocno,dtype,brhid,empgroupid,dbname from "+db2+".cm_srvassign  where   concat('"+year+"','"+month+"')  between "
                                           + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"')) "+sqlteam+" ) cs"
                                           + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "   
                                           + " left join "+db1+".hr_empm h on w.empid=h.doc_no "
                                           + "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
                                           + "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                           + "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                           + "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                           + "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                           + "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                           + "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM' "
                                           + "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'   and w.dbname='"+db2+"' "+sqlteam2+" and w.costtype!='COST' group by cs.empid,cs.refdocno,cs.dtype  union all  "
                                           + "select cs.empid emp,w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                           + "cast(coalesce(a.refname,'') as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                           + "0 pholiday,cs.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w "
                                            + "inner join (select distinct empid,refdocno,dtype,brhid,empgroupid,dbname from "+db2+".cm_srvassign  where   concat('"+year+"','"+month+"')  between "
                                           + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"')) "+sqlteam+" ) cs"
                                           + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid " 
                                           + " left join "+db2+".hr_empm h on w.empid=h.doc_no "
                                           + "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  " 
                                           + "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                           + "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                           + "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                           + "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                           + "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                           + "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                           + " where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db2+"' "+sqlteam2+" and w.costtype!='COST' group by cs.empid,cs.refdocno,cs.dtype  "
                                           + "union all  "  
                                           + "select cs.empid emp,w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                           + "cast(coalesce(a.refname,'') as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                           + "0 pholiday,cs.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w  "
                                           + "inner join (select distinct empid,refdocno,dtype,brhid,empgroupid,dbname from "+db1+".cm_srvassign  where   concat('"+year+"','"+month+"')  between "
                                           + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"')) "+sqlteam+" ) cs"
                                           + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "         
                                           + "left join "+db2+".hr_empm h on w.empid=h.doc_no "
                                           + "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  "
                                           + "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                           + "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                           + "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                           + "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                           + "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                           + "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                           + "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db1+"' "+sqlteam2+" and w.costtype!='COST' group by cs.empid,cs.refdocno,cs.dtype "+sqlteam1+"";
                
                    
         //  System.out.println("-----2nd grid --=======--------======"+sql3);
                   ResultSet resultSet4 = stmtATTN1.executeQuery(sql3);
               
                   RESULTDATA=ClsCommon.convertToJSON(resultSet4);
                   
                   stmtATTN.close();
                   conn.close();
           } catch(Exception e){
               e.printStackTrace();
               conn.close();
           } finally{
               conn.close();
           }
           return RESULTDATA;
       }
   
       
       

}

