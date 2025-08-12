<%@page import="java.util.ArrayList"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String brhid=request.getParameter("brchid");
String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
JSONObject objdata=new JSONObject();
Connection conn=null;
BufferedReader reader = request.getReader();
StringBuilder jsonBody = new StringBuilder();
String line;
while ((line = reader.readLine()) != null) {
	jsonBody.append(line);
}
String jsonString = jsonBody.toString();
	String result="0";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

	String cardb="";
	String getDBSQL = "SELECT COALESCE(carrental_db,'') db FROM my_comp WHERE STATUS=3";
	ResultSet rsgetDBSQL= stmt.executeQuery(getDBSQL);
	if(rsgetDBSQL.next()){
		cardb = rsgetDBSQL.getString("db");
	}
	
	JSONArray jsonArray = JSONArray.fromObject(jsonString);
	ArrayList<String> parsedArray = new ArrayList<String>();
	System.out.println(jsonArray.size());
    for (int i = 0; i < jsonArray.size(); i++) {
    	 JSONObject obj = jsonArray.getJSONObject(i);
    	 result="1";
    	 String docnos="";
    	 String vocnos="";
    	 String trnos="";
    	 String getDetails="SELECT IF(((SELECT method FROM "+cardb+"."+"gl_config WHERE field_nme='Yeardocno')=1),(SELECT CONCAT(1,1,DATE_FORMAT('2025-05-09', '%y'),LPAD(COALESCE(MAX(SUBSTRING(voc_no FROM 5 FOR 8))+1,1),5,0)) FROM "+cardb+"."+"gl_limoinvm  WHERE brhid="+brhid+"),(SELECT COALESCE((MAX(voc_no)+1),1) FROM "+cardb+"."+"gl_limoinvm WHERE brhid="+brhid+")) vocno , (SELECT (MAX(doc_no)+1) FROM "+cardb+"."+"gl_limoinvm) docno,(SELECT (MAX(trno)+1) FROM "+cardb+"."+"my_trno) trno"; 
    	 System.out.println(getDetails);
    	 ResultSet rsgetDetails=stmt.executeQuery(getDetails);
    	 if(rsgetDetails.next()){
    		 docnos=rsgetDetails.getString("docno");
    		 vocnos=rsgetDetails.getString("vocno");
    		 trnos=rsgetDetails.getString("trno");
    	 }
    	 System.out.println(trnos+" - "+ docnos+" - "+vocnos);
    	 String inserttrno = "INSERT INTO "+cardb+"."+"my_trno(trno,userno,trtype,brhid,edate)VALUES("+trnos+","+userid+",'LIN',"+brhid+",NOW())";
    	 System.out.println(inserttrno);
    	 int resulttr = stmt.executeUpdate(inserttrno);
    	 
    	 if(resulttr<=0){
    		 conn.close();
    		 result="0";
    	 }
    	 
    	 String insertinvmsql = "INSERT INTO "+cardb+"."+"gl_limoinvm (  `doc_no`,   `voc_no`,   `date`,   `brhid`,   `curid`,   `userid`,   `trno`,   `cldocno`,   `fromdate`,   `todate`,   `ledgernote`,   `invoicenote`,   `dtype`,   `manual`,   `status`,   `mastertotal`,   `limolpono`,   `limoevent`,   `mastervat`,   `masternettotal`,limoinvdocno, limoinvvocno) SELECT  "+docnos+",   voc_no ,   `date`,   `brhid`,   `curid`,   `userid`,   "+trnos+",   `cldocno`,   `fromdate`,   `todate`,   `ledgernote`,   `invoicenote`,   `dtype`,   `manual`,   `status`,   `mastertotal`,   `limolpono`,   `limoevent`,   `mastervat`,   `masternettotal`,doc_no,voc_no FROM gl_limoinvm WHERE doc_no="+obj.getString("docno")+" and trno="+obj.getString("trno");
    	 System.out.println(insertinvmsql);
 		 int resultinvm = stmt.executeUpdate(insertinvmsql); 
    	 if(resultinvm<=0){
    		 conn.close();
    		 result="0";
    	 }
    	 
    	 String insertinvdsql = "INSERT INTO "+cardb+"."+"gl_limoinvd (`rdocno`,   `guestno`,   `jobtype`,   `jobdocno`,   `bookdocno`,   `jobname`,   `total`,   `discount`,   `nettotal`,   `tarif`,   `nighttarif`,   `exkmchg`,   `exhrchg`,   `exnighthrchg`,   `fuelchg`,   `parkingchg`,   `otherchg`,   `greetchg`,   `vipchg`,   `boquechg`,   `exkm`,   `exhr`,   `exnighthr`,   `fuel`,   `setpercent`,   `vatpercent`,   `setvalue`,   `vatvalue`, limoguest,limorouteinfo,datentime) SELECT "+docnos+",   d.`guestno`,   d.`jobtype`,   d.`jobdocno`,   d.`bookdocno`,   d.`jobname`,   d.`total`,   d.`discount`,   d.`nettotal`,   d.`tarif`,   d.`nighttarif`,   d.`exkmchg`,   d.`exhrchg`,   d.`exnighthrchg`,   d.`fuelchg`,   d.`parkingchg`,   d.`otherchg`,   d.`greetchg`,   d.`vipchg`,   d.`boquechg`,   d.`exkm`,   d.`exhr`,   d.`exnighthr`,   d.`fuel`,   d.`setpercent`,  d.`vatpercent`,   d.`setvalue`,   d.`vatvalue` , m.guest, CONCAT('PU: : ',m.plocation,' ',m.paddress,' DO: : ',m.dlocation,' ',m.daddress) location, CONCAT(m.pickupdate,' ',m.pickuptime) times FROM gl_limoinvd d LEFT JOIN gl_limomanagement m  ON CONCAT(m.docno,' - ',m.job)=d.jobname  WHERE rdocno="+obj.getString("docno");
    	 System.out.println(insertinvdsql);
 		 int resultinvd = stmt.executeUpdate(insertinvdsql); 
    	 if(resultinvd<=0){
    		 conn.close();
    		 result="0";
    	 }
    	 
    	 String insertjvsql = "INSERT INTO "+cardb+"."+"my_jvtran (   `tr_no`,   `acno`,   `dramount`,   `rate`,   `curId`,   `out_amount`,   `duedate`,   `clearedon`,   `trtype`, `id`,   `ref_row`,   `brhid`,   `description`,   `yrId`,   `cldocno`,   `date`,   `dTYPE`,   `stkmove`,   `ldramount`,   `doc_no`,   `LAGE`,   `ref_detail`,   `lbrrate`,   `status`,   `category`,   `refTrNo`,   `rdocno`,   `rtype`,   `bankreconcile`,   `prep`,   `costtype`,   `costcode`) SELECT    "+trnos+",   `acno`,   `dramount`,   `rate`,   `curId`,   `out_amount`,   `duedate`,   `clearedon`,   `trtype`, `id`,   `ref_row`,   `brhid`,   `description`,   `yrId`,   `cldocno`,   `date`,   `dTYPE`,   `stkmove`,   `ldramount`,   "+docnos+",   `LAGE`,   `ref_detail`,   `lbrrate`,   `status`,   `category`,   `refTrNo`, rdocno,   `rtype`,   `bankreconcile`,   `prep`,   `costtype`,   `costcode` FROM my_jvtran WHERE tr_no="+obj.getString("trno");
 		 System.out.println(insertjvsql);
    	 int resultjv = stmt.executeUpdate(insertjvsql); 
    	 if(resultjv<=0){
    		 conn.close();
    		 result="0";
    	 }	 
    }
    
    if(result.equalsIgnoreCase("1")){
    	conn.commit();
    }
}
catch(Exception e){
	result="0";
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>