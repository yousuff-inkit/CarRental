package com.dashboard.operations.splitinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSplitInvoiceDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray splitinvoiceGridLoading(String branch,String fromDate, String toDate, String client, String postacc,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
		
		 if((!id.equalsIgnoreCase("1"))){
		    	return RESULTDATA;
		    }

        
		  try {
			  conn = ClsConnection.getMyConnection();
			    Statement stmt = conn.createStatement();
			    java.sql.Date sqlfromdate=null,sqltodate=null;
			    String sql="",sqltest="";
			    if((!fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0") && !fromDate.equalsIgnoreCase("undefined"))){
			    	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
		            sqltest=sqltest+" and m.date >= '"+sqlfromdate+"'";
			    }
			    if((!toDate.equalsIgnoreCase("") && !toDate.equalsIgnoreCase("0") && !toDate.equalsIgnoreCase("undefined"))){
			    	sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
			        sqltest=sqltest+" and m.date <= '"+sqltodate+"'";
				}
			    if(!(branch.equalsIgnoreCase("0")) && !(branch.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and m.brhid = '"+branch+"'";
		        }
			    if(!(client.equalsIgnoreCase("0")) && !(client.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and a.cldocno ='"+client+"'";
		        }
			   
			    System.out.println(branch);
			    System.out.println(client);
			    System.out.println(fromDate);
			    System.out.println(toDate);
				   
			    
			    sql="select m.doc_no invdocno,m.voc_no refno ,a.acno acno,m.doc_no docno, m.voc_no invno,m.brhid,m.date date, r.voc_no rano,a.refname client,driversname,round(totalinv,0)totalinv from gl_invm m INNER join gl_ragmt r on m.rano=r.doc_no and m.ratype='RAG'\r\n"
			    		+ "INNER JOIN (select group_concat(d.name) driversname,rdocno from gl_rdriver rd left join gl_drdetails d on rd.drid=d.dr_id group by rdocno having count(*)>1) RD on rd.rdocno=r.doc_no\r\n"
			    		+ "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm'\r\n"
			    		+ "left join (select sum(total) totalinv,rdocno from gl_invd group by rdocno) id on id.rdocno=m.doc_no where m.status=3 and spitrno=0"+sqltest+"";
			    		 
			    System.out.println(sql);
		  ResultSet resultSet = stmt.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmt.close();
		    conn.close();
	  }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	public   JSONArray splitinvoicedetailGridData(String check,String docno) throws SQLException {
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		
		Connection  conn = null;
		try {

			conn=ClsConnection.getMyConnection();
			Statement stmtdetail = conn.createStatement ();
			strSql="select m.doc_no invdocno,m.voc_no refno,h.doc_no acno,m.doc_no,md.idno docno,h.description account,md.description,round(d.total)total from gl_invm m\r\n"
					+ "left join gl_invd d on m.doc_no=d.rdocno left join gl_invmode md on d.chid=md.idno left join my_head h on d.acno=h.doc_no where m.doc_no="+docno+" and m.status=3;\r\n"
					+ "";
			System.out.println("======"+strSql);
			ResultSet resultSet = stmtdetail.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtdetail.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	
	

	
		public  JSONArray getClient(String id) throws SQLException {
	    Connection conn = ClsConnection.getMyConnection();
	    JSONArray RESULTDATA=new JSONArray();
	   
	      if(!(id.equalsIgnoreCase("1"))){
	    	return RESULTDATA;
	    }
	    
		try {
				
				Statement stmt = conn.createStatement ();
	        	String strSql="";
	        		strSql="select cldocno,refname from my_acbook where dtype='CRM' and status<>7";
	   
	        	System.out.println(strSql);
				ResultSet resultSet = stmt.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}



public  JSONArray getpostacc(String id,String postacc) throws SQLException {
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
    if(!(id.equalsIgnoreCase("1"))){
    	return RESULTDATA;
    }
	try {
			
			Statement stmt = conn.createStatement ();
        	String Sql="";
        		Sql="select m.doc_no  docno,m.account accountnum,m.description description from my_head m where den=340 and m_s=0 ;";
   
        	System.out.println(Sql);
			ResultSet resultSet = stmt.executeQuery (Sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
   }
}



