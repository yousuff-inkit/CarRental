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

<%ClsConnection connDAO=new ClsConnection();
String jsobject=request.getParameter("myarray")==null?"0":request.getParameter("myarray");   

 	String list=request.getParameter("list")==null?"0":request.getParameter("list");
String doc=request.getParameter("doc");
String garrageval=request.getParameter("garrageid");
String sertype=request.getParameter("maintype");
 
 ArrayList<String> mainarray= new ArrayList<String>();
 
 String aa[]=list.split(",");
 
  

 
	//mainarray.add(list);
	
 
	//System.out.println("----mainarray-----"+mainarray);
		 Connection conn=null;
		    String sql="";
		    try
		    {
		   	
		    conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement();
			 JSONObject json = JSONObject.fromObject(jsobject);   
			 JSONArray jsonArray = json.getJSONArray("workorderdata");  
		     
	for(int k=0;k<jsonArray.size();k++)
	{
	
		   JSONObject jsobj = jsonArray.getJSONObject(k);  
        //   System.out.println("remarks :"+jsobj.getString("remarks").toString());   
    
 
		
	
			 
			if(k==0)
			{
				 String sqls="delete from  gl_vcostd where rdocno='"+doc+"' ";
		   	    stmt.executeUpdate(sqls); 
		 	   
		 	    String sqlsa="update gl_vmcostm set wostatus=1,gargid='"+garrageval+"',mtype='"+sertype+"' where doc_no='"+doc+"' ";
		 	 
			    stmt.executeUpdate(sqlsa);
		   	 
		   	
				
			}
			
			 
			   PreparedStatement prestmt = conn.prepareStatement("insert into gl_vcostd(rowno,type,repdesc,remarks,labcost,partcost,total,rdocno,status)VALUES (?,?,?,?,?,?,?,?,?)");
	            prestmt.setInt (1,k+1);
	             prestmt.setString(2, jsobj.getString("type").equalsIgnoreCase("undefined") || jsobj.getString("type").equalsIgnoreCase("") || jsobj.getString("type").trim().equalsIgnoreCase("NaN")|| jsobj.getString("type").isEmpty()?"0":jsobj.getString("type").trim());
	             prestmt.setString(3, jsobj.getString("description").equalsIgnoreCase("undefined") || jsobj.getString("description").equalsIgnoreCase("") || jsobj.getString("description").trim().equalsIgnoreCase("NaN")|| jsobj.getString("description").isEmpty()?"0":jsobj.getString("description").trim());
	             prestmt.setString(4, jsobj.getString("remarks").equalsIgnoreCase("undefined") || jsobj.getString("remarks").equalsIgnoreCase("") || jsobj.getString("remarks").trim().equalsIgnoreCase("NaN")|| jsobj.getString("remarks").isEmpty()?"0":jsobj.getString("remarks").trim());
	             prestmt.setString(5, jsobj.getString("lbrcost").equalsIgnoreCase("undefined") || jsobj.getString("lbrcost").equalsIgnoreCase("") || jsobj.getString("lbrcost").trim().equalsIgnoreCase("NaN")|| jsobj.getString("lbrcost").isEmpty()?"0":jsobj.getString("lbrcost").trim());
	             prestmt.setString(6, jsobj.getString("partscost").equalsIgnoreCase("undefined") || jsobj.getString("partscost").equalsIgnoreCase("") || jsobj.getString("partscost").trim().equalsIgnoreCase("NaN")|| jsobj.getString("partscost").isEmpty()?"0":jsobj.getString("partscost").trim());
	             prestmt.setString(7, jsobj.getString("total").equalsIgnoreCase("undefined") || jsobj.getString("total").equalsIgnoreCase("") || jsobj.getString("total").trim().equalsIgnoreCase("NaN")|| jsobj.getString("total").isEmpty()?"0":jsobj.getString("total").trim());
                 prestmt.setString(8,doc);
                 prestmt.setInt(9,3);

			     int resultSet4 = prestmt.executeUpdate();       

			     if(resultSet4<=0)
                 {
			    	 
                      
                    }
			     
			} 
			  
				 //stmt.executeUpdate(sql);
				 
				 
					//response.getWriter().print(ivals);
		    
		    
	 stmt.close();
	 
		conn.close();
		    
		    }	
		    
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    	conn.close();
		    } 
		
		
		
		
		
		
		
		
		
		
		
		
		 
 

 /*   String type=request.getParameter("type")==null?"0":request.getParameter("type");
  String description=request.getParameter("description")==null?"0":request.getParameter("description");
    String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks");
    String lbrcost=request.getParameter("lbrcost")==null?"0":request.getParameter("lbrcost");
    String partscost=request.getParameter("partscost")==null?"0":request.getParameter("partscost");
    String total=request.getParameter("total")==null?"0":request.getParameter("total");
    
    
    String doc=request.getParameter("doc");
    String ival=request.getParameter("ival");
    
    String garrageval=request.getParameter("garrageid");
    String sertype=request.getParameter("maintype");
    String lgt=request.getParameter("lgt"); 
    String del=request.getParameter("del");  */
/* 	ArrayList<String> mainarray= new ArrayList<String>();
     
	mainarray.add(type+"::"+description+"::" +remarks+"::");

    	
                 
System.out.println("--------"+mainarray.size())  ;   */
/* int ivals=Integer.parseInt(ival);
    int dels=Integer.parseInt(del);
   
    Connection conn=null;
    String sql="";
    try
    {
   	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	 
	if(dels==0)
	{
		String sqls="delete from  gl_vcostd where rdocno='"+doc+"' ";
   	    stmt.executeUpdate(sqls);
 	   
 	    String sqlsa="update gl_vmcostm set wostatus=1,gargid='"+garrageval+"',mtype='"+sertype+"' where doc_no='"+doc+"' ";
 	 
	    stmt.executeUpdate(sqlsa);
   	 
   	
		
	}
	
	
	  sql="INSERT INTO gl_vcostd(rowno,type,repdesc,remarks,labcost,partcost,total,rdocno,status)VALUES"
 	           + " ("+(ivals+1)+","
		       + "'"+(type.equalsIgnoreCase("undefined") || type.equalsIgnoreCase("null") || type.equalsIgnoreCase("NaN")||type.equalsIgnoreCase("")|| type.isEmpty()?0:type)+"',"
		       + "'"+(description.equalsIgnoreCase("undefined") || description.equalsIgnoreCase("null") || description.equalsIgnoreCase("NaN")|| description.equalsIgnoreCase("")|| description.isEmpty()?0:description)+"',"
		       + "'"+(remarks.equalsIgnoreCase("undefined") || remarks.equalsIgnoreCase("null")|| remarks.equalsIgnoreCase("NaN")||remarks.equalsIgnoreCase("")|| remarks.isEmpty()?0:remarks.trim())+"',"
		       + "'"+(lbrcost.equalsIgnoreCase("undefined") || lbrcost.equalsIgnoreCase("null")|| lbrcost.equalsIgnoreCase("NaN")||lbrcost.equalsIgnoreCase("")|| lbrcost.isEmpty()?0:lbrcost)+"',"
		       + "'"+(partscost.equalsIgnoreCase("undefined") || partscost.equalsIgnoreCase("null")|| partscost.equalsIgnoreCase("NaN")||partscost.equalsIgnoreCase("")||partscost.isEmpty()?0:partscost.trim())+"',"
		       + "'"+(total.equalsIgnoreCase("undefined") || total.equalsIgnoreCase("null")|| total.equalsIgnoreCase("NaN")||total.equalsIgnoreCase("")|| total.isEmpty()?0:total)+"',"
		       +"'"+doc+"',3)"; 
	  
		 stmt.executeUpdate(sql);
		 
		 
			response.getWriter().print(ivals);
		 
		 stmt.close();
		 
	conn.close();
	
	
    }
    
    
    	
    
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    } 

	 	 */
	 	
%>



