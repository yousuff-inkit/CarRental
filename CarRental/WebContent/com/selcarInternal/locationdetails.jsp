<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String brhid=request.getParameter("branch");
	//String brhid = session.getAttribute("BRANCHID").toString(); 
	System.out.println("brnch===="+brhid);
	
	
	String strSql = "select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brhid+" order by m.doc_no asc";
	
	System.out.println("--locatioset--"+strSql);
	ResultSet rs=stmt.executeQuery(strSql);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("location");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("location");
		}
		i++;
		
	}
	System.out.println("location:"+value);

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(value);
%>