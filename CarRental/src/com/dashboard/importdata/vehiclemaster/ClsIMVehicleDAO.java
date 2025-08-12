package com.dashboard.importdata.vehiclemaster;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIMVehicleDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray vehicleListGridLoading() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select * from im_vehicle";
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }

	public JSONArray authorityGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
		    	 String sql3 = "select a.* from(select UPPER(veh.authority) authority, '' code from im_vehicle veh left join gl_vehauth au on TRIM(UPPER(veh.authority))=TRIM(UPPER(au.authname)) and au.status=3 where au.doc_no is null and veh.authority!='')a group by authority";  
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
	public JSONArray platecodeGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.platecode) platecode, UPPER(veh.platecode) name, va.doc_no authid, va.authname auth from im_vehicle veh left join gl_vehauth va on TRIM(UPPER(veh.authority))=TRIM(UPPER(va.authname)) left join gl_vehplate au on TRIM(UPPER(au.code_name))=TRIM(UPPER(veh.platecode)) and au.status=3 where au.doc_no is null and veh.platecode!='')a group by platecode"; 
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
    }
	
	public JSONArray brandGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.brand_name) brand from im_vehicle veh left join gl_vehbrand au on TRIM(UPPER(veh.brand_name))=TRIM(UPPER(au.brand_name)) and au.status=3 where au.doc_no is null and veh.brand_name!='')a group by brand";  
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
    }
	
	public JSONArray modelGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.model) model, br.brand_name brand, br.doc_no brdid from im_vehicle veh left join gl_vehbrand br on TRIM(UPPER(veh.brand_name))=TRIM(UPPER(br.brand_name)) left join gl_vehmodel au on TRIM(UPPER(veh.model))=TRIM(UPPER(au.vtype)) and au.status=3 where au.doc_no is null and veh.model!='')a group by model";  
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
   }
	
	public JSONArray yomGrid() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.yom) yom from im_vehicle veh left join gl_yom au on TRIM(UPPER(veh.yom))=TRIM(UPPER(au.yom)) where au.doc_no is null and veh.yom!='')a group by yom";  
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
  }
	
	public JSONArray colorGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select UPPER(veh.color) color from im_vehicle veh left join my_color au on TRIM(UPPER(veh.color))=TRIM(UPPER(au.color)) and au.status=3 where au.doc_no is null and veh.color!='')a group by color";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     //System.out.println("sql3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
 }
	
	public JSONArray groupGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.group_name,au.Gid groupid  from im_vehicle veh left join gl_vehgroup au on TRIM(UPPER(veh.group_name))=TRIM(UPPER(au.gname)) and au.status=3 where au.doc_no is null and veh.group_name!='')a group by group_name";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     System.out.println("grp1============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}
	
	public JSONArray specificationGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.spec from im_vehicle veh left join gl_vehspec au on TRIM(UPPER(veh.spec))=TRIM(UPPER(au.name)) and au.status=3 where au.doc_no is null and veh.spec!='')a group by spec";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     System.out.println("spec2============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}	
	
	public JSONArray projectGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.project,'' client,'' cldocno from im_vehicle veh left join gl_project au on TRIM(UPPER(veh.project))=TRIM(UPPER(au.project_name)) and au.status=3 where au.doc_no is null and veh.project!='')a group by project";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			    System.out.println("pro3============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}	
	
	public JSONArray dealerGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.dealer from im_vehicle veh left join my_vendorm au on TRIM(UPPER(veh.dealer))=TRIM(UPPER(au.name)) and au.status=3 where au.doc_no is null and veh.dealer!='')a group by dealer";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     System.out.println("del4============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}	

	public JSONArray insuranceGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.ins_type  from im_vehicle veh left join gl_vehin au on TRIM(UPPER(veh.ins_type))=TRIM(UPPER(au.inname)) and au.status=3 where au.doc_no is null and veh.ins_type!='')a group by ins_type";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			    System.out.println("ins5============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}
	
	public JSONArray financeGrid() throws SQLException {        
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 String sql3 = "select a.* from(select veh.financier from im_vehicle veh left join gl_vehfin au on TRIM(UPPER(veh.financier))=TRIM(UPPER(au.fname)) and au.status=3 where au.doc_no is null and veh.financier!='')a group by financier";     
			 	 ResultSet resultSet3 = stmtEMP.executeQuery(sql3);   
			     System.out.println("fin6============="+sql3);   
		    	 RESULTDATA=ClsCommon.convertToJSON(resultSet3);

			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
}
	
	public JSONArray accclient() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
				ResultSet resultSet = stmt.executeQuery ("select cldocno,refname  from my_acbook where dtype='CRM' and status=3");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }
	
	public JSONArray vehicleListinsertions() throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

			java.sql.PreparedStatement pstm = null ;

		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			 	 Statement stmtEMP1 = conn.createStatement();

			 	 int status1=0;
			 	int stat=0;
			 	 String str1="",str2="",str3="",str4="",str5="",str6="",str7="",str8="",str9="",str10="",str11="",str12="",str13="",str14="",str15="",str16="";  
		 str1=   "insert into gl_vehbrand(BRAND, BRAND_NAME,  DATE, STATUS)"
                +"SELECT distinct A.brand_name,A.brand_name,curdate(),3 FROM im_vehicle A "
                + "LEFT JOIN GL_veHMASTER A1 ON a.REG_NO=A1.REG_NO "
                + "left join gl_vehbrand b on a.brand_name=b.brand "
                + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.brand_name!='' ";
				 System.out.println("str1============="+str1);

				 
				 str2=  "insert into gl_vehmodel(VTYPE,  DATE, BRANDID, STATUS, ref_modelid) "
				         + "SELECT distinct A.model,curdate(),b.doc_no,3,0 FROM im_vehicle A "
				         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				         + "left join gl_vehbrand b on a.brand_name=b.brand "
				         + "left join gl_vehmodel m on a.model=m.vtype "
				         + "WHERE A1.REG_NO IS NULL and m.doc_no is null and a.model!='' ";


				        System.out.println("str2============="+str2);

			
				 str3=  "insert into gl_vehgroup(GID, GNAME, date,  status) "
				         + "SELECT distinct A.group_name,A.group_name,curdate(),3 FROM im_vehicle A "
				         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				         + "left join gl_vehgroup b on b.gname=a.group_name "
				         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.group_name!=''";

				       System.out.println("str3============="+str3);
				 
				 
				 str4=  " insert into gl_yom( yom ) "
				         + "SELECT distinct A.yom FROM im_vehicle A "
				         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO "
				         + "left join gl_yom b on b.yom=a.yom "
				         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.yom!='' ";
				          System.out.println("str4============="+str4);

				            stmtEMP1.executeUpdate(str1);
			                 stmtEMP1.executeUpdate(str2);
			                 stmtEMP1.executeUpdate(str3);
			                 stmtEMP1.executeUpdate(str4);
			                    
				  str5=" insert into gl_vehauth(AUTHID, AUTHNAME, DATE, STATUS)"
				        + "SELECT distinct SUBSTRING(a.authority, 1, 3),A.authority,curdate(),3 FROM im_vehicle A"
				        + " LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO "
				        + " left join gl_vehauth b on b.authname=a.authority "
				        + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.authority!=''";
                  System.out.println("str5============="+str5);

                  stmtEMP1.executeUpdate(str5);

				   str6="insert into gl_vehplate(CODE_NO, CODE_NAME, DATE, AUTH_ID, AUTH_NME, AUTHID, STATUS)"
				        + "SELECT distinct A.platecode,A.platecode,curdate(),va.doc_no,va.authname,va.doc_no,3 FROM im_vehicle A "
				        + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				        + "left join gl_vehauth va on va.authname=a.authority  "
				        + "left join gl_vehplate b on b.code_name=a.platecode "
				        + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.platecode!=''";
                   System.out.println("str6============="+str6);

                   stmtEMP1.executeUpdate(str6);
     
				   
				       str7="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
				             +"  date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
				             +"  select  1 brhid, dealer,1 M_S,255 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
				             +"  curdate() date,'AP' ATYPE,0,@doc_no, 'GEN' dtype,concat('.',(select doc_no from my_head where den=255 and m_s=1 limit 1),'.',@doc_no),"
				             +"  (select doc_no from my_head where den=255 and m_s=1 limit 1) grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid "
				             +"  from im_vehicle e left join my_head h on h.description=trim(e.dealer) and h.den=255  , "
				             +"  (select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where e.dealer!='' and h.doc_no is null ";
                       System.out.println("str7============="+str7);
  
				       stmtEMP1.executeUpdate(str7);


				   str8="insert into my_vendorm( name,date,status)SELECT distinct a.dealer,curdate(),3 FROM im_vehicle A "
				          + "left join  my_head H on H.description=a.dealer and h.atype='AP' "
				          + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				          + "left join my_vendorm b on b.name=a.dealer "
				          + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.dealer!='' ";
                   System.out.println("str8============="+str8);

				 stmtEMP1.executeUpdate(str8);
				 
				
                   str9="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
                        +"   date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
                        +"    select  1 brhid, financier,1 M_S,612 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
                        +"    curdate() date,'GL' ATYPE,0,@doc_no, 'GEN' dtype,concat('.',(select doc_no from my_head where den=612 and m_s=1 limit 1),'.',@doc_no),"
                        +"  (select doc_no from my_head where den=612 and m_s=1 limit 1) grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid "
                        +"   from im_vehicle e left join my_head h on h.description=trim(e.financier) and h.den=612 , "
                        +"   (select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where e.financier!='' and h.doc_no is null";  
                   System.out.println("str9============="+str9);

            //       stmtEMP1.executeUpdate(str9);

                 
                 str10=" insert into gl_vehfin(FID, FNAME, DATE, ACC_NO,status)SELECT distinct SUBSTRING(a.financier, 1, 3),a.financier,curdate(),h.doc_no,3 FROM im_vehicle A "
                         + "left join  my_head H on H.description=a.financier and h.atype='GL' "
                         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO "
                         + " left join gl_vehfin b on b.fname=a.financier "
                         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.financier!=''";
                 System.out.println("str10============="+str10);

               
			//	 stmtEMP1.executeUpdate(str10);
				 
				 str11="insert into my_head(brhid, Description, M_S, DEN, CURID, RATE, DR, TR_NO, cflow, DOC_NO, "
				       +" date, atype, cldocno,Account, dtype, alevel, grpno,grplevel, gr_type, agroup, lApply, cmpid) "
				       +"  select  1 brhid, ins_comp,1 M_S,255 DEN,1 CURID,1 RATE,1 DR,0 TR_NO,0 cflow,@doc_no:=@doc_no+1, "
				       +"  curdate() date,'AP' ATYPE,0,@doc_no, 'GEN' dtype,concat('.',(select doc_no from my_head where den=255 and m_s=1 limit 1),'.',@doc_no), "
				       +"  (select doc_no from my_head where den=255 and m_s=1 limit 1) grpno,2 grplevel,2 gr_type,0 agroup,1 lapply,0 cmpid "
				       +"  from  (select distinct ins_comp from im_vehicle where ins_comp!='') e  left join my_head h on h.description=trim(e.ins_comp) and h.den=255  , "
				       +"  (select  @doc_no:=(select coalesce(max(doc_no),0) doc_no from my_head))b where h.doc_no is null";
				
                 System.out.println("str11============="+str11);
          //       stmtEMP1.executeUpdate(str11);
				 
				 str12=" insert into gl_vehin( INNAME,  DATE, status, acc_no)"
				         + "SELECT distinct a.ins_comp,curdate(),3 ,h.doc_no FROM im_vehicle A "
				         + "left join  my_head H on H.description=a.ins_comp "
				         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				         + "left join gl_vehin b on a.ins_comp=b.inname "
				         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.ins_comp!=''";
                 System.out.println("str12============="+str12);

		//		 stmtEMP1.executeUpdate(str12);
				 str13=" insert into my_color( color ) "
				         + "SELECT distinct A.color FROM im_vehicle A "
				         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
				         + "left join my_color b on b.color=a.color "
				         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.color!='' ";
                 System.out.println("str13============="+str13);

				 stmtEMP1.executeUpdate(str13);
                 str14="insert into gl_vehspec(name,status)"
                         + "SELECT distinct A.spec,3 FROM im_vehicle A "
                         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
                         + "left join gl_vehspec b on b.name=a.spec "
                         + "WHERE A1.REG_NO IS NULL and b.doc_no is null  and a.spec!=''";
                 
                 System.out.println("str14============="+str14);

                 stmtEMP1.executeUpdate(str14);
                 
                 
                 str15="insert into gl_project(project_name, cldocno,date,status)"
                         + "SELECT distinct A.project,1,curdate(),3 FROM im_vehicle A "
                         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO  "
                         + "left join gl_project b on b.project_name=a.project "
                         + "WHERE A1.REG_NO IS NULL and b.doc_no is null and a.project!='' "; 
                 System.out.println("str15============="+str15);

                 stmtEMP1.executeUpdate(str15);

                 str16="insert into GL_VEHMASTER(FLEET_NO,FLNAME,DATE,DOC_NO,REG_NO,YOM,FSTATUS,STATUS,SALIK_TAG,tcno,DLRID,LPO,PRCH_DTE,PRCH_COST,FINID,"
                         +"  REG_DATE,depr,REG_EXP,ITYPE,INS_COMP,INS_EXP,PNO,ENG_NO,CH_NO,CLRID,SRVC_KM, "
                         +"  LST_SRV,CUR_KM,C_FUEL,renttype,AUTHID,PLTID,VGRPID,BRDID,VMODID,BRHID,STATU,a_br,fueltype,tcap,tran_code,COMP_ID,BRANDED , A_LOC)"
                         + " SELECT fleetNo,fleetname,A.DATE,A.doc_No,A.REG_NO,y.doc_no,'I' FSTATUS,'IN' veh_STATUS,SALIK_TAGNO,A.tcno,v.doc_no,if(LPOno='',0,LPOno) LPOno,if(A.purchase_date='null',null,A.purchase_date),coalesce(purchase_cost,0),f.doc_no,"
                         + " if(A.reg_date='null',null,A.reg_date),dep_per,if(A.reg_expiry='null',null,A.reg_expiry),A.ins_type,i.doc_no,if(INS_EXPIRY='null',null,ins_expiry),policy_no,engine_no,chasis_no,c.doc_no, "
                         +" if(srvduration_km='',0,srvduration_km) srvduration_km,0 lastsrv_date,currentkm,if(currentfuel='',0,currentfuel) currentfuel, 'A',COALESCE(au.doc_no,0),COALESCE(p.doc_no,0),COALESCE(g.doc_no,0),COALESCE(b.doc_no,0),COALESCE(m.doc_no,0),1,3,1,if(fuel_type='PETROL','P','D') fuel_type,fuel_capacity,'IN',1,'Y',1 FROM im_vehicle A "
                         + "LEFT JOIN GL_veHMASTER A1 ON A.REG_NO=A1.REG_NO " 
                         + "left join gl_yom y on y.yom=A.yom "
                         + "left join my_vendorm v on v.name=A.dealer "
                         + "left join gl_vehfin f on f.fname=a.financier "
                         + "left join gl_vehin i on a.ins_comp=i.inname "
                         + "left join my_color c on c.color=a.color "
                         + "left join gl_project pr on pr.project_name=a.project "
                         + "left join gl_vehauth au on au.authname=a.authority "
                         + "left join gl_vehplate p on p.code_name=a.platecode and p.authid=au.doc_no "
                         + "left join gl_vehgroup g on g.gname=a.group_name "
                         + "left join gl_vehbrand b on a.brand_name=b.brand "
                         + "left join gl_vehmodel m on a.model=m.vtype "
                         + "WHERE A1.REG_NO IS NULL and b.doc_no is NOT null ";
                 // and a.project!='' 
                 System.out.println("str16============="+str16);

                 stmtEMP1.executeUpdate(str16);
                 



				
		

	//conn.commit();
	System.out.println("Committ****");
	String sqls = "select * from im_vehicle";
    ResultSet resultSet3 = stmtEMP1.executeQuery(sqls);
   System.out.println("sql3============="+sqls);
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
