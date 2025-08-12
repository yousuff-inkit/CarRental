<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.ArrayList"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;    
	String salid=request.getParameter("salid")==null || request.getParameter("salid").trim()==""?"0":request.getParameter("salid").trim();
	String docsarray=request.getParameter("docsarray")==null || request.getParameter("docsarray").trim()==""?"0":request.getParameter("docsarray").trim();
	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
    
    try{       
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
		System.out.println(salid+"-----process--->>>"+processid);               
	    
		int val=0;
		 
		/*Operations*/  
		if(processid.equalsIgnoreCase("Salesman")){
			
			ArrayList<String> docsar=new ArrayList<String>();
			if(docsarray.contains(":")){
				String [] docs=new String []{};   
				docs=docsarray.split(":");
				for(int i=0;i<docs.length;i++){
					docsar.add(i, docs[i]);  
				}
			}
			else{
				docsar.add(0, docsarray);     
			}
			for(int i=0;i<docsar.size();i++){
				String docno="0",brhid="0";
				 String sqlselect="select brhid,cldocno doc_no from my_acbook  where cldocno='"+docsar.get(i)+"'";  
		    	 //System.out.println("sqlselect--->>>"+sqlselect);         
				 ResultSet rs = stmt.executeQuery(sqlselect);  
				 while(rs.next()){
					 docno = rs.getString("doc_no");
					 brhid = rs.getString("brhid");
				 }
				 String upsq1="update gl_ragmt set salid='"+salid+"' where clstatus=0 and cldocno='"+docno+"'";    
		    	 //System.out.println("upsql--->>>"+upsq1);         
				 val = stmt.executeUpdate(upsq1);
				 
				 String upsq2="update  gl_lagmt  set salid='"+salid+"' where clstatus=0 and cldocno='"+docno+"'";    
		    	 //System.out.println("upsq2--->>>"+upsq2);         
				 val = stmt.executeUpdate(upsq2);
		 
				 String upsq3="update my_acbook  set sal_id='"+salid+"' where cldocno='"+docno+"'";    
		    	 //System.out.println("upsq3--->>>"+upsq3);         
				 val = stmt.executeUpdate(upsq3);
				 
			     if(val>0){     
			    	 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','CSM',now(),'"+session.getAttribute("USERID").toString()+"','E')";    
					 //System.out.println("logsql--->>>"+logsql);      
					 stmt.executeUpdate(logsql);      
			     } 
			}    
	     }else{}            
		 
		if(val>0){        
			conn.commit();
		}
		 response.getWriter().print(val);
 	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();
   }
%>
