package com.dashboard.accounts.clusteraccountstatement;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsClusterAccountsStatementAction extends ActionSupport{
    
	ClsClusterAccountStatement accountStatementDAO= new ClsClusterAccountStatement();
	ClsClusterAccountsStatementBean accountStatementBean;
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
		System.out.println("PRINT ACTION===========================");
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
               
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
               String clusteraccount=request.getParameter("clusteraccount");

               String acno=request.getParameter("acno");
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String email = request.getParameter("email")==null?"0":request.getParameter("email");
        	   String print = request.getParameter("print")==null?"0":request.getParameter("print");
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
             
        	   accountStatementBean=accountStatementDAO.getPrint(request,acno,branch,fromDate,toDate);
        	 
        	   String printPathSql="select  dtype from gl_bibd where description='Cluster Account Statement'";
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
        	   System.out.println("printpath---->"+reportFileName);
        	   int value=0;
        	   String gsPrintHeader="select coalesce(method,0) val from gl_config where field_nme='greenstarPrintHeader'";
     	       ResultSet resultSetgsPrintHeader = stmtAccountStatement.executeQuery(gsPrintHeader);
	       	   while(resultSetgsPrintHeader.next()){     
	       		   value=resultSetgsPrintHeader.getInt("val");     
	       		}
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
                
               String accountstatementsql = "",openingsql="",multiaccountstatementsql="",clusterstatementsql="";
       		String sql="",sql2="";
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   accountstatementsql+=" and t.brhId="+branch+"";
	       		multiaccountstatementsql+=" and t.brhId="+branch+"";
	       		clusterstatementsql+=" and t.brhId="+branch+"";

	       	   }
	       	   if(!((clusteraccount.equalsIgnoreCase("")) || (clusteraccount.equalsIgnoreCase("0")))){
	                sql2=sql2+" and t.acno="+clusteraccount+"";
	        } else {
	        	    sql2=" and t.acno in (select acno from my_setclusterd where rdocno="+acno+")";
	        }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
	       	
	       	String accountsqlpal = "select b.regno,b.claimno,b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.regno,a.claimno,a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select invd.regno,invd.claimno,a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" left join ws_invcalctemp invd on invd.invno=mnt.doc_no order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
       	  // System.out.println("accountsqlpal==="+accountsqlpal);  
				accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
				 
				clusterstatementsql   = "select a.*,"+casestatement+"b.branchname,coalesce(round(@i:=@i+ldramount,2),0) netamount from (select t.brhid,if(transno=0,'',transno) transno,transtype,date(t.trdate) trdate,if(t.tr_des=0,'',t.tr_des) description,if(t.ref_detail=0,'',t.ref_detail) ref_detail,"
				     	+ "t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(100)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(100)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(100)) debit,"
				    	+ "CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(100)) credit,round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno,h.atype from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des,t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1"+sql+""+sql2+" union all select 0 brhid,date( '"+sqlFromDate+"' ) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ ""+sql2+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+",(select @i:=0) as i where 1=1 ";
					   
				System.out.println("clusteraccount==="+clusterstatementsql);  

				String netbalance="select d.acno doc_no,h.account,h.description,coalesce(round(sum(j.dramount),2),0) netbalance from my_setclusterd d left join my_jvtran j on d.acno=j.acno left join my_head h on h.doc_no=d.acno where j.status=3 and d.rdocno="+acno+"  and j.date<='"+sqlToDate+"' group by d.acno";
				
				multiaccountstatementsql="select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.dr,b.cr,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
		       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit, round(a.dr,2) dr, round(a.cr,2) cr,"
		       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
		       			+ "select a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.dr,a.cr,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
		       			+ "select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
		       			+ "ldramount from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
		       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+multiaccountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
		       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
				//System.out.println("a/c====="+accountstatementsql);
				//System.out.println("multia/c====="+multiaccountstatementsql);
				ResultSet resultSetAccountStatement = stmtAccountStatement.executeQuery(accountstatementsql);
	       		
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
	       			 + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),0),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
	       			 + "select sum(secamount) secamount1,a.* from ( select date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
	       			 + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by rdocno,rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
	       			 + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
	       			 + "where secamount!=0 and j.date<='"+sqlToDate+"' and c.acno="+acno+""+securitysql+" order by rdocno,rtype";  
	       		 // j.date>='"+sqlFromDate+"'  and 
	       		
	       		System.out.println("==== securitysql == "+securitysql);
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
		       		System.out.println("==unclearedreceiptssql=="+unclearedreceiptssql);
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
	        
       	   param.put("accountsqlpal", accountsqlpal);	
	           param.put("imgpath", imgpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	           	    mainbranch=branch;        	
		   		}else{
		   			mainbranch="1";
		   		}   
	           if(value>0){
	        	   String gsPrintDet="select branchname, address, tel, fax from my_brch where doc_no="+mainbranch+"";
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
			           param.put("brchaddress", accountStatementBean.getLblbranchaddress());

		       		}  
	           }else{
	        	   param.put("compname", accountStatementBean.getLblcompname());
		           param.put("compaddress", accountStatementBean.getLblcompaddress());
		           param.put("branchname", accountStatementBean.getLblbranch());
		           param.put("branchaddress", accountStatementBean.getLblbranchaddress());
		           param.put("comptel", accountStatementBean.getLblcomptel());
		           param.put("compfax", accountStatementBean.getLblcompfax());
		           param.put("compbranch", accountStatementBean.getLblbranch());
		           param.put("brchaddress", accountStatementBean.getLblbranchaddress());

	           }
	           System.out.println("in==="+accountStatementBean.getLblcompname());
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
		       param.put("accountstatementsql1", clusterstatementsql);
		       param.put("accountstatementcheck1", netbalance);

		       param.put("multiaccountstatementsql", multiaccountstatementsql);
		       param.put("accountstatementcheck", sqlAccountStatementResult);
		       param.put("securitysql", securitysql);
		       param.put("securitycheck", sqlSecurityResult);
		       
		       param.put("unclearedreceiptssql", unclearedreceiptssql);
		       param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		       
		       param.put("debittotal", netdebittotal);
		       param.put("credittotal", netcredittotal);
		       param.put("nettotal", netamount);
		       param.put("netsecurityamount", String.valueOf(netsecurityamount));
		      
		       param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		       param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		       param.put("unclrnettotal", String.valueOf(netunclramount));
		       param.put("curcode", accountStatementBean.getCurcode());
		       param.put("printby", session.getAttribute("USERNAME"));
		       param.put("accountperiod", "Period From - "+fromDate+" To - "+toDate);   
		       System.out.println("reportFileName--->>>"+reportFileName+"===Currency==="+accountStatementBean.getCurcode());
		           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
		           JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
      
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
        	  
        	String fileName="",path="", formcode="BACS",filepath=""; 
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
        	
        	File saveFile=new File(filepath);
			SendEmailAction sendmail= new SendEmailAction();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();  
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