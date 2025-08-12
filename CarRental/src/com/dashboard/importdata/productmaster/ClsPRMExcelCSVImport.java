package com.dashboard.importdata.productmaster;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.ibm.icu.text.SimpleDateFormat;

public class ClsPRMExcelCSVImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
ClsProductmasterDAO dao=new ClsProductmasterDAO();
	
	public static boolean isValidFormat(String format, String value) throws ParseException {
       java.util.Date date = null;
        
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            date = sdf.parse(value);
            String date1=sdf.format(date);
            if (value.equalsIgnoreCase(date1)) {
          return true;
            }
            else
            {
            	return false;
            }
    }
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			java.sql.PreparedStatement pstm = null ;
			
			String path="";
			String line = "";
	        String cvsSplitBy = ",";
	        
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='PRM'";

			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
			
			
			
			BufferedReader br = new BufferedReader(new FileReader(path));
			
			int i=0;
			
            while ((line = br.readLine()) != null) {

            	if(i>0) {
            
	                // use comma as separator
	                String[] journal = line.split(cvsSplitBy);
	                        
for(String n:journal)
{
	System.out.println("values"+n);
}
	            			              
				              
				              
				              if(journal[2]!="") {
				     		
					  String sql2 ="insert into im_product"
					  		+ " (psrno,code,name,dept,category,subcategory,unit,type,brand,barcode,unitprice,star,quantity,priceval) values "
					  		+ "('"+journal[0]+"','"+journal[1]+"','"+journal[2]+"','"+journal[3]+"','"+journal[4]+"','"+journal[5]+"','"+journal[6]+"','"+journal[7]+"','"+journal[8]+"','"+journal[9]+"',"
					  		+ "'"+journal[10]+"','"+journal[11]+"','"+journal[12]+"','"+journal[13]+"') ";
					 
					 // System.out.println("sql2=======>"+sql2);
					  pstm = conn.prepareStatement(sql2);
					  pstm.execute();
				
				              }     
            	}
            	
                i++;
            }
		
			  dao.ProductListinsertions();
		
if(pstm!=null)
{

            pstm.close();
            conn.close();
            return 1;
}
        } catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
		 dao.promasterGridLoading();
		 conn.close();
	 }
		return 0;
	}

}

