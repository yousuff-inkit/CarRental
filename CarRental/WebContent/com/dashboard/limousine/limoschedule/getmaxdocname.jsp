<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();  
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	String bookdocno = request.getParameter("bookdocno");
	String type = request.getParameter("type");
    Statement stmt=conn.createStatement();
    String sqlget = "";
	if(Integer.parseInt(type)==1){
	    sqlget = "SELECT COALESCE(MAX(CAST(SUBSTRING(docname, 2) AS UNSIGNED)),0)+ 1 docname FROM gl_limobooktransfer WHERE bookdocno="+bookdocno+"";
	} else if (Integer.parseInt(type)==2){
    	sqlget = "SELECT COALESCE(MAX(CAST(SUBSTRING(docname, 2) AS UNSIGNED)),0)+ 1 docname FROM gl_limobookhours WHERE bookdocno="+bookdocno+"";
	}
    System.out.println(sqlget);
    ResultSet rs = stmt.executeQuery(sqlget);
	String maxval = "0"; 
    if(rs.next()){
    	maxval=rs.getString("docname");  
    }
    		
 
	response.getWriter().print(maxval);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>