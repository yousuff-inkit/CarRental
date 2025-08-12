<%@page import="java.util.ArrayList"%>
<%@page import="com.limousine.limobooking.ClsLimoBookingDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();  
Connection conn=null;
try{
	int val=0;
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	ClsLimoBookingDAO clsLimoBookingDAO=new ClsLimoBookingDAO();
	ArrayList<String> transferarray=new ArrayList<String>();
	ArrayList<String> hoursarray=new ArrayList<String>();
	String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
	String data = request.getParameter("data");
	String bookdocno = request.getParameter("bookdocno");
	String type = request.getParameter("type")==null||request.getParameter("type").equalsIgnoreCase("")||request.getParameter("type").equalsIgnoreCase("undefined")?"0":request.getParameter("type");
    Statement stmt=conn.createStatement();
    String sqlgett ="";
    String sqlgeth ="";
	
    sqlgett = "SELECT doc_no, bookdocno, docname, Date_format(pickupdate,'%d.%m.%Y') pickupdate, pickuptime, pickuplocid, pickupadress, dropfflocid, dropoffaddress, brandid, modelid, tarifdocno, gid, nos, chkothersrvc, STATUS, assignstatus, tarifdetaildocno, transferbranch, assignedfleet, assigneddriver, masterstatus, trno, transfertype, estdist, esttime, tarif, exdistrate, extimerate, guestdetails, pax, vehdetails, detailupdate, remarks, refno, assignedvendor, otherdetails, triptype, triptypedocno, triptypetax FROM gl_limobooktransfer WHERE bookdocno="+bookdocno+"";
    ResultSet rs = stmt.executeQuery(sqlgett);
    String datajoint = "";
    while(rs.next()){
	  	datajoint += rs.getString("docname")+"::"+rs.getString("pickupdate")+"::"+rs.getString("pickuptime")+"::"+rs.getString("pickuplocid")+"::"+rs.getString("pickupadress")+"::"+rs.getString("dropfflocid")+"::"+rs.getString("dropoffaddress")+"::"+rs.getString("brandid")+"::"+rs.getString("modelid")+"::"+rs.getString("nos")+"::"+rs.getString("tarifdocno")+"::"+rs.getString("chkothersrvc")+"::"+rs.getString("gid")+"::"+rs.getString("tarifdetaildocno")+"::"+rs.getString("transfertype")+"::"+rs.getString("estdist")+"::"+rs.getString("esttime")+"::"+rs.getString("tarif")+"::"+rs.getString("exdistrate")+"::"+rs.getString("extimerate")+"::"+rs.getString("triptype")+"::"+rs.getString("pax")+",";
    }
	sqlgeth = "SELECT doc_no, bookdocno, docname,Date_format(pickupdate,'%d.%m.%Y') pickupdate, pickuptime, pickuplocid, pickupaddress, brandid, modelid, nos, tarifdocno, chkothersrvc, gid, blockhrs, tarifdetaildocno, days, transfertype, tarif, exhrrate, nighttarif, nightexhrrate, masterstatus FROM gl_limobookhours WHERE bookdocno="+bookdocno+"";
	rs = stmt.executeQuery(sqlgeth);
	String datajoinh="";
	while(rs.next()){
		datajoinh += rs.getString("docname")+"::"+rs.getString("pickupdate")+"::"+rs.getString("pickuptime")+"::"+rs.getString("pickuplocid")+"::"+rs.getString("pickupaddress")+"::"+rs.getString("brandid")+"::"+rs.getString("modelid")+"::"+rs.getString("nos")+"::"+rs.getString("tarifdocno")+"::"+rs.getString("chkothersrvc")+"::"+rs.getString("gid")+"::"+rs.getString("blockhrs")+"::"+rs.getString("tarifdetaildocno")+"::"+rs.getString("transfertype")+"::"+rs.getString("tarif")+"::"+rs.getString("exhrrate")+"::"+rs.getString("nighttarif")+"::"+rs.getString("nightexhrrate")+"::"+rs.getString("masterstatus")+",";
    }
    String finaldatat = datajoint;
    String finaldatah = datajoinh;
    
    if(Integer.parseInt(type)==1){
    	finaldatat+=data;
    } else if(Integer.parseInt(type)==2){
    	finaldatah +=data ;
    }
   	
    System.out.println("data="+data);
    

		String [] arrt = finaldatat.split(",");
		for(String s: arrt) {
			if(!s.equalsIgnoreCase("")){
				transferarray.add(s);
			}
		}
    	
		String [] arrh = finaldatah.split(",");
		for(String s: arrh){
			if(!s.equalsIgnoreCase("")){
				hoursarray.add(s);
			}
		}
    
   	boolean result=false;
   	System.out.println(hoursarray.size()+"   "+transferarray.size());
   	result = clsLimoBookingDAO.insertTarif(Integer.parseInt(bookdocno), transferarray, hoursarray, session, "E"); 
	System.out.println(result);
	if(result==true){
		val=1;
	}
	
   	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>