<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.dashboard.humanresource.timesheetreviewaccess.ClsTimeSheetReviewDAO" %>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsTimeSheetReviewDAO DAO=new ClsTimeSheetReviewDAO();


	Connection conn = null;

	try{
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement();
		 Statement stmt1 = conn.createStatement();
		
		 String year=request.getParameter("year");
		 String month=request.getParameter("month");
	   	 String mode=request.getParameter("mode");
	
	   	 int premonth=Integer.parseInt(month)-1;
	   	 
		 int val=0;
		 int pflag=0;
		 int val1=0,val2=0,errorstatus=0;
		 
		 if(mode.equalsIgnoreCase("A")) {
			 
				
				ClsHRDashboardDAO hrdao=new ClsHRDashboardDAO();
				hrdao.getInitData(year,month);
 	
		
   }

				
		 
		 System.out.println(errorstatus);
		 if(errorstatus==2 || errorstatus==0){
			 conn.commit();
		 }
		response.getWriter().print(errorstatus);

		stmt1.close();
	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
