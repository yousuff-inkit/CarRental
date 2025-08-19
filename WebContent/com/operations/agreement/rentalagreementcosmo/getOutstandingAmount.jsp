<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String errormsg="";
Connection conn=null;
double balance=0.0;
int exceedstatus=0;
double creditlimit=0.0;

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select round(sum(j.dramount),2) balance,j.acno from my_jvtran j left join my_head h on h.doc_no=j.acno "+
	" left join my_acbook ac on (h.doc_no=ac.acno) where j.status=3 and j.yrid=0 and h.atype='AR' and ac.cldocno="+cldocno+" group by j.acno";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		balance=rs.getDouble("balance");
	}
	String strgetlimit="select (j.dramount) balance,j.acno,DATEDIFF(CURDATE(),MAX(J.DATE))>AC.PERIOD2 exceedstatus,coalesce(AC.CREDIT,0) credit from my_jvtran j left join "+
	" MY_ACBOOK AC on J.ACNO=AC.acno  where j.status=3 and j.yrid=0 and AC.DTYPE='CRM' AND J.DRAMOUNT>0 and dramount-out_amount!=0 AND ac.cldocno="+cldocno;
	System.out.println(strgetlimit);
	ResultSet rslimit=stmt.executeQuery(strgetlimit);
	while(rslimit.next()){
		exceedstatus=rslimit.getInt("exceedstatus");
		creditlimit=rslimit.getDouble("credit");
	}
	strgetlimit="select date_sub(curdate(), interval ac.period2 day)>j.date ,(j.dramount) balance,j.acno,j.date,sum(dramount),credit,sum(dramount-out_amount)>credit exceedstatus,AC.PERIOD2 ,coalesce(AC.CREDIT,0) credit,sum(dramount-out_amount) newbalance from my_jvtran j left join"+
	" MY_ACBOOK AC on J.ACNO=AC.acno  where j.status=3 and j.yrid=0 and AC.DTYPE='CRM' AND J.DRAMOUNT>0 and dramount-out_amount!=0"+
	" and date_sub(curdate(), interval ac.period2 day)>j.date  AND ac.cldocno="+cldocno;
	while(rslimit.next()){
		exceedstatus=rslimit.getInt("exceedstatus");
		//balance=rs.getDouble("newbalance");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(balance+"::"+exceedstatus+"::"+creditlimit);
%>