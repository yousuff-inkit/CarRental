<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String userid = request.getParameter("userid")==null || request.getParameter("userid").trim().equals("")?"0":request.getParameter("userid").trim().toString();
	String name = request.getParameter("name")==null || request.getParameter("name").trim().equals("")?"":request.getParameter("name").trim().toString();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		JSONArray jsonUsers = new JSONArray();
		String sql="", sqltest="";	
		System.out.println(name+"==1=="+userid);   
		//String sql = "select  ac.cldocno,w.towano whatsappno, ac.refname wauser from wa_messagelog w left join my_acbook ac on ac.per_mob=w.towano WHERE 1=1 GROUP BY w.towano";  
		 
		if(!name.equals("")){
			sqltest = " and ac.refname like '%"+name+"%' ";   
		}
	    sql = "select ac.refname wauser, ac.cldocno, ac.per_mob whatsappno from wa_clientuserlink l left join my_acbook ac on ac.cldocno=l.cldocno and ac.dtype='crm' where userid='"+userid+"' "+sqltest+"";
		System.out.println("namesql--->>>"+sql);    
		ResultSet rs1 = stmt.executeQuery(sql);      
		while(rs1.next()){
				JSONObject userList = new JSONObject();
				userList.put("whatsappno", rs1.getString("whatsappno"));
				userList.put("wauser", rs1.getString("wauser"));
				userList.put("cldocno", rs1.getString("cldocno"));
				jsonUsers.add(userList);  
		}   
		System.out.println("jsonUsers--->>>"+jsonUsers);          
		
		JSONObject jsonObUserList = new JSONObject();
		jsonObUserList.put("users", jsonUsers); 
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