<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
JSONObject objdata=new JSONObject();
int errorstatus=0;
	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt=conn.createStatement();
		
		String salikaccount=request.getParameter("salikaccount");
		String expenseaccount=request.getParameter("expenseaccount");
		String status=request.getParameter("rano");
		String fleetno=request.getParameter("fleetno");
		String regno=request.getParameter("salikregno");
		String platecode=request.getParameter("platecode");
		String amounts=request.getParameter("amount");
		String mainbranch=request.getParameter("mainbranch");
		String docNo=request.getParameter("docno");
		String srno=request.getParameter("srno");
		String amountscount=request.getParameter("amountcount");
		String empId=request.getParameter("empid");
		String tagno=request.getParameter("tagno");
		String postdate=request.getParameter("postdate");
		String formdetailcode="JVT";
		String salikauhcount=request.getParameter("salikauhcount")==null?"0":request.getParameter("salikauhcount").toString();
		String salikdxbcount=request.getParameter("salikdxbcount")==null?"0":request.getParameter("salikdxbcount").toString();
		String salikauhamt=request.getParameter("salikauhamt")==null?"0":request.getParameter("salikauhamt").toString();
		String salikdxbamt=request.getParameter("salikdxbamt")==null?"0":request.getParameter("salikdxbamt").toString();
		
		String salikparkcount=request.getParameter("salikparkcount")==null?"0":request.getParameter("salikparkcount").toString();
		String salikparkamt=request.getParameter("salikparkamt")==null?"0":request.getParameter("salikparkamt").toString();
		
		String saliktype=request.getParameter("saliktype")==null?"":request.getParameter("saliktype").toString();
		
		java.sql.Date sqlDate=null;
		
		String sql=null,sql1=null,sql2=null,sql3=null,sql4=null,sql5=null;
		int docno = 0,trno = 0,currency=0,currencyexp=0,val=0,saliksrvemp=0,currencysrvemp=0;
		double rate = 0.00,rateexp = 0.00,ratesrvemp=0.00,value = 0.00;
		double amount = Double.parseDouble(amounts);
		int amountcount = Integer.parseInt(amountscount);
		int salikauhacno=0,salikdxbacno=0,salikauhsrvcacno=0,salikdxbsrvcacno=0;
		int salikauhcurid=0,salikdxbcurid=0,salikauhsrvccurid=0,salikdxbsrvccurid=0;
		int salikparkacno=0,saliksrvcparkacno=0;
		int salikparkcurid=0,saliksrvcparkcurid=0;
		double salikauhrate=0.0,salikdxbrate=0.0,salikauhsrvcrate=0.0,salikdxbsrvcrate=0.0;
		double salikparkrate=0.0,saliksrvcparkrate=0.0;
		
		if(!(postdate.equalsIgnoreCase("undefined"))&&!(postdate.equalsIgnoreCase(""))&&!(postdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(postdate);
		}
		String strgetexpacno="select ac.codeno,ac.acno,head.curid,head.rate from my_account ac left join my_head head on ac.acno=head.doc_no where codeno='EXPENSE ACCOUNT' union all"+
		" select ac.codeno,ac.acno,head.curid,head.rate from my_account ac left join my_head head on ac.acno=head.doc_no where codeno='EXPENSE ACCOUNT AUH'";
		int expdxbacno=0,expdxbcurid=0,expauhacno=0,expauhcurid=0;
		double expdxbrate=0.0,expauhrate=0.0;
		ResultSet rsgetexpacno=stmt.executeQuery(strgetexpacno);
		while(rsgetexpacno.next()){
			if(rsgetexpacno.getString("codeno").trim().equalsIgnoreCase("EXPENSE ACCOUNT")){
				expdxbacno=rsgetexpacno.getInt("acno");
				expdxbcurid=rsgetexpacno.getInt("curid");
				expdxbrate=rsgetexpacno.getDouble("rate");
			}
			else if(rsgetexpacno.getString("codeno").trim().equalsIgnoreCase("EXPENSE ACCOUNT AUH")){
				expauhacno=rsgetexpacno.getInt("acno");
				expauhcurid=rsgetexpacno.getInt("curid");
				expauhrate=rsgetexpacno.getDouble("rate");
			}
		}
		String strgetacno="select inv.idno,inv.description,inv.acno,head.CURID,head.RATE from gl_invmode inv left join my_head head on "+
				" inv.acno=head.DOC_NO where idno in (8,14,38,39,51,52)";
				ResultSet rsgetacno=stmt.executeQuery(strgetacno);
				while(rsgetacno.next()){
					if(rsgetacno.getInt("idno")==8){
						salikdxbacno=rsgetacno.getInt("acno");
						salikdxbcurid=rsgetacno.getInt("curid");
						salikdxbrate=rsgetacno.getDouble("rate");
					}
					else if(rsgetacno.getInt("idno")==38){
						salikauhacno=rsgetacno.getInt("acno");
						salikauhcurid=rsgetacno.getInt("curid");
						salikauhrate=rsgetacno.getDouble("rate");
					}
					else if(rsgetacno.getInt("idno")==39){
						salikauhsrvcacno=rsgetacno.getInt("acno");
						salikauhsrvccurid=rsgetacno.getInt("curid");
						salikauhsrvcrate=rsgetacno.getDouble("rate");
					}
					else if(rsgetacno.getInt("idno")==14){
						salikdxbsrvcacno=rsgetacno.getInt("acno");
						salikdxbsrvccurid=rsgetacno.getInt("curid");
						salikdxbsrvcrate=rsgetacno.getDouble("rate");
					}
					else if(rsgetacno.getInt("idno")==51){
						salikparkacno=rsgetacno.getInt("acno");
						salikparkcurid=rsgetacno.getInt("curid");
						salikparkrate=rsgetacno.getDouble("rate");
					}
					else if(rsgetacno.getInt("idno")==52){
						saliksrvcparkacno=rsgetacno.getInt("acno");
						saliksrvcparkcurid=rsgetacno.getInt("curid");
						saliksrvcparkrate=rsgetacno.getDouble("rate");
					}
				}   
		sql1="select curid,rate from my_head where doc_no="+salikaccount+"";
		ResultSet resultSet1 = stmt.executeQuery(sql1);
			  
		while (resultSet1.next()) {
		   currency=resultSet1.getInt("curid");
		   rate=resultSet1.getDouble("rate");
		}
		
		sql2="select curid,rate from my_head where doc_no="+expenseaccount+"";
		ResultSet resultSet2 = stmt.executeQuery(sql2);
			  
		while (resultSet2.next()) {
		   currencyexp=resultSet2.getInt("curid");
		   rateexp=resultSet2.getDouble("rate");
		}
		
		sql3="select value from gl_config where field_nme='saliksrvemp' and method=1";
		ResultSet resultSet3 = stmt.executeQuery(sql3);
			  
		while (resultSet3.next()) {
		   value=resultSet3.getDouble("value");
		}
		
		int method5=0;
		sql5="select method from gl_config where field_nme='StaffAllocatedSalikConfig'";
		ResultSet resultSet5 = stmt.executeQuery(sql5);
		while (resultSet5.next()) {
			method5 = resultSet5.getInt("method");
		}
		
		sql4="select i.acno,h.curid,h.rate from gl_invmode i left join my_head h on i.acno=h.doc_no where i.idno=14";
		ResultSet resultSet4 = stmt.executeQuery(sql4);
			  
		while (resultSet4.next()) {
			saliksrvemp=resultSet4.getInt("acno");
			currencysrvemp=resultSet4.getInt("curid");
			ratesrvemp=resultSet4.getDouble("rate");
		}
		
		ArrayList<String> salikarray= new ArrayList<String>();
		
		if(method5 == 1){
			salikarray.add(expenseaccount+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+currencyexp+"::"+rateexp+":: "+(amount+(value*amountcount))+":: "+(amount+(value*amountcount))*rateexp+":: "+srno+":: 1::6 :: "+fleetno); //Expense Account	
		}else{
			if(expauhacno==0 || (expdxbacno==expauhacno)){
				salikarray.add(expenseaccount+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+currencyexp+"::"+rateexp+":: "+(amount+(value*amountcount))+":: "+(amount+(value*amountcount))*rateexp+":: "+srno+":: 1::6 :: "+fleetno); //Expense Account	
			}
			else{
				if(Double.parseDouble(salikauhamt)>0.0){
					salikarray.add(expauhacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+expauhcurid+"::"+expauhrate+":: "+(Double.parseDouble(salikauhamt)+(value*Integer.parseInt(salikauhcount)))+":: "+(Double.parseDouble(salikauhamt)+(value*Integer.parseInt(salikauhcount)))*expauhrate+":: "+srno+":: 1::6 :: "+fleetno); //Expense Account
				}
				if(Double.parseDouble(salikdxbamt)>0.0){
					salikarray.add(expdxbacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+expdxbcurid+"::"+expdxbrate+":: "+(Double.parseDouble(salikdxbamt)+(value*Integer.parseInt(salikdxbcount)))+":: "+(Double.parseDouble(salikdxbamt)+(value*Integer.parseInt(salikdxbcount)))*expdxbrate+":: "+srno+":: 1::6 :: "+fleetno); //Expense Account
				}
				if(Double.parseDouble(salikparkamt)>0.0){
					salikarray.add(expdxbacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+expdxbcurid+"::"+expdxbrate+":: "+(Double.parseDouble(salikparkamt)+(value*Integer.parseInt(salikparkcount)))+":: "+(Double.parseDouble(salikparkamt)+(value*Integer.parseInt(salikparkcount)))*expdxbrate+":: "+srno+":: 1::6 :: "+fleetno); //Expense Account
				}
			}
		}
		
		if(Double.parseDouble(salikauhamt)>0){
			salikarray.add(salikauhacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+salikauhcurid+":: "+salikauhrate+":: "+Double.parseDouble(salikauhamt)*-1+":: "+(Double.parseDouble(salikauhamt)*salikauhrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Account
		}
		if(Double.parseDouble(salikdxbamt)>0){
			salikarray.add(salikdxbacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+salikdxbcurid+":: "+salikdxbrate+":: "+Double.parseDouble(salikdxbamt)*-1+":: "+(Double.parseDouble(salikdxbamt)*salikdxbrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Account
		}
		if(Double.parseDouble(salikparkamt)>0.0){
			salikarray.add(salikparkacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+salikparkcurid+":: "+salikparkrate+":: "+Double.parseDouble(salikparkamt)*-1+":: "+(Double.parseDouble(salikparkamt)*salikparkrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Account
		}
		
		
		//salikarray.add(salikaccount+":: Tag No: "+tagno+" of Fleet No: "+fleetno+" is Passed as Journal Voucher on "+sqlDate+":: "+currency+":: "+rate+":: "+amount*-1+":: "+(amount*rate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Account
	
	if(!(value==0)){
		if(Double.parseDouble(salikauhamt)>0){
			salikarray.add(salikauhsrvcacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+salikauhsrvccurid+":: "+salikauhsrvcrate+":: "+(value*Integer.parseInt(salikauhcount))*-1+":: "+(value*Integer.parseInt(salikauhcount)*salikauhsrvcrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Service Employee Account */
		}
		if(Double.parseDouble(salikdxbamt)>0){
			salikarray.add(salikdxbsrvcacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+salikdxbsrvccurid+":: "+salikdxbsrvcrate+":: "+(value*Integer.parseInt(salikdxbcount))*-1+":: "+(value*Integer.parseInt(salikdxbcount)*salikdxbsrvcrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Service Employee Account */
		}
		if(Double.parseDouble(salikparkamt)>0){
			salikarray.add(saliksrvcparkacno+":: Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+" is Passed as Journal Voucher on "+sqlDate+":: "+saliksrvcparkcurid+":: "+saliksrvcparkrate+":: "+(value*Integer.parseInt(salikparkcount))*-1+":: "+(value*Integer.parseInt(salikparkcount)*saliksrvcparkrate)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Service Employee Account */
		}
		/* salikarray.add(saliksrvemp+":: Tag No: "+tagno+" of Fleet No: "+fleetno+" is Passed as Journal Voucher on "+sqlDate+":: "+currencysrvemp+":: "+ratesrvemp+":: "+(value*amountcount)*-1+":: "+(value*amountcount*ratesrvemp)*-1+"::"+srno+":: -1:: 0:: 0"); //Salik Service Employee Account */
	}
	
		
		ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
		
		String sqlfilters="";
		
		if(!saliktype.equalsIgnoreCase("")){
			sqlfilters+=" and type='"+saliktype+"'";
		}
		
		int jvsalikcount=0;
		String strjvsalikcount="select count(*) itemcount from gl_salik where emp_id='"+empId+"' and fleetno='"+fleetno+"' and inv_no='0' "+sqlfilters;
		ResultSet rsjvsalikcount=stmt.executeQuery(strjvsalikcount);
		while(rsjvsalikcount.next()){
			jvsalikcount=rsjvsalikcount.getInt("itemcount");
		}
		if(jvsalikcount>0){
			
			for(int i=0;i<salikarray.size();i++){
				System.out.println(salikarray.get(i));
			}
			System.out.println(amount+"::"+(value*amountcount));
			docno=jvt.insert(sqlDate, formdetailcode.concat("-5"), status, "Tag No: "+tagno+" of Reg No: "+regno+"-"+platecode+"  is Passed as Journal Voucher on "+sqlDate, (amount+(value*amountcount)), (amount+(value*amountcount)), salikarray, session, request);
			trno=Integer.parseInt(request.getAttribute("tranno").toString());
			
			 sql="update gl_salik set inv_no='"+docno+"',inv_type='JVT',status=1 where emp_id='"+empId+"' and fleetno='"+fleetno+"' and inv_no='0'"+sqlfilters;
			 val= stmt.executeUpdate(sql);
		     
		     sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+mainbranch+"','BSAS',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		     int data= stmt.executeUpdate(sql);
		     objdata.put("docno",docno);	     
		     //response.getWriter().print(val+"***"+docno);		
		}
		else{
			errorstatus=1;
			//response.getWriter().print(0+"***"+0);
		}
		
		if(errorstatus==0){
			conn.commit();
		}
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	errorstatus=1;
		e.printStackTrace();
	 	
	 	conn.close();
   }finally{
	   conn.close();
   }
	objdata.put("errorstatus",errorstatus);
	
	response.getWriter().write(objdata+"");
%>
  
