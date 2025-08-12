package com.dashboard.operations.agreementdriverlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgreementDriverListDAO {
ClsConnection connDAO=new ClsConnection();
	
	ClsCommon commonDAO=new ClsCommon();

	
	
	 public  JSONArray reloadDriver(String type,String multidriver) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		 
		        
		        Connection conn=null;
				try {
						  conn = connDAO.getMyConnection();
						Statement stmtVeh = conn.createStatement ();
						String drsql="";
				
		           if(type.equalsIgnoreCase("1")) 
		           {
						 drsql="SELECT agmt.voc_no agmtno,'RAG' type,agmt.odate,agmt.otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_rdriver r  left join  gl_drdetails d  on d.dr_id=r.drid  left join gl_ragmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM' )where  r.status=3  order by agmt.voc_no ";
		           }
		           else if(type.equalsIgnoreCase("2"))
		           {
						 drsql="SELECT agmt.voc_no agmtno,'LAG' type,agmt.outdate odate,agmt.outtime otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_ldriver r  left join  gl_drdetails d  on d.dr_id=r.drid left join gl_lagmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where  r.status=3  order by agmt.voc_no ";
 
		           }
		           else 
		           {
		        	   drsql="select * from (SELECT agmt.voc_no agmtno,'RAG' type,agmt.odate,agmt.otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_rdriver r  left join  gl_drdetails d  on d.dr_id=r.drid left join gl_ragmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where  r.status=3   "
		        	   		+ "union all SELECT agmt.voc_no agmtno,'LAG' type,agmt.outdate odate,agmt.outtime otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM gl_ldriver r  left join  gl_drdetails d  on d.dr_id=r.drid left join gl_lagmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where  r.status=3 ) x order by x.agmtno";
		           }
						//System.out.println("gridload===="+drsql);
						ResultSet resultSet = stmtVeh.executeQuery(drsql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtVeh.close();
						conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }

	
	 
	 public  JSONArray loadMultiDriver(String multidriver ,String type) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
		 int a=0;
		      if(multidriver.equalsIgnoreCase("1")){
		      a=1;
		     }
		    
		    if(a==0){
		  return RESULTDATA;
		     }
		        
		        Connection conn=null;
				try {
						  conn = connDAO.getMyConnection();
						Statement stmtVeh = conn.createStatement ();
		            	String drsql="";
						   if(type.equalsIgnoreCase("1")) 
				           {
							   	 drsql="select agmt.voc_no agmtno,'RAG' type,agmt.odate,agmt.otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM (select count(*),rdocno from gl_rdriver group by rdocno having count(*)>1) r1 left join  gl_rdriver r  on r.rdocno=r1.rdocno left join  gl_drdetails d  on d.dr_id=r.drid  left join gl_ragmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')where  r.status=3 order by agmt.voc_no "	;
                           }
				           else if(type.equalsIgnoreCase("2"))
				           {
				        	   drsql="select agmt.voc_no agmtno,'LAG' type,agmt.outdate odate,agmt.outtime otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM (select count(*),rdocno from gl_ldriver group by rdocno having count(*)>1) r1 left join  gl_ldriver r  on r.rdocno=r1.rdocno left join  gl_drdetails d  on d.dr_id=r.drid left join gl_lagmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where  r.status=3 order by agmt.voc_no";		 
				           }
				           else 
				           {
				        	   drsql="select * from (select agmt.voc_no agmtno,'RAG' type,agmt.odate,agmt.otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM (select count(*),rdocno from gl_rdriver group by rdocno having count(*)>1) r1 left join  gl_rdriver r  on r.rdocno=r1.rdocno left join  gl_drdetails d  on d.dr_id=r.drid left join gl_ragmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')  where  r.status=3 "
				        			  + " union all select agmt.voc_no agmtno,'LAG' type,agmt.outdate odate,agmt.outtime otime,coalesce(ac.refname,'') refname, d.dr_id dr_id1,d.doc_no doc_no1,d.name name1,d.dob dob1,d.nation nation1,d.mobno mobno1,d.dlno dlno1,d.issdate issdate1,d.led led1,d.ltype ltype1,d.issfrm issfrm1,d.passport_no passport_no1,d.pass_exp pass_exp1,d.visano visano1,d.visa_exp visa_exp1,d.hcdlno hcdlno1,d.hcissdate hcissdate1,d.hcled hcled1,d.cldocno cldocno1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.dob)),'%y ') AS age1,DATE_FORMAT(FROM_DAYS(DATEDIFF(CURRENT_DATE,d.issdate)),'%y ') AS expiryear1 FROM (select count(*),rdocno from gl_ldriver group by rdocno having count(*)>1) r1 left join  gl_ldriver r  on r.rdocno=r1.rdocno left join  gl_drdetails d  on d.dr_id=r.drid left join gl_lagmt agmt on agmt.doc_no=r.rdocno  left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM' ) where  r.status=3 ) x order by x.agmtno";
}
						//System.out.println("gridloadmultidriver===="+drsql);
						ResultSet resultSet = stmtVeh.executeQuery(drsql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);
						stmtVeh.close();
						conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }

	
	 
}
