package com.humanresource.setup.hrsetup.companysetup;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCompanysetupDAO {
    
    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
   
    public int insert(Date formdate, String company, String estcode, String remarks,String mode, String fromcode, HttpSession session, HttpServletRequest request) throws SQLException {
        
        Connection conn=null;

        try{
            
                conn=ClsConnection.getMyConnection();
                Statement stmtDEP1 = conn.createStatement();
                
                String strSql = "select method from gl_config where field_nme='hrsetupconfig'";
                ResultSet rs = stmtDEP1.executeQuery(strSql);
                
                String method="";
                while(rs.next()) {
                    method=rs.getString("method");
                } 
   
               
               CallableStatement stmtDEP = conn.prepareCall("{CALL HR_companyDML(?,?,?,?,?,?,?,?,?)}");
   
               stmtDEP.setDate(1,formdate);
               stmtDEP.setString(2,estcode);
               stmtDEP.setString(3,remarks);
               stmtDEP.setString(4,company);
               stmtDEP.setString(5,mode);
               stmtDEP.setString(6,session.getAttribute("USERID").toString().trim());
               stmtDEP.setString(7,session.getAttribute("BRANCHID").toString().trim());
               stmtDEP.setString(8,fromcode);
               stmtDEP.executeQuery();
               int  docno=stmtDEP.getInt("docNo");
                   
               if(docno<=0) {
                   conn.close();
                   return 0;
               }        
                   
               if (docno > 0) {
                   stmtDEP.close();
                   stmtDEP1.close();
                   conn.close();
                   return docno;
               }       
       } catch (Exception e) {
           conn.close();
           e.printStackTrace();
       }
       return 0;
   }

public int Update(int docno,Date formdate, String company, String estcode, String remarks,String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
        
        Connection conn=null;

        try{
                    conn=ClsConnection.getMyConnection();
                    Statement stmtDES1 = conn.createStatement();
                    
                    String strSql = "select method from gl_config where field_nme='hrsetupconfig'";
                    ResultSet rs = stmtDES1.executeQuery(strSql);
                    
                    String method="";
                    while(rs.next()) {
                        method=rs.getString("method");
                    } 
                    
                     
                    CallableStatement stmtDEP = conn.prepareCall("{CALL HR_companyDML(?,?,?,?,?,?,?,?,?)}");

                    stmtDEP.setInt(9,docno);

                    // main
                    stmtDEP.setDate(1,formdate);
                    stmtDEP.setString(2,estcode);
                    stmtDEP.setString(3,remarks);
                    stmtDEP.setString(4,company);
                    stmtDEP.setString(5,mode);
                    stmtDEP.setString(6,session.getAttribute("USERID").toString().trim());
                    stmtDEP.setString(7,session.getAttribute("BRANCHID").toString().trim());
                    stmtDEP.setString(8,formdetailcode);
                 

                    int result= stmtDEP.executeUpdate();
                    if(result<=0) {
                        conn.close();
                        return 0;
                    }        
                    
                    if (result > 0) {  
                        stmtDEP.close();
                        conn.close();
                        return docno;
                    }       
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        }
        return 0;
    }

    public int delete(int docno, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {
        
        Connection conn=null;

        try{
            
                    conn=ClsConnection.getMyConnection();
            
                    CallableStatement stmtDEP = conn.prepareCall("{CALL HR_companyDML(?,?,?,?,?,?,?,?,?)}");
                    
                    stmtDEP.setInt(9,docno);

                    // main
                    stmtDEP.setDate(1,null);
                    stmtDEP.setString(2,null);
                    stmtDEP.setString(3,null);
                    stmtDEP.setString(4,null);
                    stmtDEP.setString(5,mode);
                    stmtDEP.setString(6,session.getAttribute("USERID").toString().trim());
                    stmtDEP.setString(7,session.getAttribute("BRANCHID").toString().trim());
                    stmtDEP.setString(8,formdetailcode);
                    
                    int result= stmtDEP.executeUpdate();
                    if(result<=0) {
                        conn.close();
                        return 0;
                    }        
                    
                    if (result > 0) {
                        stmtDEP.close();
                        conn.close();
                        return docno;
                    }       
        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        }
    return 0;
    }
              
                
                
                
public JSONArray estdet() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
         try {
           
               conn = ClsConnection.getMyConnection();
               Statement stmtBSP = conn.createStatement();
                String sqltest="";
                String sql="";
                
      sql="select distinct est_code est_code from hr_empm where status=3 and active=1"+sqltest;
               // System.out.println("est query========"+sql);
               ResultSet resultSet = stmtBSP.executeQuery(sql);
               RESULTDATA=ClsCommon.convertToJSON(resultSet);
               
               stmtBSP.close();
               conn.close();
                stmtBSP.close();
               conn.close();
         } catch(Exception e){
              e.printStackTrace();
              conn.close();
         } finally{
                conn.close();
            }
           return RESULTDATA;
      }


public JSONArray companydet() throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null; 
   
     try {
       
           conn = ClsConnection.getMyConnection();
           Statement stmtBSP = conn.createStatement();
            String sqltest="";
            String sql="";
            
  sql="select distinct co_name co_name from hr_empm where status=3 and active=1"+sqltest;
            //System.out.println("comp query========"+sql);
           ResultSet resultSet = stmtBSP.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtBSP.close();
           conn.close();
            stmtBSP.close();
           conn.close();
     } catch(Exception e){
          e.printStackTrace();
          conn.close();
     } finally{
            conn.close();
        }
       return RESULTDATA;
  }

public JSONArray loadgrid() throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn = null; 
   
     try {
       
           conn = ClsConnection.getMyConnection();
           Statement stmtBSP = conn.createStatement();
           String sql="";
            
  sql="select doc_no doc_no,estcode estcode,comp_name company,date date,remarks remarks from hr_setcomp where status=3";
            //System.out.println("grid query========"+sql);
           ResultSet resultSet = stmtBSP.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtBSP.close();
           conn.close();
            stmtBSP.close();
           conn.close();
     } catch(Exception e){
          e.printStackTrace();
          conn.close();
     } finally{
            conn.close();
        }
       return RESULTDATA;
  }

}
