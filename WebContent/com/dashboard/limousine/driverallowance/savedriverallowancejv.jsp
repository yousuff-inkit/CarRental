<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.fasterxml.jackson.databind.JsonNode"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.List"%>
<%@page import="com.fasterxml.jackson.core.type.TypeReference"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsCommon clsCommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn = null;
int errorstatus=0;
try{
	String allowancedata=request.getParameter("allowancedata")==null?"0":request.getParameter("allowancedata").toString();
	String driverid=request.getParameter("driverid")==null?"0":request.getParameter("driverid").toString();
	String driver=request.getParameter("driver")==null?"0":request.getParameter("driver").toString();
	System.out.println(allowancedata+" - "+driverid);
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String allowanceaccount="";
	String allowancecurr="";
	double allowancerate=0;
	String driverAccount="";
	String drivercurr="";
	double driverrate=0;
	ArrayList<String> allowance= new ArrayList<String>();
	
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");     
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date currentDate = clsCommon.changeStringtoSqlDate(formatter.format(curDate));
	
	String getAccount = "SELECT DOC_NO account,curid,rate FROM my_head WHERE description='DRIVER ALLOWANCE EXP'"; 
	System.out.println(getAccount);
	ResultSet rs = stmt.executeQuery(getAccount);
	while(rs.next()){
		allowanceaccount = rs.getString("account");
		allowancecurr = rs.getString("curid");
		allowancerate = rs.getInt("curid");
	}

	String getSalesAccount = "SELECT sal.acc_no account,h.curid,h.rate FROM my_salesman sal LEFT JOIN my_head h ON h.doc_no=sal.acc_no WHERE sal.sal_type='DRV' AND sal.sal_code="+driverid+" AND sal.STATUS=3";
	System.out.println(getSalesAccount);
	ResultSet rss = stmt.executeQuery(getSalesAccount);
	while(rss.next()){
		driverAccount = rss.getString("account");
		drivercurr = rss.getString("curid");
		driverrate = rss.getInt("curid");
	}
	
	double sum=0;
	JSONArray jsonArray = JSONArray.fromObject(allowancedata);
	for (int i = 0; i < jsonArray.size(); i++) {
        JSONObject jsonObject = jsonArray.getJSONObject(i);
       	sum += jsonObject.getDouble("allowance");
    }
	
	allowance.add(allowanceaccount+":: allowance posted to "+driver+" on "+currentDate+"::"+allowancecurr+"::"+allowancerate+"::"+(sum*-1)+"::"+(sum*allowancerate*-1)+"::"+0+"::"+"-1"+"::"+0+"::"+0);
	allowance.add(driverAccount+":: allowance posted to "+driver+" on "+currentDate+"::"+allowancecurr+"::"+allowancerate+"::"+sum+"::"+(sum*allowancerate)+"::"+0+"::"+"1"+"::"+0+"::"+0);
	
	
	ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
	
    int docno=jvt.insert(currentDate, "JVT", "", "allowance posted to "+driver+" on "+currentDate, sum, sum, allowance, session, request);
    
    if(docno<=0) {
    	errorstatus=1;
    }
    
    
    for (int i = 0; i < jsonArray.size(); i++) {
        JSONObject jsonObject = jsonArray.getJSONObject(i);
		String update = "";
        if(jsonObject.get("docname").toString().toLowerCase().startsWith("t")){
	        update = "UPDATE gl_limobooktransfer SET jvno="+docno+" WHERE bookdocno="+jsonObject.get("bookdocno")+" AND docname='"+jsonObject.get("docname")+"'";	
        } else if (jsonObject.get("docname").toString().toLowerCase().startsWith("l")){
	        update = "UPDATE gl_limobookhoursr SET jvno="+docno+" WHERE bookdocno="+jsonObject.get("bookdocno")+" AND docname='"+jsonObject.get("docname")+"'";	
        }
        int resultupdate = stmt.executeUpdate(update);
        
        if(resultupdate<=0){
        	errorstatus=1;
        }
    }
    
    if(errorstatus==0){
    	conn.commit();
    }
	stmt.close();
	response.getWriter().write(errorstatus+"");
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
