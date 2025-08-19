<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	String trno=request.getParameter("trno");
	String accountno=request.getParameter("accountno");
	String outamounts=request.getParameter("outamount");
	String dtype=request.getParameter("dtype");
	String tranid=request.getParameter("tranid");
	String branchid=request.getParameter("branchid");
	String date=request.getParameter("date");
	String reason=request.getParameter("reason");
	String removeall=request.getParameter("removeall")==null || request.getParameter("removeall").trim().equalsIgnoreCase("") ?"0":request.getParameter("removeall");
	String strdeletearray=request.getParameter("deletearray")==null || request.getParameter("deletearray").trim().equalsIgnoreCase("") ?"":request.getParameter("deletearray");

	ArrayList<String> deletearray=new ArrayList();
	if(!strdeletearray.trim().equalsIgnoreCase("")){
		for(int i=0;i<strdeletearray.split(",").length;i++){
			deletearray.add(strdeletearray.split(",")[i]);
		}
	}
	
   	for(int i=0;i<deletearray.size();i++){
   		conn=objconn.getMyConnection();
   		conn.setAutoCommit(false);
   		Statement stmt=conn.createStatement();
   		String dettranid=deletearray.get(i).split("::")[0].trim();
   		String applyamt=deletearray.get(i).split("::")[1].trim();
   		
   		String strupdatejvmain="UPDATE my_jvtran SET out_amount=((out_amount*id)-"+applyamt+")*id WHERE tranid="+tranid;
   		System.out.println(strupdatejvmain);
   		int updatejvmain=stmt.executeUpdate(strupdatejvmain);
   		if(updatejvmain<=0){
   			System.out.println("Main Jv Amount Update Error("+applyamt+"::"+tranid+")");
			errorstatus=1;
   			break;
   		}
   		
   		String strdeleteout="delete from my_outd where ap_trid="+dettranid;
   		System.out.println(strdeleteout);
   		int deleteout=stmt.executeUpdate(strdeleteout);
   		if(deleteout<=0){
   			System.out.println("Out Delete Error("+dettranid+")");
			errorstatus=1;
   			break;
   		}

   		String strupdatejvdet="update my_jvtran set out_amount=((out_amount*id)-"+applyamt+")*id where tranid="+dettranid;
   		System.out.println(strupdatejvdet);
   		int updatejvdet=stmt.executeUpdate(strupdatejvdet);
   		if(updatejvdet<=0){
   			System.out.println("Detail Jv Amount Update Error("+applyamt+"::"+dettranid+")");
			errorstatus=1;
   			break;
   		}
   		
   		if(errorstatus==0){
   			conn.commit();
   		}
   		conn.close();
   	}
    
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
}
finally{
	conn.close();
	
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");

%>
