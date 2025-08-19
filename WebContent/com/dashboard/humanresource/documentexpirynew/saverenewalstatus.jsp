<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();

	String renewaldoc=request.getParameter("doct");
	String renewstatusid=request.getParameter("status");
	String renewstatus=request.getParameter("statuscode");
	String description=request.getParameter("description");
	String docno=request.getParameter("docno");
	String docId=request.getParameter("docId");
	java.sql.Date sqlDate=null;


	int val=0;
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String columnName = "";
	String statusName = "";
	if(renewaldoc.trim().equalsIgnoreCase("VISA")){ 
		columnName = "visarenewid";
		statusName = "Visa Renewal Status ";
	}
	else if (renewaldoc.trim().equalsIgnoreCase("RTA CARD")) {
		columnName="rtarenewid";
		statusName = "RTA Card Renewal Status ";		
	}
	
	String strsql="update hr_empdoc set "+columnName+"="+renewstatusid+" where rdocno ="+docno+" and docId="+docId;
	System.out.println(strsql);
	val= stmt.executeUpdate(strsql);
	if(val>0){
		String strLogSql = "INSERT INTO my_docexpirylog (rdocno,DATE,userid,brchid,description)VALUES("+docno+",now(),'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"', 'Updated "+statusName+" to - "+renewstatus+"')";
		val= stmt.executeUpdate(strLogSql);	
	}
	
	if(val>0){
		 conn.commit();
	}
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