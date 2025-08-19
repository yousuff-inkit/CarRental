<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
	ClsConnection ClsConnection = new ClsConnection();

	String description = request.getParameter("description")==null?"":request.getParameter("description");
	String type = request.getParameter("type")==null?"":request.getParameter("type");
	String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno");
	String agmtdocno = request.getParameter("agmtdocno")==null || request.getParameter("agmtdocno").equals("")?"0":request.getParameter("agmtdocno");
	String amount = request.getParameter("amount")==null || request.getParameter("amount").equals("")?"0":request.getParameter("amount");
	String agmtType = request.getParameter("agmtType")==null?"":request.getParameter("agmtType");   
	String userid = session.getAttribute("USERID").toString(); 
	String process = request.getParameter("process")==null?"":request.getParameter("process");   
	String docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"":request.getParameter("docno");  
	String refno = request.getParameter("refno")==null || request.getParameter("refno").equals("")?"0":request.getParameter("refno");   
	String status = request.getParameter("status")==null || request.getParameter("status").equals("")?"0":request.getParameter("status");   
	String hidsalesman = request.getParameter("hidsalesman")==null || request.getParameter("hidsalesman").equals("")?"0":request.getParameter("hidsalesman");  
	String closedate = request.getParameter("closedate");
	closedate = (closedate == null || closedate.trim().isEmpty()) ? null : closedate;
	Connection conn = null;  
 	int val = 0;
 	try{
 		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		if(process.equalsIgnoreCase("Request")){
		if(closedate!=null){
			String strSql = "INSERT INTO gl_cnrefundreq(entrydate, cldocno, agmttype, agmtdocno, type, amount, description, userid,salid,closedate) VALUES(now(), '"+cldocno+"', '"+agmtType+"', '"+agmtdocno+"', '"+type+"', '"+amount+"', '"+description+"', '"+userid+"', '"+hidsalesman+"', '"+closedate+"')";
			val = stmt.executeUpdate(strSql); 
		}else{
			String strSql = "INSERT INTO gl_cnrefundreq(entrydate, cldocno, agmttype, agmtdocno, type, amount, description, userid,salid) VALUES(now(), '"+cldocno+"', '"+agmtType+"', '"+agmtdocno+"', '"+type+"', '"+amount+"', '"+description+"', '"+userid+"', '"+hidsalesman+"')";
			val = stmt.executeUpdate(strSql); 
		}
			 
		}else if(process.equalsIgnoreCase("Approve")){
			String strSql = "UPDATE gl_cnrefundreq SET status = '"+status+"', apprrefno = '"+refno+"', apprremarks = '"+description+"', appruserid = '"+userid+"', apprdate=now() WHERE doc_no='"+docno+"'";
			val = stmt.executeUpdate(strSql);   
		}else if(process.equalsIgnoreCase("GM")){
			String strSql = "UPDATE gl_cnrefundreq SET gmapproval = 1, gmapproveduser = '"+userid+"', gmapproveddate = now() WHERE doc_no='"+docno+"'";
			val = stmt.executeUpdate(strSql);  
		}else if(process.equalsIgnoreCase("FINAL")){
			String strSql = "UPDATE gl_cnrefundreq SET finalapproval = 1, finalapproveduser = '"+userid+"', finalapproveddate = now() WHERE doc_no='"+docno+"'";
			val = stmt.executeUpdate(strSql);     
		}else{}

		response.getWriter().print(val);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
	%>