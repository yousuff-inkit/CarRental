<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String strSql = "select ac.cldocno, concat(ac.acno,' - ',replace(ac.refname,',',''))refname,ac.acno from my_acbook ac where ac.dtype='CRM' and ac.status=3 ";   
	//System.out.println("Client detailsss--------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);      
		String emp="", empid="",empacno="";
		while(rs.next()) {
			emp+=rs.getString("refname")+",";
			empid+=rs.getString("cldocno")+","; 
			empacno+=rs.getString("acno")+",";   
	    }
		
		if(!emp.equals("")){
			emp=emp.substring(0, emp.length()>0?emp.length()-1:0); 
		}
		
		response.getWriter().write(emp+"####"+empid+"####"+empacno);            
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
