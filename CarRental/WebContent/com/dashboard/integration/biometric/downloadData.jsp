
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.dashboard.integration.biometric.ClsBiometricDAO"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%
	Connection conn=null;
	String responseBody="";
	JSONObject objdata=new JSONObject();
	int errorstatus=0;
	try{
		String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
		String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
	
		ClsBiometricDAO dao=new ClsBiometricDAO();
		String apiusername="sa";
		String apipassword="123456";
		String apifromdate=fromdate.replace(".", "");
		String apitodate=todate.replace(".", "");
		String apiUrl="http://alsaeedidip.dyndns.org:8081/COSEC/api.svc/v2/template-data?action=get;id=105;date-range="+apifromdate+"-"+apitodate;
			
        responseBody=dao.downloadBiometricData(apiusername, apipassword, apiUrl, conn,fromdate,todate);    
        
        
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