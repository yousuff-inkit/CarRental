package com.dashboard.vehiclepurchase.termloanrestructuring;

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
import com.finance.transactions.unclearedchequepayment.ClsUnclearedChequePaymentDAO;
public class ClsTermLoanRestructuringDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray getMortgageData(String fromdate,String todate,String id,String purchasedocno) throws SQLException{  
		JSONArray mortgagedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return mortgagedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!purchasedocno.equalsIgnoreCase("")){
				sqltest+=" and d.rdocno="+purchasedocno;
				
			}
			String strsql="select if(m.bpvno=0,0,1) poststatus,0 editstatus,1 defaultrow,m.doc_no ucrdocno,d.rowno detaildocno,pm.voc_no purchasevocno,d.rdocno purchasedocno, d.date, d.pramt principalamt,d.intstamt interestamt, d.totamt amount,"+
			" convert(coalesce(m.chqno,''),char(50)) chequeno,d.bpvno from gl_termloandetd d  left join gl_termloanm pm on pm.doc_no=d.rdocno left join my_unclrchqbm m on m.doc_no=d.bpvno  and m.brhid=pm.brhid"+
			" where 1=1 and m.status=3"+sqltest+" order by d.date";
			System.out.println("mortgagesql==="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			mortgagedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return mortgagedata;
	}
	
	public JSONArray getPurchaseSearchData(String branch) throws SQLException{
		
		JSONArray purchasedata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select round(det.loanamt,2) loanamount,m.doc_no,m.voc_no,m.date, det.dealno from gl_termloanm m "+
			" left join gl_termloandetm det on m.doc_no=det.rdocno where m.status=3"+sqltest;
			//System.out.println("search---->"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			purchasedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
			
		}
		return purchasedata;
	}
	
	public JSONArray getDeleteData(String purchasedocno,String id) throws SQLException{
		JSONArray deletedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return deletedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select 1 defaultdeleterow,m.voc_no purchasevocno,r.purchasedocno,r.date,r.chequeno,r.principalamt,r.interestamt,r.amount,r.bpvno from gl_termloanrestructure r left join gl_termloanm m on m.doc_no=r.purchasedocno where r.deletestatus=1 and r.purchasedocno="+purchasedocno;
			System.out.println("strsql==="+strsql);     
			ResultSet rs=stmt.executeQuery(strsql);
			deletedata=objcommon.convertToJSON(rs);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}  
		finally{
			conn.close();
		}
		
		return deletedata;
	}
	
	public JSONArray getBalanceLoanAcno() throws SQLException{
		JSONArray acnodata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,description,account from my_head where atype='GL' and m_s=0";
			ResultSet rs=stmt.executeQuery(strsql);
			acnodata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return acnodata;
	}
	
	
	public JSONArray getVehicle(String purchasedocno,String dealno,String id) throws SQLException{
		JSONArray vehicledata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return vehicledata; 
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select rowno,brd.brand_name brand,model.vtype model,clr.color,d.fleet_no,veh.reg_no from gl_vpurd d left join gl_vehbrand brd on "+
			" d.brdid=brd.doc_no left join gl_vehmodel model on d.modid=model.doc_no left join my_color clr on d.clrid=clr.doc_no left join gl_vehmaster veh"+
			" on d.fleet_no=veh.fleet_no where rdocno="+purchasedocno+" and d.flstatus=1";
			ResultSet rs=stmt.executeQuery(strsql);
			vehicledata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return vehicledata;
	}
	
	public int gridsave(ArrayList<String> purchasearray,ArrayList<String> deletearray,String deleteucrdocno,String purchasedocno,String currentdate,String vendor,double principalsum,double totalloanamount,String balanceloanacno,String branch,String vehicleremove,String postingdate,HttpSession session,HttpServletRequest request) throws SQLException{
		
		double balanceamt=principalsum-totalloanamount;
		System.out.println(totalloanamount+"::"+principalsum+"::"+balanceamt);
		Connection conn=null;
		ClsConnection objconn=new ClsConnection();
		ClsCommon objcommon=new ClsCommon();
		ClsUnclearedChequePaymentDAO ucpdao=new ClsUnclearedChequePaymentDAO();
		int errorstatus=0;
		java.sql.Date sqlpostingdate=null;
		if(!postingdate.equalsIgnoreCase("")){
			sqlpostingdate=objcommon.changeStringtoSqlDate(postingdate);
		}
		
		session.setAttribute("BRANCHID",branch);
		
		java.sql.Date sqlcurrentdate=null;
		if(!currentdate.equalsIgnoreCase("")){
			sqlcurrentdate=objcommon.changeStringtoSqlDate(currentdate);
		}

		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			

			String stracno="select bankaccno amountacno,intstaccno interestacno,loanaccno principalacno from gl_termloandetm where rdocno="+purchasedocno;
			int amountacno=0,interestacno=0,principalacno=0;
			ResultSet rsacno=stmt.executeQuery(stracno);
			while(rsacno.next()){
				amountacno=rsacno.getInt("amountacno");
				interestacno=rsacno.getInt("interestacno");
				principalacno=rsacno.getInt("principalacno");
			}
			System.out.println("Bank Acno: "+stracno);
			int amountcurid=0,interestcurid=0,principalcurid=0;
			double amountcurrate=0.0,interestcurrate=0.0,principalcurrate=0.0;  
			String purchasedesc="";
			
			String strgetbankdetails="select (select curid from my_head where doc_no="+amountacno+") amountcurid,"+
								" (select rate from my_head where doc_no="+amountacno+") amountcurrate,"+
								" (select curid from my_head where doc_no="+interestacno+") interestcurid,"+
								" (select rate from my_head where doc_no="+interestacno+") interestcurrate,"+
								" (select curid from my_head where doc_no="+principalacno+") principalcurid,"+
								" (select rate from my_head where doc_no="+principalacno+") principalcurrate,"+
								" (select desc1 from gl_termloandetm where rdocno="+purchasedocno+") purchasedesc";
			System.out.println("Bank Details: "+stracno);
			ResultSet rsbankdetails=stmt.executeQuery(strgetbankdetails);
			while(rsbankdetails.next()){
				amountcurid=rsbankdetails.getInt("amountcurid");
				amountcurrate=rsbankdetails.getDouble("amountcurrate");
				interestcurid=rsbankdetails.getInt("interestcurid");
				interestcurrate=rsbankdetails.getDouble("interestcurrate");
				principalcurid=rsbankdetails.getInt("principalcurid");
				principalcurrate=rsbankdetails.getDouble("principalcurrate");
				purchasedesc=rsbankdetails.getString("purchasedesc");
			}
			
			for(int i=0;i<purchasearray.size();i++){
				String purchasetemp[]=purchasearray.get(i).split("::");
				System.out.println(purchasearray.get(i));
				String temp1[]=purchasearray.get(i).split("::");
				java.sql.Date sqldate=null;
				sqldate=objcommon.changeStringtoSqlDate(purchasetemp[3]);
				java.sql.Date sqlchequedate=null;
				if(!temp1[3].equalsIgnoreCase("undefined") && temp1[3]!=null){
					sqlchequedate=objcommon.changeStringtoSqlDate(temp1[3]);
				}
				System.out.println("checking Purchasetemp[8]: "+purchasetemp[8]);
				if(!purchasetemp[8].equalsIgnoreCase("") || !purchasetemp[8].equalsIgnoreCase("undefined") || purchasetemp[8]!=null){
					System.out.println("checking temp1[10]: "+temp1[10]);
					System.out.println("checking temp1[9]: "+temp1[9]);
					if(temp1[10].equalsIgnoreCase("1") && temp1[9].equalsIgnoreCase("1")){
						String ucrdocno=temp1[8];
						
						String strupdateucrm="update my_unclrchqbm set totalAmount="+temp1[7]+",date='"+sqlchequedate+"',chqdt='"+sqlchequedate+"'  where doc_no="+ucrdocno+" and brhId="+branch+"";
						System.out.println("Update Bank UCR Master: "+strupdateucrm);
						int updateucrm=stmt.executeUpdate(strupdateucrm);
						if(updateucrm<0){
							errorstatus=1;
						}
						String strupdateucrprincipal="update my_unclrchqbd set amount="+temp1[5]+",lamount="+temp1[5]+"*rate,description='"+sqlchequedate+" Principal Amount is "+temp1[5]+"' where sr_no=3 and acno="+principalacno+" and rdocno="+ucrdocno+" and brhId="+branch+"";
						System.out.println("Update Bank Principal: "+strupdateucrprincipal);
						int updateucrprincipal=stmt.executeUpdate(strupdateucrprincipal);
						if(updateucrprincipal<0){
							errorstatus=1;
						}
						String strupdateucrinterest="update my_unclrchqbd set amount="+temp1[6]+",lamount="+temp1[6]+"*rate,description='"+sqlchequedate+" Interest Amount is "+temp1[6]+"' where sr_no=2 and acno="+interestacno+" and rdocno="+ucrdocno+" and brhId="+branch+"";
						System.out.println("Update Bank Interest: "+strupdateucrinterest);
						int updateucrinterest=stmt.executeUpdate(strupdateucrinterest);
						if(updateucrinterest<0){
							errorstatus=1;
						}
						double descamount=Double.parseDouble(temp1[7])*-1;
						String strupdateucramount="update my_unclrchqbd set amount="+temp1[7]+"*-1,lamount=("+temp1[7]+"*-1)*rate,description='"+sqlchequedate+" Amount is "+descamount+"' where sr_no=0 and acno="+amountacno+" and rdocno="+ucrdocno+" and brhId="+branch+"";
						System.out.println("Update Bank Amount: "+strupdateucramount);
						int updateucramount=stmt.executeUpdate(strupdateucramount);
						if(updateucramount<0){
							errorstatus=1;
						}
						String strupdatepurchase="update gl_termloandetd set date='"+sqlchequedate+"',pramt="+temp1[5]+",intstamt="+temp1[6]+",totamt="+temp1[7]+" where rowno="+temp1[2];
						System.out.println("Update Purchase Details: "+strupdatepurchase);
						int updatepurchase=stmt.executeUpdate(strupdatepurchase);
						if(updatepurchase<0){
							errorstatus=1;
						}
						 
						String strpurchaseinsert="insert into gl_termloanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
						"'"+purchasedocno+"','"+sqldate+"','"+purchasetemp[4]+"',"+purchasetemp[5]+","+purchasetemp[6]+","+purchasetemp[7]+","+purchasetemp[8]+",0)";
						System.out.println("Purchase Insert: "+strpurchaseinsert);
						int insertval=stmt.executeUpdate(strpurchaseinsert);
						if(insertval<=0){
							errorstatus=1;
							break;
						}
					}
					else if(temp1[9].equalsIgnoreCase("0")){
						String txtamount=sqlchequedate+" Amount is -"+temp1[7];
						String txtinterest=sqlchequedate+" Interest Amount is "+temp1[6];
						String txtprincipal=sqlchequedate+" Principal Amount is "+temp1[5];
						ArrayList<String> unclearedarray=new ArrayList<String>();
						
						double amount=Double.parseDouble(temp1[7]);
						double baseamount=amount*amountcurrate;
						double interest=Double.parseDouble(temp1[6]);
						double baseinterest=interest*interestcurrate;
						double principal=Double.parseDouble(temp1[5]);
						double baseprincipal=principal*principalcurrate;
						
						unclearedarray.add(amountacno+"::"+amountcurid+"::"+amountcurrate+"::false::"+amount*-1+"::"+txtamount+"::"+baseamount*-1+"::0::0::0");
						// bank  for zero      		
						unclearedarray.add("0::0::0::0::0::0::0::0::0::0");
			    		// interest array      
						unclearedarray.add(interestacno+"::"+interestcurid+"::"+interestcurrate+"::true::"+interest+"::"+txtinterest+"::"+baseinterest+"::0::0::0");
						// loan  array      		
						unclearedarray.add(principalacno+"::"+principalcurid+"::"+principalcurrate+"::true::"+principal+"::"+txtprincipal+"::"+baseprincipal+"::0::0::0");
						int val=0;
						if(errorstatus!=1){
							val=ucpdao.insert(sqlcurrentdate,"UCP","TLN-"+purchasedocno,amountcurrate,sqlchequedate,temp1[4],vendor,0,purchasedesc,amount,0,unclearedarray,session,request,"A",conn);
						}
						
						if(val<=0){
							errorstatus=1;
							break;
						}
						
						int rowcount=0;
						String strrowcount="select max(sr_no) maxsrno from gl_termloandetd where rdocno="+purchasedocno;
						System.out.println("Purchase Rowcount: "+strrowcount);
						ResultSet rsrowcount=stmt.executeQuery(strrowcount);
						while(rsrowcount.next()){
							rowcount=rsrowcount.getInt("maxsrno");
						}
						String strpurchasedetail="INSERT INTO gl_termloandetd(sr_no,pramt,date,intstamt,totamt,chqno,rdocno,bpvno)VALUES"
							       + " ("+(rowcount+1)+","
							       + "'"+(temp1[5].trim().equalsIgnoreCase("undefined") || temp1[5].trim().equalsIgnoreCase("NaN")|| temp1[5].trim().equalsIgnoreCase("")|| temp1[5].isEmpty()?0:temp1[5].trim())+"',"
							       + "'"+(temp1[3].trim().equalsIgnoreCase("undefined") || temp1[3].trim().equalsIgnoreCase("NaN")|| temp1[3].trim().equalsIgnoreCase("")|| temp1[3].isEmpty()?0:sqlchequedate)+"',"
							       + "'"+(temp1[6].trim().equalsIgnoreCase("undefined") || temp1[6].trim().equalsIgnoreCase("NaN")|| temp1[6].trim().equalsIgnoreCase("")|| temp1[6].isEmpty()?0:temp1[6].trim())+"',"
							       + "'"+(temp1[7].trim().equalsIgnoreCase("undefined") || temp1[7].trim().equalsIgnoreCase("NaN")||temp1[7].trim().equalsIgnoreCase("")|| temp1[7].isEmpty()?0:temp1[7].trim())+"',"
							       + "'"+(temp1[4].trim().equalsIgnoreCase("undefined") || temp1[4].trim().equalsIgnoreCase("NaN")||temp1[4].trim().equalsIgnoreCase("")|| temp1[4].isEmpty()?0:temp1[4].trim())+"',"
							       +"'"+purchasedocno+"','"+val+"')";
						System.out.println("Purchase Detail: "+strpurchasedetail);
						int detailinsert=stmt.executeUpdate(strpurchasedetail);
						if(detailinsert<=0){
							errorstatus=1;
							break;
						}
						 
						String strpurchaseinsert="insert into gl_termloanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
						"'"+purchasedocno+"','"+sqldate+"','"+purchasetemp[4]+"',"+purchasetemp[5]+","+purchasetemp[6]+","+purchasetemp[7]+","+val+",0)";
						System.out.println("Purchase Insert: "+strpurchaseinsert);
						int insertval=stmt.executeUpdate(strpurchaseinsert);
						if(insertval<=0){
							errorstatus=1;
							break;
						}
					}
				}
				
			}
			
			for(int i=0;i<deletearray.size();i++){
				String deletetemp1[]=deletearray.get(i).split("::");
				java.sql.Date sqldate=null;
				System.out.println("Delete Array:bpvno==== "+deletetemp1[9]);
				sqldate=objcommon.changeStringtoSqlDate(deletetemp1[3]);
				int defaultdeleterow=Integer.parseInt(deletetemp1[9].trim());
				
				System.out.println("Delete Array:defaultdeleterow==== "+defaultdeleterow);  
				if(defaultdeleterow==0){
					String strdeleteinsert="insert into gl_termloanrestructure(purchasedocno,date,chequeno,principalamt,interestamt,amount,bpvno,deletestatus)values("+
					"'"+deletetemp1[0]+"','"+sqldate+"','"+deletetemp1[4]+"',"+deletetemp1[5]+","+deletetemp1[6]+","+deletetemp1[7]+","+deletetemp1[8]+",1)";
					System.out.println("Delete Insert: "+strdeleteinsert);
					int insertval=stmt.executeUpdate(strdeleteinsert);
					if(insertval<=0){
						errorstatus=1;
						break;
					}			
				}

			}
			
			if(balanceamt!=0.0){
				int restructuretrno=0;
				String strmaxtrno="select (select max(trno)+1 from my_trno) maxtrno";
				ResultSet rstrno=stmt.executeQuery(strmaxtrno);
				int trno=0;
				while(rstrno.next()){
					trno=rstrno.getInt("maxtrno");
					/* restructuretrno=rstrno.getInt("restructuretrno"); */
				}
				int inserttrno=stmt.executeUpdate("insert into my_trno(trno,userno,trtype,brhid,edate,transid)values("+trno+","+session.getAttribute("USERID").toString()+",3,"+branch+",now(),0)");
				if(inserttrno<=0){
					errorstatus=1;
				}
				
				if(restructuretrno==0){
					
					int updateresttrno=stmt.executeUpdate("update gl_termloanm set restructuretrno="+trno+" where doc_no="+purchasedocno);
				}
				String strloanacdetails="select curid,rate from my_head where atype='GL' and m_s=0 and doc_no="+balanceloanacno;
				System.out.println(strloanacdetails);
				String loanaccurid="1";
				double loanaccurrate=0.0;
				ResultSet rsloanacdetails=stmt.executeQuery(strloanacdetails);
				while(rsloanacdetails.next()){
					loanaccurid=rsloanacdetails.getString("curid");
					loanaccurrate=rsloanacdetails.getDouble("rate");
				}
				/* if(restructuretrno!=0){
					int updatejv=stmt.executeUpdate("update my_jvtran set status=7 where tr_no="+restructuretrno);			
				} */
				String sqljv1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,"+
				" costtype,costcode,dTYPE,brhId,tr_no,STATUS) VALUES('"+sqlpostingdate+"','TLN "+purchasedocno+"','"+purchasedocno+"',"+balanceloanacno+","+
				" 'Purchase Loan Restructured of Doc No "+purchasedocno+"',"+loanaccurid+","+loanaccurrate+","+balanceamt+","+balanceamt*loanaccurrate+",0.0,3,1,0,0,"+
				" "+loanaccurrate+",1,0,0,'TLN',"+branch+","+trno+",3)";
				System.out.println(sqljv1);
				int jvval1=stmt.executeUpdate(sqljv1);
				if(jvval1<=0){
					errorstatus=1;
				}
				else{
					String sqljv2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,"+
					" costtype,costcode,dTYPE,brhId,tr_no,STATUS) VALUES('"+sqlpostingdate+"','TLN "+purchasedocno+"','"+purchasedocno+"',"+principalacno+","+
					" 'Purchase Loan Restructured of Doc No "+purchasedocno+"',"+loanaccurid+","+loanaccurrate+","+(balanceamt*-1)+","+(balanceamt*-1)*loanaccurrate+","+
					" 0.0,3,2,0,0,"+loanaccurrate+",-1,0,0,'TLN',"+branch+","+trno+",3)";
					System.out.println(sqljv2);
					int jvval2=stmt.executeUpdate(sqljv2);
					if(jvval2<=0){
						errorstatus=1;
					}
				}
			}
			
			if(!deleteucrdocno.equalsIgnoreCase("")){
				String strdeleteucr="update my_unclrchqbm set status=7 where doc_no in ("+deleteucrdocno+") and brhId="+branch+"";
				System.out.println("Delete Bank UCR: "+strdeleteucr);
				int deleteval=stmt.executeUpdate(strdeleteucr);
				if(deleteval<=0){
					errorstatus=1;
				}
				
			}
			 Statement stmtupdate=conn.createStatement();
			 int updatemaster=stmtupdate.executeUpdate("update gl_termloandetm set loanamt="+principalsum+",restructure=1 where rdocno="+purchasedocno);
			 if(updatemaster<0){
				 errorstatus=1;
			 }
			if(errorstatus!=1){
				conn.commit();
				System.out.println("No Errors");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return errorstatus;
	}
}
