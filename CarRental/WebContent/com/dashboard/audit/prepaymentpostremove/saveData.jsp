<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="com.connection.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
ClsJournalVouchersDAO jvdao=new ClsJournalVouchersDAO();

String docarray=request.getParameter("docarray")==null?"":request.getParameter("docarray");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");

ArrayList<String> dataarray=new ArrayList();

String[] temparray=docarray.split(",");
for(int i=0;i<temparray.length;i++){
	dataarray.add(temparray[i]);
}

Connection conn=null;
int errorstatus=0;
try{
	
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	conn.setAutoCommit(false);
	
	String userid=session.getAttribute("USERID").toString();
	
	for(int i=0;i<dataarray.size();i++){
		String data[]=dataarray.get(i).split("::");
		
		String doc_no=data[0];
		String tr_no=data[1];
		String brhid=data[2];
		
		String sqlinsert="INSERT INTO my_brpp (jvno, brhId, date, userId, remark) VALUES ("+doc_no+", "+brhid+", NOW(), "+userid+", '"+remarks+"');";
		int insert=stmt.executeUpdate(sqlinsert);
		if(insert<0){
			System.out.println("Unpost Error - insert my_brpp");
			errorstatus=1;
			break;
		}
		
		session.setAttribute("BRANCHID", brhid);
		boolean status=jvdao.delete(Integer.parseInt(doc_no), "JVT", Integer.parseInt(tr_no), session);
		if(!status){
			System.out.println("Unpost Error - JV DAO");
			errorstatus=1;
			break;
		}
		
		String sqlupdate="update my_prepd d inner join my_prepm m on m.tranId=d.tranId set posted=0,jvtrno=0 "
		+"where m.brhid="+brhid+" and d.jvtrno in (select tr_no from my_jvtran where doc_no="+doc_no+" and brhid="+brhid+" and dtype='jvt');";
		int update=stmt.executeUpdate(sqlupdate);
		if(update<0){
			System.out.println("Unpost Error - update my_prepd");
			errorstatus=1;
			break;
		}
	}
		
	if(errorstatus==0){
		conn.commit();	
	}

}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>