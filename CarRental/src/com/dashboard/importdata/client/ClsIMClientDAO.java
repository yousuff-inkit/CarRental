package com.dashboard.importdata.client;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIMClientDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray clientListGridLoading() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			     
			     
		    	String sql3 = "select * from im_client";
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

	public JSONArray salesmanGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.salesman) sal_name, '' sal_id, '' account, '' accdoc from im_client veh left join my_salm au on UPPER(veh.salesman)=UPPER(au.sal_name) and au.status=3 where au.doc_no is null and veh.salesman!='')a group by sal_name"; 
			 	 System.out.println("salesman============="+sql3); 
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
	
	   
	public JSONArray categoryGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select '' category, UPPER(veh.category) cat_name, '' account, '' accdoc from im_client veh left join my_clcatm au on UPPER(veh.category)=UPPER(au.cat_name) and au.status=3 and au.dtype='CRM' where au.doc_no is null and veh.category!='')a group by cat_name";  
		    	  System.out.println("cat============="+sql3);   
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
	
	public JSONArray areaGrid() throws SQLException {  
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select UPPER(veh.areaname) area, '' area_id, '' zone, '' region, '' po_box from im_client veh left join my_area au on UPPER(veh.areaname)=UPPER(au.area) where au.doc_no is null and veh.areaname!='')a group by area";  
		    	  System.out.println("area============="+sql3);   
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
			 	 String str1="",str2="",str3="",str4="",str5="",str6="";  
				 str1="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
				 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
				 		+ "grplevel, gr_type, agroup, lApply, cmpid) "
				 		+ "select  1 brhid, salesman,0 M_S,340 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
				 		+ "curdate() date,'AR' ATYPE,0,@doc_no:=@doc_no , "
				 		+ "'CRM' dtype,concat('.',1081,'.',@doc_no),1081 grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid from (select distinct(salesman) salesman from im_client e left join my_head h on trim(h.description)=trim(e.salesman) and h.den=301 where e.salesman!='' and h.doc_no is null) a,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b ";
				 System.out.println("str1============="+str1);

				 
				 str2="insert into my_salm(SAL_ID, SAL_NAME, COMM, ACC_NO, TARGET, MOB_NO, DOC_NO, DATE, status, type, typeId, mail, salesuserlink,userid, catid, usgper)  "
				 		+ "select @sal_id:=@sal_id+1, description,0.00 COMM, h.doc_no,0 TARGET,'' MOB_NO, @doc_no:=@doc_no+1,curdate() DATE,3 status, "
				 		+ "null type,0 typeId,'' mail,null salesuserlink,0 userid,null catid,0 usgper from (select distinct trim(h.description) description, h.doc_no  from  im_client a  left join my_head h   on  trim(h.description)=trim(a.salesman) where h.doc_no is  null) h,(select @sal_id:=(select coalesce(max(sal_id),0) sal_id from my_salm)) b,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_salm)) c";
				 System.out.println("str2============="+str2);

			
				 str3="insert into my_clcatm( DOC_NO, CATEGORY, CAT_NAME, acc_group, approval, disper, dfact, ulevel, dtype, date, STATUS, pricegroup) "
				 		+ "select  @doc_no:=@doc_no+1,upper(category) category ,upper(category) cat_name ,1005 acc_group,0 approval,0.0000,0.0000,0,'CRM',curdate(),3,0 from "
				 		+ "(select distinct trim(e.category) category from im_client e left join my_clcatm  d on trim(d.category)=trim(e.category) where e.category!='' and d.doc_no is null  ) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_clcatm))b";
				 System.out.println("str3============="+str3);
				 
				 
				 str4="insert into my_area( doc_no, Area, reg_id, PO_Box, date, status, city_id, country_id) "
					 		+ "select @doc_no:=@doc_no+1,upper(areaname) area ,0,0,curdate(),3,0,0 from "
					 		+ "(select distinct trim(areaname) areaname from im_client e left join my_area  d on trim(d.area)=trim(e.areaname) where e.areaname!='' and d.doc_no is null  ) a,(select @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_area))b";
					 System.out.println("str4============="+str4);

			//			conn.setAutoCommit(false);

				 str5="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
					 		+ "date, atype, cldocno,Account, dtype, alevel, grpno, "
					 		+ "grplevel, gr_type, agroup, lApply, cmpid) "
					 		+ "select  1 brhid, REFNAME,0 M_S,340 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
					 		+ "curdate() date,'AR' ATYPE,@cldocno:=@cldocno+1,@doc_no:=@doc_no, "
					 		+ "'CRM' dtype,concat('.',acc_group,'.',@doc_no),acc_group grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid from (select distinct refname,d.acc_group from  im_client e left join my_head h on trim(h.description)=trim(e.refname) and h.den=340 left join my_clcatm  d on trim(d.category)=trim(e.category) where e.refname!='' and h.doc_no is null)a ,(select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b ,(select  @cldocno:=(select coalesce(max(cldocno),0) cldocno from my_head  where dtype='crm'))c  ";
					 System.out.println("str5============="+str5);

				
				 
				 
				 str6="insert into my_acbook(cldocno, RefName,address,com_mob, per_mob,opt_mob,area,area_id,  doc_no, atype, acno,fax1,fax2,web1,mail1,"
				 		+ "codeno, dtype,  date,curId,contactperson,  catid, brhid, cmpid,taxid, acc_group,  status,TAX,NONTAX,TRNNUMBER,TYPE,"
				 		+ "old_docno,SAL_ID) "
				 		+ "select h.cldocno,h.description ,address,per_mob, per_mob,opt_mob,areaname,a.doc_no, h.cldocno,1,h.doc_no,fax1,fax2,web1,mail1,"
				 		+ "h.cldocno,'CRM',curdate(),1,contactperson,m.doc_no CATID,1,1,1 TAXID, m.acc_group,3,1,if(nontax='',0,nontax) nontax,TRNnumber,1,id,s.doc_no sal_id from im_client b "
				 		+ " left join my_head h on trim(h.description)=trim(b.refname) and h.den=340 "
				 		+ " left join my_area a on trim(a.area)=trim(b.areaname)"
				 		+ " left join my_salm s on trim(s.sal_name)=trim(b.salesman)"
				 		+ "left join my_clcatm m on trim(m.category)=trim(b.category) ";
				 System.out.println("str6============="+str6);

				 stmtEMP1.executeUpdate(str1);
				 stmtEMP1.executeUpdate(str2);
				 stmtEMP1.executeUpdate(str3);
				 stmtEMP1.executeUpdate(str4);
				 stmtEMP1.executeUpdate(str5);
				 stmtEMP1.executeUpdate(str6);   	


		

	//conn.commit();
	System.out.println("Committ****");
	String sql3 = "select * from im_client";
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
	
	public JSONArray accemployee() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select doc_no,description,account acno from my_head where m_s=0 and den=301");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray cataccemployee() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select description,doc_no from my_head where m_s='1' and den=340");  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	
}
