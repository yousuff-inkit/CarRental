package com.dashboard.operations.agmtpaymentupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgmtPaymentupdateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getPaymentData(String agmtno,String amount,String id) throws SQLException{
    	JSONArray chequedata=new JSONArray();
    	if(!id.equalsIgnoreCase("1")){
    		return chequedata;
    	}
    	Connection conn=null;
    	try{
    		conn=objconn.getMyConnection();
    		Statement stmt=conn.createStatement();
    		java.sql.Date sqlfromdate=null,sqltodate=null;
    		   
    		String strsql="select if(calc.markstatus>0,1,0) invstatus,agmt.date,ac.cldocno,ac.refname refname,ac.refname chqname,agmt.voc_no agmtvocno,agmt.doc_no agmtno,calc.srno detaildocno,calc.date chequedate,calc.amount,calc.bpvno,"+
    		" calc.chequeno from gl_leasepytcalc calc left join gl_lagmt agmt on (calc.rdocno=agmt.doc_no) left join my_acbook ac on "+
    		" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_unclrchqreceiptm uncl on "+
    		" (calc.bpvno=uncl.doc_no and agmt.brhid=uncl.brhid)where calc.rdocno="+agmtno+" and calc.status=3";
    		//System.out.println("paymentdata==========="+strsql);
    		ResultSet rs=stmt.executeQuery(strsql);
    		chequedata=objcommon.convertToJSON(rs);
    		stmt.close();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    	finally{
    		conn.close();
    	}
    	return chequedata;
    }
	
	
	public JSONArray getAgmtData(String fromdate,String todate,String agmttype,String agmtno,String branch,String id) throws SQLException{
    	JSONArray chequedata=new JSONArray();
    	if(!id.equalsIgnoreCase("1")){
    		return chequedata;
    	}
    	Connection conn=null;
    	try{
    		conn=objconn.getMyConnection();
    		Statement stmt=conn.createStatement();
    		java.sql.Date sqlfromdate=null,sqltodate=null;
    		if(!fromdate.equalsIgnoreCase("")){
    			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
    		}
    		if(!todate.equalsIgnoreCase("")){
    			sqltodate=objcommon.changeStringtoSqlDate(todate);
    		}
    		String sqltest="";
    		if(fromdate!=null){
    			sqltest+=" and agmt.date>='"+sqlfromdate+"'";
    		}
    		if(todate!=null){
    			sqltest+=" and agmt.date<='"+sqltodate+"'";
    		}
    		if(!agmtno.equalsIgnoreCase("")){
    			sqltest+=" and agmt.doc_no="+agmtno+"";
    		}
    		
    		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
    			sqltest+=" and agmt.brhid="+branch;
    		}
    		String strsql="select ac.acno acno,agmt.pyttotalrent pyttotalrent,agmt.pytadvance pytadvance,agmt.pytbalance pytbalance,agmt.pytstartdate pytstartdate,agmt.pytmonthno pytmonthsno, agmt.doc_no agmtno,agmt.voc_no agmtvocno,ac.refname,ac.cldocno,agmt.date,calc.amount,veh.flname,veh.fleet_no,veh.reg_no from "+
    	            " gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join"+
    	            " (select sum(amount) amount,rdocno from gl_leasepytcalc where status=3 group by rdocno) calc on (agmt.doc_no=calc.rdocno) left join gl_vehmaster "+
    	            " veh on (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.status=3 and agmt.clstatus=0 "+sqltest+" "+
    	            " group by agmt.doc_no";
    	        
    		//System.out.println("Default Agmt Query: "+strsql);
    		ResultSet rs=stmt.executeQuery(strsql);
    		chequedata=objcommon.convertToJSON(rs);
    		stmt.close();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    	finally{
    		conn.close();
    	}
    	return chequedata;
    	
    }
	
public JSONArray accountsDetails(HttpSession session,String dtype,String accountno,String accountname,String currency,String date,String date1,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        //System.out.println("IN"+check);
        Connection conn = null; 
        if(!check.equals("1")){
            return RESULTDATA;
          }
         try {
           
               conn = objconn.getMyConnection();
               Statement stmt = conn.createStatement();
    
               
               String branch=session.getAttribute("BRANCHID").toString();
               String company = session.getAttribute("COMPANYID").toString();
               String den= "";
               
               /*
                * if(dtype.equalsIgnoreCase("CPV") || dtype.equalsIgnoreCase("CRV")){
                * den="604";
                * }
                * else if(dtype.equalsIgnoreCase("BPV") || dtype.equalsIgnoreCase("BRV")){
                * den="305";
                * }
                * else if(dtype.equalsIgnoreCase("ICPV") || dtype.equalsIgnoreCase("ICRV")){
                * den="604";
                * }
                * else if(dtype.equalsIgnoreCase("ICCP") || dtype.equalsIgnoreCase("ICCR")){
                * den="604";
                * }
                * else if(dtype.equalsIgnoreCase("IBP") || dtype.equalsIgnoreCase("IBR")){
                * den="305";
                * }
                * else if(dtype.equalsIgnoreCase("ICBP") || dtype.equalsIgnoreCase("ICBR")){
                * den="305";
                * }
                * else if(dtype.equalsIgnoreCase("PC") || dtype.equalsIgnoreCase("ICPC") ||
                * dtype.equalsIgnoreCase("MCP")){
                * den="604";
                * }
                * else if(dtype.equalsIgnoreCase("BRCN") || dtype.equalsIgnoreCase("UCP")){
                * den="305";
                * }
                * else if(dtype.equalsIgnoreCase("SEC") || dtype.equalsIgnoreCase("RRP")){
                * den="305";
                * }
                * else if(dtype.equalsIgnoreCase("UCR") || dtype.equalsIgnoreCase("MCP")){
                * den="305";
                * }
                */
               java.sql.Date sqlDate=null;
               java.sql.Date sqlDate1=null;
              
               if(check.equalsIgnoreCase("1")){
                   
               date.trim();
               if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
               {
                   sqlDate = objcommon.changeStringtoSqlDate(date);
               }
               date1.trim();
               if(!(date1.equalsIgnoreCase("undefined"))&&!(date1.equalsIgnoreCase(""))&&!(date1.equalsIgnoreCase("0")))
               {
                   sqlDate1 = objcommon.changeStringtoSqlDate(date1);
               }
                String sqltest="";
                String sql="";
                
                if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                    sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                }
                if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                 sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                }
                if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                     sqltest=sqltest+" and c.code like '%"+currency+"%'";
                }
                
                    
                /*sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
                    + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
                    + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='"+den+"'"+sqltest;*/
                    
                sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
                  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
                  + "where coalesce(toDate,curdate())>='"+sqlDate1+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
                  + "where t.atype='GL' and t.m_s=0 and t.den=305"+sqltest;
                //System.out.println("agmtbank===== "+sql);
               ResultSet resultSet = stmt.executeQuery(sql);
               RESULTDATA=objcommon.convertToJSON(resultSet);
               
               stmt.close();
               conn.close();
               }
              stmt.close();
              conn.close();   
         }
         catch(Exception e){
              e.printStackTrace();
              conn.close();
         }finally{
                conn.close();
            }
           return RESULTDATA;
      }
    
	
	public JSONArray getAgmtSearchData(String agmtno,String clientname,String clientmobile,String clientmail,String id,String agmtdate) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no like '%"+agmtno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmobile+"%'";
			}
			if(!clientmail.equalsIgnoreCase("")){
				sqltest+=" and ac.mail1 like '%"+clientmail+"%'";
			}
			if(!agmtdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(agmtdate);
			}
			if(sqldate!=null){
				sqltest+=" and agmt.date='"+sqldate+"'";
			}
			strsql="select agmt.date,agmt.doc_no agmtdocno,agmt.voc_no agmtvocno,ac.refname clientname,ac.per_mob clientmobile,ac.mail1 clientmail "+
			" from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where agmt.status=3 and agmt.clstatus=0 "+sqltest;
			//System.out.println("Agmt Search Query : "+strsql);
			ResultSet rsclient=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsclient);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
}
