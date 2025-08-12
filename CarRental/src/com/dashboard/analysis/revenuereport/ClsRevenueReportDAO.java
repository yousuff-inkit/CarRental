package com.dashboard.analysis.revenuereport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsRevenueReportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
    	
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	}
    	
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    		
    	}
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.status=3 "+sqltest+" group by doc_no");
				
			
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select  l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.status=3 "+sqltest+" group by doc_no");	
					
				
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
 public JSONArray getRevenue(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss,String cmbtariftype,String invstatuss) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	
	      	
        	String sqltest="";
        	String sqltest1="";
        	String cnotefilters="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.cldocno='"+cldocno+"'";
	    		cnotefilters+=" and ac.cldocno="+cldocno;
	    	}
			/*
			 * if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
			 * sqltest=sqltest+" and inv.ratype='"+rentaltype+"'"; }
			 * if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
			 * sqltest=sqltest+" and inv.rano='"+agmtNo+"'"; }
			 * if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
			 * sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"
			 * +clstatuss+"' )"; }
			 */
			/*
			 * if(!((branchval.equalsIgnoreCase("a")) ||
			 * (branchval.equalsIgnoreCase("NA")))){
			 * sqltest+=" and inv.brhid="+branchval+"";
			 * cnotefilters+=" and m.brhid="+branchval; }
			 * if(!cmbtariftype.equalsIgnoreCase("")){
			 * if(cmbtariftype.equalsIgnoreCase("Daily")){
			 * sqltest+=" and rtarif.rentaltype='Daily'"; } else
			 * if(cmbtariftype.equalsIgnoreCase("Weekly")){
			 * sqltest+=" and rtarif.rentaltype='Weekly'"; } else
			 * if(cmbtariftype.equalsIgnoreCase("Monthly")){
			 * sqltest+=" and rtarif.rentaltype='Monthly'"; } else
			 * if(cmbtariftype.equalsIgnoreCase("Lease")){ sqltest+=" and inv.ratype='LAG'";
			 * } }
			 */
	    	if(!invstatuss.equalsIgnoreCase("")){
	    		if(invstatuss.equalsIgnoreCase("1")){
	    			sqltest+=" and inv.status=3";
	    			cnotefilters+=" and m.status=3";
	    		}
	    		else if(invstatuss.equalsIgnoreCase("2")){
	    			sqltest+=" and inv.status=7";
	    			cnotefilters+=" and m.status=7";
	    		}
	    		
	    	}
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
            		ResultSet re = stmtVeh.executeQuery(sql1);
            		
				int company=0;	
				int chk=1;
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
				company=1;
				if(company==1)
				{
					chk=0;
					
					sqltest1=sqltest1+ " vat , ";
				}
				
				else
				{
					chk=1;
					sqltest+=" and inv.status=3 ";		
					
				}
				
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(inv.date),'/',inv.voc_no)";
				}
				else{
					sqlvocno="inv.voc_no";
				}
				String strshowfleet="select method from gl_config where field_nme='invListShowFleet'";
				int showfleet=0;
				ResultSet rsshowfleet=stmtindian.executeQuery(strshowfleet);
				while(rsshowfleet.next()){
					showfleet=rsshowfleet.getInt("method");
				}
				String showfleetcolumn="";
				if(showfleet==1){
					showfleetcolumn="l.perfleet,";
				}
	         /*   			String sql ="select  m.date,m.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,h.account acno,m.ratype,if(m.ratype='RAG',r.voc_no,
	          * l.voc_no) rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "+sqltest1 +" "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) 
	            				other , ms.sal_name,"
	            				+ " if(m.ratype='RAG',r.mrano,l.manualra) mrano ,'"+chk+"' chk "
	            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
	            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano AND M.RATYPE='LAG'"
	            				+ " left join gl_ragmt r on r.doc_no=m.rano AND M.RATYPE='RAG' left join my_head h on h.doc_no=m.acno left join my_brch br on 
	            				m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid  where  "
	            				+ "  m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
	         */
				
				//Fetching data from view instead direct from db;
			/*	String sql="select "+showfleet+" showfleet,inv.dtype,if(inv.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,inv.date,br.branchname branch,inv.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,"+
				" h.account acno,inv.ratype,convert(if(inv.ratype='RAG',r.voc_no, l.voc_no),char(25)) rano,inv.cldocno,ac.refname,"+showfleetcolumn+"inv.fromdate,inv.todate,"
				+ "if(inv.status=3,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) amount , "
				+ "if(inv.status=7,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) delamount "
				+ " ,coalesce(sum(rent),0.0) rent,coalesce(sum(inschg),0.0) inschg,"+
				" coalesce(sum(accchg),0.0) accchg,(coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) salik,(coalesce(sum(traffic),0.0)+"+
				" coalesce(sum(trafficsrv),0.0)) traffic,coalesce(sum(others),0.0) other, coalesce(sum(vat),0.0) vat,"+
				" ms.sal_name,if(inv.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk  from invoice_view inv left join my_acbook ac on"+
				" ac.doc_no=inv.cldocno and  ac.dtype='CRM' left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
				" gl_ragmt r on (r.doc_no=inv.rano and inv.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
				" on inv.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
				" group by inv.doc_no union all"+
				" SELECT "+showfleet+" showfleet,m.dtype,'' tariftype,m.date,br.branchname branch,invac.idno status,convert(m.DOC_NO,char(25)) doc_no,hd.Description,hd.Account acno,'' ratype,'' rano,ac.cldocno,ac.refname,null fromdate,null todate,SUM(if(m.status=3,d.amount,0.0)) amount,\r\n" + 
				" SUM(IF(m.status=7,d.amount,0.0)) delamount,SUM(IF(invac.idno=1,d.AMOUNT,0.0)) rent,SUM(IF(invac.idno IN (17),d.AMOUNT,0.0)) inschg,SUM(IF(invac.idno=2,d.AMOUNT,0.0)) accchg,\r\n" + 
				" SUM(IF(invac.idno IN (8,14,38,39),d.AMOUNT,0.0)) salik,SUM(IF(invac.idno IN (9,15),d.AMOUNT,0.0)) traffic,\r\n" + 
				" SUM(IF(invac.idno NOT IN (1,6,2,8,14,38,39,9,15,17,20),d.AMOUNT,0.0)) other,SUM(IF(m.dtype in ('TCN','TDN'),d.taxamount,if(invac.idno IN (20),d.AMOUNT,0.0))) vat,coalesce(ms.sal_name,'') sal_name,'' mrano,'"+chk+"' chk  FROM my_cnot m LEFT JOIN my_cnotd d ON m.TR_NO=d.TR_NO \r\n" + 
				" LEFT JOIN gl_invmode invac ON d.acno=invac.acno\r\n" + 
				" LEFT JOIN my_brch br ON m.brhid=br.DOC_NO\r\n" + 
				" LEFT JOIN my_head hd ON m.acno=hd.DOC_NO left join my_acbook ac on hd.doc_no=ac.acno LEFT JOIN my_salm ms ON ac.sal_id=ms.doc_no \r\n" + 
				"\r\n" + 
				" WHERE m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+cnotefilters+" AND hd.atype='AR' GROUP BY m.tr_no";*/
				
				    
			/*	 String sql="select "+showfleet+" showfleet,cl.category clcategory,inv.dtype,if(inv.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,inv.date,br.branchname branch,inv.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,"+
                         " h.account acno,inv.ratype,convert(if(inv.ratype='RAG',r.voc_no, l.voc_no),char(25)) rano,inv.cldocno,ac.refname,"+showfleetcolumn+"inv.fromdate,inv.todate,"
                         + "if(inv.status=3,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) amount , "
                         + "if(inv.status=7,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) delamount "
                         + " ,coalesce(sum(rent),0.0) rent,coalesce(sum(inschg),0.0) inschg,"+
                         " coalesce(sum(accchg),0.0) accchg,(coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) salik,(coalesce(sum(traffic),0.0)+"+
                         " coalesce(sum(trafficsrv),0.0)) traffic,coalesce(sum(others),0.0) other, coalesce(sum(vat),0.0) vat,"+
                         " ms.sal_name,if(inv.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk  from invoice_view inv left join my_acbook ac on"+
                         " ac.doc_no=inv.cldocno and  ac.dtype='CRM' left join my_clcatm cl on cl.doc_no=ac.catid left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
                         " gl_ragmt r on (r.doc_no=inv.rano and inv.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
                         " on inv.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
                         " group by inv.doc_no union all"+
                         " SELECT "+showfleet+" showfleet,cl.category clcategory,m.dtype,'' tariftype,m.date,br.branchname branch,invac.idno status,convert(m.DOC_NO,char(25)) doc_no,hd.Description,hd.Account acno,'' ratype,'' rano,ac.cldocno,ac.refname,null fromdate,null todate,SUM(if(m.status=3,if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) amount,\r\n" + 
                         " SUM(IF(m.status=7,if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) delamount,SUM(IF(invac.idno=1,if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) rent,SUM(IF(invac.idno IN (17),if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) inschg,SUM(IF(invac.idno=2,if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) accchg,\r\n" + 
                         " SUM(IF(invac.idno IN (8,14,38,39),if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) salik,SUM(IF(invac.idno IN (9,15),if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) traffic,\r\n" + 
                         " SUM(IF(invac.idno NOT IN (1,6,2,8,14,38,39,9,15,17,20),if(m.dtype in ('CNO','TCN'),d.nettotal*-1,d.nettotal),0.0)) other,SUM(case when m.dtype='TCN' then d.taxamount*-1 when m.dtype='TDN' then d.taxamount when invac.idno in (20) and m.dtype='CNO' then d.nettotal*-1 when invac.idno in (20) and m.dtype<>'CNO' then d.nettotal else 0.0 end ) vat,coalesce(ms.sal_name,'') sal_name,'' mrano,'"+chk+"' chk  FROM my_cnot m LEFT JOIN my_cnotd d ON m.TR_NO=d.TR_NO \r\n" + 
                         " LEFT JOIN gl_invmode invac ON d.acno=invac.acno\r\n" + 
                         " LEFT JOIN my_brch br ON m.brhid=br.DOC_NO\r\n" + 
                         " LEFT JOIN my_head hd ON m.acno=hd.DOC_NO left join my_acbook ac on hd.doc_no=ac.acno left join my_clcatm cl on cl.doc_no=ac.catid LEFT JOIN my_salm ms ON ac.sal_id=ms.doc_no \r\n" + 
                         "\r\n" + 
                         " WHERE m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+cnotefilters+" AND hd.atype='AR' GROUP BY m.tr_no";       
                         */          

				 
				 
				/*String sql="select "+showfleet+" showfleet,cl.category clcategory,inv.dtype,if(inv.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,inv.date,br.branchname branch,inv.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,"+
                        " h.account acno,inv.ratype,convert(if(inv.ratype='RAG',r.voc_no, l.voc_no),char(25)) rano,inv.cldocno,ac.refname,"+showfleetcolumn+"inv.fromdate,inv.todate,"
                        + "if(inv.status=3,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0),2) amount , "
                        + "if(inv.status=7,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0),2) delamount "
                        + " ,round(coalesce(sum(rent),0.0),2) rent,round(coalesce(sum(inschg),0.0),2) inschg,"+
                        " round(coalesce(sum(accchg),0.0),2) accchg,round((coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) ,2)salik,round((coalesce(sum(traffic),0.0)+"+
                        " coalesce(sum(trafficsrv),0.0)),2) traffic,round(coalesce(sum(others),0.0),2) other, round(coalesce(sum(vat),0.0),2) vat,"+
                        " ms.sal_name,if(inv.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk  from invoice_view inv left join my_acbook ac on"+
                        " ac.doc_no=inv.cldocno and  ac.dtype='CRM' left join my_clcatm cl on cl.doc_no=ac.catid left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
                        " gl_ragmt r on (r.doc_no=inv.rano and inv.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
                        " on inv.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
                        " group by inv.doc_no union all"+
                        " SELECT "+showfleet+" showfleet,cl.category clcategory,m.dtype,'' tariftype,m.date,br.branchname branch,invac.idno status,convert(m.DOC_NO,char(25)) doc_no,hd.Description,hd.Account acno,'' ratype,'' rano,ac.cldocno,ac.refname,null fromdate,null todate,round(SUM(if(m.status=3,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) amount,\r\n" +   
                        " round(SUM(IF(m.status=7,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) delamount,round(SUM(IF(invac.idno=1,if(m.dtype in ('CNO','TCN'),if(d.amount>0,d.amount*-1,d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) rent,round(SUM(IF(invac.idno IN (17),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) inschg,round(SUM(IF(invac.idno=2,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) accchg,\r\n" + 
                        " round(SUM(IF(invac.idno IN (8,14,38,39),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) salik,round(SUM(IF(invac.idno IN (9,15),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) traffic,\r\n" + 
                        " round(SUM(IF(invac.idno NOT IN (1,6,2,8,14,38,39,9,15,17,20),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) other,round(SUM(case when m.dtype='TCN' then d.taxamount*-1 when m.dtype='TDN' then d.taxamount when invac.idno in (20) and m.dtype='CNO' then d.amount*-1 when invac.idno in (20) and m.dtype<>'CNO' then d.amount else 0.0 end ),2) vat,coalesce(ms.sal_name,'') sal_name,'' mrano,'"+chk+"' chk  FROM (select dtype, tr_no from my_jvtran where status=3 group by tr_no) j left join my_cnot m on m.dtype=j.dtype and m.tr_no=j.tr_no  LEFT JOIN my_cnotd d ON m.TR_NO=d.TR_NO \r\n" + 
                        " LEFT JOIN gl_invmode invac ON d.acno=invac.acno\r\n" + 
                        " LEFT JOIN my_brch br ON m.brhid=br.DOC_NO\r\n" + 
                        " LEFT JOIN my_head hd ON m.acno=hd.DOC_NO left join my_acbook ac on hd.doc_no=ac.acno left join my_clcatm cl on cl.doc_no=ac.catid LEFT JOIN my_salm ms ON ac.sal_id=ms.doc_no \r\n" + 
                        "\r\n" + 
                        " WHERE m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+cnotefilters+" AND hd.atype='AR' GROUP BY m.tr_no";    */   
               
				
				/* query changed on 13-03-24*/
				
				
				/*String sql="select "+showfleet+" showfleet,cl.category clcategory,inv.dtype,if(inv.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,inv.date,br.branchname branch,inv.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,"+
                        " h.account acno,inv.ratype,convert(if(inv.ratype='RAG',r.voc_no, l.voc_no),char(25)) rano,inv.cldocno,ac.refname,"+showfleetcolumn+"inv.fromdate,inv.todate,"
                        + "if(inv.status=3,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),2),0) amount , "
                        + "if(inv.status=7,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),2),0) delamount "
                        + " ,round(coalesce(sum(rent),0.0),2) rent,round(coalesce(sum(inschg),0.0),2) inschg,"+
                        " round(coalesce(sum(accchg),0.0),2) accchg,round((coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) ,2)salik,round((coalesce(sum(traffic),0.0)+"+
                        " coalesce(sum(trafficsrv),0.0)),2) traffic,round(coalesce(sum(others),0.0),2) other, round(coalesce(sum(vat),0.0),2) vat,"+
                        " ms.sal_name,if(inv.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk  from invoice_view inv left join my_acbook ac on"+
                        " ac.doc_no=inv.cldocno and  ac.dtype='CRM' left join my_clcatm cl on cl.doc_no=ac.catid left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
                        " gl_ragmt r on (r.doc_no=inv.rano and inv.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
                        " on inv.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
                        " group by inv.doc_no union all"+
                        " SELECT "+showfleet+" showfleet,cl.category clcategory,m.dtype,'' tariftype,m.date,br.branchname branch,invac.idno status,convert(m.DOC_NO,char(25)) doc_no,hd.Description,hd.Account acno,'' ratype,'' rano,ac.cldocno,ac.refname,null fromdate,null todate,\r\n" + 
                        " round(SUM(if(m.status=3,if(m.dtype in ('CNO','TCN'),if(d.amount>0,(d.amount*-1)+(case when m.dtype='TCN' then d.taxamount*-1 ELSE 0 END), d.amount*-1),if(d.amount<0,(d.amount*-1)+(case when m.dtype='TDN' then d.taxamount*-1 ELSE 0 END) ,d.amount)),0)),2) amount,\r\n" +   
                        " round(SUM(IF(m.status=7,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) delamount,round(SUM(IF(invac.idno=1,if(m.dtype in ('CNO','TCN'),if(d.amount>0,d.amount*-1,d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) rent,round(SUM(IF(invac.idno IN (17),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) inschg,round(SUM(IF(invac.idno=2,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) accchg,\r\n" + 
                        " round(SUM(IF(invac.idno IN (8,14,38,39),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) salik,round(SUM(IF(invac.idno IN (9,15),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) traffic,\r\n" + 
                        " round(SUM(IF(COALESCE(invac.idno,0) NOT IN (1,2,8,14,38,39,9,15,17,20),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) other,round(SUM(case when m.dtype='TCN' then d.taxamount*-1 when m.dtype='TDN' then d.taxamount*-1 when invac.idno in (20) and m.dtype='CNO' then d.amount*-1 when invac.idno in (20) and m.dtype<>'CNO' then d.amount else 0.0 end ),2) vat,coalesce(ms.sal_name,'') sal_name,'' mrano,'"+chk+"' chk  FROM my_cnot m  LEFT JOIN my_cnotd d ON m.TR_NO=d.TR_NO \r\n" + 
                        " LEFT JOIN gl_invmode invac ON d.acno=invac.acno\r\n" + 
                        " LEFT JOIN my_brch br ON m.brhid=br.DOC_NO\r\n" + 
                        " LEFT JOIN my_head hd ON m.acno=hd.DOC_NO left join my_acbook ac on hd.doc_no=ac.acno left join my_clcatm cl on cl.doc_no=ac.catid LEFT JOIN my_salm ms ON ac.sal_id=ms.doc_no \r\n" + 
                        "\r\n" + 
                        " WHERE m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+cnotefilters+" AND hd.atype='AR' GROUP BY m.tr_no";       
                */
				
				
				String sql="select a.* ,cl.category clcategory ,ms.sal_name from(select COALESCE(r.salid,l.salid) salid,ac.catid, "+showfleet+" showfleet,inv.dtype,if(inv.ratype='RAG',rtarif.rentaltype,'Lease') tariftype,inv.date,br.branchname branch,inv.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,"+
                        " h.account acno,inv.ratype,convert(if(inv.ratype='RAG',r.voc_no, l.voc_no),char(25)) rano,inv.cldocno,ac.refname,"+showfleetcolumn+"inv.fromdate,inv.todate,"
                        + "if(inv.status=3,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),2),0) amount , "
                        + "if(inv.status=7,round(convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),2),0) delamount "
                        + " ,round(coalesce(sum(rent),0.0),2) rent,round(coalesce(sum(inschg),0.0),2) inschg,"+
                        " round(coalesce(sum(accchg),0.0),2) accchg,round((coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) ,2)salik,round((coalesce(sum(traffic),0.0)+"+
                        " coalesce(sum(trafficsrv),0.0)),2) traffic,round(coalesce(sum(others),0.0),2) other, round(coalesce(sum(vat),0.0),2) vat,"+
                        " if(inv.ratype='RAG',r.mrano,l.manualra) mrano,'"+chk+"' chk  from invoice_view inv left join my_acbook ac on"+
                        " ac.cldocno=inv.cldocno and  ac.dtype='CRM' left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
                        " gl_ragmt r on (r.doc_no=inv.rano and inv.ratype='RAG') left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
                        " on inv.brhid=br.doc_no where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
                        " group by inv.doc_no union all"+
                        " SELECT AC.SAL_ID SALID,ac.catid,"+showfleet+" showfleet,m.dtype,'' tariftype,m.date,br.branchname branch,invac.idno status,convert(m.DOC_NO,char(25)) doc_no,hd.Description,hd.Account acno,'' ratype,'' rano,ac.cldocno,ac.refname,null fromdate,null todate,\r\n" + 
                        " round(SUM(if(m.status=3,if(m.dtype in ('CNO','TCN'),if(d.amount>0,(d.amount*-1)+(case when m.dtype='TCN' then d.taxamount*-1 ELSE 0 END), d.amount*-1),if(d.amount<0,(d.amount*-1)+(case when m.dtype='TDN' then d.taxamount*-1 ELSE 0 END) ,d.amount)),0)),2) amount,\r\n" +   
                        " round(SUM(IF(m.status=7,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) delamount,round(SUM(IF(invac.idno=1,if(m.dtype in ('CNO','TCN'),if(d.amount>0,d.amount*-1,d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) rent,round(SUM(IF(invac.idno IN (17),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) inschg,round(SUM(IF(invac.idno=2,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) accchg,\r\n" + 
                        " round(SUM(IF(invac.idno IN (8,14,38,39),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) salik,round(SUM(IF(invac.idno IN (9,15),if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) traffic,\r\n" + 
                        " round(SUM(IF(COALESCE(invac.idno,0) in (3,4,5,6,7,10,11,12,13,16,18,19,21,40) ,if(m.dtype in ('CNO','TCN'),if(d.amount>0, d.amount*-1, d.amount),if(d.amount>0,d.amount,d.amount*-1)),0)),2) other,round(SUM(case when m.dtype='TCN' then d.taxamount*-1 when m.dtype='TDN' then d.taxamount*-1 when invac.idno in (20) and m.dtype='CNO' then d.amount*-1 when invac.idno in (20) and m.dtype<>'CNO' then d.amount else 0.0 end ),2) vat,'' mrano,'"+chk+"' chk  FROM my_cnot m  LEFT JOIN my_cnotd d ON m.TR_NO=d.TR_NO \r\n" + 
                        " LEFT JOIN gl_invmode invac ON d.acno=invac.acno\r\n" + 
                        " LEFT JOIN my_brch br ON m.brhid=br.DOC_NO\r\n" + 
                        " LEFT JOIN my_head hd ON m.acno=hd.DOC_NO left join my_acbook ac on hd.doc_no=ac.acno \r\n" + 
                        "\r\n" +   
                        " WHERE m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+cnotefilters+" AND hd.atype='AR' GROUP BY m.tr_no)a left join my_clcatm cl on cl.doc_no=a.catid left join my_salm ms on ms.doc_no=a.salid  ";       
          
            		//order by inv.doc_no
	            		System.out.println("griddata===="+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	    

	 
	  
	 public JSONArray invoicelistExcel(String branchval,String fromdate,String todate,String cldocno,String rentaltype,String agmtNo,String clstatuss,String cmbtariftype, String invstatuss) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
	        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	
	      	
     	String sqltest="";
     	String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.cldocno='"+cldocno+"'";
	    	}
	    	if(!(rentaltype.equalsIgnoreCase("") || rentaltype.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.ratype='"+rentaltype+"'";
	    	}
	    	if(!(agmtNo.equalsIgnoreCase("")|| agmtNo.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and inv.rano='"+agmtNo+"'";
	    	}
	    	if(!(clstatuss.equalsIgnoreCase("") || clstatuss.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and (r.clstatus='"+clstatuss+"' or l.clstatus='"+clstatuss+"' )";
	    	}
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and inv.brhid="+branchval+"";
	 		}
	      	if(!cmbtariftype.equalsIgnoreCase("")){
	    		if(cmbtariftype.equalsIgnoreCase("Daily")){
	    			sqltest+=" and rtarif.rentaltype='Daily'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Weekly")){
	    			sqltest+=" and rtarif.rentaltype='Weekly'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Monthly")){
	    			sqltest+=" and rtarif.rentaltype='Monthly'";
	    		}
	    		else if(cmbtariftype.equalsIgnoreCase("Lease")){
	    			sqltest+=" and inv.ratype='LAG";
	    		}
	    	}
	      	
	      	if(!invstatuss.equalsIgnoreCase("")){
	    		if(invstatuss.equalsIgnoreCase("1")){
	    			sqltest+=" and inv.status=3";
	    		}
	    		else if(invstatuss.equalsIgnoreCase("2")){
	    			sqltest+=" and inv.status=7";
	    		}
	    		
	    	}
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
         		ResultSet re = stmtVeh.executeQuery(sql1);
         		
				int company=0;	
				int chk=1;
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
				company=1;
				if(company==1)
				{
					chk=0;
					
					sqltest1=sqltest1+ " vat , ";
				}
				
				else
				{
					chk=1;
					sqltest+=" and inv.status=3 ";		
					
				}
				
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(inv.date),'/',inv.voc_no)";
				}
				else{
					sqlvocno="inv.voc_no";
				}
				
				String strshowfleet="select method from gl_config where field_nme='invListShowFleet'";
				int showfleet=0;
				ResultSet rsshowfleet=stmtindian.executeQuery(strshowfleet);
				while(rsshowfleet.next()){
					showfleet=rsshowfleet.getInt("method");
				}
				String showfleetcolumn="";
				if(showfleet==1){
					showfleetcolumn="l.perfleet 'Fleet No',";
				}
				//Fetching data from view instead direct from db;
				String sql="select if(inv.ratype='RAG',rtarif.rentaltype,'Lease') 'Tarif Type',convert("+sqlvocno+",char(25)) as 'Doc No',br.branchname 'Branch',inv.date Date,h.description 'Account Name',h.account Account,inv.ratype 'RA Type',"+
				" if(inv.ratype='RAG',r.voc_no,l.voc_no) 'RA No',"+showfleetcolumn+"inv.fromdate 'From Date',inv.todate 'To Date',"
				+ "if(inv.status=3,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) 'Total' , "
				+ "if(inv.status=7,convert(coalesce(coalesce(sum(rent),0.0)+coalesce(sum(inschg),0.0)+coalesce(sum(accchg),0.0)+coalesce(sum(salik), 0.0)+coalesce(sum(saliksrv),0.0)+coalesce(sum(traffic),0.0)+coalesce(sum(trafficsrv),0.0)+coalesce(sum(others),0.0)+ coalesce(sum(vat),0.0),0),char(50)),0) 'Deleted Total' "
				+ ",coalesce(sum(rent),0.0) rent,coalesce(sum(inschg),0.0) inschg,"+
				" coalesce(sum(accchg),0.0) accchg,(coalesce(sum(salik),0.0)+coalesce(sum(saliksrv),0.0)) salik,(coalesce(sum(traffic),0.0)+"+
				" coalesce(sum(trafficsrv),0.0)) traffic,coalesce(sum(others),0.0) other, coalesce(sum(vat),0.0) vat,"+
				" ms.sal_name 'Salesman',if(inv.ratype='RAG',r.mrano,l.manualra) 'MRA NO',if(inv.status=7,'Deleted','') status from invoice_view inv "+
				" left join my_acbook ac on ac.doc_no=inv.cldocno and  ac.dtype='CRM' left join gl_lagmt l on l.doc_no=inv.rano and inv.ratype='LAG' left join"+
				" gl_ragmt r on r.doc_no=inv.rano and inv.ratype='RAG' left join gl_rtarif rtarif on (r.doc_no=rtarif.rdocno and rtarif.rstatus=5) left join  my_head h on h.doc_no=inv.acno left join my_brch br"+
				" on inv.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where inv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest +" "+
				" group by inv.doc_no order by inv.doc_no";
						
	            				
				/*	String sql ="select convert("+sqlvocno+",char(25)) as 'Doc No',m.date Date,h.description 'Account Name',h.account Account,m.ratype 'RA Type', "
							+ " 	if(m.ratype='RAG',r.voc_no,l.voc_no) 'RA No',m.fromdate 'From Date'   ,m.todate  'To Date' , "
							+ " 	convert(coalesce(sum(d.total),''),char(50)) Amount , convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),  "
							+ " ' '),char(50)) 'Rental Sum', convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50))  "
							+ " 'Insurance Charges', convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) Acc_Sum,  "
							+ "  convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) 'Salik Amt',"+sqltest1 +" "
									+ "	    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) 'Traffic Amt' ,"
							+ "    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) 'Other Charges' , ms.sal_name 'Salesman',	"
							+ "     if(m.ratype='RAG',r.mrano,l.manualra) 'MRA NO' ,if(m.status='7','Cancelled','') Status  from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
							+ "     left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano  AND M.RATYPE='LAG'"
							+ "      left join gl_ragmt r on r.doc_no=m.rano  AND M.RATYPE='RAG' left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where  "           				
	            				+ " m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";*/
	       //System.out.println("============"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=convertToJSON(resultSet);//  convertToJSON(resultSet);
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
	    
	 
	 
		public  JSONArray convertToJSON(ResultSet resultSet)
				throws Exception {
				JSONArray jsonArray = new JSONArray();
				
				while (resultSet.next()) {
				int total_rows = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < total_rows; i++) {
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
				}
				jsonArray.add(obj);
				}
				//System.out.println("ConvertTOJson:   "+jsonArray);
				return jsonArray;
				}
			 
	 
	 
	 
}
