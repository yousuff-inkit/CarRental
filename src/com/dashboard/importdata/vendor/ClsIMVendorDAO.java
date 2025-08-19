package com.dashboard.importdata.vendor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIMVendorDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray vendorListGridLoading() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			     
			     
		    	String sql3 = "select * from im_vendor";
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

	public JSONArray categoryGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select '' category, UPPER(veh.category) cat_name, '' account, '' accdoc from im_vendor veh left join my_clcatm au on UPPER(veh.category)=UPPER(au.cat_name) and au.dtype='VND' and au.status<>7 where   au.doc_no is null and veh.category!='')a group by cat_name";  
		    	  //System.out.println("cat============="+sql3);   
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
	
	public JSONArray cataccemployee() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select description,doc_no from my_head where m_s='1' and den='255' and atype='AP'");  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	
	
	
	public JSONArray employeeListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 int status1=0;
			 	int stat=0;
			 	 String  str="",str1="",str2="",str3="",str4="",str5="",str6="";  
			
			 	 str3="insert into my_clcatm( DOC_NO, CATEGORY, CAT_NAME, acc_group, approval, disper, dfact, ulevel, dtype, date, STATUS, pricegroup) "
					 		+ "select  @doc_no:=@doc_no+1,upper(category) category ,upper(category) cat_name ,1014 acc_group,0 approval,0.0000,0.0000,0,'VND',curdate(),3,0 from "
					 		+ "(select distinct trim(e.category) category from im_VENDOR e left join my_clcatm  d on trim(d.category)=trim(e.category) where e.category!='' and d.doc_no is null  ) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_clcatm))b";
					 System.out.println("str3============="+str3);
					
			 	 
				 str1="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
					 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
					 		+ "grplevel, gr_type, agroup, lApply, cmpid) "
					 		+ "select  1 brhid, REFNAME,0 M_S,255 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
					 		+ "curdate() date,'AP' ATYPE,@cldocno:=@cldocno+1,@doc_no:=@doc_no, "
					 		+ "'VND' dtype,concat('.',acc_group,'.',@doc_no),acc_group grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid from (select distinct refname,d.acc_group from  im_vendor e left join my_head h on trim(h.description)=trim(e.refname) and h.den=255 left join my_clcatm  d on trim(d.category)=trim(e.category) where e.refname!='' and h.doc_no is null)a ,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b ,(select  @cldocno:=(select coalesce(max(cldocno),0) cldocno from my_head  where DEN=255))c  ";
					 System.out.println("str1============="+str1);

				
				 
				 
				 str2="insert into my_acbook(cldocno, RefName,address,com_mob, per_mob,opt_mob,area,area_id,  doc_no, atype, acno,fax1,fax2,web1,mail1,"
				 		+ "codeno, dtype,  date,curId,contactperson,  catid, brhid, cmpid,taxid, acc_group,  status,TAX,NONTAX,TRNNUMBER,TYPE,"
				 		+ "old_docno,SAL_ID) "
				 		+ "select h.cldocno,h.description ,address,per_mob, per_mob,opt_mob,areaname,a.doc_no, h.cldocno,1,h.doc_no,fax1,fax2,web1,mail1,"
				 		+ "h.cldocno,'VND',curdate(),1,contactperson,m.doc_no CATID,1,1,1 TAXID, m.acc_group,3,1,if(nontax='',0,nontax) nontax,TRNnumber,1,id,1 sal_id from im_vendor b "
				 		+ " left join my_head h on trim(h.description)=trim(b.refname) and h.den=255 "
				 		+ " left join my_area a on trim(a.area)=trim(b.areaname)"
				 		+ "left join my_clcatm m on trim(m.category)=trim(b.category) ";
				 System.out.println("str2============="+str2);
				 stmtEMP1.executeUpdate(str3);

				 stmtEMP1.executeUpdate(str1);
				 stmtEMP1.executeUpdate(str2);
				

	//conn.commit();
	System.out.println("Committ****");
	String sql3 = "select * from im_vendor";
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
	
	
	
}
