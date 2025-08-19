<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").toString(); 
String userid = request.getParameter("userid")==null || request.getParameter("userid")==""?"0":request.getParameter("userid").toString();
String fromdtchk = request.getParameter("fromdtchk")==null?"":request.getParameter("fromdtchk").toString();
String sqltest = "", result = "";
Connection conn=null;
try{
	ClsCommon cmn = new ClsCommon();
	ClsConnection objconn=new ClsConnection();     
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlfromdate = null;
    java.sql.Date sqltodate = null;
    
    if(fromdtchk.equals("1")) {  
		if(!fromdate.equals("") && fromdate!=null) {
			sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
			sqltest += " and t.strt_date>='"+sqlfromdate+"'";
		}
	}else {
		sqltest += " and t.close_status=0";            
	}
	
	if(!todate.equals("") && todate!=null) {
		sqltodate = cmn.changeStringtoSqlDate(todate);
		sqltest += " and t.strt_date<='"+sqltodate+"'";
	}
	
	String sql = "select * from my_user where doc_no='"+userid+"' and role_id=1";
	ResultSet rs1 = stmt.executeQuery(sql);
	if(rs1.next()){            
	}else{
		sqltest += " and (t.userid='"+userid+"' or t.ass_user='"+userid+"')";
	}
	 
	String strcountdata = "select (select count(*) val from an_taskcreation t where t.act_status='Assigned' "+sqltest+") assigned, (select count(*) val from an_taskcreation t where t.act_status='Accepted' "+sqltest+") accepted, (select count(*) val from an_taskcreation t where t.act_status='Completed' "+sqltest+")  completed, (select count(*) val from an_taskcreation t where t.act_status='Confirmed' "+sqltest+")  confirmed";
	//System.out.println("getcount=="+strcountdata);
	ResultSet rs = stmt.executeQuery(strcountdata);
	while(rs.next()){       
		result = rs.getString("assigned")+"::"+rs.getString("accepted")+"::"+rs.getString("completed")+"::"+rs.getString("confirmed");           
	}  
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(result);
%>