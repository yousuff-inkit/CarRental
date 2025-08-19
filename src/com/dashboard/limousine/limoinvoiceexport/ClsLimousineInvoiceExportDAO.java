package com.dashboard.limousine.limoinvoiceexport;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;

public class ClsLimousineInvoiceExportDAO {
	ClsConnection ClsConnection = new ClsConnection();
    ClsCommon ClsCommon = new ClsCommon();
    
    public JSONArray getGridData(String id,String fromDate,String toDate) throws SQLException {
    	System.out.println(fromDate+" - "+toDate);
    	JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;
        if (!(id.equalsIgnoreCase("1"))) {
            return RESULTDATA;
        }

        try {
        	conn = ClsConnection.getMyConnection();
        	
        	java.sql.Date sqltodate = null;
        	java.sql.Date sqlfromdate = null;
            
         	if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
         		sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
         	}
        	
         	if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
         		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
         	}
         	
         	String cardb="";
         	String join ="";
         	String jcolumn ="";
        	String getDBSQL = "SELECT COALESCE(carrental_db,'') db FROM my_comp WHERE STATUS=3";
        	PreparedStatement stmts= conn.prepareStatement(getDBSQL);
        	ResultSet rsgetDBSQL = stmts.executeQuery();
        	if(rsgetDBSQL.next()){
        		cardb = rsgetDBSQL.getString("db");
        		join = "left join "+cardb+"."+"gl_limoinvm mc on m.doc_no=mc.limoinvdocno and m.voc_no=mc.limoinvvocno";
        		jcolumn = "coalesce(mc.limoinvdocno,0) invdocno,";
        	}
         	
        	
            String sql = "SELECT "+jcolumn+"m.doc_no, m.voc_no,m.brhid,m.trno,m.date,m.ledgernote,m.invoicenote,d.jobname,d.total,d.discount,d.nettotal,d.tarif,d.nighttarif,d.exkmchg,d.exhrchg,d.exnighthrchg,d.fuelchg,d.parkingchg,d.otherchg,d.greetchg,d.vipchg,d.boquechg,d.exkm,d.exhr,d.exnighthr,d.fuel,d.setvalue,d.vatvalue FROM gl_limoinvm m LEFT JOIN (SELECT rdocno,GROUP_CONCAT(jobname) jobname,SUM(COALESCE(total,0)) total,SUM(COALESCE(discount,0)) discount, SUM(COALESCE(nettotal,0)) nettotal,SUM(COALESCE(tarif,0)) tarif,SUM(COALESCE(nighttarif,0)) nighttarif,SUM(COALESCE(exkmchg,0)) exkmchg,SUM(COALESCE(exhrchg,0)) exhrchg,SUM(COALESCE(exnighthrchg,0)) exnighthrchg,SUM(COALESCE(fuelchg,0)) fuelchg,SUM(COALESCE(parkingchg,0)) parkingchg,SUM(COALESCE(otherchg,0)) otherchg,SUM(COALESCE(greetchg,0)) greetchg,SUM(COALESCE(vipchg,0)) vipchg,SUM(COALESCE(boquechg,0)) boquechg,SUM(COALESCE(exkm,0)) exkm, SUM(COALESCE(exhr,0)) exhr,SUM(COALESCE(exnighthr,0)) exnighthr,SUM(COALESCE(fuel,0)) fuel,SUM(COALESCE(setvalue,0)) setvalue,SUM(COALESCE(vatvalue,0)) vatvalue FROM gl_limoinvd GROUP BY rdocno) d ON d.rdocno=m.`doc_no` "+join+"  WHERE m.status<>7 AND m.dtype='LIN' AND m.date BETWEEN ? AND ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            System.out.println(stmt);
            System.out.println(sqlfromdate+" - "+sqltodate);
            stmt.setDate(1, sqlfromdate); // e.g., "2025-01-01"
            stmt.setDate(2, sqltodate);
            ResultSet resultSet = stmt.executeQuery();
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            //System.out.println(RESULTDATA);
            stmt.close();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }

}
