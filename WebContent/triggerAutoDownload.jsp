<%@page import="com.NewSatAutoDownload.SATdownloadWithoutCaptchaAction"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	session.removeAttribute("SALIKDOCNO");
	session.removeAttribute("TRAFFICDOCNO");
	session.removeAttribute("CURDOWNLOAD");
	session.setAttribute("AUTOSALIKTYPE", "1");
	SATdownloadWithoutCaptchaAction satdao=new SATdownloadWithoutCaptchaAction();
	satdao.run();
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>