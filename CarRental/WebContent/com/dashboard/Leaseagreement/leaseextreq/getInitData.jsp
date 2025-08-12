<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONArray"%> 
<%@page import="com.connection.ClsConnection"%>
<%
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection(); 
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	if(mode.equalsIgnoreCase("1")){
		JSONArray statusarray=new JSONArray();
		String strsql="select srno,process from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Extension Request' and status=1)";
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("srno",rs.getString("srno"));
			objtemp.put("process",rs.getString("process"));
			statusarray.add(objtemp);
		}
		objdata.put("statusdata",statusarray);
	}
	else if(mode.equalsIgnoreCase("2")){
		JSONArray statusarray=new JSONArray();
		String agmtno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
		String extdocno=request.getParameter("extdocno")==""?"0":request.getParameter("extdocno");

		String strsql="select format(round(asset.dramount*-1,2),2) depramt,date_format(asset.date,'%d.%m.%Y') deprdate,format(round(pyttotalrent,2),2) pyttotalrent,pytmonthno pytduration,format(round(veh.residual_val,2),2) residualval,format(round(a.extreqamt,2),2) extreqamt,format(round(a.extnewresval,2),2) extnewresval,date_format(a.extdate,'%d.%m.%Y') extdate  from gl_lagmt agmt "+
		" left join gl_vehmaster veh on (agmt.tmpfleet=veh.fleet_no or agmt.perfleet=veh.fleet_no and veh.statu<>7 and veh.fstatus='L')"+
		" left join (select max(sr_no) maxsrno,fleet_no from gc_assettran where ttype='VPO' group by fleet_no) maxasset on veh.fleet_no=maxasset.fleet_no"+
		" left join gc_assettran asset on maxasset.maxsrno=asset.sr_no left join (select totalrent extreqamt,residualval extnewresval,extdate,lano from gl_leaseext where srno='"+extdocno+"' ) a  on a.lano= agmt.doc_no where agmt.doc_no="+agmtno;
		//System.out.println(strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		String pyttotalrent="0.0",residualvalue="0.0",depramt="0.0",deprdate="",extreqamt="0.0",extnewresval="0.0",extdate="";
		int pytduration=0;
		while(rs.next()){
			pyttotalrent=rs.getString("pyttotalrent");
			pytduration=rs.getInt("pytduration");
			residualvalue=rs.getString("residualval");
			depramt=rs.getString("depramt");
			deprdate=rs.getString("deprdate");
			extreqamt=rs.getString("extreqamt");
			extnewresval=rs.getString("extnewresval");
			extdate=rs.getString("extdate");
		}
		objdata.put("pyttotalrent",pyttotalrent);
		objdata.put("pytduration",pytduration);
		objdata.put("residualvalue",residualvalue);
		objdata.put("depramt",depramt);
		objdata.put("deprdate",deprdate);
		objdata.put("extreqamt",extreqamt);
		objdata.put("extnewresval",extnewresval);
		objdata.put("extdate",extdate);

	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>