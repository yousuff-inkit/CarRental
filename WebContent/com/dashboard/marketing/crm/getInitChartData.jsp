<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	Connection conn=null;
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim();  
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim(); 
    java.sql.Date sqlfromdate = null;
    java.sql.Date sqltodate = null; 
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	    }else{}
	    
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	       sqltodate=objcommon.changeStringtoSqlDate(todate);
	    } else{} 
		
		String salesuser="";
     
		//System.out.println("brhid="+brhid);     
		if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")){         
			salesuser+=" and l.brhid='"+brhid+"'";             
		}
		 String strenq="select sum(lpr) lpr, sum(newclient) newclient,sum(calcul) calcul,sum(appl) appl from (select if(lc.doc_no is null and l.date between '"+sqlfromdate+"' and '"+sqltodate+"' '"+salesuser+"'  and l.cldocno!=0,1,0) lpr,if(lc.doc_no is null and l.cldocno=0 and l.date between '"+sqlfromdate+"' and '"+sqltodate+"' '"+salesuser+"' ,1,0) newclient,if(lc.doc_no is not null and lm.refdocno is null and l.date between '"+sqlfromdate+"' and '"+sqltodate+"' '"+salesuser+"' ,1,0) calcul,if(lm.refdocno is not null and l.date between '"+sqlfromdate+"' and '"+sqltodate+"' '"+salesuser+"' ,1,0) appl from gl_lprm  l left join gl_leasecalcm lc on lc.reqdoc=l.doc_no left join gl_leaseappm lm on lm.refdocno=lc.doc_no where l.date between '"+sqlfromdate+"' and '"+sqltodate+"' '"+salesuser+"' ) a ";
		 System.out.println("count==========================="+strenq);               
			String lprcount="0",newclientcount="0",calculcount="0",applcount="0";         
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				lprcount=rsenq.getString("lpr");
				newclientcount=rsenq.getString("newclient");
				calculcount=rsenq.getString("calcul");
				applcount=rsenq.getString("appl");  
			}
			objdata.put("lprcount",lprcount);
			objdata.put("newclientcount",newclientcount); 
			objdata.put("calculcount",calculcount);
			objdata.put("applcount",applcount); 
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	//System.out.println(enqdetails);  
	response.getWriter().print(objdata);           
%>