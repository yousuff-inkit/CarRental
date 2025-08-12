<%-- <%@page import = "com.whatsapp.ClsWhatsappDAO"%>;   --%>
<%@page import = "java.sql.*"%>;  
<%@page import = "com.connection.ClsConnection"%>;  
<%@page import = "com.fasterxml.jackson.databind.JsonNode"%>;
<%@page import = "com.fasterxml.jackson.databind.ObjectMapper"%>;
<%@page import = "org.apache.http.HttpEntity" %>
<%@page import = "org.apache.http.client.methods.CloseableHttpResponse" %>
<%@page import = "org.apache.http.client.methods.HttpPost" %>
<%@page import = "org.apache.http.entity.StringEntity" %>
<%@page import = "org.apache.http.impl.client.CloseableHttpClient" %>
<%@page import = "org.apache.http.impl.client.HttpClients" %>
<%@page import = "org.apache.http.util.EntityUtils" %> 
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
//ClsWhatsappDAO waDAO = new ClsWhatsappDAO();
String name = request.getParameter("name")==null || request.getParameter("name").equals("")?"":request.getParameter("name").trim();
int aaa=0; 
String bearer="", phoneId="", apiurldeltemp="";
try{
	conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement();
	System.out.println("IN DELETE TEMPLATE");
	//aaa = waDAO.deleteTemplate(conn, name);  
	
	ResultSet rs00= conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
					"select whatsappaccountid phonenoid,accesstoken from my_comp where status=3");
	if(rs00.next()) {
		bearer = rs00.getString("accesstoken");
		phoneId = rs00.getString("phonenoid");
	}
	rs00.close();
	
	String sql1 = "select apiurl from wa_apiurl where type='deleteTemplate'";         
    ResultSet rs1 = stmt.executeQuery(sql1);
 	while(rs1.next()) {
 		apiurldeltemp = rs1.getString("apiurl");
    }
 	
	ObjectMapper objMaper = new ObjectMapper();
	String resBody = "", rescode = "", message = "";
	CloseableHttpClient httpClient = HttpClients.createDefault();    
	HttpPost httppost = new HttpPost(apiurldeltemp+"?phoneId="+phoneId+"&accessToken="+bearer+"&templateName="+name);
	httppost.setHeader("Content-Type", "application/json");
	try(CloseableHttpResponse resp = httpClient.execute(httppost)){
		HttpEntity entitys = resp.getEntity();
		resBody = EntityUtils.toString(entitys);
	}catch(Exception e){
		e.printStackTrace();
	}
	System.out.println("Response Body 1: " + resBody);
    JsonNode jsNode = objMaper.readTree(resBody);
	rescode = jsNode.has("rescode") ? jsNode.get("rescode").asText() : null;
	if(rescode.equals("1")){
		String sqldelete = "DELETE FROM wa_template WHERE upper(replace(name,' ',''))=upper(replace('"+name+"',' ',''))";   
		aaa = stmt.executeUpdate(sqldelete);
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