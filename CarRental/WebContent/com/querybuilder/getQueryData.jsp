<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%
String query=request.getParameter("query")==null?"":request.getParameter("query");
String dbname=request.getParameter("dbname")==null?"":request.getParameter("dbname");
Connection conn=null;
JSONObject objdata=new JSONObject();
String sqlmessage="";
String sqltype="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//System.out.println(dbname+"::"+query);
	if(!dbname.trim().equalsIgnoreCase("")){
		String strusedb="use "+dbname;
		int usedb=stmt.executeUpdate(strusedb);
	}
	
	String uppercasequery=query.trim().toUpperCase();
	Pattern sqlpattern=Pattern.compile("^(SELECT|UPDATE|INSERT|DELETE|CREATE|ALTER|DROP|TRUNCATE|SHOW|KILL)");
	Matcher sqlmatcher=sqlpattern.matcher(uppercasequery);
	
	if(sqlmatcher.find()){
		String firstword=sqlmatcher.group(1);
		if(firstword.equalsIgnoreCase("SELECT") || firstword.equalsIgnoreCase("SHOW")){
			//Select Query
			sqltype="rs";
			ResultSet rs=stmt.executeQuery(query);
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();
			
			JSONArray columnNames=new JSONArray();
			JSONArray columnValues = new JSONArray();
			for (int i = 1; i <= columnCount; i++) {
                columnNames.add(metaData.getColumnName(i));
            }
			
			while (rs.next()) {
				ArrayList<String> valuearray=new ArrayList();
                for (int i = 0,j=1; i < columnNames.size(); i++,j++) {
                	valuearray.add(rs.getString(j));
                	//rowValues.add(rs.getObject(i));
                }
                columnValues.add(valuearray);
            }
			System.out.println(columnValues);
			objdata.put("columnnames", columnNames);
			objdata.put("columnvalues", columnValues);
		}
		else{
			sqltype="stmt";
			int rowsaffected=stmt.executeUpdate(query);
			objdata.put("rowsaffected", rowsaffected);
		}
	}
	
}
catch(Exception e){
	e.printStackTrace();
	objdata.put("sqlmessage", e.getMessage());
}
finally{
	conn.close();
}
objdata.put("sqltype", sqltype);
response.getWriter().write(objdata+"");

%>