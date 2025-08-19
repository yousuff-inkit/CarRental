package com.finance.accountssetup.accountsMaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.DatabaseMetaData;

import java.io.FileInputStream; 
import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
public class ClsAccMasterDAO {

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO =new ClsConnection();
	
	Connection conn;
	
	public int insert(Date date_accountmaster, String accountGroup, String category, String acccategory, String accountcode, String accountName, String accountgpName, String branchone, String branchtwo, String Interbranch, String mode, HttpSession session, String Formdetailcode, HttpServletRequest request, int crid, double rates, String categorys) throws SQLException {  
		try {
		    int docno=0,docno1 = 0;
		    conn = connDAO.getMyConnection();
		    conn.setAutoCommit(false);
		    /*		Statement stmtAccMaster1 = conn.createStatement ();
					String sql = "";
					
					if(accountcode.trim().equalsIgnoreCase("")){
						sql=" and account=(select max(doc_no)+1 from my_head)";
					}
					else{
						sql=" and account="+accountcode;
					}
					
					String sql1="select doc_no from my_head where 1=1 "+sql;
					
				
				
					ResultSet resultSet1 = stmtAccMaster1.executeQuery (sql1);
					
					while (resultSet1.next()) {
				
									 return -1;
						
				     }*/
		    Statement stmtac = conn.createStatement();
		    Statement stmtAccMaster1 = conn.createStatement();
		    Statement stmtac1 = conn.createStatement();
		    
		  
		    
		    String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";

		    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
		    int configmethod = 0;
		    if (rssqlconfig.next()) {
		      configmethod = rssqlconfig.getInt("method");
		    }

		    if (configmethod==1) {
		    	
		    	 String sqlden = "select den from my_head where den='"+accountGroup+"' ";
		    			    ResultSet rssqlden = stmtac1.executeQuery(sqlden);
		    			    int configden = 0;
		    			    if (rssqlden.next()) {
		    			    	configden = rssqlden.getInt("den");
		    			    }
		    			    if(configden!=301) {
		    			    	
		    			    	System.out.println("Entered");
		      Statement stmtAcc = conn.createStatement();

		      Properties prop = new Properties();
		      String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
		      filePath = filePath.replace("\\", "\\\\");
		      String db = "",dbcomp="";
		      FileInputStream ip = new FileInputStream(filePath);
		      prop.load(ip);
		      String dbname = prop.getProperty("intercompdb");
		      String multicompconfig = prop.getProperty("multicompany");
		      JSONArray dbdata = new JSONArray();
		      
		      
		      
		      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
		    	  
		    	  Context initCtx = new InitialContext();
		            
		            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
		            
		            if (ds.getConnection() != null) {
		                java.sql.DatabaseMetaData metaData = conn.getMetaData();
		                String url = metaData.getURL();
		                
		                String comp = url.substring(url.lastIndexOf("/") + 1);
		           
		//    	  Statement stmtrowno = conn.createStatement();

		//            String row="select coalesce(max(rowno)+1,1) intrcmprowno  from "+dbname+".my_intrcmpdocno";
		 //           ResultSet rsrowno = stmtrowno.executeQuery(row);
		//	        int intrcmprowno=0;
		 //           while (rsrowno.next()) {
		  //          	intrcmprowno=rsrowno.getInt("intrcmprowno");
		  //          }
		   //         Statement stmtrowno1 = conn.createStatement();

		  //          String sqluprow =" insert into "+dbname+".my_intrcmpdocno (comp1,comp2,comp3,comp4,comp5,comp6)values(1,1,1,1,1,1)";
		   //         int ss=stmtrowno1.executeUpdate(sqluprow); 
		        	
		 
		        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
		        System.out.println(strsql);
		        ResultSet rsacc = stmtAcc.executeQuery(strsql);
		        while (rsacc.next()) {
		          db = rsacc.getString("dbname");
		          dbcomp = rsacc.getString("compname");

		          if (! (db.equalsIgnoreCase(""))) {
		            if (accountcode.equalsIgnoreCase("") || accountcode.equalsIgnoreCase("undefined") || accountcode == null) {
		              //String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM " + db + ".my_head WHERE den=(SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM " + db + ".my_agrp WHERE fi_id = (SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ")";
		              String sqlaccno="";
		              if(acccategory.equalsIgnoreCase("mainacc")) {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM  " + db + ".my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM   " + db + ".my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM  " + db + ".my_head WHERE doc_no=(SELECT grpno FROM  " + db + ".my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM  " + db + ".my_agrp WHERE fi_id = "+accountGroup;
		              } else {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM "+db+".my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM  "+db+".my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM "+db+".my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM "+db+".my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM "+db+".my_agrp WHERE fi_id = (SELECT den FROM  "+db+".my_head WHERE doc_no="+accountGroup+")";
		              }
		              
		              System.out.println(sqlaccno);
		              ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
		              while (rssa.next()) {
		                accountcode = rssa.getString("acc");
		              }
		            }
		            
		            
		         
	            
		            CallableStatement stmtAccMaster = conn.prepareCall("{CALL " + db + ".accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		            stmtAccMaster.registerOutParameter(2, java.sql.Types.INTEGER);

		            stmtAccMaster.setDate(1, date_accountmaster);
		            stmtAccMaster.setString(3, accountGroup);
		            stmtAccMaster.setString(4, accountcode);
		            stmtAccMaster.setString(5, accountName);
		            stmtAccMaster.setString(6, accountgpName);
		            stmtAccMaster.setString(7, branchone);
		            stmtAccMaster.setString(8, branchtwo);
		            stmtAccMaster.setString(9, session.getAttribute("BRANCHID").toString());
		            stmtAccMaster.setString(10, session.getAttribute("USERID").toString());
		            stmtAccMaster.setString(11, session.getAttribute("CURRENCYID").toString());
		            stmtAccMaster.setString(12, category);
		            stmtAccMaster.setString(13, acccategory);
		            stmtAccMaster.setString(14, Interbranch);
		            stmtAccMaster.setString(15, Formdetailcode);
		            stmtAccMaster.setString(16, mode);
		            System.out.println(stmtAccMaster);
		            stmtAccMaster.executeUpdate();
		           
		            docno1 = stmtAccMaster.getInt("docNo");
		            System.out.println(docno1);
		            stmtAccMaster.close();
               if(db.equalsIgnoreCase(comp)) {
            	  docno=docno1;
            	  
              } 
              
            	  String sql1 = "";

		            String acc = "";
		            sql1 = "select account from " + db + ".my_head where doc_no=" + docno1;

		            ResultSet resultSet1 = stmtAccMaster1.executeQuery(sql1);

		             while (resultSet1.next()) {

		              acc = (resultSet1.getString("account"));

		            }

		            request.setAttribute("accountcode", acc);

		            if (docno1 > 0) {

		              if (categorys.equalsIgnoreCase("transaction")) {
		                Statement stmtAccMaster2 = conn.createStatement();   

		                String sqlsss = "update " + db + ".my_head set curid='" + crid + "',rate='" + rates + "' where  doc_no=" + docno1;
		                //											System.out.println(sqlsss);
		                stmtAccMaster2.executeUpdate(sqlsss);

		              } else if (acccategory.equalsIgnoreCase("mainacc")) {
		            	  Statement stmtAccMaster2 = conn.createStatement();   
		            	  String sqlsss = "update " + db + ".my_head set rate='1.00' where  doc_no=" + docno1;
			                //											System.out.println(sqlsss);
			              stmtAccMaster2.executeUpdate(sqlsss);
			              stmtAccMaster2.close();

		              }
		             // Statement stmtuprowno = conn.createStatement();   
		              //String sqluprowno="update "+dbname+".my_intrcmpdocno set " + db + "="+docno1+"  where rowno= '"+intrcmprowno+"' ";
		             // System.out.println(sqluprowno);
		              //stmtuprowno.executeUpdate(sqluprowno);
		              
		            }

		          }

		        }
		 }   
		      } else {
		    	  System.out.println("Entered Else - ");
		    	  if (accountcode.equalsIgnoreCase("") || accountcode.equalsIgnoreCase("undefined") || accountcode == null) {
		              //String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM " + db + ".my_head WHERE den=(SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM " + db + ".my_agrp WHERE fi_id = (SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ")";
		              String sqlaccno="";
		              if(acccategory.equalsIgnoreCase("mainacc")) {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM my_head WHERE doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM my_agrp WHERE fi_id = "+accountGroup;
		              } else {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM  my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM my_head WHERE doc_no="+accountGroup+")";
		              }
		              
		              System.out.println(sqlaccno);
		              ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
		              while (rssa.next()) {
		                accountcode = rssa.getString("acc");
		              }
		            }
		            
		            
		         
	            
		            CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		            stmtAccMaster.registerOutParameter(2, java.sql.Types.INTEGER);

		            stmtAccMaster.setDate(1, date_accountmaster);
		            stmtAccMaster.setString(3, accountGroup);
		            stmtAccMaster.setString(4, accountcode);
		            stmtAccMaster.setString(5, accountName);
		            stmtAccMaster.setString(6, accountgpName);
		            stmtAccMaster.setString(7, branchone);
		            stmtAccMaster.setString(8, branchtwo);
		            stmtAccMaster.setString(9, session.getAttribute("BRANCHID").toString());
		            stmtAccMaster.setString(10, session.getAttribute("USERID").toString());
		            stmtAccMaster.setString(11, session.getAttribute("CURRENCYID").toString());
		            stmtAccMaster.setString(12, category);
		            stmtAccMaster.setString(13, acccategory);
		            stmtAccMaster.setString(14, Interbranch);
		            stmtAccMaster.setString(15, Formdetailcode);
		            stmtAccMaster.setString(16, mode);
		            System.out.println(stmtAccMaster);
		            stmtAccMaster.executeUpdate();
		           
		            docno = stmtAccMaster.getInt("docNo");
		            System.out.println(docno);
		            stmtAccMaster.close(); 
              
            	  String sql1 = "";

		            String acc = "";
		            sql1 = "select account from my_head where doc_no=" + docno;

		            ResultSet resultSet1 = stmtAccMaster1.executeQuery(sql1);

		             while (resultSet1.next()) {

		              acc = (resultSet1.getString("account"));

		            }

		            request.setAttribute("accountcode", acc);

		            if (docno > 0) {

		              if (categorys.equalsIgnoreCase("transaction")) {
		                Statement stmtAccMaster2 = conn.createStatement();   

		                String sqlsss = "update my_head set curid='" + crid + "',rate='" + rates + "' where  doc_no=" + docno;
		                //											System.out.println(sqlsss);
		                stmtAccMaster2.executeUpdate(sqlsss);

		              } else if (acccategory.equalsIgnoreCase("mainacc")) {
		            	  Statement stmtAccMaster2 = conn.createStatement();   
		            	  String sqlsss = "update my_head set rate='1.00' where  doc_no=" + docno;
			                //											System.out.println(sqlsss);
			              stmtAccMaster2.executeUpdate(sqlsss);
			              stmtAccMaster2.close();

		              }
		              Statement stmtuprowno = conn.createStatement();   
		              //String sqluprowno="update "+dbname+".my_intrcmpdocno set " + db + "="+docno1+"  where rowno= '"+intrcmprowno+"' ";
		             // System.out.println(sqluprowno);
		              //stmtuprowno.executeUpdate(sqluprowno);
		              
		            }

		      }

		   }else {
			   	
			    if (accountcode.equalsIgnoreCase("") || accountcode.equalsIgnoreCase("undefined") || accountcode == null) {
			       // String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM my_head WHERE den=(SELECT den FROM my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM my_head WHERE doc_no=" + accountGroup + ")";
			    	 String sqlaccno="";
		              if(acccategory.equalsIgnoreCase("mainacc")) {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM  my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM  my_head WHERE doc_no=(SELECT grpno FROM  my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM my_agrp WHERE fi_id = "+accountGroup;
		              } else {
		            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM  my_head WHERE doc_no="+accountGroup+")";
		              } 
			    	System.out.println(sqlaccno);
			    	ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
			        while (rssa.next()) {
			          accountcode = rssa.getString("acc");
			        }
			      }


			      CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			      stmtAccMaster.registerOutParameter(2, java.sql.Types.INTEGER);
			      /*	if(accountcode.equalsIgnoreCase(""))
						{
							System.out.println("0000000");
						stmtAccMaster.registerOutParameter(4,java.sql.Types.VARCHAR);
						}
						else
						{
							System.out.println("1111111");*/
			      //stmtAccMaster.setString(4,accountcode);	
			      /*}*/
			      stmtAccMaster.setDate(1, date_accountmaster);
			      stmtAccMaster.setString(3, accountGroup);
			      stmtAccMaster.setString(4, accountcode);
			      stmtAccMaster.setString(5, accountName);
			      stmtAccMaster.setString(6, accountgpName);
			      stmtAccMaster.setString(7, branchone);
			      stmtAccMaster.setString(8, branchtwo);
			      stmtAccMaster.setString(9, session.getAttribute("BRANCHID").toString());
			      stmtAccMaster.setString(10, session.getAttribute("USERID").toString());
			      stmtAccMaster.setString(11, session.getAttribute("CURRENCYID").toString());
			      stmtAccMaster.setString(12, category);
			      stmtAccMaster.setString(13, acccategory);
			      stmtAccMaster.setString(14, Interbranch);
			      stmtAccMaster.setString(15, Formdetailcode);
			      stmtAccMaster.setString(16, mode);
			      //           System.out.println(stmtAccMaster);
			      stmtAccMaster.executeUpdate();
			      docno = stmtAccMaster.getInt("docNo");
			      stmtAccMaster.close();

			      String sql1 = "";

			      String acc = "";
			      sql1 = "select account from my_head where doc_no=" + docno;

			      ResultSet resultSet1 = stmtAccMaster1.executeQuery(sql1);

			      while (resultSet1.next()) {

			        acc = (resultSet1.getString("account"));

			      }

			      request.setAttribute("accountcode", acc);

			      if (docno > 0) {

			        if (categorys.equalsIgnoreCase("transaction")) {
			          Statement stmtAccMaster2 = conn.createStatement();

			          String sqlsss = "update my_head set curid='" + crid + "',rate='" + rates + "' where  doc_no=" + docno;
			          //						System.out.println(sqlsss);
			          stmtAccMaster2.executeUpdate(sqlsss);

			        } else if (acccategory.equalsIgnoreCase("mainacc")) {
		            	  Statement stmtAccMaster2 = conn.createStatement();   
		            	  String sqlsss = "update my_head set rate='1.00' where  doc_no=" + docno;
			                //											System.out.println(sqlsss);
			              stmtAccMaster2.executeUpdate(sqlsss);
			              stmtAccMaster2.close();

		            }
			      }

			   
			   
		   }
		}else {

		      if (accountcode.equalsIgnoreCase("") || accountcode.equalsIgnoreCase("undefined") || accountcode == null) {
		        //String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM my_head WHERE den=(SELECT den FROM my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM my_head WHERE doc_no=" + accountGroup + ")";
		    	  String sqlaccno="";
	              if(acccategory.equalsIgnoreCase("mainacc")) {
	            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM  my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM  my_head WHERE doc_no=(SELECT grpno FROM  my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM my_agrp WHERE fi_id = "+accountGroup;
	              } else {
	            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM  my_head WHERE doc_no="+accountGroup+")";
	              }   
		        ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
		        while (rssa.next()) {
		          accountcode = rssa.getString("acc");
		        }
		      }


		      CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		      stmtAccMaster.registerOutParameter(2, java.sql.Types.INTEGER);
		      /*	if(accountcode.equalsIgnoreCase(""))
					{
						System.out.println("0000000");
					stmtAccMaster.registerOutParameter(4,java.sql.Types.VARCHAR);
					}
					else
					{
						System.out.println("1111111");*/
		      //stmtAccMaster.setString(4,accountcode);	
		      /*}*/
		      stmtAccMaster.setDate(1, date_accountmaster);
		      stmtAccMaster.setString(3, accountGroup);
		      stmtAccMaster.setString(4, accountcode);
		      stmtAccMaster.setString(5, accountName);
		      stmtAccMaster.setString(6, accountgpName);
		      stmtAccMaster.setString(7, branchone);
		      stmtAccMaster.setString(8, branchtwo);
		      stmtAccMaster.setString(9, session.getAttribute("BRANCHID").toString());
		      stmtAccMaster.setString(10, session.getAttribute("USERID").toString());
		      stmtAccMaster.setString(11, session.getAttribute("CURRENCYID").toString());
		      stmtAccMaster.setString(12, category);
		      stmtAccMaster.setString(13, acccategory);
		      stmtAccMaster.setString(14, Interbranch);
		      stmtAccMaster.setString(15, Formdetailcode);
		      stmtAccMaster.setString(16, mode);
		      //           System.out.println(stmtAccMaster);
		      stmtAccMaster.executeUpdate();
		      docno = stmtAccMaster.getInt("docNo");
		      stmtAccMaster.close();

		      String sql1 = "";

		      String acc = "";
		      sql1 = "select account from my_head where doc_no=" + docno;

		      ResultSet resultSet1 = stmtAccMaster1.executeQuery(sql1);

		      while (resultSet1.next()) {

		        acc = (resultSet1.getString("account"));

		      }

		      request.setAttribute("accountcode", acc);

		      if (docno > 0) {

		        if (categorys.equalsIgnoreCase("transaction")) {
		          Statement stmtAccMaster2 = conn.createStatement();

		          String sqlsss = "update my_head set curid='" + crid + "',rate='" + rates + "' where  doc_no=" + docno;
		          //						System.out.println(sqlsss);
		          stmtAccMaster2.executeUpdate(sqlsss);

		        } else if (acccategory.equalsIgnoreCase("mainacc")) {
	            	  Statement stmtAccMaster2 = conn.createStatement();   
	            	  String sqlsss = "update my_head set rate='1.00' where  doc_no=" + docno;
		                //											System.out.println(sqlsss);
		              stmtAccMaster2.executeUpdate(sqlsss);
		              stmtAccMaster2.close();

	            }
		      }

		    }
		    if (docno > 0) {
		      conn.commit();
		      stmtAccMaster1.close();
		      //stmtAccMaster.close();
		      conn.close();
		      return docno;
		      
		    }

		  } catch(Exception e) {
		    e.printStackTrace();
		    conn.close();
		  }
		  return 0;
		}
	


	public int edit(int docno,Date date_accountmaster,String accountGroup,String category,String acccategory,
			String accountcode,String accountName,String accountgpName, String branchone,String branchtwo,String 
			Interbranch,String mode, HttpSession session,String Formdetailcode,HttpServletRequest request, int crid, double rates,String categorys) throws SQLException
	{
		try{
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);
			/*Statement stmtAccMaster1 = conn.createStatement ();
			String sql = "";
			*/
		/*	if(accountcode.trim().equalsIgnoreCase("")){
				sql=" and account="+docno+" and   doc_no!="+docno+"";
			}
			else{
				sql=" and account ="+accountcode+" and   doc_no!="+docno+"";
			}
			
			String sql1="select doc_no from my_head where 1=1 "+sql;
			ResultSet resultSet1 = stmtAccMaster1.executeQuery (sql1);
			
			while (resultSet1.next()) {
		
							 return -1;
				          
		     }*/
			 System.out.println("Entered - "+docno+ " - "+accountcode);
			 Statement stmtac = conn.createStatement();
			    Statement stmtAccMaster1 = conn.createStatement();
			    Statement stmtac1 = conn.createStatement();
			    Statement stmtAccMaster12 = conn.createStatement ();
				
			  
			  
			    String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";

			    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
			    int configmethod = 0;
			    if (rssqlconfig.next()) {
			      configmethod = rssqlconfig.getInt("method");
			    }

			    if (configmethod==1) {
			    	
			    	
			    	 Statement stmtAcc = conn.createStatement();
			    	 Statement stmtAcc1 = conn.createStatement();

				      Properties prop = new Properties();
				      String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
				      filePath = filePath.replace("\\", "\\\\");
				      String db = "",dbcomp="";
				      FileInputStream ip = new FileInputStream(filePath);
				      prop.load(ip);
				      String dbname = prop.getProperty("intercompdb");
				      String multicompconfig = prop.getProperty("multicompany");
				      JSONArray dbdata = new JSONArray();
				      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
				    	  int docnorow=0;
				    	  docnorow=docno;
				    	  Context initCtx = new InitialContext();
				            
				            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
				            
				            if (ds.getConnection() != null) {
				                java.sql.DatabaseMetaData metaData = conn.getMetaData();
				                String url = metaData.getURL();
				                
				                String comp = url.substring(url.lastIndexOf("/") + 1);
			                
				        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
				        System.out.println(strsql);
				        ResultSet rsacc = stmtAcc.executeQuery(strsql);
				        
				        while (rsacc.next()) {
				          db = rsacc.getString("dbname");
				          dbcomp = rsacc.getString("compname");

							/*
							 * String sqlcode1=" select " + db + "  editdocno from  " + dbname +
							 * ".my_intrcmpdocno where "+comp+"="+docnorow; System.out.println(sqlcode1);
							 * ResultSet rsacc11 = stmtAcc1.executeQuery(sqlcode1); int editdocno=0; while
							 * (rsacc11.next()) { editdocno=rsacc11.getInt("editdocno");
							 * 
							 * }
							 */		
				          if (! (db.equalsIgnoreCase(""))) {
				        	
							// docno=editdocno;	    
				        	  
				        	  String prevden = "";
				        	  String checkchangeDEN = "select den from "+db+".my_head where doc_no="+docno;
				        	  System.out.println(checkchangeDEN);
				        	  ResultSet rscheckchangeDEN = stmtAccMaster1.executeQuery(checkchangeDEN);
				        	  if(rscheckchangeDEN.next()) {
				        		  prevden = rscheckchangeDEN.getString("den");
				        	  }
				        	  
				        	  if (!accountGroup.equalsIgnoreCase(prevden)) {
					              //String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM " + db + ".my_head WHERE den=(SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM " + db + ".my_agrp WHERE fi_id = (SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ")";
					              String sqlaccno="";
					              if(acccategory.equalsIgnoreCase("mainacc")) {
					            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM  " + db + ".my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM   " + db + ".my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM  " + db + ".my_head WHERE doc_no=(SELECT grpno FROM  " + db + ".my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM  " + db + ".my_agrp WHERE fi_id = "+accountGroup;
					              } else {
					            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM "+db+".my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM  "+db+".my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM "+db+".my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM "+db+".my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM "+db+".my_agrp WHERE fi_id = (SELECT den FROM  "+db+".my_head WHERE doc_no="+accountGroup+")";
					              }
					              
					              System.out.println(sqlaccno);
					              ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
					              while (rssa.next()) {
					                accountcode = rssa.getString("acc");
					              }
					            }
						
				        	   CallableStatement stmtAccMaster = conn.prepareCall("{CALL " + db + ".accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				        		stmtAccMaster.setDate(1,date_accountmaster);
				    			stmtAccMaster.setInt(2, docno);
				    			stmtAccMaster.setString(3,accountGroup);
				    			stmtAccMaster.setString(4,accountcode);
				    			stmtAccMaster.setString(5,accountName);
				    			stmtAccMaster.setString(6,accountgpName);
				    			stmtAccMaster.setString(7,branchone);
				    			stmtAccMaster.setString(8,branchtwo);
				    			stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
				    			stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
				    			stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
				    			stmtAccMaster.setString(12,category);
				    			stmtAccMaster.setString(13,acccategory);
				    			stmtAccMaster.setString(14,Interbranch);
				    			stmtAccMaster.setString(15,Formdetailcode);
				    			stmtAccMaster.setString(16,"E");
				    			System.out.println(stmtAccMaster);
				    			int aaa=stmtAccMaster.executeUpdate();
				    		//	System.out.println(aaa);
				    			if(aaa<0) {
				    				return 0;
				    			}
//				    			System.out.println(stmtAccMaster);
				    			// docno=stmtAccMaster.getInt("docNo");
				    			 stmtAccMaster.close();
//				    			    String sql=" ";
//				    				ResultSet resultSet = stmtAccMaster1.executeQuery (sql);
				    				String sql1 = "";
				    				
				    				String acc="";
				    				 sql1="select account from  " + db + ".my_head where doc_no="+docno;
				    				
				    				ResultSet resultSet12 = stmtAccMaster12.executeQuery (sql1);
				    				
				    				while (resultSet12.next()) {
				    			
				    					 acc=(resultSet12.getString("account"));	
				    					
				    			     }
				    				
				    				
				    					request.setAttribute("accountcode",acc);
				    					
				    					
				    					
				    					if (docno > 0) {
				    						 
				    						
				    						
				    						if(categorys.equalsIgnoreCase("transaction"))
				    						{
				    							Statement stmtAccMaster2 = conn.createStatement ();	
				    							
				    							String sqlsss="update  " + db + ".my_head set curid='"+crid+"',rate='"+rates+"' where  doc_no="+docno; 
				    							//System.out.println(sqlsss);
				    							stmtAccMaster2.executeUpdate(sqlsss);
				    							
				    						}
				    					}
				    					
				    				
				         }		
				       }  	  //editdocno end
				 }
			 } else {
				 		System.out.println("Else - condition");        	
					// docno=editdocno;	    
				 		System.out.println(accountcode);
				 		
				 		 String prevden = "";
			        	  String checkchangeDEN = "select den from my_head where doc_no="+docno;
			        	  System.out.println(checkchangeDEN);
			        	  ResultSet rscheckchangeDEN = stmtAccMaster1.executeQuery(checkchangeDEN);
			        	  if(rscheckchangeDEN.next()) {
			        		  prevden = rscheckchangeDEN.getString("den");
			        	  }
			        	  
			        	  if (!accountGroup.equalsIgnoreCase(prevden)) {
				              //String sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,4),(LPAD(SUBSTRING((SELECT COALESCE(MAX(account),0)+1 FROM " + db + ".my_head WHERE den=(SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ") ORDER BY m_s DESC), 5, 5), 5, '0'))) acc FROM " + db + ".my_agrp WHERE fi_id = (SELECT den FROM " + db + ".my_head WHERE doc_no=" + accountGroup + ")";
				              String sqlaccno="";
				              if(acccategory.equalsIgnoreCase("mainacc")) {
				            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT COALESCE(SUBSTRING(MAX(SUBSTRING(Account,1,4)),3,2)+1,11) FROM my_head WHERE account  LIKE CONCAT((SELECT substring(accseq,1,2) FROM  my_agrp WHERE fi_id="+accountGroup+"),'%')),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0)+1 FROM my_head WHERE doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+") ORDER BY m_s DESC), 5, 5),0), 5, '0'))) AS acc FROM my_agrp WHERE fi_id = "+accountGroup;
				              } else {
				            	  sqlaccno = "SELECT CONCAT(SUBSTRING(ACCSEQ,1,2),COALESCE((SELECT SUBSTRING(Account,3,2) FROM my_head WHERE doc_no=(SELECT if(grpno<=0,doc_no,grpno) FROM  my_head WHERE doc_no="+accountGroup+")),11),(LPAD(COALESCE(SUBSTRING((SELECT COALESCE(MAX(cast(account as unsigned)),0) FROM my_head WHERE grpno=("+accountGroup+") or doc_no=(SELECT grpno FROM my_head WHERE doc_no="+accountGroup+")), 5, 5),0)+1, 5, '0'))) acc FROM my_agrp WHERE fi_id = (SELECT den FROM my_head WHERE doc_no="+accountGroup+")";
				              }
				              
				              System.out.println(sqlaccno);
				              ResultSet rssa = stmtAccMaster1.executeQuery(sqlaccno);
				              while (rssa.next()) {
				                accountcode = rssa.getString("acc");
				              }
				            }
				
		        	   CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		        		stmtAccMaster.setDate(1,date_accountmaster);
		    			stmtAccMaster.setInt(2, docno);
		    			stmtAccMaster.setString(3,accountGroup);
		    			stmtAccMaster.setString(4,accountcode);
		    			stmtAccMaster.setString(5,accountName);
		    			stmtAccMaster.setString(6,accountgpName);
		    			stmtAccMaster.setString(7,branchone);
		    			stmtAccMaster.setString(8,branchtwo);
		    			stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
		    			stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
		    			stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
		    			stmtAccMaster.setString(12,category);
		    			stmtAccMaster.setString(13,acccategory);
		    			stmtAccMaster.setString(14,Interbranch);
		    			stmtAccMaster.setString(15,Formdetailcode);
		    			stmtAccMaster.setString(16,"E");
		    			System.out.println(stmtAccMaster);
		    			int aaa=stmtAccMaster.executeUpdate();
		    		//	System.out.println(aaa);
		    			if(aaa<0) {
		    				return 0;
		    			}
//		    			System.out.println(stmtAccMaster);
		    			// docno=stmtAccMaster.getInt("docNo");
		    			 stmtAccMaster.close();
//		    			    String sql=" ";
//		    				ResultSet resultSet = stmtAccMaster1.executeQuery (sql);
		    				String sql1 = "";
		    				
		    				String acc="";
		    				 sql1="select account from my_head where doc_no="+docno;
		    				
		    				ResultSet resultSet12 = stmtAccMaster12.executeQuery (sql1);
		    				
		    				while (resultSet12.next()) {
		    			
		    					 acc=(resultSet12.getString("account"));	
		    					
		    			     }
		    				
		    				
		    					request.setAttribute("accountcode",acc);
		    					
		    					
		    					
		    					if (docno > 0) {
		    						 
		    						
		    						
		    						if(categorys.equalsIgnoreCase("transaction"))
		    						{
		    							Statement stmtAccMaster2 = conn.createStatement ();	
		    							
		    							String sqlsss="update my_head set curid='"+crid+"',rate='"+rates+"' where  doc_no="+docno; 
		    							//System.out.println(sqlsss);
		    							stmtAccMaster2.executeUpdate(sqlsss);
		    							
		    						}
		    					}		
			 }
		 }else {
			// System.out.println("Entered in else ");
			CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtAccMaster.setDate(1,date_accountmaster);
			stmtAccMaster.setInt(2, docno);
			stmtAccMaster.setString(3,accountGroup);
			stmtAccMaster.setString(4,accountcode);
			stmtAccMaster.setString(5,accountName);
			stmtAccMaster.setString(6,accountgpName);
			stmtAccMaster.setString(7,branchone);
			stmtAccMaster.setString(8,branchtwo);
			stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
			stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
			stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
			stmtAccMaster.setString(12,category);
			stmtAccMaster.setString(13,acccategory);
			stmtAccMaster.setString(14,Interbranch);
			stmtAccMaster.setString(15,Formdetailcode);
			stmtAccMaster.setString(16,"E");
			System.out.println(stmtAccMaster);
			int aaa=stmtAccMaster.executeUpdate();
		//	System.out.println(aaa);
			if(aaa<0) {
				return 0;
			}
//			System.out.println(stmtAccMaster);
			// docno=stmtAccMaster.getInt("docNo");
			 stmtAccMaster.close();
//			    String sql=" ";
//				ResultSet resultSet = stmtAccMaster1.executeQuery (sql);
				
				String sql1 = "";
				
				String acc="";
				 sql1="select account from my_head where doc_no="+docno;
				
				ResultSet resultSet12 = stmtAccMaster12.executeQuery (sql1);
				
				while (resultSet12.next()) {
			
					 acc=(resultSet12.getString("account"));	
					
			     }
				
				
					request.setAttribute("accountcode",acc);
					
					
					
					if (docno > 0) {
						 
						
						
						if(categorys.equalsIgnoreCase("transaction"))
						{
							Statement stmtAccMaster2 = conn.createStatement ();	
							
							String sqlsss="update my_head set curid='"+crid+"',rate='"+rates+"' where  doc_no="+docno; 
//							System.out.println(sqlsss);
							stmtAccMaster2.executeUpdate(sqlsss);
							
						}
					}
					
			    }

				if (docno > 0) {
					 conn.commit();
					 stmtAccMaster12.close();
						//stmtAccMaster.close();
						conn.close();
					return 1;
				}
		}catch(Exception e){
			conn.close();	
		}
		
		return 0;
	}

	public boolean delete(int docno,int delchk, HttpSession session,String Formdetailcode,String accountcode,HttpServletRequest request) throws SQLException {
		try{
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);
			 
			 Statement stmtac = conn.createStatement();
			    
			  
			   
			    
			    String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";

			    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
			    int configmethod = 0;
			    if (rssqlconfig.next()) {
			      configmethod = rssqlconfig.getInt("method");
			    }

			    if (configmethod==1) {
			 
			    	 Statement stmtAcc = conn.createStatement();

				      Properties prop = new Properties();
					 String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
				      filePath = filePath.replace("\\", "\\\\");
				      String db = "",dbcomp="";
				      FileInputStream ip = new FileInputStream(filePath);
				      prop.load(ip);
				      String dbname = prop.getProperty("intercompdb");
				      String multicompconfig = prop.getProperty("multicompany");
				      JSONArray dbdata = new JSONArray();
				      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
				    	  Statement stmtAcc1 = conn.createStatement();
				    	  Context initCtx = new InitialContext();
				    	  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
				            int docnorow=0;
					    	docnorow=docno;
				    	  if (ds.getConnection() != null) {
				                java.sql.DatabaseMetaData metaData = conn.getMetaData();
				                String url = metaData.getURL();
				                
				                String comp = url.substring(url.lastIndexOf("/") + 1);

				 
				        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
				        ResultSet rsacc = stmtAcc.executeQuery(strsql);
				        while (rsacc.next()) {
				          db = rsacc.getString("dbname");
				          dbcomp = rsacc.getString("compname");
				          
							/*
							 * String sqlcode1=" select " + db + "  editdocno from  " + dbname +
							 * ".my_intrcmpdocno where "+comp+"="+docnorow; ResultSet rsacc11 =
							 * stmtAcc1.executeQuery(sqlcode1); int editdocno=0; while (rsacc11.next()) {
							 * editdocno=rsacc11.getInt("editdocno");
							 * 
							 * }
							 */	
							
				          if (! (db.equalsIgnoreCase(""))) {
						    	
								/* docno=editdocno; */
				        		  
				        	  Statement stmtAccMaster16 = conn.createStatement ();
								{
								String sql="select grpno from " + db + ".my_head ";
									
								ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
								while (resultSet.next()) {
									 int data = (resultSet.getInt("grpno"));
									 if(docno==data)
									 {
											
										 return false;
									 }
									}
							     }
									if(delchk==3)
									{
									String sql="select acno from " + db + ".my_jvtran where acno="+docno+" ";
									ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
									while (resultSet.next()) {
										 int data = (resultSet.getInt("acno"));
										 if(docno==data)
										 {
												
											 return false;
										 }
										}
					
									}
							CallableStatement stmtAccMaster = conn.prepareCall("{CALL " + db + ".accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
							stmtAccMaster.setDate(1,null);
							stmtAccMaster.setInt(2, docno);
							stmtAccMaster.setString(3,null);
							stmtAccMaster.setString(4,null);
							stmtAccMaster.setString(5,null);
							stmtAccMaster.setString(6,null);
							stmtAccMaster.setString(7,null);
							stmtAccMaster.setString(8,null);
							stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
							stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
							stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
							stmtAccMaster.setString(12,null);
							stmtAccMaster.setString(13,null);
							stmtAccMaster.setString(14,null);
							stmtAccMaster.setString(15,Formdetailcode);
							stmtAccMaster.setString(16,"D");
							int aaa=stmtAccMaster.executeUpdate();
							if(aaa<0) {
								return false;
							}
							// docno=stmtAccMaster.getInt("docNo");
							 stmtAccMaster.close();
							//brandBean.setDocno(aaa);
			 
				          }
				        }
				      }
			       } else {
						/* docno=editdocno; */
		        		  
			        	  Statement stmtAccMaster16 = conn.createStatement ();
							{
							String sql="select grpno from my_head ";
								
							ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
							while (resultSet.next()) {
								 int data = (resultSet.getInt("grpno"));
								 if(docno==data)
								 {
										
									 return false;
								 }
								}
						     }
								if(delchk==3)
								{
								String sql="select acno from my_jvtran where acno="+docno+" ";
								ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
								while (resultSet.next()) {
									 int data = (resultSet.getInt("acno"));
									 if(docno==data)
									 {
											
										 return false;
									 }
									}
				
								}
						CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtAccMaster.setDate(1,null);
						stmtAccMaster.setInt(2, docno);
						stmtAccMaster.setString(3,null);
						stmtAccMaster.setString(4,null);
						stmtAccMaster.setString(5,null);
						stmtAccMaster.setString(6,null);
						stmtAccMaster.setString(7,null);
						stmtAccMaster.setString(8,null);
						stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
						stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
						stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
						stmtAccMaster.setString(12,null);
						stmtAccMaster.setString(13,null);
						stmtAccMaster.setString(14,null);
						stmtAccMaster.setString(15,Formdetailcode);
						stmtAccMaster.setString(16,"D");
						int aaa=stmtAccMaster.executeUpdate();
						if(aaa<0) {
							return false;
						}
						// docno=stmtAccMaster.getInt("docNo");
						 stmtAccMaster.close();
						//brandBean.setDocno(aaa);
		 
			          
			       }
			    }
				          else{
				        	  Statement stmtAccMaster16 = conn.createStatement ();
				         
							if(delchk==1||delchk==2)
							{
							String sql="select grpno from my_head ";
							ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
							while (resultSet.next()) {
								 int data = (resultSet.getInt("grpno"));
								 if(docno==data)
								 {
									 return false;
								 }
								}
						     }
								if(delchk==3)
								{
								String sql="select acno from my_jvtran where acno="+docno+" ";
								ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
								while (resultSet.next()) {
									 int data = (resultSet.getInt("acno"));
									 if(docno==data)
									 {
										 return false;
									 }
									}
				
								}
						CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtAccMaster.setDate(1,null);
						stmtAccMaster.setInt(2, docno);
						stmtAccMaster.setString(3,null);
						stmtAccMaster.setString(4,null);
						stmtAccMaster.setString(5,null);
						stmtAccMaster.setString(6,null);
						stmtAccMaster.setString(7,null);
						stmtAccMaster.setString(8,null);
						stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
						stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
						stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
						stmtAccMaster.setString(12,null);
						stmtAccMaster.setString(13,null);
						stmtAccMaster.setString(14,null);
						stmtAccMaster.setString(15,Formdetailcode);
						stmtAccMaster.setString(16,"D");
						int aaa=stmtAccMaster.executeUpdate();
						if(aaa<0) {
							return false;
						}
						// docno=stmtAccMaster.getInt("docNo");
						 stmtAccMaster.close();
						//brandBean.setDocno(aaa);
				          }
						if (docno > 0) {
							 conn.commit();
								//stmtAccMaster.close();
								conn.close();
							//System.out.println("Sucess");
							return true;
						}	
					}catch(Exception e){
						conn.close();
					}						
				//System.out.println("not deleted");
				return false;
						
			         	
				}
		
	
	public   JSONArray searchDetails() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn = null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement (); 

			 String sql="select h.rate,h.curid,r.code curr, h.Description,h.den,h.doc_no docno,h.date,h.account,if(h.m_s=1,'M','D')as md,h.m_s,h.alevel,h.grpno,a.FI_ID,"
			 		+ "a.head,b.br1,b.br2,b.doc_no from my_head as h inner join  my_agrp as a on (FI_ID=den) left join my_intr as b on  h.doc_no=b.doc_no"
			 		+ " left join my_curr r on r.doc_no=h.curid where h.dtype='GEN' ";
//System.out.println(sql);
			 ResultSet resultSet = stmtAC.executeQuery (sql);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);

			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			 conn.close();
			 e.printStackTrace();
		 }

		 return RESULTDATA;
  
}
	
	
	

/*	public  List<ClsAccMasterBean> list() throws SQLException {
		List<ClsAccMasterBean> listBean = new ArrayList<ClsAccMasterBean>();
		
		try {
			
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtaccMaster = conn.createStatement ();
		    	String sql="select h.Description,h.den,h.doc_no docno,h.date,h.account,if(h.m_s=1,'M','D')as md,h.m_s,h.alevel,h.grpno,a.FI_ID,a.head,b.br1,b.br2,b.doc_no from my_head as h inner join  my_agrp as a on (FI_ID=den) left join my_intr as b on  h.doc_no=b.doc_no ";
		    	
		    	ResultSet resultSet = stmtaccMaster.executeQuery (sql);
			
				while (resultSet.next()) {
					
					ClsAccMasterBean bean = new ClsAccMasterBean();
		        	bean.setDocno(resultSet.getInt("docno"));
		        	bean.setMd(resultSet.getString("md"));
					bean.setDate(resultSet.getString("date"));
					bean.setDescription(resultSet.getString("description"));
					bean.setHead(resultSet.getString("head"));
					bean.setAccount(resultSet.getString("account"));
					bean.setM_s(resultSet.getString("m_s"));
					bean.setAlevel(resultSet.getString("alevel"));
					bean.setGrpno(resultSet.getString("grpno"));
					bean.setBrchone(resultSet.getString("br1"));
					bean.setBrchtwo(resultSet.getString("br2"));
					bean.setDen(resultSet.getString("den"));
					listBean.add(bean);
			
				
				}
				stmtaccMaster.close();
				conn.close();
		}
		
		catch(Exception e){
			e.printStackTrace();
		}

		return listBean;
		}*/

	 public   JSONArray getChartOfAC(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement ();
if(chk.equalsIgnoreCase("load"))
{
			 String sqlnew="select (select  description from my_head where doc_no=m.grpNo) group_name,m.grpNo,m.description,m.account,d.gp_id,p.fi_id,m.alevel,m.m_s,p.head,d.gp_desc "
			 		+ " from my_head m inner join my_agrp p on m.den=p.fi_id "
			 		+ "inner join gc_agrpd d on d.gp_id= p.gp_pr  and d.gtype='D'  where  m_s=0  "
			 		+ "order by  d.gp_id,p.fi_id,m.alevel ";
//System.out.println("----sqlnew---"+sqlnew);
			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);
}
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
	 
	 
	 public   JSONArray getcurr() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement ();
 			 String sqlnew="select c1.code,c1.doc_no,b2.rate from my_curr c1 left join (select(max(doc_no)) docno,curid from my_curbook where curdate() between frmdate and coalesce(todate,curdate()) group by curid) b1 on b1.curid=c1.doc_no left join my_curbook b2 on b2.doc_no=b1.docno where c1.status=3;";
//System.out.println("----sqlnew---"+sqlnew);
			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);
 
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
	 
	 
	
	 public   JSONArray getChartOfACExcel(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 
	//	 System.out.println("-----------------");
		 
		 try {
			 
			  conn = connDAO.getMyConnection();
			  Statement stmtAC = conn.createStatement ();
			  if(chk.equalsIgnoreCase("load"))
			  {
				 
			 

			 String sqlnew="select d.gp_desc 'Group Name',p.head 'Group Head',(select  description from my_head where doc_no=m.grpNo) 'Main Head',m.account 'Account',m.description 'Description' "
			 		+ " from my_head m inner join my_agrp p on m.den=p.fi_id "
			 		+ "inner join gc_agrpd d on d.gp_id= p.gp_pr  and d.gtype='D'  where  m_s=0  "
			 		+ "order by  d.gp_id,p.fi_id,m.alevel ";

			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToEXCEL(resultSet);
			  }
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
}

