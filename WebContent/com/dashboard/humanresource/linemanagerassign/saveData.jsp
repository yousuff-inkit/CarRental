
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
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;

try{

	   String trnarray = request.getParameter("ra_no")==null || request.getParameter("ra_no").trim().equals("")?"0":request.getParameter("ra_no").trim().toString();
	   String salesman_docno=request.getParameter("salesman_txt")==null || request.getParameter("salesman_txt").trim().equals("")?"0":request.getParameter("salesman_txt").trim().toString();
		
	   //System.out.println("--------trnarray----------"+trnarray);  

java.sql.Date sqlprocessdate=null;



	 String upsql=null;

	 int j=0,val=0;
	 int docval=0;
	 

	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String temp[] = trnarray.split(",");   
	for(j=0;j<temp.length;j++){       
		   
	    upsql="update  hr_empm  set linemanager='"+salesman_docno+"' where doc_no= '"+temp[j]+"'  ";
		   //System.out.println("----upsql-1--"+upsql);
		     val= stmt.executeUpdate(upsql);
		    		  } 
	   
	  
		 				
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
