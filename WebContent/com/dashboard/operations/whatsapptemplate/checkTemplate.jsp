<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;

	try{
		String name = request.getParameter("name")==null?"":request.getParameter("name");
		String body = request.getParameter("body")==null?"":request.getParameter("body");
		String footer = request.getParameter("footer")==null?"":request.getParameter("footer");
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();  
		int val = 0;
		if(!name.equals("")){
			String sql = "select doc_no from wa_template where upper(replace(name,' ',''))=upper(replace('"+name+"',' ',''))";   
			ResultSet resultSet = stmt.executeQuery(sql);          
			while(resultSet.next()) {  
				val = 1;
			}
		}
		
		if(!body.equals("")){
			String sql1 = "select doc_no from wa_template where upper(replace(bodytext,' ',''))=upper(replace('"+body+"',' ',''))";   
			ResultSet resultSet1 = stmt.executeQuery(sql1);          
			while(resultSet1.next()) {  
				val = 2;
			}
		}
		
		if(!footer.equals("")){
			String sql2 = "select doc_no from wa_template where upper(replace(footertext,' ',''))=upper(replace('"+footer+"',' ',''))";   
			ResultSet resultSet2 = stmt.executeQuery(sql2);             
			while(resultSet2.next()) {  
				val = 3;
			}
		}   
		
		response.getWriter().print(val);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>