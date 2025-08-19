package com.dashboard.operations.riderinvoiceprep;



import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRiderInvoiceImportDAO {
    
    ClsConnection ClsConnection = new ClsConnection();
    ClsCommon ClsCommon = new ClsCommon();
    public JSONArray getGridDataExcel(String docNo,String brch,String id,String year,String month) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;
        if (!(id.equalsIgnoreCase("1"))) {
            return RESULTDATA;
        }

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "select * from my_rip where year="+year+" and month="+month+" and brchid='"+brch+"'";
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            System.out.println(RESULTDATA);
            stmt.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray getSummaryData(String brch,String id,String year,String month) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;
        if (!(id.equalsIgnoreCase("1"))) {
            return RESULTDATA;
        }

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            
            String sql="";
            String gridLoadSql = "select * from gl_summary where status=1 order by seqno";
            ResultSet rs = stmt.executeQuery(gridLoadSql);
            
            while(rs.next()) {
            	if(!sql.equalsIgnoreCase("")) {
            		sql+=" union all ";
            	}
            	sql+="SELECT "+rs.getString("id")+" id,"+rs.getString("vatper")+" vatper, "+rs.getString("vat")+" isvat ,'"+rs.getString("description")+"' description,ROUND(SUM("+rs.getString("columnname")+"),2)*"+rs.getString("id")+" grossamount,if("+rs.getString("vat")+"=1,ROUND(SUM("+rs.getString("columnname")+")*"+rs.getString("vatper")+"/100,2),0)*"+rs.getString("id")+" vat,ROUND(SUM("+rs.getString("columnname")+")+if("+rs.getString("vat")+"=1,SUM("+rs.getString("columnname")+")*"+rs.getString("vatper")+"/100,0),2)*"+rs.getString("id")+" netamount  FROM my_rip WHERE MONTH="+month+" AND YEAR="+year+" and brchid="+brch;
            }
            
            //String sql = "SELECT 'Distance Pay' description,ROUND(SUM(distancepay),2) grossamount,ROUND(SUM(distancepay)*0.05,2) vat,ROUND(SUM(distancepay)+SUM(distancepay)*0.05,2) netamount  FROM my_rip WHERE MONTH="+month+" AND YEAR="+year+" and brchid="+brch;
           // System.out.println("gridexcel data--------"+sql);
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            System.out.println(RESULTDATA);
            stmt.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }

}
