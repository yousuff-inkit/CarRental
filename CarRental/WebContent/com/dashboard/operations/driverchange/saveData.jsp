<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;
String cldocno=(request.getParameter("cldocno")==null || request.getParameter("cldocno")=="")?"0":request.getParameter("cldocno");
String doc_no=request.getParameter("doc_no")==null?"0":request.getParameter("doc_no");
String voc_no=request.getParameter("voc_no")==null?"0":request.getParameter("voc_no");
String fleet_no=request.getParameter("fleet_no")==null?"0":request.getParameter("fleet_no");
String hidtype=request.getParameter("hidtype")==null?"0":request.getParameter("hidtype");
String drid=request.getParameter("drid")==null?"0":request.getParameter("drid");
String type=request.getParameter("type")==null?"0":request.getParameter("type");
String drvid=request.getParameter("drvid")==null?"0":request.getParameter("drvid");
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
String brch=request.getParameter("brch")==null?"0":request.getParameter("brch");
String processtype=request.getParameter("processtype")==null?"0":request.getParameter("processtype");


try{
	int val=0;
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	//String brhid=session.getAttribute("BRANCHID").toString();  
	String sql="";
	
	if(type.equalsIgnoreCase("1")){
	if(hidtype.equalsIgnoreCase("RAG")){
		sql="update gl_ragmt r  left join gl_vmove v on v.rdocno=r.doc_no and v.repno=0  and v.exchng=0 and v.custno=0 and v.rdtype='RAG' set r.drid='"+drvid+"' , v.emp_id='"+drvid+"'  where r.doc_no="+doc_no;
	}else if(hidtype.equalsIgnoreCase("LAG")){

        sql="update gl_lagmt l  left join gl_vmove v on v.rdocno=l.doc_no and v.repno=0  and v.exchng=0 and v.custno=0  and v.rdtype='LAG'  set l .drid='"+drvid+"' , v.emp_id='"+drvid+"'  where l.doc_no="+doc_no;
	}
	  
	}/* else if(type.equalsIgnoreCase("2")){
		if(hidtype.equalsIgnoreCase("RAG")){
			sql="update gl_ragmt set drid='"+drvid+"' where doc_no="+agmtno;
		}else if(hidtype.equalsIgnoreCase("LAG")){
			sql="update gl_lagmt set drid='"+drvid+"' where doc_no="+agmtno;
		}
		  
		} */
	
	 else if(type.equalsIgnoreCase("2")){
		sql="update gl_vehpickup set drid='"+drvid+"' where doc_no="+doc_no;
	}
	 else if(type.equalsIgnoreCase("3")){
		 if(processtype.equalsIgnoreCase("1")){
				sql="update gl_vehreplace v left join gl_vmove m on m.repno=v.doc_no set v.DELDRVID='"+drvid+"', m.emp_id='"+drvid+"'  where v.doc_no='"+doc_no+"' and v.RTYPE='"+hidtype+"' and v.rfleetno='"+fleet_no+"' ";
		 } else {
				sql="update gl_vehreplace v left join gl_vmove m on m.repno=v.doc_no set v.CLDRVID='"+drvid+"', m.emp_id='"+drvid+"'  where v.doc_no='"+doc_no+"' and v.RTYPE='"+hidtype+"' and v.rfleetno='"+fleet_no+"' ";
			 
		 }
		}else if(type.equalsIgnoreCase("4")){
			if(processtype.equalsIgnoreCase("1")){
				sql="update gl_nrm n left join gl_vmove v on v.rdocno=n.doc_no and v.rdtype='MOV' set n.drid='"+drvid+"', v.emp_id='"+drvid+"'  where n.doc_no='"+doc_no+"' and n.fleet_no='"+fleet_no+"' ";
			} else {
				sql="update gl_nrm n left join gl_vmove v on v.rdocno=n.doc_no and v.rdtype='MOV' set n.closedr='"+drvid+"', v.emp_id='"+drvid+"'  where n.doc_no='"+doc_no+"' and n.fleet_no='"+fleet_no+"' ";
			}	
	    }
	
	val= stmt.executeUpdate(sql);
	System.out.println("delivery update=-----"+sql);

			
	if(val>0){
		
		String bibinsert="insert into gl_biblog(doc_no, brhId, dtype, edate, userId,activity, ENTRY) values('"+doc_no+"','"+brch+"','DCHG',now(),'"+userid+"','"+type+"','A') ";
		val= stmt.executeUpdate(bibinsert);
	}

	
	
	
	if(val>0){
		
		conn.commit();
	}
   
    response.getWriter().print(val);
	 
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>


 