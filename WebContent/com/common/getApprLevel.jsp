<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String brch = request.getParameter("brch");
		if(brch == null || brch.trim().equals("")) brch = "0";

		String docno = request.getParameter("docno");
		if(docno == null || docno.trim().equals("")) docno = "0";

		String dtype = request.getParameter("dtype");
		if(dtype == null) dtype = "";

		String usrid = request.getParameter("usrid");
		if(usrid == null || usrid.trim().equals("")) usrid = "0";

		String isfirstappr=request.getParameter("isfirstappr")==null || request.getParameter("isfirstappr")==""?"0":request.getParameter("isfirstappr");
		String  strSql1="",branchcond="";     
		String strbrch="select method from gl_config where field_nme='brchapproval'";
		ResultSet rsbrch = stmt1.executeQuery(strbrch);
		while(rsbrch.next()) {
			if(rsbrch.getInt("method")==1){
				branchcond= " and brhId="+brch ;
			}
			
		}
		
		if((Integer.parseInt(isfirstappr)==0)){
			//brhid="+brch+" and
		  strSql1="select * from fasttrack.my_Exdoc where  dtype='"+dtype+"' and userid="+usrid+"  "+branchcond;
		}
		else{
			//brhid="+brch+" and
		  strSql1="select * from fasttrack.my_Exdoc where  dtype='"+dtype+"' and userid="+usrid+" "+branchcond+" and apprlevel in (select apprlevel from my_exeb where brhid="+brch+" and dtype='"+dtype+"' and userid="+usrid+" and approved=0 "+branchcond+" ) order by apprlevel desc ";
		}
		
		
		System.out.println("====strSql15555555======"+strSql1);     
		
		System.out.println(strSql1);
		
	    ResultSet rs1 = stmt.executeQuery(strSql1);
		int apprlevel=0;
		int minapprl=0;
		while(rs1.next()) {
			
			apprlevel=rs1.getInt("apprlevel");
			minapprl=rs1.getInt("minapprls");
	  		}
		
		//and dt.brhId="+brch+"
		String strSql3 = "select count(*) as count from  fasttrack.my_exdoc dt   where dt.dtype='"+dtype+"' and dt.apprlevel="+apprlevel+" "+branchcond;
		
		System.out.println("strSql3====="+strSql3);
		
		ResultSet rs3 = stmt.executeQuery(strSql3);
		
		int apprlist=0;
		while(rs3.next()) {
			apprlist=rs3.getInt("count");
			
	  		}
		int aprstatus = 1;   

		String sqlStatus =
		"SELECT apprStatus " +
		"FROM fasttrack.my_exdet " +
		"WHERE doc_no=" + docno + " " +
		"AND dtype='" + dtype + "' " +
		"AND brhId=" + brch + " " +
		"ORDER BY sr_no DESC LIMIT 1";

		ResultSet rsStatus = stmt.executeQuery(sqlStatus);
		

		if(rsStatus.next()){
		    aprstatus = rsStatus.getInt("apprStatus");
		}
		System.out.println("DOCNO="+docno);
		System.out.println("DTYPE="+dtype);
		System.out.println("BRCH="+brch);
		System.out.println("SQL="+sqlStatus);
		System.out.println("FINAL APRSTATUS = " + aprstatus);
		rsStatus.close();

		
		
		
		
		response.getWriter().write(
			    usrid + "####" +
			    apprlevel + "####" +
			    minapprl + "####" +
			    apprlist + "####" +
			    aprstatus
			);
	
		
		stmt.close();
		conn.close();
		
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
