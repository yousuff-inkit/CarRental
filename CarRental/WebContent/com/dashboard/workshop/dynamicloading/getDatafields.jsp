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
		JSONArray jsondatafields = new JSONArray();
		JSONArray jsonfields = new JSONArray();
		JSONArray jsonrows = new JSONArray();
		JSONArray jsoncols = new JSONArray();
		JSONArray jsonvals = new JSONArray();
		
		String sql = "SELECT datafields, columnname, datatype, cellsformat, cellsalign, width, align, hidden FROM ws_dynamicloadm m LEFT JOIN ws_dynamicloadd d ON d.rdocno=m.doc_no WHERE m.dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"')";
		System.out.println("sql--->>>"+sql);    
		ResultSet rs = stmt.executeQuery(sql);   
		while(rs.next()){
			/* String rows = rs.getString("pivotrows");
			String cols = rs.getString("pivotcolumns");
			String vals = rs.getString("pivotvalues");
			  */
			  System.out.println("inside-->>>1");    
			JSONObject jsonObDF = new JSONObject();
			jsonObDF.put("name", rs.getString("datafields"));
			jsonObDF.put("type", rs.getString("datatype"));
			jsondatafields.add(jsonObDF);  
			 System.out.println("inside-->>>2");    
			JSONObject jsonObF = new JSONObject();
			 System.out.println("inside-->>>3");    
			jsonObF.put("text", rs.getString("datafields").toUpperCase()); 
			 System.out.println("inside-->>>4");    
			jsonObF.put("datafield", rs.getString("datafields"));
			
			 String width = rs.getString("width");
				System.out.println("width------"+width);
				if (width != null && !width.trim().isEmpty() && !"0".equals(width.trim())) {
				    jsonObF.put("width", width.trim());
				}
				
				String cellsformat = rs.getString("cellsformat");
				System.out.println("cellsformat------"+cellsformat);
				
				if (cellsformat != null && !cellsformat.trim().isEmpty() && !"0".equals(cellsformat.trim())) {
				    jsonObF.put("cellsformat", cellsformat.trim());
				}

				String cellsalign = rs.getString("cellsalign");
				System.out.println("cellsalign------"+cellsalign);
				
				if (cellsalign != null && !cellsalign.trim().isEmpty() && !"0".equals(cellsalign.trim())) {
				    jsonObF.put("cellsalign", cellsalign.trim());
				}

				String align = rs.getString("align");
				System.out.println("align------"+align);
				
				if (align != null && !align.trim().isEmpty() && !"0".equals(align.trim())) {
				    jsonObF.put("align", align.trim());
				}
				String hidden = rs.getString("hidden");
				System.out.println("hidden------"+hidden);
				
				if (hidden != null && !hidden.trim().isEmpty() && !"0".equals(hidden.trim())) {
				    jsonObF.put("hidden", hidden.trim());
				}
				System.out.println("hidden11------"+hidden);
				
		    jsonfields.add(jsonObF); 
			
		
		}
		System.out.println("jsonvals : "+jsondatafields+"####"+jsonfields);  
		//System.out.println("jsonvals : "+jsonvals);  
		//response.getWriter().print(jsondatafields+"####"+jsonfields+"####"+jsonrows+"####"+jsoncols+"####"+jsonvals);  
		response.getWriter().print(jsondatafields+"####"+jsonfields);  
		System.out.println("jsonvals : "+jsondatafields+"####"+jsonfields);  
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>