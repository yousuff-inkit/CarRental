<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%	
    String docNo = request.getParameter("docNo")==null || request.getParameter("docNo").equals("")?"0":request.getParameter("docNo").trim();
	String check = request.getParameter("check")==null || request.getParameter("check").equals("")?"0":request.getParameter("check").trim();

	try{
		ClsClientDAO clientDao = new ClsClientDAO();  
		JSONArray driverArray = new JSONArray();
		
		
		driverArray = clientDao.driverGridReloading(docNo,check);
		
		//System.out.println("driverArray==="+driverArray);
		
		response.getWriter().print(driverArray);
	}catch(Exception e){
	 	e.printStackTrace();
	}
  %>