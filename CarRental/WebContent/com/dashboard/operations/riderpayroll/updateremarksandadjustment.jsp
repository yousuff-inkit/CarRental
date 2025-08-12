<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
	String docNo=request.getParameter("docno");
	String brchid=request.getParameter("brchid");
	String year=request.getParameter("year");
	String month=request.getParameter("month");
	String remarks= request.getParameter("remarks");
	String reason= request.getParameter("reason");
	String adjustments= request.getParameter("adjustment");
	String fine= request.getParameter("fine");
	String salik= request.getParameter("salik");
	String extrasimused= request.getParameter("extrasimused");
	String insurance= request.getParameter("insurance");
	String advance= request.getParameter("advance");
	String nsalary= request.getParameter("nsalary");
	String rtaclass= request.getParameter("rtaclass");
	String fineperformance= request.getParameter("fineperformance");
	String labourcard= request.getParameter("labourcard");
	String llogns= request.getParameter("llogns");
	String isupdated= request.getParameter("isupdated");
	String result="0";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqlisupdated="";
	if(Integer.parseInt(isupdated)>0){
		sqlisupdated+=", isupdated="+isupdated;
	}
	
	String updatesql = "update my_rip set llogns="+llogns+",reason='"+reason+"', fineperformance="+fineperformance+",labourcard="+labourcard+",rtaclass="+rtaclass+",nsalary="+nsalary+",advance="+advance+",insurance="+insurance+",fine="+fine+",salik="+salik+",extrasimused="+extrasimused+",adjustments="+adjustments+" , remarks='"+remarks+"'"+sqlisupdated+" where month="+month+" and year ="+year+" and doc_no="+docNo;
	System.out.println(updatesql);
	int res = stmt.executeUpdate(updatesql);
	result = res+"";
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>