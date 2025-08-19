package com.dashboard.analysis.pivotform;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPivotFormDAO {
    
    ClsConnection ClsConnection=new ClsConnection();
    private ClsCommon ClsCommon = new ClsCommon();
    
    public  JSONArray loadGridData(HttpSession session,String fromdate,String todate, String formname) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();  

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sqlfromdate = null;
	        
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	        {
	            sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	        } else {
	        }

	        java.sql.Date sqltodate = null;
	        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	        {
	            sqltodate=ClsCommon.changeStringtoSqlDate(todate);    
	        } else {
	        }
	        
	        String sqldata = "";
	        String sqlselect = "SELECT query FROM gl_pivotm WHERE dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"')"; 					 
	        ResultSet rs =	stmt.executeQuery (sqlselect);	
	        while(rs.next()) {
	        	sqldata =rs.getString("query").replaceAll("sqlfromdate", sqlfromdate+"").replaceAll("sqltodate",sqltodate+"");
	        }
	        //System.out.println("=Pivot Grid--->>>"+sqldata);  
	        if(!sqldata.equals("")) {
	        	resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        }
			//System.out.println("=====RESULTDATA"+RESULTDATA);
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