
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int Salesman=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='Salesman'";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		Salesman=rs.getInt("method");
	}
	if(Salesman==1){
		
		String strsql1="select * from my_user u left join my_urole ur on u.role_id=ur.doc_no where urolelevel=1 and u.doc_no="+session.getAttribute("USERID");
		System.out.println("config======"+strsql1);
		ResultSet rs1=stmt.executeQuery(strsql1);
		while(rs1.next()){
			Salesman=0;
		}
	}
	
	response.getWriter().print(Salesman);	 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

%>