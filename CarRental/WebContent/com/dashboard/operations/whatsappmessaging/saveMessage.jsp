 <%@page import="java.io.IOException"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <%@page import="com.whatsapp.ClsWhatsappDAO"%>  --%>
<%@page import="org.apache.http.HttpEntity" %>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse" %>
<%@page import="org.apache.http.client.methods.HttpPost" %>
<%@page import="org.apache.http.entity.StringEntity" %>
<%@page import="org.apache.http.impl.client.CloseableHttpClient" %>
<%@page import="org.apache.http.impl.client.HttpClients" %>
<%@page import="org.apache.http.util.EntityUtils" %>  
<%@page import="com.fasterxml.jackson.databind.JsonNode" %>  
<%@page import="com.fasterxml.jackson.databind.ObjectMapper" %>  
<%                         	
String cldocnos = request.getParameter("cldocnos")==null || request.getParameter("cldocnos").equals("")?"0":request.getParameter("cldocnos");
String msg = request.getParameter("msg")==null || request.getParameter("msg").equals("")?"":request.getParameter("msg");
String attachdoc = request.getParameter("attachdoc")==null || request.getParameter("attachdoc").equals("")?"":request.getParameter("attachdoc");
String extn = request.getParameter("extn")==null || request.getParameter("extn").equals("")?"":request.getParameter("extn");
String msgtype = request.getParameter("msgtype")==null || request.getParameter("msgtype").equals("")?"":request.getParameter("msgtype");
String template = request.getParameter("template")==null || request.getParameter("template").equals("")?"":request.getParameter("template");
Connection conn=null;
int aaa=0;
String rescode="",message="";
try{
	ClsConnection ClsConnection=new ClsConnection(); 
	/* ClsWhatsappDAO DAO = new ClsWhatsappDAO(); */
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	System.out.println(extn+"=MEDIA="+msgtype);
	
	String cldocno="", mob="", client="", accesstoken="", phoneId="", whatsappaccountid="", appid="", whatsappno="", path="", mediatype="", mediaformat="", apiurl = "";
	String sql1 = "SELECT refname, per_mob, cldocno FROM my_acbook WHERE cldocno in("+cldocnos.substring(0, cldocnos.length()-1)+") AND dtype='CRM'";  
	System.out.println("client sql==="+sql1);
	ResultSet rs1 = stmt2.executeQuery(sql1);
	while(rs1.next()){
		cldocno = rs1.getString("cldocno");
		client = rs1.getString("refname");
		mob = rs1.getString("per_mob");
	
	
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
	
	String sql4 = "select mediatype from wa_mediatype where mediaformat='"+extn+"'";         
    ResultSet rs4 = stmt.executeQuery(sql4);
 	while(rs4.next()) {
 		mediatype = rs4.getString("mediatype");
    }    
	String mediaarr[] = mediatype.split("/");
	mediaformat = mediaarr[0];
	
	String sql5 = "select apiurl from wa_apiurl where type='sendMultimediawithmsg'";         
    ResultSet rs5 = stmt.executeQuery(sql5);
 	while(rs5.next()) {
 		apiurl = rs5.getString("apiurl");
    }
	
	CloseableHttpClient httpClient = HttpClients.createDefault();
	HttpPost httppost = new HttpPost(apiurl);
	httppost.setHeader("Content-Type", "application/json");
	System.out.println("apiurl=="+apiurl);  
	ObjectMapper objmaper = new ObjectMapper();
	JsonNode node = objmaper.createObjectNode()
			.put("msgtext", msg)
            .put("path", path)
            .put("extn", extn)
            .put("msgtype", msgtype)
            .put("template", template)
            .put("bearer", accesstoken)
            .put("mediatype", mediatype)
            .put("mediaformat", mediaformat)
            .put("whatsappaccountid", whatsappaccountid)
            .put("appid", appid)
            .put("phoneId", phoneId);
	
	   JsonNode clientdetails = objmaper.createArrayNode()
               .add(objmaper.createObjectNode()
                       .put("clname", client)
                       .put("mobno", mob)
                       .put("cldocno", cldocno));   
	
	((com.fasterxml.jackson.databind.node.ObjectNode) node).set("clientdetails", clientdetails);
	String jsonArr = objmaper.writeValueAsString(node);
	StringEntity entity = new StringEntity(jsonArr);
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
		if(rescode.equals("1")){  
			if(mediaid!=null && !mediaid.equals("")) {  
	 		   PreparedStatement  prest =conn.prepareStatement(
							"Insert Into wa_medialog(doc_no, brhid, userid, date, accesstoken, phoneid, mediaid, mediatype)" +
							" VALUES(?,?,?,now(),?,?,?,?)");
				    prest.setString(1, cldocno); 
				    prest.setString(2, "1");
					prest.setString(3, session.getAttribute("USERID").toString().trim());	
					prest.setString(4, accesstoken); 
					prest.setString(5, phoneId);
					prest.setString(6, mediaid);
					prest.setString(7, mediatype);
					prest.executeUpdate(); 
	 	    }
			
			PreparedStatement  prest =conn.prepareStatement(
					"Insert Into wa_messagelog(cldocno, brhid, dtype, edate, userid, towano, mediaid, attachdoc, fromwaid, fromphid, appid, fromtext, whatsappno, template)" +
					" VALUES(?,?,?,now(),?,?,?,?,?,?,?,?,?,?)");
		    prest.setString(1, cldocno);   
		    prest.setString(2, "1");
			prest.setString(3, "WAM"); 
			prest.setString(4, session.getAttribute("USERID").toString().trim());	
			prest.setString(5, mob); 
			prest.setString(6, mediaid); 
			prest.setString(7, attachdoc.equals("")?"0":attachdoc);    
			prest.setString(8, whatsappaccountid);   
			prest.setString(9, phoneId);   
			prest.setString(10, appid);   
			prest.setString(11, msg);
			prest.setString(12, whatsappno);
			prest.setString(13, template);
			prest.executeUpdate();	
	   }
	}catch(IOException e){
		e.printStackTrace();
	}finally{
		try{
			httpClient.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	}
	//aaa = DAO.sendMultipleMsgWithMedia(conn, cldocnos.substring(0, cldocnos.length()-1), msg, attachdoc, extn, msgtype, template);     
	conn.close(); 
	response.getWriter().print(rescode+"####"+message);
}
catch(Exception e){
	conn.close();
	response.getWriter().print(0);
	e.printStackTrace();
}
%>