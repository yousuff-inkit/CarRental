<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
java.sql.Date showdate=null;
String strshowdate="";
String showtime="";
int showagmtdate=0;
JSONObject objcollect=new JSONObject();

try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int delcal=0,delcheck=0,delstatus=0;
	String strSql = "select (select method from gl_config where field_nme='delcal') delcal,(select method from gl_config where field_nme='closecal') closecal,"+
			" (select invdate from gl_lagmt where doc_no="+agmtno+") invdate";
	ResultSet resultSet = stmt.executeQuery(strSql);
	while(resultSet.next()){
		delcal=resultSet.getInt("delcal");
	}
	String	strdelcheck="select delstatus,delivery from gl_lagmt where doc_no="+agmtno;
	ResultSet rsdelcheck=stmt.executeQuery(strdelcheck);
	if(rsdelcheck.next()){
		if(rsdelcheck.getInt("delivery")==1){
			delcheck=rsdelcheck.getInt("delstatus");
			delstatus=rsdelcheck.getInt("delstatus");
		}
		else if(rsdelcheck.getInt("delivery")==0){
			delcheck=1;
		}
	}
	java.sql.Date odate=null,deldate=null;
	String otime="",deltime="";
	String stragmtsql="select outdate,outtime,outkm,outfuel from gl_lagmt where doc_no="+agmtno;
	ResultSet rsagmt=stmt.executeQuery(stragmtsql);
	while(rsagmt.next()){
		odate=rsagmt.getDate("outdate");
		otime=rsagmt.getString("outtime");
	}

	if(delstatus==1){
		String strmovsql="select mov.din,mov.tin,mov.kmin,mov.fin from gl_vmove mov left join gl_lagmt agmt "+
					" on (mov.rdocno=agmt.doc_no and mov.rdtype='LAG') where mov.rdtype='LAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0  and exchng=0 and custno=0 ";
		ResultSet rsmov=stmt.executeQuery(strmovsql);
		while(rsmov.next()){
			deldate=rsmov.getDate("din");
			deltime=rsmov.getString("tin");
		}
	}
	
	if(deldate!=null && delcal==0){
		//Delivery Date And Time
		showdate=deldate;
		showtime=deltime;
	}
	else{
		//Agreement Date And Time
		showdate=odate;
		showtime=otime;
	}
	ResultSet rsconvert=stmt.executeQuery("select (select date_format('"+showdate+"','%d.%m.%Y'))strdate,(select method from gl_config where field_nme='ShowAgmtDate') showagmtdate ");
	while(rsconvert.next()){
		strshowdate=rsconvert.getString("strdate");
		showagmtdate=rsconvert.getInt("showagmtdate");
	}
	String strsql="select bindate sqlindate,datee sqlcollectdate,replace(round(km,0),',','') collectkm,round(fuel,3) collectfuel,"+
			" date_format(datee,'%d.%m.%Y') collectdate,times collecttime,replace(round(binkm,0),',','') inkm,"+
			" round(binfuel,3) infuel,date_format(bindate,'%d.%m.%Y') indate,bintime intime from"+
			" an_acollection where agmtno="+agmtno+" and agmttype='LAG'";
		//	System.out.println("an_acollection query---"+strsql);
			ResultSet rscollect=stmt.executeQuery(strsql);
			int collectstatus=0;
			int instatus=0;
			while(rscollect.next()){
				if(rscollect.getDate("sqlcollectdate")!=null){
					collectstatus=1;
					objcollect.put("collectkm",rscollect.getString("collectkm"));
					objcollect.put("collectfuel",rscollect.getString("collectfuel"));
					objcollect.put("collectdate",rscollect.getString("collectdate"));
					objcollect.put("collecttime",rscollect.getString("collecttime"));	
				}
				if(rscollect.getDate("sqlindate")!=null){
					instatus=1;
					objcollect.put("inkm",rscollect.getString("inkm"));
					objcollect.put("infuel",rscollect.getString("infuel"));
					objcollect.put("indate",rscollect.getString("indate"));
					objcollect.put("intime",rscollect.getString("intime"));
				}
				
			}
			
			String strpickup="select agmtno,pdate sqldate,date_format(pdate,'%d.%m.%Y') pdate,ptime,pkm,pfuel from gl_vehpickup p where p.status=3 and agmttype='LAG' and agmtno="+agmtno;
			//System.out.println("pickupdate query------"+strpickup);
			ResultSet rspickup=stmt.executeQuery(strpickup);
			int pickupstatus=0;
			while(rspickup.next()){
				if(rspickup.getInt("agmtno")>0){
					pickupstatus=1;
					objcollect.put("pdate",rspickup.getDate("sqldate")+"");
					objcollect.put("ptime",rspickup.getString("ptime"));
					objcollect.put("pkm", rspickup.getString("pkm"));
					objcollect.put("pfuel",rspickup.getString("pfuel"));
				}
			}
			objcollect.put("pickupstatus",pickupstatus);
			objcollect.put("collectstatus",collectstatus);
			objcollect.put("instatus",instatus);

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(strshowdate+"::"+showtime+"::"+showagmtdate+"::"+objcollect);
%>