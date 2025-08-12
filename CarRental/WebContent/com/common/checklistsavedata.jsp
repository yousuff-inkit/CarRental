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
<%@page import="com.email.*"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	Statement stmt1 = conn.createStatement(); 
	 	String qottrno=request.getParameter("qottrno")==null || request.getParameter("qottrno").trim()==""?"0":request.getParameter("qottrno").trim();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();  
		String dtype=request.getParameter("dtype")==null || request.getParameter("dtype").trim()==""?"0":request.getParameter("dtype").trim();  
		String checklistarray=request.getParameter("checklist")==null?"":request.getParameter("checklist").trim();
		
		String temp="";
		int val=0;
		
		 ArrayList<String> griddataarray=new ArrayList<String>();
	 		 String[] temparray=checklistarray.split(",");  
	 		 for(int i=0;i<temparray.length;i++){
	 			griddataarray.add(temparray[i]);    
	 		 }
			
			 String delsql="delete from my_checklistdet where qotno='"+qottrno+"' and brhid='"+brhid+"'";        
			 //System.out.println("delsql--->>>"+delsql);
			 val= stmt.executeUpdate(delsql);   
			 
			 for(int i=0;i< griddataarray.size();i++){       
					String[] contrtypedet=((String) griddataarray.get(i)).split("::");
					if(!(contrtypedet[0].trim().equalsIgnoreCase("undefined")|| contrtypedet[0].trim().equalsIgnoreCase("NaN")||contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty())){
						String checksrno=(contrtypedet[0].trim().equalsIgnoreCase("undefined") || contrtypedet[0].trim().equalsIgnoreCase("NaN")|| contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()?"0":contrtypedet[0].trim());
						String checkremarks=(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"":contrtypedet[1].trim());
						String filepath=(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"":contrtypedet[2].trim());
						String filename=(contrtypedet[3].trim().equalsIgnoreCase("undefined") || contrtypedet[3].trim().equalsIgnoreCase("NaN")|| contrtypedet[3].trim().equalsIgnoreCase("")|| contrtypedet[3].isEmpty()?"":contrtypedet[3].trim());
						if(filepath.equals("") || filepath==null){
							filename = "";     
						}
						String upsql="insert into my_checklistdet(qotno, checksrno, remarks, path, attach, brhid,status,dtype) values('"+qottrno+"','"+checksrno+"','"+checkremarks+"','"+filepath+"','"+filename+"', '"+brhid+"',3,'"+dtype+"')";            
						//System.out.println("upsql--->>>"+upsql);  
						val= stmt.executeUpdate(upsql);
					}
			 }   
			 if(val>0){
				 temp="1";  
			 }
			 
			 if(temp.equalsIgnoreCase("1")){  
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>