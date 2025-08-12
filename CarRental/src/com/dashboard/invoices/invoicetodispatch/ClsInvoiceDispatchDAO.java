package com.dashboard.invoices.invoicetodispatch;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceDispatchDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss,String invtype,String catid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!fromdate.equalsIgnoreCase(""))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}

        
     	if(!todate.equalsIgnoreCase(""))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     
	String sqltest="";
	String sqlfilters="";//For CNO Filters
    	if(!cldocno.equalsIgnoreCase("")){
    		sqltest=sqltest+" and m.cldocno in ("+cldocno+")";
    		sqlfilters=sqlfilters+" and ac.cldocno in ("+cldocno+")";
    	}
    	if(!(rentaltype.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and m.ratype='"+rentaltype+"'";
    		sqlfilters=sqlfilters+" and jvdet.rtype='"+rentaltype+"'";
    	}
    	if(!(agmtNo.equalsIgnoreCase(""))){
    		if(rentaltype.equalsIgnoreCase("RAG")){
    			sqltest=sqltest+" and r.voc_no='"+agmtNo+"'";
    			sqlfilters=sqlfilters+" and ragmt.voc_no='"+agmtNo+"'";
    		}
    		if(rentaltype.equalsIgnoreCase("LAG")){
    			sqltest=sqltest+" and l.voc_no='"+agmtNo+"'";
    			sqlfilters=sqlfilters+" and lagmt.voc_no='"+agmtNo+"'";
    		}
    	}
    	/*
    	if(!(clstatuss.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"')";
    	}*/
    	if(!catid.trim().equalsIgnoreCase("")) {
    		sqltest+=" and a.catid="+catid;
    		sqlfilters+=" and ac.catid="+catid;
    	}
    	if(!clstatuss.equalsIgnoreCase("")){
    		sqltest+=" and if(m.ratype='RAG',r.clstatus='"+clstatuss+"',l.clstatus='"+clstatuss+"')";
    		sqlfilters+=" and case when jvdet.rtype='RAG' then ragmt.clstatus when jvdet.rtype='LAG' then lagmt.clstatus else 0 end ='"+clstatuss+"'";
    	}
    	if(!invtype.equalsIgnoreCase("")){
    		if(invtype.equalsIgnoreCase("rental")){
    			sqltest+=" and m.manual in (2,3)";
    		}
    		else if(invtype.equalsIgnoreCase("lease")){
    			sqltest+=" and m.manual in (4,5)";
    		}
    		else if(invtype.equalsIgnoreCase("damage")){
    			sqltest+=" and m.manual=6";
    		}
    		else if(invtype.equalsIgnoreCase("salik")){
    			sqltest+=" and m.manual=8";
    		}
    		else if(invtype.equalsIgnoreCase("traffic")){
    			sqltest+=" and m.manual=9";
    		}
    		else if(invtype.equalsIgnoreCase("extrasrvc")){
    			sqltest+=" and m.manual=7";
    		}
    		else if(invtype.equalsIgnoreCase("extrakm")){
    			sqltest+=" and m.manual=10";
    		}
    	}
    	
    	
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				//Getting Config for List CNO
		    	int cnoconfig=0;
		    	String strcnoconfig="select method from gl_config where field_nme='CNODispatch'";
		    	ResultSet rscnoconfig=stmtVeh.executeQuery(strcnoconfig);
		    	while(rscnoconfig.next()) {
		    		cnoconfig=rscnoconfig.getInt("method");  
		    	}
				
		    	String strcno="";
		    	if(cnoconfig>0) {
		    		if(!branchval.trim().equalsIgnoreCase("") && !branchval.trim().equalsIgnoreCase("a")) {
		    			sqlfilters+=" and m.brhid="+branchval;
		    		}
		    		strcno=" union all SELECT m.mailed,m.tr_no,br.branchname branch,m.dtype,CASE WHEN jvdet.rtype='RAG' THEN ragmt.voc_no WHEN jvdet.rtype='LAG' THEN lagmt.voc_no ELSE '' END refvocno,'Dispatch' btndispatch,'Print' btnprint,m.doc_no,m.doc_no voc_no,h.description acname,h.account acno,jvdet.rtype ratype,jvdet.rdocno rano,ac.cldocno,ac.refname,m.date fromdate,m.date todate,m.netamount amount,0.0 rent,0.0 inschg,0.0 accchg,0.0 salik,0.0 traffic,ac.mail1,m.brhid FROM my_cnot m \r\n" + 
		    		" LEFT JOIN my_brch br ON m.brhid=br.doc_no AND br.status=3\r\n" + 
		    		" LEFT JOIN (SELECT rdocno,rtype,tr_no FROM my_jvtran WHERE STATUS=3 GROUP BY tr_no) jvdet ON m.tr_no=jvdet.tr_no\r\n" + 
		    		" LEFT JOIN gl_ragmt ragmt ON jvdet.rtype='RAG' AND ragmt.doc_no=jvdet.rdocno\r\n" + 
		    		" LEFT JOIN gl_lagmt lagmt ON jvdet.rtype='LAG' AND lagmt.doc_no=jvdet.rdocno\r\n" + 
		    		" LEFT JOIN my_head h ON m.acno=h.doc_no\r\n" + 
		    		" LEFT JOIN my_acbook ac ON h.doc_no=ac.acno\r\n" + 
		    		" WHERE m.dtype IN ('TCN','CNO') and m.dispatch=0 AND m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqlfilters;
		    	}
            	if(branchval.equalsIgnoreCase("a"))
            	{

            		String sql ="select * from (select m.mailed,m.tr_no,br.branchname branch,m.dtype,if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,'Dispatch' btndispatch,'Print' btnprint,m.doc_no,m.voc_no,h.description acname,h.account acno,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic,a.mail1,m.brhid  "
            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no  where m.status=3 and m.dispatch=0"
            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno"+strcno+") base order by base.tr_no";
        System.out.println("============"+sql);
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
             		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmtVeh.close();
            	}
            	else{	
            		
            		String sql ="select * from (select m.mailed,m.tr_no,br.branchname branch, m.dtype,if(m.ratype='RAG',r.voc_no,l.voc_no) refvocno,'Dispatch' btndispatch,'Print' btnprint, m.doc_no,m.voc_no,h.description acname,h.account acno,m.ratype,m.rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic,a.mail1,m.brhid  "
            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano"
            				+ " left join gl_ragmt r on r.doc_no=m.rano left join my_head h on h.doc_no=m.acno  left join my_brch br on m.brhid=br.doc_no  where m.status=3 and m.dispatch=0"
            				+ " and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' and m.brhid='"+branchval+"' "+sqltest +" group by d.rdocno "+strcno+") base order by base.tr_no";

            	     System.out.println("========2===="+sql);
     
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
         	stmtVeh.close();
            	}
          
            	
 				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
	
	
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

    		if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
    	}
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" l.brhid="+branch+"";
    		}
        	
        
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	
    		
    	}
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
    	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on (r.cldocno=a.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by doc_no");
			//	System.out.println(sql);
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");	
					

					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	
	
	
	public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}

}
