package com.finance.posting.manualapplyingnew;

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

import com.connection.ClsConnection;

public class ClsMAPPExcelImport {

	ClsConnection connDAO = new ClsConnection();
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			
			String path="";
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='MAPPE'";  
			ResultSet rs = stmt.executeQuery(strSql);
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
            
            for(int i=1; i<=sheet.getLastRowNum(); i++){
            	String edtype="";
            	int ebranch=0,edocno=0;
            	Double eamount=0.0,eappliedamt=0.0;        
                row = sheet.getRow(i);
                
                switch(row.getCell(0).getCellType()){          
       		     case Cell.CELL_TYPE_NUMERIC:     
       		    	 System.out.println("==="+row.getCell(0).getNumericCellValue());  
       		       ebranch=(int)((row.getCell(0).getNumericCellValue()+"").trim()==""?0.0:Double.parseDouble(row.getCell(0).getNumericCellValue()+""));         
       		       break;  
       		     case Cell.CELL_TYPE_STRING:   
       		       ebranch=(int)(row.getCell(0).getStringCellValue()=="" || row.getCell(0).getStringCellValue()==null?0.0:Double.parseDouble(row.getCell(0).getStringCellValue()));	  				 
       		       break;  
                }
                
               switch(row.getCell(1).getCellType()){       
      		     case Cell.CELL_TYPE_NUMERIC:     
      		    	edocno=(int)((row.getCell(1).getNumericCellValue()+"").trim()==""?0.0:Double.parseDouble(row.getCell(1).getNumericCellValue()+""));   
      		       break;  
      		     case Cell.CELL_TYPE_STRING:   
      		    	edocno=(int)(row.getCell(1).getStringCellValue()=="" || row.getCell(1).getStringCellValue()==null?0.0:Double.parseDouble(row.getCell(1).getStringCellValue()));	  			 
      		       break;  
               }
                
              switch(row.getCell(2).getCellType()){       
      		     case Cell.CELL_TYPE_NUMERIC:     
      		    	edtype=""+row.getCell(2).getNumericCellValue();  
      		       break;  
      		     case Cell.CELL_TYPE_STRING:   
      		    	edtype=row.getCell(2).getStringCellValue();					 
      		       break;  
               }
                
             /* switch(row.getCell(3).getCellType()){       
     		     case Cell.CELL_TYPE_NUMERIC:     
     		    	eamount=(row.getCell(3).getNumericCellValue()+"").trim()==""?0.0:Double.parseDouble(row.getCell(3).getNumericCellValue()+""); 
     		       break;  
     		     case Cell.CELL_TYPE_STRING:   
     		    	eamount=row.getCell(3).getStringCellValue()=="" || row.getCell(3).getStringCellValue()==null?0.0:Double.parseDouble(row.getCell(3).getStringCellValue());					 
     		       break;  
              }*/  
                
              switch(row.getCell(3).getCellType()){               
     		     case Cell.CELL_TYPE_NUMERIC:     
     		    	eappliedamt=(row.getCell(3).getNumericCellValue()+"").trim()==""?0.0:Double.parseDouble(row.getCell(3).getNumericCellValue()+"");       
     		       break;  
     		     case Cell.CELL_TYPE_STRING:   
     		    	eappliedamt=row.getCell(3).getStringCellValue()=="" || row.getCell(3).getStringCellValue()==null?0.0:Double.parseDouble(row.getCell(3).getStringCellValue());					 
     		       break;  
              } 
              //System.out.println(ebranch+"="+edocno+"="+edtype+"="+eamount+"="+eappliedamt);    
               String sql = "INSERT INTO my_mapp_excel(branch, doc_no, dtype, amount, appliedamt, id) VALUES"            
                		+ "('"+ebranch+"', '"+edocno+"', '"+edtype+"', '"+eamount+"', '"+eappliedamt+"', '"+docNo+"')";
                //System.out.println("sql=="+sql);   
                pstm = conn.prepareStatement(sql);      
                pstm.execute();
            }
            conn.commit();
            pstm.close();
            conn.close();
            input.close();
            return 1;
        }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	}

}

