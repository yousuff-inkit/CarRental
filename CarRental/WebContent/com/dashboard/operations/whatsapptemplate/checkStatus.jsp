<%@page import ="java.util.Base64" %>
<%@page import = "java.sql.Connection"%>;  
<%@page import = "com.connection.ClsConnection"%>;  
<%@page import = "java.sql.ResultSet"%>;
<%@page import = "java.sql.Statement"%>;  
<%@page import = "com.fasterxml.jackson.databind.JsonNode"%>;
<%@page import = "com.fasterxml.jackson.databind.ObjectMapper"%>;  
<%@page import="org.apache.http.HttpEntity" %>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse" %>
<%@page import="org.apache.http.client.methods.HttpPost" %>
<%@page import="org.apache.http.entity.StringEntity" %>
<%@page import="org.apache.http.impl.client.CloseableHttpClient" %>
<%@page import="org.apache.http.impl.client.HttpClients" %>
<%@page import="org.apache.http.util.EntityUtils" %>  
<%	
Connection conn=null;
ClsConnection connDAO = new ClsConnection();
String bearer="", phoneId="", apiurlname="", apiurlid="";  
int val=0;
try {  
	conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement();
	Statement stmt1 = conn.createStatement();
	ResultSet rs00= conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select whatsappaccountid phonenoid,accesstoken from my_comp where status=3");
	if(rs00.next()) {
		bearer = rs00.getString("accesstoken");
		phoneId = rs00.getString("phonenoid");
	}
	rs00.close();
	
	String sql1 = "select apiurl from wa_apiurl where type='getTemplatesByName'";         
    ResultSet rs1 = stmt.executeQuery(sql1);
 	while(rs1.next()) {
 		apiurlname = rs1.getString("apiurl");
    }
 	
 	String sql2 = "select apiurl from wa_apiurl where type='getTemplatesById'";         
    ResultSet rs2 = stmt.executeQuery(sql2);
 	while(rs2.next()) {
 		apiurlid = rs2.getString("apiurl");
    }  
	
	ObjectMapper objMaper = new ObjectMapper();
	String resBody = "", rescode = "", message = "";
	CloseableHttpClient httpClient = HttpClients.createDefault();
	HttpPost httppost = new HttpPost(apiurlname+"?phoneId="+phoneId+"&accessToken="+bearer);
	httppost.setHeader("Content-Type", "application/json");
	try(CloseableHttpResponse resp = httpClient.execute(httppost)){
		HttpEntity entitys = resp.getEntity();
		resBody = EntityUtils.toString(entitys);
	}catch(Exception e){
		e.printStackTrace();
	}
	 
    //System.out.println("Response Body 1: " + resBody);
    JsonNode jsNode = objMaper.readTree(resBody);
	rescode = jsNode.has("rescode") ? jsNode.get("rescode").asText() : null;
	message = jsNode.has("message") ? jsNode.get("message").asText() : null; 
	//System.out.println("rescode=" + rescode+"=message=" + message);   
	if(rescode.equals("1")){   
	    JsonNode rootNode = objMaper.readTree(message);
	    JsonNode nodeArray = rootNode.get("data");  
	    //System.out.println("Before Loop");
	    for(JsonNode node : nodeArray){
	    	String id = node.get("id").asText();
	    	String name = node.get("name").asText();
	    	String status = node.get("status").asText();
	    	
	    	String sqlselect = "SELECT mediaid FROM wa_template WHERE mediaid='"+id+"'";
	    	ResultSet rs = stmt.executeQuery(sqlselect);
	    	if(!rs.next()){
	    		String inssql = "INSERT INTO wa_template(entrydate, name, status, mediaid) VALUES(now(), '"+name+"', '"+status+"', '"+id+"')";
				val=stmt1.executeUpdate(inssql);     
	    	}
	    }
	    //System.out.println("IN LOOP");
	    resBody = "";
	    String templateid="";
	    String sql = "SELECT mediaid FROM wa_template";
	    ResultSet rs11= stmt.executeQuery(sql);
	    while(rs11.next()){
	    	templateid = rs11.getString("mediaid");
	    	for(JsonNode node : nodeArray){
	    		String id = node.get("id").asText();
	    		if(id.equals(templateid)){
	    			String status = node.get("status").asText();
	    			
	    			HttpPost httppost1 = new HttpPost(apiurlid+"?templateId="+id+"&accessToken="+bearer);
	    			httppost.setHeader("Content-Type", "application/json");
	    			try(CloseableHttpResponse resp = httpClient.execute(httppost1)){
	    				HttpEntity entitys = resp.getEntity();
	    				resBody = EntityUtils.toString(entitys);
	    			}catch(Exception e){
	    				e.printStackTrace();
	    			}
	    			 
	    		    //System.out.println("Response Body 2: " + resBody);
	    		    JsonNode jsNode2 = objMaper.readTree(resBody);
	    			rescode = jsNode2.has("rescode") ? jsNode2.get("rescode").asText() : null;
	    			message = jsNode2.has("message") ? jsNode2.get("message").asText() : null;   
	    			if(rescode.equals("1")){ 
		    	        JsonNode jsNodeDet = objMaper.readTree(message); 
		    	        
		    			String upsql = "UPDATE wa_template SET status='"+status+"', category='"+jsNodeDet.get("category").asText()+"', lang='"+jsNodeDet.get("language").asText()+"' WHERE mediaid='"+templateid+"'";
		    			val=stmt1.executeUpdate(upsql);
	    			}  
	    		}
	    	}
	    }
	}
    response.getWriter().print(val);
} catch (Exception e) {
	response.getWriter().print(0);
	conn.close();
    e.printStackTrace();
}finally{
	conn.close();
}
  %>