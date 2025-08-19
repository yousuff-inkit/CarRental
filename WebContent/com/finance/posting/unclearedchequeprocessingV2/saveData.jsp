<%@page import="com.finance.posting.unclearedchequeprocessing.ClsUnclearedChequeProcessingDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String dtype=request.getParameter("dtype")==null?"":request.getParameter("dtype");
	String chequeno=request.getParameter("chequeno")==null?"":request.getParameter("chequeno");
	String chequedate=request.getParameter("chequedate")==null?"":request.getParameter("chequedate");
	String chequename=request.getParameter("chequename")==null?"":request.getParameter("chequename");
	String pdc=request.getParameter("pdc")==null?"":request.getParameter("pdc");
	String rate=request.getParameter("rate")==null?"":request.getParameter("rate");
	String griddtype=request.getParameter("griddtype")==null?"":request.getParameter("griddtype");
	String postingdate=request.getParameter("postingdate")==null?"":request.getParameter("postingdate");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String dealnodesc=request.getParameter("dealnodesc")==null?"":request.getParameter("dealnodesc");
	System.out.println("Parameters:"+docno+"::"+dtype+"::"+chequeno+"::"+chequedate+"::"+chequename+"::"+pdc+"::"+rate+"::"+griddtype+"::"+postingdate+"::"+brhid);
	
	ClsUnclearedChequeProcessingDAO dao=new ClsUnclearedChequeProcessingDAO();
	int val=dao.simplifyEMI(docno,dtype,chequeno,chequedate,chequename,pdc,rate,griddtype,postingdate,brhid,session,request,dealnodesc);
	if(val<=0){
		errorstatus=1;
	}

	objdata.put("errorstatus",errorstatus);
	objdata.put("transno",val);
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	objdata.put("errorstatus",errorstatus);
}
response.getWriter().write(objdata+"");
%>