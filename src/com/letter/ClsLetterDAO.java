package com.letter;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLetterDAO  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();   
	
	 public  JSONArray reGridload(String docno,String dtype,String brchid) throws SQLException {  
	        JSONArray RESULTDATA=new JSONArray();
	        ClsCommon clcom=new ClsCommon();              
	        Connection conn = null;
			     try {
			         conn = ClsConnection.getMyConnection();
			       Statement cpstmt = conn.createStatement();
			       
			       int i=0;
			       String sqls="",sqltst="",docnoss="",dtypess="",sqltest="";  
			       String  cpsql="";
			       String sqlsss="select * from gl_attachtypechk where dtype='"+dtype+"' and status=3";
			       ResultSet rs=cpstmt.executeQuery(sqlsss);
			       if(rs.next())
			       {
			    	   i=1;
			       }
			       
			       if(i==0)
			       {
			    	   sqls= " and a.brhid='"+brchid+"' " ;     
			       }
			       ResultSet rs44=null;
			      // System.out.println("docno--->>>"+docno+"---"+dtype);
			      cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docno+") and a.dtype in ('"+dtype+"') "+sqls+" order by sr_no desc"; 					      
			       //System.out.println("cpsql--->>>"+cpsql);    
			       if((!(docno.equalsIgnoreCase("") || dtype.equalsIgnoreCase(""))) || (!(docnoss.equalsIgnoreCase("") || dtypess.equalsIgnoreCase("")))){  
				       ResultSet resultSet = cpstmt.executeQuery(cpsql);
				       RESULTDATA=clcom.convertToJSON(resultSet);                 
			       }
			       cpstmt.close();  
			       conn.close();
			     }
			     catch(Exception e){
			      e.printStackTrace();
			      conn.close();
			     }
			    finally
			    {
			    	conn.close();
			    }
			     
	           return RESULTDATA;
	       }
}
