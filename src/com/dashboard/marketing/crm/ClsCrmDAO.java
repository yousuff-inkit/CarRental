package com.dashboard.marketing.crm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCrmDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	 public JSONArray enquirylistsearch(HttpSession session,String brnchval,String fromdate,String todate,String id,String widgetname) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();  
	        if(!id.equalsIgnoreCase("1")) {
	        	return RESULTDATA;
	        }
	       Connection conn = null;
	      
		   Statement stmtVeh =null;
		   ResultSet resultSet=null;
	       String sqltest="",sqlsalman="";
	       java.sql.Date sqlfromdate = null;
	        try {
	             conn = ClsConnection.getMyConnection();
			     stmtVeh = conn.createStatement ();  
			      if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			    	  sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
			      }else{}
			     java.sql.Date sqltodate = null;
			      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
			       sqltodate=cmn.changeStringtoSqlDate(todate);
			      } else{}
			  
			      if(!(brnchval.equalsIgnoreCase("a"))&&!(brnchval.equalsIgnoreCase("0"))&&!(brnchval.equalsIgnoreCase("")))  {
			    	  sqltest+=" and e.brhid="+brnchval;
			     } else {}
			      String sql1="select doc_no from my_salm where status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";            
			      System.out.println("sql3====="+sql1); 
			      ResultSet rs =stmtVeh.executeQuery(sql1);         
			      if(rs.next()){
			    	  sqltest+=" and e.sal_id='"+rs.getString("doc_no")+"'";    
			      }   
			      if(widgetname.equalsIgnoreCase("lpr")){ 
						sqltest+=" and lc.doc_no is null and l.cldocno!=0";      
				  }else if(widgetname.equalsIgnoreCase("newclient")){
						sqltest+=" and lc.doc_no is null and l.cldocno=0 ";  
				  }else if(widgetname.equalsIgnoreCase("calcul")){
						sqltest+=" and lc.doc_no is not null and lm.refdocno is null";
				  }else if(widgetname.equalsIgnoreCase("appl")){  
						sqltest+=" and lm.refdocno is not null ";       
				  }else{}      
			        
			      String sql=" select coalesce(enq.txtname,'') enqsource,enq.doc_no enqdocno , l.voc_no, l.brhid ,b.branchname,l.doc_no,l.date,l.remarks,"
			      		+ " l.name,concat(coalesce(l.com_add1,''),',',coalesce(l.mob,''),',',"
			      		+ " coalesce(l.email,'')) as details,lc.doc_no qotno,lc.vocno calcvoc,lm.doc_no condocno,"
			      		+ " ms.sal_name salm, round(TIMESTAMPDIFF(minute,l.date,now())/60,2) age,ac.sal_id,"
			      		+ " case when lc.doc_no is null and l.cldocno!=0 then 'Lease Price Request' "
			      		+ " when lc.doc_no is null and l.cldocno=0 then 'New Client' "
			      		+ " when lc.doc_no is not null and lm.refdocno is null then 'Calculator' "
			      		+ " when lm.refdocno is not null then 'Application' else '' end as status,l.com_add1 address,l.mob per_mob,l.email mail1,l.cldocno  "
			      		+ " from gl_lprm l left join gl_leasecalcm lc on lc.reqdoc=l.doc_no "
			      		+ "  left join cm_enqsource enq on l.enqsrc=enq.doc_no "
			      		+ " left join gl_leaseappm lm on lm.refdocno=lc.doc_no "
			      		+ " left join my_brch b on l.brhid=b.doc_no "
			      		+ " left join my_acbook ac on ac.srno=l.cldocno "
			      		+ " left join my_salm ms on ms.doc_no=ac.sal_id "
			      		+ " where l.status=3 and  l.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" order by l.voc_no desc";
			      System.out.println("presalemgmt--->>>"+sql);                                        
	              resultSet = stmtVeh.executeQuery(sql);  
	              RESULTDATA=cmn.convertToJSON(resultSet);
				  stmtVeh.close();
				  conn.close();
	  }
	  catch(Exception e){
	   conn.close();
	  }
	  finally{
	   stmtVeh.close();  
	   conn.close();
	  }
	  System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public  JSONArray loadSubGridData(String doc,String enqdocno) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;   
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
					
				String sqldata = "select a.* from(select  m.date detdate,m.remarks remk,"
						+ "m.fdate,u.user_id user from gl_benq m inner join my_user u on u.doc_no=m.userid "
						+ "where m.rdocno='"+enqdocno+"' and m.bibpid=(select rowno  from gl_bibp where bibdid='87' and process='Follow-UP') "
						+ "and m.status=3 group by m.doc_no union all "
						+ " select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_blqf m "
						+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+doc+"' and m.status=3 group by m.doc_no)a  order by a.fdate desc ";
						System.out.println("detail==="+sqldata); 
				 resultSet= stmt.executeQuery (sqldata);
				 RESULTDATA=cmn.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
	 
	/* public JSONArray presaleslogGridLoad(HttpSession session,String id,String work) throws SQLException{
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null; 
			 if(!id.equalsIgnoreCase("1")){  
				 return data;
			 } 
			try{
				conn=ClsConnection.getMyConnection();  
				Statement stmt=conn.createStatement();
				String strsql="select w.rdocno,u.user_name username,date_format (w.logdate,'%d-%m-%Y %H:%m')logdate,description from my_presaleslog w left join my_user u on w.userid=u.doc_no where rdocno="+work+" ";        
				System.out.println("strsql--->>>"+strsql);               
				ResultSet rs=stmt.executeQuery(strsql);
				data=cmn.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}*/
	 public JSONArray siteGridLoad(HttpSession session,String docno,String id) throws SQLException{
			JSONArray RESULTDATA1=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";

				sql="select eq.site,grp.groupname area,eq.remarks, eq.rowno sitedocno, eq.route, eq.gpsx, eq.gpsy, eq.description from gl_enqsited eq left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' where eq.rdocno="+docno+"";
				//System.out.println("===sites===="+sql); 
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=cmn.convertToJSON(resultSet1);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}


			return RESULTDATA1;
		}
	 public JSONArray checklistData(HttpSession session,String docno,String id) throws SQLException{
			JSONArray RESULTDATA1=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();  

				String sql="select * from(select replace(path,'\\\\\\\\',';') path,attach upload,d.checksrno,c.desc1,c.mandatory,d.remarks,true chk,d.qotno,d.rowno from sk_checklistdet d left join sk_checklist c on c.srno=d.checksrno where d.qotno='"+docno+"' union all select '' path,'' upload,srno checksrno, desc1, mandatory,'' remarks,false chk,0 qotno,0 rowno from sk_checklist where status<>7)a group by checksrno order by checksrno";
				//System.out.println("===checklist===="+sql);         
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=cmn.convertToJSON(resultSet1);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return RESULTDATA1;
		}
		public   JSONArray areaSearch(HttpSession session) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Enumeration<String> Enumeration = session.getAttributeNames();
			int a=0;
			while(Enumeration.hasMoreElements()){
				if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
					a=1;
				}
			}
			if(a==0){
				return RESULTDATA;
			}
			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				//String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
			//	System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=cmn.convertToJSON(resultSet);  
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				resultSet.close();
				stmt.close();
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;
		}
		public JSONArray clientData(int id) throws SQLException{ 
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {  
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();  

				String sql="select refname, cldocno from my_acbook where dtype='crm' and status=3";
				ResultSet resultSet1 = stmt.executeQuery(sql); 
				RESULTDATA1=cmn.convertToJSON(resultSet1);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return RESULTDATA1;
		}
}
