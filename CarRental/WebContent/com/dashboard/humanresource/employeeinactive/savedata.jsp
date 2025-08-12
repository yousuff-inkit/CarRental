<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();

	String date=request.getParameter("date");
	String hiddocno=request.getParameter("hiddocno");
	java.sql.Date sqlDate=null;

    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
	     sqlDate=ClsCommon.changeStringtoSqlDate(date);
	}

	int val=0;
	Statement stmt=conn.createStatement();
	String strsql="update hr_empm set status=7,active=0, terminated_date='"+sqlDate+"' where doc_no ='"+hiddocno+"'";
	 val= stmt.executeUpdate(strsql);
	 
	 response.getWriter().print(val);

	 stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
}finally{
	   conn.close();
}
	%>
