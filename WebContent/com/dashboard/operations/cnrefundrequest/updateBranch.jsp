<%@page import="javax.servlet.http.HttpSession" %>
<%	
	String branch = request.getParameter("branch")==null || request.getParameter("branch").equals("")?"0":request.getParameter("branch");     
	session.setAttribute("BRANCHID", branch);  
  %>
  
