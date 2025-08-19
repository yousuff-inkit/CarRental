<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="com.dashboard.accounts.journalvoucherlist.ClsJournalVoucherListDAO"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
	String date=request.getParameter("date");
	String total=request.getParameter("total");
	String updocno=request.getParameter("docno");
	String result="0";
	
	BufferedReader reader = request.getReader();
	StringBuilder jsonBody = new StringBuilder();
	String line;
	while ((line = reader.readLine()) != null) {
		jsonBody.append(line);
	}
	String jsonString = jsonBody.toString();
	int res=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon common = new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	   Date currentDate = new Date();
	    
	    // Format the date using SimpleDateFormat
	    SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
	    String formattedDate = dateFormat.format(currentDate);
	
		java.sql.Date sqldate=null;
		java.sql.Date sqldatecurrent=null;
		String lasttime="";
		int status=0;
		double lastkm=0.0,lastfuel=0.0;
		if(!date.equalsIgnoreCase("")){
			sqldate=common.changeStringtoSqlDate(date);
			sqldatecurrent= common.changeStringtoSqlDate(formattedDate);
		}
		
	int sacacno = 0; 	
	int saccurid = 0; 	
	double sacrate = 0; 
	int sacpacno = 0; 	
	int sacpcurid = 0; 	
	double sacprate = 0;
		
	String getSalaryAccSql = "SELECT doc_no,curid,rate FROM my_head WHERE description='SALARIES ACCOUNT'";	
	ResultSet rsgac = stmt.executeQuery(getSalaryAccSql);
	if(rsgac.next()){
		sacacno = rsgac.getInt("doc_no");
		saccurid = rsgac.getInt("curid");
		sacrate =  rsgac.getDouble("rate");
	}
	
	
	String getSalaryPayableAccSql = "SELECT doc_no,curid,rate FROM my_head WHERE description='SALARY PAYABLES ACCOUNT'";	
	ResultSet rsgacp = stmt.executeQuery(getSalaryPayableAccSql);
	if(rsgacp.next()){
		sacpacno = rsgacp.getInt("doc_no");
		sacpcurid = rsgacp.getInt("curid");
		sacprate =  rsgacp.getDouble("rate");
	}	
	
	
	
	 JSONArray jsonArray = JSONArray.fromObject(jsonString);
	 ArrayList<String> parsedArray = new ArrayList<String>();
     for (int i = 0; i < jsonArray.size(); i++) {
    	 JSONObject obj = jsonArray.getJSONObject(i);
         
    	 int sfactor = 1;
    	 if(Double.parseDouble(obj.getString("salaries"))<0){
    		 sfactor=-1;
    	 }
    	 
    	 String rideraccount="";
    	 String getacno = "SELECT coalesce(account,'') account FROM my_head WHERE doc_no="+obj.getString("acno");
    	 ResultSet rsgetacno = stmt.executeQuery(getacno);
    	 if(rsgetacno.next()){
    		 rideraccount =" - "+rsgetacno.getString("account");
    	 }
    	 
    	 parsedArray.add(sacacno+"::"+"Rider Payroll for the date - "+sqldate+rideraccount+"::"+sacpcurid+"::"+sacprate+"::"+Double.parseDouble(obj.getString("salaries"))*1+"::"+Double.parseDouble(obj.getString("salaries"))*1*sacprate+"::"+"0"+"::"+sfactor+"::"+"0"+"::"+"JVT");
    	 
    	 if(Double.parseDouble(obj.getString("netsalary"))<0){
    		 parsedArray.add(obj.getString("acno")+"::"+"Rider Negative Payroll Payable for the date - "+sqldate+"::"+saccurid+"::"+sacrate+"::"+Double.parseDouble(obj.getString("netsalary"))*-1+"::"+Double.parseDouble(obj.getString("netsalary"))*-1*sacrate+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"JVT");
    	 } else {
    		 // added this condition to avoid insertion of 0 value entry in jvtran 
    		 if(Double.parseDouble(obj.getString("netsalary"))!=0) parsedArray.add(sacpacno+"::"+"Rider Payroll Payable for the date - "+sqldate+rideraccount+"::"+saccurid+"::"+sacrate+"::"+Double.parseDouble(obj.getString("netsalary"))*-1+"::"+Double.parseDouble(obj.getString("netsalary"))*-1*sacrate+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"JVT");
    	 }
    	 
    	 double totalded = Double.parseDouble(obj.getString("fine"))+Double.parseDouble(obj.getString("salik"))+Double.parseDouble(obj.getString("extrasimused"))+Double.parseDouble(obj.getString("insurance"))+Double.parseDouble(obj.getString("advance"))+Double.parseDouble(obj.getString("nsalary"))+Double.parseDouble(obj.getString("rtaclass"))+Double.parseDouble(obj.getString("labourcard"))+Double.parseDouble(obj.getString("fineperformance")+Double.parseDouble(obj.getString("llogns")));
		 
    	 	// added this condition to avoid insertion of 0 value entry in jvtran 
    	 if(totalded!=0)parsedArray.add(obj.getString("acno")+"::"+"Rider Deduction from Payroll for the date - "+sqldate+"::"+obj.getString("curid")+"::"+obj.getString("rate")+"::"+totalded*-1+"::"+totalded*-1*obj.optDouble("rate")+"::"+"0"+"::"+"-1"+"::"+"0"+"::"+"JVT");
    	
    	 int factor = Double.parseDouble(obj.getString("adjustments"))<0?-1:1;
    	if(Double.parseDouble(obj.getString("adjustments"))!=0){
    	 parsedArray.add(obj.getString("acno")+"::"+"Rider Payroll Adjustments for the date - "+sqldate+"::"+obj.getString("curid")+"::"+obj.getString("rate")+"::"+Double.parseDouble(obj.getString("adjustments"))*factor+"::"+Double.parseDouble(obj.getString("adjustments"))*factor*obj.optDouble("rate")+"::"+"0"+"::"+factor+"::"+"0"+"::"+"JVT");
    	}
    	 
    	 
    	 
    	 
    //	 parsedArray.add(jsonArray.getString(i));
     }

   //  String getaccount= "SELECT doc_no,curid,rate FROM my_head WHERE description='RIDER PAYROLL'";
   //  ResultSet rs = stmt.executeQuery(getaccount);
   //  if(rs.next()){
   // 	 parsedArray.add(rs.getString("doc_no")+"::"+"Rider Payroll of date - "+sqldate+"::"+rs.getString("curid")+"::"+rs.getString("rate")+"::"+Double.parseDouble(total)*1+"::"+Double.parseDouble(total)*rs.getDouble("rate")+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"JVT");
   //  }
     // Print each element
     ClsJournalVouchersDAO clsJournalVouchersDAO= new ClsJournalVouchersDAO();
     res = clsJournalVouchersDAO.insert(sqldate,"JVT".concat("-23"), "BMPP", "Payroll posted for date - "+sqldate+" as JVT on "+sqldatecurrent, Double.parseDouble(total) , Double.parseDouble(total) , parsedArray, session, request);
	 if(res>0){
		 String update = "update my_rip set ispayroll="+res+" where doc_no in ("+updocno.substring(0, updocno.length() - 1)+")";
		 stmt.executeUpdate(update);
		 
		 /* for (int i = 0; i < jsonArray.size(); i++) {
		    	JSONObject obj = jsonArray.getJSONObject(i);
		    	System.out.println(obj.getString("doc_no"));    
		    	
		    	 String updateSalikFine  = "update my_rip set salik="+Double.parseDouble(obj.getString("salik"))+", fine="+Double.parseDouble(obj.getString("fine"))+" where doc_no ="+obj.getString("doc_no");
				 System.out.println(updateSalikFine);
		    	 stmt.executeUpdate(updateSalikFine);
		  } */
	 }
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(res+"");
%>