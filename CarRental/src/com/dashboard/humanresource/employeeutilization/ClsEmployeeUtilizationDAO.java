package com.dashboard.humanresource.employeeutilization;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeUtilizationDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray GridLoading(String year, String month, String employee, String check) throws SQLException {
			
			JSONArray RESULTDATA=new JSONArray();
			
			if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
			
		    Connection conn=null;
		
		    try {
		    	    conn = ClsConnection.getMyConnection();
			        Statement stmtBTSR = conn.createStatement();
				
			        java.sql.Date sqlDate=null;
		    	    
			     
			        
			        String sql = "",sql1="",sql2="",sql3="",sql4="",sql5="";
					
		    	   
		    	    if(!(employee.equalsIgnoreCase("0")) && !(employee.equalsIgnoreCase(""))){
			            sql4=sql4+" and empid='"+employee+"'";
			        }
		    	    
		    	    String sqld="select db1,db2 from my_comp";
					
					ResultSet rs = stmtBTSR.executeQuery(sqld);
					
					String db1="";
					String db2="";
					while(rs.next()) {
						db1=rs.getString("db1");
						db2=rs.getString("db2");
				  	}
		    	    
		    	   
		    	    	sql ="select (22*8) as mnthlytargethrs ,sum(totdays) tot,if((22*8) -sum(totdays)>0,(22*8) -sum(totdays),0) nonbillhrs, round((sum(totdays)/(22*8)) * 100,2) per, empid , empname from "
		    	    			+ "(select empId,h.name empname,totdays from "+db1+".hr_workdetails d left join "+db1+".hr_empm h on d.empId=h.doc_no  where year="+year+" and month="+month+" "+sql4+" union all "
		    	    			+ "select  empId,h.name empname,totdays from "+db2+".hr_workdetails d left join "+db2+".hr_empm h on d.empId=h.doc_no where year="+year+" and month="+month+" "+sql4+" ) a group by empid ";
		       	    	/*CONVERT(if(round((m.normal-m.ot-m.hot)*60,2)=0,' ',if(LENGTH(SEC_TO_TIME((m.normal-m.ot-m.hot)*60))=8,SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,5),SUBSTRING(SEC_TO_TIME((m.normal-m.ot-m.hot)*60),1,6))),CHAR(100))
		    	    	 * */
	    	    	System.out.println(" === 2 ==== "+sql);
		    	   
					
					ResultSet resultSet = stmtBTSR.executeQuery(sql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtBTSR.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
		    return RESULTDATA;
		}

	
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String category) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBTSR = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase("")||empid.equalsIgnoreCase("0"))){
	                sql=sql+" and m.codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase("")||employeename.equalsIgnoreCase("0"))){
	             sql=sql+" and m.name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase("")||contact.equalsIgnoreCase("0"))){
	                sql=sql+" and m.pmmob like '%"+contact+"%'";
	            }
	            if(!(category.equalsIgnoreCase("")|| category.equalsIgnoreCase("0"))){
	                sql=sql+" and m.pay_catid = '"+category+"'";
	            }
	            
				sql = "select m.doc_no,m.codeno,UPPER(m.name) name,m.pmmob from hr_empm m left join hr_setpaycat c on (m.pay_catid=c.doc_no and c.status=3) where m.active=1 and m.status=3 "+sql;
				System.out.println("sql+++++++++++++++"+sql);
				ResultSet resultSet = stmtBTSR.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBTSR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA;
	}

	
	
}
