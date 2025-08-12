<%@page import="com.dashboard.operations.invoiceauditing.ClsInvoiceAuditingDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.operations.commtransactions.invoice.ClsManualInvoiceDAO"%>
<%@page import="com.finance.transactions.creditnote.ClsCreditNoteDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	String agmtdocno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
	String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
	String creditamt=request.getParameter("creditamt")==null?"":request.getParameter("creditamt");
	String invoiceamt=request.getParameter("invoiceamt")==null?"":request.getParameter("invoiceamt");
	String strinvoicearray=request.getParameter("strinvoicearray")==null?"":request.getParameter("strinvoicearray");
	String strcreditarray=request.getParameter("strcreditarray")==null?"":request.getParameter("strcreditarray");
	String creditdesc=request.getParameter("creditdesc")==null?"":request.getParameter("creditdesc");
	String invoicedesc=request.getParameter("invoicedesc")==null?"":request.getParameter("invoicedesc");
	String oldinvtrno=request.getParameter("oldinvtrno")==null?"":request.getParameter("oldinvtrno");

	ClsCreditNoteDAO creditdao=new ClsCreditNoteDAO();
	ClsManualInvoiceDAO invoicedao=new ClsManualInvoiceDAO();
	ClsInvoiceAuditingDAO auditdao=new ClsInvoiceAuditingDAO();
	
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	if(userid.equalsIgnoreCase("")){
		errorstatus=1;
		objdata.put("errorstatus",errorstatus);
		response.getWriter().write(objdata+"");
	}
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Passing creditnote of existing invoice amount
	String stragmtdetails="";
	if(agmttype.equalsIgnoreCase("RAG")){
		stragmtdetails="select agmt.brhid,m.fleet_no,agmt.cldocno,ac.acno,agmt.voc_no from gl_ragmtclosem m left join gl_ragmt agmt on m.agmtno=agmt.doc_no left join my_acbook ac on agmt.cldocno=ac.cldocno and ac.dtype='CRM' where agmt.doc_no="+agmtdocno;
	}
	else if(agmttype.equalsIgnoreCase("LAG")){
		stragmtdetails="select agmt.brhid,m.fleet_no,agmt.cldocno,ac.acno,agmt.voc_no from gl_lagmtclosem m left join gl_lagmt agmt on m.agmtno=agmt.doc_no left join my_acbook ac on agmt.cldocno=ac.cldocno and ac.dtype='CRM' where agmt.doc_no="+agmtdocno;
	}
	System.out.println(stragmtdetails);
	ResultSet rsagmtdetails=stmt.executeQuery(stragmtdetails);
	int clientacno=0,cldocno=0,agmtbrhid=0;
	String agmtvocno="",fleetno="";
	while(rsagmtdetails.next()){
		clientacno=rsagmtdetails.getInt("acno");
		agmtvocno=rsagmtdetails.getString("voc_no");
		fleetno=rsagmtdetails.getString("fleet_no");
		cldocno=rsagmtdetails.getInt("cldocno");
		agmtbrhid=rsagmtdetails.getInt("brhid");
	}
	String strmisc="select CURDATE() basedate";
	java.sql.Date sqlbasedate=null;
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		sqlbasedate=rsmisc.getDate("basedate");
	}
	
	ResultSet rsclientrate=stmt.executeQuery("select curid,rate from my_head where doc_no="+clientacno);
	int clientcurid=0;
	double clientcurrate=0.0;
	if(rsclientrate.next()){
		clientcurid=rsclientrate.getInt("curid");
		clientcurrate=rsclientrate.getDouble("rate");
	}
	if(creditdesc.trim().equalsIgnoreCase("")){
		creditdesc="CNO passed for Invoice Auditing of "+agmttype+" #"+agmtvocno;
	}
	if(invoicedesc.trim().equalsIgnoreCase("")){
		invoicedesc="INV passed for Invoice Auditing of "+agmttype+" #"+agmtvocno;
	}
	
	ArrayList<String> creditarray=new ArrayList();
	
	for(int i=0;i<strcreditarray.split(",").length;i++){
		String detacno=strcreditarray.split(",")[i].split("::")[0];
		String detamt=strcreditarray.split(",")[i].split("::")[1];
		String detunits=strcreditarray.split(",")[i].split("::")[2];
		double detbaseamt=Double.parseDouble(detamt.trim())*clientcurrate;
		creditarray.add(detacno+"::"+clientcurid+"::"+clientcurrate+"::"+true+"::"+detamt+"::"+creditdesc+"::"+detbaseamt+"::"+6+"::"+fleetno);
	}
	if(Double.parseDouble(creditamt)>0.0){
		//Calculating & Passing VAT amount
		double creditvatamt=Double.parseDouble(auditdao.getCreditVatAmt(conn,strcreditarray,cldocno,sqlbasedate).split("::")[0]);
		int creditvatacno=Integer.parseInt(auditdao.getCreditVatAmt(conn,strcreditarray,cldocno,sqlbasedate).split("::")[1]);
		creditarray.add(creditvatacno+"::"+clientcurid+"::"+clientcurrate+"::"+true+"::"+creditvatamt+"::"+creditdesc+"::"+creditvatamt*clientcurrate+"::"+6+"::"+fleetno);
		creditamt=(Double.parseDouble(creditamt)+creditvatamt)+"";
	}
	
	int creditvalue=creditdao.insert(conn, sqlbasedate, "CNO", agmtdocno, clientcurrate, creditdesc, clientacno, clientcurid+"", Double.parseDouble(creditamt), Double.parseDouble(creditamt), agmttype, Integer.parseInt(agmtdocno), creditarray, session, request, "A");
	int credittrno=Integer.parseInt(request.getAttribute("tranno")==null?"0":request.getAttribute("tranno").toString());
	if(creditvalue<=0){
		System.out.println("Credit Note Insert Error");
		errorstatus=1;
	}
	
	ArrayList<String> invoicearray=new ArrayList();
	for(int i=0;i<strinvoicearray.split(",").length;i++){
		String detacno=strinvoicearray.split(",")[i].split("::")[0];
		String detamt=strinvoicearray.split(",")[i].split("::")[1];
		String detunits=strinvoicearray.split(",")[i].split("::")[2];
		String detidno=strinvoicearray.split(",")[i].split("::")[3];
		String detdesc=strinvoicearray.split(",")[i].split("::")[4];

		System.out.println(detidno+"::"+detacno+"::"+detdesc+"::"+detunits+"::"+detamt+"::"+detamt);
		invoicearray.add(detidno+"::"+detacno+"::"+detdesc+"::"+detunits+"::"+detamt+"::"+detamt);
	}

	int invoicevalue=invoicedao.insert(conn, invoicearray, agmttype, sqlbasedate, cldocno+"", Integer.parseInt(agmtdocno), invoicedesc, invoicedesc, sqlbasedate, sqlbasedate, agmtbrhid+"", userid, clientcurid+"", "A", clientacno+"", "INV###14", "INV","");
	if(invoicevalue<=0){
		System.out.println("Invoice Insert Error");
		errorstatus=1;
	}
	
	int invoicetrno=0;
	String strgetvoc="select voc_no,tr_no from gl_invm where doc_no="+invoicevalue;
	ResultSet rsgetvoc=stmt.executeQuery(strgetvoc);
	String invvocno="";
	while(rsgetvoc.next()){
		invvocno=rsgetvoc.getString("voc_no");
		invoicetrno=rsgetvoc.getInt("tr_no");
	}
	
	//Log Entries
	
	String strinsertlog="insert into gl_invauditlog(agmtdocno,agmttype,oldinvtrno,auditcnotrno,auditinvtrno,userid,brhid,entrytime) values("+agmtdocno+",'"+agmttype+"',"+oldinvtrno+","+credittrno+","+invoicetrno+","+userid+","+agmtbrhid+",now())";
	int insertlog=stmt.executeUpdate(strinsertlog);
	if(insertlog<=0){
		errorstatus=1;
		System.out.println("Log Insert Error");
	}
	
	String strauditupdate="";
	if(agmttype.trim().equalsIgnoreCase("RAG")){
		strauditupdate="update gl_ragmtclosem set invaudit=1 where agmtno="+agmtdocno;
	}
	else if(agmttype.trim().equalsIgnoreCase("LAG")){
		strauditupdate="update gl_lagmtclosem set invaudit=1 where agmtno="+agmtdocno;
	}
	if(!strauditupdate.equalsIgnoreCase("")){
		int auditupdate=stmt.executeUpdate(strauditupdate);
		if(auditupdate<=0){
			errorstatus=1;
			System.out.println("Audit Update Error");
		}
	}
	
	//update calcstatus=2 -> lcalc or rcalc
	String strupdatecalc="";
	for(int i=0;i<strinvoicearray.split(",").length;i++){
		String detidno=strinvoicearray.split(",")[i].split("::")[3];
		if(agmttype.trim().equalsIgnoreCase("RAG")){
			strupdatecalc="update gl_rcalc set calcstatus=2 where trno="+oldinvtrno+" and idno="+detidno;	
		}
		else if(agmttype.trim().equalsIgnoreCase("LAG")){
			strupdatecalc="update gl_lcalc set calcstatus=2 where trno="+oldinvtrno+" and idno="+detidno;
		}
		int updatecalc=stmt.executeUpdate(strupdatecalc);
		if(updatecalc<=0){
			errorstatus=1;
			System.out.println("Update calc Error");
		}
		
		if(agmttype.trim().equalsIgnoreCase("RAG")){
			strupdatecalc="update gl_rcalc set calcstatus=1 where trno="+invoicetrno+" and idno="+detidno;	
		}
		else if(agmttype.trim().equalsIgnoreCase("LAG")){
			strupdatecalc="update gl_lcalc set calcstatus=1 where trno="+invoicetrno+" and idno="+detidno;
		}
		int updatecalcnew=stmt.executeUpdate(strupdatecalc);
		if(updatecalcnew<=0){
			errorstatus=1;
			System.out.println("Update New calc Error");
		}
	}
	
	
	objdata.put("CNOvoucher",creditvalue);
	objdata.put("INVvoucher",invvocno);
	if(errorstatus==0){
		conn.commit();
	}
	
}
catch(Exception e){
	e.printStackTrace();
	System.out.println("Exception Error");
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>