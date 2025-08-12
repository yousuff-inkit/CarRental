<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();

	String rtastatusid=request.getParameter("status");
	String rtastatus=request.getParameter("statuscode");
	String description=request.getParameter("description");
	String docno=request.getParameter("docno");
	String isrtaavail=request.getParameter("isrtaavail");
	java.sql.Date sqlDate=null;

	System.out.println(session.getAttribute("USERID").toString());
	int val=0;
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update hr_empm set rtastatusid="+rtastatusid+",isrtaavail="+isrtaavail+" where doc_no ="+docno;
	System.out.println(strsql);
	val= stmt.executeUpdate(strsql);
	if(val>0){
		String strLogSql = "INSERT INTO my_cdmbilog (rdocno,DATE,userid,brchid,description)VALUES("+docno+",now(),'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"', 'Updated RTA Status to - "+rtastatus+"')";
		System.out.println(strLogSql);
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
