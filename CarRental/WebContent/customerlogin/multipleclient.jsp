<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
JSONObject objdata=new JSONObject();
		String brch=session.getAttribute("BRANCHID").toString();
		String strSql ="";	
		ClsConnection ClsConnection=new ClsConnection();
		Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		JSONArray vendorarray=new JSONArray();
		String clientusername=session.getAttribute("PORTALUSERNAME")==null?"":session.getAttribute("PORTALUSERNAME").toString();
		strSql="select cldocno,refname,acno from my_acbook where clientusername='"+clientusername+"' and status=3 and dtype='CRM'";
		// System.out.println("Multiple client : "+strSql);
		ResultSet resultSet = stmt.executeQuery(strSql);
		while(resultSet.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("cldocno",resultSet.getString("cldocno"));
			objtemp.put("refname",resultSet.getString("refname"));
			objtemp.put("acno",resultSet.getString("acno"));
		    vendorarray.add(objtemp);
		}
		
		objdata.put("vendordata", vendorarray);
		response.getWriter().write(objdata+"");
		resultSet.close();
		stmt.close();
		conn.close();


%>