<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.common.ClsCommon"%>
<%
Connection conn=null;
String selectedDate = request.getParameter("date")==null?"":request.getParameter("date"); 
System.out.println(selectedDate);
int val = 0; 
Date sqldate = null;
try{
	    ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		ClsCommon cmn = new ClsCommon();
		
		if(!selectedDate.equals("")){
			sqldate = cmn.changeStringtoSqlDate(selectedDate);
		}
		
		String str1 = "select fleet_no, date, veh.tcno, statu, fstatus from carfare2023.gl_vehmaster veh left join gl_webid w on w.tcno=veh.tcno where veh.dtype='veh' and (w.tcno is null or veh.tcno='') and fstatus!='z'";
		ResultSet rs1 = stmt.executeQuery(str1);
		if(rs1.next()){
			val = 1; 
		}
		
		if(val == 0){
			String str2 = "select * from carfare2023.my_brch where status=3 and mclose < LAST_DAY('" + sqldate + "')";
			System.out.println(str2);
			ResultSet rs2 = stmt.executeQuery(str2);
			if(rs2.next()){
				val = 2; 
			}
		}
		
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
response.getWriter().print(val);
%>