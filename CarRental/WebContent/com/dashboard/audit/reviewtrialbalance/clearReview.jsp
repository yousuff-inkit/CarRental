<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>

<%

ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;
String sql="";
try{
	
	System.out.println("Started:");

	conn=ClsConnection.getMyConnection();
	Statement stmt=conn.createStatement();
	System.out.println("Executing:");

	sql="update MY_ACBOOK a left join my_clcatm b on a.catid=b.doc_no and a.dtype=b.dtype set a.acc_group=b.acc_group WHERE (a.ACC_GROUP IS NULL or a.ACC_GROUP='0') ;";
	System.out.println("SQL 1 :"+sql);

	stmt.execute(sql);
	sql="update MY_ACBOOK A LEFT JOIN MY_HEAD H ON H.doc_no=A.acno set H.GRPNO=a.ACC_GROUP WHERE (H.GRPNO IS NULL or H.GRPNO='0')  AND A.STATUS=3;";
	System.out.println("SQL 2 :"+sql);

	stmt.execute(sql);

	sql="UPDATE MY_ACBOOK A LEFT JOIN MY_CLCATM C ON A.CATID=C.DOC_NO LEFT JOIN MY_HEAD H ON H.CLDOCNO=A.CLDOCNO and h.dtype=a.dtype SET H.GRPNO=C.ACC_GROUP WHERE (H.GRPNO IS NULL or H.GRPNO='0') AND A.DTYPE='CRM'";
	System.out.println("SQL 3 :"+sql);

	stmt.execute(sql);

	sql="UPDATE MY_HEAD SET alevel=concat('.',GRPNO,'.',doc_no) WHERE m_s=0 and  (ALEVEL  IS NULL or ALEVEL='0')";
	System.out.println("SQL 4 :"+sql);

	stmt.execute(sql);

	sql="update my_head set alevel=concat('.',grpno,'.',doc_no) where m_s=0 and alevel!=concat('.',grpno,'.',doc_no)";
	System.out.println("SQL 5 :"+sql);

	stmt.execute(sql);

	sql="UPDATE my_jvtran SET ID=1 where dramount>0 and id<0";
	System.out.println("SQL 6 :"+sql);

	stmt.execute(sql);

	sql="UPDATE my_jvtran SET ID=-1 where dramount<0 and id>0";
	System.out.println("SQL 7 :"+sql);

	stmt.execute(sql);

	sql="update my_head h inner join my_agrp a on h.den=a.fi_id set h.gr_type=a.grno  where h.gr_type!=a.grno";
	System.out.println("SQL 8 :"+sql);

	stmt.execute(sql);

	sql="delete c.* from my_jvtran j left join my_costtran c  on j.tranid = c.tranid where j.status=7 and (c.tr_no is not null or c.tr_no='0')";
	System.out.println("SQL 9 :"+sql);

	stmt.execute(sql);
	sql="delete c.* from my_jvtran j left join my_costtran c  on j.tranid = c.tranid left join my_prepm p on p.tranid=j.tranid where j.status=3 and j.costtype=0 and c.tr_no is not null and (p.tranid is null or p.tranid='0')";
	System.out.println("SQL 10 :"+sql);

	stmt.execute(sql);
	conn.close();
	stmt.close();

	response.getWriter().print(1);	
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}


%>