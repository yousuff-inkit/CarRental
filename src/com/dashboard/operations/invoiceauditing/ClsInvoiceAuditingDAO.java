package com.dashboard.operations.invoiceauditing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceAuditingDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public String getCreditVatAmt(Connection conn,String strcreditarray,int cldocno,java.sql.Date sqlbasedate) throws SQLException{
		double vatamt=0.0;
		int vatacno=0;
		try {
			Statement stmt=conn.createStatement();
			int tax=0,clienttax=0;
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttax";
			ResultSet rschecktax=stmt.executeQuery(strchecktax);
			while(rschecktax.next()){
				tax=rschecktax.getInt("taxmethod");
				clienttax=rschecktax.getInt("clienttax");
			}
			
			if(tax==1 && clienttax==1) {
				for(int i=0;i<strcreditarray.split(",").length;i++){
					String detacno=strcreditarray.split(",")[i].split("::")[0];
					String detamt=strcreditarray.split(",")[i].split("::")[1];
					double vatpercent=0.0;
					int vatidno=0;
					String strtax="select coalesce(vat_per,0.0) vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlbasedate+"' between tax.fromdate and tax.todate";
					ResultSet rstax=stmt.executeQuery(strtax);
					while(rstax.next()){
						vatpercent=rstax.getDouble("vat_per");
						vatidno=rstax.getInt("idno");
						vatacno=rstax.getInt("acno");
					}
					String strdettax="select tax from gl_invmode where acno="+detacno;
					int dettax=0;
					ResultSet rsdettax=stmt.executeQuery(strdettax);
					while(rsdettax.next()) {
						dettax=rsdettax.getInt("tax");
					}
					if(dettax==1) {
						double currentvatamt=(Double.parseDouble(detamt)*(vatpercent/100));
						vatamt+=currentvatamt;
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return vatamt+"::"+vatacno;
	}
	public   JSONArray getAgmtSearchData(String sclname,String smob,String rno,String flno,String sregno,String smra,String branch,String id,String agmttype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
    	if(!id.equalsIgnoreCase("1")) {
    		return RESULTDATA;
    	}
    	String sqltest="";

    	Connection conn =null;
		try {
			conn=objconn.getMyConnection();
	    	if(!(sclname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+sclname+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob like '%"+smob+"%'";
	    	}
	    	if(!(rno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and agmt.voc_no like '%"+rno+"%'";
	    	}
	    	if(!(flno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and v.fleet_no like '%"+flno+"%'";
	    	}
	    	if(!(sregno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and v.reg_no like '%"+sregno+"%'";
	    	}
	    	if(!(smra.equalsIgnoreCase(""))){
	    		if(agmttype.equalsIgnoreCase("RAG")) {
	    			sqltest=sqltest+" and agmt.mrano like '%"+smra+"%'";
	    		}
	    		else if(agmttype.equalsIgnoreCase("LAG")) {
	    			sqltest=sqltest+" and agmt.manualra like '%"+smra+"%'";
	    		}
	    		
	    	}
	    	sqltest+=" and r.status<>7";
		 
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and r.brchid="+branch;
			}
			sqltest+=" and r.invaudit=0";
	    	//System.out.println(sqltest);
	    	Statement stmtVeh7 = conn.createStatement ();
	    	String strsql="";
	    	if(agmttype.equalsIgnoreCase("RAG")) {
	    		strsql="select agmt.doc_no agmtdocno,agmt.voc_no agmtvocno,r.voc_no voucherno,agmt.voc_no,r.agmtno,r.doc_no,r.fleet_no,v.reg_no,a.RefName,a.per_mob,agmt.mrano from gl_ragmtclosem r left join gl_ragmt agmt on r.agmtno=agmt.doc_no "+
						" left join gl_vehmaster v on v.fleet_no=agmt.fleet_no left join my_acbook a on (a.cldocno= r.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by r.doc_no order by r.doc_no";
	    	}
	    	else {
	    		strsql="select agmt.doc_no agmtdocno,agmt.voc_no agmtvocno,r.voc_no voucherno,agmt.voc_no,r.agmtno,r.doc_no,v.fleet_no,v.reg_no,a.RefName,a.per_mob,agmt.manualra mrano from gl_lagmtclosem r left join gl_lagmt agmt on r.agmtno=agmt.doc_no "+
				" left join gl_vehmaster v on (v.fleet_no=agmt.perfleet or v.fleet_no=agmt.tmpfleet) left join my_acbook a on (a.cldocno= r.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by r.doc_no  order by r.doc_no";
	    	}
	    	System.out.println("=========="+strsql);
			ResultSet resultSet = stmtVeh7.executeQuery (strsql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtVeh7.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		conn.close();
        return RESULTDATA;
    }
	
	public JSONArray getInvoiceData(String agmtno,String agmttype,String id) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(agmttype.equalsIgnoreCase("RAG")) {
				sqlfilters=" and m.ratype='RAG' and m.rano="+agmtno+" and m.manual=3";
			}
			else if(agmttype.equalsIgnoreCase("LAG")) {
				sqlfilters=" and m.ratype='LAG' and m.rano="+agmtno+" and m.manual=5";
			}
			String strsql="SELECT @i:=coalesce(@i,0)+1 slno,m.doc_no invdocno,m.tr_no,m.voc_no invvocno,m.date,m.fromdate,m.todate,m.invnote description,round(coalesce(d.total,0),2) amount FROM gl_invm m \r\n" + 
					"LEFT JOIN (select sum(total) total,rdocno from gl_invd d group by rdocno) d ON m.doc_no=d.rdocno,(select @i:=0) i \r\n" + 
					"WHERE m.status=3"+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getInvoiceDetailData(String invdocno,String id) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(!invdocno.equalsIgnoreCase("")) {
				sqlfilters+=" and m.doc_no="+invdocno;
			}
			String strsql="SELECT @i:=coalesce(@i,0)+1 slno,m.doc_no invdocno,m.voc_no invvocno,m.date,m.fromdate,m.todate,md.description,d.units,d.total amount,d.total auditamt,d.acno,d.chid idno FROM gl_invm m \r\n" + 
					" LEFT JOIN gl_invd d ON m.doc_no=d.rdocno"+
					" left join gl_invmode md on d.chid=md.idno and md.status=1,(select @i:=0) i \r\n" + 
					"WHERE m.status=3"+sqlfilters+" and d.chid not in(19,20)";
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
}
