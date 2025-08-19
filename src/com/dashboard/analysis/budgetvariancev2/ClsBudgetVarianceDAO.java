package com.dashboard.analysis.budgetvariancev2;  

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBudgetVarianceDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray budgetVarianceLoad(String branch,String fromdate,String todate,String level1,String level2, String level3, String level4, String check, double rate, String onedaylessdt, String entrydate) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 if(!check.equals("1")){  
			 return RESULTDATA;
		 }
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1 = "",sql2="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and a.brhid in ("+branch+")";
		     }
		    // System.out.println("level1="+level1+"=level2="+level2+"=level3="+level3+"=level4="+level4);
            if(level1.equalsIgnoreCase("1")){  
            	sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpAmtba=0,'',round(k.grpAmtba,2)),CHAR(100)) grpAmtba,CONVERT(if(k.netAmtba=0,'',round(k.netAmtba,2)),CHAR(100)) netAmtba,CONVERT(if(k.childAmtba=0,'',round(k.childAmtba,2)),CHAR(100)) childAmtba,CONVERT(if(k.subchildAmtba=0,'',round(k.subchildAmtba,2)),CHAR(100)) subchildAmtba, CONVERT(if(k.grpAmtam=0,'',round(k.grpAmtam,2)),CHAR(100)) grpAmtam,CONVERT(if(k.netAmtam=0,'',round(k.netAmtam,2)),CHAR(100)) netAmtam,CONVERT(if(k.childAmtam=0,'',round(k.childAmtam,2)),CHAR(100)) childAmtam,CONVERT(if(k.subchildAmtam=0,'',round(k.subchildAmtam,2)),CHAR(100)) subchildAmtam, CONVERT(if(k.grpAmtva=0,'',round(k.grpAmtva,2)),CHAR(100)) grpAmtva,CONVERT(if(k.netAmtva=0,'',round(k.netAmtva,2)),CHAR(100)) netAmtva,CONVERT(if(k.childAmtva=0,'',round(k.childAmtva,2)),CHAR(100)) childAmtva,CONVERT(if(k.subchildAmtva=0,'',round(k.subchildAmtva,2)),CHAR(100)) subchildAmtva,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end),CHAR(100)) code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
 			    	 	+ "0 subac,gp_desc description,0 budgetamount, 0 mainamtba,0 agrpAmtba,0 grpAmtba,0 netAmtba,0 childAmtba,0 subchildAmtba,0 actualamount, 0 mainamtam,0 agrpAmtam,0 grpAmtam,0 netAmtam,0 childAmtam,0 subchildAmtam,0 varianceamount, 0 mainamtva,0 agrpAmtva,0 grpAmtva,0 netAmtva,0 childAmtva,0 subchildAmtva,0 account from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
 			    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
 			    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount) budgetamount,if(subac is  null and groupno is not null,budgetamount,0) mainAmtba,if(den is  not null and groupno is  null,budgetamount,0) agrpAmtba,if(@xlevel=4,@xdramt,0) grpAmtba,if(@xlevel=5,@xdramt,0) netAmtba,if(@xlevel=3,@xdramt*1,0) childAmtba,if(@xlevel=6,@xdramt*1,0) subchildAmtba, @xdramt:=if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign) actualamount,if(subac is  null and groupno is not null,actualamount,0) mainAmtam,if(den is  not null and groupno is  null,actualamount,0) agrpAmtam,if(@xlevel=4,@xdramt,0) grpAmtam,if(@xlevel=5,@xdramt,0) netAmtam,if(@xlevel=3,@xdramt*1,0) childAmtam,if(@xlevel=6,@xdramt*1,0) subchildAmtam, @xdramt:=if(gp_id is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))*if(grpLevel=1,-1,1),(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))) varianceamount,if(subac is  null and groupno is not null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) mainAmtva,if(den is  not null and groupno is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) agrpAmtva,if(@xlevel=4,@xdramt,0) grpAmtva,if(@xlevel=5,@xdramt,0) netAmtva,if(@xlevel=3,@xdramt*1,0) childAmtva,if(@xlevel=6,@xdramt*1,0) subchildAmtva,account from (select a.doc_no subac,m.*,"
 			    	 	+ "sum(budgetamount) budgetamount, sum(actualamount) actualamount, sum(varianceamount) varianceamount, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
 			    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(select gr_type,a.account,a.description accountname,a.acno,sum(a.budget) budgetamount,sum(a.actualamount) actualamount, sum(a.budget)-sum(a.actualamount) varianceamount, a.brhid from (select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,h.gr_type, j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date between '"+sqlFromDate+"' and  last_day('"+sqlToDate+"')  and h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type, m.brhid from my_budgetm m left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.month between month('"+sqlFromDate+"') and month('"+sqlToDate+"')  and d.year between year('"+sqlFromDate+"') and year('"+sqlToDate+"')   and h.gr_type in (4,5)) a where 1=1 "+sql2+" group by a.acno having sum(a.actualamount)!=0 or sum(a.budget)!=0) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
 			    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno,description) k,(SELECT @i:= 0) as i where (k.netAmtba!=0 or k.grpAmtba!=0 or k.childAmtba!=0 or k.subchildAmtba!=0 or k.netAmtva!=0 or k.grpAmtva!=0 or k.childAmtva!=0 or k.subchildAmtva!=0 or k.netAmtam!=0 or k.grpAmtam!=0 or k.childAmtam!=0 or k.subchildAmtam!=0) and  ordno=5 order by gp_id,den,groupno,ordno,description";
            	
		     }else if(level2.equalsIgnoreCase("1")){
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpAmtba=0,'',round(k.grpAmtba,2)),CHAR(100)) grpAmtba,CONVERT(if(k.netAmtba=0,'',round(k.netAmtba,2)),CHAR(100)) netAmtba,CONVERT(if(k.childAmtba=0,'',round(k.childAmtba,2)),CHAR(100)) childAmtba,CONVERT(if(k.subchildAmtba=0,'',round(k.subchildAmtba,2)),CHAR(100)) subchildAmtba, CONVERT(if(k.grpAmtam=0,'',round(k.grpAmtam,2)),CHAR(100)) grpAmtam,CONVERT(if(k.netAmtam=0,'',round(k.netAmtam,2)),CHAR(100)) netAmtam,CONVERT(if(k.childAmtam=0,'',round(k.childAmtam,2)),CHAR(100)) childAmtam,CONVERT(if(k.subchildAmtam=0,'',round(k.subchildAmtam,2)),CHAR(100)) subchildAmtam, CONVERT(if(k.grpAmtva=0,'',round(k.grpAmtva,2)),CHAR(100)) grpAmtva,CONVERT(if(k.netAmtva=0,'',round(k.netAmtva,2)),CHAR(100)) netAmtva,CONVERT(if(k.childAmtva=0,'',round(k.childAmtva,2)),CHAR(100)) childAmtva,CONVERT(if(k.subchildAmtva=0,'',round(k.subchildAmtva,2)),CHAR(100)) subchildAmtva,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end),CHAR(100)) code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
	 			    	 	+ "0 subac,gp_desc description,0 budgetamount, 0 mainamtba,0 agrpAmtba,0 grpAmtba,0 netAmtba,0 childAmtba,0 subchildAmtba,0 actualamount, 0 mainamtam,0 agrpAmtam,0 grpAmtam,0 netAmtam,0 childAmtam,0 subchildAmtam,0 varianceamount, 0 mainamtva,0 agrpAmtva,0 grpAmtva,0 netAmtva,0 childAmtva,0 subchildAmtva,0 account from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
	 			    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
	 			    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount) budgetamount,if(subac is  null and groupno is not null,budgetamount,0) mainAmtba,if(den is  not null and groupno is  null,budgetamount,0) agrpAmtba,if(@xlevel=4,@xdramt,0) grpAmtba,if(@xlevel=5,@xdramt,0) netAmtba,if(@xlevel=3,@xdramt*1,0) childAmtba,if(@xlevel=6,@xdramt*1,0) subchildAmtba, @xdramt:=if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign) actualamount,if(subac is  null and groupno is not null,actualamount,0) mainAmtam,if(den is  not null and groupno is  null,actualamount,0) agrpAmtam,if(@xlevel=4,@xdramt,0) grpAmtam,if(@xlevel=5,@xdramt,0) netAmtam,if(@xlevel=3,@xdramt*1,0) childAmtam,if(@xlevel=6,@xdramt*1,0) subchildAmtam, @xdramt:=if(gp_id is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))*if(grpLevel=1,-1,1),(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))) varianceamount,if(subac is  null and groupno is not null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) mainAmtva,if(den is  not null and groupno is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) agrpAmtva,if(@xlevel=4,@xdramt,0) grpAmtva,if(@xlevel=5,@xdramt,0) netAmtva,if(@xlevel=3,@xdramt*1,0) childAmtva,if(@xlevel=6,@xdramt*1,0) subchildAmtva,account from (select a.doc_no subac,m.*,"
	 			    	 	+ "sum(budgetamount) budgetamount, sum(actualamount) actualamount, sum(varianceamount) varianceamount, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
	 			    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(select gr_type,a.account,a.description accountname,a.acno,sum(a.budget) budgetamount,sum(a.actualamount) actualamount, sum(a.budget)-sum(a.actualamount) varianceamount, a.brhid from (select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,h.gr_type, j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date between '"+sqlFromDate+"' and  last_day('"+sqlToDate+"')  and h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type, m.brhid from my_budgetm m left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.month between month('"+sqlFromDate+"') and month('"+sqlToDate+"')  and d.year between year('"+sqlFromDate+"') and year('"+sqlToDate+"')   and h.gr_type in (4,5)) a where 1=1 "+sql2+" group by a.acno having sum(a.actualamount)!=0 or sum(a.budget)!=0) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
	 			    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno,description) k,(SELECT @i:= 0) as i where (k.netAmtba!=0 or k.grpAmtba!=0 or k.childAmtba!=0 or k.subchildAmtba!=0 or k.netAmtva!=0 or k.grpAmtva!=0 or k.childAmtva!=0 or k.subchildAmtva!=0 or k.netAmtam!=0 or k.grpAmtam!=0 or k.childAmtam!=0 or k.subchildAmtam!=0) and  ordno in (5,3) order by gp_id,den,groupno,ordno,description";
	            
		     }else if(level3.equalsIgnoreCase("1")){
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpAmtba=0,'',round(k.grpAmtba,2)),CHAR(100)) grpAmtba,CONVERT(if(k.netAmtba=0,'',round(k.netAmtba,2)),CHAR(100)) netAmtba,CONVERT(if(k.childAmtba=0,'',round(k.childAmtba,2)),CHAR(100)) childAmtba,CONVERT(if(k.subchildAmtba=0,'',round(k.subchildAmtba,2)),CHAR(100)) subchildAmtba, CONVERT(if(k.grpAmtam=0,'',round(k.grpAmtam,2)),CHAR(100)) grpAmtam,CONVERT(if(k.netAmtam=0,'',round(k.netAmtam,2)),CHAR(100)) netAmtam,CONVERT(if(k.childAmtam=0,'',round(k.childAmtam,2)),CHAR(100)) childAmtam,CONVERT(if(k.subchildAmtam=0,'',round(k.subchildAmtam,2)),CHAR(100)) subchildAmtam, CONVERT(if(k.grpAmtva=0,'',round(k.grpAmtva,2)),CHAR(100)) grpAmtva,CONVERT(if(k.netAmtva=0,'',round(k.netAmtva,2)),CHAR(100)) netAmtva,CONVERT(if(k.childAmtva=0,'',round(k.childAmtva,2)),CHAR(100)) childAmtva,CONVERT(if(k.subchildAmtva=0,'',round(k.subchildAmtva,2)),CHAR(100)) subchildAmtva,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end),CHAR(100)) code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
	 			    	 	+ "0 subac,gp_desc description,0 budgetamount, 0 mainamtba,0 agrpAmtba,0 grpAmtba,0 netAmtba,0 childAmtba,0 subchildAmtba,0 actualamount, 0 mainamtam,0 agrpAmtam,0 grpAmtam,0 netAmtam,0 childAmtam,0 subchildAmtam,0 varianceamount, 0 mainamtva,0 agrpAmtva,0 grpAmtva,0 netAmtva,0 childAmtva,0 subchildAmtva,0 account from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
	 			    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
	 			    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount) budgetamount,if(subac is  null and groupno is not null,budgetamount,0) mainAmtba,if(den is  not null and groupno is  null,budgetamount,0) agrpAmtba,if(@xlevel=4,@xdramt,0) grpAmtba,if(@xlevel=5,@xdramt,0) netAmtba,if(@xlevel=3,@xdramt*1,0) childAmtba,if(@xlevel=6,@xdramt*1,0) subchildAmtba, @xdramt:=if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign) actualamount,if(subac is  null and groupno is not null,actualamount,0) mainAmtam,if(den is  not null and groupno is  null,actualamount,0) agrpAmtam,if(@xlevel=4,@xdramt,0) grpAmtam,if(@xlevel=5,@xdramt,0) netAmtam,if(@xlevel=3,@xdramt*1,0) childAmtam,if(@xlevel=6,@xdramt*1,0) subchildAmtam, @xdramt:=if(gp_id is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))*if(grpLevel=1,-1,1),(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))) varianceamount,if(subac is  null and groupno is not null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) mainAmtva,if(den is  not null and groupno is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) agrpAmtva,if(@xlevel=4,@xdramt,0) grpAmtva,if(@xlevel=5,@xdramt,0) netAmtva,if(@xlevel=3,@xdramt*1,0) childAmtva,if(@xlevel=6,@xdramt*1,0) subchildAmtva,account from (select a.doc_no subac,m.*,"
	 			    	 	+ "sum(budgetamount) budgetamount, sum(actualamount) actualamount, sum(varianceamount) varianceamount, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
	 			    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(select gr_type,a.account,a.description accountname,a.acno,sum(a.budget) budgetamount,sum(a.actualamount) actualamount, sum(a.budget)-sum(a.actualamount) varianceamount, a.brhid from (select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,h.gr_type, j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date between '"+sqlFromDate+"' and  last_day('"+sqlToDate+"')  and h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type, m.brhid from my_budgetm m left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.month between month('"+sqlFromDate+"') and month('"+sqlToDate+"')  and d.year between year('"+sqlFromDate+"') and year('"+sqlToDate+"')   and h.gr_type in (4,5)) a where 1=1 "+sql2+" group by a.acno having sum(a.actualamount)!=0 or sum(a.budget)!=0) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
	 			    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno,description) k,(SELECT @i:= 0) as i where (k.netAmtba!=0 or k.grpAmtba!=0 or k.childAmtba!=0 or k.subchildAmtba!=0 or k.netAmtva!=0 or k.grpAmtva!=0 or k.childAmtva!=0 or k.subchildAmtva!=0 or k.netAmtam!=0 or k.grpAmtam!=0 or k.childAmtam!=0 or k.subchildAmtam!=0) and  ordno in (5,3,4) order by gp_id,den,groupno,ordno,description";
	            
		     }else{
		    	 sql="select @i:=@i+1 id,k.description,CONVERT(if(k.grpAmtba=0,'',round(k.grpAmtba,2)),CHAR(100)) grpAmtba,CONVERT(if(k.netAmtba=0,'',round(k.netAmtba,2)),CHAR(100)) netAmtba,CONVERT(if(k.childAmtba=0,'',round(k.childAmtba,2)),CHAR(100)) childAmtba,CONVERT(if(k.subchildAmtba=0,'',round(k.subchildAmtba,2)),CHAR(100)) subchildAmtba, CONVERT(if(k.grpAmtam=0,'',round(k.grpAmtam,2)),CHAR(100)) grpAmtam,CONVERT(if(k.netAmtam=0,'',round(k.netAmtam,2)),CHAR(100)) netAmtam,CONVERT(if(k.childAmtam=0,'',round(k.childAmtam,2)),CHAR(100)) childAmtam,CONVERT(if(k.subchildAmtam=0,'',round(k.subchildAmtam,2)),CHAR(100)) subchildAmtam, CONVERT(if(k.grpAmtva=0,'',round(k.grpAmtva,2)),CHAR(100)) grpAmtva,CONVERT(if(k.netAmtva=0,'',round(k.netAmtva,2)),CHAR(100)) netAmtva,CONVERT(if(k.childAmtva=0,'',round(k.childAmtva,2)),CHAR(100)) childAmtva,CONVERT(if(k.subchildAmtva=0,'',round(k.subchildAmtva,2)),CHAR(100)) subchildAmtva,k.gp_id,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end),CHAR(100)) code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
	 			    	 	+ "0 subac,gp_desc description,0 budgetamount, 0 mainamtba,0 agrpAmtba,0 grpAmtba,0 netAmtba,0 childAmtba,0 subchildAmtba,0 actualamount, 0 mainamtam,0 agrpAmtam,0 grpAmtam,0 netAmtam,0 childAmtam,0 subchildAmtam,0 varianceamount, 0 mainamtva,0 agrpAmtva,0 grpAmtva,0 netAmtva,0 childAmtva,0 subchildAmtva,0 account from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
	 			    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
	 			    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount) budgetamount,if(subac is  null and groupno is not null,budgetamount,0) mainAmtba,if(den is  not null and groupno is  null,budgetamount,0) agrpAmtba,if(@xlevel=4,@xdramt,0) grpAmtba,if(@xlevel=5,@xdramt,0) netAmtba,if(@xlevel=3,@xdramt*1,0) childAmtba,if(@xlevel=6,@xdramt*1,0) subchildAmtba, @xdramt:=if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign) actualamount,if(subac is  null and groupno is not null,actualamount,0) mainAmtam,if(den is  not null and groupno is  null,actualamount,0) agrpAmtam,if(@xlevel=4,@xdramt,0) grpAmtam,if(@xlevel=5,@xdramt,0) netAmtam,if(@xlevel=3,@xdramt*1,0) childAmtam,if(@xlevel=6,@xdramt*1,0) subchildAmtam, @xdramt:=if(gp_id is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))*if(grpLevel=1,-1,1),(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign))) varianceamount,if(subac is  null and groupno is not null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) mainAmtva,if(den is  not null and groupno is  null,(if(gp_id is  null,budgetamount*if(grpLevel=1,-1,1),budgetamount)-if(gp_id is  null,actualamount*if(grpLevel=1,-1,1),actualamount*drsign)),0) agrpAmtva,if(@xlevel=4,@xdramt,0) grpAmtva,if(@xlevel=5,@xdramt,0) netAmtva,if(@xlevel=3,@xdramt*1,0) childAmtva,if(@xlevel=6,@xdramt*1,0) subchildAmtva,account from (select a.doc_no subac,m.*,"
	 			    	 	+ "sum(budgetamount) budgetamount, sum(actualamount) actualamount, sum(varianceamount) varianceamount, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
	 			    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(select gr_type,a.account,a.description accountname,a.acno,sum(a.budget) budgetamount,sum(a.actualamount) actualamount, sum(a.budget)-sum(a.actualamount) varianceamount, a.brhid from (select h.account,h.description,j.acno,0 budget,j.ldramount actualamount,h.gr_type, j.brhid from my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.date between '"+sqlFromDate+"' and  last_day('"+sqlToDate+"')  and h.gr_type in (4,5) UNION ALL select h.account,h.description,d.acno,d.amount budget,0 actualamount,h.gr_type, m.brhid from my_budgetm m left join my_budgetdetail d on m.doc_no=d.rdocno left join my_head h on d.acno=h.doc_no where m.status=3 and d.month between month('"+sqlFromDate+"') and month('"+sqlToDate+"')  and d.year between year('"+sqlFromDate+"') and year('"+sqlToDate+"')   and h.gr_type in (4,5)) a where 1=1 "+sql2+" group by a.acno having sum(a.actualamount)!=0 or sum(a.budget)!=0) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
	 			    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno,description) k,(SELECT @i:= 0) as i where (k.netAmtba!=0 or k.grpAmtba!=0 or k.childAmtba!=0 or k.subchildAmtba!=0 or k.netAmtva!=0 or k.grpAmtva!=0 or k.childAmtva!=0 or k.subchildAmtva!=0 or k.netAmtam!=0 or k.grpAmtam!=0 or k.childAmtam!=0 or k.subchildAmtam!=0) order by gp_id,den,groupno,ordno,description";
	            
		     }
		     //System.out.println("===== "+sql);
		     ResultSet resultSet = stmtProfitLoss.executeQuery(sql);
			 
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamtba="",directcostamtba="",grossprofitba="",otherincomeamtba="",indirectexpensesamtba="",netprofitba="0.00" ,revenueamtam="",directcostamtam="",grossprofitam="",otherincomeamtam="",indirectexpensesamtam="",netprofitam="0.00",revenueamtva="",directcostamtva="",grossprofitva="",otherincomeamtva="",indirectexpensesamtva="",netprofitva="0.00";
             int a=0,b=0;
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamtba=resultSet.getString("netamtba");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamtba=resultSet.getString("netamtba");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamtba=resultSet.getString("netamtba");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamtba=resultSet.getString("netamtba");
							}

							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamtam=resultSet.getString("netamtam");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamtam=resultSet.getString("netamtam");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamtam=resultSet.getString("netamtam");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamtam=resultSet.getString("netamtam");
							}

							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamtva=resultSet.getString("netamtva");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamtva=resultSet.getString("netamtva");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamtva=resultSet.getString("netamtva");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamtva=resultSet.getString("netamtva");
							}
						}else if(masterid.equalsIgnoreCase("3")){
							parentid=masterparentid;
							childparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("4")){
							parentid=childparentid;
							subchildparentid=resultSet.getString("id");
						}else if(masterid.equalsIgnoreCase("6")){
							parentid=subchildparentid;
						}
						
							if(resultSet.getInt("gp_id")>=22 && a==0){
								if(parentid==null){
									
									grossprofitba=String.valueOf((revenueamtba.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamtba))-(directcostamtba.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamtba)));
									grossprofitam=String.valueOf((revenueamtam.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamtam))-(directcostamtam.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamtam)));
									grossprofitva=String.valueOf((revenueamtva.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamtva))-(directcostamtva.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamtva)));
									temp="0::GROSS PROFIT:: :: "+grossprofitba+" :: :: :: :: "+grossprofitam+" :: :: :: :: "+grossprofitva+" :: :: :: null:: 5:: :: 0::Group II::0";
									balancearray.add(temp);
									a=1;
								}
							}
							
							if(resultSet.getInt("gp_id")>=23 && b==0){
								if(parentid==null){
									 netprofitba=String.valueOf(((grossprofitba.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofitba))+(otherincomeamtba.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamtba)))-(indirectexpensesamtba.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamtba)));
									 netprofitam=String.valueOf(((grossprofitam.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofitam))+(otherincomeamtam.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamtam)))-(indirectexpensesamtam.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamtam)));
									 netprofitva=String.valueOf(((grossprofitva.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofitva))+(otherincomeamtva.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamtva)))-(indirectexpensesamtva.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamtva)));
									 b=1;
								}
							}
							
						 childid=masterid;
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("grpamtba")+"::"+resultSet.getString("netamtba")+"::"+resultSet.getString("childamtba")+"::"+resultSet.getString("subchildamtba")+"::"+resultSet.getString("grpamtam")+"::"+resultSet.getString("netamtam")+"::"+resultSet.getString("childamtam")+"::"+resultSet.getString("subchildamtam")+"::"+resultSet.getString("grpamtva")+"::"+resultSet.getString("netamtva")+"::"+resultSet.getString("childamtva")+"::"+resultSet.getString("subchildamtva")+"::"+parentid+"::"+resultSet.getString("ordno")+"::"+resultSet.getString("groupno")+"::"+resultSet.getString("subac")+"::"+resultSet.getString("code")+"::"+resultSet.getString("gp_id");
					balancearray.add(temp);
				}

				balancearray.add("999::NET PROFIT/LOSS:: :: "+netprofitba+" :: :: :: :: "+netprofitam+" :: :: :: :: "+netprofitva+" :: :: :: null:: 5:: :: 0::Group II::0");
				
				RESULTDATA=convertArrayToJSON(balancearray);   
				
				String sqlConfig="select method from gl_config where field_nme='budgetvarianceDetailPrint'";
				ResultSet resultSetConfig = stmtProfitLoss.executeQuery(sqlConfig);
				String valueOfConfig="";
				while(resultSetConfig.next()){
					valueOfConfig=resultSetConfig.getString("method");
				}
			    //System.out.println("RESULTDATA=="+RESULTDATA);
				String amount="";
				if(valueOfConfig.equalsIgnoreCase("1")){  
					String sqls="DELETE FROM budgetvariancedet WHERE entrydate<"+onedaylessdt+"";   
					stmtProfitLoss.executeUpdate(sqls);     
					   
					 for (int i = 0, size = RESULTDATA.size(); i < size; i++) {
					       JSONObject objectInArray = RESULTDATA.getJSONObject(i);

					       if(objectInArray.getString("ordno").trim().equalsIgnoreCase("5") || objectInArray.getString("ordno").trim().equalsIgnoreCase("3") || objectInArray.getString("ordno").trim().equalsIgnoreCase("1")  || objectInArray.getString("ordno").trim().equalsIgnoreCase("4")  || objectInArray.getString("ordno").trim().equalsIgnoreCase("6")) {
					    	   
								String sql3 ="insert into budgetvariancedet (description, group1fc, group2fc, mainfc, detailfc, group1ac, group2ac, mainac, detailac, group1va, group2va, mainva, detailva, ordno,code, gp_id, entrydate) values('"+objectInArray.getString("description")+"',"
										+ "'"+(objectInArray.getString("childamtba").trim().equalsIgnoreCase("")?"":objectInArray.getString("childamtba"))+"',"
										+ "'"+(objectInArray.getString("netamtba").trim().equalsIgnoreCase("")?"":objectInArray.getString("netamtba"))+"',"
										+ "'"+(objectInArray.getString("grpamtba").trim().equalsIgnoreCase("")?"":objectInArray.getString("grpamtba"))+"',"    
										+ "'"+(objectInArray.getString("subchildamtba").trim().equalsIgnoreCase("")?"":objectInArray.getString("subchildamtba"))+"'," 
										+ "'"+(objectInArray.getString("childamtam").trim().equalsIgnoreCase("")?"":objectInArray.getString("childamtam"))+"',"
										+ "'"+(objectInArray.getString("netamtam").trim().equalsIgnoreCase("")?"":objectInArray.getString("netamtam"))+"',"
										+ "'"+(objectInArray.getString("grpamtam").trim().equalsIgnoreCase("")?"":objectInArray.getString("grpamtam"))+"',"    
										+ "'"+(objectInArray.getString("subchildamtam").trim().equalsIgnoreCase("")?"":objectInArray.getString("subchildamtam"))+"',"  
										+ "'"+(objectInArray.getString("childamtva").trim().equalsIgnoreCase("")?"":objectInArray.getString("childamtva"))+"',"
										+ "'"+(objectInArray.getString("netamtva").trim().equalsIgnoreCase("")?"":objectInArray.getString("netamtva"))+"',"
										+ "'"+(objectInArray.getString("grpamtva").trim().equalsIgnoreCase("")?"":objectInArray.getString("grpamtva"))+"',"    
										+ "'"+(objectInArray.getString("subchildamtva").trim().equalsIgnoreCase("")?"":objectInArray.getString("subchildamtva"))+"',"
										+ "'"+(objectInArray.getString("ordno").trim().equalsIgnoreCase("")?"0":objectInArray.getString("ordno"))+"',"
										+ "'"+(objectInArray.getString("code").trim().equalsIgnoreCase("")?"":objectInArray.getString("code"))+"',"  
										+ "'"+(objectInArray.getString("gp_id").trim().equalsIgnoreCase("")?"0":objectInArray.getString("gp_id"))+"','"+entrydate+"')";
								int data1= stmtProfitLoss.executeUpdate(sql3);
							
					       }
					    }
				}
			 
			 stmtProfitLoss.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			//System.out.println(arrayList+"==="+arrayList.size());
			for (int i = 0; i < arrayList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] balanceSheetArray=arrayList.get(i).split("::");
				
				obj.put("id",balanceSheetArray[0]);
				obj.put("description",balanceSheetArray[1]);
				obj.put("grpamtba",balanceSheetArray[2]);
				obj.put("netamtba",balanceSheetArray[3]);
				obj.put("childamtba",balanceSheetArray[4]);
				obj.put("subchildamtba",balanceSheetArray[5]);
				obj.put("grpamtam",balanceSheetArray[6]);
				obj.put("netamtam",balanceSheetArray[7]);
				obj.put("childamtam",balanceSheetArray[8]);
				obj.put("subchildamtam",balanceSheetArray[9]);
				obj.put("grpamtva",balanceSheetArray[10]);
				obj.put("netamtva",balanceSheetArray[11]);
				obj.put("childamtva",balanceSheetArray[12]);
				obj.put("subchildamtva",balanceSheetArray[13]);
				obj.put("parentid",balanceSheetArray[14]);
				obj.put("ordno",balanceSheetArray[15]);
				obj.put("groupno",balanceSheetArray[16]);
				obj.put("subac",balanceSheetArray[17]);
				obj.put("code",balanceSheetArray[18]);
				obj.put("gp_id",balanceSheetArray[19]);
				jsonArray.add(obj);
			}
			return jsonArray;
		}
	
	public JSONArray budgetVarianceExcel(String check, String entrydate) throws SQLException {
	    Connection conn=null;
	    
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBalance1 = conn.createStatement();
	        	
				ResultSet resultSet1 = stmtBalance1.executeQuery ("SELECT description 'Description', group1fc 'Group I - Forecast', group2fc 'Group II - Forecast', mainfc 'Main - Forecast', detailfc 'Detail - Forecast', group1ac 'Group I - Actual', group2ac 'Group II - Actual', mainac 'Main - Actual', detailac 'Detail - Actual', group1va 'Group I - Variance', group2va 'Group II - Variance', mainva 'Main - Variance', detailva 'Detail - Variance' FROM budgetvariancedet WHERE entrydate='"+entrydate+"'");
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBalance1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
 
}
