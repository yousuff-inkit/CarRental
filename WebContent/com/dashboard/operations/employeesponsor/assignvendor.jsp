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
	String employeedocnos=request.getParameter("employeedocnos")==null?"":request.getParameter("employeedocnos");
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	
	conn.setAutoCommit(false);
	
	Statement stmt=conn.createStatement();
	System.out.println(employeedocnos);
	
	String empid [] = employeedocnos.split(",");
	for(int i=0; i<empid.length;i++){
		
		boolean ispresent=false;
		String sql = "select count(employeeid) cnt from my_velink where status=3 and employeeid="+empid[i];
		ResultSet rs = stmt.executeQuery(sql);	
		if(rs.next()){
			if(rs.getInt("cnt")>0){
				ispresent=true;
			}
		}
		
		if(ispresent){
			String strupdatelog="Update my_velink set status=7 where status=3 and employeeid="+empid[i];
			System.out.println(strupdatelog);
			int updatelog=stmt.executeUpdate(strupdatelog);	
			if(updatelog<=0){
				System.out.println("Update Failed in velink");
				errorstatus=1;
			}
		}
		
		String strupdatelog="insert into my_velink (vendorid,employeeid,date) values("+vendordocno+","+empid[i]+",now())";
		System.out.println(strupdatelog);
		int updatelog=stmt.executeUpdate(strupdatelog);	
		if(updatelog<=0){
			errorstatus=1;
		}
	}
	
	if(errorstatus==0){
		conn.commit();
	}else{
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