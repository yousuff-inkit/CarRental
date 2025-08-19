<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<% 
JSONArray countarray=new JSONArray();
Connection conn=null;
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
try{

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	if(mode.equalsIgnoreCase("1")){
		String strsql="SELECT 1 srno,'Rental Invoice' description,COUNT(*) itemcount FROM gl_ragmt WHERE clstatus=0 AND STATUS<>7 AND IF(advchk=1,invdate,invtodate)<=CURDATE() UNION ALL"+
		" SELECT 2 srno,'Lease Invoice' description,COUNT(*) itemcount FROM gl_lagmt WHERE clstatus=0 AND STATUS<>7 AND IF(adv_chk=1,invdate,invtodate)<=CURDATE() UNION ALL"+
		" SELECT 3 srno,'Damages' description,COUNT(*) itemcount FROM gl_vinspm insp WHERE (insp.amount>0 OR insp.fine)>0 AND COALESCE(insp.invno,0)=0 AND insp.status<>7 UNION ALL"+
		" SELECT 4 srno,'Rental Delivery' description,COUNT(*) itemcount FROM gl_ragmt WHERE clstatus=0 AND STATUS<>7 AND delivery=1 AND delstatus=0 UNION ALL"+
		" SELECT 5 srno,'Lease Delivery' description,COUNT(*) itemcount FROM gl_lagmt WHERE clstatus=0 AND STATUS<>7 AND delivery=1 AND delstatus=0";
		ResultSet rs=conn.createStatement().executeQuery(strsql);
		countarray=objcommon.convertToJSON(rs);
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(countarray+"");
%>
