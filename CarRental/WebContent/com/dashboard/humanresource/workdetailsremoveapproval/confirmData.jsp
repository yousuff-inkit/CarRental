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

	Connection conn = null;
	
	try{
	
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	
		String selectedsrno=request.getParameter("selectedsrno");
		String confirmed=request.getParameter("confirmed");
		String selecteddb=request.getParameter("selecteddb");
		String selectedempid=request.getParameter("selectedempid");
		
		int val=0;
		java.sql.Date sqlUpToDate=null;
		
        String[] docsarray = selectedsrno.split("::");
        String[] dbarray = selecteddb.split("::");
        String[] emparray = selectedempid.split("::");
      
		for (int i = 0; i < docsarray.length; i++) {
			String srno=docsarray[i];	
			String db=dbarray[i];	
			String empid=emparray[i];	

			if(!(srno.equalsIgnoreCase(""))){
				
			String	sql="UPDATE "+db+".hr_workdetails SET confirmed="+confirmed+" where srno='"+srno+"'";
			//System.out.println("sql=================="+sql);
				val= stmt.executeUpdate(sql);
			
				String sqldate="select CURRENT_TIMESTAMP() curdate";
				 ResultSet resultSet1 = stmt.executeQuery(sqldate);
		    	    String newdate="";
		    	    while(resultSet1.next()){
		    	    	newdate=resultSet1.getString("curdate");
		    	    }
		    	  int rdocno=0;  
		    	String sqlup1="insert into hr_workrm(date,userid)values(?,?)";

				//System.out.println("workrm==========="+sqlup1);
				
				PreparedStatement statement = conn.prepareStatement(sqlup1,Statement.RETURN_GENERATED_KEYS);
				statement.setString(1, newdate);
		        statement.setString(2,session.getAttribute("USERID").toString());
		        statement.executeUpdate();
		    
		        ResultSet generatedKeys = statement.getGeneratedKeys();
		        
		        
		            if (generatedKeys.next()) {
		            	rdocno=generatedKeys.getInt(1);
		               
		            }
			String sqlup2="insert into hr_workrd(srno,rdocno)values('"+srno+"','"+rdocno+"')";

			//	System.out.println("workrd==========="+sqlup2);
				stmt.executeUpdate(sqlup2);
					
		  }
		}
		
		
				 
		conn.commit();
		
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	conn.close();
	 	e.printStackTrace();	
   } finally{
	   conn.close();
   }
	%>
