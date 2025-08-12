package com.dashboard.importdata.productmaster;

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

public class ClsPRMExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsProductmasterDAO dao=new ClsProductmasterDAO();


		
	
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
         	String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='PRM'";
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
        

            int status=0;
    		
            String sql11="truncate im_product";
            status=stmt.executeUpdate(sql11);	  
            System.out.println("sql11============="+sql11);
	    	     
           for(int i=2; i<=sheet.getLastRowNum(); i++){  //Changed i=0 because of header in excel - 2022/07/11
            	  row = sheet.getRow(i);
                int ar[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13};
               for(int j=0;j<ar.length;j++)
               {
            	   if(row.getCell(ar[j])!=null){
                   	row.getCell(ar[j]).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
			//System.out.println("abc"+row.getCell(0).getStringCellValue());
                String psrno = row.getCell(0)==null || row.getCell(0).getStringCellValue().equals("")?"0":row.getCell(0).getStringCellValue().replace(",", " ");
                String code= row.getCell(1)==null?"":row.getCell(1).getStringCellValue().replace(",", " ");
                String name= row.getCell(2)==null?"":row.getCell(2).getStringCellValue().replace(",", " ");
                String dept = row.getCell(3)==null?"":row.getCell(3).getStringCellValue().replace(",", " "); 
                String category= row.getCell(4)==null?"":row.getCell(4).getStringCellValue().replace(",", " "); 
                String subcategory =row.getCell(5)==null?"":row.getCell(5).getStringCellValue().replace(",", " "); 
                String unit = row.getCell(6)==null?"":row.getCell(6).getStringCellValue().replace(",", " "); 
                String type =row.getCell(7)==null?"":row.getCell(7).getStringCellValue().replace(",", " "); 
                String brand =row.getCell(8)==null?"":row.getCell(8).getStringCellValue().replace(",", " "); 
                String barcode =row.getCell(9)==null?"":row.getCell(9).getStringCellValue().replace(",", " "); 
                String unitprice = row.getCell(10)==null?"":row.getCell(10).getStringCellValue().replace(",", " "); 
                String star = row.getCell(11)==null?"":row.getCell(11).getStringCellValue().replace(",", " "); 
                String quantity = row.getCell(12)==null?"":row.getCell(12).getStringCellValue().replace(",", " "); 
                String priceval = row.getCell(13)==null?"":row.getCell(13).getStringCellValue().replace(",", " "); 
				
                if (name !="") {       
                String sql2 ="insert into im_product(psrno,code,name,dept,category,subcategory,unit,type,brand,barcode,unitprice,star,quantity,priceval)values('"+psrno+"','"+code+"','"+name+"','"+dept+"','"+category+"','"+subcategory+"','"+unit+"','"+type+"','"+brand+"','"+barcode+"','"+unitprice+"','"+star+"','"+quantity+"','"+priceval+"')";
					    
				  //System.out.println("sql2=======>"+sql2);
				  pstm = conn.prepareStatement(sql2);
				  pstm.execute();
				  
					    }
				  
				  
			                
            
            }
			  	        dao.ProductListinsertions();
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

