package com.dashboard.analysis.taskmanagement;    
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsTaskManagementDAO {  

	ClsConnection connObj=new ClsConnection();     
	ClsCommon cmnObj=new ClsCommon();
	Connection conn;  
	 
	public JSONArray pendingGrid(String userid, String fromdate, String todate, String fromdtchk, String id) throws SQLException {      
        JSONArray RESULTDATA=new JSONArray();    
        Connection conn = null;
        if(!id.equals("1")) {
        	return RESULTDATA;
        }
		try {
				conn = connObj.getMyConnection();
				Statement stmt = conn.createStatement ();
				java.sql.Date sqlfromdate = null;
				java.sql.Date sqltodate = null;
				String sqltest="";
				
				if(fromdtchk.equals("1")) {  
					if(!fromdate.equals("") && fromdate!=null) {
						sqlfromdate = cmnObj.changeStringtoSqlDate(fromdate);
						sqltest += " and strt_date>='"+sqlfromdate+"'";
					}
				}else {
					sqltest += " and t.close_status=0";            
				}
				
				if(!todate.equals("") && todate!=null) {
					sqltodate = cmnObj.changeStringtoSqlDate(todate);
					sqltest += " and strt_date<='"+sqltodate+"'";
				}
				
				String sql = "select * from my_user where doc_no='"+userid+"' and role_id=1";
				ResultSet rs1 = stmt.executeQuery(sql);
				if(rs1.next()){            
				}else{
					sqltest += " and (t.userid='"+userid+"' or t.ass_user='"+userid+"')";
				}
				
				String strsql="select a.*, @i:=@i+1 slno from(select u1.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,tt.reftype ref_type,ref_no,strt_date,strt_time,description,act_status status,t.edcdate from an_taskcreation t "
						+ "left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user left join my_user u1 on u1.doc_no=t.userid  left join an_tasktype tt on tt.doc_no=t.ref_type "
						+ "where 1=1 "+sqltest+" group by doc_no)a,(select @i:=0)b"; 
			    //System.out.println("pendingGrid--->>>"+strsql);     
				ResultSet rs = stmt.executeQuery(strsql);
				
				RESULTDATA=cmnObj.convertToJSON(rs);  
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
	
	public JSONArray loadflwupgrid(String docno,  String id) throws SQLException{ 
		JSONArray RESULTDATA=new JSONArray(); 
		Connection conn=null; 
		if(!id.equals("1")) {
        	return RESULTDATA;
        }
		try{
			conn=connObj.getMyConnection(); 
			Statement stmt=conn.createStatement(); 
	
			String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f "
					+ "left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
			//System.out.println("flwp--->>>"+strsql); 
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=cmnObj.convertToJSON(rs);   
		} 
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close(); 
		}
	    return RESULTDATA;
	}
	
	public JSONArray scheduleGrid(String id) throws SQLException{ 
		JSONArray RESULTDATA=new JSONArray(); 
		Connection conn=null; 
		if(!id.equals("1")) {
        	return RESULTDATA;
        }
		try{
			conn=connObj.getMyConnection(); 
			Statement stmt=conn.createStatement(); 
	
			String strsql = "SELECT s.type typeid, t.reftype type, DATE_FORMAT(s.lastdate, '%d.%m.%Y') date, s.remarks FROM an_schedule s LEFT JOIN an_tasktype t ON t.doc_no=s.type WHERE s.status=3";     
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=cmnObj.convertToJSON(rs);   
		} 
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close(); 
		}
	    return RESULTDATA;
	}
}
