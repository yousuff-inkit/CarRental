<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
String brhid = request.getParameter("branch")==null?"0":request.getParameter("branch");
	try{
		
		ClsConnection connDAO=new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		java.sql.Date sqlPayrollPostDate=null;
	    String message = "",sqltst="";
	    if(employeebranchchk.equalsIgnoreCase("1")){    
        	if(!(brhid.equalsIgnoreCase("")) && !(brhid.equalsIgnoreCase("0")) && !(brhid.equalsIgnoreCase("a"))){  
        		sqltst=sqltst+" and brhid='"+brhid+"'";     
        	}
        }
	    /* Date to be Posted*/
	    String sql = "select LAST_DAY(DATE_ADD(min(d.date),INTERVAL 1 DAY)) tobepostdate,Coalesce(CONCAT('Done till ',DATE_FORMAT(min(d.date),'%b %Y')),'') message from hr_payrolld d left join hr_payroll m on m.doc_no=d.rdocno where d.posted=0 and m.status=3 "+sqltst+"";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			sqlPayrollPostDate= rs.getDate("tobepostdate");
			message= rs.getString("message");
		} 
		/* Date to be Posted Ends*/
		
		response.getWriter().write(sqlPayrollPostDate+"***"+message);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  