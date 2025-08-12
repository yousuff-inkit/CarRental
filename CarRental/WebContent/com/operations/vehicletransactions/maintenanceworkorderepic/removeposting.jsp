<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsApplyDelete" %>

<%  
String docval=request.getParameter("docval")==null?"":request.getParameter("docval");
//System.out.println("doc_val value=============="+docval);


Connection conn =null;
int val=0,reftrno=0;
int trno=0;

 try
{
	 ClsApplyDelete  DAO =new ClsApplyDelete ();
	  ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	  Statement stmt = conn.createStatement ();
	  Statement stmt1 = conn.createStatement ();
	
	  
	  String strsql="select trno from gl_vmcostm where doc_no="+docval+" "; 
		//System.out.println("strsql==="+strsql);  
		ResultSet rs = stmt.executeQuery(strsql);         
		while(rs.next()) {  
			trno=rs.getInt("trno");  
		}  
 	
		  DAO.getFinanceApplyDelete(conn,trno);
          
	/* 	String strsql1="select reftrno from my_jvtran  where tr_no= "+trno+" "; 
			System.out.println("strsql==="+strsql);  
			ResultSet rs1 = stmt1.executeQuery(strsql1);         
			while(rs1.next()) {  
				reftrno=rs1.getInt("reftrno");  
			}   */
			
			String vmcostm="update gl_vmcostm set trno=0,psstatus=0 where doc_no="+docval+" ";
			val =stmt.executeUpdate(vmcostm);
	         
            String sqls = "update my_jvma set status=7 where tr_no= "+trno+" ";
	        val =stmt.executeUpdate(sqls);
	         
	        String sqls2 =" update  my_jvtran set status=7 where tr_no= "+trno+" ";
            val =stmt.executeUpdate(sqls2);
            
            
	        
	// System.out.println("update query val======"+val);
	// System.out.println("update query vmcostm======"+vmcostm);
	// System.out.println("update query jvma======"+sqls);
	// System.out.println("update query jvtran======"+sqls2);
	 	
	  
	response.getWriter().print(val);
    stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 