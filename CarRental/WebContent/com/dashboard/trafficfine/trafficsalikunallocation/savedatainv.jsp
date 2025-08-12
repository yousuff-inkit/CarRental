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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
String chktypes=request.getParameter("chktypes");
String strdataarray=request.getParameter("dataarray")==null?"":request.getParameter("dataarray");

ArrayList<String> dataarray=new ArrayList();
String[] temparray=strdataarray.split(",");
for(int i=0;i<temparray.length;i++){
	dataarray.add(temparray[i]);
}

	try{
	 	conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
	
		

	 	int val=0;
	 	String sqlup="";
	 	for(int i=0;i<dataarray.size();i++){
			//System.out.println(dataarray.get(i));
			String data[]=dataarray.get(i).split("::");
		
	 	if(chktypes.equalsIgnoreCase("salik")){
	 		
	       sqlup=" update  gl_salik set inv_no=999999,status=1  where trans='"+data[0]+"' ";
		
	 	}else if(chktypes.equalsIgnoreCase("traffic")){
			
	 		sqlup="update GL_TRAFFIC set inv_no=999999,status=1 where TICKET_NO='"+data[0]+"' ";
		}
	//System.out.println(" uppdate query -----"+sqlup);
	
 			val= stmt.executeUpdate(sqlup);
 			
 			if(val>0){
 		 		
 		 		
 		 		String upsql="insert into gl_trafficsaliklog (doc_no, date, user,type, remarks)values('"+data[0]+"',now(),'"+session.getAttribute("USERID").toString()+"','"+chktypes+"','Marked as Invoice') ";
 		 		//System.out.println(" uppdate query -----"+upsql);
 		 		 val= stmt.executeUpdate(upsql);
 		 	}
	 	}
	 	
	 
 			 if(val<=0)
				{
					conn.close();
					 
					
				} 
 			
 			if(val>0){  
				conn.commit();
			}
 		response.getWriter().print(val);
 			
 		 	 stmt.close();
 		 	 conn.close();
 		}catch(Exception e){
 		 	e.printStackTrace();	
 		 	conn.close();
 	   }finally{
 		   conn.close();
 	   }
 	%> 