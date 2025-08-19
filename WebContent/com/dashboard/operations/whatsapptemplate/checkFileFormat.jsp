<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;

	try{
		String extn = request.getParameter("extn")==null?"":request.getParameter("extn");
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		int val = 0;
		String mediasizeinbyte="", mediasize="";
		
		String sql = "select mediasizeinbyte, mediasize from wa_mediatype where status=3 and mediaformat='"+extn+"' and (mediatype like '%application%' or mediatype like '%image%' or mediatype like '%video%')";   
		ResultSet resultSet = stmt.executeQuery(sql);          
		if(resultSet.next()) {
			mediasizeinbyte = resultSet.getString("mediasizeinbyte");
			mediasize = resultSet.getString("mediasize");   
			val = 1;
		}
		
		response.getWriter().write(val+"####"+mediasizeinbyte+"####"+mediasize);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>