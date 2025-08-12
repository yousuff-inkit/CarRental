<%@page import="com.dashboard.accounts.posting.ClsPostingDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
JSONArray data=new JSONArray();
String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval");
String fromDate = request.getParameter("fromDate")==null?"0":request.getParameter("fromDate");
String toDate = request.getParameter("toDate")==null?"0":request.getParameter("toDate");
String payType = request.getParameter("payType")==null?"0":request.getParameter("payType");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
String type = request.getParameter("type")==null?"":request.getParameter("type");

String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
//System.out.println("type------------"+type);

try{
	
	ClsPostingDAO dao=new ClsPostingDAO();
	if(type.equalsIgnoreCase("postingcash")){
	 	data=dao.postingGridLoading(branchval,fromDate,toDate,payType,check);	
	 }
	else if(type.equalsIgnoreCase("postingcard")){
		data=dao.postingGridLoading(branchval,fromDate,toDate,payType,check);
	}
	else if(type.equalsIgnoreCase("postingcheque")){
		data=dao.postingGridLoading(branchval,fromDate,toDate,payType,check);
	}else if(type.equalsIgnoreCase("postingrefund")){
		data=dao.postingGridLoading(branchval,fromDate,toDate,payType,check);
	}else if(type.equalsIgnoreCase("accountsdetailsearch")){
		data=dao.accountsDetails(session, accountno, accountname,date, check);
	}
	
	
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(data+"");
%>