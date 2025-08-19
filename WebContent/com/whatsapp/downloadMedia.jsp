<%@page import ="java.util.Base64" %>
<%@page import = "java.sql.Connection"%>;  
<%@page import = "com.connection.ClsConnection"%>;  
<%@page import = "java.sql.ResultSet"%>;
<%@page import = "java.sql.Statement"%>;  
<%@page import = "com.fasterxml.jackson.databind.JsonNode"%>;
<%@page import = "com.fasterxml.jackson.databind.ObjectMapper"%>;
<%@page import = "org.apache.http.HttpEntity" %>
<%@page import = "org.apache.http.client.methods.CloseableHttpResponse" %>
<%@page import = "org.apache.http.client.methods.HttpPost" %>
<%@page import = "org.apache.http.entity.StringEntity" %>
<%@page import = "org.apache.http.impl.client.CloseableHttpClient" %>
<%@page import = "org.apache.http.impl.client.HttpClients" %>
<%@page import = "org.apache.http.util.EntityUtils" %>  
<%@page import = "java.io.InputStream" %> 
<%@page import = "java.io.FileOutputStream" %> 
<%@page import = "java.io.InputStreamReader" %> 
<%@page import = "java.io.File" %> 
<%@page import = "java.io.ByteArrayInputStream" %>
<%@page import = "java.io.ByteArrayOutputStream" %>
<%@page import = "java.nio.charset.StandardCharsets" %>  

<%	
Connection conn=null;
ClsConnection connDAO = new ClsConnection();
String bearer="", phoneId="", filePath="", path="", filename = "", apiurl="";
int val=0;
String mediaId = request.getParameter("mediaId")==null || request.getParameter("mediaId").equals("")?"":request.getParameter("mediaId");
String attachDoc = request.getParameter("attachDoc")==null || request.getParameter("attachDoc").equals("")?"":request.getParameter("attachDoc");
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
	
	ResultSet rs22= conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select path, filename from my_fileattach where doc_no='"+attachDoc+"' and dtype='wam'");
	if(rs22.next()) {
		path = rs22.getString("path");
		filename = rs22.getString("filename");
	}
	rs22.close();
	
	String sql5 = "select apiurl from wa_apiurl where type='getMediaFile'";         
    ResultSet rs5 = stmt.executeQuery(sql5);
 	while(rs5.next()) {
 		apiurl = rs5.getString("apiurl");
    }
	
	
	ObjectMapper objMaper = new ObjectMapper();
	String resBody = "", rescode = "", message = "";
	CloseableHttpClient httpClient = HttpClients.createDefault();
	HttpPost httppost = new HttpPost("http://localhost:8080/api/"+apiurl+"?mediaId="+mediaId+"&accessToken="+bearer);  
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
	String ipstream = jsNode.has("ipstream") ? jsNode.get("ipstream").asText() : null;
	String mediatype = jsNode.has("mediatype") ? jsNode.get("mediatype").asText() : null;
	System.out.println("mediatype : " + mediatype);
	String[] mediaspec = mediatype.split("/");
	//InputStream inputStream = new ByteArrayInputStream(ipstream.getBytes(StandardCharsets.UTF_8));
	byte[] bytes = Base64.getDecoder().decode(ipstream);
	InputStream inputStream = new ByteArrayInputStream(bytes);
	System.out.println("rescode=" + rescode+"=message=" + message);  
	String extn="";
	ResultSet rs11= conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select mediaformat from wa_mediatype where mediatype='"+mediatype+"'");  
	while(rs11.next()) {
		extn = rs11.getString("mediaformat");   
	}
	rs11.close();
	
	if(rescode.equals("1")){
		String downloadFolderPath = System.getProperty("user.home") + File.separator + "Downloads" + File.separator;
		filePath = downloadFolderPath + "media_file." + extn;
        System.out.println("filePath : " + filePath);
		FileOutputStream outputStream = new FileOutputStream(filePath);
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.close();
        inputStream.close();
		val=1;
	}
	
	System.out.println("==RESULT==" + val);  
	System.out.println("filePath : " + filePath);
    response.getWriter().print(val+"####"+filePath+"####"+path+"####"+filename+"####");
} catch (Exception e) {
	response.getWriter().print(0+"####"+filePath+"####"+path+"####"+filename+"####");
	conn.close();
    e.printStackTrace();
}finally{
	conn.close();
}
  %>