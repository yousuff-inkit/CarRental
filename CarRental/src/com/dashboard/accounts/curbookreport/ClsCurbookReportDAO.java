package com.dashboard.accounts.curbookreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCurbookReportDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	
	public JSONArray curDetails(String chk,String fromdate,String todate,String currid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
       
        if(!(chk.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        String sqltest="";

		if(!(currid.equalsIgnoreCase("") || currid.equalsIgnoreCase("NA"))){
			sqltest=sqltest+" and cb.curid ='"+currid+"'";
		}
		
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				
				int curdec=2;
				String cursqlDecimal="select cvalue value from my_system where codeno='curdec';";
			    //System.out.println("cursqlDecimal:"+cursqlDecimal);

				ResultSet currsDecimal=stmtVeh.executeQuery(cursqlDecimal);
				if(currsDecimal.next())
				{
					curdec=currsDecimal.getInt("value");
				}
			   
				
				
				
            		String sql="select cb.doc_no docno,cb.curid currid,cr.code curr,cr.c_name currname,cb.frmdate frmdate,cb.todate todate,round(cb.rate,"+curdec+") rate from my_curbook cb "
            				 + "left join my_curr cr on cr.doc_no=cb.curid where cb.frmdate between '"+sqlFromDate+"' and  '"+sqlToDate+"' "+sqltest+" order by cb.frmdate ";
            		//System.out.println("-----------Grid Load-----------"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

}
