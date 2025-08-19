package com.operations.clientrelations.nationality;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsNationalityDAO {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsNationalityBean nationalityBean = new ClsNationalityBean();
	Connection conn = null;
	
	public int insert(String formdetailcode,int docno,String name, HttpSession session, String mode) throws SQLException {
//System.out.println("name------"+name);
		try{
			int aaa;
			conn=connDAO.getMyConnection();
			Statement stmtCAT1 = conn.createStatement();
			
			
			  String branch = session.getAttribute("BRANCHID").toString(); String userid =
			  session.getAttribute("USERID").toString();
			
		
			
		   String sqls="select nation name from my_natm where nation='"+name+"'";
		   ResultSet resultSet1 = stmtCAT1.executeQuery(sqls);
		   if(resultSet1.next()){
			   stmtCAT1.close();
				conn.close();
				return -1;
			}  
			CallableStatement stmtCAT = conn.prepareCall("{CALL nationalityDML(?,?,?,?,?,?)}");
			
		    stmtCAT.registerOutParameter(4, java.sql.Types.INTEGER); 
			stmtCAT.setString(1,name);
			stmtCAT.setString(6,formdetailcode);
			stmtCAT.setString(3,branch);
			stmtCAT.setString(2,userid);
			stmtCAT.setString(5,mode);
			stmtCAT.executeQuery();
			aaa=stmtCAT.getInt("docNo");
			nationalityBean.setDocno(aaa);
			if (aaa > 0) {
				stmtCAT.close();
				conn.close();
				return aaa;
			}
		 stmtCAT.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();  
		}
		return 0;
	}
	
	public int edit(String formdetailcode, int docno,String name,HttpSession session, String mode) throws SQLException {
		//System.out.println("docno2------"+docno);
		try{
		     conn=connDAO.getMyConnection();
		     Statement stmtCAT1 = conn.createStatement();
		    
			 String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
		    
		   String sqls="select nation from my_natm where nation='"+name+"' and doc_no<>'"+docno+"'";
			   ResultSet resultSet2 = stmtCAT1.executeQuery(sqls);
			   if(resultSet2.next()){
				   stmtCAT1.close();
					conn.close();
					return -1;
				}  
			   
			CallableStatement stmtCAT = conn.prepareCall("{CALL nationalityDML(?,?,?,?,?,?)}");
			
			stmtCAT.setString(1,name);
			stmtCAT.setInt(4,docno);
			stmtCAT.setString(3,branch);
			stmtCAT.setString(2,userid);
			stmtCAT.setString(5,mode);
			stmtCAT.setString(6,formdetailcode);
			int aa = stmtCAT.executeUpdate();
			
			//nationalityBean.setDocno(docno);
			if (aa > 0) {
				stmtCAT.close();
				conn.close();
				return 1;
		    }
		stmtCAT.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

 public List<ClsNationalityBean> list(String check) throws SQLException {
        List<ClsNationalityBean> listBean = new ArrayList<ClsNationalityBean>();

        if(!(check.equalsIgnoreCase("1"))){
        	 return listBean; 
        }
        
        Connection conn = null;
          
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
				ResultSet resultSet = stmtCAT.executeQuery ("select doc_no,nation name from my_natm");
				while (resultSet.next()) {
					
					ClsNationalityBean bean = new ClsNationalityBean();
					bean.setTxtname(resultSet.getString("name"));
					bean.setDocno(resultSet.getInt("doc_no"));
	            	listBean.add(bean);
				}  
			stmtCAT.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return listBean;
    }
   
      public JSONArray nationality() throws SQLException {
       JSONArray RESULTDATA=new JSONArray();
       
       Connection conn = null;
		
       try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
           	    
				String sql="select nation name,doc_no  from my_natm;";
           	    
				ResultSet resultSet = stmtCAT.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
			stmtCAT.close();
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
