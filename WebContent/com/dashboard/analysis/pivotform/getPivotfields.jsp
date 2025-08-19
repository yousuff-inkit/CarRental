<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%	
	Connection conn = null;
    String formname = request.getParameter("formname")==null?"":request.getParameter("formname").trim().toString();
	try{ ClsConnection ClsConnection=new ClsConnection();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		JSONArray jsondatafields = new JSONArray();
		
		String strSql = "SELECT datafields, types, pivotrows, pivotcolumns, pivotvalues FROM gl_pivotm m LEFT JOIN gl_pivotd d ON d.rdocno=m.doc_no WHERE m.dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"')";
		//System.out.println("-----------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		String datafields="",datafieldsId="";
		while(rs.next()) {
			JSONObject jsonObDF = new JSONObject();
			jsonObDF.put("field", rs.getString("datafields").toUpperCase());  
			jsondatafields.add(jsonObDF);  
		} 
		JSONObject jsonObDFs = new JSONObject();
		jsonObDFs.put("datafields", jsondatafields);   
		
		response.getWriter().print(jsonObDFs);     
 
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  