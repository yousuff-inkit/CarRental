package com.dashboard.humanresource.documentexpirynew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDocumentExpiryNewDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray renewalGridLoad(String check, String documentType) throws SQLException {
	    System.out.println("ENtered MEhtod");
	    JSONArray RESULTDATA=new JSONArray();
	    
	    if(!check.equalsIgnoreCase("1")) {
	    	return RESULTDATA;
	    }
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmnt = conn.createStatement();
				String tableName="";
				if(documentType.trim().equalsIgnoreCase("VISA")) tableName="my_visarenewal";
				else if (documentType.trim().equalsIgnoreCase("RTA CARD")) tableName="my_rtarenewal";
				String sqlLoad="SELECT doc_no docno,status,`desc` from "+tableName;
				//System.out.println("Status Update - "+sqlLoad);
				ResultSet resultSet = stmnt.executeQuery (sqlLoad);
	            
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmnt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray documentExpiryFollowUpGrid(String empdocno,String document,String process,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
            return RESULTDATA;
        }
        Connection conn = null;
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmtCRM = conn.createStatement();
                
                String sql = "SELECT m.date detdate,m.remarks remk,m.fdate,u.user_id user FROM hr_bcde m inner join my_user u on u.doc_no=m.userid where m.empdocno="+empdocno+" "
                        + "and m.document='"+document+"' and m.bibpid=(select rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Document Expiry Mgmt' "
                        + ") and process='"+process+"') group by m.doc_no";
                //System.out.println(sql);
                ResultSet resultSet = stmtCRM.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmtCRM.close();
                conn.close();
        }catch(Exception e){
            e.printStackTrace();
            conn.close();
        }finally{
            conn.close();
        }
        return RESULTDATA;
    }
	
	public JSONArray documentsExpiryGridLoading(String branch,String uptodate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql = "";
				java.sql.Date sqlUpToDate = null;
				 
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				 
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhid="+branch+"";
	    		}
				
				sql = "select 'View' as view, 'Attach' as attach,CONVERT(coalesce(bb.fdate,''),CHAR(100)) followupdate,m.doc_no empdocno,m.codeNo empid,m.name empname,m.pmmob,m.brhid,d.docid,d.expdt expirydate,sd.desc1 doct,CONCAT(sd.desc1,' Expired') document,"
						+ "des.desc1 designation,dep.desc1 department,CONVERT(concat(' Emp. ID : ',coalesce(m.codeNo,' '), ' * ','Employee  : ',coalesce(m.name,' '),' * ','Mobile No. : ' ,coalesce(m.pmmob,' '),' * ','Document : ', "
						+ "coalesce(CONCAT(sd.desc1,' Expired'),' '),' * ','Expiry Date : ', DATE_FORMAT(coalesce(d.expdt,' '),'%d-%m-%Y')),CHAR(1000)) empinfo, COALESCE(vr.status,'') visastatus,COALESCE(rt.status,'') rtastatus from hr_empm m "
						+ "left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_empdoc d on m.doc_no=d.rdocno LEFT JOIN my_visarenewal vr ON vr.doc_no=d.visarenewid LEFT JOIN my_rtarenewal rt ON rt.doc_no=d.rtarenewid left join hr_setdoc sd on sd.doc_no=d.docid "
						+ "left join (select max(doc_no) doc,empdocno,docid from hr_bcde group by empdocno,docid) a on a.empdocno=m.doc_no and a.docid=d.docid left join hr_bcde bb on a.doc=bb.doc_no where m.status=3 and m.active=1 "
						+ "and d.docid is not null and d.expdt<='"+sqlUpToDate+"'"+sql+" order by m.doc_no";
				System.out.println(sql);
				ResultSet resultSet = stmtCRM.executeQuery(sql); 
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray renewallogSheetGridLoad(String check,String docno) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	    
	    if(!check.equalsIgnoreCase("1")) {
	    	return RESULTDATA;
	    }
	    
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmnt = conn.createStatement();
				String sqlLoad="SELECT u.user_name user, cl.date, cl.description  FROM my_docexpirylog cl LEFT JOIN my_user u ON u.DOC_NO=cl.userid WHERE cl.rdocno="+docno;
				//System.out.println("Status Update - "+sqlLoad);
				ResultSet resultSet = stmnt.executeQuery (sqlLoad);
	            
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmnt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
}
