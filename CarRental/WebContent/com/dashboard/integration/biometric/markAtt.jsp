<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	String empid=request.getParameter("empid")==null?"":request.getParameter("empid");
	String checkindate=request.getParameter("checkindate")==null?"":request.getParameter("checkindate");
	String checkintime=request.getParameter("checkintime")==null?"":request.getParameter("checkintime");
	String checkoutdate=request.getParameter("checkoutdate")==null?"":request.getParameter("checkoutdate");
	String checkouttime=request.getParameter("checkouttime")==null?"":request.getParameter("checkouttime");
	String punchdocno=request.getParameter("punchdocno")==null?"":request.getParameter("punchdocno");

	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	//Checking if timesheet has entry corresponding to empid,year,month;
	
	java.sql.Date sqlcheckindate=null;
	java.sql.Date sqlcheckoutdate=null;
	
	if(!checkindate.trim().equalsIgnoreCase("")){
		sqlcheckindate=objcommon.changeStringtoSqlDate(checkindate);
	}
	if(!checkoutdate.trim().equalsIgnoreCase("")){
		sqlcheckoutdate=objcommon.changeStringtoSqlDate(checkoutdate);
	}
	
	String strcheckentry="SELECT srno tsdocno FROM hr_timesheet WHERE empid="+empid+" AND YEAR=YEAR('"+sqlcheckindate+"') AND MONTH=MONTH('"+sqlcheckindate+"')";
	int timesheetdocno=0;
	ResultSet rscheckentry=stmt.executeQuery(strcheckentry);
	while(rscheckentry.next()){
		timesheetdocno=rscheckentry.getInt("tsdocno");
	}
	
	if(timesheetdocno==0){
		//Insert new timesheet entry
		String strinsert="insert into hr_timesheet(empid,year,month,totdays) values("+empid+",YEAR('"+sqlcheckindate+"'),MONTH('"+sqlcheckindate+"'),DAY(LAST_DAY('"+sqlcheckindate+"')))";
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			errorstatus=1;
		}
		
		strcheckentry="SELECT srno tsdocno FROM hr_timesheet WHERE empid="+empid+" AND YEAR=YEAR('"+sqlcheckindate+"') AND MONTH=MONTH('"+sqlcheckindate+"')";
		rscheckentry=stmt.executeQuery(strcheckentry);
		while(rscheckentry.next()){
			timesheetdocno=rscheckentry.getInt("tsdocno");
		}
	}
	
	Calendar checkincal=Calendar.getInstance();
	checkincal.setTime(sqlcheckindate);
	
	int dayOfMonth=checkincal.get(Calendar.DAY_OF_MONTH);
	
	String updatecolumn="date"+dayOfMonth;
	//Updating total time.
	String strupdate="update hr_timesheet set "+updatecolumn+"=TIMESTAMPDIFF(MINUTE, CONCAT('"+sqlcheckindate+"', ' ', '"+checkintime+"'), CONCAT('"+sqlcheckoutdate+"', ' ', '"+checkouttime+"')) where srno="+timesheetdocno;
	System.out.println(strupdate);
	int update=stmt.executeUpdate(strupdate);
	
	String strpunchupdate="update hr_punchatt set attstatus=1 where doc_no="+punchdocno;
	int punchupdate=stmt.executeUpdate(strpunchupdate);
	if(punchupdate<=0){
		errorstatus=1;
	}
	
	if(errorstatus==0){
		conn.commit();
	}
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>