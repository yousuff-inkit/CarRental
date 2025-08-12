<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%

ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String tranid=request.getParameter("tranid")==null?"0":request.getParameter("tranid");
String strupinvarray=request.getParameter("upinvarray")==null?"":request.getParameter("upinvarray");
String upinvlength=request.getParameter("upinvlength")==null?"0":request.getParameter("upinvlength");


Connection conn=null;
int errorstatus=0;
try{
	//System.out.println("="+tranid+"=="+strupinvarray+"=="+upinvlength);
	ArrayList<String> upinvarray=new ArrayList();
	for(int i=0;i<Integer.parseInt(upinvlength);i++){
		upinvarray.add(strupinvarray.split(",")[i]);
	}
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	//String userid=session.getAttribute("USERID").toString();
	
	for(int i=0;i<upinvarray.size();i++){
			String strupdateinv="update my_prepd  set posted=999999999,jvtrno=999999999 where  tranid="+tranid+"  and rowno="+upinvarray.get(i).split("::")[0]+" ";
		//	System.out.println(strupdateinv);
			int updateinv=stmt.executeUpdate(strupdateinv);
			if(updateinv<=0){
				errorstatus=1;
					
		}
	}

	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>
 
 
 
 
 
 
 
 
 