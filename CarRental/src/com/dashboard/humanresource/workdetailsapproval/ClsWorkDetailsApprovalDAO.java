package com.dashboard.humanresource.workdetailsapproval;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsWorkDetailsApprovalDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	private CallableStatement stmtBHTS1;

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
                     // change on 07-02-2023 as all employee worked in that project should list
                     // sqlteam="and empid in (select group_concat(empid) from cm_serteamd where rdocno='"+docno+"')";
                     
                     
                     sqlteam=" and empgroupid="+docno+"  ";
                     sqlteam1=" union all select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                             + "cast(coalesce(c1.description,'') as char(100)) name, '' site,0 pholiday, w.dbname dbs,"
                             + " coalesce (h.name,'') empname ,w.* from hr_workdetails w  inner join hr_empm h on"
                             + " w.empid=h.doc_no and linemanager="+docno+" "
                             + "left join my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode  "
                             + "where  month='"+month+"' and year='"+year+"' and w.empid='"+emp+"' and w.costtype='COST'  ";
                     sqlteam2=" and cs.empgroupid="+docno+"  ";

                 }
			    	    
			        
			    	/* changed query as value was not loading  
		    	    String sql3="select x.costtype, x.brhid, tr_no, code, x.name,x.site, x.dbname, d.empId as emp,coalesce (h.name,'') empname , totdays,srno, date1, date2, date3, date4, date5, date6, date7, date8, date9, date10, date11, date12, date13, date14, date15, date16, date17, date18, date19, date20, date21, date22, date23, date24, date25, date26, date27, date28, date29, date30, date31, tot_leave1,clientaprvdhrs,  confirmed,x.pholiday "
		    	    		+ " from  hr_workdetails d inner join (select m.dtype costtype,m.brhid,m.doc_no tr_no,cast(concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) as char(100)) code,"
		    	    		+ "cast(concat(if(sd.name is null,'' ,concat(sd.name,' ')),a.refname) as char(100)) name,coalesce(dd.site,'') site,0 pholiday,'"+db1+"' dbname "
		    	    		+ " from "+db1+".cm_srvcontrm m left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no left join "+db1+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
		    	    		+ " left join "+db1+".cm_subdivm s on m.tr_no=s.jobdocno left join "+db1+".cm_subdivision sd on"
		    	    		+ " sd.doc_no=s.rdocno "
             				+ " left join "+db1+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype=m.dtype "
		    	    		+ " where m.status=3 and a.status=3  and m.dtype in ('sjob','amc') and cs.empId='"+emp+"'and m.jbaction in (0,4)  and cs.plannedon<=last_day('"+year+"-"+month+"-01') group by m.doc_no union all(select m.dtype costtype,m.brhid,m.doc_no tr_no,"
		    	    		+ "cast(concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) as char(100)) code,"
		    	    		+ "cast(concat(if(sd.name is null,'' ,concat(sd.name,' ')),a.refname) as char(100)) name,coalesce(dd.site,'') site,0 pholiday,"
		    	    		+ "'"+db2+"' dbname  from "+db2+".cm_srvcontrm m  left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no left join "+db2+".my_acbook a on"
		    	    		+ " m.cldocno=a.doc_no and a.dtype='CRM'  left join "+db2+".cm_subdivm s on m.tr_no=s.jobdocno "
		    	    		+ " left join "+db2+".cm_subdivision sd on sd.doc_no=s.rdocno "
		    	    		+ " left join "+db2+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype=m.dtype "
                            + "  where m.status=3 and a.status=3  and m.dtype in ('sjob','amc') and cs.empId='"+emp+"' and m.jbaction in (0,4)  and cs.plannedon<=last_day('"+year+"-"+month+"-01')      group by m.doc_no )"
    	    				+ " UNION ALL select 'STC' costtype,m.brhid,m.doc_no tr_no,cast(concat(m.doc_no ) as char(100)) code, cast(concat(a.refname) as char(100)) name,m.pholiday,'' site,'"+db1+"' dbname  from  "+db1+".cm_staffcontrm m left join  "+db1+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM'  left join "+db1+".cm_staffcontrd cd on cd.rdocno=m.doc_no " 
    	    				+ " left join "+db1+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype='STC' "
    	    				+ " where m.status=3 and a.status=3 and ( cd.empid='"+emp+"' || cs.empId='"+emp+"')   and cs.plannedon<=last_day('"+year+"-"+month+"-01')   group by m.doc_no UNION ALL "
	    					+ "select 'COST' ,1,c1.costcode code,c1.doc_no doc_no,c1.description name,'' site,0 pholiday, '"+db1+"' DBNAME    from  "+db1+".HR_EMPM M LEFT JOIN  "+db1+".my_ccentre c1 ON C1.DOC_NO=M.COSTID left join  "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0 AND M.DOC_NO='"+emp+"' "
	    					+ " UNION ALL select 'STC' costtype,m.brhid,m.doc_no tr_no,cast(concat(m.doc_no ) as char(100)) code, cast(concat(a.refname) as char(100)) name,'' site,m.pholiday,'"+db2+"' dbname  from  "+db2+".cm_staffcontrm m left join  "+db2+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM'  left join "+db2+".cm_staffcontrd cd on cd.rdocno=m.doc_no "
	    					+ " left join "+db2+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype='STC' "
	    					+ " where m.status=3 and a.status=3 and ( cd.empid='"+emp+"' || cs.empId='"+emp+"') and cs.plannedon<=last_day('"+year+"-"+month+"-01')  group by m.doc_no UNION ALL "
	    					+ "select 'COST' ,1,c1.costcode code,c1.doc_no doc_no,c1.description name,'' site,0 pholiday, '"+db2+"' DBNAME    from  "+db2+".HR_EMPM M LEFT JOIN  "+db2+".my_ccentre c1 ON C1.DOC_NO=M.COSTID left join  "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0 AND M.DOC_NO='"+emp+"'"
		    	    		+ " UNION ALL select 'AMS' costtype,m.brhid,m.doc_no tr_no,cast(concat(m.doc_no ) as char(100)) code, cast(concat(a.refname) as char(100)) name,coalesce(dd.site,'') site,'' pholiday,'"+db1+"' dbname  from  "+db1+".cm_amscontrm m  left join "+db1+".cm_amssited dd on m.doc_no=dd.rdocno left join  "+db1+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
		    	    		+ " left join "+db1+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype='AMS' "
		    	    		+ " where m.status=3 and a.status=3 and cs.empId='"+emp+"' and cs.plannedon<=last_day('"+year+"-"+month+"-01')  group by m.doc_no "
		    	    		+ " UNION ALL select 'AMS' costtype,m.brhid,m.doc_no tr_no,cast(concat(m.doc_no ) as char(100)) code, cast(concat(a.refname) as char(100)) name,coalesce(dd.site,'') site,'' pholiday,'"+db2+"' dbname  from  "+db2+".cm_amscontrm m left join "+db2+". cm_amssited dd on m.doc_no=dd.rdocno left join  "+db2+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
		    	    		+ " left join "+db2+".cm_srvassign cs on cs.refDocNo=m.doc_no and cs.brhid=m.brhid and cs.dtype='AMS' "
		    	    		+ " where m.status=3 and a.status=3 and cs.empId='"+emp+"' and cs.plannedon<=last_day('"+year+"-"+month+"-01')  group by m.doc_no "
	    					+ ") x "
		    	    		+ "  on (d.empid='"+emp+"' and d.costtype=x.costtype and d.costcode=x.code and d.dbname=x.dbname)"
		    	    		+ " and d.year="+year+" and d.month="+month+"  "+sqltst+""
		    	    	    + " left join hr_empm h on d.empid=h.doc_no "
		    	    	    + " order by costtype,tr_no,code ";     
		    	    	   */
			            	
					/*
					 * String
					 * sql3="select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,cast(coalesce(a.refname,c1.description) as char(100)) name, "
					 * +
					 * " coalesce(case when s.dtype='sjob' then dd.site when s.dtype='ams' then amsd.site else '' end ,'') site,0 pholiday,'"
					 * +db1+"' dbs, " + "coalesce (h.name,'') empname ,w.* from "
					 * +db1+".hr_workdetails w left join (select distinct empid,dtype,refdocno,brhid from cm_srvassign  where dbname='"
					 * +db1+"'  and empid='"+emp+"' " + "and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+
					 * month+"'))) s  on s.refdocno=w.costcode and s.dtype=w.costtype and w.empid=s.empid  and w.brhid=s.brhid "
					 * + "left join "+db1+".hr_empm h on w.empid=h.doc_no " +
					 * "left join cm_srvcontrm m on s.refDocNo=m.doc_no and s.brhid=m.brhid and s.dtype=m.dtype "
					 * + "left join cm_srvcsited dd on m.tr_no=dd.tr_no " +
					 * "left join cm_staffcontrm sm on s.refDocNo=sm.doc_no and s.brhid=sm.brhid and s.dtype='STC' "
					 * + "left join cm_staffcontrd cd on cd.rdocno=sm.doc_no " +
					 * "left join cm_amscontrm ams  on s.refDocNo=ams.doc_no and s.brhid=ams.brhid and s.dtype='AMS' left join cm_amssited amsd on ams.doc_no=amsd.rdocno "
					 * + "left join "
					 * +db1+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode left join  "
					 * +db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) " +
					 * "left join my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM' where w.empid='"
					 * +emp+"' and month='"+month+"' and year='"+year+"'  " +
					 * "union all select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,cast(coalesce(a.refname,c1.description) as char(100)) name, "
					 * +
					 * "coalesce(case when s.dtype='sjob' then dd.site when s.dtype='ams' then amsd.site else '' end ,'') site,0 pholiday,'"
					 * +db2+"' dbs, " + "coalesce (h.name,'') empname ,w.* from "
					 * +db2+".hr_workdetails w left join (select distinct empid,dtype,refdocno,brhid from cm_srvassign  where dbname='"
					 * +db2+"'  and empid='"+emp+"' " + "and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+
					 * month+"'))) s on s.refdocno=w.costcode and s.dtype=w.costtype and w.empid=s.empid  and w.brhid=s.brhid "
					 * + "left join "
					 * +db2+".hr_empm h on w.empid=h.doc_no left join cm_srvcontrm m on s.refDocNo=m.doc_no and s.brhid=m.brhid and s.dtype=m.dtype "
					 * + " left join cm_srvcsited dd on m.tr_no=dd.tr_no " +
					 * "left join cm_staffcontrm sm on s.refDocNo=sm.doc_no and s.brhid=sm.brhid and s.dtype='STC' "
					 * +
					 * "left join cm_staffcontrd cd on cd.rdocno=sm.doc_no left join cm_amscontrm ams  on s.refDocNo=ams.doc_no and s.brhid=ams.brhid and s.dtype='AMS' left join cm_amssited amsd on ams.doc_no=amsd.rdocno "
					 * + "left join "
					 * +db2+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode left join  "
					 * +db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) " +
					 * "left join my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  where w.empid='"
					 * +emp+"' and month='"+month+"' and year='"+year+"'  ";
					 */ 
			            
                 
             /*    
                 
                 String sql3="select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                         + "cast(coalesce(a.refname,c1.description) as char(100)) name,  "
                         + "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                         + "0 pholiday, w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
                                 + " left join "+db1+".hr_empm h on w.empid=h.doc_no "
                                 + "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
                                 + "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                 + "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                 + "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                 + "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                 + "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                 + "left join "+db1+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
                                 + "left join  "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
                                 + "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'"
                                 + " where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"' and w.dbname='"+db1+"' "
                                 + " union all  "
                                 + "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                 + "cast(coalesce(a.refname,c1.description) as char(100)) name,  "
                                 + "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                 + "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
                                 + " left join "+db1+".hr_empm h on w.empid=h.doc_no "
                                 + "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
                                 + "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                 + "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                 + "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                 + "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                 + "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                 + "left join "+db2+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
                                 + "left join  "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
                                 + "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM' "
                                 + "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'   and w.dbname='"+db2+"'  union all  "
                                 + "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                 + "cast(coalesce(a.refname,c1.description) as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                 + "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w "
                                 + " left join "+db2+".hr_empm h on w.empid=h.doc_no "
                                 + "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  "
                                 + "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                 + "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                 + "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                 + "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                 + "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                 + "left join "+db2+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
                                 + "left join  "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
                                 + "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                 + "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db2+"'   "
                                 + "union all  "
                                 + "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
                                 + "cast(coalesce(a.refname,c1.description) as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
                                 + "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w  "
                                 + "left join "+db2+".hr_empm h on w.empid=h.doc_no "
                                 + "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  "
                                 + "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
                                 + "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
                                 + "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
                                 + "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
                                 + "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
                                 + "left join "+db1+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
                                 + "left join  "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
                                 + "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                 + "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db1+"'   ";
                 
                 */
                 
           /*      
                 String sql3="select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
			            			+ "cast(coalesce(a.refname,c1.description) as char(100)) name,  "
			            			+ "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
			            			+ "0 pholiday, w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
			            					+ " left join "+db1+".hr_empm h on w.empid=h.doc_no "
			            					+ "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
			            					+ "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
			            					+ "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
			            					+ "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
			            					+ "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
			            					+ "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
			            					+ "left join "+db1+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
			            					+ "left join  "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
			            					+ "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'"
			            					+ "left join (select distinct empid,refdocno,dtype,brhid from "+db1+".cm_srvassign  where   concat('2023','04')  between "
			            					+ " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('2023','04') "+sqlteam+" )) cs"
			            				    + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "
			            					+ " where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"' and w.dbname='"+db1+"' group by cs.empid,cs.refdocno,cs.dtype "
			            					+ " union all  "
			            					+ "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
			            					+ "cast(coalesce(a.refname,c1.description) as char(100)) name,  "
			            					+ "coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
			            					+ "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db1+".hr_workdetails w "
			            					+ " left join "+db1+".hr_empm h on w.empid=h.doc_no "
			            					+ "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype "
			            					+ "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
			            					+ "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
			            					+ "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
			            					+ "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
			            					+ "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
			            					+ "left join "+db2+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
			            					+ "left join  "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
			            					+ "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM' "
                                            + "left join (select distinct empid,refdocno,dtype,brhid from "+db2+".cm_srvassign  where   concat('2023','04')  between "
                                            + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('2023','04') "+sqlteam+" )) cs"
                                            + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "   
			            					+ "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'   and w.dbname='"+db2+"' group by cs.empid,cs.refdocno,cs.dtype  union all  "
			            					+ "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
			            					+ "cast(coalesce(a.refname,c1.description) as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
			            					+ "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w "
			            					+ " left join "+db2+".hr_empm h on w.empid=h.doc_no "
			            					+ "left join "+db2+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  "
			            					+ "left join "+db2+".cm_srvcsited dd on m.tr_no=dd.tr_no "
			            					+ "left join "+db2+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
			            					+ "left join "+db2+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
			            					+ "left join "+db2+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
			            					+ "left join "+db2+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
			            					+ "left join "+db2+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
			            					+ "left join  "+db2+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
			            					+ "left join "+db2+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                            + "left join (select distinct empid,refdocno,dtype,brhid from "+db2+".cm_srvassign  where   concat('2023','04')  between "
                                            + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('2023','04') "+sqlteam+" )) cs"
                                            + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "
			            					+ " where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db2+"' group by cs.empid,cs.refdocno,cs.dtype  "
			            					+ "union all  "
			            					+ "select w.costtype,w.brhid,w.costcode tr_no,cast(w.costcode as char(100)) code,"
			            					+ "cast(coalesce(a.refname,c1.description) as char(100)) name, coalesce(case when w.costtype='sjob' then dd.site when w.costtype='ams' then amsd.site else '' end ,'') site,"
			            					+ "0 pholiday,w.dbname dbs, coalesce (h.name,'') empname ,w.* from "+db2+".hr_workdetails w  "
			            					+ "left join "+db2+".hr_empm h on w.empid=h.doc_no "
			            					+ "left join "+db1+".cm_srvcontrm m on w.costcode=m.doc_no and w.brhid=m.brhid and w.costtype=m.dtype  "
			            					+ "left join "+db1+".cm_srvcsited dd on m.tr_no=dd.tr_no "
			            					+ "left join "+db1+".cm_staffcontrm sm on w.costcode=sm.doc_no and w.brhid=sm.brhid and w.costtype='STC' "
			            					+ "left join "+db1+".cm_staffcontrd cd on cd.rdocno=sm.doc_no "
			            					+ "left join "+db1+".cm_amscontrm ams  on w.costcode=ams.doc_no and w.brhid=ams.brhid and w.costtype='AMS' "
			            					+ "left join "+db1+".cm_amssited amsd on ams.doc_no=amsd.rdocno "
			            					+ "left join "+db1+".my_ccentre c1 ON c1.m_s=0 AND  C1.DOC_NO=w.COSTcode "
			            					+ "left join  "+db1+".my_ccentre c2 on(c1.doc_no=c2.grpno) "
			            					+ "left join "+db1+".my_acbook a on (m.cldocno=a.doc_no or sm.cldocno=a.doc_no  or ams.cldocno=a.doc_no ) and a.dtype='CRM'  "
                                            + "left join (select distinct empid,refdocno,dtype,brhid from "+db1+".cm_srvassign  where   concat('2023','04')  between "
                                            + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('2023','04') "+sqlteam+" )) cs"
                                            + " on cs.refDocNo=w.costcode and cs.brhid=w.brhid and cs.dtype=w.costtype and cs.empid=w.empid "         
			            					+ "where w.empid='"+emp+"' and month='"+month+"' and year='"+year+"'    and w.dbname='"+db1+"' group by cs.empid,cs.refdocno,cs.dtype ";
			          */ 
                 
                 
                 
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
                 
                     
          //  System.out.println("WDA---=====------2nd grid--=======--------======"+sql3);
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
	
		
		public JSONArray attendanceGridLoading1(HttpSession session,String year,String totaldays,String month,String brhid) throws SQLException {
		    
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
			            		sqltst=sqltst+" and d.brhid='"+brhid+"'";       
			            	
			            	}
		                       String userid=session.getAttribute("USERID").toString();
		                      // System.out.println("user===="+userid);

                        int docno=0;
                        String sqlteam="",sqlteam1="";
			            	 String sql4="select doc_no from cm_serteamm  where serteamuserlink="+userid;
					    	    ResultSet rs4 = stmtATTN1.executeQuery(sql4);
					    	    if(rs4.next())
					    	    {
					    	    	docno=rs4.getInt("doc_no");
					    	    }
			        
			    	if(docno>0)
			    	{
			    	    // change on 07-02-2023 as all employee worked in that project should list
			    	    // sqlteam="and empid in (select group_concat(empid) from cm_serteamd where rdocno='"+docno+"')";
			    		
			    		
			    	    sqlteam=" and empgroupid="+docno+"  ";
                        sqlteam1=" union all  select coalesce (m.name,'') name ,w.* from hr_workdetails w   inner join hr_empm m on "
                                + "m.doc_no=w.empid  and m.linemanager="+docno+" where  month='"+month+"' and year='"+year+"' and w.costtype='COST' ";

			    		
			    	}
		    	   /*
		    	    *  commeted as not loading as group head
		    	    *  String sql3="select  d.empId as emp,coalesce (h.name,'') empname , totdays,srno,"
		    	    		+ " coalesce(sum(date1),0) date1,  coalesce(sum(date2),0) date2,"
		    	    		+ "  coalesce(sum(date3),0) date3,  coalesce(sum(date4),0) date4,"
		    	    		+ " coalesce(sum(date5),0) date5,  coalesce(sum(date6),0) date6,"
		    	    		+ "  coalesce(sum(date7),0) date7,  coalesce(sum(date8),0) date8,"
		    	    		+ "  coalesce(sum(date9),0) date9,  coalesce(sum(date10),0) date10,"
		    	    		+ "  coalesce(sum(date11),0) date11,  coalesce(sum(date12),0) date12,"
		    	    		+ " coalesce(sum(date13),0) date13,  coalesce(sum(date14),0) date14,"
		    	    		+ " coalesce(sum(date15),0) date15,  coalesce(sum(date16),0) date16,"
		    	    		+ " coalesce(sum(date17),0) date17,  coalesce(sum(date18),0) date18,"
		    	    		+ " coalesce(sum(date19),0) date19,  coalesce(sum(date20),0) date20,"
		    	    		+ " coalesce(sum(date21),0) date21,  coalesce(sum(date22),0) date22, "
		    	    		+ " coalesce(sum(date23),0) date23,  coalesce(sum(date24),0) date24,"
		    	    		+ " coalesce(sum(date25),0) date25,  coalesce(sum(date26),0) date26,"
		    	    		+ " coalesce(sum(date27),0) date27,  coalesce(sum(date28),0) date28,"
		    	    		+ " coalesce(sum(date29),0) date29,  coalesce(sum(date30),0) date30,"
		    	    		+ " coalesce(sum(date31),0) date31, tot_leave1,clientaprvdhrs, "
		    	    		+ " confirmed,year,month  from hr_workdetails d left join hr_empm h on d.empid=h.doc_no "
		    	    		+ "where d.year='"+year+"' and d.month='"+month+"' "+sqltst+" "+sqlteam+" group by d.empid";
		    	    */
					/*
					 * String
					 * sql3="select tot.empId as emp,coalesce (name,'') empname , totdays,srno," +
					 * " coalesce(sum(date1),0) date1,  coalesce(sum(date2),0) date2," +
					 * "  coalesce(sum(date3),0) date3,  coalesce(sum(date4),0) date4," +
					 * " coalesce(sum(date5),0) date5,  coalesce(sum(date6),0) date6," +
					 * "  coalesce(sum(date7),0) date7,  coalesce(sum(date8),0) date8," +
					 * "  coalesce(sum(date9),0) date9,  coalesce(sum(date10),0) date10," +
					 * "  coalesce(sum(date11),0) date11,  coalesce(sum(date12),0) date12," +
					 * " coalesce(sum(date13),0) date13,  coalesce(sum(date14),0) date14," +
					 * " coalesce(sum(date15),0) date15,  coalesce(sum(date16),0) date16," +
					 * " coalesce(sum(date17),0) date17,  coalesce(sum(date18),0) date18," +
					 * " coalesce(sum(date19),0) date19,  coalesce(sum(date20),0) date20," +
					 * " coalesce(sum(date21),0) date21,  coalesce(sum(date22),0) date22, " +
					 * " coalesce(sum(date23),0) date23,  coalesce(sum(date24),0) date24," +
					 * " coalesce(sum(date25),0) date25,  coalesce(sum(date26),0) date26," +
					 * " coalesce(sum(date27),0) date27,  coalesce(sum(date28),0) date28," +
					 * " coalesce(sum(date29),0) date29,  coalesce(sum(date30),0) date30," +
					 * " coalesce(sum(date31),0) date31, tot_leave1,clientaprvdhrs, " +
					 * " confirmed,year,month  from (select coalesce (h.name,'') name ,w.* from "
					 * +db1+".hr_workdetails w left join (select distinct empid,dtype,refdocno,brhid from cm_srvassign  where dbname='"
					 * +db1+"' "+sqlteam+" and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+
					 * month+"'))) s on s.refdocno=w.costcode and s.dtype=w.costtype and w.empid=s.empid  and w.brhid=s.brhid   left join "
					 * +db1+".hr_empm h on w.empid=h.doc_no  where  month='"+month+"' and year='"
					 * +year+"'   and ( s.dtype is not null ) union " +
					 * "select  coalesce (h.name,'') name ,w.* from "
					 * +db2+".hr_workdetails w left join  (select distinct empid,dtype,refdocno,brhid from cm_srvassign  where dbname='"
					 * +db2+"' "+sqlteam+"   and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+
					 * month+"'))) s  on s.refdocno=w.costcode and s.dtype=w.costtype and w.empid=s.empid and month='"
					 * +month+"' and year='"+year+"'  and w.brhid=s.brhid  left join "
					 * +db2+".hr_empm h on w.empid=h.doc_no where  month='"+month+"' and year='"
					 * +year+"'  and ( s.dtype is not null ) union select coalesce (h.name,'') name ,w.* from "
					 * +db1+".hr_workdetails w inner join (select distinct empid from cm_srvassign  where dbname='"
					 * +db1+"' "+sqlteam+" and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+month+"'))) s on w.empid=s.empid  left join "
					 * +db1+".hr_empm h on w.empid=h.doc_no  where  month='"+month+"' and year='"
					 * +year+"'   and ( w.costtype = 'COST' ) union " +
					 * "select  coalesce (h.name,'') name ,w.* from "
					 * +db2+".hr_workdetails w inner join  (select distinct empid from cm_srvassign  where dbname='"
					 * +db2+"' "+sqlteam+"   and concat('"+year+"','"+
					 * month+"')  between  concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), lpad(month(inactivedate),2,0)) ,concat('"
					 * +year+"','"+month+"'))) s  on  w.empid=s.empid   left join "
					 * +db2+".hr_empm h on w.empid=h.doc_no where  month='"+month+"' and year='"
					 * +year+"'  and ( w.costtype = 'COST' ) ) tot  group by tot.empid  ";
					 */
			    /*	
			    	String sql3="select tot.empId as emp,coalesce (name,'') empname , sum(totdays) totdays,srno, coalesce(sum(date1),0) date1,"
			    			+ "  coalesce(sum(date2),0) date2,  coalesce(sum(date3),0) date3,  coalesce(sum(date4),0) date4,"
			    			+ " coalesce(sum(date5),0) date5,  coalesce(sum(date6),0) date6,  coalesce(sum(date7),0) date7,"
			    			+ "  coalesce(sum(date8),0) date8,  coalesce(sum(date9),0) date9,  coalesce(sum(date10),0) date10,"
			    			+ "  coalesce(sum(date11),0) date11,  coalesce(sum(date12),0) date12, coalesce(sum(date13),0) date13, "
			    			+ " coalesce(sum(date14),0) date14, coalesce(sum(date15),0) date15,  coalesce(sum(date16),0) date16,"
			    			+ " coalesce(sum(date17),0) date17,  coalesce(sum(date18),0) date18, coalesce(sum(date19),0) date19,"
			    			+ "  coalesce(sum(date20),0) date20, coalesce(sum(date21),0) date21,  coalesce(sum(date22),0) date22,"
			    			+ "  coalesce(sum(date23),0) date23,  coalesce(sum(date24),0) date24, coalesce(sum(date25),0) date25, "
			    			+ " coalesce(sum(date26),0) date26, coalesce(sum(date27),0) date27,  coalesce(sum(date28),0) date28,"
			    			+ " coalesce(sum(date29),0) date29,  coalesce(sum(date30),0) date30, coalesce(sum(date31),0) date31,"
			    			+ " tot_leave1,clientaprvdhrs,  confirmed,year,month  from "
			    			+ " (select coalesce (m.name,'') name ,w.* from (select distinct empid from cm_srvassign  "
			    			+ "where dbname='"+db1+"' "+sqlteam+"  and concat('"+year+"','"+month+"')  between  "
			    			+ "concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), "
			    			+ "lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"'))) s "
			    			+ "inner join "+db1+".hr_empm m on m.doc_no=s.empid "
			    			+ "inner join "+db1+".hr_workdetails w on m.doc_no=w.empid  "
			    			+ "where  month='"+month+"' and year='"+year+"' "
			    			+ "union all "
			    			+ "select coalesce (m.name,'') name ,w.* from (select distinct empid from cm_srvassign "
			    			+ " where dbname='"+db2+"' "+sqlteam+"  and concat('"+year+"','"+month+"')  between "
			    			+ " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), "
			    			+ " lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"'))) s "
			    			+" inner join "+db2+".hr_empm m on m.doc_no=s.empid "
			    			+ "inner join "+db2+".hr_workdetails w on m.doc_no=w.empid  "
			    			+ "where  month='"+month+"' and year='"+year+"' ) tot  group by tot.empid ";

*/
			    	String sql3="select tot.empgrpid,tot.empId as emp,coalesce (name,'') empname , sum(totdays) totdays,srno,convert(if(sum(date1)=0.00,'', coalesce(sum(date1),0)),char(25)) date1,"
                            + " convert(if(sum(date2)=0,'', coalesce(sum(date2),0)),char(25)) date2, convert(if(sum(date3)=0.00,'', coalesce(sum(date3),0)),char(25)) date3, convert(if(sum(date4)=0.00,'', coalesce(sum(date4),0)),char(25)) date4,"
                            + " convert(if(sum(date5)=0.00,'',coalesce(sum(date5),0)),char(25)) date5,  convert(if(sum(date6)=0.00,'',coalesce(sum(date6),0)),char(25)) date6,  convert(if(sum(date7)=0.00,'',coalesce(sum(date7),0)),char(25)) date7,"
                            + " convert(if(sum(date8)=0.00,'', coalesce(sum(date8),0)),char(25)) date8,  convert(if(sum(date9)=0.00,'',coalesce(sum(date9),0)),char(25)) date9,  convert(if(sum(date10)=0.00,'',coalesce(sum(date10),0)),char(25)) date10,"
                            + " convert(if(sum(date11)=0.00,'', coalesce(sum(date11),0)),char(25)) date11, convert(if(sum(date12)=0.00,'', coalesce(sum(date12),0)),char(25)) date12,convert(if(sum(date13)=0.00,'', coalesce(sum(date13),0)),char(25)) date13, "
                            + " convert(if(sum(date14)=0.00,'',coalesce(sum(date14),0)),char(25)) date14, convert(if(sum(date15)=0.00,'',coalesce(sum(date15),0)),char(25)) date15, convert(if(sum(date16)=0.00,'', coalesce(sum(date16),0)),char(25)) date16,"
                            + " convert(if(sum(date17)=0.00,'',coalesce(sum(date17),0)),char(25)) date17, convert(if(sum(date18)=0.00,'', coalesce(sum(date18),0)),char(25)) date18,convert(if(sum(date19)=0.00,'', coalesce(sum(date19),0)),char(25)) date19,"
                            + " convert(if(sum(date20)=0.00,'', coalesce(sum(date20),0)),char(25)) date20, convert(if(sum(date21)=0.00,'',coalesce(sum(date21),0)),char(25)) date21, convert(if(sum(date22)=0.00,'', coalesce(sum(date22),0)),char(25)) date22,"
                            + " convert(if(sum(date23)=0.00,'', coalesce(sum(date23),0)),char(25)) date23, convert(if(sum(date24)=0.00,'', coalesce(sum(date24),0)),char(25)) date24,convert(if(sum(date25)=0.00,'', coalesce(sum(date25),0)),char(25)) date25, "
                            + " convert(if(sum(date26)=0.00,'', coalesce(sum(date26),0)),char(25)) date26, convert(if(sum(date27)=0.00,'',coalesce(sum(date27),0)),char(25)) date27, convert(if(sum(date28)=0.00,'', coalesce(sum(date28),0)),char(25)) date28,"
                            + " convert(if(sum(date29)=0.00,'',coalesce(sum(date29),0)),char(25)) date29,  convert(if(sum(date30)=0.00,'',coalesce(sum(date30),0)),char(25)) date30,convert(if(sum(date31)=0.00,'', coalesce(sum(date31),0)),char(25)) date31,"
                            + " tot_leave1,clientaprvdhrs,  confirmed,year,month  from "
                            + " (select coalesce (m.name,'') name ,empgrpid,w.* from (select distinct empid,empgroupid empgrpid,refdocno,dtype from cm_srvassign  "
                            + " where dbname='"+db1+"' "+sqlteam+"  and concat('"+year+"','"+month+"')  between  "
                            + "concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), "
                            + "lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"'))) s "
                            + "inner join "+db1+".hr_empm m on m.doc_no=s.empid "
                            + "inner join "+db1+".hr_workdetails w on m.doc_no=w.empid and s.refdocno=w.costcode and s.dtype=w.costtype "
                            + " where  month='"+month+"' and year='"+year+"' and w.costtype!='COST' " 
                            + "union all "
                            + " select coalesce (m.name,'') name ,empgrpid,w.* from (select distinct empid,empgroupid empgrpid,refdocno,dtype from cm_srvassign "
                            + " where dbname='"+db2+"' "+sqlteam+"  and concat('"+year+"','"+month+"')  between "
                            + " concat(year(plannedon),lpad(month(plannedon),2,0)) and coalesce(concat(year(inactivedate), "
                            + " lpad(month(inactivedate),2,0)) ,concat('"+year+"','"+month+"'))) s "
                            +" inner join "+db2+".hr_empm m on m.doc_no=s.empid "
                            + " inner join "+db2+".hr_workdetails w on m.doc_no=w.empid  and s.refdocno=w.costcode and s.dtype=w.costtype"
                            + " where  month='"+month+"' and year='"+year+"' and w.costtype!='COST' "+sqlteam1+" ) tot  group by tot.empid ";

 

			    	
			 //   	System.out.println("---=wda====--------==1st grid=====--------======"+sql3);
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

		
		
		public JSONArray commentsGrid(String year,String month) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtCRM = conn.createStatement();
					
					String sql = "select wc.doc_no,wc.costcode,wc.costtype,wc.empid,wc.dbname,wc.date,wc.comments,h.name emp,'Clear' Clear from hr_workcomments wc left join hr_empm h on h.doc_no=wc.empid where year(wc.date)='"+year+"' and month(wc.date)='"+month+"' and wc.clear=0 ";
					
					ResultSet resultSet = stmtCRM.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtCRM.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }

		
		
		
		public JSONArray attendanceGridLoadingExcelExport(HttpSession session,String totaldays,String year,String month,String day,String department,String category,String empid) throws SQLException {
		    
			Connection conn=null;
		    JSONArray RESULTDATA=new JSONArray();

		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtATTN = conn.createStatement();
			        Statement stmtATTN1 = conn.createStatement();
			        
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
			             
			        String branchid=session.getAttribute("BRANCHID").toString();
		    	    
			        String sql="",sql1="",leave1="",leave2="",leave3="",leave4="",leave5="",leave6="",leave7="",leave8="",leave9="",leave10="";

			        String sqls="select doc_no,desc1 from hr_setleave where status=3";
		    	    ResultSet resultSets = stmtATTN1.executeQuery(sqls);
		    	    
		    	    while(resultSets.next()){
		    	    	if(resultSets.getInt("doc_no")==1){
		    	    		leave1 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave1,0),1) '"+leave1+"',";
		    	    	} else if(resultSets.getInt("doc_no")==2){
		    	    		leave2 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave2,0),1) '"+leave2+"',";
		    	    	} else if(resultSets.getInt("doc_no")==3){
		    	    		leave3 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave3,0),1) '"+leave3+"',";
		    	    	} else if(resultSets.getInt("doc_no")==4){
		    	    		leave4 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave4,0),1) '"+leave4+"',";
		    	    	}else if(resultSets.getInt("doc_no")==5){
		    	    		leave5 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave5,0),1) '"+leave5+"',";
		    	    	}else if(resultSets.getInt("doc_no")==6){
		    	    		leave6 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave6,0),1) '"+leave6+"',";
		    	    	}else if(resultSets.getInt("doc_no")==7){
		    	    		leave7 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave7,0),1) '"+leave7+"',";
		    	    	}else if(resultSets.getInt("doc_no")==8){
		    	    		leave8 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave8,0),1) '"+leave8+"',";
		    	    	}else if(resultSets.getInt("doc_no")==9){
		    	    		leave9 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave9,0),1) '"+leave9+"',";
		    	    	}else if(resultSets.getInt("doc_no")==10){
		    	    		leave10 = resultSets.getString("desc1");
		    	    		sql1=sql1+"round(coalesce(t.tot_leave10,0),1) '"+leave10+"',";
		    	    	}
		    	    }
					
		            if(!(department.equalsIgnoreCase(""))){
		            	sql=sql+" and m.dept_id like '%"+department+"%'";
		            }
		            if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and m.pay_catid like '%"+category+"%'";
		            }
		            if(!(empid.equalsIgnoreCase(""))){
		                sql=sql+" and m.doc_no like '%"+empid+"%'";
		            }
		            
		            String sql7 = "select method from gl_config where field_nme='HRAttendanceLeaveEditEnable'";
		            ResultSet resultSet7 = stmtATTN1.executeQuery(sql7);
		            String method="";
					while(resultSet7.next()) {
						method=resultSet7.getString("method");
					}
					
					if(method.equalsIgnoreCase("1")) {
						
						/*Attendance Leave Edit Enable*/
						
						sql = "select m.codeno 'Emp. ID',UPPER(m.name) 'Emp. Name',t.totdays 'Days',coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) 'DAY 01',"  
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) 'DAY 02',coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) 'DAY 03',"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) 'DAY 04',coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) 'DAY 05',"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) 'DAY 06',coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) 'DAY 07',"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) 'DAY 08',coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) 'DAY 09',"  
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) 'DAY 10',coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) 'DAY 11',"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) 'DAY 12',coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) 'DAY 13',"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) 'DAY 14',coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) 'DAY 15'," 
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) 'DAY 16',coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) 'DAY 17',"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) 'DAY 18',coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) 'DAY 19',"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) 'DAY 20',coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) 'DAY 21',"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) 'DAY 22',coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) 'DAY 23',"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) 'DAY 24',coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) 'DAY 25',"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) 'DAY 26',coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) 'DAY 27',"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) 'DAY 28',coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) 'DAY 29',"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) 'DAY 30',coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) 'DAY 31',"+sql1+""
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) 'Over Time',"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) 'Holiday Over Time' from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
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
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Enable Ends*/
						
					} else {
		            
						/*Attendance Leave Edit Disable */
						
						sql = "select m.codeno 'Emp. ID',UPPER(m.name) 'Emp. Name',t.totdays 'Days',coalesce(s.alpha,SUBSTRING(SEC_TO_TIME(t.date1*60),1,5)) 'DAY 01'," 
								+ "coalesce(s1.alpha,SUBSTRING(SEC_TO_TIME(t.date2*60),1,5)) 'DAY 02',coalesce(s2.alpha,SUBSTRING(SEC_TO_TIME(t.date3*60),1,5)) 'DAY 03',"  
								+ "coalesce(s3.alpha,SUBSTRING(SEC_TO_TIME(t.date4*60),1,5)) 'DAY 04',coalesce(s4.alpha,SUBSTRING(SEC_TO_TIME(t.date5*60),1,5)) 'DAY 05',"  
								+ "coalesce(s5.alpha,SUBSTRING(SEC_TO_TIME(t.date6*60),1,5)) 'DAY 06',coalesce(s6.alpha,SUBSTRING(SEC_TO_TIME(t.date7*60),1,5)) 'DAY 07',"  
								+ "coalesce(s7.alpha,SUBSTRING(SEC_TO_TIME(t.date8*60),1,5)) 'DAY 08',coalesce(s8.alpha,SUBSTRING(SEC_TO_TIME(t.date9*60),1,5)) 'DAY 09'," 
								+ "coalesce(s9.alpha,SUBSTRING(SEC_TO_TIME(t.date10*60),1,5)) 'DAY 10',coalesce(s10.alpha,SUBSTRING(SEC_TO_TIME(t.date11*60),1,5)) 'DAY 11',"  
								+ "coalesce(s11.alpha,SUBSTRING(SEC_TO_TIME(t.date12*60),1,5)) 'DAY 12',coalesce(s12.alpha,SUBSTRING(SEC_TO_TIME(t.date13*60),1,5)) 'DAY 13',"  
								+ "coalesce(s13.alpha,SUBSTRING(SEC_TO_TIME(t.date14*60),1,5)) 'DAY 14',coalesce(s14.alpha,SUBSTRING(SEC_TO_TIME(t.date15*60),1,5)) 'DAY 15',"  
								+ "coalesce(s15.alpha,SUBSTRING(SEC_TO_TIME(t.date16*60),1,5)) 'DAY 16',coalesce(s16.alpha,SUBSTRING(SEC_TO_TIME(t.date17*60),1,5)) 'DAY 17',"  
								+ "coalesce(s17.alpha,SUBSTRING(SEC_TO_TIME(t.date18*60),1,5)) 'DAY 18',coalesce(s18.alpha,SUBSTRING(SEC_TO_TIME(t.date19*60),1,5)) 'DAY 19',"  
								+ "coalesce(s19.alpha,SUBSTRING(SEC_TO_TIME(t.date20*60),1,5)) 'DAY 20',coalesce(s20.alpha,SUBSTRING(SEC_TO_TIME(t.date21*60),1,5)) 'DAY 21',"  
								+ "coalesce(s21.alpha,SUBSTRING(SEC_TO_TIME(t.date22*60),1,5)) 'DAY 22',coalesce(s22.alpha,SUBSTRING(SEC_TO_TIME(t.date23*60),1,5)) 'DAY 23',"  
								+ "coalesce(s23.alpha,SUBSTRING(SEC_TO_TIME(t.date24*60),1,5)) 'DAY 24',coalesce(s24.alpha,SUBSTRING(SEC_TO_TIME(t.date25*60),1,5)) 'DAY 25',"  
								+ "coalesce(s25.alpha,SUBSTRING(SEC_TO_TIME(t.date26*60),1,5)) 'DAY 26',coalesce(s26.alpha,SUBSTRING(SEC_TO_TIME(t.date27*60),1,5)) 'DAY 27',"  
								+ "coalesce(s27.alpha,SUBSTRING(SEC_TO_TIME(t.date28*60),1,5)) 'DAY 28',coalesce(s28.alpha,SUBSTRING(SEC_TO_TIME(t.date29*60),1,5)) 'DAY 29',"  
								+ "coalesce(s29.alpha,SUBSTRING(SEC_TO_TIME(t.date30*60),1,5)) 'DAY 30',coalesce(s30.alpha,SUBSTRING(SEC_TO_TIME(t.date31*60),1,5)) 'DAY 31',"+sql1+""
								+ "CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) 'Over Time',"
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) 'Holiday Over Time' from "
								+ "hr_empm m left join hr_timesheet t on m.doc_no=t.empid and t.year='"+year+"' and t.month='"+month+"' left join hr_timesheetset s on s.refno=t.date1 "
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
								+ "left join hr_timesheetset s30 on s30.refno=t.date31 where m.status=3 and m.dtjoin<=LAST_DAY('"+year+"-"+month+"-"+day+"')"+sql+" order by m.doc_no";
					
						/*Attendance Leave Edit Disable Ends*/
					}
					//System.out.println("===== "+sql);
					ResultSet resultSet = stmtATTN.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					
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
		
		public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String employeebranchchk,String brhid) throws SQLException {
		    Connection conn=null;
		   
		    JSONArray RESULTDATA1=new JSONArray();
		
		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtATTN = conn.createStatement();
				
		    	    String sql = "";
					
		    	    if(!(empid.equalsIgnoreCase(""))){
		                sql=sql+" and codeno like '%"+empid+"%'";
		            }
		            if(!(employeename.equalsIgnoreCase(""))){
		             sql=sql+" and name like '%"+employeename+"%'";
		            }
		            if(!(contact.equalsIgnoreCase(""))){
		                sql=sql+" and pmmob like '%"+contact+"%'";
		            }
		            if(employeebranchchk.equalsIgnoreCase("1")){    
		            	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0"))){  
		            		sql=sql+" and brhid='"+brhid+"'";   
		            	}
		            }
		            
					sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where active=1 and status=3"+sql+"  order by name";
					//System.out.println("sql--->>>"+sql);   
					ResultSet resultSet1 = stmtATTN.executeQuery(sql);
					
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
					
					stmtATTN.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		    return RESULTDATA1;
		}

		
		
		public int insert(String month,String year, ArrayList<String> timesheetarray, HttpSession session, HttpServletRequest request,String mode,String empid) throws SQLException {
			
			Connection conn  = null;
			  
			try{
				
				 conn=ClsConnection.getMyConnection();
				 conn.setAutoCommit(false);
				 Statement stmtBHTS = conn.createStatement();
				
				 String branch=session.getAttribute("BRANCHID").toString().trim();
				 String userid=session.getAttribute("USERID").toString().trim();
				 
					for(int i=0;i< timesheetarray.size();i++)
					{
					String[] timesheet=timesheetarray.get(i).split("::");
                    String sql11="";
                   
					String[] srno=timesheet[43].split(",");
					
				//	String[] db=timesheet[44].split(",");

					 for(int j=0;j< srno.length;j++)
						{
							String srnos=srno[j];	
						//	String dbs=db[j];	

				//	System.out.println("dbname="+dbs);
                  		if(!(timesheet[40].trim().equalsIgnoreCase("undefined")|| timesheet[40].trim().equalsIgnoreCase("NaN")||timesheet[40].trim().equalsIgnoreCase("")||timesheet[40].trim().equalsIgnoreCase("null")|| timesheet[40].isEmpty()))
						{
                        if(timesheet[40].trim().equalsIgnoreCase(srnos))
                        {
						  sql11=" update "+timesheet[44].trim()+".hr_workdetails set totdays="
							    + "'"+(timesheet[3].trim().equalsIgnoreCase("undefined") || timesheet[3].trim().equalsIgnoreCase("NaN") || timesheet[3].trim().equalsIgnoreCase("") ||timesheet[3].trim().isEmpty()?"0.00":timesheet[3].trim())+"',"
                                + "date1="
								+ "'"+(timesheet[9].trim().equalsIgnoreCase("undefined") || timesheet[9].trim().equalsIgnoreCase("NaN") || timesheet[9].trim().equalsIgnoreCase("") ||timesheet[9].trim().isEmpty()?"0.00":timesheet[9].trim())+"',"
						 		+ "date2="
						 		+ "'"+(timesheet[10].trim().equalsIgnoreCase("undefined") || timesheet[10].trim().equalsIgnoreCase("NaN") || timesheet[10].trim().equalsIgnoreCase("") ||timesheet[10].trim().isEmpty()?"0.00":timesheet[10].trim())+"',"
						 		+ "date3="
							    + "'"+(timesheet[11].trim().equalsIgnoreCase("undefined") || timesheet[11].trim().equalsIgnoreCase("NaN") || timesheet[11].trim().equalsIgnoreCase("") ||timesheet[11].trim().isEmpty()?"0.00":timesheet[11].trim())+"',"

						 		+ "date4="
							    + "'"+(timesheet[12].trim().equalsIgnoreCase("undefined") || timesheet[12].trim().equalsIgnoreCase("NaN") || timesheet[12].trim().equalsIgnoreCase("") ||timesheet[12].trim().isEmpty()?"0.00":timesheet[12].trim())+"',"

						 		+ "date5="
								 + "'"+(timesheet[13].trim().equalsIgnoreCase("undefined") || timesheet[13].trim().equalsIgnoreCase("NaN") || timesheet[13].trim().equalsIgnoreCase("") ||timesheet[13].trim().isEmpty()?"0.00":timesheet[13].trim())+"',"

						 		+ "date6="
								 + "'"+(timesheet[14].trim().equalsIgnoreCase("undefined") || timesheet[14].trim().equalsIgnoreCase("NaN") || timesheet[14].trim().equalsIgnoreCase("") ||timesheet[14].trim().isEmpty()?"0.00":timesheet[14].trim())+"',"

						 		+ "date7="
								 + "'"+(timesheet[15].trim().equalsIgnoreCase("undefined") || timesheet[15].trim().equalsIgnoreCase("NaN") || timesheet[15].trim().equalsIgnoreCase("") ||timesheet[15].trim().isEmpty()?"0.00":timesheet[15].trim())+"',"

						 		+ "date8="
								 + "'"+(timesheet[16].trim().equalsIgnoreCase("undefined") || timesheet[16].trim().equalsIgnoreCase("NaN") || timesheet[16].trim().equalsIgnoreCase("") ||timesheet[16].trim().isEmpty()?"0.00":timesheet[16].trim())+"',"

						 		+ "date9="
								 + "'"+(timesheet[17].trim().equalsIgnoreCase("undefined") || timesheet[17].trim().equalsIgnoreCase("NaN") || timesheet[17].trim().equalsIgnoreCase("") ||timesheet[17].trim().isEmpty()?"0.00":timesheet[17].trim())+"',"

						 		+ "date10="
								 + "'"+(timesheet[18].trim().equalsIgnoreCase("undefined") || timesheet[18].trim().equalsIgnoreCase("NaN") || timesheet[18].trim().equalsIgnoreCase("") ||timesheet[18].trim().isEmpty()?"0.00":timesheet[18].trim())+"',"

						 		+ "date11="
								 + "'"+(timesheet[19].trim().equalsIgnoreCase("undefined") || timesheet[19].trim().equalsIgnoreCase("NaN") || timesheet[19].trim().equalsIgnoreCase("") ||timesheet[19].trim().isEmpty()?"0.00":timesheet[19].trim())+"',"

						 		+ "date12="
								 + "'"+(timesheet[20].trim().equalsIgnoreCase("undefined") || timesheet[20].trim().equalsIgnoreCase("NaN") || timesheet[20].trim().equalsIgnoreCase("") ||timesheet[20].trim().isEmpty()?"0.00":timesheet[20].trim())+"',"

						 		+ "date13="
								 + "'"+(timesheet[21].trim().equalsIgnoreCase("undefined") || timesheet[21].trim().equalsIgnoreCase("NaN") || timesheet[21].trim().equalsIgnoreCase("") ||timesheet[21].trim().isEmpty()?"0.00":timesheet[21].trim())+"',"

						 		+ "date14="
								 + "'"+(timesheet[22].trim().equalsIgnoreCase("undefined") || timesheet[22].trim().equalsIgnoreCase("NaN") || timesheet[22].trim().equalsIgnoreCase("") ||timesheet[22].trim().isEmpty()?"0.00":timesheet[22].trim())+"',"

						 		+ "date15="
								 + "'"+(timesheet[23].trim().equalsIgnoreCase("undefined") || timesheet[23].trim().equalsIgnoreCase("NaN") || timesheet[23].trim().equalsIgnoreCase("") ||timesheet[23].trim().isEmpty()?"0.00":timesheet[23].trim())+"',"

						 		+ "date16="
								 + "'"+(timesheet[24].trim().equalsIgnoreCase("undefined") || timesheet[24].trim().equalsIgnoreCase("NaN") || timesheet[24].trim().equalsIgnoreCase("") ||timesheet[24].trim().isEmpty()?"0.00":timesheet[24].trim())+"',"

						 		+ "date17="
								 + "'"+(timesheet[25].trim().equalsIgnoreCase("undefined") || timesheet[25].trim().equalsIgnoreCase("NaN") || timesheet[25].trim().equalsIgnoreCase("") ||timesheet[25].trim().isEmpty()?"0.00":timesheet[25].trim())+"',"

						 		+ "date18="
								 + "'"+(timesheet[26].trim().equalsIgnoreCase("undefined") || timesheet[26].trim().equalsIgnoreCase("NaN") || timesheet[26].trim().equalsIgnoreCase("") ||timesheet[26].trim().isEmpty()?"0.00":timesheet[26].trim())+"',"

						 		+ "date19="
								 + "'"+(timesheet[27].trim().equalsIgnoreCase("undefined") || timesheet[27].trim().equalsIgnoreCase("NaN") || timesheet[27].trim().equalsIgnoreCase("") ||timesheet[27].trim().isEmpty()?"0.00":timesheet[27].trim())+"',"

						 		+ "date20="
								 + "'"+(timesheet[28].trim().equalsIgnoreCase("undefined") || timesheet[28].trim().equalsIgnoreCase("NaN") || timesheet[28].trim().equalsIgnoreCase("") ||timesheet[28].trim().isEmpty()?"0.00":timesheet[28].trim())+"',"

						 		+ "date21="
								 + "'"+(timesheet[29].trim().equalsIgnoreCase("undefined") || timesheet[29].trim().equalsIgnoreCase("NaN") || timesheet[29].trim().equalsIgnoreCase("") ||timesheet[29].trim().isEmpty()?"0.00":timesheet[29].trim())+"',"

						 		+ "date22="
								 + "'"+(timesheet[30].trim().equalsIgnoreCase("undefined") || timesheet[30].trim().equalsIgnoreCase("NaN") || timesheet[30].trim().equalsIgnoreCase("") ||timesheet[30].trim().isEmpty()?"0.00":timesheet[30].trim())+"',"

						 		+ "date23="
								 + "'"+(timesheet[31].trim().equalsIgnoreCase("undefined") || timesheet[31].trim().equalsIgnoreCase("NaN") || timesheet[31].trim().equalsIgnoreCase("") ||timesheet[31].trim().isEmpty()?"0.00":timesheet[31].trim())+"',"

						 		+ "date24="
								 + "'"+(timesheet[32].trim().equalsIgnoreCase("undefined") || timesheet[32].trim().equalsIgnoreCase("NaN") || timesheet[32].trim().equalsIgnoreCase("") ||timesheet[32].trim().isEmpty()?"0.00":timesheet[32].trim())+"',"

						 		+ "date25="
								 + "'"+(timesheet[33].trim().equalsIgnoreCase("undefined") || timesheet[33].trim().equalsIgnoreCase("NaN") || timesheet[33].trim().equalsIgnoreCase("") ||timesheet[33].trim().isEmpty()?"0.00":timesheet[33].trim())+"',"

						 		+ "date26="
								 + "'"+(timesheet[34].trim().equalsIgnoreCase("undefined") || timesheet[34].trim().equalsIgnoreCase("NaN") || timesheet[34].trim().equalsIgnoreCase("") ||timesheet[34].trim().isEmpty()?"0.00":timesheet[34].trim())+"',"

						 		+ "date27="
								 + "'"+(timesheet[35].trim().equalsIgnoreCase("undefined") || timesheet[35].trim().equalsIgnoreCase("NaN") || timesheet[35].trim().equalsIgnoreCase("") ||timesheet[35].trim().isEmpty()?"0.00":timesheet[35].trim())+"',"

						 		+ "date28="
								 + "'"+(timesheet[36].trim().equalsIgnoreCase("undefined") || timesheet[36].trim().equalsIgnoreCase("NaN") || timesheet[36].trim().equalsIgnoreCase("") ||timesheet[36].trim().isEmpty()?"0.00":timesheet[36].trim())+"',"

						 		+ "date29="
								 + "'"+(timesheet[37].trim().equalsIgnoreCase("undefined") || timesheet[37].trim().equalsIgnoreCase("NaN") || timesheet[37].trim().equalsIgnoreCase("") ||timesheet[37].trim().isEmpty()?"0.00":timesheet[37].trim())+"',"

						 		+ "date30="
								 + "'"+(timesheet[38].trim().equalsIgnoreCase("undefined") || timesheet[38].trim().equalsIgnoreCase("NaN") || timesheet[38].trim().equalsIgnoreCase("") ||timesheet[38].trim().isEmpty()?"0.00":timesheet[38].trim())+"',"
										
								 + "confirmed="
								  + "'"+(timesheet[41].trim().equalsIgnoreCase("undefined") || timesheet[41].trim().equalsIgnoreCase("NaN") || timesheet[41].trim().equalsIgnoreCase("") ||timesheet[41].trim().isEmpty()?"0":timesheet[41].trim())+"',"

						 		+ "date31= "
								 + "'"+(timesheet[39].trim().equalsIgnoreCase("undefined") || timesheet[39].trim().equalsIgnoreCase("NaN") || timesheet[39].trim().equalsIgnoreCase("") ||timesheet[39].trim().isEmpty()?"0.00":timesheet[39].trim())+"', "
								 + "clientaprvdhrs="
								 + "'"+(timesheet[42].trim().equalsIgnoreCase("undefined") || timesheet[42].trim().equalsIgnoreCase("NaN") || timesheet[42].trim().equalsIgnoreCase("") ||timesheet[42].trim().isEmpty()?"0":timesheet[42].trim())+"'"		
								 
								 + " where srno='"+srnos.trim()+"' ";
						
						  
					//	System.out.println("%%%%%%"+sql11);
					
					 int data = stmtBHTS.executeUpdate(sql11);
					
				     if(data<=0){
						    conn.close();
							return 0;
						}
                        }
    					
						}
					}
					}
					conn.commit();
			 } catch(Exception e){	
				 	conn.close();
				 	e.printStackTrace();	
			 } finally{
				 conn.close();
			 }
			return 1;
			}
			
}
		

