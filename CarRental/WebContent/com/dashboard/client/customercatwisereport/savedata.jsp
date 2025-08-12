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
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");    
//String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray"); 
int cldoc=request.getParameter("cldoc")==null || request.getParameter("cldoc")==""?0:Integer.parseInt(request.getParameter("cldoc").trim().toString());
 System.out.println("cldoc :"+cldoc);   
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;
System.out.println("in==="+gridarray);

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		System.out.println("peek========"+newarray);	
		
		String delsql="delete from my_clprod where cldocno="+cldoc+"";
		stmt.execute(delsql);
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				
			String alias = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"":temp[0].trim()).toString();    
			String depid = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"":temp[1].trim().toString();
		                 
			 
				String sql="insert into my_clprod(cldocno, alias, depno) values('"+cldoc+"','"+alias+"','"+depid+"')";
				System.out.println(sql);          
				 val=stmt.executeUpdate(sql);   
			
			//System.out.println("val==="+val); 
			if(val>0){
				msg="1";
				conn.commit();
			}
		}
		/* conn.commit(); */
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(msg);
%>