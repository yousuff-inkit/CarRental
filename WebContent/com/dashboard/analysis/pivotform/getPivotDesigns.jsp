<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
Connection conn=null;
String formname = request.getParameter("formname")==null?"":request.getParameter("formname").trim().toString();
try{ ClsConnection ClsConnection=new ClsConnection();
	 conn = ClsConnection.getMyConnection();
	 Statement stmt = conn.createStatement ();
	 String strSql = "SELECT DISTINCT pivotdesign doc_no, pivotdesignname name FROM gl_pivotm m LEFT JOIN gl_pivotd d ON d.rdocno=m.doc_no WHERE m.dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"')";
	 ResultSet rs = stmt.executeQuery(strSql);
	 String pro="",sr="";
	 while(rs.next()) {
				pro+=rs.getString("name").toUpperCase()+",";
				sr+=rs.getString("doc_no")+",";
	 } 
	 
	 if(!pro.equals("")){
		 pro=pro.substring(0, pro.length()-1);
		 sr=sr.substring(0, sr.length()-1);
	 }
	 response.getWriter().write(sr+"####"+pro);
	 stmt.close();
	 conn.close();
}
catch(Exception e){

		conn.close();
		e.printStackTrace();
	}
	
	
	
	
  %>
  