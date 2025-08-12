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
<%@page import="com.dashboard.humanresource.timesheetreviewaccess.ClsTimeSheetReviewDAO"%>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsTimeSheetReviewDAO DAO=new ClsTimeSheetReviewDAO();

	Connection conn = null;

	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement();
		 Statement stmt1 = conn.createStatement();
		
		 String year=request.getParameter("year");
		 String month=request.getParameter("month");
	   	 String mode=request.getParameter("mode");
	
		 int val=0;
	
		 if(mode.equalsIgnoreCase("A")) {
			 
			 /*Add */
			 
			    ArrayList<String> weeklyoffarray=new ArrayList<String>();
		        ArrayList<String> employeearray=new ArrayList<String>();
		        
		             
	    	    String sql1="",date="",empid="0",rowno="",normalhrs="",intime="",outtime="";
	    	    String[] weekoffs=null;
	    	    
	    	    String sql = "select date,empid,rowno,normalhrs,intime,outtime from hr_timesheethrs where month(date)='"+month+"' and year(date)='"+year+"'  ";
	    //	   System.out.println("sssql=============="+sql);
	    	    ResultSet resultSet = stmt.executeQuery(sql);
	    	    
	    	    while(resultSet.next()){
	    	    	date=resultSet.getString("date");
	    	    	empid=resultSet.getString("empid");
	    	    	normalhrs=resultSet.getString("normalhrs");
	    	    	intime=resultSet.getString("intime");
	    	    	outtime=resultSet.getString("outtime");
	    	    	rowno=resultSet.getString("rowno");
       		val=	 DAO.setval(date,empid,rowno,normalhrs,intime,outtime);

	    	    }
	    	    
		 }
		 	//System.out.println("val----"+val);			
		response.getWriter().print(val);

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
