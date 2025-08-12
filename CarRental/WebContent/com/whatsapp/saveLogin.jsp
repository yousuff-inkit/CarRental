<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.ClsEncrypt" %>
<%	
	 ClsConnection ClsConnection=new ClsConnection();

	 String user = request.getParameter("username")==null?"":request.getParameter("username").trim().toString();
	 String pass = request.getParameter("password")==null?"":request.getParameter("password").trim().toString();
	 Connection conn=null;
	 try{
    
		 int val=0;
		 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement ();
		 ClsEncrypt ClsEncrypt=new ClsEncrypt();
		 
		 pass = ClsEncrypt.getInstance().encrypt(pass);
		 int wachat = 0, userid = 0;
		 String sql = "select wachat, doc_no from my_user where user_id='"+user+"' and pass='"+pass+"' and block=0 and wachat=1";    
		 System.out.println("login==="+sql);
		 ResultSet rs = stmt.executeQuery(sql);
		 if(rs.next()){
			 val = 1;
			 wachat = rs.getInt("wachat");
			 userid = rs.getInt("doc_no");  
		 }
		 
		 response.getWriter().print(val+"####"+userid);  
	 	 stmt.close();
	 	 conn.close();
	 } catch(Exception e){
	 			conn.close();
	 			e.printStackTrace();
	  }finally{
		  if(conn!=null){
			  conn.close();
		  }
	  }  
	%>