<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.ArrayList"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null; 
	String formname = request.getParameter("formname")==null?"":request.getParameter("formname").trim().toString();
	String name = request.getParameter("name")==null?"":request.getParameter("name").trim();
	String rowfields = request.getParameter("rowfields")==null?"":request.getParameter("rowfields").trim();
	String colfields = request.getParameter("colfields")==null?"":request.getParameter("colfields").trim();
	String valfields = request.getParameter("valfields")==null?"":request.getParameter("valfields").trim();  
    try{       
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
		int val=0, pivotdesign=0, docno=0;
		String rowString = "0", colString = "0", valString = "0"; 
		
		if(!rowfields.equals("")){
			String[] rowArray = rowfields.split(",");
		    for (int i = 0; i < rowArray.length; i++) {
		    	rowArray[i] = "'" + rowArray[i].toLowerCase() + "'";
		    }
		    rowString = String.join(",", rowArray);   
		}
		
		if(!colfields.equals("")){
			String[] colArray = colfields.split(",");
		    for (int i = 0; i < colArray.length; i++) {
		    	colArray[i] = "'" + colArray[i].toLowerCase() + "'";
		    }
		    colString = String.join(",", colArray);
		}
		
		if(!valfields.equals("")){
			String[] valArray = valfields.split(",");
		    for (int i = 0; i < valArray.length; i++) {
		    	valArray[i] = "'" + valArray[i].toLowerCase() + "'";
		    }
		    valString = String.join(",", valArray);  
		}
		 
		String selectsql = "SELECT m.doc_no, dd.pivotdesign FROM gl_pivotm m LEFT JOIN (SELECT COALESCE(MAX(pivotdesign)+1,1) pivotdesign, rdocno FROM gl_pivotd GROUP BY rdocno) dd ON dd.rdocno=m.doc_no WHERE m.dtype=(SELECT dtype FROM gl_bibd WHERE description='"+formname+"')"; 
		//System.out.println("selectsql--->>>"+selectsql); 
		ResultSet rs = stmt.executeQuery(selectsql);
		while(rs.next()){
			docno = rs.getInt("doc_no");
			pivotdesign = rs.getInt("pivotdesign");
		}
		
		String inssql = "INSERT INTO gl_pivotd(rdocno, datafields, types, pivotdesign, pivotdesignname) SELECT rdocno, datafields, types, "+pivotdesign+" pivotdesign, '"+name+"' pivotdesignname FROM gl_pivotd WHERE rdocno="+docno+" AND pivotdesign=0";
		//System.out.println("inssql--->>>"+inssql);         
		val = stmt.executeUpdate(inssql);  
		if(val>0){
			String upsql = "UPDATE gl_pivotd SET pivotrows = IF(datafields IN("+rowString+"), 1, 0), pivotcolumns = IF(datafields IN("+colString+"), 1, 0), pivotvalues = IF(datafields IN("+valString+"), 1, 0) WHERE rdocno="+docno+" AND pivotdesign="+pivotdesign+"";  
			//System.out.println("upsql--->>>"+upsql);           
			val = stmt.executeUpdate(upsql); 
		}
		
		if(val>0){
			conn.commit();
		}
		
		response.getWriter().print(val);
 	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();
   }
%>