package com.dashboard.limousine.invoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceListDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray gridData(String fromdate,String todate,String cldocno,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",sqltest1="";
			 
			java.sql.Date sqlfromdate=null,sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and inv.date>='"+sqlfromdate+"'";
			}
			
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and inv.date<='"+sqltodate+"'";
			}
			
			if(!cldocno.equalsIgnoreCase("")) {
				sqltest+=" and inv.cldocno='"+cldocno+"'";
			}
		    
			String strsql="select coalesce(sum(invd.vatvalue),0)+coalesce(sum(invd.total),0) nettotal, max(invd.vatpercent) vatpercent, sum(invd.vatvalue) vatvalue, bm.voc_no bookno, bm.vesselno,bm.vesselname,sum(invd.total) total,inv.doc_no,inv.voc_no,inv.date,inv.cldocno,ac.refname,ac.per_mob,ac.mail1,ac.address,inv.fromdate,inv.todate,inv.ledgernote," + 
					"inv.invoicenote,inv.fromdate,inv.todate,bm.refno from gl_limoinvm inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoinvd invd on inv.doc_no=invd.rdocno left join gl_limobookm bm on bm.doc_no=invd.bookdocno" + 
					" where inv.status=3 "+sqltest+" group by inv.doc_no order by inv.doc_no ";
		       
			//System.out.println("strsql==>"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	}  
	
	public JSONArray gridDetailData(String fromdate,String todate,String cldocno,String id)throws SQLException{
		JSONArray invoicedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return invoicedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			
          java.sql.Date sqlfromdate=null,sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and inv.date>='"+sqlfromdate+"'";
			}
			
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and inv.date<='"+sqltodate+"'";
			}
			
			if(!cldocno.equalsIgnoreCase("")) {
				sqltest+=" and inv.cldocno='"+cldocno+"'";    
			}
			
			String strsql="select coalesce(invd.vatvalue,0)+coalesce(invd.total,0) nettotal, invd.vatpercent,invd.vatvalue,inv.doc_no,cp.location pickuploc, cd.location dropoffloc,bm.voc_no bookno, bm.vesselno,bm.vesselname,invd.total,ac.refname,inv.voc_no,invd.guestno,guest.guest,invd.jobtype,invd.jobdocno,invd.bookdocno,invd.jobname jobnametemp,invd.tarif,invd.nighttarif,"+
					" invd.exkmchg excesskmchg,invd.exhrchg excesshrchg,invd.exnighthrchg excessnighthrchg,invd.fuelchg,invd.parkingchg,invd.otherchg,invd.greetchg,invd.vipchg,"+
					" invd.boquechg,bm.refno from gl_limoinvm inv left join gl_limoinvd invd on inv.doc_no=invd.rdocno left join gl_limoguest guest on invd.guestno=guest.doc_no left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limobookm bm on bm.doc_no=invd.bookdocno left join gl_limobooktransfer bt on bm.doc_no=bt.bookdocno left join gl_cordinates cp on cp.doc_no=bt.pickuplocid left join gl_cordinates cd on cd.doc_no=bt.dropfflocid where inv.status=3 "+sqltest+" order by inv.doc_no";
			//System.out.println("strsqldetail==>"+strsql);   
			ResultSet rs=stmt.executeQuery(strsql);
			invoicedata=objcommon.convertToJSON(rs);
			
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invoicedata;
	}
}