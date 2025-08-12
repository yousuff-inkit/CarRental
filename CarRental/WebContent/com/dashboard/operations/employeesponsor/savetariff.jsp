<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
try{
	
	String vendordocno=request.getParameter("vendordocno")==null?"":request.getParameter("vendordocno");
	String description=request.getParameter("description")==null?"":request.getParameter("description");
	String monthlycarrent=request.getParameter("monthlycarrent")==null?"":request.getParameter("monthlycarrent");
	String monthlybikerentp=request.getParameter("monthlybikerentp")==null?"":request.getParameter("monthlybikerentp");
	String monthlybikerentd=request.getParameter("monthlybikerentd")==null?"":request.getParameter("monthlybikerentd");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	
	conn.setAutoCommit(false);
	
	Statement stmt=conn.createStatement();
	
	boolean ispresent=false;
	String sql = "select count(vendorid) cnt from my_vtariff where status=3 and vendorid="+vendordocno;
	ResultSet rs = stmt.executeQuery(sql);	
	if(rs.next()){
		if(rs.getInt("cnt")>0){
			ispresent=true;
		}
	}
	
	if(ispresent){
		String strupdatelog="Update my_vtariff set status=7 where vendorid="+vendordocno;
		System.out.println(strupdatelog);
		int updatelog=stmt.executeUpdate(strupdatelog);	
		if(updatelog<=0){
			System.out.println("Update Failed in my_vtariff");
			errorstatus=1;
		}
	}
	
	String strupdatelog="insert into my_vtariff (vendorid,monthlyratecar,pickupratebike,droppoffratebike,description) values ("+vendordocno+","+monthlycarrent+","+monthlybikerentp+","+monthlybikerentd+",'"+description+"')";
	System.out.println(strupdatelog);
	int updatelog=stmt.executeUpdate(strupdatelog);
	if(updatelog>0){
		conn.commit();
	}
	else{
		errorstatus=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>