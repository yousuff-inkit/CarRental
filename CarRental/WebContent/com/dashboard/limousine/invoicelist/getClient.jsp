<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String strSql = "select refname, cldocno from my_acbook where dtype='CRM' and status=3" ;
	    //System.out.println("sql --====== "+strSql);   
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="";
		while(rs.next()) {
					brnch+=rs.getString("refname")+",";
					brnchId+=rs.getString("cldocno")+",";
	  		}  
		
		if(!brnchId.equals("")){
			brnch=brnch.substring(0, brnch.length()-1);
			brnchId=brnchId.substring(0, brnchId.length()-1);
		}
		
		response.getWriter().write(brnchId+"####"+brnch);                   
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>