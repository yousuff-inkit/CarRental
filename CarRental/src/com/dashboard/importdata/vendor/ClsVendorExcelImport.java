package com.dashboard.importdata.vendor;

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

public class ClsVendorExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsIMVendorDAO dao=new ClsIMVendorDAO();


		
	
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
		
			String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='VDR'";
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
               for(int j=0;j<25;j++)
               {
            	   if(row.getCell(j)!=null){
                   	row.getCell(j).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
               
               
               
               
				
				  if(row.getCell(26)!=null){
				  row.getCell(26).setCellType(Cell.CELL_TYPE_STRING); }
				  if(row.getCell(27)!=null){
				  row.getCell(27).setCellType(Cell.CELL_TYPE_STRING); }
				  if(row.getCell(28)!=null){
				  row.getCell(28).setCellType(Cell.CELL_TYPE_STRING); }
				 
				  for(int k=29;k<87;k++)
	               {
	            	   if(row.getCell(k)!=null){
	                   	row.getCell(k).setCellType(Cell.CELL_TYPE_STRING);  
	                   }  
	               }
				
				 
                //System.out.println("Row==="+row.getCell(11).toString());
				    String cldocno = row.getCell(0)==null?"":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");  
				  String serial_no = row.getCell(1)==null?"":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String refname = row.getCell(2)==null?"":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
	                String salutation = row.getCell(3)==null?"":row.getCell(3).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String address = row.getCell(4)==null?"":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String com_mob = row.getCell(5)==null?"":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String per_mob = row.getCell(6)==null?"":row.getCell(6).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String opt_mob = row.getCell(7)==null?"":row.getCell(7).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String taxable = row.getCell(8)==null?"":row.getCell(8).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String trnnumber = row.getCell(9)==null?"":row.getCell(9).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String category = row.getCell(10)==null?"":row.getCell(10).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String areaname = row.getCell(11)==null?"":row.getCell(11).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String areaid = row.getCell(12)==null?"":row.getCell(12).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String doc_no = row.getCell(13)==null?"":row.getCell(13).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String atype = row.getCell(14)==null?"":row.getCell(14).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String acno = row.getCell(15)==null?"":row.getCell(15).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String parentco = row.getCell(16)==null?"":row.getCell(16).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String fax1 = row.getCell(17)==null?"":row.getCell(17).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String fax2 = row.getCell(18)==null?"":row.getCell(18).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String web1 = row.getCell(19)==null?"":row.getCell(19).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String mail1 = row.getCell(20)==null?"":row.getCell(20).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String mail2 = row.getCell(21)==null?"":row.getCell(21).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String active = row.getCell(22)==null?"":row.getCell(22).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String codeno = row.getCell(23)==null?"":row.getCell(23).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String dtype = row.getCell(24)==null?"":row.getCell(24).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String date = row.getCell(25)==null?"":row.getCell(25).toString(); 
	                String curid = row.getCell(26)==null?"":row.getCell(26).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String designation = row.getCell(27)==null?"":row.getCell(27).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String refno = row.getCell(28)==null?"":row.getCell(28).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String dtjoin = row.getCell(29)==null?"":row.getCell(29).toString(); 
	                String basic = row.getCell(30)==null?"":row.getCell(30).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String contactperson = row.getCell(31)==null?"":row.getCell(31).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String period = row.getCell(32)==null?"":row.getCell(32).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String period2 = row.getCell(33)==null?"":row.getCell(33).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String credit = row.getCell(34)==null?"":row.getCell(34).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String address2 = row.getCell(35)==null?"":row.getCell(35).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String isagent = row.getCell(36)==null?"":row.getCell(36).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String salid = row.getCell(37)==null?"":row.getCell(37).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String agent = row.getCell(38)==null?"":row.getCell(38).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String catid = row.getCell(39)==null?"":row.getCell(39).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String brhid = row.getCell(40)==null?"":row.getCell(40).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String cmpid = row.getCell(41)==null?"":row.getCell(41).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String cstno = row.getCell(42)==null?"":row.getCell(42).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String taxid = row.getCell(43)==null?"":row.getCell(43).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String pricegroup = row.getCell(44)==null?"":row.getCell(44).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String remarks = row.getCell(45)==null?"":row.getCell(45).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliveryaddr = row.getCell(46)==null?"":row.getCell(46).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliveryaddr2 = row.getCell(47)==null?"":row.getCell(47).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliverytelno = row.getCell(48)==null?"":row.getCell(48).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliveryfax = row.getCell(49)==null?"":row.getCell(49).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliverycontactno = row.getCell(50)==null?"":row.getCell(50).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String deliverymob = row.getCell(51)==null?"":row.getCell(51).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String bankname = row.getCell(52)==null?"":row.getCell(52).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String branchname = row.getCell(53)==null?"":row.getCell(53).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String branchaddr = row.getCell(54)==null?"":row.getCell(54).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String ibanno = row.getCell(55)==null?"":row.getCell(55).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String acden = row.getCell(56)==null?"":row.getCell(56).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String cgroup = row.getCell(57)==null?"":row.getCell(57).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String advance = row.getCell(58)==null?"":row.getCell(58).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String invcmethod = row.getCell(59)==null?"":row.getCell(59).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String delcharges = row.getCell(60)==null?"":row.getCell(60).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String paymode = row.getCell(61)==null?"":row.getCell(61).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String accgroup = row.getCell(62)==null?"":row.getCell(62).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String serdefault = row.getCell(63)==null?"":row.getCell(63).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String persalikrate = row.getCell(64)==null?"":row.getCell(64).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String pertrafficcharge = row.getCell(65)==null?"":row.getCell(65).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String reftype = row.getCell(66)==null?"":row.getCell(66).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String contactperno = row.getCell(67)==null?"":row.getCell(67).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String extno = row.getCell(68)==null?"":row.getCell(68).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String contractupto = row.getCell(69)==null?"":row.getCell(69).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String audit = row.getCell(70)==null?"":row.getCell(70).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String spclnotes = row.getCell(71)==null?"":row.getCell(71).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String status = row.getCell(72)==null?"":row.getCell(72).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String rostatus = row.getCell(73)==null?"":row.getCell(73).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String lostatus = row.getCell(74)==null?"":row.getCell(74).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String pcase = row.getCell(75)==null?"":row.getCell(75).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String contractno = row.getCell(76)==null?"":row.getCell(76).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String conremarks = row.getCell(77)==null?"":row.getCell(77).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String tinno = row.getCell(78)==null?"":row.getCell(78).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String accno = row.getCell(79)==null?"":row.getCell(79).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String bankswiftno = row.getCell(80)==null?"":row.getCell(80).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String bankcity = row.getCell(81)==null?"":row.getCell(81).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String bankcountry = row.getCell(82)==null?"":row.getCell(82).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String finname = row.getCell(83)==null?"":row.getCell(83).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String finaddress = row.getCell(84)==null?"":row.getCell(84).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String olddocno = row.getCell(85)==null?"":row.getCell(85).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	                String nontax = row.getCell(86)==null?"":row.getCell(86).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
	             java.sql.Date sqlDate = null;
        		java.sql.Date sqlDtjoin=null;
        		
                
                if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("null"))){
                    
	     		     sqlDate=ClsCommon.changeStringtoSqlDate3(date);
	     		} 
					 
     	  
     	  if(!(dtjoin.equalsIgnoreCase("undefined"))&&!(dtjoin.equalsIgnoreCase(""))&&!(dtjoin.equalsIgnoreCase("null"))){
           
    		     sqlDtjoin=ClsCommon.changeStringtoSqlDate3(dtjoin);
    		
				 }
                
                
			 System.out.println("value==="+refname);  

			              String sql1 ="select refname from im_vendor where refname='"+refname+"' ";
			              ResultSet rs1=stmt.executeQuery(sql1);
			              if(rs1.next())
			              {
				     			 System.out.println("Already Imported===");

			              }
			              else if (!(refname.equalsIgnoreCase("")))
			              {
			              
			     			
			     			  String sql2 ="insert into im_vendor"
			     					+ "( cldocno,srno, refname, salutation, address, com_mob, per_mob, opt_mob, taxable, trnnumber, category,"
			     					+ " areaname, areaid, doc_no, atype, acno, parentco, fax1, fax2, web1, mail1,mail2,"
			     					+ " active, codeno, dtype, date, curid, designation, refno, dtjoin, basic, contactperson,"
			     					+ " period, period2, credit, address2, isagent, salid, agent, catid, brhid, cmpid,"
			     					+ " cstno, taxid, pricegroup, remarks, deliveryaddress, deliveryaddress2, deliverytelno, deliveryfax, deliverycontactno, deliverymob, "
			     					+ " bankname, branchname, branchaddress, ibanno, acden, cgroup, advance, invcmethod, delcharge, paymode,"
			     					+ " accgroup, serdefault, persalikrate, pertrafficcharge, reftype, per_tel, extno, contractupto, auditt, spclnotes,"
			     					+ " status, rostatus, lostatus, pcase, contractno, conremarks, tinno, accno, bankswiftno, bankcity,"
			     					+ " bankcountry, finname, finaddress, olddocno, nontax ) values "
			 			  			+ "('"+cldocno+"','"+serial_no+"','"+refname+"','"+salutation+"','"+address+"','"+com_mob+"','"+per_mob+"','"+opt_mob+"','"+taxable+"','"+trnnumber+"','"+category+"',"
			  				  		+ "'"+areaname+"','"+areaid+"','"+doc_no+"','"+atype+"','"+acno+"','"+parentco+"','"+fax1+"','"+fax2+"','"+web1+"','"+mail1+"','"+mail2+"',"
			  			  			+ "'"+active+"','"+codeno+"','"+dtype+"',if('"+sqlDate+"'='null',curdate(),'"+sqlDate+"') ,'"+curid+"','"+designation+"','"+refno+"',if('"+sqlDtjoin+"'='null',null,'"+sqlDtjoin+"') ,'"+basic+"','"+contactperson+"',"
			  				  		+ "'"+period+"','"+period2+"','"+credit+"','"+address2+"','"+isagent+"','"+salid+"','"+agent+"','"+catid+"','"+brhid+"','"+cmpid+"',"
			  				  		+ "'"+cstno+"','"+taxid+"','"+pricegroup+"','"+remarks+"','"+deliveryaddr+"','"+deliveryaddr2+"','"+deliverytelno+"','"+deliveryfax+"','"+deliverycontactno+"','"+deliverymob+"',"
			  				  		+ "'"+bankname+"','"+branchname+"','"+branchaddr+"','"+ibanno+"','"+acden+"','"+cgroup+"','"+advance+"','"+invcmethod+"','"+delcharges+"','"+paymode+"',"
			  				  		+ "'"+accgroup+"','"+serdefault+"','"+persalikrate+"','"+pertrafficcharge+"','"+reftype+"','"+contactperno+"','"+extno+"','"+contractupto+"','"+audit+"','"+spclnotes+"',"
			  				  		+ "'"+status+"','"+rostatus+"','"+lostatus+"','"+pcase+"','"+contractno+"','"+conremarks+"','"+tinno+"','"+accno+"','"+bankswiftno+"','"+bankcity+"',"
			  				  		+ "'"+bankcountry+"','"+finname+"','"+finaddress+"','"+olddocno+"','"+nontax+"')";
			  				 
			  			 
				  System.out.println("sql2=======>"+sql2);
				  pstm = conn.prepareStatement(sql2);
				  pstm.execute();
				  
				  
				  
				  
			              }           
            
            }
			  	       dao.employeeListinsertions();
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

