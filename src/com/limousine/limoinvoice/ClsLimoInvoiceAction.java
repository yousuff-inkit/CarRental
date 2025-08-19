package com.limousine.limoinvoice;

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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsLimoInvoiceAction {
	ClsCommon objcommon=new ClsCommon();
	ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();
	ClsLimoInvoiceBean invoicebean=new ClsLimoInvoiceBean();
ClsCommon commDAO=new ClsCommon();
	
	ClsConnection connDAO=new ClsConnection();
	
	Connection conn;
	
	private int docno;
	private int vocno;
	private String date;
	private String fromdate;
	private String todate;
	private String hidclient;
	private String client;
	private String clientdetails;
	private String ledgernote;
	private String invoicenote;
	private int gridlength;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetailcode;
	private String brchName;
	private int trno;
	private String manual;
	private double mastertotal;
	private String url;
	private String lpono;
	private String eventno;
	
	private String lbldetails;
	private String lblcldocno;
	private String lblclient;
	private String lbldate;
	private String lblvocno;
	private String lblfromdate;
	private String lbltodate;
	private String lblrefno;
	private String lblbookedby;
	private String lblguest;
	private String lblcompname;
	private String lblcomppbno;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lbllocation;
    private String lblcomptrn;
	private String lblprintname;
	private String lblbranch;
	private String lblcheckedby;
	private String lblfinaldate;
	private String lblrecievedby;
	private String lblcode,lbladdress,lbladdressother,lblmobileno,lblmail;
	private String lbllpo,lblevent,lblcurrencycode,lbltotal,lblnetamount,lblamountwords;
	private String lblinvnote;
	private String lblclienttrn;
	private String lblsubtotal;
	private String lblvatamt;
	private String lblgrandtotal; 
	 private String lblcompbranchaddress,lblbankdetails,lblbankbeneficiary,lblbankaccountno,lblbeneficiarybank,lblbankibanno;
	 
	
	public String getLbllocation() {
        return lbllocation;
    }
    public void setLbllocation(String lbllocation) {
        this.lbllocation = lbllocation;
    }
    public String getLblcomptrn() {
        return lblcomptrn;
    }
    public void setLblcomptrn(String lblcomptrn) {
        this.lblcomptrn = lblcomptrn;
    }
    public String getLblbankaccountno() {
		return lblbankaccountno;
	}
	public void setLblbankaccountno(String lblbankaccountno) {
		this.lblbankaccountno = lblbankaccountno;
	}
	public String getLblbankdetails() {
		return lblbankdetails;
	}
	public void setLblbankdetails(String lblbankdetails) {
		this.lblbankdetails = lblbankdetails;
	}
	public String getLblbankbeneficiary() {
		return lblbankbeneficiary;
	}
	public void setLblbankbeneficiary(String lblbankbeneficiary) {
		this.lblbankbeneficiary = lblbankbeneficiary;
	}
	public String getLblbeneficiarybank() {
		return lblbeneficiarybank;
	}
	public void setLblbeneficiarybank(String lblbeneficiarybank) {
		this.lblbeneficiarybank = lblbeneficiarybank;
	}
	public String getLblbankibanno() {
		return lblbankibanno;
	}
	public void setLblbankibanno(String lblbankibanno) {
		this.lblbankibanno = lblbankibanno;
	}
	public String getLblcompbranchaddress() {
		return lblcompbranchaddress;
	}
	public void setLblcompbranchaddress(String lblcompbranchaddress) {
		this.lblcompbranchaddress = lblcompbranchaddress;
	}
	public String getLblsubtotal() {
		return lblsubtotal;
	}
	public void setLblsubtotal(String lblsubtotal) {
		this.lblsubtotal = lblsubtotal;
	}
	public String getLblvatamt() {
		return lblvatamt;
	}
	public void setLblvatamt(String lblvatamt) {
		this.lblvatamt = lblvatamt;
	}
	public String getLblgrandtotal() {
		return lblgrandtotal;
	}
	public void setLblgrandtotal(String lblgrandtotal) {
		this.lblgrandtotal = lblgrandtotal;
	}
	public String getLblclienttrn() {
		return lblclienttrn;
	}
	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}
	public String getLblinvnote() {
		return lblinvnote;
	}
	public void setLblinvnote(String lblinvnote) {
		this.lblinvnote = lblinvnote;
	}
	public String getLbllpo() {
		return lbllpo;
	}
	public void setLbllpo(String lbllpo) {
		this.lbllpo = lbllpo;
	}
	public String getLblevent() {
		return lblevent;
	}
	public void setLblevent(String lblevent) {
		this.lblevent = lblevent;
	}
	public String getLblcurrencycode() {
		return lblcurrencycode;
	}
	public void setLblcurrencycode(String lblcurrencycode) {
		this.lblcurrencycode = lblcurrencycode;
	}
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblamountwords() {
		return lblamountwords;
	}
	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}
	public String getLpono() {
		return lpono;
	}
	public void setLpono(String lpono) {
		this.lpono = lpono;
	}
	public String getEventno() {
		return eventno;
	}
	public void setEventno(String eventno) {
		this.eventno = eventno;
	}
	public String getLblcode() {
		return lblcode;
	}
	public void setLblcode(String lblcode) {
		this.lblcode = lblcode;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLbladdressother() {
		return lbladdressother;
	}
	public void setLbladdressother(String lbladdressother) {
		this.lbladdressother = lbladdressother;
	}
	public String getLblmobileno() {
		return lblmobileno;
	}
	public void setLblmobileno(String lblmobileno) {
		this.lblmobileno = lblmobileno;
	}
	public String getLblmail() {
		return lblmail;
	}
	public void setLblmail(String lblmail) {
		this.lblmail = lblmail;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getLblrecievedby() {
		return lblrecievedby;
	}
	public void setLblrecievedby(String lblrecievedby) {
		this.lblrecievedby = lblrecievedby;
	}
	
	
	public String getLbldetails() {
		return lbldetails;
	}
	public void setLbldetails(String lbldetails) {
		this.lbldetails = lbldetails;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblcldocno() {
		return lblcldocno;
	}
	public void setLblcldocno(String lblcldocno) {
		this.lblcldocno = lblcldocno;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblvocno() {
		return lblvocno;
	}
	public void setLblvocno(String lblvocno) {
		this.lblvocno = lblvocno;
	}
	public String getLblfromdate() {
		return lblfromdate;
	}
	public void setLblfromdate(String lblfromdate) {
		this.lblfromdate = lblfromdate;
	}
	public String getLbltodate() {
		return lbltodate;
	}
	public void setLbltodate(String lbltodate) {
		this.lbltodate = lbltodate;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblbookedby() {
		return lblbookedby;
	}
	public void setLblbookedby(String lblbookedby) {
		this.lblbookedby = lblbookedby;
	}
	public String getLblguest() {
		return lblguest;
	}
	public void setLblguest(String lblguest) {
		this.lblguest = lblguest;
	}
	
	public String getManual() {
		return manual;
	}
	public void setManual(String manual) {
		this.manual = manual;
	}
	public double getMastertotal() {
		return mastertotal;
	}
	public void setMastertotal(double mastertotal) {
		this.mastertotal = mastertotal;
	}
	public int getTrno() {
		return trno;
	}
	public void setTrno(int trno) {
		this.trno = trno;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getClientdetails() {
		return clientdetails;
	}
	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getVocno() {
		return vocno;
	}
	public void setVocno(int vocno) {
		this.vocno = vocno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getLedgernote() {
		return ledgernote;
	}
	public void setLedgernote(String ledgernote) {
		this.ledgernote = ledgernote;
	}
	public String getInvoicenote() {
		return invoicenote;
	}
	public void setInvoicenote(String invoicenote) {
		this.invoicenote = invoicenote;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	 private Map<String, Object> param=null;
		
		
		public Map<String, Object> getParam() {
			return param;
		}
		public void setParam(Map<String, Object> param) {
			this.param = param;
		}
		
		
		//company details for print
		
		private String comp_name,comp_brname,comp_address,comp_fax,comp_tel,comp_email,comp_trnno,totamtwrds;
		
		
		public String getTotamtwrds() {
			return totamtwrds;
		}
		public void setTotamtwrds(String totamtwrds) {
			this.totamtwrds = totamtwrds;
		}
		public String getComp_name() {
			return comp_name;
		}

		public void setComp_name(String comp_name) {
			this.comp_name = comp_name;
		}

		public String getComp_brname() {
			return comp_brname;
		}

		public void setComp_brname(String comp_brname) {
			this.comp_brname = comp_brname;
		}

		public String getComp_address() {
			return comp_address;
		}

		public void setComp_address(String comp_address) {
			this.comp_address = comp_address;
		}

		public String getComp_fax() {
			return comp_fax;
		}

		public void setComp_fax(String comp_fax) {
			this.comp_fax = comp_fax;
		}

		public String getComp_tel() {
			return comp_tel;
		}

		public void setComp_tel(String comp_tel) {
			this.comp_tel = comp_tel;
		}

		public String getComp_email() {
			return comp_email;
		}

		public void setComp_email(String comp_email) {
			this.comp_email = comp_email;
		}

		public String getComp_trnno() {
			return comp_trnno;
		}

		public void setComp_trnno(String comp_trnno) {
			this.comp_trnno = comp_trnno;
		}
		//vatcheck
		 private String vatcheck;
		 
			
			public String getVatcheck() {
				return vatcheck;
			}
			public void setVatcheck(String vatcheck) {
				this.vatcheck = vatcheck;
			}
	public String getLblcomppbno() {
                return lblcomppbno;
            }
            public void setLblcomppbno(String lblcomppbno) {
                this.lblcomppbno = lblcomppbno;
            }
    public void setValues(int docno,int vocno,int trno,java.sql.Date sqldate,java.sql.Date sqlfromdate,java.sql.Date sqltodate){
		setDocno(docno);
		setVocno(vocno);
		if(sqldate!=null){
			setDate(sqldate.toString());	
		}
		if(sqlfromdate!=null){
			setFromdate(sqlfromdate.toString());
		}
		if(sqltodate!=null){
			setTodate(sqltodate.toString());
		}
		setClient(getClient());
		setClientdetails(getClientdetails());
		setHidclient(getHidclient());
		setInvoicenote(getInvoicenote());
		setLedgernote(getLedgernote());
		setManual(getManual());
		setMastertotal(getMastertotal());
		setTrno(trno);
		
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		java.sql.Date sqldate = null;
		java.sql.Date sqlfromdate=null ;
		java.sql.Date sqltodate=null;
		if(getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(getFromdate()!=null){
			sqlfromdate=objcommon.changeStringtoSqlDate(getFromdate());
		}
		if(getTodate()!=null){
			sqltodate=objcommon.changeStringtoSqlDate(getTodate());
		}
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> invoicearray = new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("invoice"+i)[0];
				invoicearray.add(temp);
				//System.out.println(invoicearray.get(i));
			}
			for(int i=0;i<invoicearray.size();i++){
				System.out.println(invoicearray.get(i));
			}
			int value=invoicedao.insert(sqldate,sqlfromdate,sqltodate,getHidclient(),getLedgernote(),getInvoicenote(),invoicearray,mode,getFormdetailcode(),request,getBrchName(),session,getManual(),getMastertotal(),getLpono(),getEventno());
			if(value>0){
				int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
				int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
				setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
				int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
				setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
				setMsg("Not Saved");
				return "fail";
			}
				
			}  else if(mode.equalsIgnoreCase("E")) {
                
                ArrayList<String> invoicearray = new ArrayList<>();
                for(int i=0;i<getGridlength();i++){
                    String temp=requestParams.get("invoice"+i)[0];
                    invoicearray.add(temp);
                    //System.out.println(invoicearray.get(i));
                }
                for(int i=0;i<invoicearray.size();i++){
                    System.out.println(invoicearray.get(i));
                }
                
                int value=invoicedao.edit(sqldate,sqlfromdate,sqltodate,getHidclient(),getLedgernote(),getInvoicenote(),invoicearray,mode,getFormdetailcode(),request,getBrchName(),session,getManual(),getMastertotal(),getLpono(),getEventno(),getDocno());
                if(value>0){
                    int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
                    int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
                    setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
                    setMsg("Successfully Saved");
                    return "success";
                }
                else{
                    int voucher=Integer.parseInt(request.getAttribute("VOUCHER").toString());
                    int tran=Integer.parseInt(request.getAttribute("LIMOTRNO").toString());
                    setValues(value, voucher,tran, sqldate, sqlfromdate, sqltodate);
                    setMsg("Not Saved");
                    return "fail";
                }
            }
        
        setMsg("Not Saved");
		return "fail";
	}
	
	public String printAction() throws ParseException,SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		 String branch=session.getAttribute("BRANCHID").toString().trim();
		 setUrl(objcommon.getPrintPath("LIN"));
		String bankdocno=request.getParameter("bankdocno")==null?"0":request.getParameter("bankdocno").toString();
		invoicebean=invoicedao.getPrint(getDocno(),request,session,bankdocno,branch);
		
		
		String dtype=request.getParameter("dtype");
		String docno=request.getParameter("docno");
		
		// System.out.println("bankdocno=="+bankdocno);
		setLblbookedby(invoicebean.getLblbookedby());
		setLblcldocno(invoicebean.getLblcldocno());
		setLblclient(invoicebean.getLblclient());
		setLbldate(invoicebean.getLbldate());
		setLblfromdate(invoicebean.getLblfromdate());
		setLblguest(invoicebean.getLblguest());
		setLblrefno(invoicebean.getLblrefno());
		setLbltodate(invoicebean.getLbltodate());
		setLblvocno(invoicebean.getLblvocno());
		setLblcompname(invoicebean.getLblcompname());
		setLblcomppbno(invoicebean.getLblcomppbno());
		setLblcompaddress(invoicebean.getLblcompaddress());
		setLblprintname("Tax Invoice Limo Service");
		setLblrecievedby(invoicebean.getLblrecievedby());
		setLblcheckedby(invoicebean.getLblcheckedby());
		setLblfinaldate(invoicebean.getLblfinaldate());
		setLblcompfax(invoicebean.getLblcompfax());
		setLblcomptel(invoicebean.getLblcomptel());
		setLblbranch(invoicebean.getLblbranch());
		setLbldetails(invoicebean.getLbldetails());
		setLbladdress(invoicebean.getLbladdress());
		setLblmail(invoicebean.getLblmail());
		setLblmobileno(invoicebean.getLblmobileno());
		setLblevent(invoicebean.getLblevent());
		setLbllpo(invoicebean.getLbllpo());
		setLblcurrencycode(invoicebean.getLblcurrencycode());
		setLbltotal(invoicebean.getLbltotal());
		setLblnetamount(invoicebean.getLblnetamount());
		setLblamountwords(invoicebean.getLblamountwords());
		setLblinvnote(invoicebean.getLblinvnote());
		setLblclienttrn(invoicebean.getLblclienttrn());
		setLblsubtotal(invoicebean.getLblsubtotal());
		setLblvatamt(invoicebean.getLblvatamt());
		setLblgrandtotal(invoicebean.getLblgrandtotal());
		
		setLblcompbranchaddress(invoicebean.getLblcompbranchaddress());
    	setLblbankdetails(invoicebean.getLblbankdetails());
    	setLblbankbeneficiary(invoicebean.getLblbankbeneficiary());
    	setLblbankaccountno(invoicebean.getLblbankaccountno());
    	setLblbeneficiarybank(invoicebean.getLblbeneficiarybank());
    	setLblbankibanno(invoicebean.getLblbankibanno());
    	
		//Statement stmtinvoice11 = conn.createStatement ();
		
		//stmtinvoice11.close();
    	
    	
    	
    	//new jrxml print get set datas
    	
    	
    	setComp_name(invoicebean.getComp_name());
    	setComp_brname(invoicebean.getComp_brname());
    	setLbllocation(invoicebean.getComp_brname());
    	setComp_address(invoicebean.getComp_address());
    	setComp_fax(invoicebean.getComp_fax());
    	setComp_tel(invoicebean.getComp_tel());
    	setComp_email(invoicebean.getComp_email());
    	setComp_trnno(invoicebean.getComp_trnno());
    	setLblcomptrn(invoicebean.getComp_trnno());
    	setTotamtwrds(invoicebean.getTotamtwrds());
		
    	//vat check
    	
    	setVatcheck(invoicebean.getVatcheck());
		
		if(objcommon.getPrintPath(dtype).contains(".jrxml")==true)
		{
			
			 ClsConnection conobj=new ClsConnection();
	    	   param = new HashMap();
	    	  
	    	   //new added imgpath for jrxml print 
	    	   
	    	   String imgpath = request.getSession().getServletContext()
						.getRealPath("/icons/aitsheader.jpg");
				imgpath = imgpath.replace("\\", "\\\\");
				String imgfooter = request.getSession().getServletContext()
						.getRealPath("/icons/aitsfooter.jpg");
				imgfooter = imgfooter.replace("\\", "\\\\");    
	    	   Connection conn = null;
	    	   conn = conobj.getMyConnection();	   
	    	   
	    	  
	    	   try{
	    		   Statement stmt= conn.createStatement();
	    		 
	    		   String bankname="",bankbeneficiary="",bankaccount="",bankswiftcode="",bankibanno="",branchaddress="";
	    			String bankinfosql = "select name,beneficiary,account,ibanno,swiftcode,address branchaddress from cm_bankdetails ";
	    			ResultSet resultsetbank = stmt.executeQuery(bankinfosql);
	    	      // System.out.println("bankdetails==="+bankinfosql);
	    			while (resultsetbank.next()) {
	    				//bean.setLbllogoimgpath(resultsetbank.getString("logo"));
	    				bankname=(resultsetbank.getString("name"));
	    				bankbeneficiary=(resultsetbank.getString("beneficiary"));
	    				bankaccount=(resultsetbank.getString("account"));
	    				bankswiftcode=(resultsetbank.getString("swiftcode"));
	    				bankibanno=(resultsetbank.getString("ibanno"));
	    				branchaddress=(resultsetbank.getString("branchaddress"));
 	    			}
	    		   
	    			
	    			
	    		   param.put("docno", docno);
	    		   param.put("date", getLbldate());
	    		   param.put("invno", getLblvocno());
	    		   param.put("clientname", getLblclient());
	    		   param.put("clienttrn", getLblclienttrn());
	    		   param.put("total", getLblsubtotal());
	    		   param.put("taxamt", getLblvatamt());
	    		   param.put("invoicenote", getLblinvnote());
	    		   param.put("clientaddress", getLbldetails());
	    		   param.put("tel", getLblmobileno());
	    		   param.put("grandtotal", getLblgrandtotal());
	    		
	    		   //new added paramters for jrxml print 
	    		   
	    			param.put("imghedderpath", imgpath);
					param.put("imgfooterpath", imgfooter);
					param.put("compname", getComp_name());
					param.put("compbrname", getComp_brname());
					param.put("compaddress", getComp_address());
					param.put("compfax", getComp_fax());
					param.put("comptel", getComp_tel());
					param.put("compemail", getComp_email());
					param.put("comptrnno", getComp_trnno());
					param.put("totamtwrds", getTotamtwrds());
					
					//bank details
					
					param.put("lblbankdetails", getLblbankdetails());
					param.put("lblcompbranchaddress", getLblcompbranchaddress());
					param.put("lblbankbeneficiary", getLblbankbeneficiary());
					param.put("lblbankaccountno", getLblbankaccountno());
					param.put("lblbankibanno", getLblbankibanno());
					param.put("lblbeneficiarybank", getLblbeneficiarybank());
					
					//vatcheck
					
					param.put("vatcheck", getVatcheck());
	    		   System.out.println(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));
	    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));	      	     	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	               generateReportPDF(response, param, jasperReport, conn);
	    	   }catch (Exception e) {
			       e.printStackTrace();
			   }
	    	   finally{
	    		   conn.close();
	    	   }
		 }
	 return "print";
	}

		
		private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
			  byte[] bytes = null;
		    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		      resp.reset();
		    resp.resetBuffer();
		    
		    resp.setContentType("application/pdf");
		    resp.setContentLength(bytes.length);
		    ServletOutputStream ouputStream = resp.getOutputStream();
		    ouputStream.write(bytes, 0, bytes.length);
		   
		    ouputStream.flush();
		    ouputStream.close();
		}
		
		
		public void sendLimoInvMails() throws SQLException {
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			HttpSession session=request.getSession();
			int docno=Integer.parseInt(request.getParameter("docno"));
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String bankdocno=request.getParameter("bankdocno")==null?"0":request.getParameter("bankdocno").toString();
			String dtype=request.getParameter("dtype");
			invoicebean=invoicedao.getPrint(getDocno(),request,session,bankdocno,branch);
			
			
			
			Connection conn=null;
			
			
			ClsConnection objconn=new ClsConnection();
			try {
				conn=objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				int cldocno=0;
				String agmttype="";
				int agmtdocno=0;
				java.util.List<File> listfile=new ArrayList<File>();
				int brhid=0;				
				String userName="",port="",host="",password="";
				String strSql1 = "select email,mailpass,smtpServer,smtpHostport FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
				ResultSet rs1 = conn.createStatement().executeQuery(strSql1);
				while(rs1.next ()) {
					userName=rs1.getString("email");
					port=rs1.getString("smtpHostport");
					host=rs1.getString("smtpServer");
					password=rs1.getString("mailpass");
					password=ClsEncrypt.getInstance().decrypt(password);
				}
				
				//Getting Subject and Mail
				
				String strmsg="SELECT msg,SUBJECT,coalesce(cc,'') cc FROM gl_emailmsg WHERE dtype='lin'";  // need to change to LIN
				ResultSet rsmsg=stmt.executeQuery(strmsg);
				String mailmsg="",mailsubject="",mailcc="";
				while(rsmsg.next()) {
					mailmsg=rsmsg.getString("msg");
					mailsubject=rsmsg.getString("subject");
					mailcc=rsmsg.getString("cc");
				}
				
				String imgsignaturepath=request.getSession().getServletContext().getRealPath("/icons/mail-signature.png");
				imgsignaturepath=imgsignaturepath.replace("\\", "\\\\");    
				
				String mailedtrno="";
				String clientmail="",vocno="";
				String monthyear="";
			
				vocno=invoicebean.getLblvocno();
				cldocno=0;
				listfile=new ArrayList<File>();
				cldocno=Integer.parseInt(invoicebean.getLblcldocno());
				clientmail=invoicebean.getLblmail();
				System.out.println(docno);
				listfile = (getPDFFile(conn,dtype,bankdocno,branch,docno,request,session,response,vocno));
				System.out.println("TOT - "+listfile.size());
				mailcc=getExtraCC(cldocno,conn);
				sendEmailwithMultiplepdf(host, port, userName, password, clientmail, mailsubject+" "+monthyear,mailmsg, listfile, docno+"",mailcc,imgsignaturepath);
			}catch(Exception e) {
				e.printStackTrace();
				//return "fail";
			}
			finally {
				conn.close();
			}
			System.out.println("Success");
			//return "success";
		}
		
		private List<File> getPDFFile(Connection conn, String dtype, String bankdocno, String branch,int docno, HttpServletRequest request, HttpSession session, HttpServletResponse response, String vocno) {
			// TODO Auto-generated method stub
			
			try {	
				 return getInvoicePDF(conn,dtype,bankdocno,branch, docno,request,session,response,vocno);
							
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		private List<File> getInvoicePDF(Connection conn, String dtype,String bankdocno, String branch,int docno, HttpServletRequest request, HttpSession session, HttpServletResponse response, String vocno) throws NamingException, SQLException, IOException, MessagingException {
			// TODO Auto-generated method stub
			
			List<File> files = new ArrayList<File>();
			invoicebean=invoicedao.getPrint(docno,request,session,bankdocno,branch);
			
			setLblbookedby(invoicebean.getLblbookedby());
			setLblcldocno(invoicebean.getLblcldocno());
			setLblclient(invoicebean.getLblclient());
			setLbldate(invoicebean.getLbldate());
			setLblfromdate(invoicebean.getLblfromdate());
			setLblguest(invoicebean.getLblguest());
			setLblrefno(invoicebean.getLblrefno());
			setLbltodate(invoicebean.getLbltodate());
			setLblvocno(invoicebean.getLblvocno());
			setLblcompname(invoicebean.getLblcompname());
			setLblcompaddress(invoicebean.getLblcompaddress());
			setLblprintname("Limousine Service Invoice");
			setLblrecievedby(invoicebean.getLblrecievedby());
			setLblcheckedby(invoicebean.getLblcheckedby());
			setLblfinaldate(invoicebean.getLblfinaldate());
			setLblcompfax(invoicebean.getLblcompfax());
			setLblcomptel(invoicebean.getLblcomptel());
			setLblbranch(invoicebean.getLblbranch());
			setLbldetails(invoicebean.getLbldetails());
			setLbladdress(invoicebean.getLbladdress());
			setLblmail(invoicebean.getLblmail());
			setLblmobileno(invoicebean.getLblmobileno());
			setLblevent(invoicebean.getLblevent());
			setLbllpo(invoicebean.getLbllpo());
			setLblcurrencycode(invoicebean.getLblcurrencycode());
			setLbltotal(invoicebean.getLbltotal());
			setLblnetamount(invoicebean.getLblnetamount());
			setLblamountwords(invoicebean.getLblamountwords());
			setLblinvnote(invoicebean.getLblinvnote());
			setLblclienttrn(invoicebean.getLblclienttrn());
			setLblsubtotal(invoicebean.getLblsubtotal());
			setLblvatamt(invoicebean.getLblvatamt());
			setLblgrandtotal(invoicebean.getLblgrandtotal());
			
			setLblcompbranchaddress(invoicebean.getLblcompbranchaddress());
	    	setLblbankdetails(invoicebean.getLblbankdetails());
	    	setLblbankbeneficiary(invoicebean.getLblbankbeneficiary());
	    	setLblbankaccountno(invoicebean.getLblbankaccountno());
	    	setLblbeneficiarybank(invoicebean.getLblbeneficiarybank());
	    	setLblbankibanno(invoicebean.getLblbankibanno());
	    	
			//Statement stmtinvoice11 = conn.createStatement ();
			
			//stmtinvoice11.close();
	    	
	    	
	    	
	    	//new jrxml print get set datas
	    	
	    	
	    	setComp_name(invoicebean.getComp_name());
	    	setComp_brname(invoicebean.getComp_brname());
	    	setComp_address(invoicebean.getComp_address());
	    	setComp_fax(invoicebean.getComp_fax());
	    	setComp_tel(invoicebean.getComp_tel());
	    	setComp_email(invoicebean.getComp_email());
	    	setComp_trnno(invoicebean.getComp_trnno());
	    	setTotamtwrds(invoicebean.getTotamtwrds());
			
	    	//vat check
	    	
	    	setVatcheck(invoicebean.getVatcheck());
			
				
				 ClsConnection conobj=new ClsConnection();
		    	   param = new HashMap();
		    	  
		    	   //new added imgpath for jrxml print 
		    	   
		    	   String imgpath = request.getSession().getServletContext()
							.getRealPath("/icons/aitsheader.jpg");
					imgpath = imgpath.replace("\\", "\\\\");
					String imgfooter = request.getSession().getServletContext()
							.getRealPath("/icons/aitsfooter.jpg");
					imgfooter = imgfooter.replace("\\", "\\\\");  	   
		    	   
		    	  
		    	   try{
		    		   Statement stmt= conn.createStatement();
		    		 
		    		   String bankname="",bankbeneficiary="",bankaccount="",bankswiftcode="",bankibanno="",branchaddress="";
		    			String bankinfosql = "select name,beneficiary,account,ibanno,swiftcode,address branchaddress from cm_bankdetails ";
		    			ResultSet resultsetbank = stmt.executeQuery(bankinfosql);
		    	      // System.out.println("bankdetails==="+bankinfosql);
		    			while (resultsetbank.next()) {
		    				//bean.setLbllogoimgpath(resultsetbank.getString("logo"));
		    				bankname=(resultsetbank.getString("name"));
		    				bankbeneficiary=(resultsetbank.getString("beneficiary"));
		    				bankaccount=(resultsetbank.getString("account"));
		    				bankswiftcode=(resultsetbank.getString("swiftcode"));
		    				bankibanno=(resultsetbank.getString("ibanno"));
		    				branchaddress=(resultsetbank.getString("branchaddress"));
	 	    			}
		    		   
		    			
		    			
		    		   param.put("docno", docno+"");
		    		   param.put("date", getLbldate());
		    		   param.put("invno", getLblvocno());
		    		   param.put("clientname", getLblclient());
		    		   param.put("clienttrn", getLblclienttrn());
		    		   param.put("total", getLblsubtotal());
		    		   param.put("taxamt", getLblvatamt());
		    		   param.put("invoicenote", getLblinvnote());
		    		   param.put("clientaddress", getLbldetails());
		    		   param.put("tel", getLblmobileno());
		    		   param.put("grandtotal", getLblgrandtotal());
		    		
		    		   //new added paramters for jrxml print 
		    		   
		    			param.put("imghedderpath", imgpath);
						param.put("imgfooterpath", imgfooter);
						param.put("compname", getComp_name());
						param.put("compbrname", getComp_brname());
						param.put("compaddress", getComp_address());
						param.put("compfax", getComp_fax());
						param.put("comptel", getComp_tel());
						param.put("compemail", getComp_email());
						param.put("comptrnno", getComp_trnno());
						param.put("totamtwrds", getTotamtwrds());
						
						//bank details
						
						param.put("lblbankdetails", getLblbankdetails());
						param.put("lblcompbranchaddress", getLblcompbranchaddress());
						param.put("lblbankbeneficiary", getLblbankbeneficiary());
						param.put("lblbankaccountno", getLblbankaccountno());
						param.put("lblbankibanno", getLblbankibanno());
						param.put("lblbeneficiarybank", getLblbeneficiarybank());
						
						//vatcheck
						
						param.put("vatcheck", getVatcheck());
						
						String getAllFiles = "SELECT path FROM my_fileattach WHERE dtype='LIN' AND doc_no="+docno;
			               ResultSet rsgetAllFiles = stmt.executeQuery(getAllFiles);
			               while(rsgetAllFiles.next()) {
			            	   files.add(new File(rsgetAllFiles.getString("path")));
			               }  
						
						
		    		   System.out.println(files.size()+request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype))+"  -  "+docno);
		    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));	      	     	 
		               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		               files.add(saveFile(response, param, jasperReport, conn, session, docno+"", branch, vocno+"", "LIN"));
		               System.out.println("File Size - "+files.size());
		                  
		               
		        }catch (JRException e) {
		   				// TODO Auto-generated catch block
		   				e.printStackTrace();
		   	    }
			
			return files;
		}
		
		
		private File saveFile(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,HttpSession session,String printdoc,String brhid,String refid,String dtype)throws JRException, NamingException, SQLException, IOException, MessagingException , javax.mail.MessagingException {
			
			byte[] bytes = null;
			//parameters.forEach((key, value) -> System.out.println(key + ": " + value));
			
	        bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	        resp.reset();
	        resp.resetBuffer();
	        
	        resp.setContentType("application/pdf");
	        resp.setContentLength(bytes.length);
	        ServletOutputStream ouputStream = resp.getOutputStream();
	       
	      	Statement stmtleaseapp =conn.createStatement();
	      	  
	      	String fileName="",path="", formcode="LIN",filepath=""; 
	      	String strSql1 = "select imgPath from my_comp";

	    	ResultSet rs1 = stmtleaseapp.executeQuery(strSql1);
	    	while(rs1.next ()) {
	    		path=rs1.getString("imgPath");
	    	}

	    	DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
	  		java.util.Date date = new java.util.Date();
	  		String currdate=dateFormat.format(date);
	  		
	  		String reportname="";
	  		reportname = "LimousineInvoice";
	    	fileName = reportname+"_"+currdate+".pdf";
	    	filepath=path+ "/attachment/"+formcode+"/"+fileName;

	    	File dir = new File(path+ "/attachment/"+formcode);
	    	dir.mkdirs();
	    		
	    	FileOutputStream fos = new FileOutputStream(filepath);
	      	fos.write(bytes);
	      	fos.flush();
	      	fos.close();
	      	
	      	File saveFile=new File(filepath);
	      	return saveFile;
		}
			
			private String getExtraCC(int cldocno, Connection conn) {
				// TODO Auto-generated method stub
				String cc="";
				try {
					String cc1="",cc2="",cc3="";
					Statement stmtcc=conn.createStatement();
					String strcc="SELECT coalesce(cc,'') cc FROM gl_emailmsg WHERE dtype='BIVD'";
					ResultSet rscc=stmtcc.executeQuery(strcc);
					while(rscc.next()) {
						cc=rscc.getString("cc");
					}
					
					String strextracc="SELECT COALESCE(off_mail,'') cc1,COALESCE(res_mail,'') cc2,COALESCE(hme_mail,'') cc3 FROM gl_sponsor WHERE doc_no="+cldocno;
					ResultSet rsexcc=stmtcc.executeQuery(strextracc);
					while(rsexcc.next()) {
						cc1=rsexcc.getString("cc1");
						cc2=rsexcc.getString("cc2");
						cc3=rsexcc.getString("cc3");
					}
					if(!cc1.trim().equalsIgnoreCase("")) {
						if(cc.trim().equalsIgnoreCase("")) {
							cc+=cc1;
						}
						else {
							cc+=","+cc1;
						}
					}
					
					if(!cc2.trim().equalsIgnoreCase("")) {
						if(cc.trim().equalsIgnoreCase("")) {
							cc+=cc2;
						}
						else {
							cc+=","+cc2;
						}
					}
					
					if(!cc3.trim().equalsIgnoreCase("")) {
						if(cc.trim().equalsIgnoreCase("")) {
							cc+=cc3;
						}
						else {
							cc+=","+cc3;
						}
					}
					
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				return cc;
			}

		
		
		public  void sendEmailwithMultiplepdf(String host, String port,
				final String userName, final String password,String recipient,String subject, String message, java.util.List<File> attachFileList,String docnos,String mailcc, String imgsignaturepath) throws AddressException, MessagingException {
	        // sets SMTP server properties
			
		//	System.out.println("==recipient==="+recipient+"=CC=="+CC);
		try {
			System.out.println("-------------Email Process-----------------"+message);
			System.out.println("host=="+host+"==port=="+port+"==userName=="+userName+"==password=="+password+"==recipient=="+recipient);
				Session mailsession=null;
				Properties properties = new Properties();
			if(port.equalsIgnoreCase("465")){	
		       
		        properties.setProperty("mail.smtp.protocol", "smtps");
		        properties.put("mail.smtp.auth", "true");
		        properties.put("mail.smtp.starttls.enable", "true");
		        properties.put("mail.smtp.host", host);
		        properties.put("mail.smtp.port", port);
		        properties.put("mail.smtp.debug", "true");
		        properties.put("mail.smtp.socketFactory.port", port);
		        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		        properties.put("mail.smtp.socketFactory.fallback", "false");
		        properties.put("mail.user", userName);
		        properties.put("mail.password", password);
		        //java.net.preferIPv4Stack=true;
		        // creates a new session with an authenticator
		       
			}
			if(port.equalsIgnoreCase("587")){	
				properties.put("mail.smtp.auth", "true");
				properties.put("mail.smtp.starttls.enable", "true");
				// properties.put("mail.smtp.host", "smtp.gmail.com");
				properties.put("mail.smtp.host", host);                 //  added for tokai
				properties.put("mail.smtp.ssl.protocols", "TLSv1.2");  //  added for tokai
				properties.put("mail.smtp.port", port);
			}
			else //port 25
			{
				 properties.put("mail.smtp.host", host);    // SMTP Host
				 properties.put("mail.smtp.port", port);                             // SMTP Port
				 properties.put("mail.smtp.auth", "true");                         // SMTP Authentication Enabled
			                
			      
			}
			 Authenticator auth = new Authenticator() {
		         public PasswordAuthentication getPasswordAuthentication() {
		             return new PasswordAuthentication(userName, password);
		         }
		     };
		     mailsession = Session.getInstance(properties, auth);
		        // creates a new e-mail message
		        Message msg = new MimeMessage(mailsession);
		        		
		        		System.out.println("==userName===="+userName);
		        		
		        msg.setFrom(new InternetAddress(userName));
		        System.out.println("recipient - "+recipient);
		        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
		        msg.setRecipients(Message.RecipientType.TO, toAddresses);
		        
		        
		        
		        if(!mailcc.equalsIgnoreCase("")) {
		        	if(mailcc.contains(",")) {
		        		for(int i=0;i<mailcc.split(",").length;i++) {
		                    msg.addRecipient(Message.RecipientType.CC, new InternetAddress(mailcc.split(",")[i]));
		        		}
		        	}
		        	else {
		        		msg.addRecipient(Message.RecipientType.CC, new InternetAddress(mailcc));
		        	}
		        }
		        
		        
		        
		        if(!(subject.equals(""))){
		        msg.setSubject(subject);
		        }
		        msg.setSentDate(new Date());
		 
		        // creates message part
		        Multipart multipart = new MimeMultipart();
		        docnos=docnos==null?"":docnos;
		        //nou
		        /*if(!(docnos.equalsIgnoreCase("")))
		        {*/
		        
		        
		        for(File attachFile:attachFileList) {
		        	MimeBodyPart myattach = new MimeBodyPart();
		        	DataSource source = new FileDataSource(attachFile);
		        	myattach.setDataHandler(new DataHandler(source));
		        	
		        	if (attachFile != null) {
		                MimeBodyPart attachPart = new MimeBodyPart();
		     
		                try {
		                    attachPart.attachFile(attachFile);
		                } catch (IOException ex) {
		                    ex.printStackTrace();
		                }
		     
		                multipart.addBodyPart(attachPart);
		            }
		        }
		        
		        MimeBodyPart messageBodyPart = new MimeBodyPart();
		     //   messageBodyPart.setText(message, "ISO-8859-1");  // first
		        messageBodyPart.setContent(message, "text/html");
		      // messageBodyPart.setHeader("content-Type", "text/html;charset=\"ISO-8859-1\""); // first
		        
		        if(!imgsignaturepath.trim().equalsIgnoreCase("")) {
		        	MimeBodyPart imageBodyPart = new MimeBodyPart();
		        	DataSource fds = new FileDataSource(imgsignaturepath);
		        	imageBodyPart.setDataHandler(new DataHandler(fds));
		            imageBodyPart.setHeader("Content-ID", "<image1>");
		            multipart.addBodyPart(imageBodyPart);
		        }
		        
		        multipart.addBodyPart(messageBodyPart);
		       // multipart.addBodyPart(messageBodyPart);
		 
		        // adds attachments
		       
		        // sets the multi-part as e-mail's content*/
		        msg.setContent(multipart);
		 
		        // sends the e-mail
		       // System.out.println("=====dfghjkjhgfdfghjkl======="+msg);
		        Transport.send(msg);
		}
		catch(MessagingException e) {
			e.printStackTrace();
		}

	
	
	
	
		}
	}
