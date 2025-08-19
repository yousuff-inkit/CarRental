<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
String brhid = request.getParameter("branch")==null?"0":request.getParameter("branch");
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlPayrollDate=null;
		String sql="";  
		String payrolldate=request.getParameter("payrolldate");
		
	    if(!(payrolldate.equalsIgnoreCase("undefined"))&&!(payrolldate.equalsIgnoreCase(""))&&!(payrolldate.equalsIgnoreCase("0"))){
		     sqlPayrollDate=ClsCommon.changeStringtoSqlDate(payrolldate);
		}
	    if(employeebranchchk.equalsIgnoreCase("1")){    
        	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0")) && !(brhid.equalsIgnoreCase("a"))){  
        		sql=sql+" and brhid='"+brhid+"'";   
        	}
        } 
		String strSql = "select doc_no from hr_payroll where status=3 and MONTH(date)=MONTH('"+sqlPayrollDate+"') and YEAR(date)=YEAR('"+sqlPayrollDate+"')"+sql+"";
		//System.out.println("strSql--->>>"+strSql);  
		ResultSet rs = stmt.executeQuery(strSql);
		
		String docNo="0";
		while(rs.next()) {
			docNo=rs.getString("doc_no");
		} 
		
		response.getWriter().write(docNo);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  