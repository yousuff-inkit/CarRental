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

	Connection conn = null;
	
	try{
	
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	
		String selectedsrno=request.getParameter("selectedsrno");
		String confirmed=request.getParameter("confirmed");
		String selecteddb=request.getParameter("selecteddb");

		int val=0;
		java.sql.Date sqlUpToDate=null;
		
        String[] docsarray = selectedsrno.split("::");
        String[] dbarray = selecteddb.split("::");

       
		for (int i = 0; i < docsarray.length; i++) {
			String srno=docsarray[i];	
			String db=dbarray[i];	

			if(!(srno.equalsIgnoreCase(""))){
				
			String	sql="UPDATE "+db+".hr_workdetails SET confirmed="+confirmed+" where srno='"+srno+"'";
			System.out.println("sql=================="+sql);
				val= stmt.executeUpdate(sql);
		  }
		}
		
		
				 
		conn.commit();
		
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
   } finally{
	   conn.close();
   }
	%>
