<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;
try{	
String strdocarray=request.getParameter("docarray")==null?"":request.getParameter("docarray");
ArrayList<String> docarray=new ArrayList<>();
if(strdocarray.contains(",")){
	for(int i=0;i<strdocarray.split(",").length;i++){
		docarray.add(strdocarray.split(",")[i]);
	}
}
else{
	docarray.add(strdocarray);
}

conn=ClsConnection.getMyConnection();
Statement stmt=conn.createStatement();
int a=1;
for(int i=0;i<docarray.size();i++){
	conn.setAutoCommit(false);
	String trno=docarray.get(i).split("::")[0];
	String dtype=docarray.get(i).split("::")[1];
	String docno=docarray.get(i).split("::")[2];
	String brhid=docarray.get(i).split("::")[3];
	String strsql="";
	if(dtype.trim().equalsIgnoreCase("INV") || dtype.trim().equalsIgnoreCase("INS") || dtype.trim().equalsIgnoreCase("INT")){
		strsql="update gl_invm set dispatch=1 where status=3 and tr_no="+trno;
	}
	else if(dtype.trim().equalsIgnoreCase("CNO") || dtype.trim().equalsIgnoreCase("TCN")){
		strsql="update my_cnot set dispatch=1 where status=3 and tr_no="+trno;
	}
	int val=stmt.executeUpdate(strsql);
	if(val>0){
		String upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+brhid+"','BIVD',now(),'"+session.getAttribute("USERID").toString()+"','E')";
		int logval=stmt.executeUpdate(upsql);
		if(logval>0){
			conn.commit();
		}
		else{
			a=0;
			break;
		}
	}
}
response.getWriter().write(a+"");

}
catch(Exception e1){
	e1.printStackTrace();
}
finally{
	conn.close();
}

%>
  
