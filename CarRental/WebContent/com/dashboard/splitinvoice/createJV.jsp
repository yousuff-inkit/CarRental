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
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>     
<%@page import="com.ibm.icu.text.SimpleDateFormat" %> 
<%
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();           
		Statement stmt = conn.createStatement();   
		int brhid = request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String postdate = request.getParameter("postdate")==null?"0":request.getParameter("postdate").trim();
		String postacc=request.getParameter("postacc")=="" || request.getParameter("postacc")==null?"0":request.getParameter("postacc");
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		double credit=Double.parseDouble(request.getParameter("credit")=="" || request.getParameter("credit")==null?"0.0":request.getParameter("credit"));
		double debit=Double.parseDouble(request.getParameter("debit")=="" || request.getParameter("debit")==null?"0.0":request.getParameter("debit"));
		String description=request.getParameter("description")=="" || request.getParameter("description")==null?"":request.getParameter("description");
		String refno=request.getParameter("refno")=="" || request.getParameter("refno")==null?"":request.getParameter("refno");
		String invdocno=request.getParameter("invdocno")=="" || request.getParameter("invdocno")==null?"":request.getParameter("invdocno");
		
	    String sql="",statusupdate="";
		String strarray=request.getParameter("gridarray").equalsIgnoreCase("") || request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		ArrayList<String> gridarray=new ArrayList<String>();
		for(int i=0;i<strarray.split(",").length;i++){
			gridarray.add(strarray.split(",")[i]);
		}
		ClsJournalVouchersDAO DAO=new ClsJournalVouchersDAO(); 
        int val=0,temp=0,trnosss=0;
        int data;
			 java.sql.Date sqlpostdate=null;
			 
			 if((!postdate.equalsIgnoreCase("") && !postdate.equalsIgnoreCase("0") && !postdate.equalsIgnoreCase("undefined"))){
			    	sqlpostdate=ClsCommon.changeStringtoSqlDate(postdate);
			    }
			 val=DAO.insert(sqlpostdate,"JVT-18",refno, description, debit, credit,gridarray,session, request);
				if(val>0){ 
					trnosss=Integer.parseInt(request.getAttribute("tranno").toString());
					  statusupdate="update gl_invm set spitrno='"+trnosss+"' where doc_no='"+invdocno+"'";         
						//System.out.println("statusupdate--->>>"+statusupdate);                         
						  stmt.executeUpdate(statusupdate);  
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
				
						
		