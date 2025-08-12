package com.dashboard.accounts.accountsstatement;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsAccountsStatementAction extends ActionSupport{
    
	ClsAccountsStatementDAO accountStatementDAO= new ClsAccountsStatementDAO();
	ClsAccountsStatementBean accountStatementBean;
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private double txtnetamount;
	
	//Print
	private String lblcompname,curcode;
	private String lblcompaddress,brnchaddress;
	public String getBrnchaddress() {
		return brnchaddress;
	}
	public void setBrnchaddress(String brnchaddress) {
		this.brnchaddress = brnchaddress;
	}
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcomptel2;
	private String lblcompwebsite;
	private String lblcompemail;
	
	private String accountno;
	private String accountname;
	private String accountaddress;
	private String accountemail;
	private String accountmobile;
	private String accountphone;
	private String accountfax;
	private String creditperiodmin;
	private String creditperiodmax;
	private String creditlimit;
	private String date;
	private String type;
	private String docno;
	private String description;
	private String debit;
	private String credit;
	private String lblnetdebitamount;
	private String lblnetcreditamount;
	private String lblnetamount;
	private String lblnetsecurityamount;
	
	private Map<String, Object> param = null;
	
	public double getTxtnetamount() {
		return txtnetamount;
	}
	public void setTxtnetamount(double txtnetamount) {
		this.txtnetamount = txtnetamount;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	private String lblbranchaddress;
	public String getLblbranchaddress() {
		return lblbranchaddress;
	}
	public void setLblbranchaddress(String lblbranchaddress) {
		this.lblbranchaddress = lblbranchaddress;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblcomptel2() {
		return lblcomptel2;
	}
	public void setLblcomptel2(String lblcomptel2) {
		this.lblcomptel2 = lblcomptel2;
	}
	public String getLblcompwebsite() {
		return lblcompwebsite;
	}
	public void setLblcompwebsite(String lblcompwebsite) {
		this.lblcompwebsite = lblcompwebsite;
	}
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	public String getAccountno() {
		return accountno;
	}
	public void setAccountno(String accountno) {
		this.accountno = accountno;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getAccountaddress() {
		return accountaddress;
	}
	public void setAccountaddress(String accountaddress) {
		this.accountaddress = accountaddress;
	}
	public String getAccountemail() {
		return accountemail;
	}
	public void setAccountemail(String accountemail) {
		this.accountemail = accountemail;
	}
	public String getAccountmobile() {
		return accountmobile;
	}
	public void setAccountmobile(String accountmobile) {
		this.accountmobile = accountmobile;
	}
	public String getAccountphone() {
		return accountphone;
	}
	public void setAccountphone(String accountphone) {
		this.accountphone = accountphone;
	}
	public String getAccountfax() {
		return accountfax;
	}
	public void setAccountfax(String accountfax) {
		this.accountfax = accountfax;
	}
	public String getCreditperiodmin() {
		return creditperiodmin;
	}
	public void setCreditperiodmin(String creditperiodmin) {
		this.creditperiodmin = creditperiodmin;
	}
	public String getCreditperiodmax() {
		return creditperiodmax;
	}
	public void setCreditperiodmax(String creditperiodmax) {
		this.creditperiodmax = creditperiodmax;
	}
	public String getCreditlimit() {
		return creditlimit;
	}
	public void setCreditlimit(String creditlimit) {
		this.creditlimit = creditlimit;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDebit() {
		return debit;
	}
	public void setDebit(String debit) {
		this.debit = debit;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getLblnetdebitamount() {
		return lblnetdebitamount;
	}
	public void setLblnetdebitamount(String lblnetdebitamount) {
		this.lblnetdebitamount = lblnetdebitamount;
	}
	public String getLblnetcreditamount() {
		return lblnetcreditamount;
	}
	public void setLblnetcreditamount(String lblnetcreditamount) {
		this.lblnetcreditamount = lblnetcreditamount;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetsecurityamount() {
		return lblnetsecurityamount;
	}
	public void setLblnetsecurityamount(String lblnetsecurityamount) {
		this.lblnetsecurityamount = lblnetsecurityamount;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String saveAction() throws ParseException, SQLException{
		return accountname;
	}
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
     //   JasperDesign design=null;
    //    JasperReport jasperReport=null;
    //    param=null;
		try {
               //System.out.println("printaction");
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
               
               int acno=Integer.parseInt(request.getParameter("acno"));
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
        	   String toDate = request.getParameter("toDate");
        	   String chckopn = request.getParameter("chckopn")==null?"0":request.getParameter("chckopn");
        	   String email = request.getParameter("email")==null?"0":request.getParameter("email");
        	   String print = request.getParameter("print")==null?"0":request.getParameter("print");
        	   String allcase = request.getParameter("allcase")==null?"0":request.getParameter("allcase");
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
               //System.out.println("xlstat---"+xlstat);
        	   accountStatementBean=accountStatementDAO.getPrint(request,acno,branch,fromDate,toDate);
        	 
        	   String printPathSql="select CONCAT('AS',atype) dtype from my_head where doc_no="+acno+"";
        	   ResultSet resultSetPrintPath = stmtAccountStatement.executeQuery(printPathSql);
	       	   String printPathDtype="BIB",unClrChqShow="0",unClrChqShow2="0";
	       	   while(resultSetPrintPath.next()){
	       			printPathDtype=resultSetPrintPath.getString("dtype");
	       		}
	       	   
	       	   if(printPathDtype.equalsIgnoreCase("ASAR")) {
		       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAR'";
	     	       ResultSet resultSetUnclrChq = stmtAccountStatement.executeQuery(unclrChqView);
		       	   while(resultSetUnclrChq.next()){
		       		   unClrChqShow=resultSetUnclrChq.getString("value");
		       		}
	       	   }
	       	if(printPathDtype.equalsIgnoreCase("ASAP")) {
		       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAP'";
	     	       ResultSet resultSetUnclrChq = stmtAccountStatement.executeQuery(unclrChqView);
		       	   while(resultSetUnclrChq.next()){
		       		   unClrChqShow2=resultSetUnclrChq.getString("value");
		       		}
	       	   }
	       	      
	       	   
        	   String reportFileName = commonDAO.getBIBPrintPath(printPathDtype);
        	   //System.out.println("printpath"+reportFileName);
        	   int value=0;
        	   String gsPrintHeader="select coalesce(method,0) val from gl_config where field_nme='greenstarPrintHeader'";
     	       ResultSet resultSetgsPrintHeader = stmtAccountStatement.executeQuery(gsPrintHeader);
	       	   while(resultSetgsPrintHeader.next()){     
	       		   value=resultSetgsPrintHeader.getInt("val");     
	       		}
	       	   
	       	  String doc_no="",atype="";
	       	 String accounttyp="select atype from my_head where doc_no="+acno+"";
	       	  ResultSet resultAccounttype=stmtAccountStatement.executeQuery(accounttyp);
	       	while(resultAccounttype.next()){
	       		atype=resultAccounttype.getString("atype");
	       	}
	       	String configSqlAll="select method from gl_config where field_nme='accountstatementAll'";
			ResultSet configrsall=stmtAccountStatement.executeQuery(configSqlAll);
			int configMethodAll=0;
			while(configrsall.next()){
				configMethodAll=configrsall.getInt("method");
			}
			if(configMethodAll==1){
	       	ArrayList<String> invarray=new ArrayList<String>();
	       	   String accounttypeAll="select h.doc_no,sum(ldramount) tot,(out_amount) tot1 from my_head h left join my_jvtran j on h.doc_no=j.acno and j.status=3 where atype="+"'"+atype+"'"+" and m_s=0 group by h.doc_no having tot!=0";
	       	   System.out.println("accounttypeAll=="+accounttypeAll);
	       	   ResultSet resultaccounttypeAll=stmtAccountStatement.executeQuery(accounttypeAll);
	       	   while(resultaccounttypeAll.next()){
	       		//int i=0;
	       		   doc_no=resultaccounttypeAll.getString("doc_no");
	       		
				if(doc_no.contains(":")){
					String [] inv=new String []{};
					inv=doc_no.split(":");
					for(int i=0;i<inv.length;i++){
						invarray.add(i, inv[i]);
					}
				}
				else{
					invarray.add(0, doc_no);
				}
				
	       	   }
	       	param.put("docnos", invarray);
			}
	       
	       	param.put("acno", acno);
	        //param.put("acno", acno);
		      // System.out.println("acno--"+acno);
			//System.out.println("invarray=="+invarray);
	       	   String imgpath="";           
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
	       	   if(value>0){
	       		  if(branch.equalsIgnoreCase("1")){   
	       			imgpath=request.getSession().getServletContext().getRealPath("/icons/greenstarlogo1.jpg");
		            imgpath=imgpath.replace("\\", "\\\\");     
	       		  }else if(branch.equalsIgnoreCase("2")){
	       			 imgpath=request.getSession().getServletContext().getRealPath("/icons/greenstarlogo2.jpg");
		            imgpath=imgpath.replace("\\", "\\\\");  
	       		  }else if(branch.equalsIgnoreCase("3")){
	       			 imgpath=request.getSession().getServletContext().getRealPath("/icons/greenstarlogo3.jpg");    
		            imgpath=imgpath.replace("\\", "\\\\");  
	       		  }else{    
	       			imgpath=request.getSession().getServletContext().getRealPath("/icons/greenstarlogo1.jpg");
		            imgpath=imgpath.replace("\\", "\\\\");                             
	       		  }
	       	   }else{
	       		 imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");  
	       	   }
               
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                
               String accountstatementsql = "",openingsql="",multiaccountstatementsql="",accountstatementsql1 = "",openingsql1="";
       		
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   accountstatementsql+=" and t.brhId="+branch+"";
	       		 accountstatementsql1+=" and t.brhId="+branch+"";
	       		multiaccountstatementsql+=" and t.brhId="+branch+"";
	       	   }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
	       	   if(chckopn.equalsIgnoreCase("1")){
	       		
	       		   openingsql = " union all select 0 tranid,t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t "
	       				   + "where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+accountstatementsql+" and t.acno= "+acno+" group by t.acno,t.curId";
	       		//for cosmocarrental print  openingsql1
	       		 openingsql1 = " union all select  t.rtype,t.rdocno,0 tranid,t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t "
	       				   + "where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+accountstatementsql1+" and t.acno= "+acno+" group by t.acno,t.curId";
	       	
	       	   }
	       	String accountsqlpal = "select b.regno,b.claimno,b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select tranid,a.regno,a.claimno,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select tranid,invd.regno,invd.claimno,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,tranid,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" left join ws_invcalctemp invd on invd.invno=mnt.doc_no order by dt,tranid,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
       	   //System.out.println("accountsqlpal==="+accountsqlpal);  
				/*accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,tranid,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,tranid,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";*/ //Modified on 2023-01-23 added transacted values also
	       	
	       /*	accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue,b.dr,b.cr,b.nettotalin,b.netdebittotalin,b.netcredittotalin,if(b.netamountvaluein<0,CONCAT(format((b.netamountvaluein*-1),2),' Cr'),CONCAT(format(b.netamountvaluein,2),' Dr')) netamountvaluein from (select tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue, format(a.dr,2) dr, format(a.cr,2) cr,format(round(@p:=@p+a.nettotalamountin,2),2) nettotalin,format(round(@q:=@q+round(a.dr,2),2),2) netdebittotalin,format(round(@r:=@r+round((a.cr),2),2),2) netcredittotalin,coalesce(round(@s:=@s+nettotalamountin,2),0) netamountvaluein from ( "
	       			+ "select tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount,a.dr,a.cr,format(round((a.dr+(a.cr)*-1),2),2) nettotalin,round((a.dr+(a.cr)*-1),2) nettotalamountin from ("
	       			+ "select tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno='"+acno+"' and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,tranid,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,tranid,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l,(select @p:=0) as p,(select @q:=0) as q,(select @r:=0) as r,(select @s:=0) as s) b";*/
				
	       	accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue,b.dr,b.cr,b.nettotalin,b.netdebittotalin,b.netcredittotalin,if(b.netamountvaluein<0,CONCAT(format((b.netamountvaluein*-1),2),' Cr'),CONCAT(format(b.netamountvaluein,2),' Dr')) netamountvaluein from (select a.tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue, format(a.dr,2) dr, format(a.cr,2) cr,format(round(@p:=@p+a.nettotalamountin,2),2) nettotalin,format(round(@q:=@q+round(a.dr,2),2),2) netdebittotalin,format(round(@r:=@r+round((a.cr),2),2),2) netcredittotalin,coalesce(round(@s:=@s+nettotalamountin,2),0) netamountvaluein from ( "
	       			+ "select a.tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount,a.dr,a.cr,format(round((a.dr+(a.cr)*-1),2),2) nettotalin,round((a.dr+(a.cr)*-1),2) nettotalamountin from ("
	       			+ "select t.tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno='"+acno+"' and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,tranid,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,a.tranid,a.TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l,(select @p:=0) as p,(select @q:=0) as q,(select @r:=0) as r,(select @s:=0) as s) b";
	       	
	       	//for cosmocarrental print  accountstatementsql1
	    	accountstatementsql1 = "select b.lpo,b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue,b.dr,b.cr,b.nettotalin,b.netdebittotalin,b.netcredittotalin,if(b.netamountvaluein<0,CONCAT(format((b.netamountvaluein*-1),2),' Cr'),CONCAT(format(b.netamountvaluein,2),' Dr')) netamountvaluein from (select CASE WHEN a.rtype='RAG' THEN COALESCE(a.pono,'') WHEN a.rtype='LAG' THEN COALESCE(a.po,'') ELSE '' END lpo,a.rtype,a.rdocno,a.tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue, format(a.dr,2) dr, format(a.cr,2) cr,format(round(@p:=@p+a.nettotalamountin,2),2) nettotalin,format(round(@q:=@q+round(a.dr,2),2),2) netdebittotalin,format(round(@r:=@r+round((a.cr),2),2),2) netcredittotalin,coalesce(round(@s:=@s+nettotalamountin,2),0) netamountvaluein from ( "
	       			+ "select rag.pono,lag.po,a.rtype,a.rdocno,a.tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount,a.dr,a.cr,format(round((a.dr+(a.cr)*-1),2),2) nettotalin,round((a.dr+(a.cr)*-1),2) nettotalamountin from ("
	       			+ "select  t.rtype,t.rdocno,t.tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select  t.rtype,t.rdocno,t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql1+" and t.acno='"+acno+"' and t.yrid=0"+openingsql1+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,tranid,transNo,t.curId,transType) a  LEFT JOIN gl_ragmt rag ON (a.rtype='RAG' AND a.rdocno=rag.doc_no and rag.status=3) LEFT JOIN gl_lagmt lag ON (a.rtype='LAG' AND a.rdocno=lag.doc_no and lag.status=3) left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,a.tranid,a.TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l,(select @p:=0) as p,(select @q:=0) as q,(select @r:=0) as r,(select @s:=0) as s) b";
	
	
	       	
	       /*	multiaccountstatementsql="select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.dr,b.cr,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
		       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit, round(a.dr,2) dr, round(a.cr,2) cr,"
		       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
		       			+ "select tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.dr,a.cr,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
		       			+ "select tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
		       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
		       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+multiaccountstatementsql+" and  '"+acno+"' and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
		       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";*/
	       	
	     	multiaccountstatementsql="select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.dr,b.cr,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.tranid,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit, round(a.dr,2) dr, round(a.cr,2) cr,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select a.tranid,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.dr,a.cr,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select t.tranid,h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.tranid,t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+multiaccountstatementsql+" and  t.acno='"+acno+"' and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,a.TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
		//	System.out.println("accountstatementPrint=="+accountstatementsql);
		//	System.out.println("accountstatementPrint1=="+accountstatementsql1);
			
			//System.out.println("multia/c====="+multiaccountstatementsql);
				ResultSet resultSetAccountStatement = stmtAccountStatement.executeQuery(accountstatementsql);
	       		
				String netdebittotal="0",netcredittotal="0",netamount="0",netdebittotalin="0",netcredittotalin="0",netamountin="0";
	       		while(resultSetAccountStatement.next()){
	       			sqlAccountStatementResult="1";
	       			
	       			netdebittotal = resultSetAccountStatement.getString("netdebittotal");
	       			netcredittotal = resultSetAccountStatement.getString("netcredittotal");
	       			netamount = resultSetAccountStatement.getString("nettotal");
	       			
	       			netdebittotalin = resultSetAccountStatement.getString("netdebittotalin");
	       			netcredittotalin = resultSetAccountStatement.getString("netcredittotalin");
	       			netamountin = resultSetAccountStatement.getString("nettotalin");
	       		}  
				
	       		String securitysql = "";   
	       		
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			securitysql+=" and j.brhId="+branch+"";
	       		}
	       		
	       		securitysql = "select DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,j.doc_no,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,"  
	       			 + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),0),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
	       			 + "select sum(secamount) secamount1,a.* from ( select date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
	       			 + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by rdocno,rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
	       			 + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
	       			 + "where secamount!=0 and j.date<='"+sqlToDate+"' and c.acno="+acno+""+securitysql+" order by rdocno,rtype";  
	       	
	       		// changed security query because it shows sum of all doc , need to be seperated doc- this was now made changes and removed commented portion and made old query works on 17-06-2025
	       		
	       		/*securitysql = "select DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,j.doc_no,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,"  
	                     + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),0),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
	                     + "select sum(secamount) secamount1,a.* from ( select tr_no,date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
	                     + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by tr_no,rtype) a group by tr_no,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
	                     + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
	                     + "where secamount!=0 and j.date<='"+sqlToDate+"' and c.acno="+acno+""+securitysql+" order by tr_no,rtype";  
	            */
	       		// j.date>='"+sqlFromDate+"'  and 
	       		
	       		//System.out.println("==== securitysql == "+securitysql);
	       	   ResultSet resultSetSecurity = stmtAccountStatement.executeQuery(securitysql);
	       	   Double netsecurityamount=0.00;
	       	   while(resultSetSecurity.next()){
	       		    sqlSecurityResult="1";
	       			netsecurityamount=netsecurityamount+resultSetSecurity.getDouble("securityamount");
	       	   }
	       	   
	       	   netsecurityamount = commonDAO.Round(netsecurityamount, 2);
	       	
	       	   String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	   Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
	       	   if(unClrChqShow.equalsIgnoreCase("1.00000")){
		       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		       			unclearedreceiptssql+=" and m.brhId="+branch+"";
		       		}
		       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
		       				+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
		       		   		+ " CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m "
		       		   		+ " left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) where m.status=3 and m.bpvno=0 and m.chqdt>='"+sqlFromDate+"'  and m.chqdt<='"+sqlToDate+"' and d.acno="+acno+""+unclearedreceiptssql+") a,"
		       				+ "(select @i:=0) as i";
		       		//System.out.println("==unclearedreceiptssql=="+unclearedreceiptssql);
		       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
		       		
		       		while(resultSetUnclearAccountStatement.next()){
		       			sqlUnclrAccountStatementResult="1";
		       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
		       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
		       		}
		       		
		       		netunclramount=netunclrdebittotal-netunclrcredittotal;
		       		
		       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
		       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
		       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	   }
	       	if(unClrChqShow2.equalsIgnoreCase("2.00000") || unClrChqShow.equalsIgnoreCase("2.00000")){
//	       		System.out.println("====aaaa=="+unClrChqShow2);
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			unclearedreceiptssql+=" and m.brhId="+branch+"";
	       		}
       		
	       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
	       			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
	       			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
					+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
					+" where m.status=3 and d1.pdc=1 and d1.status='E' and m.date<='"+sqlToDate+"' and d.acno = "+acno+" "+unclearedreceiptssql+" ) a, (select @i:=0) as i order by date ";
//	       		System.out.println("===sqllaaa=="+unclearedreceiptssql);
	       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
	       		
	       		while(resultSetUnclearAccountStatement.next()){
	       			sqlUnclrAccountStatementResult="1";
	       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
	       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
	       		}
	       		
	       		netunclramount=netunclrdebittotal-netunclrcredittotal;

	       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
	       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
	       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	}
	       	
	       	String detailsql="",mainbranch="";
	        param.put("sqlFromDate", sqlFromDate);	
	           param.put("sqlToDate", sqlToDate);
       	   param.put("accountsqlpal", accountsqlpal);	
	           param.put("imgpath", imgpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	           	    mainbranch=branch;        	
		   		}else{
		   			//mainbranch="1";
		   		}   
	           if(value>0){
	        	   String gsPrintDet="";
	        	   if(mainbranch.trim().equalsIgnoreCase("")){
	        	       gsPrintDet="select branchname, address, tel, fax from my_brch where mainbranch=1";
	        	   }
	        	   else{
	        	       gsPrintDet="select branchname, address, tel, fax from my_brch where doc_no="+mainbranch+"";
	        	   }
	        	//   System.out.println(gsPrintDet);
	     	       ResultSet resultSetgsPrintDet = stmtAccountStatement.executeQuery(gsPrintDet);
		       	   while(resultSetgsPrintDet.next()){     
		       		   //param.put("compname", "");
		       		   param.put("compname", accountStatementBean.getLblcompname());
			           param.put("compaddress", resultSetgsPrintDet.getString("address"));
			           param.put("branchname", accountStatementBean.getLblbranch());
			           param.put("branchaddress", accountStatementBean.getLblbranchaddress());
			           param.put("comptel", resultSetgsPrintDet.getString("tel"));
			           param.put("compfax", resultSetgsPrintDet.getString("fax"));    
			           param.put("compbranch", resultSetgsPrintDet.getString("branchname"));       
		       		}  
	           }else{
	        	   param.put("compname", accountStatementBean.getLblcompname());
		           param.put("compaddress", accountStatementBean.getLblcompaddress());
		           param.put("branchname", accountStatementBean.getLblbranch());
		           param.put("branchaddress", accountStatementBean.getLblbranchaddress());
		           param.put("comptel", accountStatementBean.getLblcomptel());
		           param.put("compfax", accountStatementBean.getLblcompfax());
		           param.put("compbranch", accountStatementBean.getLblbranch());
	           }
	           //System.out.println("in==="+accountStatementBean.getLblcompname());
	           param.put("compname1", accountStatementBean.getLblcompname());
	           param.put("location", accountStatementBean.getLbllocation());
	           param.put("printname", accountStatementBean.getLblprintname());
	           param.put("subprintname", accountStatementBean.getLblprintname1());
	           param.put("account", accountStatementBean.getAccountno()+" - "+accountStatementBean.getAccountname());
	           param.put("customeraddress", accountStatementBean.getAccountaddress());
	           param.put("customeremail", accountStatementBean.getAccountemail());
	           param.put("customermobile", accountStatementBean.getAccountmobile());
	           param.put("customerphone", accountStatementBean.getAccountphone());
	           param.put("customerfax", accountStatementBean.getAccountfax());
	           param.put("creditperiod", accountStatementBean.getCreditperiodmin()+" (Days)");
		       param.put("creditlimit", accountStatementBean.getCreditlimit());
		       param.put("accountstatementsql", accountstatementsql);
		       param.put("accountstatementsql1", accountstatementsql1);
		       //param.put("accountstatementsql", multiaccountstatementsql);
		       param.put("multiaccountstatementsql", multiaccountstatementsql);
		       param.put("accountstatementcheck", sqlAccountStatementResult);
		       param.put("securitysql", securitysql);
		       param.put("securitycheck", sqlSecurityResult);
		       //System.out.println("securitycheck--"+sqlSecurityResult);
		       param.put("unclearedreceiptssql", unclearedreceiptssql);
		       param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		       
		       param.put("debittotal", netdebittotal);
		       param.put("credittotal", netcredittotal);
		       param.put("nettotal", netamount);
		       
		       param.put("debittotalin", netdebittotalin);
		       param.put("credittotalin", netcredittotalin); 
		       param.put("nettotalin", netamountin);
		       
		       param.put("netsecurityamount", String.valueOf(netsecurityamount));
		     // System.out.println("netsecurity"+String.valueOf(netsecurityamount));
		      
		       param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		       param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		       param.put("unclrnettotal", String.valueOf(netunclramount));
		       param.put("curcode", accountStatementBean.getCurcode());
		       param.put("printby", session.getAttribute("USERNAME"));
		       param.put("accountperiod", "Period From - "+fromDate+" To - "+toDate);   
		       
		   	String configSqlAll1="select method from gl_config where field_nme='accountstatementAll'";
			ResultSet configrsall1=stmtAccountStatement.executeQuery(configSqlAll1);
			String configMethodAll1="";
			while(configrsall1.next()){
				configMethodAll1=configrsall1.getString("method");
			}
			//System.out.println("configMethodAll=="+configMethodAll+"--allcase--"+allcase);
			//System.out.println(param);
			// System.out.println("xlstat=="+xlstat);
			 
if(configMethodAll1.equalsIgnoreCase("1") && allcase.equalsIgnoreCase("1")) {
		    	 String[] pathstr=reportFileName.split("[.]", 0);
		    	 reportFileName=pathstr[0]+"All.jrxml";
} 
			 if (xlstat.equalsIgnoreCase("1"))
     	   	 { 
	     	    //System.out.println("Creating JasperPrint Object For Excel");
					 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
					 JasperReport jasperReport = JasperCompileManager.compileReport(design);
	
	     	    JasperPrint jasperPrint = JasperFillManager.fillReport (jasperReport,param,conn); 
	     	    byte bytes[] = new byte[20000]; 
	     	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
	     		
	     		JRXlsExporter exporter = new JRXlsExporter(); 
	     	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
	     	    
	     	    
	     	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
	     	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
	     	    exporter.exportReport(); 
	     	   
	     	   
	     	    String fileName = "AccountReport.xls";
	     	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
	     	    response.setContentType("application/vnd.ms-excel"); 
	     	    //System.out.println("After JasperPrint = 1"); 
	     	    response.setContentLength(xlsReport.size()); 
	     	    //System.out.println("After JasperPrint = 2"); 
	     	    xlsReport.close(); 
	     	    //System.out.println("After JasperPrint = 3"); 
	            OutputStream outputStream = response.getOutputStream(); 
	     	    //System.out.println("After JasperPrint = 4"); 
	     	    xlsReport.writeTo(outputStream); 
	     	    outputStream.flush(); 
	     	    //outputStream.close(); 
	     	    //System.out.println("export end");  
     	   	}else if(configMethodAll1.equalsIgnoreCase("1") && allcase.equalsIgnoreCase("1")) {
				 
				 //reportFileName=objcommon.getPrintPath("EST"); 
		    	
		    	 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
			
			} else
			 {
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
					
		          
			 }
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		param=null;
         		conn.close();
         	}
      	
	 }
	
	public void printProjectWiseAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;

        try {
        	
        	//System.out.println("printaction1");
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
               
               int acno=Integer.parseInt(request.getParameter("acno"));
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String chckopn = request.getParameter("chckopn");
        	   String email = request.getParameter("email");
        	   String print = request.getParameter("print");
        	   String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
             
        	   accountStatementBean=accountStatementDAO.getPrint(request,acno,branch,fromDate,toDate);
        	 
        	   String reportFileName = "com/dashboard/accounts/accountsstatementtype/arProjectWise.jrxml";
        	   
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                
               String arprojectwisesql="";
       		
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   arprojectwisesql+=" and t.brhId="+branch+"";
	       	   }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
			  arprojectwisesql = "select b.projectname, b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branchname, b.ref_detail,b.description,"
			  		+ "round(if(b.debit='',0,b.debit),2) debit,b.debits,round(if(b.credit='',0,b.credit),2) credit,b.credits,b.nettotal,b.netdebittotal,b.netcredittotal,"
			  		+ "if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from "
			  		+ "( select a.projectname,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype,  a.branchname,  a.ref_detail, if(a.description='0',"
			  		+ "'',a.description) description, a.debit,format(round(a.debit,2),2) debits, a.credit,format(round(a.credit,2),2) credits,  "
			  		+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,  "
			  		+ "format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0)  netamountvalue from "
			  		+ "(   select a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,a.projectname,b.branchname,"
			  		+ "a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2)  nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  "
			  		+ "from (  select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,  transtype,projectname,t.ref_detail,t.tr_des description,CONVERT(if(ldramount>0,"
			  		+ "round((ldramount*1),2),' '),CHAR(50)) debit,  CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,ldramount from my_head h "
			  		+ "inner join  (  select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,  t.ldramount, t.rate,"
			  		+ "t.doc_no transNo,t.dtype transType,coalesce(c.description,'') projectname from my_jvtran t left join my_ccentre c on t.rdocno=c.doc_no where  "
			  		+ "t.status=3 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+arprojectwisesql+"  and t.acno="+acno+" and t.yrid=0 union all  select t.brhid,  "
			  		+ "DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,  t.curId, sum(t.dramount),sum(t.ldramount) "
			  		+ "ldramount,1,0 transNo,'OPN' transType,'' projectname from my_jvtran t where   t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and "
			  		+ "t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+arprojectwisesql+" and t.acno="+acno+" group by t.acno,t.curId)t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId "
			  		+ "order by  acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on  (ac.acno=a.acno and ac.dtype='CRM')"+joins+" "
			  		+ "order by projectname,dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
			   
			   param.put("imgpath", imgpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           param.put("compname", accountStatementBean.getLblcompname());
	           param.put("compaddress", accountStatementBean.getLblcompaddress());
	           param.put("branchname", accountStatementBean.getLblbranch());
	           param.put("branchaddress", accountStatementBean.getLblbranchaddress());
	           param.put("comptel", accountStatementBean.getLblcomptel());
	           param.put("compfax", accountStatementBean.getLblcompfax());
	           param.put("compbranch", accountStatementBean.getLblbranch());
	           param.put("location", accountStatementBean.getLbllocation());
	           param.put("printname", accountStatementBean.getLblprintname());
	           param.put("subprintname", accountStatementBean.getLblprintname1());
	           param.put("account", accountStatementBean.getAccountno()+" - "+accountStatementBean.getAccountname());
	           param.put("customeraddress", accountStatementBean.getAccountaddress());
	           param.put("customeremail", accountStatementBean.getAccountemail());
	           param.put("customermobile", accountStatementBean.getAccountmobile());
	           param.put("customerphone", accountStatementBean.getAccountphone());
	           param.put("customerfax", accountStatementBean.getAccountfax());
	           param.put("creditperiod", accountStatementBean.getCreditperiodmin()+" (Days)");
		       param.put("creditlimit", accountStatementBean.getCreditlimit());
		       param.put("arprojectwisesql", arprojectwisesql);
		       
		       param.put("printby", session.getAttribute("USERNAME"));
		      
		       JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
		       JasperReport jasperReport = JasperCompileManager.compileReport(design);
		       if(xlstat.equalsIgnoreCase("1"))
	     	   	 { 
	     	    //System.out.println("Creating JasperPrint Object For Excel");
	     	    JasperPrint jasperPrint = JasperFillManager.fillReport (jasperReport,param,conn); 
	     	    byte bytes[] = new byte[20000]; 
	     	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
	     		
	     		JRXlsExporter exporter = new JRXlsExporter(); 
	     	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
	     	    
	     	    
	     	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
	     	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
	     	    exporter.exportReport(); 
	     	   
	     	   
	     	    String fileName = "InvoiceReport.xls";
	     	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
	     	    response.setContentType("application/vnd.ms-excel"); 
	     	    //System.out.println("After JasperPrint = 1"); 
	     	    response.setContentLength(xlsReport.size()); 
	     	    //System.out.println("After JasperPrint = 2"); 
	     	    xlsReport.close(); 
	     	    //System.out.println("After JasperPrint = 3"); 
	            OutputStream outputStream = response.getOutputStream(); 
	     	    //System.out.println("After JasperPrint = 4"); 
	     	    xlsReport.writeTo(outputStream); 
	     	    outputStream.flush(); 
	     	    //outputStream.close(); 
	     	    //System.out.println("export end");
	     	   	 }
				
	     	   /*else
	   {
	     	    generateReportPDF(response, param, jasperReport, conn);
		}  */
		       else
		       {
		       generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
        }
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		param=null;
         		conn.close();
         	}
      	
	 }
	
	public void printRAwiseAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
     //   JasperDesign design=null;
    //    JasperReport jasperReport=null;
    //    param=null;
		try {
			   //System.out.println("printaction2");
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
               
               int acno=Integer.parseInt(request.getParameter("acno"));
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String chckopn = request.getParameter("chckopn");
        	   String email = request.getParameter("email");
        	   String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
        	   String print = request.getParameter("print");
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
             
        	   accountStatementBean=accountStatementDAO.getPrint(request,acno,branch,fromDate,toDate);
        	 
        	   String printPathSql="select CONCAT('AS',atype) dtype from my_head where doc_no="+acno+"";
        	   ResultSet resultSetPrintPath = stmtAccountStatement.executeQuery(printPathSql);
	       	   String printPathDtype="BIB",unClrChqShow="0",unClrChqShow2="0";
	       	   while(resultSetPrintPath.next()){
	       			printPathDtype=resultSetPrintPath.getString("dtype");
	       		}
	       	   
	       	   if(printPathDtype.equalsIgnoreCase("ASAR")) {
		       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAR'";
	     	       ResultSet resultSetUnclrChq = stmtAccountStatement.executeQuery(unclrChqView);
		       	   while(resultSetUnclrChq.next()){
		       		   unClrChqShow=resultSetUnclrChq.getString("value");
		       		}
	       	   }
	       	if(printPathDtype.equalsIgnoreCase("ASAP")) {
		       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAP'";
	     	       ResultSet resultSetUnclrChq = stmtAccountStatement.executeQuery(unclrChqView);
		       	   while(resultSetUnclrChq.next()){
		       		   unClrChqShow2=resultSetUnclrChq.getString("value");
		       		}
	       	   }
	       	   
	       	   
        	   String reportFileName = "com/dashboard/accounts/accountsstatementtype/accountStatementTypeAlfahimAPARPrintRAwise.jrxml";
        	 //  System.out.println("printpath"+reportFileName);
        	   
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                
               String accountstatementsql = "",openingsql="";
       		
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   accountstatementsql+=" and t.brhId="+branch+"";
	       	   }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
	       	   if(chckopn.equalsIgnoreCase("1")){
	       		
	       		   openingsql = " union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t "
	       				   + "where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+accountstatementsql+" and t.acno= "+acno+" group by t.acno,t.curId";
	       		   
	       	   }
	       	   
				accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
					
				ResultSet resultSetAccountStatement = stmtAccountStatement.executeQuery(accountstatementsql);
	       		//System.out.println("a/c====="+accountstatementsql);
				String netdebittotal="0",netcredittotal="0",netamount="0";
	       		while(resultSetAccountStatement.next()){
	       			sqlAccountStatementResult="1";
	       			netdebittotal=resultSetAccountStatement.getString("netdebittotal");
	       			netcredittotal=resultSetAccountStatement.getString("netcredittotal");
	       			netamount=resultSetAccountStatement.getString("nettotal");
	       		}
				
	       		String securitysql = "";
	       		
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			securitysql+=" and j.brhId="+branch+"";
	       		}
	       		
	       		securitysql = "select DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,j.doc_no,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,"  
	       			 + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),' '),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
	       			 + "select sum(secamount) secamount1,a.* from ( select date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
	       			 + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by rdocno,rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
	       			 + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
	       			 + "where secamount!=0 and j.date>='"+sqlFromDate+"'  and j.date<='"+sqlToDate+"' and c.acno="+acno+""+securitysql+" order by rdocno,rtype";  
	       		
	       	   ResultSet resultSetSecurity = stmtAccountStatement.executeQuery(securitysql);
	       	   Double netsecurityamount=0.00;
	       	   while(resultSetSecurity.next()){
	       		    sqlSecurityResult="1";
	       			netsecurityamount=netsecurityamount+resultSetSecurity.getDouble("securityamount");
	       	   }
	       	   
	       	   netsecurityamount = commonDAO.Round(netsecurityamount, 2);
	       	
	       	   String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	   Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
	       	   if(unClrChqShow.equalsIgnoreCase("1.00000")){
		       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		       			unclearedreceiptssql+=" and m.brhId="+branch+"";
		       		}
		       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
		       				+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
		       		   		+ " CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m "
		       		   		+ " left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) where m.status=3 and m.bpvno=0 and m.chqdt>='"+sqlFromDate+"'  and m.chqdt<='"+sqlToDate+"' and d.acno="+acno+""+unclearedreceiptssql+") a,"
		       				+ "(select @i:=0) as i";
		       		//System.out.println("==unclearedreceiptssql=="+unclearedreceiptssql);
		       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
		       		
		       		while(resultSetUnclearAccountStatement.next()){
		       			sqlUnclrAccountStatementResult="1";
		       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
		       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
		       		}
		       		
		       		netunclramount=netunclrdebittotal-netunclrcredittotal;
		       		
		       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
		       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
		       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	   }
	       	if(unClrChqShow2.equalsIgnoreCase("2.00000") || unClrChqShow.equalsIgnoreCase("2.00000")){
//	       		System.out.println("====aaaa=="+unClrChqShow2);
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			unclearedreceiptssql+=" and m.brhId="+branch+"";
	       		}
       		
	       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
	       			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
	       			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
					+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
					+" where m.status=3 and d1.pdc=1 and d1.status='E' and m.date<='"+sqlToDate+"' and d.acno = "+acno+" "+unclearedreceiptssql+" ) a, (select @i:=0) as i order by date ";
//	       		System.out.println("===sqllaaa=="+unclearedreceiptssql);
	       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
	       		
	       		while(resultSetUnclearAccountStatement.next()){
	       			sqlUnclrAccountStatementResult="1";
	       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
	       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
	       		}
	       		
	       		netunclramount=netunclrdebittotal-netunclrcredittotal;

	       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
	       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
	       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	}
	       	
	       //	String detailsql="";
	       	
	       	/*detailsql="select radetails, Date, type, doc_no, Remarks, Dr, Cr, coalesce(round(@i:=@i+dramount,2),0) netamountvalue from (select '' radetails, '"+sqlFromDate+"' Date,'OPN' type, '' doc_no, 'OPN'  Remarks,round(if(sum(j.dramount)>0,sum(j.dramount),0),2)  Dr,"
	       			+"round(if(sum(j.dramount)<0,sum(j.dramount)*-1,0),2)  Cr, "
	       			+"0 Balance,sum(j.dramount) dramount from my_jvtran j where j.status=3 and j.acno="+acno+" and j.date <'"+sqlFromDate+"' "
	       			+"union all select if((r.voc_no is null and l.voc_no is null) ,'UNAPPLIED',concat(if(l.voc_no is null,'RA','LA') ,' - ' ,coalesce(r.voc_no,l.voc_no)  ,' - ' , flname  ,' - ' , v.fleet_no ,' - ' , "
	       			+ "if(coalesce(coalesce(l.clstatus,r.clstatus),1)=1,'OFFHIRE','ONHIRE'))) radetails, a.Date, a.type, a.doc_no, a.Remarks, a.Dr, a.Cr, a.Balance,a.dramount from "
	       			+"(select j.Date,j.dtype type, j.doc_no, j.description Remarks,round(if(j.dramount>0,j.dramount,0),2)  Dr, "
	       			+ "round(if(j.dramount<0,j.dramount*-1,0),2)  Cr, 0 Balance,j.rdocno,j.rtype,j.dramount from my_jvtran j "
	       			+ "where j.status=3 and j.dramount>0  and j.acno="+acno+" and j.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "
	       			+"union all select j1.Date,j1.dtype type, j1.doc_no, j1.description Remarks,round(if((d.amount*j1.id)>0,d.amount,0),2) Dr, "
	       			+"round(if((d.amount*j1.id)<0,d.amount,0),2) Cr, 0 Balance,j.rdocno,j.rtype,d.amount*j1.id dramount from my_jvtran j "
	       			+"left join my_outd d on j.tranid=d.ap_trid left join my_jvtran j1 on j1.tranid=d.tranid "
	       			+"where j.status=3 and j1.status=3 and j.dramount>0  and j.acno="+acno+" and j1.acno is not null and j.date <='"+sqlToDate+"' "
	       			+"and j1.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "
	       			+"union all select j.Date,j.dtype type, j.doc_no, j.description Remarks, "
	       			+"round(if(((j.dramount*j.id)-coalesce(d.amount,0))>0,((j.dramount*j.id)-coalesce(d.amount,0)),0),2) Dr, "
	       			+"round(if(((j.dramount*j.id)-coalesce(d.amount,0))<0,((j.dramount*j.id)-coalesce(d.amount,0)),0),2) Cr, 0 Balance,j.rdocno,j.rtype , ((j.dramount*j.id)-coalesce(d.amount,0)) *id dramount from my_jvtran j "
	       			+"left join (select sum(amount) amount,tranid from my_outd group by tranid) d on j.tranid=d.tranid "
	       			+"where j.status=3 and j.dramount<0  and j.acno="+acno+" and ((j.dramount*j.id)-coalesce(d.amount,0))!=0 "
	       			+"and j.date between '"+sqlFromDate+"' and '"+sqlToDate+"') a left join gl_ragmt r on a.rdocno=r.doc_no and a.rtype='rag' "
	       			+"left join gl_lagmt l on a.rdocno=l.doc_no and a.rtype='lag' "
	       			+"left join gl_vehmaster v on v.fleet_no=r.fleet_no or l.perfleet=v.fleet_no "
	       			+"left join gl_vehplate p on v.pltid=p.doc_no order by radetails,date) a, (select @i:=0) as i ";*/	
	       	
	       //	System.out.println("query"+	detailsql);  
	       		
	       	   
	           param.put("imgpath", imgpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           param.put("compname", accountStatementBean.getLblcompname());
	           param.put("compaddress", accountStatementBean.getLblcompaddress());
	           param.put("branchname", accountStatementBean.getLblbranch());
	           param.put("branchaddress", accountStatementBean.getLblbranchaddress());
	           param.put("comptel", accountStatementBean.getLblcomptel());
	           param.put("compfax", accountStatementBean.getLblcompfax());
	           param.put("compbranch", accountStatementBean.getLblbranch());
	           param.put("location", accountStatementBean.getLbllocation());
	           param.put("printname", accountStatementBean.getLblprintname());
	           param.put("subprintname", accountStatementBean.getLblprintname1());
	           param.put("account", accountStatementBean.getAccountno()+" - "+accountStatementBean.getAccountname());
	           param.put("customeraddress", accountStatementBean.getAccountaddress());
	           param.put("customeremail", accountStatementBean.getAccountemail());
	           param.put("customermobile", accountStatementBean.getAccountmobile());
	           param.put("customerphone", accountStatementBean.getAccountphone());
	           param.put("customerfax", accountStatementBean.getAccountfax());
	           param.put("creditperiod", accountStatementBean.getCreditperiodmin()+" (Days)");
		       param.put("creditlimit", accountStatementBean.getCreditlimit());
		       param.put("accountstatementsql", accountstatementsql);
		       param.put("accountstatementcheck", sqlAccountStatementResult);
		       param.put("securitysql", securitysql);
		       param.put("securitycheck", sqlSecurityResult);
		       
		       param.put("unclearedreceiptssql", unclearedreceiptssql);
		       param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		       
		       param.put("netdrtotal", netdebittotal);
		       param.put("netcrtotal", netcredittotal);
		       param.put("nettotals", netamount);
		       param.put("netsecurityamount", String.valueOf(netsecurityamount));
		      // System.out.println("sqlSecurityResult--"+sqlSecurityResult);
		       //System.out.println("credittotals"+netcredittotal);
		       //System.out.println(netamount);
		       param.put("acno", acno);
		      // System.out.println("acno--"+acno);
		       param.put("fromdate", sqlFromDate);
		       param.put("todate", sqlToDate);
		       
		       param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		       param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		       param.put("unclrnettotal", String.valueOf(netunclramount));
		       
		       param.put("printby", session.getAttribute("USERNAME"));
		      
		           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
		           JasperReport jasperReport = JasperCompileManager.compileReport(design);
		           
		           if(xlstat.equalsIgnoreCase("1"))
		     	   	 { 
		     	    //System.out.println("Creating JasperPrint Object For Excel");
		     	    JasperPrint jasperPrint = JasperFillManager.fillReport (jasperReport,param,conn); 
		     	    byte bytes[] = new byte[20000]; 
		     	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
		     		
		     		JRXlsExporter exporter = new JRXlsExporter(); 
		     	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
		     	    
		     	    
		     	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
		     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
		     	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
		     	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
		     	    exporter.exportReport(); 
		     	   
		     	   
		     	    String fileName = "InvoiceReport.xls";
		     	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
		     	    response.setContentType("application/vnd.ms-excel"); 
		     	    //System.out.println("After JasperPrint = 1"); 
		     	    response.setContentLength(xlsReport.size()); 
		     	    //System.out.println("After JasperPrint = 2"); 
		     	    xlsReport.close(); 
		     	    //System.out.println("After JasperPrint = 3"); 
		            OutputStream outputStream = response.getOutputStream(); 
		     	    //System.out.println("After JasperPrint = 4"); 
		     	    xlsReport.writeTo(outputStream); 
		     	    outputStream.flush(); 
		     	    //outputStream.close(); 
		     	    //System.out.println("export end");
		     	   	 }
					
		     	   /*else
		   {
		     	    generateReportPDF(response, param, jasperReport, conn);
			}  */
		           else
		           {
               generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
		           }
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		param=null;
         		conn.close();
         	}
      	
	 }
	
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print, String acno)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
  		  byte[] bytes = null;
          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
          resp.reset();
          resp.resetBuffer();
          
          resp.setContentType("application/pdf");
          resp.setContentLength(bytes.length);
          ServletOutputStream ouputStream = resp.getOutputStream();
          
          if(print.equalsIgnoreCase("1")) {
          
	          ouputStream.write(bytes, 0, bytes.length);
	          ouputStream.flush();
	          ouputStream.close();
          } else {
        	
        	 Statement stmtAccountStatement1 =conn.createStatement();
        	  
        	String fileName="",path="", formcode="BACS",filepath="", cldocno="0"; 
        	String strSql1 = "select imgPath from my_comp";

      		ResultSet rs1 = stmtAccountStatement1.executeQuery(strSql1);
      		while(rs1.next ()) {
      			path=rs1.getString("imgPath");
      		}

      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
    		java.util.Date date = new java.util.Date();
    		String currdate=dateFormat.format(date);
    		
      		fileName = "AccountStatement["+accountStatementBean.getAccountno()+"]"+currdate+".pdf";
      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

      		File dir = new File(path+ "/attachment/"+formcode);
      		dir.mkdirs();
      		
      		FileOutputStream fos = new FileOutputStream(filepath);
        	fos.write(bytes);
        	fos.flush();
        	fos.close();
        	
        	String strSql11 = "select cldocno FROM my_acbook where acno='"+acno+"'";
		    ResultSet rs11 = stmtAccountStatement1.executeQuery(strSql11);
		    while(rs11.next ()) {
		    	cldocno = rs11.getString("cldocno");
			} 
        	
        	File saveFile=new File(filepath);  
			SendEmailAction sendmail= new SendEmailAction();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();  
			
			session.setAttribute("clientcldocno", cldocno); 
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),accountStatementBean.getAccountno());
			
          }
               
      }
	public String getCurcode() {
		return curcode;
	}
	public void setCurcode(String curcode) {
		this.curcode = curcode;
	}
}