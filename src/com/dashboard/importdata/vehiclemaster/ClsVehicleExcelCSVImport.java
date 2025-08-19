package com.dashboard.importdata.vehiclemaster;

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

public class ClsVehicleExcelCSVImport {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
ClsIMVehicleDAO dao=new ClsIMVehicleDAO();
	
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
	        
			String sql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='VHM'";

			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
			
			
			
			BufferedReader br = new BufferedReader(new FileReader(path));
			
			int i=0;
			
            while ((line = br.readLine()) != null) {

            	if(i>0) {
            		
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

	                // use comma as separator
	                String[] journal = line.split(cvsSplitBy);
	                        
for(String n:journal)
{
	System.out.println("values"+n);
}
	            	  if(!(journal[2].equalsIgnoreCase("undefined"))&&!(journal[2].equalsIgnoreCase(""))&&!(journal[2].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[2]))
					 {
				     		     sqlDate2=ClsCommon.changeStringtoSqlDate3(journal[2]);
					 }  
					 }
	            	  
	            	  if(!(journal[11].equalsIgnoreCase("undefined"))&&!(journal[11].equalsIgnoreCase(""))&&!(journal[11].equalsIgnoreCase("0"))){
                      if(isValidFormat("d/M/yyyy",journal[11]))
						 {
				     		     sqlDate11=ClsCommon.changeStringtoSqlDate3(journal[11]);
				     		} 
						 }
		              
		              if(!(journal[27].equalsIgnoreCase("undefined"))&&!(journal[27].equalsIgnoreCase(""))&&!(journal[27].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[27]))
						 {
			     		     sqlDate27=ClsCommon.changeStringtoSqlDate3(journal[27]);
			     		}
						 }
		              
		              if(!(journal[46].equalsIgnoreCase("undefined"))&&!(journal[46].equalsIgnoreCase(""))&&!(journal[46].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[46]))
						 {
			     		     sqlDate46=ClsCommon.changeStringtoSqlDate3(journal[46]);
			     		}
						 }
		              if(!(journal[47].equalsIgnoreCase("undefined"))&&!(journal[47].equalsIgnoreCase(""))&&!(journal[47].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[47]))
							 {
				     		     sqlDate47=ClsCommon.changeStringtoSqlDate3(journal[47]);
				     		}
							 }
		              
		              if(!(journal[48].equalsIgnoreCase("undefined"))&&!(journal[48].equalsIgnoreCase(""))&&!(journal[48].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[48]))
							 {
				     		     sqlDate48=ClsCommon.changeStringtoSqlDate3(journal[48]);
				     		}
							 }
		              
		              
		              if(!(journal[51].equalsIgnoreCase("undefined"))&&!(journal[51].equalsIgnoreCase(""))&&!(journal[51].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[51]))
							 {
				     		     sqlDate51=ClsCommon.changeStringtoSqlDate3(journal[51]);
				     		}
							 }
		              
		              if(!(journal[64].equalsIgnoreCase("undefined"))&&!(journal[64].equalsIgnoreCase(""))&&!(journal[64].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[64]))
						 {
			     		     sqlDate64=ClsCommon.changeStringtoSqlDate3(journal[64]);
			     		}
						 }
		              System.out.println("64"+journal[64]+"65"+journal[65]+"66"+journal[66]+"67"+journal[67]);
		              if(!(journal[67].equalsIgnoreCase("undefined"))&&!(journal[67].equalsIgnoreCase(""))&&!(journal[67].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[67]))
							 {
				     		     sqlDate67=ClsCommon.changeStringtoSqlDate3(journal[67]);
				     		}
							 }
		              
		              
		              
		              if(!(journal[68].equalsIgnoreCase("undefined"))&&!(journal[68].equalsIgnoreCase(""))&&!(journal[68].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[68]))
						 {
			     		     sqlDate68=ClsCommon.changeStringtoSqlDate3(journal[68]);
			     		}
						 }
		              
		             
		              if(!(journal[71].equalsIgnoreCase("undefined"))&&!(journal[71].equalsIgnoreCase(""))&&!(journal[71].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[71]))
						 {
			     		     sqlDate71=ClsCommon.changeStringtoSqlDate3(journal[71]);
			     		}
						 }
		              
		              if(!(journal[72].equalsIgnoreCase("undefined"))&&!(journal[72].equalsIgnoreCase(""))&&!(journal[72].equalsIgnoreCase("0"))){
		              if(isValidFormat("d/M/yyyy",journal[72]))
						 {
			     		     sqlDate72=ClsCommon.changeStringtoSqlDate3(journal[72]);
			     		}
						 }
		              
		              
		              if(!(journal[75].equalsIgnoreCase("undefined"))&&!(journal[75].equalsIgnoreCase(""))&&!(journal[75].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[75]))
							 {
				     		     sqlDate75=ClsCommon.changeStringtoSqlDate3(journal[75]);
				     		}
							 }
			              
			              if(!(journal[76].equalsIgnoreCase("undefined"))&&!(journal[76].equalsIgnoreCase(""))&&!(journal[76].equalsIgnoreCase("0"))){
			              if(isValidFormat("d/M/yyyy",journal[76]))
							 {
				     		     sqlDate76=ClsCommon.changeStringtoSqlDate3(journal[76]);
				     		}
							 }
			              
			              
			              if(!(journal[79].equalsIgnoreCase("undefined"))&&!(journal[79].equalsIgnoreCase(""))&&!(journal[79].equalsIgnoreCase("0"))){
				              if(isValidFormat("d/M/yyyy",journal[79]))
								 {
					     		     sqlDate79=ClsCommon.changeStringtoSqlDate3(journal[79]);
					     		}
								 }
				              
				              if(!(journal[80].equalsIgnoreCase("undefined"))&&!(journal[80].equalsIgnoreCase(""))&&!(journal[80].equalsIgnoreCase("0"))){
				              if(isValidFormat("d/M/yyyy",journal[80]))
								 {
					     		     sqlDate80=ClsCommon.changeStringtoSqlDate3(journal[80]);
					     		}
								 }
			              
				              if(!(journal[83].equalsIgnoreCase("undefined"))&&!(journal[83].equalsIgnoreCase(""))&&!(journal[83].equalsIgnoreCase("0"))){
					              if(isValidFormat("d/M/yyyy",journal[83]))
									 {
						     		     sqlDate83=ClsCommon.changeStringtoSqlDate3(journal[83]);
						     		}
									 }
				              if(!(journal[84].equalsIgnoreCase("undefined"))&&!(journal[84].equalsIgnoreCase(""))&&!(journal[84].equalsIgnoreCase("0"))){
				              if(isValidFormat("d/M/yyyy",journal[84]))
								 {
					     		     sqlDate84=ClsCommon.changeStringtoSqlDate3(journal[84]);
					     		}
								 }
				              
				              
				              if(!(journal[87].equalsIgnoreCase("undefined"))&&!(journal[87].equalsIgnoreCase(""))&&!(journal[87].equalsIgnoreCase("0"))){
					              if(isValidFormat("d/M/yyyy",journal[87]))
									 {
						     		     sqlDate87=ClsCommon.changeStringtoSqlDate3(journal[87]);
						     		}
									 }
				              if(!(journal[88].equalsIgnoreCase("undefined"))&&!(journal[88].equalsIgnoreCase(""))&&!(journal[88].equalsIgnoreCase("0"))){
				              if(isValidFormat("d/M/yyyy",journal[88]))
								 {
					     		     sqlDate88=ClsCommon.changeStringtoSqlDate3(journal[88]);
					     		}
								 }
		              
				              
				              
				              String sql1 ="select codeNo from im_employee where codeNo='"+journal[3]+"' ";
				              ResultSet rs1=stmt.executeQuery(sql1);
				              if(rs1.next())
				              {
					     			 System.out.println("Already Imported===");
 
				              }
				              else
				              {
				              
				     			 System.out.println("value==="+journal[3]);

					  String sql2 ="insert into im_employee"
					  		+ " (brhid, doc_no, date, codeNo, name, CASH_ADVANCE, BASIC_SALARY, HRA, TA, OTHERS, Total, dtjoin, acno, acc_curr, pmaddr, praddr, pmmob, prmob, pmemail, premail, CITY, STATE, PINCODE, NATIONALITY, religion, NEAREST, pob, DOB, dtype, nation, cmp, mstatus, GENDER, status, fatherName, motherName, bloodGroup, age, est_code, grpNo, spouseName, OTHER_DETAILS, curr, active, calendar, lAnnLeave, TER_DATE, DT_RJOIN, DT_LEV, timeSheet, curBrhId, dt_close, category, AGENT, BANK_ACCOUNT_NO, EMPLOYEE_ID, BRANCH_NAME, IFSC_CODE, desig, dept, pay_cat, travels, salary_paid, terminal_benefits, terminated_date, rdocno, DOC_IDNO_PASSPORT, PISSUEDATE, PEXPDATE, PPLACEOFISSUE, DOC_IDNO_VISA, VISSUEDATE, VEXPDATE, VPLACEOFISSUE, DOC_IDNO_EMIRATESID, EISSUEDATE, EEXPDATE, EPLACEOFISSUE, DOC_IDNO_LABOURCARD, LISSUEDATE, LEXPDATE, LPLACEOFISSUE, DOC_IDNO_LICENSE, LIISSUEDATE, LIEXPDATE, LIPLACEOFISSUE, DOC_IDNO_MEDICALCARD, MISSUEDATE, MEXPIRYDATE, MPLACEOFISSUE, BASIC_SALARY1, HRA1, TRANSPORATION_ALLOWANCE, FUEL_ALLOWANCE, OVERTIME_ALLOWANCE, OTHER_ALLOWANCE,CARALLOWANCE) values "
					  		+ "('"+journal[0]+"','"+journal[1]+"','"+sqlDate2+"','"+journal[3]+"','"+journal[4]+"','"+journal[5]+"','"+journal[6]+"','"+journal[7]+"','"+journal[8]+"','"+journal[9]+"',"
					  		+ "'"+journal[10]+"','"+sqlDate11+"','"+journal[12]+"','"+journal[13]+"','"+journal[14]+"','"+journal[15]+"','"+journal[16]+"','"+journal[17]+"','"+journal[18]+"','"+journal[19]+"',"
					  	    + "'"+journal[20]+"','"+journal[21]+"','"+journal[22]+"','"+journal[23]+"','"+journal[24]+"','"+journal[25]+"','"+journal[26]+"','"+sqlDate27+"','"+journal[28]+"','"+journal[29]+"',"
					  	    + "'"+journal[30]+"','"+journal[31]+"','"+journal[32]+"','"+journal[33]+"','"+journal[34]+"','"+journal[35]+"','"+journal[36]+"','"+journal[37]+"','"+journal[38]+"','"+journal[39]+"',"
					  	    + "'"+journal[40]+"','"+journal[41]+"','"+journal[42]+"','"+journal[43]+"','"+journal[44]+"','"+journal[45]+"','"+sqlDate46+"','"+sqlDate47+"','"+sqlDate48+"','"+journal[49]+"' ,"
					  	    + "'"+journal[50]+"','"+sqlDate51+"','"+journal[52]+"','"+journal[53]+"','"+journal[54]+"','"+journal[55]+"','"+journal[56]+"','"+journal[57]+"','"+journal[58]+"','"+journal[59]+"',"
					  	    + "'"+journal[60]+"','"+journal[61]+"','"+journal[62]+"','"+journal[63]+"','"+sqlDate64+"','"+journal[65]+"','"+journal[66]+"','"+sqlDate67+"','"+sqlDate68+"','"+journal[69]+"',"
					  	    + "'"+journal[70]+"','"+sqlDate71+"','"+sqlDate72+"','"+journal[73]+"','"+journal[74]+"','"+sqlDate75+"','"+sqlDate76+"','"+journal[77]+"','"+journal[78]+"','"+sqlDate79+"',"
					  	    + "'"+sqlDate80+"','"+journal[81]+"','"+journal[82]+"','"+sqlDate83+"','"+sqlDate84+"','"+journal[85]+"','"+journal[86]+"','"+sqlDate87+"','"+sqlDate88+"','"+journal[89]+"',"
					  	    + "'"+journal[90]+"','"+journal[91]+"','"+journal[92]+"','"+journal[93]+"','"+journal[94]+"','"+journal[95]+"','"+journal[96]+"') ";
					 
					  System.out.println("sql2=======>"+sql2);
					  pstm = conn.prepareStatement(sql2);
					  pstm.execute();
					  
					  
					  
					  
					  
					  
					  
					  
				              }
					 
            	}
            	
                i++;
            }
	        //dao.vehicleListinsertions();

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
		 dao.vehicleListGridLoading(); 
		 conn.close();
	 }
		return 0;
	}

}

