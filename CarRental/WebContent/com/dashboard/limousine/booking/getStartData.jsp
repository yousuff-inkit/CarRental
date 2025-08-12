<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.sayaraInternal.*" %>
<%	
	
Connection conn=null;
String rowno="", startkm="", startdate="", starttime="", bstatus="";
	try{
		ClsConnection  ClsConnection =new ClsConnection();
		 ClsCommon   ClsCommon =new ClsCommon();
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String jobno=request.getParameter("jobno")==""?"0":request.getParameter("jobno").trim();
		
				String sqldid = "SELECT startkm,date_format(startdate,'%d.%m.%Y') startdate,starttime FROM an_starttripdet WHERE jobno ='"+jobno+"'";
				System.out.println(sqldid);
				ResultSet did = stmt.executeQuery(sqldid);
				while(did.next()){
					startkm=did.getString("startkm");
					startdate=did.getString("startdate");
					starttime=did.getString("starttime");
				}
				
				String sqlstart = "select bstatus from gl_limomanagement where CONCAT(docno,'-',job)='"+jobno+"'";
				ResultSet stat = stmt.executeQuery(sqlstart);
				while(stat.next()){
					bstatus = stat.getString("bstatus");
				}
					
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	}
	response.getWriter().write(startkm+"::"+startdate+"::"+starttime+"::"+bstatus);
 	System.out.println("Start KM"+startkm+" "+startdate+"::"+starttime);
	
  %>
  
