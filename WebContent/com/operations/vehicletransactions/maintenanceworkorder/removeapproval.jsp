<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%  
String docval=request.getParameter("docval")==null?"":request.getParameter("docval");
//System.out.println("doc_val value=============="+docval);


Connection conn =null;
int val=0,psstatus=0;

 try
{
	  ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	  Statement stmt = conn.createStatement ();
 	
	  
	 String check= "select psstatus from gl_vmcostm where doc_no="+docval+" ";
	// System.out.println("==========check psstatus======"+check);
	 ResultSet rs = stmt.executeQuery(check);   
	 while(rs.next()) {  
		 psstatus=rs.getInt("psstatus");  
		}  
	 
	  if (psstatus==0){
	  String sqls = "update gl_vmcostm set apstatus=0 where doc_no="+docval+"";
	  val =stmt.executeUpdate(sqls);
	  //System.out.println("update query val======"+val);
	  //System.out.println("update query======"+sqls);
	  stmt.close();
    }else{
		  val=-1;
	  }
    response.getWriter().print(val);
   
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 