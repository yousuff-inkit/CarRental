package com.dashboard.importdata.employee;

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

public class ClsEMPExcelImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsEmployeeDAO dao=new ClsEmployeeDAO();


		
	
	
    public int ExcelImport(String docNo) throws SQLException {
    	 Connection conn = null;
    	
        try{
        	conn=connDAO.getMyConnection();
			//conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			java.sql.Date sqlDate2 = null;
    		java.sql.Date sqlDate11=null;
    		java.sql.Date sqlDate27=null;
    		java.sql.Date sqlDate46=null;
    		java.sql.Date sqlDate47=null;
    		java.sql.Date sqlDate48=null;
    		java.sql.Date sqlDate51=null;
    		java.sql.Date sqlDate64=null;
    		java.sql.Date sqlDate67=null;
    		java.sql.Date sqlDate68=null;
    		java.sql.Date sqlDate71=null;
    		java.sql.Date sqlDate72=null;
      		java.sql.Date sqlDate75=null;
    		java.sql.Date sqlDate76=null;
    		java.sql.Date sqlDate79=null;
    		java.sql.Date sqlDate80=null;
    		java.sql.Date sqlDate83=null;
    		java.sql.Date sqlDate84=null;
    		java.sql.Date sqlDate87=null;
    		java.sql.Date sqlDate88=null;

			String path="";
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='EMP'";
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
            for(int i=1; i<=sheet.getLastRowNum(); i++){  //Changed i=0 because of header in excel - 2022/07/11
            	String accounts="",description="";
                row = sheet.getRow(i);
                int ar[] = { 0,1,3,4,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,49,50,52,53,54,55,56,57,58,59,60,61,62,63,65,66,69,70,73,74,77,78,81,82,85,86,89};
               for(int j=0;j<ar.length;j++)
               {
            	   if(row.getCell(ar[j])!=null){
                   	row.getCell(ar[j]).setCellType(Cell.CELL_TYPE_STRING);  
                   }  
               }
				/*
				 * if(row.getCell(66)!=null){
				 * row.getCell(66).setCellType(Cell.CELL_TYPE_STRING); }
				 * if(row.getCell(54)!=null){
				 * row.getCell(54).setCellType(Cell.CELL_TYPE_STRING); }
				 * if(row.getCell(86)!=null){
				 * row.getCell(86).setCellType(Cell.CELL_TYPE_STRING); }
				 */
               
                //System.out.println("Row==="+row.getCell(11).toString());
                String brhid = row.getCell(0)==null?"":row.getCell(0).getStringCellValue().replace(",", " ");
                String doc_no= row.getCell(1)==null?"":row.getCell(1).getStringCellValue().replace(",", " ");
                String codeno= row.getCell(3)==null?"":row.getCell(3).getStringCellValue().replace(",", " ");
                String name = row.getCell(4)==null?"":row.getCell(4).getStringCellValue().replace(",", " "); 
                int cash_advance= (int) (row.getCell(5)==null?0:row.getCell(5).getNumericCellValue()); 
                int basicsalary = (int) (row.getCell(6)==null?0:row.getCell(6).getNumericCellValue()); 
                int hra = (int) (row.getCell(7)==null?0:row.getCell(7).getNumericCellValue()); 
                int ta = (int) (row.getCell(8)==null?0:row.getCell(8).getNumericCellValue()); 
                int others = (int) (row.getCell(9)==null?0:row.getCell(9).getNumericCellValue()); 
                int total = (int) (row.getCell(10)==null?0:row.getCell(10).getNumericCellValue()); 
                String acno = row.getCell(12)==null?"":row.getCell(12).getStringCellValue().replace(",", " "); 
                String acc_curid = row.getCell(13)==null?"":row.getCell(13).getStringCellValue().replace(",", " "); 
                String address = row.getCell(14)==null?"":row.getCell(14).getStringCellValue().replace(",", " "); 
                String paddress = row.getCell(15)==null?"":row.getCell(15).getStringCellValue().replace(",", " "); 
                String mobile = row.getCell(16)==null?"":row.getCell(16).getStringCellValue().replace(",", " "); 
                String pmobile = row.getCell(17)==null?"":row.getCell(17).getStringCellValue().replace(",", " ");
                String email = row.getCell(18)==null?"":row.getCell(18).getStringCellValue().replace(",", " "); 
                String pemail = row.getCell(19)==null?"":row.getCell(19).getStringCellValue().replace(",", " "); 
                String city = row.getCell(20)==null?"":row.getCell(20).getStringCellValue().replace(",", " "); 
                String state = row.getCell(21)==null?"":row.getCell(21).getStringCellValue().replace(",", " "); 
                String pincode = row.getCell(22)==null?"":row.getCell(22).getStringCellValue().replace(",", " ");
                String nationality = row.getCell(23)==null?"":row.getCell(23).getStringCellValue().replace(",", " "); 
                String religion = row.getCell(24)==null?"":row.getCell(24).getStringCellValue().replace(",", " "); 
                String nairport = row.getCell(25)==null?"":row.getCell(25).getStringCellValue().replace(",", " "); 
                String pob = row.getCell(26)==null?"":row.getCell(26).getStringCellValue().replace(",", " "); 
                String dtype = row.getCell(28)==null?"":row.getCell(28).getStringCellValue().replace(",", " "); 
                String nation = row.getCell(29)==null?"":row.getCell(29).getStringCellValue().replace(",", " "); 
                String cmpny = row.getCell(30)==null?"":row.getCell(30).getStringCellValue().replace(",", " "); 
                String mstatus = row.getCell(31)==null?"":row.getCell(31).getStringCellValue().replace(",", " "); 
                String gender = row.getCell(32)==null?"":row.getCell(32).getStringCellValue().replace(",", " "); 
                String status = row.getCell(33)==null?"":row.getCell(33).getStringCellValue().replace(",", " "); 
                String father = row.getCell(34)==null?"":row.getCell(34).getStringCellValue().replace(",", " "); 
                String mother = row.getCell(35)==null?"":row.getCell(35).getStringCellValue().replace(",", " "); 
                String bloodgrp = row.getCell(36)==null?"":row.getCell(36).getStringCellValue().replace(",", " "); 
                String age = row.getCell(37)==null?"":row.getCell(37).getStringCellValue().replace(",", " "); 
                String estcode = row.getCell(38)==null?"":row.getCell(38).getStringCellValue().replace(",", " "); 
                String grpno = row.getCell(39)==null?"":row.getCell(39).getStringCellValue().replace(",", " "); 
                String spouse = row.getCell(40)==null?"":row.getCell(40).getStringCellValue().replace(",", " "); 
                String otherdetail = row.getCell(41)==null?"":row.getCell(41).getStringCellValue().replace(",", " "); 
                String curid = row.getCell(42)==null?"":row.getCell(42).getStringCellValue().replace(",", " "); 
                String active = row.getCell(43)==null?"":row.getCell(43).getStringCellValue().replace(",", " "); 
                String calender = row.getCell(44)==null?"":row.getCell(44).getStringCellValue().replace(",", " "); 
                String lannleave = row.getCell(45)==null?"":row.getCell(45).getStringCellValue().replace(",", " "); 
                String timesheet =row.getCell(49)==null?"":row.getCell(49).getStringCellValue().replace(",", " "); 
                String curbrhid = row.getCell(50)==null?"":row.getCell(50).getStringCellValue().replace(",", " "); 
                String categ = row.getCell(52)==null?"":row.getCell(52).getStringCellValue().replace(",", " "); 
                String agent = row.getCell(53)==null?"":row.getCell(53).getStringCellValue().replace(",", " "); 
               //System.out.println("data53"+data53);
                String bank_acc = row.getCell(54)==null?"":row.getCell(54).getStringCellValue().replace(",", " "); 
               // System.out.println("data54"+data54);

                String employee_id = row.getCell(55)==null?"":row.getCell(55).getStringCellValue().replace(",", " "); 
                String branch_name = row.getCell(56)==null?"":row.getCell(56).getStringCellValue().replace(",", " "); 
                String ifsccode =row.getCell(57)==null?"":row.getCell(57).getStringCellValue().replace(",", " "); 
                String desc = row.getCell(58)==null?"":row.getCell(58).getStringCellValue().replace(",", " "); 
                String dept = row.getCell(59)==null?"":row.getCell(59).getStringCellValue().replace(",", " "); 
                String pay_cat = row.getCell(60)==null?"":row.getCell(60).getStringCellValue().replace(",", " "); 
                String travels = row.getCell(61)==null?"":row.getCell(61).getStringCellValue().replace(",", " "); 
                String salary_paid = row.getCell(62)==null?"":row.getCell(62).getStringCellValue().replace(",", " ");
                String terminalbenefit = row.getCell(63)==null?"":row.getCell(63).getStringCellValue().replace(",", " "); 
                String rdocno = row.getCell(65)==null?"":row.getCell(65).getStringCellValue().replace(",", " ");
                String pdocno = row.getCell(66)==null?"":row.getCell(66).getStringCellValue().replace(",", " "); 
                String pplace = row.getCell(69)==null?"":row.getCell(69).getStringCellValue().replace(",", " "); 
                String vdocno = row.getCell(70)==null?"":row.getCell(70).getStringCellValue().replace(",", " "); 
                String vplace = row.getCell(73)==null?"":row.getCell(73).getStringCellValue().replace(",", " "); 
                String edocno = row.getCell(74)==null?"":row.getCell(74).getStringCellValue().replace(",", " "); 
                String eplace = row.getCell(77)==null?"":row.getCell(77).getStringCellValue().replace(",", " "); 
                String ldocno = row.getCell(78)==null?"":row.getCell(78).getStringCellValue().replace(",", " ");
                String lplace = row.getCell(81)==null?"":row.getCell(81).getStringCellValue().replace(",", " "); 
                String lidocno = row.getCell(82)==null?"":row.getCell(82).getStringCellValue().replace(",", " ");
                String liplace = row.getCell(85)==null?"":row.getCell(85).getStringCellValue().replace(",", " "); 
                String mdocno = row.getCell(86)==null?"":row.getCell(86).getStringCellValue().replace(",", " "); 
                String mplace = row.getCell(89)==null?"":row.getCell(89).getStringCellValue().replace(",", " "); 
                int basicsalary1 = (int) (row.getCell(90)==null?0:row.getCell(90).getNumericCellValue()); 
                int hra1 = (int) (row.getCell(91)==null?0:row.getCell(91).getNumericCellValue()); 
                int ta1 = (int) (row.getCell(92)==null?0:row.getCell(92).getNumericCellValue()); 
                int fa1 = (int) (row.getCell(93)==null?0:row.getCell(93).getNumericCellValue()); 
                int ot1 = (int) (row.getCell(94)==null?0:row.getCell(94).getNumericCellValue()); 
                int otherallowance = (int) (row.getCell(95)==null?0:row.getCell(95).getNumericCellValue()); 
                int carallowance = (int) (row.getCell(96)==null?0:row.getCell(96).getNumericCellValue()); 

                
                
                
                
                
                
                
                String date2 = row.getCell(2)==null?"":row.getCell(2).toString();  
                String date11 = row.getCell(11)==null?"":row.getCell(11).toString();  
                String date27 = row.getCell(27)==null?"":row.getCell(27).toString();  
                String date46 = row.getCell(46)==null?"":row.getCell(46).toString();  
                String date47 = row.getCell(47)==null?"":row.getCell(47).toString();  
                String date48 = row.getCell(48)==null?"":row.getCell(48).toString();  
                String date51 = row.getCell(51)==null?"":row.getCell(51).toString();  
                String date64 = row.getCell(64)==null?"":row.getCell(64).toString();  
                String date67 = row.getCell(67)==null?"":row.getCell(67).toString();  
                String date68 = row.getCell(68)==null?"":row.getCell(68).toString();  
                String date71 = row.getCell(71)==null?"":row.getCell(71).toString();  
                String date72 = row.getCell(72)==null?"":row.getCell(72).toString();  
                String date75 = row.getCell(75)==null?"":row.getCell(75).toString();  
                String date76 = row.getCell(76)==null?"":row.getCell(76).toString();  
                String date79 = row.getCell(79)==null?"":row.getCell(79).toString();  
                String date80 = row.getCell(80)==null?"":row.getCell(80).toString();  
                String date83 = row.getCell(83)==null?"":row.getCell(83).toString();  
                String date84 = row.getCell(84)==null?"":row.getCell(84).toString();  
                String date87 = row.getCell(87)==null?"":row.getCell(87).toString();  
                String date88 = row.getCell(88)==null?"":row.getCell(88).toString();  

                if(!(date2.equalsIgnoreCase("undefined"))&&!(date2.equalsIgnoreCase(""))&&!(date2.equalsIgnoreCase("null"))){
                   
		     		     sqlDate2=ClsCommon.changeStringtoSqlDate3(date2);
		     		} 
    					 
          	  
          	  if(!(date11.equalsIgnoreCase("undefined"))&&!(date11.equalsIgnoreCase(""))&&!(date11.equalsIgnoreCase("null"))){
                
	     		     sqlDate11=ClsCommon.changeStringtoSqlDate3(date11);
	     		
					 }
	              
	              if(!(date27.equalsIgnoreCase("undefined"))  && !(date27.equalsIgnoreCase(""))&&!(date27.equalsIgnoreCase("null"))){
	             
		     		     sqlDate27=ClsCommon.changeStringtoSqlDate3(date27 );
		     		
					 }
	              
	              if(!(date46.equalsIgnoreCase(null))&&!(date46.equalsIgnoreCase(""))&&!(date46.equalsIgnoreCase("null"))){
	              
		     		     sqlDate46=ClsCommon.changeStringtoSqlDate3(date46);
		     		
					 }
	              if(!(date47.equalsIgnoreCase("undefined"))&&!(date47.equalsIgnoreCase(""))&&!(date47.equalsIgnoreCase("null"))){
		              
			     		     sqlDate47=ClsCommon.changeStringtoSqlDate3(date47);
			     		
						 }
	              
	              if(!(date48.equalsIgnoreCase("undefined"))&&!(date48.equalsIgnoreCase(""))&&!(date48.equalsIgnoreCase("null"))){
		              
			     		     sqlDate48=ClsCommon.changeStringtoSqlDate3(date48);
			     		
						 }
	              
	              
	              if(!(date51.equalsIgnoreCase("undefined"))&&!(date51.equalsIgnoreCase(""))&&!(date51.equalsIgnoreCase("null"))){
		              
			     		     sqlDate51=ClsCommon.changeStringtoSqlDate3(date51);
			     		
						 }
	              
	              if(!(date64.equalsIgnoreCase("undefined"))&&!(date64.equalsIgnoreCase(""))&&!(date64.equalsIgnoreCase("null"))){
	               
		     		     sqlDate64=ClsCommon.changeStringtoSqlDate3(date64);
		     		
					 }
	              
	              if(!(date67.equalsIgnoreCase("undefined"))&&!(date67.equalsIgnoreCase(""))&&!(date67.equalsIgnoreCase("null"))){
		              sqlDate67=ClsCommon.changeStringtoSqlDate3(date67);
			     		
						 }
	              
	              
	              
	              if(!(date68.equalsIgnoreCase("undefined"))&&!(date68.equalsIgnoreCase(""))&&!(date68.equalsIgnoreCase("null"))){
	               sqlDate68=ClsCommon.changeStringtoSqlDate3(date68);
		     		
					 }
	              
	             
	              if(!(date71.equalsIgnoreCase("undefined"))&&!(date71.equalsIgnoreCase(""))&&!(date71.equalsIgnoreCase("null"))){
	                  sqlDate71=ClsCommon.changeStringtoSqlDate3(date71);
		     		
					 }
	              
	              if(!(date72.equalsIgnoreCase("undefined"))&&!(date72.equalsIgnoreCase(""))&&!(date72.equalsIgnoreCase("null"))){
	               
		     		     sqlDate72=ClsCommon.changeStringtoSqlDate3(date72);
		     		
					 }
	              
	              
	              if(!(date75.equalsIgnoreCase("undefined"))&&!(date75.equalsIgnoreCase(""))&&!(date75.equalsIgnoreCase("null"))){
		               
			     		     sqlDate75=ClsCommon.changeStringtoSqlDate3(date75);
			     		
						 }
		              
		              if(!(date76.equalsIgnoreCase("undefined"))&&!(date76.equalsIgnoreCase(""))&&!(date76.equalsIgnoreCase("null"))){
		               
			     		     sqlDate76=ClsCommon.changeStringtoSqlDate3(date76);
			     		
						 }
		              
		              
		              if(!(date79.equalsIgnoreCase("undefined"))&&!(date79.equalsIgnoreCase(""))&&!(date79.equalsIgnoreCase("null"))){
			               
				     		     sqlDate79=ClsCommon.changeStringtoSqlDate3(date79);
				     		
							 }
			              
			              if(!(date80.equalsIgnoreCase("undefined"))&&!(date80.equalsIgnoreCase(""))&&!(date80.equalsIgnoreCase("null"))){
			              
				     		     sqlDate80=ClsCommon.changeStringtoSqlDate3(date80);
				     		
							 }
		              
			              if(!(date83.equalsIgnoreCase("undefined"))&&!(date83.equalsIgnoreCase(""))&&!(date83.equalsIgnoreCase("null"))){
				               
					     		     sqlDate83=ClsCommon.changeStringtoSqlDate3(date83);
					     		
								 }
			              if(!(date84.equalsIgnoreCase("undefined"))&&!(date84.equalsIgnoreCase(""))&&!(date84.equalsIgnoreCase("null"))){
			               
				     		     sqlDate84=ClsCommon.changeStringtoSqlDate3(date84);
				     		}
							 
			              
			              
			              if(!(date87 .equalsIgnoreCase("undefined"))&&!(date87 .equalsIgnoreCase("")) && !(date87.equalsIgnoreCase("null"))){
				               
					     		     sqlDate87=ClsCommon.changeStringtoSqlDate3(date87 );
					     		
								 }
			              if(!(date88.equalsIgnoreCase("undefined")) && !(date88 .equalsIgnoreCase("")) && !(date88 .equalsIgnoreCase("null"))){
			               
				     		     sqlDate88=ClsCommon.changeStringtoSqlDate3(date88 );
				     		
							 }
			              
			     			 //System.out.println("value==="+row.getCell(3).getNumericCellValue());

			              String sql1 ="select codeNo from im_employee where codeNo='"+codeno+"' ";
			              ResultSet rs1=stmt.executeQuery(sql1);
			              if(rs1.next())
			              {
				     			 System.out.println("Already Imported===");

			              }
 			              else if (!(name.equalsIgnoreCase("")))

			              {
			              
			     			 System.out.println("value==="+doc_no);  

			     			  String sql2 ="insert into im_employee"
			  				  		+ " (brhid, doc_no, date, codeNo, name, CASH_ADVANCE, BASIC_SALARY, HRA, TA, OTHERS, Total, dtjoin, acno, acc_curr, pmaddr, praddr, pmmob, prmob, pmemail, premail, CITY, STATE, PINCODE, NATIONALITY, religion, NEAREST, pob, DOB, dtype, nation, cmp, mstatus, GENDER, status, fatherName, motherName, bloodGroup, age, est_code, grpNo, spouseName, OTHER_DETAILS, curr, active, calendar, lAnnLeave, TER_DATE, DT_RJOIN, DT_LEV, timeSheet, curBrhId, dt_close, category, AGENT, BANK_ACCOUNT_NO, EMPLOYEE_ID, BRANCH_NAME, IFSC_CODE, desig, dept, pay_cat, travels, salary_paid, terminal_benefits, terminated_date, rdocno, DOC_IDNO_PASSPORT, PISSUEDATE, PEXPDATE, PPLACEOFISSUE, DOC_IDNO_VISA, VISSUEDATE, VEXPDATE, VPLACEOFISSUE, DOC_IDNO_EMIRATESID, EISSUEDATE, EEXPDATE, EPLACEOFISSUE, DOC_IDNO_LABOURCARD, LISSUEDATE, LEXPDATE, LPLACEOFISSUE, DOC_IDNO_LICENSE, LIISSUEDATE, LIEXPDATE, LIPLACEOFISSUE, DOC_IDNO_MEDICALCARD, MISSUEDATE, MEXPIRYDATE, MPLACEOFISSUE, BASIC_SALARY1, HRA1, TRANSPORATION_ALLOWANCE, FUEL_ALLOWANCE, OVERTIME_ALLOWANCE, OTHER_ALLOWANCE,CARALLOWANCE) values "
			  				  		+ "('"+brhid+"','"+doc_no+"',if('"+sqlDate2+"'='null',curdate(),'"+sqlDate2+"'),'"+codeno+"','"+name+"','"+cash_advance+"','"+basicsalary+"','"+hra+"','"+ta+"','"+others+"',"
			  				  		+ "'"+total+"','"+sqlDate11+"','"+acno+"','"+acc_curid+"','"+address+"','"+paddress+"','"+mobile+"','"+pmobile+"','"+email+"','"+pemail+"',"
			  				  	    + "'"+city+"','"+state+"','"+pincode+"','"+nationality+"','"+religion+"','"+nairport+"','"+pob+"','"+sqlDate27+"','"+dtype+"','"+nation+"',"
			  				  	    + "'"+cmpny+"','"+mstatus+"','"+gender+"','"+status+"','"+father+"','"+mother+"','"+bloodgrp+"','"+age+"','"+estcode+"','"+grpno+"',"
			  				  	    + "'"+spouse+"','"+otherdetail+"','"+curid+"','"+active+"','"+calender+"','"+lannleave+"','"+sqlDate46+"','"+sqlDate47+"','"+sqlDate48+"','"+timesheet+"',"
			  				  	    + "'"+curbrhid+"','"+sqlDate51+"','"+categ+"','"+agent+"','"+bank_acc+"','"+employee_id+"','"+branch_name+"','"+ifsccode+"','"+desc+"','"+dept+"',"
			  				  	    + "'"+pay_cat+"','"+travels+"','"+salary_paid+"','"+terminalbenefit+"','"+sqlDate64+"','"+rdocno+"','"+pdocno+"','"+sqlDate67+"','"+sqlDate68+"','"+pplace+"',"
			  				  	    + "'"+vdocno+"','"+sqlDate71+"','"+sqlDate72+"','"+vplace+"','"+edocno+"','"+sqlDate75+"','"+sqlDate76+"','"+eplace+"','"+ldocno+"','"+sqlDate79+"',"
			  				  	    + "'"+sqlDate80+"','"+lplace+"','"+lidocno+"','"+sqlDate83+"','"+sqlDate84+"','"+liplace+"','"+mdocno+"','"+sqlDate87+"','"+sqlDate88+"','"+mplace+"',"
			  				  	    + "'"+basicsalary1+"','"+hra1+"','"+ta1+"','"+fa1+"','"+ot1+"','"+otherallowance+"','"+carallowance+"')";
			  				 
			  			 
				  System.out.println("sql2=======>"+sql2);
				  pstm = conn.prepareStatement(sql2);
				  pstm.execute();
				  
				  
				  
				  
			              }           
            
            }
			  	         //dao.employeeListinsertions();
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

