package com.humanresource.setup.hrsetup.terminationsetup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTerminationSetupDAO {

    ClsConnection ClsConnection=new ClsConnection();

    ClsCommon ClsCommon=new ClsCommon();


    public int insert(int refno, int catid,String mode, String fromcode, HttpSession session, HttpServletRequest request, ArrayList<String> subarray, ArrayList<String> conditionarray, String type ) throws SQLException {    
        Connection conn=null;
        try{
            conn=ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            Statement stmt=conn.createStatement();
            String id = "";
            for(int i=0;i<1;i++){
                String[] subarraydesc=subarray.get(i).split("::");
                
                //System.out.println(subarraydesc[0]+" : "+subarraydesc[1]+" : "+subarraydesc[2]);
                
                id=""+(subarraydesc[0].trim().equalsIgnoreCase("undefined") || subarraydesc[0].trim().equalsIgnoreCase("NaN")|| subarraydesc[0].trim().equalsIgnoreCase("")|| subarraydesc[0].isEmpty()?0:subarraydesc[0].trim())+"";
                int rowno=0;
                String sqls="";
                if(type.equalsIgnoreCase("TER"))
                    sqls="select sr_no rowno from hr_payeost where sr_no='"+id+"' and rdocno='"+refno+"' ";
                else if(type.equalsIgnoreCase("RES")) 
                    sqls="select sr_no rowno from hr_payeosr where sr_no='"+id+"' and rdocno='"+refno+"' ";
                else if(type.equalsIgnoreCase("LEV")) 
                    sqls="select sr_no rowno from hr_payeosl where sr_no='"+id+"' and rdocno='"+refno+"' ";
                //System.out.println("39"+sqls);
                ResultSet rs=stmt.executeQuery(sqls);
                
                if(rs.next()) {
                   rowno=rs.getInt("rowno");
                  // System.out.println("rowno------"+rowno);
                   String sqlss="";
                   if(type.equalsIgnoreCase("TER"))
                       sqlss="delete from hr_payeost where sr_no='"+id+"' and rdocno='"+refno+"' ";
                   else if(type.equalsIgnoreCase("RES"))
                       sqlss="delete from hr_payeosr where sr_no='"+id+"' and rdocno='"+refno+"' ";
                   else if(type.equalsIgnoreCase("LEV"))
                	   sqlss="delete from hr_payeosl where sr_no='"+id+"' and rdocno='"+refno+"' ";
                   
                  // System.out.println("46"+sqlss);
                   stmt.executeUpdate(sqlss);
                      
                   
                   String sqlsss="delete from hr_payeos where refno='"+id+"' and rdocno='"+refno+"' and type='"+type+"'";
                  // System.out.println("51"+sqlsss);
                   stmt.executeUpdate(sqlsss);
                }
//                if(!(subarraydesc[0].trim().equalsIgnoreCase("undefined")|| subarraydesc[0].trim().equalsIgnoreCase("NaN")||subarraydesc[0].trim().equalsIgnoreCase("")|| subarraydesc[0].isEmpty())) {
                    if(rowno>0) {
                        String sql="";
                        if(type.equalsIgnoreCase("TER"))
                            sql="INSERT INTO hr_payeost(sr_no,rdocno,years,days,status)VALUES"
                                + " ('"+rowno+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";
                               
                        else if(type.equalsIgnoreCase("RES"))
                            sql="INSERT INTO hr_payeosr(sr_no,rdocno,years,days,status)VALUES"
                                    + " ('"+rowno+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                    + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";
                        else if(type.equalsIgnoreCase("LEV"))
                            sql="INSERT INTO hr_payeosl(sr_no,rdocno,years,days,status)VALUES"
                                    + " ('"+rowno+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                    + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";
      
                       // System.out.println("Termination SQL ==== "+sql); 
                        int resultSet2 = stmt.executeUpdate(sql);
                               if(resultSet2<=0)
                                  {
                                      conn.close();
                                      return 0;
                                  }
                         }  else { // row no case 
                             String sql="";
                             String maxsql="";
                             String max="";
                             if(type.equalsIgnoreCase("TER")) {
                                 maxsql = "SELECT COALESCE(MAX(sr_no)+1,1) max FROM hr_payeost WHERE rdocno="+refno;
                             } else if(type.equalsIgnoreCase("RES")) {
                                 maxsql = "SELECT COALESCE(MAX(sr_no)+1,1) max FROM hr_payeosr WHERE rdocno="+refno;
                             } else if(type.equalsIgnoreCase("LEV")) {
                                 maxsql = "SELECT COALESCE(MAX(sr_no)+1,1) max FROM hr_payeosl WHERE rdocno="+refno;
                             }
                             ResultSet msl = stmt.executeQuery(maxsql);
                             if(msl.next()) {
                                 max = msl.getString("max");
                             }
                         //    System.out.println(max);
                             if(type.equalsIgnoreCase("TER"))
                                 sql="INSERT INTO hr_payeost(sr_no,rdocno,years,days,status)VALUES"
                                 + " ('"+max+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                 + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";
                             else if(type.equalsIgnoreCase("RES"))
                                 sql="INSERT INTO hr_payeosr(sr_no,rdocno,years,days,status)VALUES"
                                 + " ('"+max+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                 + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";
                             else if(type.equalsIgnoreCase("LEV"))
                                 sql="INSERT INTO hr_payeosl(sr_no,rdocno,years,days,status)VALUES"
                                 + " ('"+max+"','"+refno+"','"+(subarraydesc[1].trim().equalsIgnoreCase("undefined") || subarraydesc[1].trim().equalsIgnoreCase("NaN")|| subarraydesc[1].trim().equalsIgnoreCase("")|| subarraydesc[1].isEmpty()?0:subarraydesc[1].trim())+"',"
                                 + "'"+(subarraydesc[2].trim().equalsIgnoreCase("undefined") || subarraydesc[2].trim().equalsIgnoreCase("NaN")|| subarraydesc[2].trim().equalsIgnoreCase("")|| subarraydesc[2].isEmpty()?0:subarraydesc[2].trim())+"',3)";

                           //  System.out.println("Termination SQL ==== "+sql); 
                       int resultSet2 = stmt.executeUpdate(sql);
                       if(resultSet2<=0) {
                              conn.close();
                              return 0;
                          }
                       id=max;
                      }
//                }
                if(Integer.parseInt(id)>0) {
                    
                    for(int j=0;j<conditionarray.size();j++){
                        
                        int maxsr=0;
                        String sqlmax = "SELECT COALESCE(MAX(sr_no)+1,1) srno FROM hr_payeos WHERE rdocno="+refno;
                        ResultSet rsm = stmt.executeQuery(sqlmax);
                        if(rsm.next()) {
                          maxsr = rsm.getInt("srno");
                        }
                        
                        String[] conditionarraysec=conditionarray.get(j).split("::");
                        if(!(conditionarraysec[0].trim().equalsIgnoreCase("undefined")|| conditionarraysec[0].trim().equalsIgnoreCase("NaN")||conditionarraysec[0].trim().equalsIgnoreCase("")|| conditionarraysec[0].isEmpty())) {
                             String sql="INSERT INTO hr_payeos (sr_no, alwid, rdocno,`type`,refno,status) VALUES ("+maxsr+","+(conditionarraysec[0].trim().equalsIgnoreCase("UNDEFINED") || conditionarraysec[0].trim().equalsIgnoreCase("NaN")|| conditionarraysec[0].trim().equalsIgnoreCase("")|| conditionarraysec[0].isEmpty()?0:conditionarraysec[0].trim())+","+refno+",'"+type+"',"+id+",3)";
                             //System.out.println(sql);
                             int resultSet2 = stmt.executeUpdate(sql);
                             if(resultSet2<=0) {
                                    conn.close();
                                    return 0;
                                }
                        }
                    
                    }
                }
                    
            }
            
            if(Integer.parseInt(id)<=0) {
                conn.close();
                return 0;
            }        
            
            if (Integer.parseInt(id) > 0) {
                conn.commit();
                stmt.close();
                conn.close();
                return Integer.parseInt(id);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
    
    public JSONArray searchTermination(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt = conn.createStatement ();
                
                String   sql=("SELECT sr_no srno, years, days, 'View' btnsave FROM hr_payeost WHERE rdocno="+docno+" and status=3 ORDER BY sr_no ASC");
                System.out.println(sql);
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);

                stmt.close();
                conn.close();
        } catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray searchResignation(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt = conn.createStatement ();
                
                String   sql=("SELECT sr_no srno, years, days, 'View' btnsave FROM hr_payeosr WHERE rdocno="+docno+" and status=3 ORDER BY sr_no ASC");
                System.out.println(sql);
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);

                stmt.close();
                conn.close();
        } catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray searchLeave(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt = conn.createStatement ();
                
                String   sql=("SELECT sr_no srno, years, days, 'View' btnsave FROM hr_payeosl WHERE rdocno="+docno+" and status=3 ORDER BY sr_no ASC");
                System.out.println(sql);
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);

                stmt.close();
                conn.close();
        } catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    
    public JSONArray searchAllowancerelode(String docno, String refno, String type) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt  = conn.createStatement (); 
 
                String sql="select * from (select CONVERT(e.alwid,CHAR(50))  allowanceid,a.desc1 allowance, '1' ckecked,e.type type, e.refno refno from " + 
                        "hr_payeos e left join hr_setallowance a on  e.alwid=a.doc_no where e.rdocno='"+docno+"' and e.type='"+type+"' and e.status=3  and e.refno='"+refno+"'"+ 
                        " union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'0' ckecked, '' type, '' refno from hr_setallowance where status=3 and doc_no>=0) a" + 
                        " group by a.allowanceid order by a.allowanceid";
                System.out.println("COND = "+sql);
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);

                stmt.close();
                conn.close();
            } catch(Exception e){
                e.printStackTrace();
                conn.close();
            }
        return RESULTDATA;
        }
    
    public JSONArray searchAllowance() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;

        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt  = conn.createStatement(); 
                
                String sql="select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance  from hr_setallowance where status=3 and doc_no>=0 order by allowanceid";
                
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmt.close();
                conn.close();
        } catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray searchrefsearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();

        Connection conn=null;
  
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmt = conn.createStatement();
                
                String  sql= "select m.catid,m.doc_no,m.date,m.valfrmdate,m.revdate,c.desc1 cat,l.desc1 leavdesc,'' sowlabel from hr_paycode m "
                        + "left join hr_setpaycat c on m.catid=c.doc_no left join hr_setleave l on l.doc_no=m.annual_id where m.status=3";
                
                ResultSet resultSet = stmt.executeQuery (sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmt.close();
                conn.close();
        } catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
        return RESULTDATA;
    }
    
    
    }
