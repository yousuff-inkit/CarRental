<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	String hidcldocno = request.getParameter("hidcldocno")==null || request.getParameter("hidcldocno")==""?"0":request.getParameter("hidcldocno").trim();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = " select dr_id drid,concat(dr_id,' - ',replace(name,',',''))name From gl_drdetails where cldocno="+hidcldocno;   
		//    System.out.println("Driver detailsss--------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);      
		String drid="", drname="";
		while(rs.next()) {
			
			drname+=rs.getString("name")+","; 
			drid+=rs.getString("drid")+",";
	    }
		
		if(!drname.equals("")){
			drname=drname.substring(0, drname.length()>0?drname.length()-1:0); 
		}
		
		response.getWriter().write(drname+"####"+drid);            
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
