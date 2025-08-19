<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

String txttotrno=request.getParameter("txttotrno");

Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int clone=0;
	Statement stmt=conn.createStatement();
	String strsql="select posttrno from gl_rentreceipt where posttrno='"+txttotrno+"'";
	//System.out.println("configval============"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		if(rs.getInt("posttrno")>0){
			clone=1;
			break;
		}
	}
	//System.out.println("clone===="+clone);
	response.getWriter().print(clone);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>