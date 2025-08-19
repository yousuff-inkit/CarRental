<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon ClsCommon=new ClsCommon();

	String remarks=request.getParameter("remarks");
	String processid=request.getParameter("processid");
	String process=request.getParameter("process");
	String docno=request.getParameter("docno");
	java.sql.Date sqlDate=null;


	int val=0;
	int count = 0;
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsqlsearch = "select count(*) count from my_cdmprocess where rdocno="+docno;
	ResultSet rs = stmt.executeQuery(strsqlsearch);
	if(rs.next()){
		count=rs.getInt("count");
	}
	
	if(count>0){
		String strsql="update my_cdmprocess set processid="+processid+", process='"+process+"', remarks='"+remarks+"' where rdocno="+docno+"";
		System.out.println(strsql);
		val= stmt.executeUpdate(strsql);
		if(val>0){
			String strLogSql = "INSERT INTO my_cdmbilog (rdocno,DATE,userid,brchid,description)VALUES("+docno+",now(),'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"', 'Updated RTA Process to - "+process+"')";
			val= stmt.executeUpdate(strLogSql);	
		}
	} else {
		String strsql="Insert into my_cdmprocess (rdocno, processid, process, remarks) values ("+docno+", "+processid+", '"+process+"','"+remarks+"')";
		System.out.println(strsql);
		val= stmt.executeUpdate(strsql);
		if(val>0){
			String strLogSql = "INSERT INTO my_cdmbilog (rdocno,DATE,userid,brchid,description)VALUES("+docno+",now(),'"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"', 'Inserted RTA Process to - "+process+"')";
			val= stmt.executeUpdate(strLogSql);	
		}
	}
	
	
	
	if(val>0){
		 conn.commit();
	}
	 response.getWriter().print(val);

	 stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
}finally{
	   conn.close();
}
	%>
