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
String agmtype = (request.getParameter("agmtype") == null || request.getParameter("agmtype").equals("")) ? "" : request.getParameter("agmtype");
String drvid = request.getParameter("drvid") == null ? "0" : request.getParameter("drvid");
String agmdocno = request.getParameter("agmdocno") == null ? "0" : request.getParameter("agmdocno");


try{
	int val=0;
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	String sql="";
	

	if(agmtype.equalsIgnoreCase("RAG")){
		sql="update gl_ragmt r   set r.drid='"+drvid+"', r.delivery='1.0',r.invdate=null,r.invtodate=null  where r.doc_no="+agmdocno;
	}else if(agmtype.equalsIgnoreCase("LAG")){

		sql="update gl_lagmt r   set r.drid='"+drvid+"', r.delivery='1.0',r.invdate=null,r.invtodate=null  where r.doc_no="+agmdocno;
	}
	  

	val= stmt.executeUpdate(sql);
	//System.out.println("delivery update=-----"+sql);

			
	
	
	if(val>0){
		
		conn.commit();
	}
   
    response.getWriter().print(val);
	 
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>


 