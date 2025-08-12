package com.dashboard.importdata.vehiclemaster;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ClsVehicleExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsIMVehicleDAO dao=new ClsIMVehicleDAO();
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
		
			String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='VHM'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
            java.sql.PreparedStatement pstm = null ;
            FileInputStream input = new FileInputStream(path);
            POIFSFileSystem fs = new POIFSFileSystem( input );
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            HSSFSheet sheet = wb.getSheetAt(0);
            Row row;
            System.out.println("getLastRowNum===="+sheet.getLastRowNum());
            for(int i=1; i<=sheet.getLastRowNum(); i++){  //Changed i=0 because of header in excel - 2022/07/11
                row = sheet.getRow(i);
               
                String doc_no = cleanStringCell(row.getCell(0)); 
                String date = getFormattedDate(row.getCell(1));  
                String fleetno = cleanStringCell(row.getCell(2));
                String fleetname = cleanStringCell(row.getCell(3));
                String authority = cleanStringCell(row.getCell(4));
                String platecode =cleanStringCell( row.getCell(5));
                String reg_no = cleanStringCell(row.getCell(6));
                String veh_status = cleanStringCell(row.getCell(7));
                String group_name = cleanStringCell(row.getCell(8));
                String brand_name = cleanStringCell(row.getCell(9));
                String model = cleanStringCell(row.getCell(10));
                String yom = cleanStringCell(row.getCell(11));
                String salik_tagno = cleanStringCell(row.getCell(12));
                String tcno = cleanStringCell(row.getCell(13));
                String reg_date = getFormattedDate(row.getCell(14));  
                String reg_expiry = getFormattedDate(row.getCell(15));     
                String ins_expiry = getFormattedDate(row.getCell(16));          
                String purchase_cost = cleanStringCell(row.getCell(17));
                String dep_per = cleanStringCell(row.getCell(18));
                String dealer = cleanStringCell(row.getCell(19));
                String lpono = cleanStringCell(row.getCell(20));
                String purchase_date = getFormattedDate(row.getCell(21));
                String financier = cleanStringCell(row.getCell(22));
                String ins_type = cleanStringCell(row.getCell(23));
                String ins_comp = cleanStringCell(row.getCell(24));
                String policy_no = cleanStringCell(row.getCell(25));
                String branch = cleanStringCell(row.getCell(26));
                String location = cleanStringCell(row.getCell(27));
                String color = cleanStringCell(row.getCell(28));
                String engine_no = cleanStringCell(row.getCell(29));
                String chasis_no = cleanStringCell(row.getCell(30));
                String fuel_type = cleanStringCell(row.getCell(31));
                String fuel_capacity = cleanStringCell(row.getCell(32));
                String status = cleanStringCell(row.getCell(33));
                String currentkm = cleanStringCell(row.getCell(34));
                String fstatus = cleanStringCell(row.getCell(35));
                String currentfuel = cleanStringCell(row.getCell(36));
                String srvduration_km = cleanStringCell(row.getCell(37));
                String lastsrv_date = getFormattedDate(row.getCell(38));  
                String spec = cleanStringCell(row.getCell(39));
                String project = cleanStringCell(row.getCell(40));
                
                System.out.println(date+"==lastsrv_date=="+lastsrv_date);
                
               
			              String sql1 ="select fleetname from im_vehicle where platecode='"+platecode+"' and reg_no='"+reg_no+"' ";
			              ResultSet rs1=stmt.executeQuery(sql1);
			              if(rs1.next())
			              {
				     			 System.out.println("Already Imported===");

			              }
			              else if (!(reg_no.equalsIgnoreCase("")))
			              {
			     			
			     			  String sql2 ="insert into im_vehicle"
			     					+ "(doc_no,date,fleetno,fleetname, authority, platecode, reg_no, veh_status, group_name, brand_name, model,"
			     					+ " yom, salik_tagno, tcno, reg_date, reg_expiry, ins_expiry, purchase_cost, dep_per,"
			     					+ " dealer, lpono, purchase_date, financier, ins_type, ins_comp, policy_no, branch,"
			     					+ " location, color, engine_no, chasis_no, fuel_type, fuel_capacity, status, currentkm,"
			     					+ " fstatus, currentfuel, srvduration_km, lastsrv_date,spec,project ) values "
			 			  			+ "('"+doc_no+"',if('"+date+"'='null',curdate(),'"+date+"'),'"+fleetno+"','"+fleetname+"','"+authority+"','"+platecode+"','"+reg_no+"','"+veh_status+"','"+group_name+"','"+brand_name+"','"+model+"',"
			 			  			+ "'"+yom+"','"+salik_tagno+"','"+tcno+"','"+reg_date+"','"+reg_expiry+"','"+ins_expiry+"','"+purchase_cost+"','"+dep_per+"',"
			 			  		    + "'"+dealer+"','"+lpono+"','"+purchase_date+"','"+financier+"','"+ins_type+"','"+ins_comp+"','"+policy_no+"','"+branch+"',"
			 			  		    + "'"+location+"','"+color+"','"+engine_no+"','"+chasis_no+"','"+fuel_type+"','"+fuel_capacity+"','"+status+"','"+currentkm+"',"
			  				  	    + "'"+fstatus+"','"+currentfuel+"','"+srvduration_km+"','"+lastsrv_date+"','"+spec+"','"+project+"')";
			  			 
							  System.out.println("sql2=======>"+sql2);
							  pstm = conn.prepareStatement(sql2);
							  pstm.execute();
				        }             
            
            }
			  	      // dao.vehicleListinsertions();
			if(pstm!=null) {
	          // conn.commit();
	            pstm.close();
	            conn.close();
	            input.close();
	            return 1;
		    }   
        }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}
    
    private String cleanStringCell(Cell cell) {
        if (cell == null) return "";

        String value = "";

        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING:
                value = cell.getStringCellValue();
                break;

            case Cell.CELL_TYPE_NUMERIC:
                double numericValue = cell.getNumericCellValue();
                if (numericValue == Math.floor(numericValue)) {
                    value = String.valueOf((long) numericValue);
                } else {
                    value = String.valueOf(numericValue);
                }
                break;

            case Cell.CELL_TYPE_BOOLEAN:
                value = String.valueOf(cell.getBooleanCellValue());
                break;

            case Cell.CELL_TYPE_FORMULA:
                try {
                    value = cell.getStringCellValue();
                } catch (IllegalStateException e) {
                    double formulaValue = cell.getNumericCellValue();
                    if (formulaValue == Math.floor(formulaValue)) {
                        value = String.valueOf((long) formulaValue);
                    } else {
                        value = String.valueOf(formulaValue);
                    }
                }
                break;

            case Cell.CELL_TYPE_BLANK:
                value = "";
                break;

            default:
                value = cell.toString();
                break;
        }

        return value.replace("\"", "'")
                    .replaceAll("'", "/")
                    .replaceAll("\\s+", " ");
    }


    
    private String getFormattedDate(Cell cell) {
        if (cell == null) return "";

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC && DateUtil.isCellDateFormatted(cell)) {
                return sdf.format(cell.getDateCellValue());
            } else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
                String val = cell.getStringCellValue().trim();
                
                String[] knownFormats = { "dd/MM/yyyy", "MM/dd/yyyy", "yyyy-MM-dd", "dd-MM-yyyy" };

                for (String fmt : knownFormats) {
                    try {
                        Date parsedDate = new SimpleDateFormat(fmt).parse(val);
                        return sdf.format(parsedDate);  
                    } catch (Exception ignore) {
                    }
                }

                System.out.println("Unrecognized date format: " + val);
                return val;  
            }
        } catch (Exception e) {
            System.out.println("Date parsing error: " + e.getMessage());
        }

        return "";
    }

}