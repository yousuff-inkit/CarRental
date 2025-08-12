package com.dashboard.trafficfine.satdaily;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSatDailyReport  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray getSATUsername(String satcategory,String id,String saliksource)throws SQLException{
		System.out.println("Username Parameters:"+satcategory+"::"+id+"::"+saliksource);
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=ClsConnection.getMyConnection();
			String strsql="";
			if(satcategory.trim().equalsIgnoreCase("Salik")) {
				String sqltest="";
				if(saliksource.trim().equalsIgnoreCase("DXB")) {
					sqltest+=" and site='DXB'";
				}
				else if(saliksource.trim().equalsIgnoreCase("AUH")) {
					sqltest+=" and site='AUH'";
				}
				strsql="select username from gl_webid where type='U'"+sqltest;
			}
			else if(satcategory.trim().equalsIgnoreCase("Traffic")) {
				strsql="select tcno as username from gl_webid where type='F'";
			}
			//System.out.println("Username SQL:"+strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray satDailyReportGridLoading(String fromdate,String todate,String satcatg,String datefilter,String check,String saliksource,String username) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			java.sql.Date edate=ClsCommon.changeStringtoSqlDate(todate);
			//System.out.println("sdate==>"+sdate);
			//System.out.println("edate==>"+edate);
			String sql="";
			
			if(satcatg.equalsIgnoreCase("salik")){
				if(!username.trim().equalsIgnoreCase("") && !username.trim().equalsIgnoreCase("0")) {
					sql+=" and ltrim(rtrim(salik_user))='"+username+"'";
				}
				if(saliksource.trim().equalsIgnoreCase("DXB")) {
					sql+=" and ltrim(rtrim(source))<>'AUH'";
				}
				if(saliksource.trim().equalsIgnoreCase("AUH")) {
					sql+=" and ltrim(rtrim(source))='AUH'";
				}
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				String sql1="Select CASE WHEN type='SAL' THEN 'Salik' WHEN type='PAR' THEN 'Parking' ELSE '' END type,Salik_User username,trans,DATE_FORMAT(salik_date,'%d.%m.%Y') salik_date,salik_time,DATE_FORMAT(sal_date,'%d.%m.%Y') sal_date,regno,source,tagno,location,direction,amount,DATE_FORMAT((coalesce(autodate,date)),'%d.%m.%Y %H:%m:%s') date from gl_salik where 1=1"+sql+"";
				resultSet= stmt.executeQuery (sql1);
				//System.out.println("gridsql1===>"+sql1); 
			}
			if(satcatg.equalsIgnoreCase("traffic")){
				if(!username.trim().equalsIgnoreCase("") && !username.trim().equalsIgnoreCase("0")) {
					sql+=" and ltrim(rtrim(t.tcno))='"+username+"'";
				}
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(t.traffic_date,t.date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(t.traffic_date,t.date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(t.autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(t.autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				
				String sql2="Select t.blackpoints,t.tcno,t.ticket_no,DATE_FORMAT(t.traffic_date,'%d.%m.%Y') traffic_date,t.time,t.fine_source,t.amount,t.regno,coalesce(v.CODE_NAME,t.pcolor) pcolor,t.licence_no,t.licence_from,t.tick_violat,t.tick_location,DATE_FORMAT((coalesce(t.autodate,t.date)),'%d.%m.%Y %H:%m:%s') date,t.desc1  from gl_traffic t left join gl_vehplate v on t.pcolor=v.doc_no where 1=1"+sql+"";
				resultSet= stmt.executeQuery (sql2);
				//System.out.println("gridsql2===>"+sql2); 
			}
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	/*
	 * public JSONArray satDailyReportExcelExport(String fromdate,String
	 * todate,String satcatg,String datefilter,String check) throws SQLException {
	 * 
	 * JSONArray RESULTDATA=new JSONArray();
	 * 
	 * if(!(check.equalsIgnoreCase("1"))){ return RESULTDATA; }
	 * 
	 * Connection conn = null; Statement stmt =null; ResultSet resultSet=null; try {
	 * 
	 * conn = ClsConnection.getMyConnection(); stmt = conn.createStatement ();
	 * 
	 * java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate); java.sql.Date
	 * edate=ClsCommon.changeStringtoSqlDate(todate);
	 * 
	 * String sql="";
	 * 
	 * if(satcatg.equalsIgnoreCase("salik")){
	 * 
	 * if(datefilter.equalsIgnoreCase("1")) {
	 * sql+=" and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"
	 * +edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+
	 * "'"; } else if(datefilter.equalsIgnoreCase("2")) {
	 * sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"
	 * +edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'"; }
	 * 
	 * resultSet= stmt.executeQuery
	 * ("Select trans 'Transaction',Salik_User 'User Name',DATE_FORMAT((coalesce(autodate,date)),'%d-%m-%Y %H:%m:%s') 'Downloaded Date',salik_date 'Trip Date',salik_time 'Trip Time',sal_date 'Post Date',regno 'Plate',source 'Source',tagno 'Tag',location 'Location',direction 'Direction',amount 'Amount' from gl_salik where 1=1"
	 * +sql+""); } if(satcatg.equalsIgnoreCase("traffic")){
	 * 
	 * if(datefilter.equalsIgnoreCase("1")) {
	 * sql+=" and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')<='"
	 * +edate+"' and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')>='"+sdate
	 * +"'"; } else if(datefilter.equalsIgnoreCase("2")) {
	 * sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"
	 * +edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'"; }
	 * 
	 * String
	 * sql2="Select tcno 'TcNo',DATE_FORMAT((coalesce(autodate,date)),'%d-%m-%Y %H:%m:%s') 'Downloaded Date',ticket_no 'Fine No',traffic_date 'Traffic Date',time as 'Time',fine_source 'Fine Source',amount 'Fees',regno 'Plate No',Pcolor 'Plate Category',desc1 'Description'  from gl_traffic where 1=1"
	 * +sql+""; resultSet= stmt.executeQuery (sql2); }
	 * 
	 * RESULTDATA=ClsCommon.convertToEXCEL(resultSet); } catch(Exception e){
	 * e.printStackTrace(); } finally{ stmt.close(); conn.close(); } return
	 * RESULTDATA; }
	 */
	
	@SuppressWarnings("resource")
	public JSONArray satDailyReportCountGridLoading(String fromdate,String todate,String satcatg,String datefilter,String check, String userName,String saliksource) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;   
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			String sql = "",sqltest = "";
			java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			java.sql.Date edate=ClsCommon.changeStringtoSqlDate(todate);
			
			 if(satcatg.equalsIgnoreCase("traffic")){
			     if(!userName.trim().equalsIgnoreCase("")) {
	                    sql+=" and ltrim(rtrim(tcno))='"+userName+"'";
	                }
				 if(datefilter.equalsIgnoreCase("1")) {
					 sqltest="select DATE_FORMAT((coalesce(traffic_date,date)),'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT((coalesce(traffic_date,date)),'%d.%m.%Y') hiddate from gl_traffic where DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')>='"+sdate+"' "+sql+" group by coalesce(date(traffic_date),date)";				 
					 resultSet= stmt.executeQuery (sqltest);
				 } else if(datefilter.equalsIgnoreCase("2")) {
					 sqltest="select DATE_FORMAT(autodate,'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT(autodate,'%d.%m.%Y') hiddate from gl_traffic where DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"' "+sql+" group by DATE_FORMAT(autodate,'%Y-%m-%d')";				 
					 resultSet= stmt.executeQuery (sqltest);
				 }
			}
			 //System.out.println("countsql1==="+sqltest); 
			 if(satcatg.equalsIgnoreCase("salik")){
			     if(!userName.trim().equalsIgnoreCase("")) {
	                    sql+=" and ltrim(rtrim(salik_user))='"+userName+"'";
	                }
			     if(saliksource.trim().equalsIgnoreCase("DXB")) {
						sql+=" and ltrim(rtrim(source))<>'AUH'";
					}
					if(saliksource.trim().equalsIgnoreCase("AUH")) {
						sql+=" and ltrim(rtrim(source))='AUH'";
					}
				 if(datefilter.equalsIgnoreCase("1")) {
					 sqltest="select DATE_FORMAT((coalesce(salik_date,date)),'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT((coalesce(salik_date,date)),'%d.%m.%Y') hiddate from gl_salik where DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+"' "+sql+" group by coalesce(date(salik_date),date)";
					resultSet= stmt.executeQuery (sqltest);
				 } else if(datefilter.equalsIgnoreCase("2")) {
					 sqltest="select DATE_FORMAT(autodate,'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT(autodate,'%d.%m.%Y') hiddate from gl_salik where DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"' "+sql+" group by DATE_FORMAT(autodate,'%Y-%m-%d')";
					 resultSet= stmt.executeQuery (sqltest);
					 
				 }
			}
			// System.out.println("countsql2==="+sqltest);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	
}
