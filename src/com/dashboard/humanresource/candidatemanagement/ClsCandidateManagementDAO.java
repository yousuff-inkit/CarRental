package com.dashboard.humanresource.candidatemanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCandidateManagementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
		public JSONArray candidateManagementGridLoad(String check) throws SQLException {
		        
		        JSONArray RESULTDATA=new JSONArray();
		        
		        if(!check.equalsIgnoreCase("1")) {
		        	return RESULTDATA;
		        }
		        
		        Connection conn = null;
		        
				try {
						conn = ClsConnection.getMyConnection();
						Statement stmnt = conn.createStatement();
					
						String sqlLoad="SELECT m.doc_no docno, m.brhid,m.name NAME, m.gender gender, m.dob dob, n.nation, n.doc_no ndocno,q.desc1 qualification,q.doc_no qdocno,ds.desc1 designation, ds.doc_no desdocno, m.experience exp, m.postapplied post, m.remarks remarks, cs.status rtastatus,cs.doc_no rtastatusid, cp.process PROCESS, cp.processid processid,cp.remarks processremarks, cv.status visastatus, cv.doc_no visadocno  FROM hr_candidatem m LEFT JOIN hr_designqual q ON m.qualificationId=q.doc_no  LEFT JOIN hr_setdesig ds ON m.designationId=ds.doc_no LEFT JOIN my_natm n ON n.doc_no=m.nationId LEFT JOIN my_cmstatus cs ON cs.doc_no=m.rtastatusid LEFT JOIN my_cdmprocess cp ON cp.rdocno=m.doc_no LEFT JOIN my_cmvisa cv ON cv.doc_no=m.visastatusid WHERE m.isconverted<>1 and m.status<>7";
						System.out.println("candidate Management - "+sqlLoad);
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

		public JSONArray statusUpdateGridLoad(String check, String isRtaAvail) throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		    
		    if(!check.equalsIgnoreCase("1")) {
		    	return RESULTDATA;
		    }
		    
		    Connection conn = null;
		    
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmnt = conn.createStatement();
					String tableName="";
					if(isRtaAvail.equalsIgnoreCase("1")) {
						tableName = "my_rtarenewal";
					} else {
						tableName = "my_cmstatus";
					}
					String sqlLoad="SELECT doc_no docno,status,`desc` from "+tableName;
					System.out.println("Status Update - "+sqlLoad);
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

public JSONArray statusUpdateGridLoad(String check) throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		    
		    if(!check.equalsIgnoreCase("1")) {
		    	return RESULTDATA;
		    }
		    
		    Connection conn = null;
		    
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmnt = conn.createStatement();
					String sqlLoad="SELECT doc_no docno,status,`desc` from my_cmstatus";
					System.out.println("Status Update - "+sqlLoad);
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

		public JSONArray visaUpdateGridLoad(String check) throws SQLException {
			
			JSONArray RESULTDATA=new JSONArray();
			
			if(!check.equalsIgnoreCase("1")) {
				return RESULTDATA;
			}
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmnt = conn.createStatement();
				String sqlLoad="SELECT doc_no docno,status,`desc` from my_cmvisa";
				System.out.println("Visa Update - "+sqlLoad);
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

		public JSONArray logSheetGridLoad(String check,String docno) throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		    
		    if(!check.equalsIgnoreCase("1")) {
		    	return RESULTDATA;
		    }
		    
		    Connection conn = null;
		    
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmnt = conn.createStatement();
					String sqlLoad="SELECT u.user_name user, cl.date, cl.description  FROM my_cdmbilog cl LEFT JOIN my_user u ON u.DOC_NO=cl.userid WHERE cl.rdocno="+docno;
					System.out.println("Status Update - "+sqlLoad);
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
