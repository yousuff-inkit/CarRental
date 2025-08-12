<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = "select mode,sr_no  from my_cardm where id=1 and dtype in ('mode','refund')";
		System.out.println("strSql54===>"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String pay="",payId="";
		while(rs.next()) {
					pay+=rs.getString("mode")+",";
					payId+=rs.getString("sr_no")+",";
				} 
		
		String brn[]=pay.split(",");
		String brnId[]=payId.split(",");
		
		pay=pay.substring(0, pay.length()-1);
		payId=payId.substring(0, payId.length()-1);
		
		response.getWriter().write(payId+"####"+pay);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  