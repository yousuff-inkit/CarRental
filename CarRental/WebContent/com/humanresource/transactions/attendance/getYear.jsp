<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select year(min(accyr_f)) year2,year(curdate()) year  from my_year";
		ResultSet rs = stmt.executeQuery(strSql);
		String srtyear="";
		String year="";
		String yearid="";
		String endyear="";
		while(rs.next()) {
			endyear=rs.getString("year");	
			srtyear=rs.getString("year2");
	  	}
		
		for(int i=Integer.parseInt(endyear);i>=Integer.parseInt(srtyear);i--){
			year+=i+",";
			yearid+=i+",";
		}
		
		year=year.substring(0, year.length()>0?year.length()-1:0);
		
		response.getWriter().write(year+"####"+yearid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
