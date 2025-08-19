package com.dashboard.humanresource.payrollanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPayrollAnalysisDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cmn=new ClsCommon();
    public JSONArray loadGrid(String id,String month,String year,String employee) throws SQLException{
    	JSONArray jsarray = new JSONArray();
    	if(!id.equals("1")){
    	
    		return jsarray;
    	}
    	Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
				
			if(!year.equals("") && !year.equalsIgnoreCase("0")){
				sqltest+=" AND YEAR(p.DATE)="+year+"";
			}
				
		    if(!month.equals("") && !month.equalsIgnoreCase("0")){
					sqltest+=" AND MONTH(p.DATE)="+month+"";
			}
			
		    if(!employee.equals("") && !employee.equalsIgnoreCase("0")){
				sqltest+=" AND d.empid="+employee+"";
		    }
		    
		    String sqldata="select DATE_FORMAT(p.date,'%b %Y') dates,d.daystopay,round(d.earnedbasic,0) basicsalary,round(d.earnedtotalsalary-d.earnedbasic,0) totalsalary,round(d.overtime,0) overtime,"
		    		+ " round(d.grosssalary,0) grosssalary,round(d.additions,0) additions,round(d.deductions,0) deductions,round(d.loan,0) loan,round(d.netsalary,0) netsalary,d.remarks,d.rdocno, d.empId"
		    		+ " employeedocno,m.codeno employeeid,m.name employeename,m.pay_catid empcatid,d.posted, d.salary_payment paid from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on  d.empid=m.doc_no"
		    		+ " left join hr_timesheet t on (t.year= YEAR(p.DATE)  and  t.month=MONTH(p.DATE) and t.empid=d.empid) where p.status=3 and d.status=3 and t.payroll_processed=1 "
		    		+ "  "+sqltest+"";  // and d.posted=0
		    System.out.println(sqldata);  
			resultSet= stmt.executeQuery (sqldata);
			jsarray=cmn.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
    	return jsarray;
    }
}
