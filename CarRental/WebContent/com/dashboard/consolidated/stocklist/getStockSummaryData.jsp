<%@page import="com.dashboard.consolidated.stocklist.ClsStocklistBean"%>
<%@page import="com.dashboard.consolidated.stocklist.ClsStocklistDAO"%>    
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>  
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%	
    ClsStocklistDAO prd = new ClsStocklistDAO();
    ClsStocklistBean bean = new ClsStocklistBean();     
	try{
		JSONArray stockArray = new JSONArray();
		JSONObject objprd = new JSONObject(); 
		
		String flbarchval = request.getParameter("barchval")==null?"":request.getParameter("barchval").trim();
	  	String flload = request.getParameter("load")==null?"":request.getParameter("load").trim();
	  	String fllocid = request.getParameter("locid")==null?"":request.getParameter("locid").trim();
	  	String flhidbrand = request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand").trim();
	  	String flhidtype = request.getParameter("hidtype")==null?"":request.getParameter("hidtype").trim();
	  	String flhidproduct = request.getParameter("hidproduct")==null?"":request.getParameter("hidproduct").trim();
	  	String flhidcat = request.getParameter("hidcat")==null?"":request.getParameter("hidcat").trim();
	  	String flhidsubcat = request.getParameter("hidsubcat")==null?"":request.getParameter("hidsubcat").trim();
	  	String flhidept = request.getParameter("hidept")==null?"":request.getParameter("hidept").trim();
	  	String flzeroqty = request.getParameter("zeroqty")==null?"":request.getParameter("zeroqty").trim();
	  	String fltodate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	  	String flexpupto = request.getParameter("expupto")==null?"":request.getParameter("expupto").trim();
		String hidcompid = request.getParameter("hidcompid")==null?"":request.getParameter("hidcompid").trim();

		bean.setFlbarchval(flbarchval);
		bean.setFlexpupto(flexpupto);
		bean.setFlhidbrand(flhidbrand);
		bean.setFlhidcat(flhidcat);
		bean.setFlhidept(flhidept);
		bean.setFlhidproduct(flhidproduct);
		bean.setFlhidsubcat(flhidsubcat);
		bean.setFlhidtype(flhidtype);
		bean.setFlload(flload);
		bean.setFllocid(fllocid);
		bean.setFltodate(fltodate);
		bean.setFlzeroqty(flzeroqty);
		bean.setHidcompid(hidcompid);
		System.out.println("hidcompid==="+hidcompid);   
		stockArray = prd.stocklist(bean);
		
		System.out.println("stockArray==="+stockArray);    
		response.getWriter().print(stockArray);
		
	}catch(Exception e){
	 	e.printStackTrace();
	 	
	}finally{
		
	}
  %>