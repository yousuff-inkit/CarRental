<%@page import="com.opensymphony.xwork2.util.TextParseUtil.ParsedValueEvaluator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;

try{

    conn = ClsConnection.getMyConnection();
    Statement stmt = conn.createStatement();
    Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    Statement stmt3 = conn.createStatement();
    Statement stmt4 = conn.createStatement();
    Statement stmt5 = conn.createStatement();
    
	int val=0;
	
	String brsql = "select doc_no,branchname from my_brch order by doc_no;";
	ResultSet rsbr = stmt.executeQuery(brsql);
	ResultSet rsbr2 = stmt2.executeQuery(brsql);
	
	while(rsbr.next()){
		while(rsbr2.next()){
			
			int brdocno = rsbr.getInt("doc_no");
			int brdocno2 = rsbr2.getInt("doc_no");
			
			if(brdocno < brdocno2){
				String branchname = rsbr.getString("branchname");
				String branchname2 = rsbr2.getString("branchname");
				
				int docno = 0;
				
				String docsql="select max(doc_no)+1 doc_no from my_head;";
				ResultSet rsdoc = stmt3.executeQuery(docsql); 
				while(rsdoc.next()){
					docno = rsdoc.getInt("doc_no");
				}
				
				String headsql="INSERT INTO my_head (Description, M_S, DEN, CURID, RATE, DR, DOC_NO, date, atype, Account, dtype, alevel, grpno, grplevel, gr_type, agroup, lApply, cmpid, new_docno, old_docno, olddocno)" 
						+" VALUES ('INTER BRANCH "+branchname+" "+branchname2+" A/C', 0, '300', 1, 1.00000, 1, "+docno+", curdate(), 'GL', '"+docno+"', 'GEN', '.1133."+docno+"', 1133, 2, 1, 1, 0, 0, 0, 0, 0);";
				val= stmt4.executeUpdate(headsql); 
				
				if(val>0){
					String inrsql="insert into my_intr(doc_no, br1,br2) values ("+docno+","+brdocno+","+brdocno2+");";
					val= stmt5.executeUpdate(inrsql); 
				}
				
			}
		}
		rsbr2.first();
	}
	 
	stmt.close();
	stmt2.close();
	stmt3.close();
	stmt4.close();
	stmt5.close();
 	conn.close();
	 	  
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	
%>
