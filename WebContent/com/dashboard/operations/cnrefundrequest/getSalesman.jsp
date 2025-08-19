<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	String agmttype = request.getParameter("agmttype")==null || request.getParameter("agmttype").equals("")?"":request.getParameter("agmttype").trim();
	String agmtno = request.getParameter("agmtno")==null?"":request.getParameter("agmtno").trim();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String strsql = "";
		  
		if(agmttype.equalsIgnoreCase("RAG")){
		//	strsql=" select r.salid,(select method from gl_config where field_nme='delcal') delcal, coalesce(s.sal_name) sal_name ,coalesce(CONVERT(DATE_FORMAT(rm.indate,'%d.%m.%Y'),char(25)),'') indate  ,coalesce(CONVERT(DATE_FORMAT(rm.coldate,'%d.%m.%Y'),char(25)),'') coldate From gl_ragmt r  left join gl_ragmtclosem rm on rm.agmtno=r.doc_no left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' left join my_salm s on s.doc_no=ac.sal_id where r.voc_no="+agmtno;  
			strsql=" select r.salid,(select method from gl_config where field_nme='delcal') delcal, coalesce(s.sal_name) sal_name ,coalesce(rm.indate,'') indate  ,coalesce(rm.coldate,'') coldate From gl_ragmt r  left join gl_ragmtclosem rm on rm.agmtno=r.doc_no left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' left join my_salm s on s.doc_no=ac.sal_id where r.voc_no="+agmtno;  
			}else if(agmttype.equalsIgnoreCase("LAG")){
			//strsql="   select r.salid, (select method from gl_config where field_nme='delcal') delcal,coalesce(s.sal_name) sal_name ,coalesce(CONVERT(DATE_FORMAT(rm.indate,'%d.%m.%Y'),char(25)),'') indate  ,coalesce(CONVERT(DATE_FORMAT(rm.coldate,'%d.%m.%Y'),char(25)),'') coldate From gl_lagmt r  left join gl_lagmtclosem rm on rm.agmtno=r.doc_no  left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM'  left join my_salm s on s.doc_no=ac.sal_id where r.voc_no="+agmtno;  
				strsql="   select r.salid, (select method from gl_config where field_nme='delcal') delcal,coalesce(s.sal_name) sal_name ,coalesce(rm.indate,'') indate  ,coalesce(rm.coldate,'') coldate From gl_lagmt r  left join gl_lagmtclosem rm on rm.agmtno=r.doc_no  left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM'  left join my_salm s on s.doc_no=ac.sal_id where r.voc_no="+agmtno;  
					}else{}
	//	System.out.println("AGMTSQLsalesman===="+strsql);
		String salname="", indate="",cldate="", coldate="",delcal="",hidsalname="";
		// System.out.println(strsql);
		if(!strsql.equals("")){   
			ResultSet rs = stmt.executeQuery(strsql);      
			while(rs.next()) {
				salname+=rs.getString("sal_name")+",";
				hidsalname+=rs.getString("salid")+",";
				indate+=rs.getString("indate")+","; 
				coldate+=rs.getString("coldate")+",";  
				delcal=rs.getString("delcal"); 
		    }
			if(coldate!=null && delcal=="0"){
				//Delivery Date And Time
				cldate=coldate;
			}
			else{
				//Agreement Date And Time
				cldate=indate;  
			}
			
		}
		 if(!salname.equals("")){
			 salname=salname.substring(0, salname.length()>0?salname.length()-1:0); 
		}
		if(!cldate.equals("")){
			cldate=cldate.substring(0, cldate.length()>0?cldate.length()-1:0); 
		} 
	 	if(!hidsalname.equals("")){
			hidsalname=hidsalname.substring(0, hidsalname.length()>0?hidsalname.length()-1:0); 
		}  

		response.getWriter().write(salname+"####"+cldate+"####"+hidsalname);
		//System.out.println("salemans====="+salname+"####"+cldate+"####"+hidsalname);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
