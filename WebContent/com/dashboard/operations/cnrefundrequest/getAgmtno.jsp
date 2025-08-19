<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno").trim();
	String agmttype = request.getParameter("agmttype")==null?"":request.getParameter("agmttype").trim();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String strsql = "";
		if(!cldocno.equalsIgnoreCase("0")){
		if(agmttype.equalsIgnoreCase("RAG")){
			strsql="select r.voc_no,r.doc_no, concat(r.voc_no,' - Fleet#',r.fleet_no) agmtno, r.cldocno, r.mrano,v.reg_no from gl_ragmt r  "
					+ " left join gl_vehmaster v on v.fleet_no=r.fleet_no where r.status=3 and (r.cldocno='"+cldocno+"' or actualcldocno='"+cldocno+"' or insurcldocno='"+cldocno+"');";  
		}else if(agmttype.equalsIgnoreCase("LAG")){
			strsql = "select r.voc_no,r.doc_no, concat(r.voc_no,' - Fleet#',if(r.perfleet<>0,r.perfleet,r.tmpfleet)) agmtno, r.cldocno, v.reg_no from gl_lagmt r"+
	    			" left join gl_vehmaster v on v.fleet_no=if(r.perfleet<>0,r.perfleet,r.tmpfleet) where r.status=3 and r.cldocno='"+cldocno+"'";  
		}else{}
		}
	//	System.out.println("AGMTSQL===="+strsql);
		String emp="", empid="";
		// System.out.println(strsql);
		if(!strsql.equals("")){   
			ResultSet rs = stmt.executeQuery(strsql);      
			while(rs.next()) {
				emp+=rs.getString("agmtno")+",";
				empid+=rs.getString("doc_no")+",";  
		    }
		}
		if(!emp.equals("")){
			emp=emp.substring(0, emp.length()>0?emp.length()-1:0); 
		}
		
		
		response.getWriter().write(emp+"####"+empid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
