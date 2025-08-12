<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
	Connection conn=null;
	int configmethod=0;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strsql="select rentalpreauth from my_brch where doc_no="+branch+" and status=3";
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			configmethod=rs.getInt("rentalpreauth");
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(configmethod+"");
%>