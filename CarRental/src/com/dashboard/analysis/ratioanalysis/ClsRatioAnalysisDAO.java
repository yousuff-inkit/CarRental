package com.dashboard.analysis.ratioanalysis;

 import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRatioAnalysisDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray ratioAnalysisData(String branch,String fromdate,String todate, String check) throws SQLException {  
		 JSONArray RESULTDATA=new JSONArray();
		 if(!check.equals("1")) {   
			return RESULTDATA;     
		 }
		 Connection conn =  null;
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtBalance = conn.createStatement();
				 
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sqls="Truncate ratioanalysis";   
			 int data= stmtBalance.executeUpdate(sqls);   
			 
		     balanceSheetInsert(branch, sqlFromDate, sqlToDate);   
		     profitandlossInsert(branch, sqlFromDate, sqlToDate); 
		     
		     String sql1="select round(sum(coalesce(ldramount,0)),2) total from my_jvtran where status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and acno=(select acno from my_account where codeno='COST OF GOODS SOLD')";     
			 ResultSet rs1 = stmtBalance.executeQuery(sql1); 
			 Double cogs = 0.0;
			 while(rs1.next()) {
				 cogs = rs1.getDouble("total");     
			 }
			 
			 String sql="select description, amount, gp_id, den from ratioanalysis";     
			 //System.out.println("Ratio======"+sql);          
			 ResultSet rs = stmtBalance.executeQuery(sql);
			 
			 ArrayList<String> ratioarray = new ArrayList<String>();
			 Double amount = 0.0, grossprofit = 0.0, revenue = 0.0, netprofit = 0.0, shareholdereq = 0.0, totalassets = 0.0;
			 Double indirectexp = 0.0, marketingexp = 0.0, financialexp = 0.0, adminexp = 0.0;
			 Double currentasset = 0.0, currentliability = 0.0, inventory = 0.0, cashinbank = 0.0, cashequivalent = 0.0, totaldebt = 0.0;      
			 String desc = "", gpid ="", den ="";
			 while(rs.next()) {
				  desc = rs.getString("description");  
				  gpid = rs.getString("gp_id");  
				  den = rs.getString("den");  
				  amount = rs.getDouble("amount");       
				  
				  if(desc.equalsIgnoreCase("GROSS PROFIT")) {  
					  grossprofit = amount;  
				  }
				  if(desc.equalsIgnoreCase("REVENUE") && den.equals("0")) {        
					  revenue = amount;  
				  }
				  if(desc.equalsIgnoreCase("NET PROFIT/LOSS")) {     
					  netprofit = amount;  
				  }
				  if(den.equalsIgnoreCase("280")) {       
					  shareholdereq = amount;    
				  }
				  if(gpid.equalsIgnoreCase("16") && den.equals("0")) {           
					  totalassets = amount;  
				  }
				  if(gpid.equalsIgnoreCase("23") && den.equals("0")) {             
					  indirectexp = amount;  
				  }
				  if(den.equalsIgnoreCase("120")) {       
					  marketingexp = amount;    
				  }
				  if(den.equalsIgnoreCase("125")) {       
					  financialexp = amount;    
				  }
				  if(den.equalsIgnoreCase("127")) {       
					  adminexp = amount;      
				  }
				  if(desc.equalsIgnoreCase("CURRENT ASSETS")) {       
					  currentasset = amount;  
				  }
				  if(desc.equalsIgnoreCase("CURRENT LIABILITIES")) {  
					  currentliability = amount;  
				  }
				  if(den.equalsIgnoreCase("342")) {     
					  inventory = amount;  
				  }
				  if(den.equalsIgnoreCase("305")) {     
					  cashinbank = amount;  
				  }
				  if(den.equalsIgnoreCase("604")) {           
					  cashequivalent = amount;    
				  }
				  if(den.equalsIgnoreCase("340")) {              
					  totaldebt = amount;    
				  }
			 }
			 //System.out.println(grossprofit+"=="+revenue+"=="+netprofit+"=="+shareholdereq+"=="+totalassets);   
			 Double gpmargin = 0.0, npmrgin = 0.0, roa = 0.0, roe = 0.0;
			
			 if(revenue==0) {
				 gpmargin = 0.00;  
				 npmrgin = 0.00;  
			 }else {
				 gpmargin = (grossprofit/revenue)*100;  
				 npmrgin = (netprofit/revenue)*100;  
			 }
			 
			 if(totalassets==0) {
				 roa = 0.00; 
			 }else {
				 roa = (netprofit/totalassets)*100; 
			 }
			 
			 if(shareholdereq==0) {       
				 roe = 0.00; 
			 }else {
				 roe = (netprofit/shareholdereq)*100;   
			 }
			 ratioarray.add("1::null::Profitability Ratios:: :: ");     
			 ratioarray.add("2::1::Gross Profit Margin::"+ClsCommon.Round(gpmargin, 2)+":: ");    
			 ratioarray.add("3::1::Net Profit Margin::"+ClsCommon.Round(npmrgin, 2)+":: ");
			 ratioarray.add("4::1::Return on Assets (ROA)::"+ClsCommon.Round(roa, 2)+":: ");
			 ratioarray.add("5::1::Return on Equity (ROE)::"+ClsCommon.Round(roe, 2)+":: ");     
			 
			 Double cogsrev = 0.0, indirectexprev = 0.0, marketexprev = 0.0, financialexprev = 0.0, adminexprev = 0.0;  
			 if(revenue==0) {
				 cogsrev = 0.00;  
				 indirectexprev = 0.00;
				 marketexprev = 0.00; 
				 financialexprev = 0.00; 
				 adminexprev = 0.00;            
			 }else {
				 cogsrev = (cogs/revenue)*100;
				 indirectexprev = (indirectexp/revenue)*100;
				 marketexprev = (marketingexp/revenue)*100;  
				 financialexprev = (financialexp/revenue)*100;
				 adminexprev = (adminexp/revenue)*100; 
			 }
			 ratioarray.add("6::null::Expense Ratios:: :: ");     
			 ratioarray.add("7::6::Cost of Goods Sold on Revenue::"+ClsCommon.Round(cogsrev, 2)+":: ");
			 ratioarray.add("8::6::Indirect Expenses on Revenue::"+ClsCommon.Round(indirectexprev, 2)+":: ");
			 ratioarray.add("9::6::Marketing Expenses on Revenue::"+ClsCommon.Round(marketexprev, 2)+":: ");
			 ratioarray.add("10::6::Financial Expenses on Revenue::"+ClsCommon.Round(financialexprev, 2)+":: "); 
			 ratioarray.add("11::6::Administration Expenses on Revenue::"+ClsCommon.Round(adminexprev, 2)+":: ");      
			 
			 Double currentratio = 0.0, quickratio = 0.0, cashratio = 0.0;        
			 if(currentliability==0) {             
				 currentratio = 0.00; 
				 quickratio = 0.00; 
				 cashratio = 0.00;    
			 }else {
				 currentratio = currentasset/currentliability; 
				 quickratio = (currentasset-inventory)/currentliability;   
				 cashratio = (cashinbank+cashequivalent)/currentliability;       
			 }
			 ratioarray.add("12::null::Liquidity Ratios:: :: ");            
			 ratioarray.add("13::12::Current Ratio::"+ClsCommon.Round(currentratio, 2)+":: ");   
			 ratioarray.add("14::12::Quick Ratio::"+ClsCommon.Round(quickratio, 2)+":: ");
			 ratioarray.add("15::12::Cash Ratio::"+ClsCommon.Round(cashratio, 2)+":: ");          
			 
			 Double debitequratio = 0.0, debitratio = 0.0;
			 if(shareholdereq==0) {                   
				 debitequratio = 0.00; 
			 }else {
				 debitequratio = totaldebt/shareholdereq;     
			 }
			 
			 if(totalassets==0) {                    
				 debitratio = 0.00;     
			 }else {
				 debitratio = totaldebt/totalassets;  
			 }
			 ratioarray.add("16::null::Solvency Ratios:: :: ");            
			 ratioarray.add("17::16::Debt-to-Equity Ratio::"+ClsCommon.Round(debitequratio, 2)+":: ");    
			 ratioarray.add("18::16::Debt Ratio::"+ClsCommon.Round(debitratio, 2)+":: ");     
			 
			 RESULTDATA=convertArrayToJSONRatio(ratioarray);          
			    
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	public  JSONArray convertArrayToJSONRatio(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] ratioArray=arrayList.get(i).split("::");
			
			obj.put("id",ratioArray[0]);
			obj.put("parentid",ratioArray[1]);
			obj.put("description",ratioArray[2]);
			obj.put("group1",ratioArray[3]);
			jsonArray.add(obj);
		}
		return jsonArray;
		}
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			for (int i = 0; i < arrayList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] balanceSheetArray=arrayList.get(i).split("::");
				
				obj.put("id",balanceSheetArray[0]);
				obj.put("description",balanceSheetArray[1]);
				obj.put("grpamt",balanceSheetArray[2]);
				obj.put("netamt",balanceSheetArray[3]);
				obj.put("childamt",balanceSheetArray[4]);
				obj.put("subchildamt",balanceSheetArray[5]);
				obj.put("parentid",balanceSheetArray[6]);
				obj.put("ordno",balanceSheetArray[7]);
				obj.put("groupno",balanceSheetArray[8]);
				obj.put("subac",balanceSheetArray[9]);
				obj.put("gp_id",balanceSheetArray[10]);
				obj.put("code",balanceSheetArray[11]);        
				obj.put("den",balanceSheetArray[12]);  
				jsonArray.add(obj);
			}
			return jsonArray;
			}
	
	public int balanceSheetInsert(String branch,Date sqlFromDate,Date sqlToDate) {     
		 Connection conn =  null; 
		 JSONArray RESULTDATA=new JSONArray();  
		 try {
		 conn = ClsConnection.getMyConnection();
		 Statement stmtBalance = conn.createStatement();       
		 
		 String sql = "",sql1 = "",sql2="";  
		   
		 sql="select @i:=@i+1 id,k.description,ROUND(COALESCE(k.grpamt,0),2) grpamt, ROUND(COALESCE(k.netamt,0),2) netamt, ROUND(COALESCE(k.childamt,0),2) childamt,"
		    	 	+ " ROUND(COALESCE(k.subchildamt,0),2) subchildamt,k.gp_id,k.den,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
			    	  + "else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno       end),CHAR(100)) code from (select "+sql1+"if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select "+sql1+"0 ORDNO,19 gp_id,0 den,"
			    	  + "0 groupNo, 0 subac,0 account,'' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and  h.gr_type in (4,5) "+sql2+" UNION ALL select "+sql1+""
			    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
			    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
			    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
			    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 "+sql2+" UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
			    	  + "and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and  h.gr_type>=4 and t.trtype!=1 "+sql2+" UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1) "+sql2+"  group by t.acno ) t  where (m.groupNo=t.acno "
			    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) and  ordno in (5,3,1,0) or gp_id=14 order by gp_id,den,groupno,ordno";
		 //System.out.println("Balance sheet======"+sql);        
		 ResultSet resultSet = stmtBalance.executeQuery(sql);
		 
		 ArrayList<String> balancearray= new ArrayList<String>();
		 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",orderno="",profityearamt="0",netamount="";
         int a=0,b=0;
		 
		 while(resultSet.next()){
				String temp="";

				masterid=resultSet.getString("parentid");
				netamount=resultSet.getString("netamt");
				
				if(childid!=masterid){
					
					if(masterid.equalsIgnoreCase("null")){
						parentid=null;
						masterparentid=resultSet.getString("id");
					}else if(masterid.equalsIgnoreCase("3")){
						parentid=masterparentid;
						childparentid=resultSet.getString("id");
					}else if(masterid.equalsIgnoreCase("4")){
						parentid=childparentid;
						subchildparentid=resultSet.getString("id");
					}else if(masterid.equalsIgnoreCase("6")){
						parentid=subchildparentid;
					}else if(masterid.equalsIgnoreCase("0")){
						parentid=masterparentid;
					}  
					
					childid=masterid;
				}
				
				orderno=resultSet.getString("ordno");
				
				if(resultSet.getString("gp_id").equalsIgnoreCase("14")){
					parentid=null;
					orderno="5";
				}
				
				if(resultSet.getInt("gp_id")>=19 && a==0 && resultSet.getString("description").contains("PROFIT FOR THE PERIOD")){
					profityearamt=resultSet.getString("netamt");
					orderno="3";
					a=1;
				}
				
				if(resultSet.getInt("gp_id")>=20 && b==0){
					String netamt=resultSet.getString("netamt");
					
					netamount=String.valueOf(Double.parseDouble(netamt)+Double.parseDouble(profityearamt));
					
					b=1;
				}
				netamount=(netamount==null?"0.00":netamount);      
				temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("grpamt")+"::"+netamount+"::"+resultSet.getString("childamt")+"::"+resultSet.getString("subchildamt")+"::"+parentid+"::"+orderno+"::"+resultSet.getString("groupno")+"::"+resultSet.getString("subac")+"::"+resultSet.getString("gp_id")+"::"+resultSet.getString("code")+"::"+resultSet.getString("den");       
				
				balancearray.add(temp);
			 }
			 System.out.println("balancearray="+balancearray);   
		     RESULTDATA=convertArrayToJSON(balancearray);   
			 
		     for (int i = 0, size = RESULTDATA.size(); i < size; i++) {   
			       JSONObject objectInArray = RESULTDATA.getJSONObject(i);

			       if(objectInArray.getString("ordno").trim().equalsIgnoreCase("5") || objectInArray.getString("ordno").trim().equalsIgnoreCase("3") || objectInArray.getString("ordno").trim().equalsIgnoreCase("1")  || objectInArray.getString("ordno").trim().equalsIgnoreCase("4")  || objectInArray.getString("ordno").trim().equalsIgnoreCase("6")) {
			    	   
			    	   String sql3 ="insert into ratioanalysis (description, amount, gp_id, den) values('"+objectInArray.getString("description")+"',"  
								+ "if("+objectInArray.getDouble("childamt")+"!=0,"+objectInArray.getDouble("childamt")+","+(objectInArray.getDouble("netamt"))+"), '"+objectInArray.getString("gp_id")+"','"+objectInArray.getString("den")+"')";   
			    	   int data1= stmtBalance.executeUpdate(sql3);                   
			       }
			}  
			 
		 stmtBalance.close();
		 conn.close();
		 }catch(Exception e){   
			    e.printStackTrace();
		  }
		return 1;
	   }
	
	public int profitandlossInsert(String branch,Date sqlFromDate,Date sqlToDate) throws SQLException {    
		 JSONArray RESULTDATA=new JSONArray();   
		 Connection conn =  null;
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtProfitLoss = conn.createStatement();
			
		     String sql = "",sql1 = "",sql2="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql1+=""+branch+" brhId,";
			     sql2=" and t.brhid in ("+branch+")";
		     }    

		     sql="select @i:=@i+1 id,k.description, ROUND(COALESCE(k.grpamt,0),2) grpamt, ROUND(COALESCE(k.netamt,0),2) netamt, ROUND(COALESCE(k.childamt,0),2) childamt,"
			    	 	+ " ROUND(COALESCE(k.subchildamt,0),2) subchildamt,k.gp_id,k.den,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac,CONVERT((case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end),CHAR(100)) code from (select "+sql1+"0 ORDNO,gp_id,0 den,0 groupNo,"
			    	 	+ "0 subac,0 account,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 union all select "+sql1+"@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,"
			    	 	+ "if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,' NET PROFIT / (LOSS) ',"
			    	 	+ "if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr*drsign) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,"
			    	 	+ "if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,"
			    	 	+ "sum(ldramount) dr, a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,"
			    	 	+ "length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h "
			    	 	+ "where t.status=3 and t.yrid=0 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 "+sql2+" group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) "
			    	 	+ "and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or "
			    	 	+ "k.subchildamt!=0) and  ordno in (5,3) order by gp_id,den,groupno,ordno";
		     
		     //System.out.println("Profit and loss===== "+sql);
		     ResultSet resultSet = stmtProfitLoss.executeQuery(sql);
			 ArrayList<String> balancearray= new ArrayList<String>();
			 String masterid="",childid="",parentid="",masterparentid="",childparentid="",subchildparentid="",revenueamt="",directcostamt="",grossprofit="",
					 otherincomeamt="",indirectexpensesamt="",netprofit="0.00";
             int a=0,b=0;  
			 
				while(resultSet.next()){
					String temp="";

					masterid=resultSet.getString("parentid");
					
					if(childid!=masterid){
						
						if(masterid.equalsIgnoreCase("null")){
							parentid=null;
							masterparentid=resultSet.getString("id");
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("19") && parentid==null){
								revenueamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("20") && parentid==null){
								directcostamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("22") && parentid==null){
								otherincomeamt=resultSet.getString("netamt");
							}
							if(resultSet.getString("gp_id").trim().equalsIgnoreCase("23") && parentid==null){
								indirectexpensesamt=resultSet.getString("netamt");
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
									
									grossprofit=String.valueOf((revenueamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(revenueamt))-(directcostamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(directcostamt)));
									temp="0::GROSS PROFIT:: ::"+grossprofit+" :: :: :: null:: 5:: :: 0 :: 0 :: 0 :: 0";
									balancearray.add(temp);
									a=1;
								}
							}
							
							if(resultSet.getInt("gp_id")>=23 && b==0){
								if(parentid==null){
								    netprofit=String.valueOf(((grossprofit.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(grossprofit))+(otherincomeamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(otherincomeamt)))-(indirectexpensesamt.trim().equalsIgnoreCase("")?0.00:Double.parseDouble(indirectexpensesamt)));
								    b=1;
								}
							}
							
						 childid=masterid;
					}
					
					temp=resultSet.getString("id")+"::"+resultSet.getString("description")+"::"+resultSet.getString("grpamt")+"::"+resultSet.getString("netamt")+"::"+resultSet.getString("childamt")+"::"+resultSet.getString("subchildamt")+"::"+parentid+"::"+resultSet.getString("ordno")+"::"+resultSet.getString("groupno")+"::"+resultSet.getString("subac")+"::"+resultSet.getString("gp_id")+"::"+resultSet.getString("code")+"::"+resultSet.getString("den");
					balancearray.add(temp);
				}
               double grossprofitval=0.0, revenueval=0.0, gratio=0.0, nratio=0.0, netprofitval=0.0;
               
               grossprofitval = Double.parseDouble(grossprofit);
               revenueval = Double.parseDouble(revenueamt);
               gratio = grossprofitval/revenueval;
               netprofitval = Double.parseDouble(netprofit);
               nratio = netprofitval/revenueval;
				balancearray.add("999::NET PROFIT/LOSS:: ::"+netprofit+" :: :: :: null:: 5:: :: 0 :: 0 :: 0 :: 0");   
				
				
				String sqlConfig1="select method from gl_config where field_nme='grossnetprofit'";
				ResultSet resultSetConfig1 = stmtProfitLoss.executeQuery(sqlConfig1);
				int valueOfConfig1=0;
				while(resultSetConfig1.next()){
					valueOfConfig1=resultSetConfig1.getInt("method");
				}
				if(valueOfConfig1>0) {
					balancearray.add("9999::GROSS PROFIT RATIO ON REVENUE:: ::"+gratio+" :: :: :: null:: 5:: :: 0 :: 0 :: 0 :: 0");  
					balancearray.add("99999::NET PROFIT RATIO OF REVENUE:: ::"+nratio+" :: :: :: null:: 5:: :: 0 :: 0 :: 0 :: 0");
				}
				
				//System.out.println("profitarray===="+balancearray);
				RESULTDATA=convertArrayToJSON(balancearray);
				 
				Double amount = 0.0;   
				
				for (int i = 0, size = RESULTDATA.size(); i < size; i++) {
					       JSONObject objectInArray = RESULTDATA.getJSONObject(i);

					       if(objectInArray.getString("ordno").trim().equalsIgnoreCase("5") || objectInArray.getString("ordno").trim().equalsIgnoreCase("3") || objectInArray.getString("ordno").trim().equalsIgnoreCase("4") || objectInArray.getString("ordno").trim().equalsIgnoreCase("6")) {
					    	   if(objectInArray.getString("ordno").trim().equalsIgnoreCase("3")){
					    		   amount = objectInArray.getDouble("childamt"); 
					    	   }
					    	   if(objectInArray.getString("ordno").trim().equalsIgnoreCase("4")){
					    		   amount = objectInArray.getDouble("grpamt"); 
					    	   }
					    	   if(objectInArray.getString("ordno").trim().equalsIgnoreCase("6")){
					    		   amount = objectInArray.getDouble("subchildamt");                      
					    	   }
					    	   String sql3 ="INSERT INTO ratioanalysis (description, amount, gp_id, den) values('"+objectInArray.getString("description")+"',"
										+ "if("+amount+"!=0,"+amount+","+(objectInArray.getDouble("netamt"))+"), '"+objectInArray.getString("gp_id")+"','"+objectInArray.getString("den")+"')";
								int data1= stmtProfitLoss.executeUpdate(sql3);     
								amount = 0.0;                  
					       }
					    }
				 
			 stmtProfitLoss.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return 1;
       }  
 }