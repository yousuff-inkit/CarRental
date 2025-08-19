<%@page import="com.dashboard.consolidated.stocklist.ClsStocklistBean"%>
<%@page import="com.dashboard.consolidated.stocklist.ClsStocklistDAO"%>    
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%	
    ClsStocklistDAO prb = new ClsStocklistDAO();
    ClsStocklistBean bean = new ClsStocklistBean();     
	try{
			
		JSONArray locArray = new JSONArray();
		JSONObject objprb = new JSONObject(); 
		
	  	String locname = request.getParameter("locname")==null?"":request.getParameter("locname").trim();
	  	String aa = request.getParameter("aa")==null?"":request.getParameter("aa").trim();
	  	//alert(1);
		bean.setLocationname(locname);
		bean.setLoad(aa);
		
		locArray = prb.locationSearch(bean);       
		
		System.out.println("locArray==="+locArray);    
		response.getWriter().print(locArray);
		
	}catch(Exception e){
	 	e.printStackTrace();
	 	
	}finally{
		
	}
  %>