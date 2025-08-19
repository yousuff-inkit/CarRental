package com.dashboard.operations.riderinvoiceprep;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsExcelImport {
    
    ClsConnection connDAO = new ClsConnection();
    ClsCommon commonDAO= new ClsCommon();

    public int ExcelImport(String docNo,String brchid,String year, String month) throws SQLException {
        Connection conn = null;
        PreparedStatement pstm = null; // Declare at the beginning

        try {
            conn = connDAO.getMyConnection();
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();

            // Fetch file path
            String path = "";
            String pathsql = "select path from my_fileattach where doc_no='" + docNo + "' and dtype='RIIP'";
            ResultSet rs = stmt.executeQuery(pathsql);
            while (rs.next()) {
                path = rs.getString("path");
            }
            path = path.replace("\\", "//");
            FileInputStream input = new FileInputStream(path);
            Workbook wb; // Use Workbook to support both formats
            String fileExtension = path.substring(path.lastIndexOf("."));

            if (fileExtension.equalsIgnoreCase(".xlsx")) {
                wb = new XSSFWorkbook(input); // For .xlsx files
            } else if (fileExtension.equalsIgnoreCase(".xls")) {
                wb = new HSSFWorkbook(input); // For .xls files
            } else {
                throw new IllegalArgumentException("Invalid file type: " + fileExtension);
            }

            // Get the first sheet
            Sheet sheet = wb.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            // Truncate temp table

            // Prepare SQL statement
            String sql = "INSERT INTO my_rip (rider_id, rider_name, pickupcnt, dropoffcnt, pickupcancl, dropoffcancl, evalutedhrs, distancepay, questpaid, ridertipspay, adminfeecom, operatorfeerider, total, vehicletype, eligiblemingrantee, telematics, extramobiledata, unpaiddispay, unpaidquest, unpaidincentive, unpaidtelematics, ev, inventorydeduction, custexpincentives, adjstfrmpastmonth, tphersincentive, dubspltincentive,brchid,year,month,coddeductions,orderissuedeductions,extrasimused,insurance,advance,rtaclass,labourcard,fineperformance,daysofwork,llogns) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstm = conn.prepareStatement(sql);
            System.out.println("sql : "+sql);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row != null && getCellValue(row.getCell(0)).length() > 0) {
                    // Read and set each column value
                    pstm.setInt(1, (int) getNumericCellValue(row.getCell(0))); // Rider Id
                    pstm.setString(2, getCellValue(row.getCell(1))); // Rider Name
                    pstm.setInt(3, (int) getNumericCellValue(row.getCell(2))); // Pickups Count
                    pstm.setInt(4, (int) getNumericCellValue(row.getCell(3))); // Dropoffs Count
                    pstm.setInt(5, (int) getNumericCellValue(row.getCell(4))); // Pickup Cancellations
                    pstm.setInt(6, (int) getNumericCellValue(row.getCell(5))); // Dropoff Cancellations
                    pstm.setDouble(7, getNumericCellValue(row.getCell(6))); // Evaluated Hours
                    pstm.setDouble(8, getNumericCellValue(row.getCell(7))); // Distance Pay
                    pstm.setDouble(9, getNumericCellValue(row.getCell(8))); // Quest (Paid)
                    pstm.setDouble(10, getNumericCellValue(row.getCell(9))); // Rider Tips Payments (LC)
                    pstm.setDouble(11, getNumericCellValue(row.getCell(10))); // Admin Fee FOR COMPANY
                    pstm.setDouble(12, getNumericCellValue(row.getCell(11))); // Operator fee rIDER
                    pstm.setDouble(13, getNumericCellValue(row.getCell(12))); // Total
                    pstm.setString(14, getCellValue(row.getCell(13))); // Vehicle Type
                    pstm.setString(15, getCellValue(row.getCell(14))); // Eligible for Min Guarantee
                    pstm.setDouble(16, getNumericCellValue(row.getCell(15))); // Telematics (paid)
                    pstm.setDouble(17, getNumericCellValue(row.getCell(16))); // Extra Mobile data
                    pstm.setDouble(18, getNumericCellValue(row.getCell(17))); // Unpaid distance pay
                    pstm.setDouble(19, getNumericCellValue(row.getCell(18))); // Unpaid quest
                    pstm.setDouble(20, getNumericCellValue(row.getCell(19))); // Unpaid Incentive
                    pstm.setDouble(21, getNumericCellValue(row.getCell(20))); // Unpaid Telematics
                    pstm.setDouble(22, getNumericCellValue(row.getCell(21))); // EV
                    pstm.setDouble(23, getNumericCellValue(row.getCell(22))); // Inventory deduction Sept
                    pstm.setDouble(24, getNumericCellValue(row.getCell(23))); // Customer experience incentives (Paid)
                    pstm.setDouble(25, getNumericCellValue(row.getCell(24))); // Adjustments from past month
                    pstm.setDouble(26, getNumericCellValue(row.getCell(25))); // Top Heroes - Incentive (Paid)
                    pstm.setDouble(27, getNumericCellValue(row.getCell(26))); // Dubai Split incentive (Paid)
                    pstm.setString(28, brchid);
                    pstm.setString(29, year);
                    pstm.setString(30, month);
                    pstm.setDouble(31, getNumericCellValue(row.getCell(27))); // Total Cod deduction
                    pstm.setDouble(32, getNumericCellValue(row.getCell(28))); // Order Issue Deductions 
                    pstm.setDouble(33, getNumericCellValue(row.getCell(29))); // Extra Sim Used
                    pstm.setDouble(34, getNumericCellValue(row.getCell(30))); // Insurance 
                    pstm.setDouble(35, getNumericCellValue(row.getCell(31))); // Advance 
                    pstm.setDouble(36, getNumericCellValue(row.getCell(32))); // rta Class 
                    pstm.setDouble(37, getNumericCellValue(row.getCell(33))); // Labour Card
                    pstm.setDouble(38, getNumericCellValue(row.getCell(34))); // Fine Performance
                    pstm.setDouble(39, getNumericCellValue(row.getCell(35))); // days of work
                    pstm.setDouble(40, getNumericCellValue(row.getCell(36))); // late login or no show
                   

                    // Execute the prepared statement
                    pstm.execute();
                }

              
            }

            conn.commit();
            return 1;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) conn.rollback(); // Rollback on exception
            return 0;
        } finally {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        }
    }

    // Utility methods for reading cell values
    private String getCellValue(Cell cell) {
        return cell != null ? cell.toString().trim() : "";
    }

    private double getNumericCellValue(Cell cell) {
        if (cell == null || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
            return 0.0;
        }

        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_NUMERIC:
                return cell.getNumericCellValue();

            case Cell.CELL_TYPE_STRING:
                String str = cell.getStringCellValue().trim();
                try {
                    return Double.parseDouble(str);
                } catch (NumberFormatException e) {
                    System.err.println("Not a number at cell: " + cell.getColumnIndex()+"-"+cell.getRowIndex());
                    return 0.0;
                }

            case Cell.CELL_TYPE_FORMULA:
                try {
                    return cell.getNumericCellValue();
                } catch (IllegalStateException e) {
                    try {
                        String formulaResult = cell.getStringCellValue().trim();
                        return Double.parseDouble(formulaResult);
                    } catch (Exception ex) {
                        return 0.0;
                    }
                }

            default:
                return 0.0;
        }
    }


    public int ExcelImportCSV(String docNo,String brchid,String year,String month) throws SQLException, IOException {
        Connection conn = null;
        PreparedStatement pstm = null;
        BufferedReader br = null;
        
        try {
            conn = connDAO.getMyConnection();
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            
            // Get the file path
            String path = "";
            String sql = "SELECT path FROM my_fileattach WHERE doc_no='" + docNo + "' AND dtype='RIIP'";
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                path = rs.getString("path").replace("\\", "//");
            }
            rs.close();
            
            br = new BufferedReader(new FileReader(path));
            String line;
            String cvsSplitBy = ",";
            
            // SQL for inserting into database
            String sqlInsert = "INSERT INTO my_rip (rider_id, rider_name, pickupcnt, dropoffcnt, pickupcancl, dropoffcancl, evalutedhrs, distancepay, questpaid, ridertipspay, adminfeecom, operatorfeerider, total, vehicletype, eligiblemingrantee, telematics, extramobiledata, unpaiddispay, unpaidquest, unpaidincentive, unpaidtelematics, ev, inventorydeduction, custexpincentives, adjstfrmpastmonth, tphersincentive, dubspltincentive,brchid,year,month,coddeductions,orderissuedeductions,extrasimused,insurance,advance,rtaclass,labourcard,fineperformance,daysofwork,llogns) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            System.out.println("sql : "+sqlInsert);

            int lineNumber = 0;
            while ((line = br.readLine()) != null) {
                // Skip the header line
                if (lineNumber++ == 0) continue;

                String[] data = line.split(cvsSplitBy);
                
                // Create a PreparedStatement
                pstm = conn.prepareStatement(sqlInsert);
                
                // Populate the PreparedStatement parameters
                pstm.setInt(1, Integer.parseInt(data[1].trim())); // Rider ID
                pstm.setString(2, data[2].trim()); // Rider Name
                pstm.setInt(3, parseToInt(data[3])); // Pickup Count
                pstm.setInt(4, parseToInt(data[4])); // Dropoff Count
                pstm.setInt(5, parseToInt(data[5])); // Pickup Cancellations
                pstm.setInt(6, parseToInt(data[6])); // Dropoff Cancellations
                pstm.setBigDecimal(7, parseToBigDecimal(data[7])); // Evaluated Hours
                pstm.setBigDecimal(8, parseToBigDecimal(data[8])); // Distance Pay
                pstm.setBigDecimal(9, parseToBigDecimal(data[9])); // Quest Paid
                pstm.setBigDecimal(10, parseToBigDecimal(data[10])); // Rider Tips Payments
                pstm.setBigDecimal(11, parseToBigDecimal(data[11])); // Admin Fee for Company
                pstm.setBigDecimal(12, parseToBigDecimal(data[12])); // Operator Fee Rider
                pstm.setBigDecimal(13, parseToBigDecimal(data[13])); // Total
                pstm.setString(14, data[14].trim()); // Vehicle Type
                pstm.setBoolean(15, Boolean.parseBoolean(data[15].trim())); // Eligible for Min Guarantee
                pstm.setBigDecimal(16, parseToBigDecimal(data[16])); // Telematics
                pstm.setBigDecimal(17, parseToBigDecimal(data[17])); // Extra Mobile Data
                pstm.setBigDecimal(18, parseToBigDecimal(data[18])); // Unpaid Distance Pay
                pstm.setBigDecimal(19, parseToBigDecimal(data[19])); // Unpaid Quest
                pstm.setBigDecimal(20, parseToBigDecimal(data[20])); // Unpaid Incentive
                pstm.setBigDecimal(21, parseToBigDecimal(data[21])); // Unpaid Telematics
                pstm.setString(22, data[22].trim()); // EV
                pstm.setBigDecimal(23, parseToBigDecimal(data[23])); // Inventory Deduction
                pstm.setBigDecimal(24, parseToBigDecimal(data[24])); // Customer Experience Incentives
                pstm.setBigDecimal(25, parseToBigDecimal(data[25])); // Adjustments from Past Month
                pstm.setBigDecimal(26, parseToBigDecimal(data[26])); // Top Heroes Incentive
                pstm.setBigDecimal(27, parseToBigDecimal(data[27])); // Dubai Split Incentive
                pstm.setString(28, brchid);
                pstm.setString(29, year);
                pstm.setString(30, month);
                pstm.setBigDecimal(31, parseToBigDecimal(data[28])); // Total Cod deduction
                pstm.setBigDecimal(32, parseToBigDecimal(data[29])); // Order Issue Deductions  
                pstm.setBigDecimal(33, parseToBigDecimal(data[30])); // Extra Sim Used
                pstm.setBigDecimal(34, parseToBigDecimal(data[31])); // Insurance 
                pstm.setBigDecimal(35, parseToBigDecimal(data[32])); // Advance 
                pstm.setBigDecimal(36, parseToBigDecimal(data[33])); // rta Class 
                pstm.setBigDecimal(37, parseToBigDecimal(data[34])); // Labour Card
                pstm.setBigDecimal(38, parseToBigDecimal(data[35])); // Fine Performance
                pstm.setBigDecimal(39, parseToBigDecimal(data[36])); // days of work
                pstm.setBigDecimal(40, parseToBigDecimal(data[37])); // LATE LOGIN & NO SHOW
                // Populate the PreparedStatement parameters
              System.out.println(pstm);
                
                // Execute insertion
                pstm.executeUpdate();
            }
            
            // Commit the transaction
            conn.commit();
            return 1;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) conn.rollback();
            return 0;
        } finally {
            if (pstm != null) pstm.close();
            if (br != null) br.close();
            if (conn != null) conn.close();
        }
    }

    // Helper methods
    private int parseToInt(String value) {
        return value == null || value.trim().isEmpty() ? 0 : Integer.parseInt(value.trim());
    }

    private BigDecimal parseToBigDecimal(String value) {
        return value == null || value.trim().isEmpty() ? BigDecimal.ZERO : new BigDecimal(value.trim());
    }

}
