<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.finance.transactions.unclearedchequereceipt.*" %>
<%
String bankacno=request.getParameter("bankacno")==null?"":request.getParameter("bankacno");
String mstr_form_date=request.getParameter("mstr_frm_date")==null?"":request.getParameter("mstr_frm_date");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String clientacno=request.getParameter("clientacno")==null?"":request.getParameter("clientacno");
String masterdocno=request.getParameter("agmtvocno")==null?"0":request.getParameter("agmtvocno").toString();
String pyttotalrent=request.getParameter("pyttotalrent")==null?"0":request.getParameter("pyttotalrent");
String pytadvance=request.getParameter("pytadvance")==null?"0":request.getParameter("pytadvance");
String pytbalance=request.getParameter("pytbalance")==null?"0":request.getParameter("pytbalance");
String pytstartdate=request.getParameter("pytstartdate")==null?"0":request.getParameter("pytstartdate");
String pytmonthsno=request.getParameter("pytmonthsno")==null?"0":request.getParameter("pytmonthsno");
String pytbankacno=request.getParameter("txtfromaccid")==null || request.getParameter("txtfromaccid")==""?"0":request.getParameter("txtfromaccid");

//String srno=request.getParameter("srno")==null?"0":request.getParameter("srno");
//System.out.println("masterdate"+mstr_form_date);
//System.out.println("pytstartdate"+pytstartdate);
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

java.sql.Date sqlpytdate=null;
java.sql.Date master_date=null;
if(!pytstartdate.equalsIgnoreCase("0") && !pytstartdate.equalsIgnoreCase("") && pytstartdate!=null){
	sqlpytdate=objcommon.changeStringtoSqlDate(pytstartdate);
}
if(!mstr_form_date.equalsIgnoreCase("0") && !mstr_form_date.equalsIgnoreCase("") && mstr_form_date!=null){
	master_date=objcommon.changeStringtoSqlDate(mstr_form_date);
}

//System.out.println(mstr_form_date+"= master_date ="+master_date);

ClsUnclearedChequeReceiptDAO ucrdao=new ClsUnclearedChequeReceiptDAO();
String chequearray=request.getParameter("chequearray")==null?"":request.getParameter("chequearray");
java.sql.Date sqldate=null;
java.sql.Date sqldate1=null;
String clientname="";
int srno=0;
int bpvno=0;
double currate=0.0;
double baseamt=0.0;
int clientdocno=0;
String curid=session.getAttribute("CURRENCYID").toString();
ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=chequearray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}
int status=0;
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String strclient="select (select refname from my_acbook where acno="+clientacno+") refname,(select cldocno from my_head where account="+clientacno+") clientdocno,"+
	" (select rate from my_curbook where doc_no=(select max(doc_no) from my_curbook where '"+sqlpytdate+"' between frmdate and todate and curid=(select curid from my_head where account="+clientacno+"))) rate";
	//System.out.println("Client Rate Query: "+strclient);
	ResultSet rsclient=stmt.executeQuery(strclient);
	while(rsclient.next()){
		clientname=rsclient.getString("refname");	     
		clientdocno=rsclient.getInt("clientdocno");
		currate=rsclient.getDouble("rate");
	}
	//System.out.println("mainarray========================="+mainarray);
	for(int i=0;i<mainarray.size();i++){
			String temp[]=mainarray.get(i).split("::");
	
		if(!temp[0].equalsIgnoreCase("") && !temp[0].equalsIgnoreCase("undefined") && temp[0]!=null){
			sqldate=objcommon.changetstmptoSqlDate(temp[0]);
		}
		
		if(!temp[6].equalsIgnoreCase("") && !temp[6].equalsIgnoreCase("undefined") && temp[6]!=null){
			sqldate1=objcommon.changetstmptoSqlDate(temp[6]);
		}
	    baseamt=Double.parseDouble(temp[1])*currate;
		double amount=Double.parseDouble(temp[1]);
		String chequeno=temp[2];
		String detaildocno=temp[3];
        String agmtno=temp[4];
		String cldocno=temp[5];
		String chequedate=temp[6];
		String clientnames=temp[7];
	if(detaildocno.equalsIgnoreCase("")){
	String sql="select coalesce((max(srno)+1),1) srno from gl_leasepytcalc";
	ResultSet rs1=stmt.executeQuery(sql);
	while(rs1.next()){
      srno=rs1.getInt("srno");

	}

	detaildocno=srno+"";
    String sql12="INSERT INTO gl_leasepytcalc(srno,date,amount,rdocno,chequeno)VALUES("+detaildocno+",'"+sqldate1+"',"+amount+","+agmtno+","+chequeno+")";
	//System.out.println("insertfun========="+sql12);
	int pytcalcinsert=stmt.executeUpdate(sql12);
	if(pytcalcinsert<=0){
		System.out.println("Pyt Calc Insert Error");
		status=0;
	 }
	}
	ArrayList<String> ucrarray=new ArrayList<String>();
	ucrarray.add(bankacno+"::"+curid+"::"+currate+"::false::"+amount+"::Cheque for LAG "+docno+"::"+baseamt+"::0::0::0");
	//ucrarray.add("undefined"+"::"+curid+"::"+currate+"::false::"+amount+"::Cheque for LAG "+docno+"::"+baseamt+"::0::0::0");
	ucrarray.add(clientacno+"::"+curid+"::"+currate+"::true::"+amount*-1+"::Cheque for LAG "+docno+"::"+baseamt*-1+"::0::0::0");
	//System.out.println("arraysys======="+ucrarray);
	int val=ucrdao.insert(master_date, "UCR", "LAG - "+docno, currate, sqldate1, chequeno,clientnames, 0,"Cheque for LAG "+docno, amount,
			clientdocno, ucrarray, session, request, "A");
	//System.out.println("val: "+val);
	
	if(val<=0){
		System.out.println("UCR Insert Error");
		status=0;
	}
	else{
		String strupdate="update gl_leasepytcalc set bpvno="+val+",chequeno='"+chequeno+"' where srno="+detaildocno;
		//System.out.println("Update Query1: "+strupdate);
		int updateval=stmt.executeUpdate(strupdate);
		if(updateval>0){
			
			status=1;		
		}
		else{
			System.out.println("Pyt update Error");
			status=0;
		}

	}
	  }
	
	//System.out.println("status"+status);


	if(status==1){
		String lagupdate="update gl_lagmt set pytbankacno="+bankacno+" where doc_no="+docno;
		//System.out.println(lagupdate);
		int lagupdateval=stmt.executeUpdate(lagupdate);
		if(lagupdateval<0){
			status=0;
		}
		else{
			status=1;
			conn.commit();
		}
	}

}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
/*		
Date unclearedChequeReceiptDate, String formdetailcode,String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, int chckpdc, 
String txtdescription, double txtdrtotal, int txttodocno, ArrayList<String> unclearedchequereceiptarray, HttpSession session, HttpServletRequest request, String mode*/

/* 2016-10-09::UCR::::1.0::2016-10-09::123::Checker::0::Checking UCR::500.0::2268
1036::1::1.0::false::500.0::Checking UCR::500.0::0::0::0
2268::1::1.0::true::-500.0::Checking UCR::-500.0::0::0::0 
unclearedchequereceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0");
unclearedchequereceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::0::0::0");

*/
response.getWriter().write(status+"");
%>