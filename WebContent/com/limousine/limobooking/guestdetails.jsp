<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

Connection conn=null;
JSONArray gridarray=new JSONArray();
JSONObject objdata=new JSONObject();
System.out.println("--------In--------");

try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();

			String strsql="select doc_no,guest,guestcontactno from gl_limoguest where status=3";
			JSONArray guestData = new JSONArray();
			System.out.println("GET Tarif Docno Limo Query: "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("docno",rs.getString("doc_no"));
				objtemp.put("guest",rs.getString("guest"));
				objtemp.put("guestcontactno",rs.getString("guestcontactno"));
				guestData.add(objtemp);
			}
		objdata.put("guestData", guestData);            
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(objdata+"");
%>
