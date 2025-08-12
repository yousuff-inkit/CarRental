<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int data=0;
	int termdata=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='hrsetupconfig'";
	//System.out.println("config========="+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		data=rs.getInt("method");
	}
	String sql = "SELECT method FROM gl_config WHERE field_nme='hideterminationbenefits'";
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		termdata=rs.getInt("method");
	}
	
	
	response.getWriter().write(data+"####"+termdata);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}


%>

