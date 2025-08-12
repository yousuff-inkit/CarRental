<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
ClsJournalVouchersDAO journaldao=new ClsJournalVouchersDAO();
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String hidcldocno=request.getParameter("hidcldocno")==null?"":request.getParameter("hidcldocno");
String pricenew=request.getParameter("salesvalue")==null?"0":request.getParameter("salesvalue");
//System.out.println("salesvalue====="+pricenew);
String hidacno=request.getParameter("hidacno")==null?"":request.getParameter("hidacno");
String vehreturndocno=request.getParameter("vehreturndocno")==null?"":request.getParameter("vehreturndocno");
Double salesprice=Double.parseDouble(pricenew)==0?0.00:Double.parseDouble(pricenew);
int insertmaster=0;

int errorstatus=0;
try{
	
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
	Statement stmt2=conn.createStatement();
	Statement stmt3=conn.createStatement();

	double currate=0.0;
	String userid=session.getAttribute("USERID").toString();
	
	int maxdocno=0;
	
	//Inserting into master
	
	String txtrefno="",vocno="";
	double txtdrtotal=0.0,txtcrtotal=0.0;
	int costtranacno=0;
	String txtdescription="";
	
	
	
	
		int tranid=0,jvacno=0,acnonw=0;
				double jvdramount=0,jvldramount=0,dramt=0,ldramt=0;
				String strasset="select tr_no tranid from gc_assettran where doc_no='"+vehreturndocno+"' and ttype='VSI'";
				ResultSet rstranid=stmt.executeQuery(strasset);
				while(rstranid.next()){
					tranid=rstranid.getInt("tranid");
				}
				//Insertion to gc_assettran
				String strjvtran1="select dramount dramt,ldramount ldramt from my_jvtran where tr_no='"+tranid+"' and acno=15813 ";
				ResultSet rsjvtran1=stmt.executeQuery(strjvtran1);
				while(rsjvtran1.next()){
					dramt=rsjvtran1.getDouble("dramt");
					ldramt=rsjvtran1.getDouble("ldramt");

				}
				String strjvtran="select dramount,ldramount from my_jvtran where tr_no='"+tranid+"' and acno='"+hidacno+"'";
				//	String strasset="insert into gc_assettran(date,doc_no,tr_no,fleet_no,acno,dramount,book_value,brhid,ttype,ftype)values('"+sqldate+"',"+maxdocno+","+request.getAttribute("tranno")+","+fleetno+","+temp[0]+","+amount+","+amount+","+branchid+",'"+dtype+"',1)";
				ResultSet rsjvtran=stmt.executeQuery(strjvtran);
				while(rsjvtran.next()){
					jvdramount=rsjvtran.getInt("dramount");
					jvldramount=rsjvtran.getInt("ldramount");
				}
				double amt=salesprice-jvdramount;
				double  dramount=dramt-amt;

				double lamt=salesprice-jvldramount;
				double  ldramount=ldramt-amt;

		//		System.out.println("dramount----"+dramount+"ldramount--------"+ldramount);	
				
			String sqltest="",sqltest1="",sqltest2="",sqltest3="";
			if(salesprice!=0)
			{
				sqltest=sqltest+",dramount='"+salesprice+"',ldramount='"+salesprice+"'";
				sqltest1=sqltest1+",dramount='"+dramount+"',ldramount='"+ldramount+"'";
				sqltest2=sqltest2+",amount='"+salesprice+"'";
				sqltest3=sqltest3+",salesprice='"+salesprice+"'";


			}
				
				if(cldocno!="")
				{
					String stracno="select acno from my_acbook where cldocno='"+cldocno+"'";
					//	String strasset="insert into gc_assettran(date,doc_no,tr_no,fleet_no,acno,dramount,book_value,brhid,ttype,ftype)values('"+sqldate+"',"+maxdocno+","+request.getAttribute("tranno")+","+fleetno+","+temp[0]+","+amount+","+amount+","+branchid+",'"+dtype+"',1)";
					ResultSet rsacno=stmt1.executeQuery(stracno);
					while(rsacno.next()){
						acnonw=rsacno.getInt("acno");
					}
					String strinsertmaster="update my_jvtran set cldocno="+cldocno+",acno='"+acnonw+"' "+sqltest+" where tr_no='"+tranid+"' and acno='"+hidacno+"'";
				//	System.out.println("jvtran: "+strinsertmaster);
					stmt1.executeUpdate(strinsertmaster);
					String strinsertmasters="update my_jvtran set cldocno="+cldocno+" "+sqltest1+" where tr_no='"+tranid+"' and acno='15813'";
				//	System.out.println("jvtran: "+strinsertmasters);
					stmt1.executeUpdate(strinsertmasters);
					
					String strinsertmaster1="update gl_vehreturncalc set acno='"+acnonw+"' "+sqltest2+" where agmtno='"+agmtno+"' and acno='"+hidacno+"'";
				//	System.out.println("gl_vehreturncalc: "+strinsertmaster1);
					stmt2.executeUpdate(strinsertmaster1);
					String strinsertmaster1s="update gl_vehreturncalc set amount='"+dramount+"' where agmtno='"+agmtno+"' and acno='15813'";
				//	System.out.println("gl_vehreturncalc: "+strinsertmaster1s);
					stmt2.executeUpdate(strinsertmaster1s);
					
					String strinsertmaster2="update gl_vehreturn set cldocno='"+cldocno+"' "+sqltest3+" where doc_no='"+vehreturndocno+"'";
				//	System.out.println("gl_vehreturn: "+strinsertmaster2);
                    insertmaster=stmt2.executeUpdate(strinsertmaster2);
					
				
				}
				else
				{
					
					String strinsertmaster="update my_jvtran set dramount='"+salesprice+"',ldramount='"+salesprice+"' where tr_no='"+tranid+"' and acno='"+hidacno+"'";
				//	System.out.println("jvtran: "+strinsertmaster);
				    stmt1.executeUpdate(strinsertmaster);
				    String strinsertmasters="update my_jvtran set dramount='"+dramount+"',ldramount='"+ldramount+"' where tr_no='"+tranid+"' and acno='15813'";
				//	System.out.println("jvtran: "+strinsertmasters);
					stmt1.executeUpdate(strinsertmasters);
				
					String strinsertmaster1="update gl_vehreturncalc set amount='"+salesprice+"' where agmtno='"+agmtno+"' and acno='"+hidacno+"'";
				//	System.out.println("gl_vehreturncalc: "+strinsertmaster1);
					stmt2.executeUpdate(strinsertmaster1);
					String strinsertmaster1s="update gl_vehreturncalc set amount='"+dramount+"' where agmtno='"+agmtno+"' and acno='15813'";
				//	System.out.println("gl_vehreturncalc: "+strinsertmaster1s);
					stmt2.executeUpdate(strinsertmaster1s);
				
					String strinsertmaster2="update gl_vehreturn set salesprice="+salesprice+" where doc_no='"+vehreturndocno+"'";
				//	System.out.println("gl_vehreturn: "+strinsertmaster2);
					insertmaster=stmt3.executeUpdate(strinsertmaster2);
						
				
				
				}
			
			//	System.out.println("insertmaster: "+insertmaster);

		
					if(insertmaster<=0){
						errorstatus=1;
					}
					else{
			}
			
			String sqllog="insert into gl_biblog (doc_no,brhId,dtype,edate,userId,ENTRY) values ('"+vehreturndocno+"','"+session.getAttribute("BRANCHID").toString()+"','BLVR',now(),'"+userid+"','E')";
			int loginsert=stmt.executeUpdate(sqllog);
			if(loginsert<=0){
				errorstatus=1;
			}
		
	
	/* if(errorstatus!=1){
		conn.commit();
		
	} */
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>