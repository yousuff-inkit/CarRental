<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%	
String sessionbrch=session.getAttribute("BRANCHID").toString();
if(sessionbrch.equals("a")){
	sessionbrch="1";
	session.setAttribute("BRANCHID",sessionbrch);
}

  %>
  