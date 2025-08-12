<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%

String docno=request.getParameter("doc_no")==null?"0":request.getParameter("doc_no");
String rentaltype=request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype");


Connection conn = null;
ClsConnection objconn=new ClsConnection();
	try{
		conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select fleet_no,tdocno from gl_ragmt where doc_no='"+docno+"'";
	ResultSet rs = stmt.executeQuery(strSql);
int fleetno=0;
int tdocno=0;
	if(rs.next()) {
		fleetno=rs.getInt("fleet_no");
		tdocno=rs.getInt("tdocno");
  		} 
	//id=rental.substring(0, rental.length()-1);
	int gid=0;
	String conv="";
	if(fleetno!=0 && tdocno!=0 ){
		String veSql = "select vgrpid from gl_vehmaster where fleet_no='"+fleetno+"'";
		ResultSet vehrs = stmt.executeQuery(veSql);
		if(vehrs.next()){
			gid=vehrs.getInt("vgrpid");
		}
	}
	int ulvl=0;
	String userid=session.getAttribute("USERID").toString();
	String ursSql = "select ulevel from my_user where doc_no='"+userid+"'";
	ResultSet usrrs = stmt.executeQuery(ursSql);
	if(usrrs.next()){
		ulvl=usrrs.getInt("ulevel");
	}
	System.out.println("rentaltype===>"+rentaltype);
	int discount=0;
	if(ulvl!=0){
		String sqlon = "";
		if(!rentaltype.equals("")){
			sqlon+="  and m2.rentaltype='"+rentaltype+"'";   
		}
		
		String disSql = "select case when u.ulevel=1 then m1.disclevel1 when u.ulevel=2 then m1.disclevel2 when u.ulevel=3 then m1.disclevel3 else 0 end as 'disclevel' "
				+ " from gl_tarifm M inner join gl_tarifd m1 on m.doc_no=m1.doc_no  right join gl_tlistm m2 on m1.renttype=m2.rentaltype "+sqlon+" "
				+ "left join my_user u on u.doc_no='"+userid+"' where m1.gid='"+gid+"' and m2.status=1 and m.doc_no='"+tdocno+"' order by m2.doc_no";
		
		//System.out.println("disSql===>"+disSql);   
		ResultSet disrs = stmt.executeQuery(disSql);
		if(disrs.next()){
			discount=disrs.getInt("disclevel");
		}
	}
	stmt.close();
	conn.close();
	System.out.println("discount===>"+discount);
	response.getWriter().print(discount);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>