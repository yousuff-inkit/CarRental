<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();  

	Connection conn = null;

	String acno = request.getParameter("acno")==null || request.getParameter("acno").equals("")?"0":request.getParameter("acno").toString();
	String trno = request.getParameter("trno")==null || request.getParameter("trno").equals("")?"0":request.getParameter("trno").toString();
	String tranid = request.getParameter("tranid")==null || request.getParameter("tranid").equals("")?"0":request.getParameter("tranid").toString();
	String docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno").toString();
	String dtype = request.getParameter("dtype")==null || request.getParameter("dtype").equals("")?"0":request.getParameter("dtype").toString();
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").equals("")?"0":request.getParameter("brhid").toString();
	String refrow = request.getParameter("refrow")==null || request.getParameter("refrow").equals("")?"0":request.getParameter("refrow").toString();
	String gridarray = request.getParameter("gridarray");
	int status=-1;         
	
	try{
		ArrayList<String> newarray=new ArrayList();
		
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		
		String sql=null;
		int val=0;
	
		conn=connDAO.getMyConnection();
		conn.setAutoCommit(false);
		
		Statement stmt = conn.createStatement();
		
		if(!tranid.equalsIgnoreCase("0")){
			
			String sqldel="DELETE FROM my_costtran WHERE TRANID="+tranid+"";
			int deleteval=stmt.executeUpdate(sqldel);
			
			for(int i=0;i<newarray.size();i++){
				
				String temp[]=newarray.get(i).split("::");
				
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					
				String costtype = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();
				String costcode = (temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0":temp[1].trim()).toString();
				Double amount = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?0.00:Double.parseDouble(temp[2].trim());
				
				sql="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+acno+","+costtype+","+amount+","+(i+1)+","+costcode+","+tranid+","+trno+")";
				val=stmt.executeUpdate(sql);
				if(val<=0){
					status=0;
				}
				
				if(newarray.size()==1){     
					String sql1 = "update my_jvtran set costtype="+costtype+",costcode="+costcode+" where tranid="+tranid+"";
					int val1 = stmt.executeUpdate(sql1);
					
					String sql2 = "update my_srvpurm m inner join my_srvpurd d on d.rdocno=m.doc_no set d.costtype="+costtype+", d.costcode="+costcode+" where m.voc_no='"+docno+"' and m.brhid='"+brhid+"' and m.dtype='"+dtype+"' and d.rowno='"+refrow+"'";
					//System.out.print("sql2==="+sql2);
					int val2 = stmt.executeUpdate(sql2);       
					
					String sql3 = "update my_srvsalem m inner join my_srvsaled d on d.rdocno=m.doc_no set d.costtype="+costtype+", d.costcode="+costcode+" where m.voc_no='"+docno+"' and m.brhid='"+brhid+"' and m.dtype='"+dtype+"' and d.rowno='"+refrow+"'";   
					//System.out.print("sql3==="+sql3);
					int val3 = stmt.executeUpdate(sql3);        
					
					String sql4 = "update my_cnot m inner join my_cnotd d on d.tr_no=m.tr_no set d.costtype="+costtype+", d.costcode="+costcode+" where m.doc_no='"+docno+"' and m.brhid='"+brhid+"' and m.dtype='"+dtype+"' and d.rowno='"+refrow+"'";
					//System.out.print("sql4==="+sql4);
					int val4 = stmt.executeUpdate(sql4);         
					
					String sql5 = "update my_cashbm m inner join my_cashbd d on m.tr_no=d.tr_no set d.costtype="+costtype+", d.costcode="+costcode+" where m.doc_no='"+docno+"' and m.brhid='"+brhid+"' and m.dtype='"+dtype+"' and d.rowno='"+refrow+"'";
					//System.out.print("sql5==="+sql5);   
					int val5 = stmt.executeUpdate(sql5);         
				}
			  }
			}
			
			if(newarray.size()>1){
				String sql1="update my_jvtran set costtype=7,costcode=9999 where tranid="+tranid+"";
				int val1 = stmt.executeUpdate(sql1);
			}
		}
		
		if(status==0){
			System.out.print("******** FAILED TO UPDATE COSTING ********");     
		}
		else{
			status=1;
			conn.commit();
		}
		 				
		response.getWriter().write(status+"");

	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>