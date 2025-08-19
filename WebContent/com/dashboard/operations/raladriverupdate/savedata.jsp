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
ClsConnection viewDAO=new ClsConnection();
String array=request.getParameter("array")==null?"0":request.getParameter("array");
String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno");
String brhid=request.getParameter("brhid")==null|| request.getParameter("brhid")=="" ?"0":request.getParameter("brhid");
String type=request.getParameter("type")==null|| request.getParameter("type")=="" ?"0":request.getParameter("type");
String rdocno=request.getParameter("rdocno")==null|| request.getParameter("rdocno")=="" ?"0":request.getParameter("rdocno");



String aa[]=array.split(",");

	ArrayList<String> mainarray= new ArrayList<String>();
for(int i=0;i<aa.length;i++){
	 
	 String bb[]=aa[i].split("::");

	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
} 

Connection conn=null;
String sql2="";
int val=0,resultSet4=0;
String sqls="";
try
{
	
conn = viewDAO.getMyConnection();
Statement stmt = conn.createStatement();
for(int k=0;k<mainarray.size();k++)
{
	/* if(k==0)
	{
		if(type.equalsIgnoreCase("RA"))
				{

             sqls="delete from  gl_rdriver where rdocno='"+rdocno+"' and cldocno='"+cldocno+"'";
				}
		else if(type.equalsIgnoreCase("LA"))
				{
			 sqls="delete from  gl_ldriver where rdocno='"+rdocno+"' and cldocno='"+cldocno+"' ";

				}
   stmt.executeUpdate(sqls);

}    */

	  String[] serarray=mainarray.get(k).split("::");  
	   // System.out.println("values=="+mainarray.size());
	    
	   
	   if(type.equalsIgnoreCase("RA") && (serarray[1].trim().equalsIgnoreCase("")))
	     {
		 //    System.out.println(type+"array"+serarray[0]+"array1"+serarray[1]);

	     if(!(serarray[0].trim().equalsIgnoreCase("undefined")|| serarray[0].trim().equalsIgnoreCase("null")|| serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()))
	     {
	      sql2="INSERT INTO gl_rdriver( brhid, drid, cldocno,rdocno)VALUES"
			       + "('"+brhid+"',"
			       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
			       + "'"+cldocno+"','"+rdocno+"')";
	    // System.out.println("INSERT--RA------------------------------"+sql2);
	     resultSet4 = stmt.executeUpdate(sql2);
	     val++;
	     if(resultSet4<=0)
       {
	    	 stmt.close();
			 conn.close();
            
          }
	     }
	    	 
	     }
	   
	     
	      if(type.equalsIgnoreCase("LA") && (serarray[1].trim().equalsIgnoreCase("")))
	     {
	     if(!(serarray[0].trim().equalsIgnoreCase("undefined")|| serarray[0].trim().equalsIgnoreCase("null")|| serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()))
	     {
		   //  System.out.println(type+"array"+serarray[0]+"array1"+serarray[1]);

	    	  sql2="INSERT INTO gl_ldriver( brhid, drid, cldocno,rdocno)VALUES"
				       + "('"+brhid+"',"
				       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
				       + "'"+cldocno+"','"+rdocno+"')";
		  // System.out.println("INSERT--LA------------------------------"+sql2);
		    resultSet4 = stmt.executeUpdate(sql2);
		    val++;
		     if(resultSet4<=0)
       {
	    	 stmt.close();
			 conn.close();
            
          }
	     }
	 
	    		 
	     }
	 
	     
	}

response.getWriter().print(val);


stmt.close();
conn.close();


}
catch(Exception e)
{
e.printStackTrace();
conn.close();
}































%>


