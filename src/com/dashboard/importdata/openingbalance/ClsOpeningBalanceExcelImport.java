package com.dashboard.importdata.openingbalance;

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

public class ClsOpeningBalanceExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsIMOpeningBalanceDAO dao=new ClsIMOpeningBalanceDAO();


		
	
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
		
			String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='OPB'";
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
               for(int k=4;k<8;k++)
               {
            	   if(row.getCell(k)!=null){
                   	row.getCell(k).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
               
               
               
				
				 
                //System.out.println("Row==="+row.getCell(11).toString());
				  String serial_no = row.getCell(0)==null?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String accountno = row.getCell(1)==null?"":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
	                String accountname = row.getCell(2)==null?"":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String date = row.getCell(3)==null?"":row.getCell(3).toString(); 
	                String doc_no = row.getCell(4)==null?"":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String debit = row.getCell(5)==null?"":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String credit = row.getCell(6)==null?"":row.getCell(6).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String desc = row.getCell(7)==null?"":row.getCell(7).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                    java.sql.Date sqlDate = null;
        		java.sql.Date sqlDtjoin=null;
        		double debit1=0.0, credit1=0.0;
        		
        		if(!debit.equals("")) {
        			debit1 = Double.parseDouble(debit);
        		}
        		
        		if(!credit.equals("")) {
        			credit1 = Double.parseDouble(credit);
        		}
                
                if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("null"))){
                    
	     		     sqlDate=ClsCommon.changeStringtoSqlDate3(date);
	     		} 
					 
     	  
     	 

			            /*  String sql1 ="select doc_no from im_openbalance where doc_no='"+doc_no+"' ";
			              ResultSet rs1=stmt.executeQuery(sql1);
			              if(rs1.next())
			              {
				     			 System.out.println("Already Imported===");

			              }
						  
							else
								*/
								if (!(accountno.equalsIgnoreCase(""))) 
			              {
			              
			     			
			     			  String sql2 ="insert into im_openbalance"
			     					+ "( srno, accountno, accountname, date, doc_no, debit, credit, `desc` ) values "
			 			  			+ "('"+serial_no+"','"+accountno+"','"+accountname+"','"+sqlDate+"','"+doc_no+"',round('"+debit1+"',2),round('"+credit1+"',2),'"+desc+"')";
			  				 
			  			 
				  //System.out.println("sql2=======>"+sql2);
				  pstm = conn.prepareStatement(sql2);
				  pstm.execute();
				  
				  
				  
				  
			              }           
            
            }
			  	    // dao.employeeListinsertions();
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

