<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
	ClsConnection ClsConnection = new ClsConnection();

    String agmttype = request.getParameter("agmttype")==null || request.getParameter("agmttype").equals("")?"0":request.getParameter("agmttype");
	String hiddocno = request.getParameter("hiddocno")==null || request.getParameter("hiddocno").equals("")?"0":request.getParameter("hiddocno");
	String hidcldocno = request.getParameter("hidcldocno")==null || request.getParameter("hidcldocno").equals("")?"0":request.getParameter("hidcldocno");
	String hidacno = request.getParameter("hidacno")==null || request.getParameter("hidacno").equals("")?"0":request.getParameter("hidacno");
	String hiddrid = request.getParameter("hiddrid")==null || request.getParameter("hiddrid").equals("")?"0":request.getParameter("hiddrid");
	Connection conn = null;  
	int val = 0,val1=0,val2=0,val3=0,val4=0,val5=0;
 	try{
 		
 		conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		
		if(agmttype.equalsIgnoreCase("RAG")){
	
 String strSql = "UPDATE gl_ragmt r "
			+" LEFT JOIN gl_rdriver dr ON dr.rdocno = r.doc_no "
			+" set r.cldocno ="+hidcldocno+", r.acno="+hidacno+",dr.cldocno ="+hidcldocno+",dr.drid="+hiddrid+" WHERE r.doc_no ="+hiddocno+" " ;
 val = stmt.executeUpdate(strSql); 
 
 String strSql1="UPDATE gl_invm  inv  left join gl_ragmt r on inv.rano=r.doc_no and inv.ratype='RAG'  "
			+" INNER JOIN my_jvtran j ON j.tr_no = inv.tr_no "
			+" set  inv.cldocno ="+hidcldocno+",inv.acno="+hidacno+",j.acno="+hidacno+",j.cldocno ="+hidcldocno+" "
					+" WHERE inv.rano ="+hiddocno+" and inv.ratype='RAG' AND j.cldocno != 0 "; 
 val1 = stmt.executeUpdate(strSql1);
 
 String strSql2="UPDATE gl_vmove set emp_id="+hidacno+" where rdocno="+hiddocno+" and rdtype='RAG' and emp_type='CRM' ";
 val2 = stmt.executeUpdate(strSql2);
 
 String strSql3="UPDATE  gl_salik  set emp_id="+hidacno+" where RA_NO="+hiddocno+" and rtype in('RM','RA','RD','RW') and EMP_TYPE='CRM';  ";
 val3 = stmt.executeUpdate(strSql3);
 
 String strSql4="UPDATE  gl_traffic  set emp_id="+hidacno+" where RA_NO="+hiddocno+" and rtype in('RM','RA','RD','RW') and EMP_TYPE='CRM';  ";
 val4 = stmt.executeUpdate(strSql4);
 
 String strSql5="UPDATE gl_rentreceipt set cldocno ="+hidcldocno+" where aggno="+hiddocno+" and rtype='RAG'";
 val5 = stmt.executeUpdate(strSql5);
 
 //System.out.println("strSql---"+strSql+"----strSql1---"+strSql1+"----strSql2-------"+strSql2+"-----strSql3-----"+strSql3+"----strSql4--------"+strSql4+"-----strSql5----"+strSql5);		
 
		}	else if(agmttype.equalsIgnoreCase("LAG")){
	
String strSql = "UPDATE gl_lagmt r "
					+" LEFT JOIN gl_ldriver dr ON dr.rdocno = r.doc_no "
					+" set r.cldocno ="+hidcldocno+", r.acno="+hidacno+",dr.cldocno ="+hidcldocno+",dr.drid="+hiddrid+" WHERE r.doc_no ="+hiddocno+" " ;
val = stmt.executeUpdate(strSql); 
		 
String strSql1="UPDATE gl_invm  inv  left join gl_lagmt r on inv.rano=r.doc_no and inv.ratype='LAG'  "
					+" INNER JOIN my_jvtran j ON j.tr_no = inv.tr_no "
					+" set  inv.cldocno ="+hidcldocno+",inv.acno="+hidacno+",j.acno="+hidacno+",j.cldocno ="+hidcldocno+" "
							+" WHERE  inv.rano ="+hiddocno+" and inv.ratype='LAG' AND j.cldocno != 0 "; 
val1 = stmt.executeUpdate(strSql1);
		 
String strSql2="UPDATE gl_vmove set emp_id="+hidacno+" where rdocno="+hiddocno+" and rdtype='LAG' and emp_type='CRM' ";
val2 = stmt.executeUpdate(strSql2);
		 
String strSql3="UPDATE  gl_salik  set emp_id="+hidacno+" where RA_NO="+hiddocno+" and rtype ='LA' and EMP_TYPE='CRM';  ";
val3 = stmt.executeUpdate(strSql3);
		 
String strSql4="UPDATE  gl_traffic  set emp_id="+hidacno+" where RA_NO="+hiddocno+" and rtype ='LA' and EMP_TYPE='CRM';  ";
val4 = stmt.executeUpdate(strSql4);

String strSql5="UPDATE gl_rentreceipt set cldocno ="+hidcldocno+" where aggno="+hiddocno+" and rtype='LAG'";
val5 = stmt.executeUpdate(strSql5);

//System.out.println("strSql---"+strSql+"----strSql1---"+strSql1+"----strSql2-------"+strSql2+"-----strSql3-----"+strSql3+"----strSql4--------"+strSql4+"-----strSql5----"+strSql5);		
			}
		
if(val>0){
			
			conn.commit();
		}
if(val1>0){
			
			conn.commit();
		}
if(val2>0){
	
	conn.commit();
}
if(val3>0){
	
	conn.commit();
}
if(val4>0){
	
	conn.commit();
}
if(val5>0){
	
	conn.commit();
}
		//response.getWriter().print(val);
response.getWriter().print(val + val1 + val2 + val3 + val4 + val5);
//System.out.println("VALSYS----"+"---"+val +"---"+ val1 +"---"+ val2 +"---"+ val3 + "---"+val4 +"---"+ val5);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 	}
 	finally{
 		conn.close();
 	}
	%>