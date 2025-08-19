package com.dashboard.importdata.driver;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIMDriverDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray driverGridLoading() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			        
			     
		    	String sql3 = "select * from im_driver";
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			    // System.out.println("sql3============="+sql3);
		    	    RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }

	
	public JSONArray driverListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 
			 	
			 	 
			 	 String  str1="";  
			
			 	 str1="insert into gl_drdetails (dr_id, NAME,Branch,NATION, MOBNO, DLNO, ISSFRM, ISSDATE, DOB, DOC_NO,ltype, "
                        +"cldocno,PASSPORT_NO, pass_exp,visano,visa_exp,   dtype,sr_no) "  
                        + "  select @dr_id:=@dr_id+1,drivername,1,nationality,mobileno,dlno,licenseissuedfrom,licenseissueddate,dob,doc_no,licensetype,doc_no,passportno,passportexpiry,idno,idexpiry,dtype,srno from"
                        + "(select distinct drivername,1,d.nationality,d.mobileno,d.dlno,d.licenseissuedfrom,d.licenseissueddate,d.dob, "
                        + "c.doc_no,d.licensetype,d.passportno,d.passportexpiry,d.idno,d.idexpiry,'CRM' dtype,d.srno from im_driver d "
                        + "left join my_acbook c on d.clientdocno=c.cldocno left join gl_drdetails g on g.name=d.drivername where g.dr_id is null and d.drivername!='' )h,(select @dr_id:=(select coalesce(max(dr_id),0) dr_id from gl_drdetails)) b ";
                        					 System.out.println("str1============="+str1);     
					 
    
				 stmtEMP1.executeUpdate(str1);
				

	//conn.commit();
	System.out.println("Committ****");
	String sql3 = "select * from im_driver";
    ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
   // System.out.println("sql3============="+sql3);
	    RESULTDATA=ClsCommon.convertToJSON(resultSet3);


stmtEMP.close();
stmtEMP1.close();

			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
	public JSONArray nationGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	String sql3 = "select a.* from(select UPPER(veh.nationality) nationality  from im_driver veh left join my_natm au on UPPER(veh.nationality)=UPPER(au.nation)  where au.doc_no is null and veh.nationality!='')a group by nationality"; 
			 	 System.out.println("nation============="+sql3); 
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();  
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
   }
	
	
}
