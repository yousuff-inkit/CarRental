<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String cldocno = request.getParameter("wano")==null || request.getParameter("wano").trim().equals("")?"":request.getParameter("wano"); 
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();  
		
		JSONArray jsonUsers = new JSONArray();
		
		String sql = "select * from (select UPPER(SUBSTRING_INDEX(m.mediatype, '/', 1)) mediatype, chat, DATE_FORMAT(c.edate,'%d.%m.%Y') date, DATE_FORMAT(c.edate,'%H.%i') time, edate, ac.refname touser, c.whatsappno fromuserno, c.towano touserno, c.fromtext, c.totext, a1.refname fromuser, c.rowno, c.mediaid, attachdoc, template from my_acbook ac inner join wa_messagelog c on ac.per_mob=c.towano left join my_acbook a1 on a1.per_mob=c.whatsappno left join wa_medialog m on m.mediaid=c.mediaid where ac.cldocno='"+cldocno+"' and ac.dtype='CRM')a group by a.rowno order by a.rowno";
		System.out.println("Chatlog--->>>"+sql);       
		ResultSet rs = stmt.executeQuery(sql);     
		while(rs.next()){
			JSONObject userList = new JSONObject();
			userList.put("touser", rs.getString("touser"));
			userList.put("fromuser", rs.getString("fromuser"));
			userList.put("fromuserno", rs.getString("fromuserno"));
			userList.put("fromtext", rs.getString("fromtext"));
			userList.put("touserno", rs.getString("touserno"));
			userList.put("totext", rs.getString("totext"));
			userList.put("date", rs.getString("date"));
			userList.put("time", rs.getString("time"));
			userList.put("mediaid", rs.getString("mediaid"));
			userList.put("attachdoc", rs.getString("attachdoc"));
			userList.put("template", rs.getString("template"));
			userList.put("chat", rs.getString("chat"));   
			userList.put("mediatype", rs.getString("mediatype"));       
			jsonUsers.add(userList);  
		}   
		JSONObject jsonObUserList = new JSONObject();
		jsonObUserList.put("chatlist", jsonUsers); 
		response.getWriter().print(jsonObUserList);  

 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>