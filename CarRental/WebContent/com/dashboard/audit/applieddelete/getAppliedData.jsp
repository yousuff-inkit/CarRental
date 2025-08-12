<%@page import="com.dashboard.audit.applieddelete.ClsAppliedDeleteDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%	
	String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
	String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();
	
	try{
		 ClsAppliedDeleteDAO dao = new ClsAppliedDeleteDAO();
		 JSONArray appliedArray = new JSONArray();
		 
		 JSONObject paramJson = new JSONObject();
	        paramJson.put("branch", branch);
	        paramJson.put("atype", atype);
	        paramJson.put("check", check);
	        paramJson.put("accountno", accountno);
		 
		 appliedArray = dao.appliedGridLoading(paramJson);
		 
		 System.out.println("appliedArray :"+appliedArray);
	     
		 response.getWriter().print(appliedArray);

	}catch(Exception e){
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  
	 	e.printStackTrace();
   } 
%>
