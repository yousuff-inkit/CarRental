<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO"%>
<%@page import="com.operations.agreement.leaseagmtformaster.ClsLeaseAgmtForMasterDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONArray clientarray=new JSONArray();
try{
	 String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
	 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
	 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
	 String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
	 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
	 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
	 String masterrefnocldocno=request.getParameter("masterrefnocldocno")==null?"":request.getParameter("masterrefnocldocno");
	 String id = request.getParameter("id")==null?"0":request.getParameter("id");    
	
	 ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
	 clientarray=viewDAO.clientSearch(session, clname, mob, lcno, passno, nation, dob, id);
}
catch(Exception e){
	e.printStackTrace();	
}
response.getWriter().write(clientarray+"");
%>
