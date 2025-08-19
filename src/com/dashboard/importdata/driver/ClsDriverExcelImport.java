package com.dashboard.importdata.driver;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDriverExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsIMDriverDAO dao=new ClsIMDriverDAO();


		
	
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
		
			String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='DRV'";
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
            	String accounts="",description="";
                row = sheet.getRow(i);
               for(int j=0;j<3;j++)
               {
            	   if(row.getCell(j)!=null){
                   	row.getCell(j).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
               for(int k=4;k<9;k++)
               {
            	   if(row.getCell(k)!=null){
                   	row.getCell(k).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
               for(int k=11;k<15;k++)
               {
                   if(row.getCell(k)!=null){
                    row.getCell(k).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
               
               if(row.getCell(16)!=null){
                   row.getCell(16).setCellType(Cell.CELL_TYPE_STRING);  
                  } 
               
				
				 
                //System.out.println("Row==="+row.getCell(11).toString());
				  String clientname = row.getCell(0)==null?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String driverid = row.getCell(1)==null?"":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
	                String drivername = row.getCell(2)==null?"":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String dob = row.getCell(3)==null?"":row.getCell(3).toString(); 
	                String nationality = row.getCell(4)==null?"":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String mobileno = row.getCell(5)==null?"":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                 String licenseno = row.getCell(6)==null?"":row.getCell(6).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String licensetype = row.getCell(7)==null?"":row.getCell(7).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String licenseissuedfrom = row.getCell(8)==null?"":row.getCell(8).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String licenseissueddate = row.getCell(9)==null?"":row.getCell(9).toString();  
                    String licenseexpiry = row.getCell(10)==null?"":row.getCell(10).toString(); 
                    String srno = row.getCell(11)==null?"":row.getCell(11).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String clientdocno = row.getCell(12)==null?"":row.getCell(12).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String led = row.getCell(13)==null?"":row.getCell(13).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String passportno = row.getCell(14)==null?"":row.getCell(14).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String passportexpiry = row.getCell(15)==null?"":row.getCell(15).toString(); 
                    String idno = row.getCell(16)==null?"":row.getCell(16).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                    String idexpiry = row.getCell(17)==null?"":row.getCell(17).toString(); 

	                java.sql.Date dob1 = null;
        		java.sql.Date lissuedate=null,lexpirydate=null,passexpiry=null,idsexpiry=null;
        		
                
                if(!(licenseissueddate.equalsIgnoreCase("undefined"))&&!(licenseissueddate.equalsIgnoreCase(""))&&!(licenseissueddate.equalsIgnoreCase("null"))){
                    
                    lissuedate=ClsCommon.changeStringtoSqlDate3(licenseissueddate);
	     		} 
					 
                if(!(licenseexpiry.equalsIgnoreCase("undefined"))&&!(licenseexpiry.equalsIgnoreCase(""))&&!(licenseexpiry.equalsIgnoreCase("null"))){
                    
                    lexpirydate=ClsCommon.changeStringtoSqlDate3(licenseexpiry);
               } 
                if(!(passportexpiry.equalsIgnoreCase("undefined"))&&!(passportexpiry.equalsIgnoreCase(""))&&!(passportexpiry.equalsIgnoreCase("null"))){
                    
                    passexpiry=ClsCommon.changeStringtoSqlDate3(passportexpiry);
               } 
                if(!(idexpiry.equalsIgnoreCase("undefined"))&&!(idexpiry.equalsIgnoreCase(""))&&!(idexpiry.equalsIgnoreCase("null"))){
                    
                    idsexpiry=ClsCommon.changeStringtoSqlDate3(idexpiry);
               } 
                if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("null"))){
                    
                    dob1=ClsCommon.changeStringtoSqlDate3(dob);
               } 
     	 

			              String sql1 ="select drivername from im_driver where driverid='"+driverid+"' ";
			              ResultSet rs1=stmt.executeQuery(sql1);
			              if(rs1.next())
			              {
				     			 System.out.println("Already Imported===");

			              }
						  
							else if (!(driverid.equalsIgnoreCase(""))) 
			              {
			              
							    String sqls ="select cldocno from my_acbook where cldocno='"+clientdocno+"' ";
				                 ResultSet rs2=stmt.executeQuery(sqls);
				                 if(rs2.next())
				                 {
				                        System.out.println("cldocno matching==="+clientdocno);

				                 
			     			  String sql2 ="insert into im_driver"
			     					+ "( client, driverid, drivername, dob, nationality, mobileno, dlno, licensetype, licenseissuedfrom, licenseissueddate, licenseexpiry, srno, clientdocno, led, passportno, passportexpiry, idno, idexpiry) values "
			 			  			+ "('"+clientname+"','"+driverid+"','"+drivername+"','"+dob1+"','"+nationality+"','"+mobileno+"','"+licenseno+"','"+licensetype+"','"+licenseissuedfrom+"','"+lissuedate+"','"+lexpirydate+"','"+srno+"','"+clientdocno+"','"+led+"','"+passportno+"','"+passexpiry+"','"+idno+"','"+idsexpiry+"')";
			  				 
			  			 
				  System.out.println("sql2=======>"+sql2);
				  pstm = conn.prepareStatement(sql2);
				  pstm.execute();
				  
				                 }
				                 else
				                 {
                                     System.out.println("cldocno NOT matching==="+clientdocno);

				                 }
				  
				  
			              }           
            
            }
			  	       // dao.driverListinsertions();
			  	      if(pstm!=null)
			  	    {
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

}

