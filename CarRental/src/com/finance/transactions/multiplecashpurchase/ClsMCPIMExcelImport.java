package com.finance.transactions.multiplecashpurchase;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMCPIMExcelImport {

	  

	public int ExcelImport(String docNo) throws SQLException {  
     	ClsConnection connDAO = new ClsConnection();
 	    Connection conn = null;
 		ClsCommon com=new ClsCommon();
     try{
     	conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			Date sqlDODate = null ;
			String path="";   
			String line = "";
	        String cvsSplitBy = ",";
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='MCPIM'"; 
			System.out.println(strSql);
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			System.out.println("Path - "+path);
			
			 String sql5="truncate my_mcpexcel";     
			 //System.out.println("sql5--->>>"+sql5);    
	         stmt.executeUpdate(sql5);   
			
			BufferedReader br = new BufferedReader(new FileReader(path));
			System.out.println(br);
			int i=0;
			
            while ((line = br.readLine()) != null) {
            	if(i>0) {
            		
	                // use comma as separator
	                String[] journal = line.split(cvsSplitBy);
	                System.out.println(journal[3]);
					/*
					 * if(journal[3]!=null){ SimpleDateFormat format2 = new
					 * SimpleDateFormat("dd-MM-yyyy"); String dodatestr =
					 * format2.format(journal[3]); System.out.println(dodatestr);
					 * sqlDODate=com.changeStringtoSqlDate2(dodatestr); }
					 */
	                String vendor = journal[0].equalsIgnoreCase("")?"0":journal[0];
	                String vendorid = journal[1].equalsIgnoreCase("")?"0":journal[1];
	                
	                String costType = "0";
	                if(journal[10].trim().length()>0) {
	                	String sqle = "SELECT costtype FROM my_costunit WHERE Costgroup LIKE ('"+journal[10].trim()+"') LIMIT 1";
	                	ResultSet executeQuery = stmt.executeQuery(sqle);
	                	
	                	if(executeQuery.next()) {
	                		costType = executeQuery.getString("costtype");
	                	}
	                }
	                
	                
	                if((journal[5].equalsIgnoreCase("0") || journal[5].equalsIgnoreCase("")) || (journal[12].equalsIgnoreCase("0") || journal[12].equalsIgnoreCase("")) || (journal[13].equalsIgnoreCase("0") || journal[13].equalsIgnoreCase(""))){
	                	stmt.close();
	                    conn.close();
	                    return 99;
	                }
	                if(!(journal[7].equalsIgnoreCase("0") || journal[7].equalsIgnoreCase("")) || !(journal[13].equalsIgnoreCase("0") || journal[13].equalsIgnoreCase("")) || !(journal[14].equalsIgnoreCase("0") || journal[14].equalsIgnoreCase(""))){           
	                	String sql ="INSERT INTO my_mcpexcel(vendor, vendorid, invno, invdate, type, account, accountname, currency, rate, costtype, costcode, qty, unitprice, amount, taxper, taxamt, tot, description,currencyid) VALUES("+vendor+","+vendorid+","+journal[2]+",'"+journal[3]+"','"+journal[4]+"',"+journal[5]+",'"+journal[6]+"','"+journal[8]+"',"+journal[9]+","+costType+","+journal[11]+","+journal[12]+","+journal[13]+","+journal[14]+","+journal[15]+","+journal[16]+","+journal[17]+",'"+journal[18]+"',"+journal[7]+")";
	                    System.out.println(sql);
	                	int val=stmt.executeUpdate(sql);                                
	                }
	            }
            	i++;
            }
         conn.commit();	
         stmt.close();
         conn.close();
     }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
     return 1;
	}
}
