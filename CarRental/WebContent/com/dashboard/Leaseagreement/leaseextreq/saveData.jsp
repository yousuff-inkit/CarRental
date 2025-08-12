<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.email.*"%>
<%
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null; 

try{
 	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
 	Statement stmt = conn.createStatement(); 
 	Statement stmt1 = conn.createStatement();    
 	Statement stmt2 = conn.createStatement();    
 	Statement stmt3 = conn.createStatement();    
 	Statement stmt4 = conn.createStatement();    
 	Statement stmts = conn.createStatement(); 

	String docno=request.getParameter("docno")=="" || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
	String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();  
	String process=request.getParameter("process")=="" || request.getParameter("process").trim()==""?"0":request.getParameter("process").trim();
	String flwpdate=request.getParameter("flwpdate")==""?"":request.getParameter("flwpdate").trim();
	String flwpremarks=request.getParameter("flwpremarks")==""?"":request.getParameter("flwpremarks").trim(); 
	String rdtype=request.getParameter("rdtype")==""?"":request.getParameter("rdtype").trim(); 
	String reqdate=request.getParameter("reqdate")==""?"":request.getParameter("reqdate").trim();
	String reqremarks=request.getParameter("reqremarks")==""?"":request.getParameter("reqremarks").trim(); 
	String reqamt=request.getParameter("reqamt")==""?"0":request.getParameter("reqamt").replace(",","").trim(); 
	String exttilldate=request.getParameter("exttilldate")==""?"":request.getParameter("exttilldate").trim();
	String newresval=request.getParameter("newresval")==""?"0":request.getParameter("newresval").replace(",","").trim(); 
	String perfleet=request.getParameter("perfleet")==""?"0":request.getParameter("perfleet").trim(); 
	String fromdt=request.getParameter("fromdt")==""?"":request.getParameter("fromdt").trim();
	String todt=request.getParameter("todt")==""?"":request.getParameter("todt").trim();

	// System.out.println("process--->>>"+process+"---");  
	String extdocno=request.getParameter("extdocno")==""?"0":request.getParameter("extdocno").trim(); 
	String extnno=request.getParameter("extno")==""?"0":request.getParameter("extno").trim(); 

	String sql="",sqlsub="",sql1="",rowno="",proces="",upsql1="";
	String temp="";
	int val=0;
	 /*Submit */
		java.sql.Date flwpsqlDate=null;
	    if(!(flwpdate.equalsIgnoreCase("undefined"))&&!(flwpdate.equalsIgnoreCase(""))&&!(flwpdate.equalsIgnoreCase("0"))){
	    	flwpsqlDate=ClsCommon.changeStringtoSqlDate(flwpdate);
		}
	    java.sql.Date reqsqlDate=null;
	    if(!(reqdate.equalsIgnoreCase("undefined"))&&!(reqdate.equalsIgnoreCase(""))&&!(reqdate.equalsIgnoreCase("0"))){
	    	reqsqlDate=ClsCommon.changeStringtoSqlDate(reqdate);
		}
	    java.sql.Date extsqlDate=null;
	    if(!(exttilldate.equalsIgnoreCase("undefined"))&&!(exttilldate.equalsIgnoreCase(""))&&!(exttilldate.equalsIgnoreCase("0"))){
	    	extsqlDate=ClsCommon.changeStringtoSqlDate(exttilldate);
		}
	    java.sql.Date fromsqlDate=null;
	    if(!(fromdt.equalsIgnoreCase("undefined"))&&!(fromdt.equalsIgnoreCase(""))&&!(fromdt.equalsIgnoreCase("0"))){
	    	fromsqlDate=ClsCommon.changeStringtoSqlDate(fromdt);
		}
	    java.sql.Date tosqlDate=null;
	    if(!(todt.equalsIgnoreCase("undefined"))&&!(todt.equalsIgnoreCase(""))&&!(todt.equalsIgnoreCase("0"))){
	    	tosqlDate=ClsCommon.changeStringtoSqlDate(todt);
		}
	    
	    if(process.equalsIgnoreCase("1"))
	    {
	     upsql1="select rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where description='LA Extension Request' and process='Follow-Up')";  
			 ResultSet rs=stmt.executeQuery(upsql1);
			 while (rs.next())
			 {
				rowno=rs.getString("rowno"); 
			 }
				
			   sql="insert into gl_blagmt (date, rdocno, bibpid, fdate, remarks, userid, status)values(now(),'"+docno+"','"+rowno+"','"+flwpsqlDate+"','"+flwpremarks+"','"+session.getAttribute("USERID").toString()+"',3) ";

			 //System.out.println("followup=="+sql);
			 val= stmt.executeUpdate(sql);
			 if(val>0) { 
				 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','"+rdtype+"',now(),'"+session.getAttribute("USERID").toString()+"','A')";

				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);        
			
		}
	    }
			  else if(process.equalsIgnoreCase("2")){
				   String lano="";

					int extno=0;
					ResultSet rsmaxdoc=stmt.executeQuery("select coalesce(max(extno),0)+1 extno from gl_leaseext where   lano="+docno);
					while (rsmaxdoc.next()){
						extno=rsmaxdoc.getInt("extno");
						
					}
					/* ResultSet rsmaxdoc=stmt.executeQuery("select lano from gl_leaseext where lano='"+docno+"' ");
					if (rsmaxdoc.next()){
					
						sql="update gl_leaseext set  userid='"+session.getAttribute("USERID").toString()+"',edate=now(),totalrent='"+reqamt+"',extdate='"+extsqlDate+"',residualval='"+newresval+"',reqremarks='"+reqremarks+"',approvalstatus=0 where lano='"+docno+"'";
					}
					else{ */
						  sql="insert into gl_leaseext ( lano,extno, userid, edate, totalrent, extdate, residualval,reqremarks)values('"+docno+"','"+extno+"','"+session.getAttribute("USERID").toString()+"',now(),'"+reqamt+"','"+extsqlDate+"','"+newresval+"','"+reqremarks+"') ";

				//	}
					 val= stmts.executeUpdate(sql);

					
					// System.out.println("Extno=="+extno);

				// System.out.println("Request=="+sql);
				 if(val>0) { 
					 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','"+rdtype+"',now(),'"+session.getAttribute("USERID").toString()+"','A')";

					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
		}
	    
	    
	    
			  else if(process.equalsIgnoreCase("3")){
				  double amt=0.00;
				 String dates="",bpvno="",chequeno="",per_fleet="",rsdval="";
				  String lano="";

			
					ResultSet rsmaxdocno=stmt.executeQuery("select d.date,amount,bpvno,chequeno,l.perfleet,m.residualval from gl_leasepytcalcext d left join gl_leaseext m on m.srno=d.rdocno left join gl_lagmt l on l.doc_no=m.lano where rdocno='"+extdocno+"'");
					while (rsmaxdocno.next()){
						dates=rsmaxdocno.getString("date");
						bpvno=rsmaxdocno.getString("bpvno");
						chequeno=rsmaxdocno.getString("chequeno");
						amt=rsmaxdocno.getDouble("amount");
						perfleet=rsmaxdocno.getString("perfleet");
						rsdval=rsmaxdocno.getString("residualval");

					
						String strinsert="insert into gl_leasepytcalc(date,amount,bpvno,chequeno,rdocno,status)values('"+dates+"','"+amt+"','"+bpvno+"','"+chequeno+"','"+docno+"',3)";
						// System.out.println("ApproveInsert=="+strinsert);

						val= stmt1.executeUpdate(strinsert);
					}
						String newfromdt="";
					String strsel="select dateadd(todt,INTERVAL 1 DAY) as newfromdt from gl_leaseext where  lano='"+docno+"'and extno="+extnno+"-1 ";
					 System.out.println("leasetodt=="+strsel);
						ResultSet rssel=stmt.executeQuery(strsel);
						while (rssel.next()){
							newfromdt=rssel.getString("newfromdt");
						}
		
						String strupappr="update gl_leaseext set approvalstatus=1,fromdt='"+newfromdt+"',todt='"+tosqlDate+"' where lano='"+docno+"'and extno='"+extnno+"'and approvalstatus!=1 ";
						 System.out.println("strupappr=="+strupappr);
						
						val= stmt4.executeUpdate(strupappr);
					
						String strinsertagmt="update gl_lagmt set extno='"+extnno+"' where doc_no='"+docno+"' ";
						 System.out.println("ApproveInsertagmt=="+strinsertagmt);

						val= stmt3.executeUpdate(strinsertagmt);
					//	String strupveh="update gl_vehmaster set residual_val='"+rsdval+"'where fleet_no='"+perfleet+"' ";
						 //System.out.println("strupveh=="+strupveh);

					//	val= stmt4.executeUpdate(strupveh);
					
						
						
						 if(val>0) { 
							 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','"+rdtype+"',now(),'"+session.getAttribute("USERID").toString()+"','A')";
							 val= stmt3.executeUpdate(logsql);        
						 }
						
					
					
					// System.out.println("Extno=="+extno);
			 
		}
	    
	    
	    
	    
		 if(val>0){
			 temp="1";    
		 }
        
	 
	if(temp.equalsIgnoreCase("1")){  
		conn.commit();
	}
	 response.getWriter().print(temp);
	stmt.close();
	stmt1.close();

	conn.close();
}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
