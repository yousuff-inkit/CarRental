<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String masterdocno=request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String pyttotalrent=request.getParameter("pyttotalrent")==null?"0":request.getParameter("pyttotalrent").replace(",","").trim();
String pytadvance=request.getParameter("pytadvance")==null?"0":request.getParameter("pytadvance");
String pytbalance=request.getParameter("pytbalance")==null?"0":request.getParameter("pytbalance");
String pytstartdate=request.getParameter("pytstartdate")==null?"0":request.getParameter("pytstartdate");
String pytmonthsno=request.getParameter("pytmonthsno")==null?"0":request.getParameter("pytmonthsno");
String pytbankacno=request.getParameter("pytbankacno")==null || request.getParameter("pytbankacno")==""?"0":request.getParameter("pytbankacno");
String rsdval=request.getParameter("rsdval")==null || request.getParameter("rsdval")==""?"0":request.getParameter("rsdval").replace(",","").trim();
String extdate=request.getParameter("extdate")==null?"0":request.getParameter("extdate");

//System.out.println("Inside Ajax");
String gridarray=request.getParameter("gridarray");
/* ==null?"":request.getParameter("gridarray"); */
//System.out.println("Grid Array: "+gridarray);
int status=-1;
try{
	java.sql.Date sqlpytdate=null;
	java.sql.Date sqlextdate=null;

	if(!pytstartdate.equalsIgnoreCase("0")){
		sqlpytdate=objcommon.changeStringtoSqlDate(pytstartdate);
	}
	if(!extdate.equalsIgnoreCase("0")){
		sqlextdate=objcommon.changeStringtoSqlDate(extdate);
	}
	String temparray[]=gridarray.split(",");
	ArrayList<String> newarray=new ArrayList();
	for(int i=0;i<temparray.length;i++){
		newarray.add(temparray[i]);
	}
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	if(!masterdocno.equalsIgnoreCase("0")){
		
		String strsql="update gl_leaseext set totalrent="+pyttotalrent+",startdt='"+sqlpytdate+"',noofmonth="+pytmonthsno+",bankacno="+pytbankacno+",extdate='"+sqlextdate+"',residualval="+rsdval+" where srno="+masterdocno;
		//System.out.println("UPDATION========>"+strsql);
		int updateval=stmt.executeUpdate(strsql);
		if(updateval<0){
			status=0;
		}
		else{
			String strsqlcount="select count(*) maxcount from gl_leasepytcalcext where rdocno="+masterdocno+" and markstatus>0";
			//System.out.println("Payment Inv Count Query:"+strsql);
			ResultSet rs=stmt.executeQuery(strsqlcount);
			int count=0;
			while(rs.next()){
				count=rs.getInt("maxcount");
			}
			if(count==0){
				String strdelete="delete from gl_leasepytcalcext where rdocno="+masterdocno+" and status=3";
				int deleteval=stmt.executeUpdate(strdelete);
				
				for(int i=0;i<newarray.size();i++){
					String temp[]=newarray.get(i).split("::");
					java.sql.Date sqldate=null;
					if(!temp[0].equalsIgnoreCase("") && temp[0]!=null){
						sqldate=objcommon.changeStringtoSqlDate(temp[0]);
					}
					String bpvno=temp[3].trim().equalsIgnoreCase("")?null:temp[3];
					String chequeno=temp[2].trim().equalsIgnoreCase("")?null:temp[2];
					Statement stmtcheque=conn.createStatement();
					String strinsert="insert into gl_leasepytcalcext(date,amount,bpvno,chequeno,rdocno,status)values('"+sqldate+"',"+temp[1]+","+bpvno+","+chequeno+","+masterdocno+",3)";
					int val=stmtcheque.executeUpdate(strinsert);
					if(val<=0){
						status=0;
					}
				//	System.out.println("Status: "+status);
					//System.out.println("Query: "+strinsert);
				}	
			}
			else{
				status=0;
			}
			
		}
	}
if(status==0){
	
}
else{
	//System.out.print("Success: "+status);
	status=1;
	conn.commit();
}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>