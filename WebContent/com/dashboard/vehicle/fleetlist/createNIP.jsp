<%@page import="sun.security.action.GetIntegerAction"%>
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
<%@ page import="com.finance.nipurchase.nipurchase.*" %>
 
<%
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();
	 ResultSet rs=null;
	 Statement st=null;
	String masArray=request.getParameter("masArray")==null?"0":request.getParameter("masArray");
	String date=request.getParameter("date")==null?"0":request.getParameter("date");
	String accdoc=request.getParameter("accdoc")==null?"0":request.getParameter("accdoc");
	String accname=request.getParameter("accname")==null?"0":request.getParameter("accname");
	String cur=request.getParameter("cur")==null?"0":request.getParameter("cur");
	String rate=request.getParameter("rate")==null?"0":request.getParameter("rate");
	Double nettotal=Double.parseDouble(request.getParameter("nettotal"))==0.0?0.0:Double.parseDouble(request.getParameter("nettotal"));
	double nettotalval=Double.parseDouble(request.getParameter("nettotalval"))==0.0?0.0:Double.parseDouble(request.getParameter("nettotalval"));
	String formdetailcode="CPU";
	int billtype=1;
	String reftype="DIR";
	String invdate=request.getParameter("invdate")==null?"0":request.getParameter("invdate");
	System.out.println("date : "+date+"==accdoc=="+accdoc+"==accname=="+accname+"==cur=="+cur+"==rate=="+rate+"==nettotal=="+nettotal+"==invdate=="+invdate);

	ArrayList<String> masterarray= new ArrayList<String>();
	
	// Split the string into an array
	String[] elements = masArray.split(",");

	// Create an ArrayList and add elements back with '::'
 	for (int i = 0; i < elements.length; i++) {
	    masterarray.add(elements[i]);  // Add element
	    /* if (i < elements.length) {
	        masterarray.add("::");  // Add separator except after the last element
	    } */
	} 

	// Print for debugging
	System.out.println("is array : "+masterarray);


		
	  Connection conn=null;
	    String sql="";
	    try
	    {
	    conn = ClsConnection.getMyConnection();
	    st=conn.createStatement();
		 conn.setAutoCommit(false);
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(invdate);
		int val=0;
		int a=0; 
		 val=DAO.insert(sqlDate, sqlDate, "DIR", 0, "", accdoc, accname, cur, rate, "", "", "", session, "A", nettotal, masterarray,formdetailcode,request,sqlDate,"",invdate,0,1,0.0,nettotalval,billtype);
		 if(val>0){
			 /* String upsql="update my_sordprodum set delrefn="+val+" where rrefno in ("+scodarray+") ";
			 stmt.execute(upsql); */
			 int tr_no=0;
			String trsql=" select tr_no from my_srvpurm where doc_no='"+val+"'";
			   System.out.println("trsql sql : "+trsql);

		    rs=st.executeQuery(trsql);
		    if(rs.next()){
		    	 
		    	tr_no=rs.getInt("tr_no");
		    	//System.out.println("inside rs : "+tr_no);
		    }
			   System.out.println("tr_no : "+tr_no);

			 if(tr_no>0){
				 System.out.println("tr_no inside if : "+tr_no);
				 for(int i=0;i< masterarray.size();i++){
					 String[] purorderarray=masterarray.get(i).split("::");
					 if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty())){
						    String description=""+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")||purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"";
							   System.out.println("description : "+description);
							   System.out.println("description9 : "+description.split("-")[0]);

						    String finalrate=""+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"";
						    String trackid=""+(purorderarray[16].trim().equalsIgnoreCase("undefined") || purorderarray[16].trim().equalsIgnoreCase("NaN")||purorderarray[16].trim().equalsIgnoreCase("")|| purorderarray[16].isEmpty()?0:purorderarray[16].trim())+"";
						    String outdays=""+(purorderarray[17].trim().equalsIgnoreCase("undefined") || purorderarray[17].trim().equalsIgnoreCase("NaN")||purorderarray[17].trim().equalsIgnoreCase("")|| purorderarray[17].isEmpty()?0:purorderarray[17].trim())+"";
						    String totaldays=""+(purorderarray[18].trim().equalsIgnoreCase("undefined") || purorderarray[18].trim().equalsIgnoreCase("NaN")||purorderarray[18].trim().equalsIgnoreCase("")|| purorderarray[18].isEmpty()?0:purorderarray[18].trim())+"";
						    String fleetno = description.split("-")[0];
						    String fleetlogsql="insert into my_nipfleetlog (fleetno, acno, trackingid, date, nitrno, totrent,outdays, totaldays) values ('"+fleetno+"','"+accdoc+"','"+Double.parseDouble(trackid)+"','"+sqlDate+"','"+tr_no+"','"+finalrate+"','"+outdays+"','"+totaldays+"')";
						   System.out.println("fleet insert sql : "+fleetlogsql);
						    a=st.executeUpdate(fleetlogsql);
						    
					 }
					 
				 }
				 
			 }
			 
		 }
		 if(a>0){
			 conn.commit();
		 }else{
			 val=0;
		 }
				
				response.getWriter().print(val);
				 
				st.close();
		    	conn.close();
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	st.close();
	    	conn.close();
	    	response.getWriter().print(0);
	    }finally{
	    	st.close();
	    	conn.close();
	    }
	 	
	 	
%>



 