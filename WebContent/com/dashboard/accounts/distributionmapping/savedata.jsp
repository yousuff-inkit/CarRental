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
	String list=request.getParameter("list")==null?"0":request.getParameter("list");
	//System.out.println("list----------"+list);
	String docss=request.getParameter("docss")==null?"0":request.getParameter("docss");
	//System.out.println("docss----------"+docss);
	ArrayList<String> proday= new ArrayList<String>();
	String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 proday.add(temp);
		  } 
	  	Connection conn=null;
	    String sql="";
	    try
	    {
	    conn = ClsConnection.getMyConnection();
	   
		Statement stmt = conn.createStatement();
	 
		Statement stmt1 = conn.createStatement();
		ArrayList<String> masterarray= new ArrayList<String>();
		
		 int val=0;
		
		
        // System.out.println("prod----------"+proday);
        
         for(int k=0;k<proday.size();k++){
				
            String[] prod=((String) proday.get(k)).split("::"); 
            
            String docno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			String br1=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
			String br2=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";		
			String br3=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
			String br4=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[4].trim())+"";
			String br5=""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].trim().equalsIgnoreCase("")|| prod[5].isEmpty()?0:prod[5].trim())+"";
			String br6=""+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].trim().equalsIgnoreCase("")|| prod[6].isEmpty()?0:prod[6].trim())+"";
			
			String sqlchk="select acno acno from my_dsmp where acno ="+docno+" ";
			// System.out.println("sqlchk----------"+sqlchk);
	         
	         ResultSet resultSet = stmt.executeQuery(sqlchk);
	        int acnoss=0;
	         if (resultSet.next()){
	        	 
	        	 acnoss=resultSet.getInt("acno");
	         }
	      //   System.out.println("acnoss----------"+acnoss);
	      	
		if(acnoss>0){
			
			
			String upsql="update my_dsmp set branch1='"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
					+ " branch2='"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"', "
					+ " branch3='"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"', "
					+ " branch4='"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[4].trim())+"',  "
					+ " branch5='"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].trim().equalsIgnoreCase("")|| prod[5].isEmpty()?0:prod[5].trim())+"', "
					+ " branch6='"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].trim().equalsIgnoreCase("")|| prod[6].isEmpty()?0:prod[6].trim())+"' "
					+ " where acno='"+docno+"' ";
				val=stmt.executeUpdate(upsql);
				//System.out.println("update--"+upsql);
			 
			
			
		}else{
			  
				if(!(prod[0].trim().equalsIgnoreCase("undefined")|| prod[0].trim().equalsIgnoreCase("NaN")||prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()))
			     {
				
					String insertsqls=" insert into my_dsmp(acno, branch1, branch2, branch3, branch4, branch5, branch6) value  "
									 +" ('"+docno+"','"+br1+"','"+br2+"','"+br3+"','"+br4+"','"+br5+"','"+br6+"') ";
					
					
				   //  System.out.println("--------insert-------"+insertsqls);
					val=stmt.executeUpdate(insertsqls);
				 
			}
				
	  }
}
 
				
				response.getWriter().print(val);
				 
				conn.close();
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(0);
	    }
	 	
	 	
%>



 