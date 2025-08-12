<%@page import = "java.io.BufferedReader"%>;
<%@page import = "java.io.DataOutputStream"%>;
<%@page import = "java.io.InputStreamReader"%>;
<%@page import = "java.net.HttpURLConnection"%>;
<%@page import = "java.net.URL"%>;
<%@page import = "java.nio.charset.Charset"%>;
<%-- <%@page import = "com.whatsapp.ClsWhatsappDAO"%>;  --%> 
<%@page import = "java.sql.*"%>;  
<%@page import = "com.connection.ClsConnection"%>; 
<%@page import="org.apache.http.HttpEntity" %>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse" %>
<%@page import="org.apache.http.client.methods.HttpPost" %>
<%@page import="org.apache.http.entity.StringEntity" %>
<%@page import="org.apache.http.impl.client.CloseableHttpClient" %>
<%@page import="org.apache.http.impl.client.HttpClients" %>
<%@page import="org.apache.http.util.EntityUtils" %>  
<%@page import="com.fasterxml.jackson.databind.JsonNode" %>  
<%@page import="com.fasterxml.jackson.databind.ObjectMapper" %> 
<%@page import="org.apache.http.entity.ContentType" %> 
<%
Connection conn=null;  
ClsConnection connDAO = new ClsConnection();
/* ClsWhatsappDAO waDAO = new ClsWhatsappDAO(); */
String name = request.getParameter("name")==null || request.getParameter("name").equals("")?"":request.getParameter("name");
String headertext = request.getParameter("headertext")==null || request.getParameter("headertext").equals("")?"":request.getParameter("headertext");
String bodytext = request.getParameter("bodytext")==null || request.getParameter("bodytext").equals("")?"":request.getParameter("bodytext");
String footertext = request.getParameter("footertext")==null || request.getParameter("footertext").equals("")?"":request.getParameter("footertext");
String qrbtext = request.getParameter("qrbtext")==null || request.getParameter("qrbtext").equals("")?"":request.getParameter("qrbtext");
String cabtext = request.getParameter("cabtext")==null || request.getParameter("cabtext").equals("")?"":request.getParameter("cabtext");
String caburl = request.getParameter("caburl")==null || request.getParameter("caburl").equals("")?"":request.getParameter("caburl"); 
String attachdoc = request.getParameter("attachdoc")==null || request.getParameter("attachdoc").equals("")?"0":request.getParameter("attachdoc"); 
String extn = request.getParameter("extn")==null || request.getParameter("extn").equals("")?"":request.getParameter("extn");
String dtype = request.getParameter("dtype")==null || request.getParameter("dtype").equals("")?"":request.getParameter("dtype");
String filesize = request.getParameter("fsize")==null || request.getParameter("fsize").equals("")?"":request.getParameter("fsize");  
String lang = request.getParameter("lang")==null || request.getParameter("lang").equals("")?"":request.getParameter("lang");  
int aaa=0;   
try{
	conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement();
	System.out.println("IN CREATE TEMPLATE");  
	
	System.out.println(headertext+"=|="+bodytext);
	
	//aaa = waDAO.createTemplate(conn, name, headertext, bodytext, footertext, qrbtext, cabtext, caburl, attachdoc, extn, dtype, filesize);   
	
	String cldocno="", mob="", client="", accesstoken="", phoneId="", whatsappaccountid="", appid="", whatsappno="", path="", mediatype="",apiurlcreatetemp="",
			mediaformat="", headertype="", rescode="", message="";
	String sql2 = "SELECT phonenoid, accesstoken, whatsappaccountid, appid, whatsappno FROM my_comp WHERE status=3";  
	ResultSet rs2 = stmt.executeQuery(sql2);
	while(rs2.next()){
		accesstoken = rs2.getString("accesstoken");
		phoneId = rs2.getString("phonenoid");
		whatsappaccountid = rs2.getString("whatsappaccountid");
		appid = rs2.getString("appid");
		whatsappno = rs2.getString("whatsappno");
	}
	
	String sql3 = "SELECT path FROM my_fileattach WHERE doc_no='"+attachdoc+"' AND dtype='WAM'";  
	ResultSet rs3 = stmt.executeQuery(sql3); 
	while(rs3.next()){
		path = rs3.getString("path");
	}
	path = path.replace("\\", "\\");  
	
	if(path.equals("")){
		headertype="TEXT";  
	}
	
	String sql4 = "select mediatype from wa_mediatype where mediaformat='"+extn+"'";         
    ResultSet rs4 = stmt.executeQuery(sql4);
 	while(rs4.next()) {
 		mediatype = rs4.getString("mediatype");
    }
 	String mediaarr[] = mediatype.split("/");
	mediaformat = mediaarr[0];
	
	String sql1 = "select apiurl from wa_apiurl where type='createTemplate'";         
    ResultSet rs1 = stmt.executeQuery(sql1);
 	while(rs1.next()) {
 		apiurlcreatetemp = rs1.getString("apiurl");
    }
	
	CloseableHttpClient httpClient = HttpClients.createDefault();
	HttpPost httppost = new HttpPost(apiurlcreatetemp);
	httppost.setHeader("Content-Type", "application/json; charset=UTF-8");
	
	ObjectMapper objmaper = new ObjectMapper();
	JsonNode node = objmaper.createObjectNode()
			.put("headertext", headertext)
            .put("bodytext", bodytext)
			.put("footertext", footertext)
			.put("headertype", headertype)
		    .put("qrbtext", qrbtext)
            .put("extn", extn)
            .put("caburl", caburl)
            .put("path", path)
            .put("bearer", accesstoken)
            .put("mediatype", mediatype)
            .put("mediaformat", mediaformat)
            .put("whatsappaccountid", whatsappaccountid)
            .put("appid", appid)
            .put("phoneId", phoneId)
			.put("filesize", filesize)
			.put("lang", lang)
			.put("name", name);
	
	String jsonArr = objmaper.writeValueAsString(node);
	StringEntity entity = new StringEntity(jsonArr, ContentType.APPLICATION_JSON);
	httppost.setEntity(entity);	
	
	try(CloseableHttpResponse resp = httpClient.execute(httppost)){
		HttpEntity entitys = resp.getEntity();
		String responseBody = EntityUtils.toString(entitys);
		System.out.println("APIRESPONSE : "+responseBody);  
		JsonNode JSnode = objmaper.readTree(responseBody);
		rescode = JSnode.has("rescode") ? JSnode.get("rescode").asText() : null;
		String mediaid = JSnode.has("mediaid") ? JSnode.get("mediaid").asText() : null;
		message = JSnode.has("message") ? JSnode.get("message").asText() : null;   
		System.out.println(rescode+"=="+mediaid+"=="+message);
		String success[] = message.split("####"); 
		if(rescode.equals("1")){  
			PreparedStatement  prest =conn.prepareStatement(
					"Insert Into wa_template(entrydate, name, headertext, bodytext, footertext, status, category, mediaid, whatsappid, userid)" +
					" VALUES(now(),?,?,?,?,?,?,?,?,?)");
		    prest.setString(1, name); 
		    prest.setString(2, headertext);
			prest.setString(3, bodytext); 
			prest.setString(4, footertext);	
			prest.setString(5, success[0]); 
		    prest.setString(6, success[1]); 
		    prest.setString(7, mediaid); 
		    prest.setString(8, whatsappaccountid); 
		    prest.setString(9, session.getAttribute("USERID").toString().trim());    
			prest.executeUpdate(); 
			aaa = 1;
	   }else{
		   aaa = 0;  
	   }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try{
			httpClient.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	response.getWriter().print(aaa);
}
catch(Exception e){ 
	conn.close();
	response.getWriter().print(0);
	e.printStackTrace();
}finally{
	conn.close();
}
%>