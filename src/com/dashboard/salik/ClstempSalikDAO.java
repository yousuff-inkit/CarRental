package com.dashboard.salik;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClstempSalikDAO {

	ClsConnection ClsConnection=new ClsConnection();
	
	ClsCommon ClsCommon=new ClsCommon();
	public  JSONArray unallocation1(String update,String tagno,String regno,String aa,String fromdate,String hidchkdate,String saliktype) throws SQLException {
//		System.out.println("--------IN---------");
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
    	try {   
    	java.sql.Date sqlfromdate = null;	
        java.sql.Date sqluptodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     	}
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     	
    	String sqltest="";
    	if(hidchkdate.equals("1")) {
     		sqltest=sqltest+" and sal_date>='"+sqlfromdate+"' ";
     	}
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(tagno)='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(regno)='"+regno+"' ";
    	}
    	if(!saliktype.trim().equalsIgnoreCase("")){
    		sqltest=sqltest+" and type='"+saliktype+"' ";
    	}
       
	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				if(aa.equalsIgnoreCase("2"))
				{
//					System.out.println("--------aa--------"+aa);
				 String sql="select CASE WHEN type='SAL' THEN 'Salik' WHEN type='PAR' THEN 'Parking' ELSE '' END type,regno,tagno,salik_date,  salik_time,  fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=0 and status in (0,3) and sal_date<='"+sqluptodate+"'   " +sqltest;
        //System.out.println("---------2---------"+sql);
            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray allocationlist1(String update,String tagno,String regno,String bb,String fromdate,String hidchkdate,String saliktype) throws SQLException {
//		System.out.println("--------IN---2------");
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
        
		try {
	    java.sql.Date sqlfromdate = null;
        java.sql.Date sqluptodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     	}
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     	String sqltest="";
     	
     	if(hidchkdate.equals("1")) {
     		sqltest=sqltest+" and s.sal_date>='"+sqlfromdate+"' ";
     	}
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(s.tagno)='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(s.regno)='"+regno+"' ";
    	}
    	if(!saliktype.trim().equalsIgnoreCase("")){
    		sqltest=sqltest+" and type='"+saliktype+"' ";
    	}
    	
     	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement();

				/* String sql="select regno,tagno,salik_date,fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=1 and sal_date<='"+sqluptodate+"' "+sqltest;*/
				 
				 if(bb.equalsIgnoreCase("10"))
				 {
//					 System.out.println("--------bb--------"+bb);
				 String sql="select  CASE WHEN s.type='SAL' THEN 'Salik' WHEN s.type='PAR' THEN 'Parking' ELSE '' END type,s.regno,s.tagno,s.salik_date,  s.salik_time,  s.fleetno,s.trans,round(s.AMOUNT,2) AMOUNT, "
				 		+ " if(s.reason is null,'',reason) reason, convert(case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
				 		+ "s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end,char(30)) as 'rano',convert(coalesce(s.branch,''),char(30)) branch  "
				 		+ " from gl_salik s	 left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))   "
				 		+ " left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) where s.ISALLOCATED=1 "
				 		+ " and s.sal_date<='"+sqluptodate+"'  "+sqltest;
				 
				//System.out.println("1====>"+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				 }
            	stmtVeh.close();
 				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
public  JSONArray unallocation1Excel(String update,String tagno,String regno,String aa,String fromdate,String hidchkdate,String saliktype) throws SQLException {
//		System.out.println("--------IN---------");
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
    	try {    
    	java.sql.Date sqlfromdate = null;
        java.sql.Date sqluptodate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(update);
     	}
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
    	String sqltest="";
    	if(hidchkdate.equals("1")) {
     		sqltest=sqltest+" and sal_date>='"+sqlfromdate+"'";
     	}
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(tagno)='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and trim(regno)='"+regno+"' ";
    	}
    	if(!saliktype.trim().equalsIgnoreCase("")){
    		sqltest=sqltest+" and type='"+saliktype+"' ";
    	}
       
	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				if(aa.equalsIgnoreCase("2"))
				{
//					System.out.println("--------aa--------"+aa);
				 String sql="select CASE WHEN type='SAL' THEN 'Salik' WHEN type='PAR' THEN 'Parking' ELSE '' END type,trans 'Transaction',tagno 'Tag NO',regno 'Reg NO',DATE_FORMAT(salik_date,'%d-%m-%Y') 'Salik Date',  salik_time 'Salik Time',  "
				 		+ "fleetno 'Fleet',round(AMOUNT,2) 'Amount',convert(coalesce(ra_no,' '),char(30)) 'RA No',"
				 		+ "convert(coalesce(branch,''),char(30)) 'Branch',if(reason is null,'',reason) 'Reason' "
				 		+ "from gl_salik where ISALLOCATED=0 and status in (0,3) and sal_date<='"+sqluptodate+"' "+sqltest+"";
        //  System.out.println("--------excel----------"+sql);
            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				}
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
        return RESULTDATA;
    }

	
}
