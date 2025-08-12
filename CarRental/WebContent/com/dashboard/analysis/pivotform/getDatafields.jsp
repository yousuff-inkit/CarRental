<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String formname = request.getParameter("formname")==null?"":request.getParameter("formname").trim().toString();
		String pivotdesign = request.getParameter("pivotdesign")==null || request.getParameter("pivotdesign").equals("")?"0":request.getParameter("pivotdesign").trim().toString();
		JSONArray jsondatafields = new JSONArray();
		JSONArray jsonfields = new JSONArray();
		JSONArray jsonrows = new JSONArray();
		JSONArray jsoncols = new JSONArray();
		JSONArray jsonvals = new JSONArray();
		
		String sql = "SELECT datafields, types, pivotrows, pivotcolumns, pivotvalues FROM gl_pivotm m LEFT JOIN gl_pivotd d ON d.rdocno=m.doc_no WHERE m.dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"') AND d.pivotdesign="+pivotdesign+"";
		//System.out.println("sql--->>>"+sql);    
		ResultSet rs = stmt.executeQuery(sql);   
		while(rs.next()){
			String rows = rs.getString("pivotrows");
			String cols = rs.getString("pivotcolumns");
			String vals = rs.getString("pivotvalues");
			
			JSONObject jsonObDF = new JSONObject();
			jsonObDF.put("name", rs.getString("datafields"));
			jsonObDF.put("type", rs.getString("types"));
			jsondatafields.add(jsonObDF);  
			
			JSONObject jsonObF = new JSONObject();
			jsonObF.put("dataField", rs.getString("datafields"));
			jsonObF.put("text", rs.getString("datafields").toUpperCase());  
			jsonfields.add(jsonObF); 
			
			if(rows.equals("1")){
				JSONObject jsonObR = new JSONObject();
				jsonObR.put("dataField", rs.getString("datafields"));
				jsonObR.put("text", rs.getString("datafields").toUpperCase());  
				jsonrows.add(jsonObR);
			}
			
			if(cols.equals("1")){
				JSONObject jsonObC = new JSONObject();
				jsonObC.put("dataField", rs.getString("datafields"));
				jsonObC.put("text", rs.getString("datafields").toUpperCase());  
				jsoncols.add(jsonObC);  
			}
			
			if(vals.equals("1")){
				JSONObject jsonObV = new JSONObject();
				JSONObject jsonObV1 = new JSONObject();
				jsonObV.put("dataField", rs.getString("datafields"));
				jsonObV.put("text", rs.getString("datafields").toUpperCase());
				jsonObV.put("function", "sum");
				jsonObV.put("align", "right");
				jsonObV1.put("decimalPlaces", 2);  
				jsonObV1.put("align", "right");
				jsonObV1.put("thousandsSeparator", ",");  
				jsonObV.put("formatSettings", jsonObV1);   
				jsonvals.add(jsonObV);  
			}
			
		}
	    
		//System.out.println("jsonvals : "+jsonvals);  
		response.getWriter().print(jsondatafields+"####"+jsonfields+"####"+jsonrows+"####"+jsoncols+"####"+jsonvals);  

 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>