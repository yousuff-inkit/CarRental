package com.dashboard.invoices.limoinvoicelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoInvoiceListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public  JSONArray loadGrid(String acno,String fromdate,String todate,String fromdocno,String todocno,String branch) throws SQLException {
	//	System.out.println("Inside Invno");
		JSONArray RESULTDATA=new JSONArray();
		/*if(!status.equalsIgnoreCase("1")){
			return RESULTDATA;
		}*/
		
       Connection conn =null;
       java.sql.Date sqlFromDate = null;
       java.sql.Date sqlToDate = null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtDashBoard = conn.createStatement ();
			//System.out.println("Here");
			String sqltest="";
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
	        
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqltest+=" and inv.brhid='"+branch+"'";        	
			}
			if(!((acno.equalsIgnoreCase("")) || (acno.equalsIgnoreCase("0")))){
				sqltest+=" and ac.acno='"+acno+"'";        	
			}
			if(!((fromdocno.equalsIgnoreCase("")) || (fromdocno.equalsIgnoreCase("0")) || (todocno.equalsIgnoreCase("")) || (todocno.equalsIgnoreCase("0")))){
				sqltest+=" and inv.voc_no >="+fromdocno+" and inv.voc_no <="+todocno+"";        	
			}
		
				String strSql=" select inv.doc_no,inv.voc_no,inv.date,ac.refname,inv.invoicenote,SUM(ind.total) mastertotal,SUM(ind.vatvalue) mastervat,SUM(ind.total+ind.vatvalue) masternettotal from gl_limoinvm inv "+
                              " left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoinvd ind on ind.rdocno=inv.doc_no where inv.status=3 and inv.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqltest+" GROUP BY INV.DOC_NO ";
            	System.out.println("Inv No Sql"+strSql);
				ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtDashBoard.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray loadGridExcel(String acno,String fromdate,String todate,String fromdocno,String todocno,String branch) throws SQLException {
		//	System.out.println("Inside Invno");
			JSONArray RESULTDATA=new JSONArray();
			/*if(!status.equalsIgnoreCase("1")){
				return RESULTDATA;
			}*/
			
	       Connection conn =null;
	       java.sql.Date sqlFromDate = null;
	       java.sql.Date sqlToDate = null;
			try {
				conn=ClsConnection.getMyConnection();
				Statement stmtDashBoard = conn.createStatement ();
				//System.out.println("Here");
				String sqltest="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sqltest+=" and inv.brhid='"+branch+"'";        	
				}
				if(!((acno.equalsIgnoreCase("")) || (acno.equalsIgnoreCase("0")))){
					sqltest+=" and ac.acno='"+acno+"'";        	
				}
				if(!((fromdocno.equalsIgnoreCase("")) || (fromdocno.equalsIgnoreCase("0")) || (todocno.equalsIgnoreCase("")) || (todocno.equalsIgnoreCase("0")))){
					sqltest+=" and inv.voc_no >="+fromdocno+" and inv.voc_no <="+todocno+"";        	
				}
			
					String strSql=" select inv.voc_no,inv.date,ac.refname,inv.invoicenote,inv.mastertotal,inv.mastervat,inv.masternettotal from gl_limoinvm inv "+
	                              " left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') where inv.status=3 and inv.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqltest+" ";
	            	System.out.println("Inv No Sql"+strSql);
					ResultSet resultSet = stmtDashBoard.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					stmtDashBoard.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String condition="";
	    	    String sql1 = "";
	    	    
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				else if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
	    	    
	    	    if(!((account.equalsIgnoreCase("")) || (account.equalsIgnoreCase("0")))){
	                sql1=sql1+" and t.account like '%"+account+"%'";
	            }
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and t.description like '%"+partyname+"%'";
	            }
	            if(!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))){
	                sql1=sql1+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
	        	
				
					sql = "select a.per_mob,a.mail1 email,a.acno doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where  a.status<>7 and t.m_s=0"+sql1;
			
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtAccountStatement1.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtAccountStatement1.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	
	
	
}
