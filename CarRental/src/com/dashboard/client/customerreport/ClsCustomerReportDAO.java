package com.dashboard.client.customerreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 

 
public class ClsCustomerReportDAO

{
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

		
	public  JSONArray clientDetailsFrom(String accountname,String chck,String account,String mob) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
     
        if(!chck.equals("1")) {
          return RESULTDATA;  
        }
        String sqltest="";
       
        Connection conn = null;
        if(!(accountname.equalsIgnoreCase("")) && !(accountname.equalsIgnoreCase("")) && !(accountname.equalsIgnoreCase(null))){
            sqltest+=" and ac.refname like '%"+accountname+"%'";
        }
        if(!(account.equalsIgnoreCase("")) && !(account.equalsIgnoreCase("")) && !(account.equalsIgnoreCase(null))){
            sqltest+=" and ac.acno like '%"+account+"%'";
        }
        if(!(mob.equalsIgnoreCase("")) && !(mob.equalsIgnoreCase("")) && !(mob.equalsIgnoreCase(null))){
            sqltest+=" and ac.per_mob like '%"+mob+"%'";
        }
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); // UAL - UNallocated ,ANI - allocated not  Invoiced, AIN- allocated Invoiced , POS -traffic posted, RES - Received
				String sql=" SELECT ac.refname refname,ac.cldocno cldocno FROM my_acbook ac LEFT JOIN my_clcatm cat ON ac.catid=cat.DOC_NO WHERE ac.status=3 AND ac.dtype='CRM' AND cat.actualclient=1"+sqltest+""; 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	
     				conn.close();
		}
		catch(Exception e){
			conn.close();
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public JSONArray rentalSearchList(String brval, String acno, String chck,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        if (!chck.equals("1")) {
            return RESULTDATA;
        }
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
            sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
     }
    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
     }


        Connection conn = null;   

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement();   
      
            String sql = "   select @i:=@i+1 slno,a.* from(select date_format( invm.date ,'%d.%m.%Y')invdate,invm.dtype invtype, invm.ratype renttype,invm.voc_no invno,m.flname,m.fleet_no vplate,ac.refname cusname,ac.acno cusaccno,pl.code_name,concat(date_format(invm.fromdate,'%d.%m.%Y'),' - ',date_format(invm.todate,'%d.%m.%Y')) invperd,invd.total invamt,if(r.voc_no is not null or r.voc_no!='',r.odate,if(l.voc_no is null or l.voc_no='',null,l.outdate)) vehoutdate,convert(if(invm.ratype='RAG',r.voc_no,if(invm.ratype='LAG',l.voc_no,'')),char(40)) agmntnum,cat.category catgry,if(r.voc_no is not null or r.voc_no!='',r.pono,if(l.voc_no is null or l.voc_no='','',l.po)) lpono" + 
                    "     from gl_invm invm left join gl_invd invd on invm.doc_no=invd.rdocno left join my_acbook ac on ac.cldocno=invm.cldocno and ac.dtype='crm' left join my_head mh on ac.acno=mh.doc_no left join gl_lagmt l on l.doc_no=invm.rano and invm.ratype='LAG' left join gl_ragmt r on r.doc_no=invm.rano and invm.ratype='RAG' left join gl_vehmaster m on r.fleet_no=m.fleet_no or if(l.perfleet=0,l.tmpfleet,l.perfleet)=m.fleet_no left join my_clcatm cat on ac.catid=cat.doc_no left join gl_vehplate pl on pl.doc_no = m.PLTID     where invm.cldocno="+acno+" and invd.chid not in (8,15,9,14,38,39) and invm.date between '"+sqlFromDate+"' and '"+sqlToDate+"' group by invm.doc_no)a,(select @i:=0)b";
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
            stmtVeh.close();
            conn.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();

        }
        // System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
    public JSONArray trafficfineList(String brval, String acno, String chck,String fromdate,String todate) throws SQLException {
        
        JSONArray RESULTDATA = new JSONArray();
        if (!chck.equals("1")) {
            return RESULTDATA;
        }
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
            sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
     }
    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
     }
        
        
  
        
        Connection conn = null;   
        
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement();   
            
            String sql = "select @i:=@i+1 slno,a.* from(select t.ticket_no tfnum, date_format(t.traffic_date ,'%d.%m.%Y') tdate,time,invm.date invdate,invm.dtype invtype, invm.ratype rentltype,invm.voc_no invno,invm.ratype agmtype,m.flname,m.fleet_no pltnum,ac.refname cusname,ac.acno cusacno,pl.code_name,concat(date_format(invm.fromdate,'%d.%m.%Y'),' - ',date_format(invm.todate,'%d.%m.%Y')) invperiod,t.amount amount,if(r.voc_no is not null or r.voc_no!='',r.odate,if(l.voc_no is null or l.voc_no='',l.outdate,null)) outdate,convert(if(invm.ratype='RAG',r.voc_no,if(invm.ratype='LAG',l.voc_no,'')),char(40)) agreemnt,cat.category catgry,if(r.voc_no is not null or r.voc_no!='',r.pono,if(l.voc_no is null or l.voc_no='','',l.po)) lpono,t.inv_desc description" + 
                    "     from gl_invm invm inner join gl_traffic t on t.inv_no=invm.doc_no and t.inv_type in ('inv','int') left join my_acbook ac on ac.cldocno=invm.cldocno and ac.dtype='crm' left join my_head mh on ac.acno=mh.doc_no left join gl_lagmt l on l.doc_no=invm.rano and invm.ratype='LAG' left join gl_ragmt r on r.doc_no=invm.rano and invm.ratype='RAG' left join gl_vehmaster m on r.fleet_no=m.fleet_no or if(l.perfleet=0,l.tmpfleet,l.perfleet)=m.fleet_no left join my_clcatm cat on ac.catid=cat.doc_no left join gl_vehplate pl on pl.doc_no = m.PLTID  where invm.cldocno="+acno+" and invm.date between '"+sqlFromDate+"' and '"+sqlToDate+"')a,(select @i:=0)b";
           
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
            stmtVeh.close();
            conn.close();
            
            conn.close();
        } catch (Exception e) {
            conn.close();
            
        }
        // System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray tollSearchList(String brval, String acno, String chck,String fromdate,String todate) throws SQLException {
        
        JSONArray RESULTDATA = new JSONArray();
        if (!chck.equals("1")) {
            return RESULTDATA;
        }
        
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
            sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
     }
    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
     }
 
        
        Connection conn = null;   
        
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement();   
            
            String sql = "select @i:=@i+1 slno,a.* from(select t.trans tollgate, date_format(t.salik_date,'%d.%m.%Y')tripdate,t.salik_time triptime,invm.date invdate,invm.dtype invtype, invm.ratype agmnttype,invm.voc_no invno,invm.ratype renttype,m.flname,m.fleet_no pltnum,ac.refname cusname,ac.acno cusacno,pl.code_name,concat(date_format(invm.fromdate,'%d.%m.%Y'),' - ',date_format(invm.todate,'%d.%m.%Y')) invperiod,t.amount amt,if(r.voc_no is not null or r.voc_no!='',r.odate,if(l.voc_no is null or l.voc_no='',l.outdate,null)) outdate,convert(if(invm.ratype='RAG',r.voc_no,if(invm.ratype='LAG',l.voc_no,'')),char(40)) agmnt,cat.category catgry, t.direction direction,if(r.voc_no is not null or r.voc_no!='',r.pono,if(l.voc_no is null or l.voc_no='','',l.po)) lpono  " + 
                    "     from gl_invm invm inner join gl_salik t on t.inv_no=invm.doc_no  and t.inv_type in ('inv','ins') left join my_acbook ac on ac.cldocno=invm.cldocno and ac.dtype='crm' left join my_head mh on ac.acno=mh.doc_no left join gl_lagmt l on l.doc_no=invm.rano and invm.ratype='LAG' left join gl_ragmt r on r.doc_no=invm.rano and invm.ratype='RAG' left join gl_vehmaster m on r.fleet_no=m.fleet_no or if(l.perfleet=0,l.tmpfleet,l.perfleet)=m.fleet_no left join my_clcatm cat on ac.catid=cat.doc_no left join gl_vehplate pl on pl.doc_no = m.PLTID    where invm.cldocno="+acno+" and invm.date between '"+sqlFromDate+"' and '"+sqlToDate+"')a,(select @i:=0)b";
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
            stmtVeh.close();
            conn.close();
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            
        }
        // System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public JSONArray damageSearchList(String brval, String acno, String chck,String fromdate,String todate) throws SQLException {
        
        JSONArray RESULTDATA = new JSONArray();
        if (!chck.equals("1")) {
            return RESULTDATA;
        }
        
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
            sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
     }
    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
            sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
     }
   
        
        Connection conn = null;   
        
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtVeh = conn.createStatement();   
            
            String sql ="select @i:=@i+1 slno,a.* from(select date_format(t.date ,'%d.%m.%Y') ddate,t.time dtime, t.reftype agmnttype,t.invno invno,t.reftype renttype,m.flname,m.fleet_no pltnum,ac.refname cusname,ac.acno cusacno,pl.code_name,concat(date_format(invm.fromdate,'%d.%m.%Y'),' - ',date_format(invm.todate,'%d.%m.%Y')) invperiod,t.amount amount,if(r.voc_no is not null or r.voc_no!='',r.odate,if(l.voc_no is null or l.voc_no='','',l.outdate)) outdate,if(r.voc_no is not null or r.agmt_no!='',r.agmt_no,if(l.agmt_no is null or l.agmt_no='','',l.agmt_no)) agmt_no,cat.category catgry,invm.ldgrnote description,if(r.voc_no is not null or r.voc_no!='',r.pono,if(l.voc_no is null or l.voc_no='','',l.po)) lpono   " + 
                    " from gl_invm invm left join gl_invd invd on invm.doc_no=invd.rdocno left join my_acbook ac on ac.cldocno=invm.cldocno and ac.dtype='crm' left join my_head mh on ac.acno=mh.doc_no left join gl_lagmt l on l.doc_no=invm.rano and invm.ratype='LAG' left join gl_ragmt r on r.doc_no=invm.rano and invm.ratype='RAG' left join gl_vehmaster m on r.fleet_no=m.fleet_no or if(l.perfleet=0,l.tmpfleet,l.perfleet)=m.fleet_no left join my_clcatm cat on ac.catid=cat.doc_no left join gl_vehplate pl on pl.doc_no = m.PLTID left join gl_vinspm t on t.invno=invm.doc_no  and t.invtype in ('inv','ind')   where invm.cldocno="+acno+" and invd.chid in (10) and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"')a,(select @i:=0)b"; 
            ResultSet resultSet = stmtVeh.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            
            stmtVeh.close();
            conn.close();
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            
        }
        // System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}