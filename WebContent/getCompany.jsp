<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
		String cmp="",cmpId="",amcRenewalMsg="";
		 	 
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		int erastatus=0;
		String comp_id="";
		int isUpdatedate=0;
		String era="";
		
		// checking era for license
		
		String getera = "select if(projectstatus=2 and (DATEDIFF(era,CURDATE())<0), 1, (if(projectstatus=1 and(DATEDIFF(era,CURDATE())<0),1,0))) prstatus, era,comp_refid from my_comp";
		ResultSet rsgetera = stmt.executeQuery(getera);
		if(rsgetera.next()){
			erastatus=rsgetera.getInt("prstatus");
			comp_id=rsgetera.getString("comp_refid");
		}
		
		if(erastatus>0){
			System.out.println("Entered IN Call");
			URL url = new URL("http://185.217.125.145:8877/ServiceDB/getlist.jsp?compid="+comp_id);
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");
	
	        int status = con.getResponseCode();
	        if (status != 200) {
	            throw new RuntimeException("HTTP Error: " + status);
	        }
	
	        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        String inputLine;
	        StringBuilder res = new StringBuilder();
	
	        while ((inputLine = in.readLine()) != null) {
	        	res.append(inputLine);
	        }
			System.out.println("Result - "+res);
	        in.close();
	        con.disconnect();
	        
	        JSONObject json = JSONObject.fromObject(res.toString());  // Parse the raw string as JSON
	        System.out.println("Parsed JSON: " + json);
	        
	        if (json.has("date") && !json.get("date").equals(null) && !json.getString("date").trim().isEmpty()) {
		        String	jsonDate = json.getString("date");
		        System.out.println("Date: " + jsonDate);
		        
		        String compres = "select DATEDIFF(era,'"+jsonDate+"') prstatus from my_comp";
		        System.out.println(compres);
		        ResultSet rscompres = stmt.executeQuery(compres);
				if(rscompres.next()){
					isUpdatedate=rscompres.getInt("prstatus");
				}
				if(isUpdatedate<0){
					String updateDate = "update my_comp set era='"+jsonDate+"'";
					System.out.println(updateDate);
					int result = stmt.executeUpdate(updateDate); 
				} 
	        }
		}
		
		// end checking era for license
		
		String strSql = "select company,comp_id,COALESCE(if(projectstatus=2 and DATEDIFF(era,CURDATE())=0,'AMC Expires Today',"
				+ "if(projectstatus=2 and (DATEDIFF(era,CURDATE()) between 1 and 10),CONCAT('AMC Expires in ',DATEDIFF(era,CURDATE()),' Day(s)'),"
				+ "if(projectstatus=2 and (DATEDIFF(era,CURDATE())<0),CONCAT('AMC Renewal Pending ',DATEDIFF(CURDATE(),era),' Day(s)'),''))),'') amcRenewalMsg from my_comp";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			cmp+=rs.getString("company")+",";
			cmpId+=rs.getString("comp_id")+",";
			amcRenewalMsg=rs.getString("amcRenewalMsg");
	  		} 
		 
		response.getWriter().write(cmp+"####"+cmpId+"####"+amcRenewalMsg);

		stmt.close();
		conn.close();
		
 
	}catch(Exception e){
	 
	 	response.getWriter().print("NOTGET");	 
	 	e.printStackTrace();
	 	
	  
	}finally{
		
		if(conn!=null)
	 	{
			// System.out.println("--1-conn----"+conn) ;
		conn.close();
	 	}
	}
  %>
  
