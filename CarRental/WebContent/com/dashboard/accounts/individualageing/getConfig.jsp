
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<% 
		 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();


	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
	int conval=0;
	
		String consql="select method from gl_config where field_nme='Acurr'";
		ResultSet rsconfg = stmt.executeQuery(consql);

		while (rsconfg.next()) {
			conval=rsconfg.getInt("method");
			System.out.println("conval=="+conval);
		}
	
		response.getWriter().print(conval);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  