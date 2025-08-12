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
<%@page import="com.fasterxml.jackson.databind.node.ObjectNode" %>
<%@page import="com.common.ClsCommon"%> 
<%@page import="com.emailnew.EmailUtility"%>
<%@page import="java.io.File"%>
<%@page import="com.common.ClsEncrypt"%>    
<%              
String remark = request.getParameter("remarks")==null?"":request.getParameter("remarks");   
String crtuser = request.getParameter("crtuser")==null || request.getParameter("crtuser").equals("")?"0":request.getParameter("crtuser");     
String userid = request.getParameter("userid")==null || request.getParameter("userid").equals("")?"0":request.getParameter("userid");
String status = request.getParameter("status")==null?"":request.getParameter("status");
String oldstatus = request.getParameter("oldstatus")==null?"":request.getParameter("oldstatus");
String docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno"); 
String asgnuser = request.getParameter("asgnuser")==null || request.getParameter("asgnuser").equals("")?"0":request.getParameter("asgnuser");  
String oldassuser = request.getParameter("oldassuser")==null?"":request.getParameter("oldassuser");        
int val=0;   
Connection conn=null;
try{          
	ClsConnection objconn=new ClsConnection();  
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	EmailUtility utl = new EmailUtility();
	ClsEncrypt crypt = new ClsEncrypt();
	String strsql = "", assigneduser = "";
	
	if(!(status.equalsIgnoreCase("Confirmed") || status.equalsIgnoreCase("Completed"))){                  
		if(!asgnuser.equalsIgnoreCase("")){ 
			assigneduser = asgnuser;
			strsql="update an_taskcreation set ass_user='"+asgnuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
		}else{  
			assigneduser = oldassuser;
			strsql="update an_taskcreation set ass_user='"+oldassuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";
			val=stmt.executeUpdate(strsql);
		}      
	}else if(status.equalsIgnoreCase("Completed")){   
		    assigneduser = crtuser;
			strsql="update an_taskcreation set ass_user='"+crtuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
	}else{
		  assigneduser = crtuser;
		  strsql="update an_taskcreation set act_status='"+status+"',close_status=1 where doc_no='"+docno+"' and utype!='app'";  
		  val=stmt.executeUpdate(strsql);
	}
	int val2=0;
	if(val>0){    
		String flwsql="insert into an_taskcreationdets(rdocno,ass_date,userid,assnfrom_user,action_status,remarks) values('"+docno+"',now(),'"+asgnuser+"','"+session.getAttribute("USERID")+"','"+status+"','"+remark+"')";
		val2=stmt.executeUpdate(flwsql);          
	}
	
	if(val2>0){
		System.out.println(crtuser+"====||| 0 |||===="+assigneduser);
		if(!crtuser.equals(assigneduser)){                
			System.out.println("====||| 1 |||====");
			String host = "", port = "", userName = "", password = "", recipient = "", subject = "", mailmessage = "", mobile = "", template = "", accesstoken="", phoneId="", 
					whatsappaccountid="", appid="", whatsappno="", path="", mediatype="", mediaformat="", apiurl = "", cldocnos = "", msg = "", attachdoc = "", extn = "",
					msgtype = "Template", cldocno="0", mob="", client="", rescode="",message="";  
			File saveFile = null;  
			
			String sqlstr = "SELECT mail, mailpass, smtpserver, smtphostport FROM my_user WHERE status=3 AND user_id='super'";	
			ResultSet rs = stmt.executeQuery(sqlstr);
			while(rs.next()){   
				host = rs.getString("smtpserver");
				port = rs.getString("smtphostport");
				userName = rs.getString("mail");
				password = crypt.decrypt(rs.getString("mailpass").trim());    
			}   
			//System.out.println("====||| 2 |||====");
			String senduserid = "0";
			String sqlsel = "SELECT IF('Assigned'='Completed',ua.doc_no,u.doc_no) touserid FROM an_taskcreation t LEFT JOIN my_user u ON u.doc_no=t.userid LEFT JOIN (select max(rowno) rowno,rdocno from an_taskcreationdets group by rdocno) s ON t.doc_no=s.rdocno LEFT JOIN an_taskcreationdets ds on ds.rowno=s.rowno LEFT JOIN my_user ua ON ua.doc_no=ds.assnfrom_user WHERE t.doc_no='"+docno+"'"; 	  
			ResultSet rssel = stmt.executeQuery(sqlsel);
			while(rssel.next()){
				senduserid = rssel.getString("touserid");         
			}    
			//System.out.println("====||| 3 |||====");
			String sqlstr1 = "SELECT email, mobile FROM my_user WHERE doc_no='"+senduserid+"'";    	  
			ResultSet rs1 = stmt.executeQuery(sqlstr1);
			while(rs1.next()){
				recipient = rs1.getString("email");  
				mobile = rs1.getString("mobile");    
			}
			//System.out.println("====||| 4 |||====");
			String mailmsgsql="";
			String sqlstr2 = "select msg, subject from gl_emailmsg where dtype='TMT' and description='"+status+"'";    	  
			ResultSet rs2 = stmt.executeQuery(sqlstr2);
			while(rs2.next()){
				mailmsgsql = rs2.getString("msg").replaceAll("document", docno+"");           
				subject = rs2.getString("subject");      
			}
			//System.out.println("====||| 5 |||===="+mailmsgsql);
			if(!mailmsgsql.equals("")){  
				ResultSet rs3 = stmt.executeQuery(mailmsgsql);
				while(rs3.next()){
					mailmessage = rs3.getString("content");        
				}  
			}
			
			//System.out.println(message+"====+===="+recipient);  
			try{
				if(!mailmessage.equals("") && !recipient.equals("")){     
					String successtatus = utl.sendEmailpdf(host,  port, userName,  password,  recipient,  "" , subject,  mailmessage, "", "", saveFile);  
					//System.out.println("====successtatus===="+successtatus);    
				}   
			  }catch(Exception e){
				e.printStackTrace();  
			} 
			
			String whatsappmsgsql="";
			String sqlstr4 = "select msg, template, t.mediaid templateid from gl_whatsappmsg g left join wa_template t on t.name=g.template where dtype='TMT' and description='"+status+"'";  	  
			ResultSet rs4 = stmt.executeQuery(sqlstr4);
			while(rs4.next()){
				whatsappmsgsql = rs4.getString("msg").replaceAll("document", docno+"");           
				template = rs4.getString("templateid");            
			}
			//System.out.println(template+"========"+whatsappmsgsql);      
			String touser = "", taskname = "", edc = "", fromuser = "";  
			if(!whatsappmsgsql.equals("")){  
				ResultSet rs5 = stmt.executeQuery(whatsappmsgsql);  
				while(rs5.next()){
					touser = rs5.getString("touser");
					taskname = rs5.getString("taskname");
					edc = rs5.getString("edcdate");
					fromuser = rs5.getString("fromuser");
				}  
			}   
			String param1 = "{ \"type\": \"text\", \"text\": \"touser\" }"; 
			String param2 = "{ \"type\": \"text\", \"text\": \"task\" }"; 
			String param3 = "{ \"type\": \"text\", \"text\": \"edc\" }"; 
			String param4 = "{ \"type\": \"text\", \"text\": \"fromuser\" }";   
			
			ObjectMapper objectMapper = new ObjectMapper();
		    ObjectNode objectNode = (ObjectNode) objectMapper.readTree(param1);
	
		    if (objectNode.has("text")) {
		            objectNode.put("text", touser);
		    }
		    param1 = objectMapper.writeValueAsString(objectNode);
	        //System.out.println("UPDATED : "+param1);
	        
	        objectNode = (ObjectNode) objectMapper.readTree(param2);
	
		    if (objectNode.has("text")) {
		            objectNode.put("text", taskname);
		    }
		    param2 = objectMapper.writeValueAsString(objectNode);
	        //System.out.println("UPDATED : "+param2);
	        
	        objectNode = (ObjectNode) objectMapper.readTree(param3);
	
		    if (objectNode.has("text")) {
		            objectNode.put("text", edc);
		    }
		    param3 = objectMapper.writeValueAsString(objectNode);
	        //System.out.println("UPDATED : "+param3);
	        
	        objectNode = (ObjectNode) objectMapper.readTree(param4);
	
		    if (objectNode.has("text")) {
		            objectNode.put("text", fromuser);  
		    }
		    param4 = objectMapper.writeValueAsString(objectNode);
	        //System.out.println("UPDATED : "+param4);
	        String paramslist = "";
	        
	        if(status.equalsIgnoreCase("Assigned")){  
			     paramslist = "[{\"type\": \"body\", \"parameters\": ["+param1+", "+param2+", "+param3+"]}]";      
	        }else{
	        	 paramslist = "[{\"type\": \"body\", \"parameters\": ["+param1+", "+param2+", "+param4+"]}]"; 
	        }
	        
			if((!mobile.equals("") && mobile!=null) && !touser.equals("")){  
				String sql2 = "SELECT phonenoid, accesstoken, whatsappaccountid, appid, whatsappno FROM my_comp WHERE status=3";  
				ResultSet rs6 = stmt.executeQuery(sql2);
				while(rs6.next()){
					accesstoken = rs6.getString("accesstoken");
					phoneId = rs6.getString("phonenoid");
					whatsappaccountid = rs6.getString("whatsappaccountid");
					appid = rs6.getString("appid");
					whatsappno = rs6.getString("whatsappno");  
				}
				
				String sql3 = "select apiurl from wa_apiurl where type='sendMultimediawithmsg'";         
			    ResultSet rs7 = stmt.executeQuery(sql3);
			 	while(rs7.next()) {
			 		apiurl = rs7.getString("apiurl");  
			    }
				
				CloseableHttpClient httpClient = HttpClients.createDefault();
				HttpPost httppost = new HttpPost(apiurl);
				httppost.setHeader("Content-Type", "application/json");
				//System.out.println("apiurl=="+apiurl);  
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
			            .put("phoneId", phoneId)
			            .put("params", paramslist);  
				
				   JsonNode clientdetails = objmaper.createArrayNode()
			               .add(objmaper.createObjectNode()
			                       .put("clname", client)
			                       .put("mobno", mobile)
			                       .put("cldocno", cldocno));   
				
				((com.fasterxml.jackson.databind.node.ObjectNode) node).set("clientdetails", clientdetails);
				String jsonArr = objmaper.writeValueAsString(node);
				StringEntity entity = new StringEntity(jsonArr);
				httppost.setEntity(entity);
				try(CloseableHttpResponse resp = httpClient.execute(httppost)){
					HttpEntity entitys = resp.getEntity();
					String responseBody = EntityUtils.toString(entitys);
					//System.out.println("APIRESPONSE : "+responseBody);  
					JsonNode JSnode = objmaper.readTree(responseBody);
					rescode = JSnode.has("rescode") ? JSnode.get("rescode").asText() : null;
					String mediaid = JSnode.has("mediaid") ? JSnode.get("mediaid").asText() : null;
					message = JSnode.has("message") ? JSnode.get("message").asText() : null;   
					//System.out.println(rescode+"=="+mediaid+"=="+message);
					if(rescode.equals("1")){  
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
				}	
			}
		  }
	  }		
	//System.out.println(val+"---->>>"+strsql);  
}   
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(val+"");   

%>