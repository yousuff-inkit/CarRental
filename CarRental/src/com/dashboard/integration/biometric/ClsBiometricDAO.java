package com.dashboard.integration.biometric;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsBiometricDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public String downloadBiometricData(String apiusername,String apipassword,String apiUrl,Connection conn,String fromdate,String todate) {
		String responseBody="";
		try {
			
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(fromdate!=null && !fromdate.trim().equalsIgnoreCase("") && !fromdate.trim().equalsIgnoreCase("undefined")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(todate!=null && !todate.trim().equalsIgnoreCase("") && !todate.trim().equalsIgnoreCase("undefined")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			
			
			CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
            credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(apiusername, apipassword));

            // Create HttpClient with Basic Authentication
            CloseableHttpClient httpClient = HttpClients.custom()
                    .setDefaultCredentialsProvider(credentialsProvider)
                    .build();
            HttpGet httpget = new HttpGet(apiUrl);
            /* httpget.setHeader("Content-Type", "application/json");
            String jsonArr = jsonObject.toString();
            StringEntity entity = new StringEntity(jsonArr);
            httppost.setEntity(entity);
             */
            // Execute the request
            org.apache.http.HttpResponse resp = httpClient.execute(httpget);
            // Get the response entity as a string
            responseBody = EntityUtils.toString(resp.getEntity());
            //System.out.println("respbody - "+responseBody);
            
            String[] rows=responseBody.toString().split("\n");
            
            PreparedStatement pstmtInsert = null;
            PreparedStatement pstmtUpdate = null;
            
            int delete=conn.createStatement().executeUpdate("delete from hr_punchatt where date>='"+sqlfromdate+"' and date<='"+sqltodate+"'");
            
            String sqlInsert = "INSERT INTO hr_punchatt (empid, checkindate, checkintime, status, machineid, date) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            pstmtInsert = conn.prepareStatement(sqlInsert);

            // Prepared statement for updating the "Out" punch record
            String sqlUpdate = "UPDATE hr_punchatt SET checkoutdate = ?, checkouttime = ?, status = ? " +
                    "WHERE empid = ? AND checkindate = ?";
            pstmtUpdate = conn.prepareStatement(sqlUpdate);
            
            //First Line and Last Line Skipped
            for(int i=1;i<rows.length-1;i++){
            	String row=rows[i];
            	System.out.println("APIDATA:"+row);
            	String[] data=row.split("\\|");
            	
            	String empid = data[1];
                String name = data[2];
                String entryDate = data[3];
                
                String[] entrydateparts = entryDate.split("/");
                entryDate= entrydateparts[2] + "-" + entrydateparts[1] + "-" + entrydateparts[0];
                
                String entryTime = data[4];
                String ioflag = data[5];
                String machineid = data[6];

                if (ioflag.equalsIgnoreCase("I")) {
                    // Insert new record for "In" punch
                    pstmtInsert.setInt(1, Integer.parseInt(empid));      // empid
                    pstmtInsert.setDate(2, java.sql.Date.valueOf(entryDate)); // checkindate
                    pstmtInsert.setString(3, entryTime);                 // checkintime
                    pstmtInsert.setInt(4, 1);                            // status (1 for checked-in)
                    pstmtInsert.setInt(5, Integer.parseInt(machineid.trim()));  // machineid
                    pstmtInsert.setDate(6, java.sql.Date.valueOf(entryDate)); // date (same as checkindate)
                    pstmtInsert.executeUpdate();  // Insert the "In" record
                } else if (ioflag.equals("O")) {
                    // Update existing record for "Out" punch
                    pstmtUpdate.setDate(1, java.sql.Date.valueOf(entryDate)); // checkoutdate
                    pstmtUpdate.setString(2, entryTime);                // checkouttime
                    pstmtUpdate.setInt(3, 0);                           // status (0 for checked-out)
                    pstmtUpdate.setInt(4, Integer.parseInt(empid));      // empid
                    pstmtUpdate.setDate(5, java.sql.Date.valueOf(entryDate)); // checkindate (same as punchDate)
                    int rowsUpdated = pstmtUpdate.executeUpdate(); // Update the "Out" record
                    
                    // If no row was updated, it means there was no "In" punch, you might log or handle this scenario
                    if (rowsUpdated == 0) {
                        System.out.println("No corresponding 'In' record found for empid: " + empid + " on date: " + entryDate);
                    }
                    
                    
                    
                    
                }
            }

            return responseBody;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	public JSONArray getBiometricData(String fromdate,String todate,String brhid,String id) throws SQLException  {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String sqlfilters="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters+=" and att.date>='"+sqlfromdate+"'";
			}
			
			if(todate!=null && !todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqlfilters+=" and att.date<='"+sqltodate+"'";
			}
			
			if(brhid!=null && !brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")) {
				sqlfilters+=" and att.brhid="+brhid;
			}
			
			String strsql="SELECT att.attstatus,att.doc_no,att.empid,att.checkindate,att.checkintime,att.checkoutdate,att.checkouttime,emp.doc_no empdocno,emp.name empname FROM hr_punchatt att LEFT JOIN hr_empm emp ON att.empid=emp.codeNo where 1=1 "+sqlfilters;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		}
		
		return data;
	}
}
