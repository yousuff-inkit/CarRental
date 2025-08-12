package com.dashboard.accounts.clusteraccountstatement;

 import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClusterAccountStatement  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clusterDetailedAccountStatementGrid(String branch,String fromdate,String todate,String cluster,String clusteraccount,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
			JSONArray RESULTDATA1=new JSONArray();

		 Connection conn =  null;
		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtCLM = conn.createStatement();
			
			 java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		        
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		     }
		     
		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		     }
		     
		     String sql = "",sql1="",sql2="",joins="",casestatement="";
		     
		     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    	 sql+=" and t.brhId="+branch+"";
			}
		     
		    if(!((clusteraccount.equalsIgnoreCase("")) || (clusteraccount.equalsIgnoreCase("0")))){
	                sql2=sql2+" and t.acno="+clusteraccount+"";
	        } else {
	        	    sql2=" and t.acno in (select acno from my_setclusterd where rdocno="+cluster+")";
	        }
		     
		    joins=ClsCommon.getFinanceVocTablesJoins(conn);
			casestatement=ClsCommon.getFinanceVocTablesCase(conn);
			
		     sql = "select a.*,"+casestatement+"b.branchname,coalesce(round(@i:=@i+ldramount,2),0) netamount from (select t.brhid,if(transno=0,'',transno) transno,transtype,date(t.trdate) trdate,if(t.tr_des=0,'',t.tr_des) description,if(t.ref_detail=0,'',t.ref_detail) ref_detail,"
		     	+ "t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(100)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(100)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(100)) debit,"
		    	+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(100)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des,t.acno,2 srno,"
				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1"+sql+""+sql2+" union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
				+ ""+sql2+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+",(select @i:=0) as i where 1=1"+sql1+" order by a.account,a.trdate,a.transno";
			System.out.println("sql============"+sql);
			 ResultSet resultSet = stmtCLM.executeQuery(sql);
			 
			 ArrayList<String> accountstatementarray= new ArrayList<String>();
			 ArrayList<String> clmarray= new ArrayList<String>();

			 String accountno="",accountname="",oldaccountno="",oldaccountname="",parentid="",debittotals="0.00",credittotals="0.00",netamounts="0.00";
			 int id=1;
			 double debittotal=0.00,credittotal=0.00,netamount=0.00;
			 
				while(resultSet.next()){
					accountno=resultSet.getString("account");
					accountname=resultSet.getString("accountname");

					if(!(oldaccountno.equalsIgnoreCase(accountno))){
					    parentid=null;
					    
					    if(id!=1){
					    	
					    	if(debittotal==0.00){
					    		debittotals=String.valueOf("");
					    	}else {
					    		debittotal=ClsCommon.Round(debittotal, 2);
					    		debittotals=String.valueOf(debittotal);
					    	}
					    	
					    	if(credittotal==0.00){
					    		credittotals=String.valueOf("");
					    	}else {
					    		credittotal=ClsCommon.Round(credittotal, 2);
					    		credittotals=String.valueOf(credittotal);
					    	}
					    	
					    	if(netamount==0.00){
					    		netamounts=String.valueOf("");
					    	}else {
					    		netamount=ClsCommon.Round((debittotal-credittotal), 2);
					    		netamounts=String.valueOf(netamount);
					    	}
					    	
					    	accountstatementarray.add(id+"::"+parentid+"::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: "+oldaccountname+":: ");
					    	clmarray.add(id+"::"+parentid+"::null:: :: :: ::NET BALANCE::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: "+oldaccountname+":: ");

					    	debittotals="0.00";credittotals="0.00";netamounts="0.00";
					    	id++;
					    }
					    debittotal=0.00;credittotal=0.00;netamount=0.00;
					    
					    accountstatementarray.add(id+"::"+parentid+"::null:: :: ::"+resultSet.getString("accountname")+":: :: :: :: :: "+accountno+":: "+resultSet.getString("accountname")+":: ");
					    clmarray.add(id+"::"+parentid+"::null:: :: ::"+resultSet.getString("accountname")+":: :: :: :: :: "+accountno+":: "+resultSet.getString("accountname")+":: ");

						oldaccountno=accountno;
						oldaccountname=accountname;
						parentid=id+"";
						id++;
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=ClsCommon.Round((debittotal-credittotal),2);
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						clmarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));

					}else{
						
						debittotal=debittotal+resultSet.getDouble("debit");
						credittotal=credittotal+resultSet.getDouble("credit");
						netamount=ClsCommon.Round((debittotal-credittotal),2);
						
						accountstatementarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));
						clmarray.add(id+"::"+parentid+"::"+resultSet.getString("trdate")+"::"+resultSet.getString("transtype")+"::"+resultSet.getString("transno")+"::"+resultSet.getString("description")+"::"+resultSet.getString("ref_detail")+"::"+resultSet.getString("debit")+"::"+resultSet.getString("credit")+"::"+netamount+":: "+accountno+":: "+resultSet.getString("accountname")+"::"+resultSet.getString("branchname"));

					}

					id++;
				}
				
				if(debittotal==0.00){
		    		debittotals=String.valueOf("");
		    	}else {
		    		debittotal=ClsCommon.Round(debittotal, 2);
		    		debittotals=String.valueOf(debittotal);
		    	}
		    	
		    	if(credittotal==0.00){
		    		credittotals=String.valueOf("");
		    	}else {
		    		credittotal=ClsCommon.Round(credittotal, 2);
		    		credittotals=String.valueOf(credittotal);
		    	}
		    	
		    	if(netamount==0.00){
		    		netamounts=String.valueOf("");
		    	}else {
		    		netamount=ClsCommon.Round((debittotal-credittotal), 2);
		    		netamounts=String.valueOf(netamount);
		    	}
				
				accountstatementarray.add(id+":: ::null:: :: ::NET BALANCE:: ::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: "+accountname+" :: ");
				clmarray.add(id+":: ::null:: :: :: ::NET BALANCE::"+debittotals+"::"+credittotals+"::"+netamounts+"::0:: "+accountname+" :: ");

				System.out.println("Array=====>"+accountstatementarray);
			 RESULTDATA=convertArrayToJSON(accountstatementarray);
			 RESULTDATA1=convertArrayToJSON(clmarray);

			 String sqlConfig="select method from gl_config where field_nme='clusterAccountStatement'";
				ResultSet resultSetConfig = stmtCLM.executeQuery(sqlConfig);
				String valueOfConfig="";
				while(resultSetConfig.next()){
					valueOfConfig=resultSetConfig.getString("method");
				}
				//System.out.println("RESULTDATA=="+RESULTDATA);
				String amount="";
				if(valueOfConfig.equalsIgnoreCase("1")){  
					
					String sqls="Truncate CLUSTERSTATEMENT";
					int data= stmtCLM.executeUpdate(sqls);
					 
					 for (int i = 0, size = RESULTDATA1.size(); i < size; i++) {
					       JSONObject objectInArray = RESULTDATA1.getJSONObject(i);
						
					       java.sql.Date sqlDate = null;

				           //   sqlDate = ClsCommon.changeStringtoSqlDate(objectInArray.getString("trdate"));

			            	CallableStatement stmtC=null; 
			            	//System.out.println("branchname----"+objectInArray.getString("branchname")+"debit---"+objectInArray.getString("debit")+"credit-----"+objectInArray.getString("credit")+"refdetails---"+objectInArray.getString("ref_detail"));
if(!(objectInArray.getString("netamount").equalsIgnoreCase(" ") && objectInArray.getString("debit").equalsIgnoreCase(" ") && objectInArray.getString("credit").equalsIgnoreCase(" ")))
{
								stmtC=conn.prepareCall("INSERT INTO CLUSTERSTATEMENT (TRDATE,TRANSTYPE,TRANSNO,`DESC`,DEBIT,CREDIT,NETAMOUNT,ACCOUNTNAME,BRANCHNAME,ref_detail) values(?,?,?,?,?,?,?,?,?,?)");
								stmtC.setString(1,objectInArray.getString("trdate").trim().equalsIgnoreCase("null")?"":objectInArray.getString("trdate"));          
								stmtC.setString(2,objectInArray.getString("transtype")); 
								stmtC.setString(3,objectInArray.getString("transno")); 
								stmtC.setString(4,objectInArray.getString("description")); 
								stmtC.setString(5,objectInArray.getString("debit"));     
								stmtC.setString(6,objectInArray.getString("credit")); 
								stmtC.setString(7,objectInArray.getString("netamount")); 
								stmtC.setString(8,objectInArray.getString("accountname"));
								stmtC.setString(9,objectInArray.getString("branchname").equalsIgnoreCase("null")?"":objectInArray.getString("branchname")); 
								stmtC.setString(10,objectInArray.getString("ref_detail").equalsIgnoreCase(null)?"":objectInArray.getString("ref_detail"));

								int val=stmtC.executeUpdate();                                

								
								
							//	System.out.println("sql3========"+sql3);


							//	int data1= stmtCLM.executeUpdate(sql3);
								amount="";       
					       }
					 }
					    }
				
			 
			 
			 
			 
			 stmtCLM.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
        }
	
	public JSONArray accountDetailsGridLoading(String branch,String fromdate,String todate,String clusterdocno,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!(check.equalsIgnoreCase("1")))
		{
			return RESULTDATA;
		}
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCLM = conn.createStatement();
			    
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				/*if(!(sqlFromDate==null)){
		        	sql+=" and j.date>='"+sqlFromDate+"'";
			    }*/
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and j.date<='"+sqlToDate+"'";
			    }
		        
			    sql = "select d.acno doc_no,h.account,h.description,coalesce(round(sum(j.dramount),2),0) netbalance from my_setclusterd d left join my_jvtran j on "
			    		+ "d.acno=j.acno left join my_head h on h.doc_no=d.acno where j.status=3 and d.rdocno="+clusterdocno+" "+sql+" group by d.acno";
			    
			   // System.out.println("net balance grid=="+sql);
			    
			    ResultSet resultSet = stmtCLM.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCLM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray clusterDetailsSearch(HttpSession session,String docno,String date,String clustername,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtCLM = conn.createStatement();
    	   
    	   if(check.equalsIgnoreCase("1")){
        	    java.sql.Date sqlDate=null;
        	   
    	        date.trim();
    	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
    	        {
    	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
    	        }
    	        
    	        String sqltest="";

    	        if(!(docno.equalsIgnoreCase(""))){
    	        	sqltest=sqltest+" and doc_no like '%"+docno+"%'";
    	        }
    	        if(!(sqlDate==null)){
    	        	sqltest=sqltest+" and date='"+sqlDate+"'";
    	        } 
    	        if(!(clustername.equalsIgnoreCase(""))){
    	            sqltest=sqltest+" and desc1 like '%"+clustername+"%'";
    	        }
    	        
	       ResultSet resultSet = stmtCLM.executeQuery("select doc_no, date, desc1 name, remarks description from my_setclusterm where status=3"+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
    	   
    	   }
	       stmtCLM.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			for (int i = 0; i < arrayList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] balanceSheetArray=arrayList.get(i).split("::");
				
				obj.put("id",balanceSheetArray[0]);
				obj.put("parentid",balanceSheetArray[1]);
				obj.put("trdate",balanceSheetArray[2]);
				obj.put("transtype",balanceSheetArray[3]);
				obj.put("transno",balanceSheetArray[4]);
				obj.put("description",balanceSheetArray[5]);
				obj.put("ref_detail",balanceSheetArray[6]);
				obj.put("debit",balanceSheetArray[7]);
				obj.put("credit",balanceSheetArray[8]);
				obj.put("netamount",balanceSheetArray[9]);
				obj.put("accountno",balanceSheetArray[10]);
				obj.put("accountname",balanceSheetArray[11]);
				obj.put("branchname",balanceSheetArray[12]);
				
				jsonArray.add(obj);
			}
			return jsonArray;
			}
	
	
	public  ClsClusterAccountsStatementBean getPrint(HttpServletRequest request,String acno,String branch,String fromdate,String todate) throws SQLException {
		ClsClusterAccountsStatementBean bean = new ClsClusterAccountsStatementBean();
		
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtAccountStatement = conn.createStatement();
		String sql="";String mainbranch="";
		
		if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
        	mainbranch=branch;        	
		}else{
			mainbranch="1";
		}
		
		sql="select b.doc_no brhid,b.branchname,b.address brchaddress,'Statement of Cluster Account' vouchername,CONCAT('Period From ',DATE_FORMAT('"+sqlFromDate+"','%d-%m-%Y'),' To ',DATE_FORMAT('"+sqlToDate+"' ,'%d-%m-%Y')) vouchername1,"
				+ "c.company,c.address,c.tel,c.tel2,c.email,c.web,c.fax,b.pbno,b.stcno,b.cstno,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
				+ "b.cmpid=c.doc_no where b.doc_no="+mainbranch+" group by brhid";
		
		ResultSet resultSet = stmtAccountStatement.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLblbranchaddress(resultSet.getString("brchaddress"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			bean.setLblcomptel2(resultSet.getString("tel2"));
			bean.setLblcompwebsite(resultSet.getString("web"));
			bean.setLblcompemail(resultSet.getString("email"));
			if(resultSet.getString("company").equalsIgnoreCase("PAL AUTO GARAGE")&& resultSet.getInt("brhid")!=3){    
	    		   bean.setLblcompname(resultSet.getString("company")+" (Br.)");
	    		  // System.out.println("in");
	    	   }  
		}
		
		String sqls="select c.code,j.acno,coalesce(t.account,'') account,coalesce(t.description,'') description,coalesce(a.period,0) minperiod,coalesce(a.period2,0) maxperiod,coalesce(a.credit,0) creditlimit,coalesce(a.address,'') customeraddress,coalesce(a.mail1,'') customeremail,"
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax from my_setclusterd d left join my_jvtran j on d.acno=j.acno left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_acbook a on a.acno=t.doc_no where "
				+ "d.rdocno="+acno+" group by acno";
		//System.out.println("curfetch==="+sqls);
		ResultSet resultSets = stmtAccountStatement.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setAccountno(resultSets.getString("account"));
			bean.setAccountname(resultSets.getString("description"));
			bean.setAccountaddress(resultSets.getString("customeraddress"));
			bean.setAccountemail(resultSets.getString("customeremail"));
			bean.setAccountmobile(resultSets.getString("customermobile"));
			bean.setAccountphone(resultSets.getString("customertel"));
			bean.setAccountfax(resultSets.getString("customerfax"));
			bean.setCreditperiodmin(resultSets.getString("minperiod"));
			bean.setCreditperiodmax(resultSets.getString("maxperiod"));
			bean.setCreditlimit(resultSets.getString("creditlimit"));
			bean.setCurcode(resultSets.getString("code"));
		}
		
		stmtAccountStatement.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }

	
	
     }
