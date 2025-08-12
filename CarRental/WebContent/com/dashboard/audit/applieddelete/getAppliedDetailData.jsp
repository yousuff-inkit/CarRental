<%@page import="com.dashboard.audit.applieddelete.ClsAppliedDeleteDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%	
	String trno = request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
	String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();
	
	try{
		 ClsAppliedDeleteDAO dao = new ClsAppliedDeleteDAO();
		 JSONArray appliedArray = new JSONArray();
		 
		 JSONObject paramJson = new JSONObject();
	        paramJson.put("trno", trno);
	        paramJson.put("check", check);
	        paramJson.put("accountno", accountno);
		 
		 appliedArray = dao.applyInvoiceDeleteGridLoading(paramJson);  
		 
		 System.out.println("applieddetailArray :"+appliedArray);
	     
		 response.getWriter().print(appliedArray);

	}catch(Exception e){
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  
	 	e.printStackTrace();
   } 
%>
