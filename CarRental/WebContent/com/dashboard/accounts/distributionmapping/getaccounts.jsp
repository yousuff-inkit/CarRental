<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	 
    ClsConnection conobj= new ClsConnection();
    ClsCommon com=new ClsCommon();
	
 	Connection conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement ();
	java.sql.Date sqlDate = null;
	
	String strSql = "select head,grno from my_agrp where gp_pr=0 and grno!=3";  
	
	//System.out.println("===strSql===currency="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String currId="",mClose="",currCode="",rate="";
	while(rs.next()) {   
	         	currId+=rs.getString("grno")+",";
	        	currCode+=rs.getString("head")+",";
	}
    //System.out.println("curr code "+currCode);   
	if(!currId.equals("")){
		    currId = currId.substring(0, currId.length()-1);
		    currCode = currCode.substring(0, currCode.length()-1);
   	}  
   
    response.getWriter().write(currId+"####"+currCode);    
	stmt.close();
	conn.close();
  %>