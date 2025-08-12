<%@page import="com.freeware.gridtag.RowNumColumn"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
String qotno=request.getParameter("docno")==null?"0": request.getParameter("docno").toString();
String srno=request.getParameter("rowno")==null?"0": request.getParameter("rowno").toString();
ClsConnection clsConnection = new ClsConnection();
Connection con=null;
int id;
try{
	con=clsConnection.getMyConnection();
	Statement st=con.createStatement();
	String sql="update my_checklistdet skc left join my_fileattach f on f.doc_no=skc.qotno and skc.attach=f.filename and skc.brhid=f.brhid set skc.status=7, skc.attach='',skc.path='',f.status=7 where skc.qotno='"+qotno+"' and skc.rowno='"+srno+"'";
	System.out.println(sql);
	id=st.executeUpdate(sql);
	System.out.println("ID is :"+id);
	response.getWriter().print(id+"####"+"####"+id);
	con.close();
	st.close();
	System.out.println("SRN on delete :"+srno);
}catch(Exception e){
	e.printStackTrace();
	con.close();
}



%>