<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();

	String visastatusid=request.getParameter("status");
	String visastatus=request.getParameter("statuscode");
	String description=request.getParameter("description");
	String docno=request.getParameter("docno");


	int val=0;
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update hr_candidatem set visastatusid="+visastatusid+" where doc_no ="+docno;
	System.out.println(strsql);
	val= stmt.executeUpdate(strsql);
	if(val>0){
		String strLogSql = "INSERT INTO my_cdmbilog (rdocno,DATE,userid,brchid,description)VALUES("+docno+",now(),'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"', 'Updated Visa Status to - "+visastatus+"')";
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
