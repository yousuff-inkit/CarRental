<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.util.Date" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO = new ClsCommon();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		java.sql.Date sqlStartDate=null;
		java.sql.Date sqlEndDate=null;

		String frequency=request.getParameter("frequency");
		String installno=request.getParameter("installno")==null || (request.getParameter("installno")).equalsIgnoreCase("")?"0":request.getParameter("installno");
		String startdate=request.getParameter("startdate");
		String instalchk=request.getParameter("instalchk")==null || (request.getParameter("instalchk")).equalsIgnoreCase("")?"0":request.getParameter("instalchk");
       
		sqlStartDate =(startdate.equalsIgnoreCase("undefined") || startdate.equalsIgnoreCase("NaN") || startdate.equalsIgnoreCase("") || startdate.equalsIgnoreCase("0") ||  startdate.isEmpty()?null:commonDAO.changeStringtoSqlDate(startdate));

		if(frequency.equalsIgnoreCase("2")){
        	frequency="MONTH";
        } else if(frequency.equalsIgnoreCase("3")){
        	frequency="YEAR";
        } else {
        	frequency="DAY";
        }
        
        //change enddate using instnos
        String givenDateStr = sqlStartDate+"";
        LocalDate givenDate = LocalDate.parse(givenDateStr);
        LocalDate calculatedDate = givenDate.plusMonths(Long.parseLong(installno));
        LocalDate finalDate = calculatedDate.minusDays(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String finalDateStr = finalDate.format(formatter);
        
        //System.out.println("Final Date: " + finalDateStr);


        if(instalchk.equalsIgnoreCase("1")){
        	
        	String strSql = "SELECT '"+finalDateStr+"' installenddate";
            ResultSet rs = stmt.executeQuery(strSql);
     		//System.out.println("strSql enddate in else---------"+strSql);
     		while(rs.next()) {
     			sqlEndDate=rs.getDate("installenddate");
     		} 
     	
        }
        
        /* else{ 
		String strSql = "SELECT DATE_ADD(coalesce('"+sqlStartDate+"',null),INTERVAL if("+installno+"=0,0,("+installno+"-1)) "+frequency+") installenddate";
		System.out.println("strSql---------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			sqlEndDate=rs.getDate("installenddate");
		} 
         
        
        }  */
		response.getWriter().print(sqlEndDate);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  