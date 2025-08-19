<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>

<%	
ClsConnection ClsConnection=new ClsConnection();
String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();

	Connection conn = null;
	 JSONArray resultArray = new JSONArray();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();   
		
		String strSql = "select @i:=@i+1 slno,a.* from(select ac.refname,sm.sal_name salesman, round(d.rsvqty,2) resqty from my_prddrevm m left join my_prddrevd d on d.rdocno=m.doc_no left join my_salm sm on sm.doc_no=m.salid left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where d.psrno='"+psrno+"')a, (select @i:=0)b";
		System.out.println(strSql);   
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			JSONObject obj = new JSONObject();
            obj.put("slno", rs.getInt("slno"));
            obj.put("salesman", rs.getString("salesman"));
            obj.put("resQty", rs.getInt("resqty"));
            obj.put("refname", rs.getString("refname"));         
            resultArray.add(obj);
	  	 } 
		
		response.getWriter().print(resultArray);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
