<%@page import="com.mysql.jdbc.exceptions.MySQLSyntaxErrorException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
String month=request.getParameter("month")==null?"":request.getParameter("month");
String year=request.getParameter("year")==null?"":request.getParameter("year");

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ArrayList<String> logarray=new ArrayList();
	String targetdb="carfare2023";  
	String[] params={"#dbname","#month","#year"};
	String[] values={targetdb,month,year};
	
	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	
	String strfta="select query,log,mastername from my_fta where status=3 order by seqno";
	ResultSet rs=stmt.executeQuery(strfta);
	String master="",rawquery="",vpurdocno="";
	while(rs.next()){
		try{
			rawquery=rs.getString("query");
			master=rs.getString("mastername");
			int log=rs.getInt("log");
			for(int i=0;i<params.length;i++){
				if(rawquery.contains(params[i])){
					rawquery=rawquery.replace(params[i],values[i]);
				}
			}
			System.out.println("Running : "+master);
			if(master.equalsIgnoreCase("Vehicle Purchase Jvtran")){
				ResultSet rsvp=conn.createStatement().executeQuery(rawquery);
				while(rsvp.next()){
					vpurdocno+=rsvp.getInt("rdocno");
					System.out.println(vpurdocno+"==="+rawquery);
				}
				if(vpurdocno.equalsIgnoreCase("")){
					System.out.println("insert into my_jvtran (tr_no,acno,dramount,rate,curId,out_amount,duedate,clearedon,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,category,refTrNo,rdocno,rtype,bankreconcile,prep,costtype,costcode)  select m.tr_no,m.acno,m.dramount,m.rate,m.curId,m.out_amount,m.duedate,m.clearedon, m.trtype, -1 id,m.ref_row,inv.brhid,m.description,m.yrId,m.cldocno,m.date,m.dTYPE,m.stkmove, m.dramount, m.doc_no, m.LAGE,m.ref_detail,m.lbrrate,m.status,m.category,m.refTrNo,m.rdocno,m.rtype, m.bankreconcile, m.prep,m.costtype,m.costcode from gl_vpurm inv inner join #dbname.my_jvtran m on inv.tr_no=m.tr_no  left join my_jvtran m1 on inv.tr_no=m1.tr_no and m1.acno=m.acno where  month(m.date)=#month and year(m.date)=#year and m.status=3 and coalesce(m1.tr_no,'')='' ".replace("#month",month).replace("#year",year).replace("#dbname",targetdb));
					
					 int update=conn.createStatement().executeUpdate("insert into my_jvtran (tr_no,acno,dramount,rate,curId,out_amount,duedate,clearedon,trtype,id,ref_row,brhid,description,yrId,cldocno,date,dTYPE,stkmove,ldramount,doc_no,LAGE,ref_detail,lbrrate,status,category,refTrNo,rdocno,rtype,bankreconcile,prep,costtype,costcode)  select m.tr_no,m.acno,m.dramount,m.rate,m.curId,m.out_amount,m.duedate,m.clearedon, m.trtype, -1 id,m.ref_row,inv.brhid,m.description,m.yrId,m.cldocno,m.date,m.dTYPE,m.stkmove, m.dramount, m.doc_no, m.LAGE,m.ref_detail,m.lbrrate,m.status,m.category,m.refTrNo,m.rdocno,m.rtype, m.bankreconcile, m.prep,m.costtype,m.costcode from gl_vpurm inv inner join #dbname.my_jvtran m on inv.tr_no=m.tr_no  left join my_jvtran m1 on inv.tr_no=m1.tr_no and m1.acno=m.acno where  month(m.date)=#month and year(m.date)=#year and m.status=3 and coalesce(m1.tr_no,'')='' ".replace("#month",month).replace("#year",year).replace("#dbname",targetdb));
					 
				}
			}else {
			int update=conn.createStatement().executeUpdate(rawquery);
			if(update<0){
				logarray.add(master+" Not Updated"+"::"+0);
			}
			else{
				if(log>0 && update>0){
					logarray.add(master+" "+update+" Updated"+"::"+1);
				}
			}
			}
		}
		catch(Exception ex){
			System.out.println(rawquery);
			ex.printStackTrace();
			logarray.add(master+" Not Updated,"+ex.getMessage()+""+"::"+0);
		}
		
	}
	
	for(int i=0;i<logarray.size();i++){
		String message=logarray.get(i).split("::")[0];
		String logtype=logarray.get(i).split("::")[1];
		if(message.contains("\'")){
			message=message.replace("\'", "");
		}
		String strinsertlog="insert into my_ftalog(userid,message,logtype,monthno,yearno) values("+userid+",'"+message+"',"+logtype+","+month+","+year+")";
		System.out.println(strinsertlog);
		int insertlog=stmt.executeUpdate(strinsertlog);
	}
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	if(conn!=null && !conn.isClosed()){
		conn.close();
	}
}
objdata.put("errorstatus", errorstatus);
response.getWriter().write(objdata+"");
%>