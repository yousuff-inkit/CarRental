package com.dashboard.serviceandmaintenance.workshopinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.google.gson.Gson;
import com.google.gson.JsonArray;

public class ClsWorkshopInvoice {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon commonDAO = new ClsCommon();
	
	public JSONArray wsinvGridLoad(String fromdate,String todate,String id, String brchid) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String wsdb=getDatabase("ws");
		String crdb=getDatabase("cr");
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
			String sqltest="",sqltest1="";
			
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=commonDAO.changeStringtoSqlDate(todate);
				sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			
			int data=0;
			String strsql="select method from gl_config where field_nme='configworkshopinv'";
			System.out.println("config========="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				data=rs.getInt("method");
			}
			 
			if(data==2){
				sqltest1+="m.invoicetoacno=15797";
			}else {
				sqltest1+="g.cldocno in (1,200)" ;
			}
			String intercompanyname="";
			String str="select intercompany from my_comp where doc_no=1";
			ResultSet rse=stmt.executeQuery(str);
			while(rse.next()){
				intercompanyname=rse.getString("intercompany");
			}
			
			if(intercompanyname.equalsIgnoreCase("All")) {
				RESULTDATA = getGateInPassDataFromApi(fromdate,todate,"1");
			} else {
			String resql=" select g.insurcldocno,m.doc_no invno,date_format(m.date,'%d.%m.%Y') invdate,m.refno,g.regno,m.taxtotal totalinv,e.doc_no, j.doc_no jdocno,e.doc_no edocno,"
					+" if(coalesce(es.sparetot,0)-coalesce(ty.tyretot,0)-coalesce(bt.batterytot,0)>m.taxtotal,m.taxtotal,coalesce(es.sparetot,0)-coalesce(bt.batterytot,0)-coalesce(ty.tyretot,0)) sparetot, if(coalesce(ty.tyretot,0)<0,0,coalesce(ty.tyretot,0)) tyretot,if(coalesce(cw.carwashtot,0)<0,0,coalesce(cw.carwashtot,0)) carwashtot,if(coalesce(bt.batterytot,0)<0,0,coalesce(bt.batterytot,0)) batterytot ,if(m.taxtotal-coalesce(es.sparetot,0)-coalesce(cw.carwashtot,0)<0,0,m.taxtotal-coalesce(es.sparetot,0)-coalesce(cw.carwashtot,0)) labourtot ,g.refno,"
					+" convert(concat(coalesce(vb.brand,''),' ',coalesce(vm.vtype,'')),char(200)) make,g.pltid,convert(coalesce(nr.fleet_no,''),char) fleet, j.doc_no jobcardno,"
					+" (select acno from "+crdb+"my_account where codeno='WORKSHOPACCOUNT') acno,"
					+" (select acno from "+wsdb+"my_account where codeno='MAINTSP') acnosp,"
					+" (select acno from "+wsdb+"my_account where codeno='MAINTLAB') acnolab, "
					+" (select acno from "+wsdb+"my_account where codeno='MAINTTYR') acnotyr, "
					+" (select acno from "+wsdb+"my_account where codeno='MAINTCWS') acnocws, "
					+" (select acno from "+wsdb+"my_account where codeno='MAINTBAT') acnobat "
					+" from "+wsdb+"ws_invm m "
					+" inner join "+wsdb+"MY_JVTRAN Jv on (jv.doc_no=m.doc_no and jv.dtype='mnt' and jv.acno=m.acno and jv.status=3)"
					+" left join "+wsdb+"ws_jobcard j on (m.refno=j.doc_no and m.reftype='JC')"
					+" left join "+wsdb+"ws_estm e on (j.refno=e.doc_no and j.reftype='EST')"
					+" left join "+wsdb+"ws_gateinpass g on ((j.reftype='GIP' and j.refno=g.doc_no) or (e.gipno=g.doc_no))"
					+" left join (select jobcarddocno , sum(customeramt) sparetot from "+wsdb+"ws_jccspare group by jobcarddocno) es on (j.doc_no=es.jobcarddocno)"
					+" left join (SELECT jobcarddocno ,SUM(customeramt) tyretot FROM "+wsdb+"ws_jccspare js LEFT JOIN "+wsdb+"my_main m ON js.psrno=m.psrno left join "+wsdb+"my_catm c on m.catId=c.doc_no and c.status=3 WHERE c.category='TYRES INVENTORY' group by jobcarddocno) ty on (j.doc_no=ty.jobcarddocno)"
					+" left join (SELECT l.rdocno,SUM(l.invoiceamt) carwashtot FROM "+wsdb+"ws_estlabour l LEFT JOIN "+wsdb+"ws_jobtype j ON j.doc_no=l.jobid WHERE j.type='CAR WASH' AND j.status=3 GROUP BY l.rdocno) cw on (e.doc_no=cw.rdocno)"
					+" left join (SELECT jobcarddocno, SUM(customeramt) batterytot FROM "+wsdb+"ws_jccspare js LEFT JOIN "+wsdb+"my_main m ON js.psrno=m.psrno left join "+wsdb+"my_catm c on m.catId=c.doc_no and c.status=3 WHERE c.category='BATTERIES' group by jobcarddocno) bt on (j.doc_no=bt.jobcarddocno)"
					+" left join "+wsdb+"gl_vehbrand vb on (g.brdid=vb.doc_no)"
					+" left join "+wsdb+"gl_vehmodel vm on (g.modid=vm.doc_no)"
					+" left join "+crdb+"gl_nrm nr on (nr.doc_no=g.movno)"
					+" where "+sqltest1+" and m.status=3 and jv.dramount!=0 and m.nipno=0 "+sqltest+" order by m.doc_no";
			
			System.out.println("--resql--"+resql);
			ResultSet resultSet = stmt.executeQuery(resql);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			}
			stmt.close();
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
	
	public JSONArray wsinvExcelLoad(String fromdate,String todate,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String wsdb=getDatabase("ws");
		String crdb=getDatabase("cr");
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
			String sqltest="";
			
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=commonDAO.changeStringtoSqlDate(todate);
				sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			String resql=" select m.doc_no 'Inv No',date_format(m.date,'%d.%m.%Y') 'Inv Date', j.doc_no 'Jobcard No',g.regno 'Reg No',convert(concat(coalesce(vb.brand,''),' ',coalesce(vm.vtype,'')),char(200)) 'Make',"
					+" round(m.taxtotal,2) 'Total Invoice',round(if(coalesce(es.sparetot,0)>m.taxtotal,m.taxtotal,coalesce(es.sparetot,0) ),2) 'Spare Total',round(if(m.taxtotal-coalesce(es.sparetot,0)<0,0,m.taxtotal-coalesce(es.sparetot,0)),2) 'Labour Total' ,g.refno 'Ref No'"
					+" from "+wsdb+"ws_invm m "
					+" inner join "+wsdb+"MY_JVTRAN Jv on (jv.doc_no=m.doc_no and jv.dtype='mnt' and jv.acno=m.acno and jv.status=3)"
					+" left join "+wsdb+"ws_jobcard j on (m.refno=j.doc_no and m.reftype='JC')"
					+" left join "+wsdb+"ws_estm e on (j.refno=e.doc_no and j.reftype='EST')"
					+" left join "+wsdb+"ws_gateinpass g on ((j.reftype='GIP' and j.refno=g.doc_no) or (e.gipno=g.doc_no))"
					+" left join (select jobcarddocno ,sum(customeramt) sparetot from "+wsdb+"ws_jccspare group by jobcarddocno) es on (j.doc_no=es.jobcarddocno)"
					+" left join "+wsdb+"gl_vehbrand vb on (g.brdid=vb.doc_no)"
					+" left join "+wsdb+"gl_vehmodel vm on (g.modid=vm.doc_no)"
					+" left join "+crdb+"gl_nrm nr on (nr.doc_no=g.movno)"
					+" where g.cldocno=1 and m.status=3 and jv.dramount!=0 and m.nipno=0 "+sqltest+" order by m.doc_no";
			
//			System.out.println("--resql--"+resql);
			ResultSet resultSet = stmt.executeQuery(resql);
			
			RESULTDATA=commonDAO.convertToEXCEL(resultSet);
			
			stmt.close();
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
	
	public String getDatabase(String code) throws SQLException{
		Connection conn = null;
		String  db=null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			String sqldb="select coalesce(carrental_db,'') carrental_db,coalesce(workshop_db,'')workshop_db from my_comp";
			ResultSet resultSet = stmt.executeQuery(sqldb);
			if(code.equalsIgnoreCase("ws")){
				while(resultSet.next()){
					db=resultSet.getString("workshop_db")+".";
				}
			}
			else{
				while(resultSet.next()){
					db=resultSet.getString("carrental_db")+".";
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return db;
	}
	
	public JSONArray getGateInPassDataFromApi(String fromdate, String todate, String branch)
            throws SQLException
    {

        JSONArray data = new JSONArray();
        String apiUrl = ""; // Replace this with your API endpoint
        String sqlurl = "";
        String endpoint = "api/getDatas";
        System.out.println("Entered");
        JSONObject jsonObject = new JSONObject();

        // Set data in JSON object
        jsonObject.put("fromdate", fromdate);
        jsonObject.put("todate", todate);
        jsonObject.put("brhid", branch);
		jsonObject.put("workshopinvoice", "win");
        Connection connection = null;
        try {
            connection = ClsConnection.getMyConnection();
            Statement stmt = connection.createStatement();
            String password = ""; 
            String userid = ""; 
            String str="select coalesce(apiurl,'') url,apiusername,apipass from my_comp where doc_no=1";          
            ResultSet rs=stmt.executeQuery(str);
            while(rs.next()){
                sqlurl=rs.getString("url");  
                password=rs.getString("apipass");   
                userid=rs.getString("apiusername");  
            }

            ClsEncrypt clsEncrypt = new ClsEncrypt();

            password = clsEncrypt.decrypt(password);

            System.out.println(password);
            apiUrl = sqlurl + endpoint;
            System.out.println(apiUrl);
            CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
            credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(userid, password));

            // Create HttpClient with Basic Authentication
            CloseableHttpClient httpClient = HttpClients.custom()
                    .setDefaultCredentialsProvider(credentialsProvider)
                    .build();
            HttpPost httppost = new HttpPost(apiUrl);
            httppost.setHeader("Content-Type", "application/json");
            String jsonArr = jsonObject.toString();
            StringEntity entity = new StringEntity(jsonArr);
            httppost.setEntity(entity);
            // Execute the request
            org.apache.http.HttpResponse response = httpClient.execute(httppost);
            // Get the response entity as a string
            String responseBody = EntityUtils.toString(response.getEntity());
            System.out.println("respbody - "+responseBody);
            Gson gson = new Gson();
            JsonArray jsonArray = gson.fromJson(responseBody, JsonArray.class);
            data = JSONArray.fromObject(jsonArray.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
	
	 public int setGateInPassDataFromApi(int nrmdocno,int gipno) {
	     String apiUrl = ""; // Replace this with your API endpoint
         String sqlurl = "";
         String endpoint = "api/setDatas";
         JSONObject jsonObject = new JSONObject();
         System.out.println("Entered inupdateapi");
         // Set data in JSON object
         jsonObject.put("trno", nrmdocno);
         jsonObject.put("invno", gipno);
		 jsonObject.put("workshopinvoice", "win");
         Integer responseBody = 0;
         Connection conn =null;
         try {
             conn = ClsConnection.getMyConnection();
             Statement stmt =conn.createStatement();
             String password = ""; 
             String userid = ""; 
             String str="select coalesce(apiurl,'') url,apiusername,apipass from my_comp where doc_no=1";          
             ResultSet rs=stmt.executeQuery(str);
             while(rs.next()){
                 sqlurl=rs.getString("url");  
                 password=rs.getString("apipass");   
                 userid=rs.getString("apiusername");  
             }
             
             
             ClsEncrypt clsEncrypt = new ClsEncrypt();
             
             
             password=clsEncrypt.decrypt(password);
             apiUrl = sqlurl+endpoint;
             CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
             credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(userid, password));
             
             // Create HttpClient with Basic Authentication
             CloseableHttpClient httpClient = HttpClients.custom()
                     .setDefaultCredentialsProvider(credentialsProvider)
                     .build();
             HttpPost httppost = new HttpPost(apiUrl);
             httppost.setHeader("Content-Type", "application/json");
             String jsonArr = jsonObject.toString();
             StringEntity entity = new StringEntity(jsonArr);
             httppost.setEntity(entity);
             org.apache.http.HttpResponse response = httpClient.execute(httppost);
             // Get the response entity as a string
             responseBody = Integer.parseInt(EntityUtils.toString(response.getEntity()));
             System.out.println(responseBody);
         } catch (Exception e) {
             e.printStackTrace();
         }
         return responseBody;
	 }
	
	 
	 
	 public JSONArray getLabourcostData(String jobcarddocno,String docno,String id)throws SQLException{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null;
			try{
				
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				String intercompanyname="";
				String str="select intercompany from my_comp where doc_no=1";
				ResultSet rse=stmt.executeQuery(str);
				while(rse.next()){
					intercompanyname=rse.getString("intercompany");
				}	
			    if(intercompanyname.equalsIgnoreCase("All")) {
			    	data = getLabourcostDataFromApi(jobcarddocno,docno);
				} else {
				    String addition="";
				    String wsdb=getDatabase("ws");
	                String crdb=getDatabase("cr");
	                String stsql = "select coalesce(group_concat(distinct t.addition),0) addition from "+wsdb+"ws_invm m left join "+wsdb+"ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+docno;
	                System.out.println(stsql);
	                ResultSet rsadd=stmt.executeQuery(stsql);
	                while(rsadd.next()){
	                    addition=rsadd.getString("addition");
	                }
					String strsql="SELECT @k:=@k+1 AS slno,'-' qty, rate,'SERVICES' TYPE,CONVERT(CONCAT(a.voc_no,'-S',@i:=@i+1),CHAR(25)) srno,a.description desc1,ROUND(a.amount,2) amount, discount,vatpercent,vatamount,netamount FROM (     SELECT @i:=0 COUNT,lab.description description,IF(lab.amount=0,0,ROUND(lab.amount,2)) amount,est.voc_no,ROUND(lab.qty,2) qty, ROUND((lab.amount+lab.discount)/lab.qty,2) rate,ROUND(lab.discount,2) discount,ROUND(lab.vatamount,2) vatamount,ROUND(lab.vatpercent,2) vatpercent,ROUND(lab.netamount,2) netamount FROM "+wsdb+"ws_jobcard card LEFT JOIN "+wsdb+"ws_estm est ON  (card.reftype='EST' AND card.refno=est.doc_no) LEFT JOIN "+wsdb+"ws_investdetail lab ON est.doc_no=lab.estdocno  WHERE card.doc_no="+jobcarddocno+" AND lab.addition IN ("+addition+")  AND lab.invno="+docno+" AND card.status=3 AND UPPER(lab.type)!='SUBLET' AND TRIM(lab.type)<>'Parts') a,(SELECT @k:= 0) AS r UNION ALL SELECT  @j:=@j+1 AS slno,qty, rate,'Sublet' TYPE,CONVERT(CONCAT(a.voc_no,'-S',@i:=@i+1),CHAR(25)) srno,a.description desc1,ROUND(a.amount,2) amount,discount,vatpercent,vatamount,netamount FROM ( SELECT @i:=0 COUNT,lab.description,IF(lab.amount=0,0,ROUND(lab.amount,2)) amount,ROUND(lab.discount,2) discount,ROUND(lab.vatamount,2) vatamount,ROUND(lab.vatpercent,2) vatpercent,ROUND(lab.netamount,2) netamount,est.voc_no,ROUND(lab.qty,2) qty, ROUND((lab.amount+lab.discount)/lab.qty,2) rate FROM "+wsdb+"ws_jobcard card LEFT JOIN "+wsdb+"ws_estm est ON  (card.reftype='EST' AND card.refno=est.doc_no) LEFT JOIN "+wsdb+"ws_investdetail lab ON est.doc_no=lab.estdocno WHERE card.doc_no="+jobcarddocno+" AND lab.addition IN ("+addition+")  AND lab.invno="+docno+" AND card.status=3 AND UPPER(lab.type)='SUBLET'  AND TRIM(lab.type)<>'Parts') a,(SELECT @j:= 0) AS r";
					System.out.println("Labour Data:"+strsql);
					ResultSet rs=stmt.executeQuery(strsql);
					data=commonDAO.convertToJSON(rs);
				}
				
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
			//	conn.close();
			}
			finally{
				conn.close();
			}
			return data;
		}
	 
	 public JSONArray getLabourcostDataFromApi(String jobcarddocno, String docno)
	            throws SQLException
	    {

	        JSONArray data = new JSONArray();
	        String apiUrl = ""; // Replace this with your API endpoint
	        String sqlurl = "";
	        String endpoint = "api/getDatas";
	        System.out.println("Entered");
	        JSONObject jsonObject = new JSONObject();

	        // Set data in JSON object
	        jsonObject.put("jobcarddocno", jobcarddocno);
	        jsonObject.put("docno", docno);
			jsonObject.put("labourdata", "labourdata");
	        Connection connection = null;
	        try {
	            connection = ClsConnection.getMyConnection();
	            Statement stmt = connection.createStatement();
	            String password = ""; 
	            String userid = ""; 
	            String str="select coalesce(apiurl,'') url,apiusername,apipass from my_comp where doc_no=1";          
	            ResultSet rs=stmt.executeQuery(str);
	            while(rs.next()){
	                sqlurl=rs.getString("url");  
	                password=rs.getString("apipass");   
	                userid=rs.getString("apiusername");  
	            }

	            ClsEncrypt clsEncrypt = new ClsEncrypt();

	            password = clsEncrypt.decrypt(password);

	            System.out.println(password);
	            apiUrl = sqlurl + endpoint;
	            System.out.println(apiUrl);
	            CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
	            credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(userid, password));

	            // Create HttpClient with Basic Authentication
	            CloseableHttpClient httpClient = HttpClients.custom()
	                    .setDefaultCredentialsProvider(credentialsProvider)
	                    .build();
	            HttpPost httppost = new HttpPost(apiUrl);
	            httppost.setHeader("Content-Type", "application/json");
	            String jsonArr = jsonObject.toString();
	            StringEntity entity = new StringEntity(jsonArr);
	            httppost.setEntity(entity);
	            System.out.println("entity");
	            // Execute the request
	            org.apache.http.HttpResponse response = httpClient.execute(httppost);
	            // Get the response entity as a string
	            System.out.println("response");
	            String responseBody = EntityUtils.toString(response.getEntity());
	            System.out.println("respbody - "+responseBody);
	            Gson gson = new Gson();
	            JsonArray jsonArray = gson.fromJson(responseBody, JsonArray.class);
	            data = JSONArray.fromObject(jsonArray.toString());
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	connection.close();
	        }
	        return data;
	    }
	 
	 public JSONArray getSparepartsData(String docno,String jobcarddocno,String id) throws SQLException
		{
			JSONArray data=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null;
			try{
			
				conn=ClsConnection.getMyConnection();
				Statement stmt=conn.createStatement();
				
				
				//System.out.println();	
				String intercompanyname="";
				String str="select intercompany from my_comp where doc_no=1";
				ResultSet rse=stmt.executeQuery(str);
				while(rse.next()){
					intercompanyname=rse.getString("intercompany");
				}	
				if(intercompanyname.equalsIgnoreCase("All")) {
					data = getSparepartsDataFromApi(jobcarddocno,docno);
				} else {
				    String addition="";
				    String wsdb=getDatabase("ws");
	                String crdb=getDatabase("cr");
	                String stsql = "select coalesce(group_concat(distinct t.addition),0) addition from "+wsdb+"ws_invm m left join "+wsdb+"ws_invcalctemp t on m.doc_no=t.invno where m.doc_no="+docno;
	                System.out.println(stsql);
	                ResultSet rsadd=stmt.executeQuery(stsql);
	                while(rsadd.next()){
	                    addition=rsadd.getString("addition");
	                }
					String strsql="SELECT @h:=@h+1 AS slno,qty,rate,'SPARE PARTS' TYPE,CONVERT(CONCAT(a.voc_no,'-P',@j:=@j+1),CHAR(25)) serialno,a.description,ROUND(a.amount,2) amount,discount,vatpercent,vatamount,netamount FROM ( SELECT @j:=0 COUNT,IF(s.qty=0,'',ROUND(s.qty,2)) qty,ROUND((s.amount+s.discount)/s.qty,2) rate, s.description,IF(s.amount=0,0,ROUND(s.amount,2)) amount ,  IF(s.discount=0,0,ROUND(s.discount,2)) discount ,IF(s.vatamount=0,0,ROUND(s.vatamount,2))  vatamount, IF(s.vatpercent=0,0,ROUND(s.vatpercent,2))  vatpercent,IF(s.netamount=0,0,ROUND(s.netamount,2))  netamount, m.voc_no  FROM  "+wsdb+"ws_jobcard card LEFT JOIN "+wsdb+"ws_estm m ON  (card.reftype='EST' AND card.refno=m.doc_no) LEFT JOIN "+wsdb+"ws_investdetail s ON s.estdocno=m.doc_no  WHERE   card.doc_no="+jobcarddocno+" AND s.addition IN ("+addition+")  AND s.invno="+docno+" AND (s.description!='null' AND s.description IS NOT NULL AND TRIM(s.type)='Parts') ORDER BY s.rowno )a,(SELECT @h:= 0) AS r";
					System.out.println("SPARE - "+strsql);
					ResultSet rs=stmt.executeQuery(strsql);
					data=commonDAO.convertToJSON(rs);
				}
				
				 
			}
			catch(Exception e){
				e.printStackTrace();
			//	conn.close();
			}
			finally{
				conn.close();
			}
			return data;
		}
	 
	 public JSONArray getSparepartsDataFromApi(String jobcarddocno, String docno)
	            throws SQLException
	    {

	        JSONArray data = new JSONArray();
	        String apiUrl = ""; // Replace this with your API endpoint
	        String sqlurl = "";
	        String endpoint = "api/getDatas";
	        System.out.println("Entered");
	        JSONObject jsonObject = new JSONObject();

	        // Set data in JSON object
	        jsonObject.put("jobcarddocno", jobcarddocno);
	        jsonObject.put("docno", docno);
			jsonObject.put("sparedata", "sparedata");
	        Connection connection = null;
	        try {
	            connection = ClsConnection.getMyConnection();
	            Statement stmt = connection.createStatement();
	            String password = ""; 
	            String userid = ""; 
	            String str="select coalesce(apiurl,'') url,apiusername,apipass from my_comp where doc_no=1";          
	            ResultSet rs=stmt.executeQuery(str);
	            while(rs.next()){
	                sqlurl=rs.getString("url");  
	                password=rs.getString("apipass");   
	                userid=rs.getString("apiusername");  
	            }

	            ClsEncrypt clsEncrypt = new ClsEncrypt();

	            password = clsEncrypt.decrypt(password);

	            System.out.println(password);
	            apiUrl = sqlurl + endpoint;
	            System.out.println(apiUrl);
	            CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
	            credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(userid, password));

	            // Create HttpClient with Basic Authentication
	            CloseableHttpClient httpClient = HttpClients.custom()
	                    .setDefaultCredentialsProvider(credentialsProvider)
	                    .build();
	            HttpPost httppost = new HttpPost(apiUrl);
	            httppost.setHeader("Content-Type", "application/json");
	            String jsonArr = jsonObject.toString();
	            StringEntity entity = new StringEntity(jsonArr);
	            httppost.setEntity(entity);
	            // Execute the request
	            System.out.println("Entity");
	            org.apache.http.HttpResponse response = httpClient.execute(httppost);
	            System.out.println("Response");
	            // Get the response entity as a string
	            String responseBody = EntityUtils.toString(response.getEntity());
	            System.out.println("respbody - "+responseBody);
	            Gson gson = new Gson();
	            JsonArray jsonArray = gson.fromJson(responseBody, JsonArray.class);
	            data = JSONArray.fromObject(jsonArray.toString());
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	connection.close();
	        }
	        return data;
	    }
		
}
