<%@page import="com.dashboard.invoices.invoicetodispatch.ClsInvoiceDispatchDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%
JSONArray data=new JSONArray();
try{
	ClsInvoiceDispatchDAO dao=new ClsInvoiceDispatchDAO();
	data=dao.clientDetailsSearch();
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(data+"");
%>