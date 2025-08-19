package com.dashboard.importdata.openingbalance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIMOpeningBalanceDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray openingbalanceGridLoading() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			     
			     
		    	String sql3 = "select * from im_openbalance";
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			    // System.out.println("sql3============="+sql3);
		    	    RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }

	
	public JSONArray employeeListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 int status1=0;
			 	int stat=0;
			 	 String  str="",str1="",str2="",str3="",str4="",str5="",str6="";  
			
			 	 str1="select coalesce(max(trno),0) trno from my_trno ";
					 System.out.println("str1============="+str1);
					
int trno=0;
					 ResultSet rs=stmtEMP1.executeQuery(str1);
					 while(rs.next())
					 {
						 trno=rs.getInt("trno");
					 }
				 str2="insert into my_trno(userno,trtype,brhid,edate,transid,trno) "
				 		+ "select 1,'OPN', brhid,now(),doc_no ,@trno:=@trno+1 srno from "
				 		+ "(select distinct accountno doc_no,1 brhid	 from im_openbalance a ) a  ,(select  @trno:=(select coalesce(max(trno),0) trno from my_trno))b   ";
					 System.out.println("str2============="+str2);

				
				 
				 
				 str3="insert into my_jvtran(tr_no, acno, dramount, rate, curId, out_amount, duedate, clearedon, trtype,  id, "
				 		+ "ref_row, brhid,description, yrId, cldocno, date, dTYPE, stkmove, ldramount, doc_no, LAGE, ref_detail, lbrrate, status) "
				 		+ "select t.trno,h.doc_no accountno,(a.debit-a.credit),h.rate,h.curid,0,null,null,1,if((a.debit-a.credit) <0,-1,1) ,if(srno='',0,srno)  srno,1 brhid,concat('INV NO: ',coalesce(a.doc_no,0),' ',coalesce(date(a.date),'')) description, "
				 		+ "0,h.cldocno,a.date,'OPN',0,cast(replace((a.debit-a.credit),',','') as decimal(15,2)), if(srno='',0,srno) srno,0,'',1,3 "
				 		+ "from im_openbalance a inner join my_trno t on t.transid=a.accountno and t.trno>"+trno+" left join my_head h on a.accountno=h.account "
				 		+ "order by trno";
				 System.out.println("str3============="+str3);
				
				 str4= "insert into my_opnbal(acno, brhId, srno, tr_no, amount, baseamount, curid, rate, total, description, doc_no, date, atype, tranid, debitTotal, creditTotal, status, Basetotal) "
				 		+ "select acno,brhid,tranid,tr_no,dramount,dramount,curid,rate,dramount,description,doc_no,date,'GL',tranid, "
				 		+ "if(dramount>0,dramount,0),if(dramount<0,dramount,0),3,ldramount from my_jvtran where dtype='opn' and tr_no >"+trno+"";
					 System.out.println("str4============="+str4);
					
				 

				 stmtEMP1.executeUpdate(str2);
				 stmtEMP1.executeUpdate(str3);
				 stmtEMP1.executeUpdate(str4);


	//conn.commit();
	System.out.println("Committ****");
	String sql3 = "select * from im_openbalance";
    ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
   // System.out.println("sql3============="+sql3);
	    RESULTDATA=ClsCommon.convertToJSON(resultSet3);


stmtEMP.close();
stmtEMP1.close();

			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
	
	
}
