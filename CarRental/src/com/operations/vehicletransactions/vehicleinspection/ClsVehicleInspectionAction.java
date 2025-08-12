package com.operations.vehicletransactions.vehicleinspection;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
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
import javax.servlet.ServletContext;
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
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsVehicleInspectionAction extends ActionSupport{
	ClsVehicleInspectionDAO inspectionDAO=new ClsVehicleInspectionDAO();
	ClsVehicleInspectionBean bean;
	ClsVehicleInspectionBean beannew;
	ClsVehicleInspectionBean beansign;
	ClsVehicleInspectionBean rentalbean;
	ClsVehicleInspectionBean leasebean;
	ClsVehicleInspectionBean rplbean;
	
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	private Map<String, Object> par=null;
	private int docno;
	private String refvoucherno;
	private String brchName;
	private String date;
	private String hiddate;
	private String cmbtype;
	private String hidcmbtype;
	private String cmbreftype;
	private String hidcmbreftype;
	private int rdocno;
	private String amount;
	private String accdate;
	private String hidaccdate;
	private String prcs;
	private String collectdate;
	private String hidcollectdate;
	private String accplace;
	private String accfines;
	private String cmbclaim;
	private String hidcmbclaim;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetail;
	private String formdetailcode;
	private String hidaccidents;
	private String accremarks;
	private String rfleet;
	private int damagegridlength;
	private int maintenancegridlength;
	private int existdamagegridlength;
	private String time;
	private String hidtime;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String regno;
	private String client;
	private String lblregno;
	private String lblfleetname;
	private String visano;
	private String visaexp;
	private String userid;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getVisano() {
		return visano;
	}
	public void setVisano(String visano) {
		this.visano = visano;
	}
	public String getVisaexp() {
		return visaexp;
	}
	public void setVisaexp(String visaexp) {
		this.visaexp = visaexp;
	}
	public String getLblregno() {
		return lblregno;
	}
	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}
	public String getLblfleetname() {
		return lblfleetname;
	}
	public void setLblfleetname(String lblfleetname) {
		this.lblfleetname = lblfleetname;
	}
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getCmbagmtbranch() {
		return cmbagmtbranch;
	}
	public void setCmbagmtbranch(String cmbagmtbranch) {
		this.cmbagmtbranch = cmbagmtbranch;
	}
	public String getHidcmbagmtbranch() {
		return hidcmbagmtbranch;
	}
	public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
		this.hidcmbagmtbranch = hidcmbagmtbranch;
	}


	//Save File 
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
	private String message = ""; 
	
	//Print
	
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
    private String lbldocno;
    private String lbldate;
    private String lbltime;
    private String lbltype;
    private String lblreftype;
    private String lblreffleetno;
    private String lblrefdocno;
    private String lblaccdate;
    private String lblprcs;
    private String lblcoldate;
    private String lblplace;
    private String lblfines;
    private String lblclaim;
    private String lblremarks;
    private String lblamount;
    private String lblaccident;
    private String lblprintname;
    private String lblhidexisting;
    private String lblhidnew;
    private String lblurl;


    
  public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
public String getRefvoucherno() {
		return refvoucherno;
	}
	public void setRefvoucherno(String refvoucherno) {
		this.refvoucherno = refvoucherno;
	}
public String getLblurl() {
		return lblurl;
	}
	public void setLblurl(String lblurl) {
		this.lblurl = lblurl;
	}
	public String getLblhidexisting() {
		return lblhidexisting;
	}
	public void setLblhidexisting(String lblhidexisting) {
		this.lblhidexisting = lblhidexisting;
	}
	public String getLblhidnew() {
		return lblhidnew;
	}
	public void setLblhidnew(String lblhidnew) {
		this.lblhidnew = lblhidnew;
	}
    public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblaccident() {
		return lblaccident;
	}
	public void setLblaccident(String lblaccident) {
		this.lblaccident = lblaccident;
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
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltime() {
		return lbltime;
	}
	public void setLbltime(String lbltime) {
		this.lbltime = lbltime;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLblreftype() {
		return lblreftype;
	}
	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}
	public String getLblreffleetno() {
		return lblreffleetno;
	}
	public void setLblreffleetno(String lblreffleetno) {
		this.lblreffleetno = lblreffleetno;
	}
	public String getLblrefdocno() {
		return lblrefdocno;
	}
	public void setLblrefdocno(String lblrefdocno) {
		this.lblrefdocno = lblrefdocno;
	}
	public String getLblaccdate() {
		return lblaccdate;
	}
	public void setLblaccdate(String lblaccdate) {
		this.lblaccdate = lblaccdate;
	}
	public String getLblprcs() {
		return lblprcs;
	}
	public void setLblprcs(String lblprcs) {
		this.lblprcs = lblprcs;
	}
	public String getLblcoldate() {
		return lblcoldate;
	}
	public void setLblcoldate(String lblcoldate) {
		this.lblcoldate = lblcoldate;
	}
	public String getLblplace() {
		return lblplace;
	}
	public void setLblplace(String lblplace) {
		this.lblplace = lblplace;
	}
	public String getLblfines() {
		return lblfines;
	}
	public void setLblfines(String lblfines) {
		this.lblfines = lblfines;
	}
	public String getLblclaim() {
		return lblclaim;
	}
	public void setLblclaim(String lblclaim) {
		this.lblclaim = lblclaim;
	}
	public String getLblremarks() {
		return lblremarks;
	}
	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}
	public String getLblamount() {
		return lblamount;
	}
	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileFileContentType() {
		return fileFileContentType;
	}
	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getHidtime() {
		return hidtime;
	}
	public void setHidtime(String hidtime) {
		this.hidtime = hidtime;
	}
	public int getExistdamagegridlength() {
		return existdamagegridlength;
	}
	public void setExistdamagegridlength(int existdamagegridlength) {
		this.existdamagegridlength = existdamagegridlength;
	}
	public int getDamagegridlength() {
		return damagegridlength;
	}
	public void setDamagegridlength(int damagegridlength) {
		this.damagegridlength = damagegridlength;
	}
	public int getMaintenancegridlength() {
		return maintenancegridlength;
	}
	public void setMaintenancegridlength(int maintenancegridlength) {
		this.maintenancegridlength = maintenancegridlength;
	}
	public String getRfleet() {
		return rfleet;
	}
	public void setRfleet(String rfleet) {
		this.rfleet = rfleet;
	}
	public String getAccremarks() {
		return accremarks;
	}
	public void setAccremarks(String accremarks) {
		this.accremarks = accremarks;
	}
	public String getHidaccidents() {
		return hidaccidents;
	}
	public void setHidaccidents(String hidaccidents) {
		this.hidaccidents = hidaccidents;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public int getRdocno() {
		return rdocno;
	}
	public void setRdocno(int rdocno) {
		this.rdocno = rdocno;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getAccdate() {
		return accdate;
	}
	public void setAccdate(String accdate) {
		this.accdate = accdate;
	}
	public String getHidaccdate() {
		return hidaccdate;
	}
	public void setHidaccdate(String hidaccdate) {
		this.hidaccdate = hidaccdate;
	}
	public String getPrcs() {
		return prcs;
	}
	public void setPrcs(String prcs) {
		this.prcs = prcs;
	}
	public String getCollectdate() {
		return collectdate;
	}
	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}
	public String getHidcollectdate() {
		return hidcollectdate;
	}
	public void setHidcollectdate(String hidcollectdate) {
		this.hidcollectdate = hidcollectdate;
	}
	public String getAccplace() {
		return accplace;
	}
	public void setAccplace(String accplace) {
		this.accplace = accplace;
	}
	public String getAccfines() {
		return accfines;
	}
	public void setAccfines(String accfines) {
		this.accfines = accfines;
	}
	public String getCmbclaim() {
		return cmbclaim;
	}
	public void setCmbclaim(String cmbclaim) {
		this.cmbclaim = cmbclaim;
	}
	public String getHidcmbclaim() {
		return hidcmbclaim;
	}
	public void setHidcmbclaim(String hidcmbclaim) {
		this.hidcmbclaim = hidcmbclaim;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	private String vehauth;
	private String rentalproject,hidrentalproject;
	private String lbldesc,lblauthority,ramobile;
	private double totaltot,rentaltotals;
	private String lbldeldate;
	private String lbldeltime;
	private String lbldelkm;
	private String lbldelfuel;
	private String lblcollectdate;
	private String lblcollecttime;
	private String lblcollectkm;
	private String lblcollectfuel;

	private String lblpassissdate;
	private String lblvisaexp;
	private String lblvisaissdate;
	private String lblclientrn;
	private String rayear;
	private String inspdoc;
	private String sal_docno;
	private String sal_id;
	private String sal_name;
	private String cardtype;
	private String acode;
	private String cardno;
	private String exdate;
	private String recieptno,delcharges,rasupercdw,ravmd;
	private int delchkvalue;
	private int  advance_chkval;
	private int advance_chk;
	private int masterdoc_no;
	private String ch_no;
	private String ravehplate,lblnofdays,lbltraficfine,lblsalik,lblrentaldesc,lblrentaltype,lblrentalrate,lblcldocno,lbluser,lblagmtbrhid;
	private String ravehauthregno;
	private int weekendval,weekend;
	private String lblnation,lblissfromdate,lblissby,lblidno,lblpassissued;
	private String lbladdpassno1,lbladdpassexp1,lbladdnation1,lbladdissby1,lbladdissfrom1,lbladdid1,lbladdpassissued1;
	private String lblcompwebsite,lblcompmail;	
	private String lbltel1,lbltel2,duedate, salagent ,raagent,  salname,duetime ,createdate;

	private String jqxRentalDate;
	private String hidjqxRentalDate;
	private String  txtfleetno;	
	private String vehlocation;
	private String txtcusid;
	private int re_salmanid;
	private String re_clcodeno;
	private String re_clacno;
	private String rentaldesc;
	private int additional_driver;
	private String adidrvcharges;
	private int delivery_chk;
	private int radrivercheck;
	private int del_chaufferid;
	private String client_driverid;
	 private String ratariffsystem;
	 private String ratariffdocno1;
	 private String invoice;
	 private String excessinsur;
	 private String veh_fleetgrouptariff;
	 private String re_Km;
	 private String ratariff_fuel;
	 private int tariffsales_Agentid;
	 private int tariffrenral_Agentid;
	 private String jqxDateOut;  //out date
	 private String hidjqxDateOut;
	 private String jqxTimeOut;   // out time
	 private String hidjqxTimeOut;
	 private String ratariff_checkout;
	 private int ratariff_checkoutid;
	 private String jqxOnDate;   // due date
	 private String hidjqxOnDate;
	 private String jqxOnTime;   // due time
	 private String hidjqxOnTime;
	 private String hidvehfuel;
	 private String payment_Mra;
	private String payment_PO;
	 private String payment_Conveh;// original fleet
	 private String del_chaufferid2;
	 private String del_KM;
	 private String del_Fuel;
	 private String jqxDeliveryOut;
	 private String hidjqxDeliveryOut;
	 private String jqxDelTimeOut;
	 private String hidjqxDelTimeOut;
	 private String rentaltype; 
	 private String vehdetails;
	 private String client_Name;
	 private String re_salman;
	 private String radriverlist;
	 private String rasales_Agent;
	 private String rarenral_Agent;
	 private String cusaddress;  
	 private String salikcharge,trafficcharge,totalsalikandtraffic;
	 private String del_Driver; 
	 private String rentalstatus,rafuelout,rayom,racolor,adddrname1,adddrname2,addlicno1,addlicno2,expdate1,expdate2,adddob1,adddob2,raextrakm,raexxtakmchg,rarenttypes;
	 private String clname,claddress,clmobno,clemail,barnchval,mrano,rentaldoc,radrname,radlno,passno,licexpdate,passexpdate,dobdate;
	private String ravehname,ravehregno,ravehmodel,ravehgroup,radateout,ratimeout,raklmout,excessinsu; 
	private String radaily,raweakly,ramonthly,tariff,racdwscdw,raaccessory,rarentserdue,raadditionalcge;
	private String inkm,infuel,indate,intime,rastatus,totalpaid,invamount,balance;
	private String companyname,address,mobileno,fax,location;
	private String deldates,deltimes,delkmins,delfuels;
	private String branchname;
	private String lblclientname;
	private String lblfleetno;
	private String lbldateout;
	private String lbltimeout;
	private String lblfuelout;
	private String lbldatein;
	private String lbltimein;
	private String lblkmin;
	private String lblfuelin;
	private String lblsumotherdebit;
	private String lblsumothercredit;
	private String lblsumcrvdebit;
	private String lblsumcrvcredit;
	private String lblnetbalance;
	private String coldates,coltimes,colkmins,colfuels;
	private String outdetails,deldetailss;
	private String indetails,coldetails;
	private String lblclname,lblcladdress,lblpertel,lblfaxno,lblclmobno,lblclemail,lbldobdate,lblradlno,lbcardno,lbexpcarddate,drivravehregno;
	private String ldllandno;
	private String  lblpai,laldelcharge,lblchafcharge;
	private String securitycardno,securityexpdate,securitypreauthno,securitypreauthamt,tarifftotal,racdwscdwtotal,raaccessorytotal,laldelchargetotal, advtotalamont,advpaidamount,advbalance;
	private String lblcosmofleetno;
	private String lblcosmofleetbrand;
	private String lblcosmoissuedat;
	private String lblcosmocheckin;
	private String lblcosmocheckout;
	private String lblcosmokmin;
	private String lblcosmofuelin;
	private String lblcosmocreditcardno;
	private String lblcosmocreditvaliddate;
	private String lblcosmosecurity;
	private String lblcosmoexcessamt;
	private String lblcosmogps;
	private String lblcosmobabyseater;
	private String lblcosmocollectchg;
	private String lblcosmodamagechg;
	public ClsVehicleInspectionBean getRentalbean() {
		return rentalbean;
	}
	public void setRentalbean(ClsVehicleInspectionBean rentalbean) {
		this.rentalbean = rentalbean;
	}
	public String getRatariff_checkout() {
		return ratariff_checkout;
	}
	public void setRatariff_checkout(String ratariff_checkout) {
		this.ratariff_checkout = ratariff_checkout;
	}
	public int getRatariff_checkoutid() {
		return ratariff_checkoutid;
	}
	public void setRatariff_checkoutid(int ratariff_checkoutid) {
		this.ratariff_checkoutid = ratariff_checkoutid;
	}
	public String getJqxOnDate() {
		return jqxOnDate;
	}
	public void setJqxOnDate(String jqxOnDate) {
		this.jqxOnDate = jqxOnDate;
	}
	public String getHidjqxOnDate() {
		return hidjqxOnDate;
	}
	public void setHidjqxOnDate(String hidjqxOnDate) {
		this.hidjqxOnDate = hidjqxOnDate;
	}
	public String getJqxOnTime() {
		return jqxOnTime;
	}
	public void setJqxOnTime(String jqxOnTime) {
		this.jqxOnTime = jqxOnTime;
	}
	public String getHidjqxOnTime() {
		return hidjqxOnTime;
	}
	public void setHidjqxOnTime(String hidjqxOnTime) {
		this.hidjqxOnTime = hidjqxOnTime;
	}
	public String getHidvehfuel() {
		return hidvehfuel;
	}
	public void setHidvehfuel(String hidvehfuel) {
		this.hidvehfuel = hidvehfuel;
	}
	public String getPayment_Mra() {
		return payment_Mra;
	}
	public void setPayment_Mra(String payment_Mra) {
		this.payment_Mra = payment_Mra;
	}
	public String getPayment_PO() {
		return payment_PO;
	}
	public void setPayment_PO(String payment_PO) {
		this.payment_PO = payment_PO;
	}
	public String getPayment_Conveh() {
		return payment_Conveh;
	}
	public void setPayment_Conveh(String payment_Conveh) {
		this.payment_Conveh = payment_Conveh;
	}
	public String getDel_chaufferid2() {
		return del_chaufferid2;
	}
	public void setDel_chaufferid2(String del_chaufferid2) {
		this.del_chaufferid2 = del_chaufferid2;
	}
	public String getDel_KM() {
		return del_KM;
	}
	public void setDel_KM(String del_KM) {
		this.del_KM = del_KM;
	}
	public String getDel_Fuel() {
		return del_Fuel;
	}
	public void setDel_Fuel(String del_Fuel) {
		this.del_Fuel = del_Fuel;
	}
	public String getJqxDeliveryOut() {
		return jqxDeliveryOut;
	}
	public void setJqxDeliveryOut(String jqxDeliveryOut) {
		this.jqxDeliveryOut = jqxDeliveryOut;
	}
	public String getHidjqxDeliveryOut() {
		return hidjqxDeliveryOut;
	}
	public void setHidjqxDeliveryOut(String hidjqxDeliveryOut) {
		this.hidjqxDeliveryOut = hidjqxDeliveryOut;
	}
	public String getJqxDelTimeOut() {
		return jqxDelTimeOut;
	}
	public void setJqxDelTimeOut(String jqxDelTimeOut) {
		this.jqxDelTimeOut = jqxDelTimeOut;
	}
	public String getHidjqxDelTimeOut() {
		return hidjqxDelTimeOut;
	}
	public void setHidjqxDelTimeOut(String hidjqxDelTimeOut) {
		this.hidjqxDelTimeOut = hidjqxDelTimeOut;
	}
	public String getRentaltype() {
		return rentaltype;
	}
	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}
	public String getVehdetails() {
		return vehdetails;
	}
	public void setVehdetails(String vehdetails) {
		this.vehdetails = vehdetails;
	}
	public String getClient_Name() {
		return client_Name;
	}
	public void setClient_Name(String client_Name) {
		this.client_Name = client_Name;
	}
	public String getRe_salman() {
		return re_salman;
	}
	public void setRe_salman(String re_salman) {
		this.re_salman = re_salman;
	}
	public String getRadriverlist() {
		return radriverlist;
	}
	public void setRadriverlist(String radriverlist) {
		this.radriverlist = radriverlist;
	}
	public String getRasales_Agent() {
		return rasales_Agent;
	}
	public void setRasales_Agent(String rasales_Agent) {
		this.rasales_Agent = rasales_Agent;
	}
	public String getRarenral_Agent() {
		return rarenral_Agent;
	}
	public void setRarenral_Agent(String rarenral_Agent) {
		this.rarenral_Agent = rarenral_Agent;
	}
	public String getCusaddress() {
		return cusaddress;
	}
	public void setCusaddress(String cusaddress) {
		this.cusaddress = cusaddress;
	}
	public String getSalikcharge() {
		return salikcharge;
	}
	public void setSalikcharge(String salikcharge) {
		this.salikcharge = salikcharge;
	}
	public String getTrafficcharge() {
		return trafficcharge;
	}
	public void setTrafficcharge(String trafficcharge) {
		this.trafficcharge = trafficcharge;
	}
	public String getTotalsalikandtraffic() {
		return totalsalikandtraffic;
	}
	public void setTotalsalikandtraffic(String totalsalikandtraffic) {
		this.totalsalikandtraffic = totalsalikandtraffic;
	}
	public String getDel_Driver() {
		return del_Driver;
	}
	public void setDel_Driver(String del_Driver) {
		this.del_Driver = del_Driver;
	}
	public String getRentalstatus() {
		return rentalstatus;
	}
	public void setRentalstatus(String rentalstatus) {
		this.rentalstatus = rentalstatus;
	}
	public String getRafuelout() {
		return rafuelout;
	}
	public void setRafuelout(String rafuelout) {
		this.rafuelout = rafuelout;
	}
	public String getRayom() {
		return rayom;
	}
	public void setRayom(String rayom) {
		this.rayom = rayom;
	}
	public String getRacolor() {
		return racolor;
	}
	public void setRacolor(String racolor) {
		this.racolor = racolor;
	}
	public String getAdddrname1() {
		return adddrname1;
	}
	public void setAdddrname1(String adddrname1) {
		this.adddrname1 = adddrname1;
	}
	public String getAdddrname2() {
		return adddrname2;
	}
	public void setAdddrname2(String adddrname2) {
		this.adddrname2 = adddrname2;
	}
	public String getAddlicno1() {
		return addlicno1;
	}
	public void setAddlicno1(String addlicno1) {
		this.addlicno1 = addlicno1;
	}
	public String getAddlicno2() {
		return addlicno2;
	}
	public void setAddlicno2(String addlicno2) {
		this.addlicno2 = addlicno2;
	}
	public String getExpdate1() {
		return expdate1;
	}
	public void setExpdate1(String expdate1) {
		this.expdate1 = expdate1;
	}
	public String getExpdate2() {
		return expdate2;
	}
	public void setExpdate2(String expdate2) {
		this.expdate2 = expdate2;
	}
	public String getAdddob1() {
		return adddob1;
	}
	public void setAdddob1(String adddob1) {
		this.adddob1 = adddob1;
	}
	public String getAdddob2() {
		return adddob2;
	}
	public void setAdddob2(String adddob2) {
		this.adddob2 = adddob2;
	}
	public String getRaextrakm() {
		return raextrakm;
	}
	public void setRaextrakm(String raextrakm) {
		this.raextrakm = raextrakm;
	}
	public String getRaexxtakmchg() {
		return raexxtakmchg;
	}
	public void setRaexxtakmchg(String raexxtakmchg) {
		this.raexxtakmchg = raexxtakmchg;
	}
	public String getRarenttypes() {
		return rarenttypes;
	}
	public void setRarenttypes(String rarenttypes) {
		this.rarenttypes = rarenttypes;
	}
	public String getClname() {
		return clname;
	}
	public void setClname(String clname) {
		this.clname = clname;
	}
	public String getCladdress() {
		return claddress;
	}
	public void setCladdress(String claddress) {
		this.claddress = claddress;
	}
	public String getClmobno() {
		return clmobno;
	}
	public void setClmobno(String clmobno) {
		this.clmobno = clmobno;
	}
	public String getClemail() {
		return clemail;
	}
	public void setClemail(String clemail) {
		this.clemail = clemail;
	}
	public String getBarnchval() {
		return barnchval;
	}
	public void setBarnchval(String barnchval) {
		this.barnchval = barnchval;
	}
	public String getMrano() {
		return mrano;
	}
	public void setMrano(String mrano) {
		this.mrano = mrano;
	}
	public String getRentaldoc() {
		return rentaldoc;
	}
	public void setRentaldoc(String rentaldoc) {
		this.rentaldoc = rentaldoc;
	}
	public String getRadrname() {
		return radrname;
	}
	public void setRadrname(String radrname) {
		this.radrname = radrname;
	}
	public String getRadlno() {
		return radlno;
	}
	public void setRadlno(String radlno) {
		this.radlno = radlno;
	}
	public String getPassno() {
		return passno;
	}
	public void setPassno(String passno) {
		this.passno = passno;
	}
	public String getLicexpdate() {
		return licexpdate;
	}
	public void setLicexpdate(String licexpdate) {
		this.licexpdate = licexpdate;
	}
	public String getPassexpdate() {
		return passexpdate;
	}
	public void setPassexpdate(String passexpdate) {
		this.passexpdate = passexpdate;
	}
	public String getDobdate() {
		return dobdate;
	}
	public void setDobdate(String dobdate) {
		this.dobdate = dobdate;
	}
	public String getRavehname() {
		return ravehname;
	}
	public void setRavehname(String ravehname) {
		this.ravehname = ravehname;
	}
	public String getRavehregno() {
		return ravehregno;
	}
	public void setRavehregno(String ravehregno) {
		this.ravehregno = ravehregno;
	}
	public String getRavehmodel() {
		return ravehmodel;
	}
	public void setRavehmodel(String ravehmodel) {
		this.ravehmodel = ravehmodel;
	}
	public String getRavehgroup() {
		return ravehgroup;
	}
	public void setRavehgroup(String ravehgroup) {
		this.ravehgroup = ravehgroup;
	}
	public String getRadateout() {
		return radateout;
	}
	public void setRadateout(String radateout) {
		this.radateout = radateout;
	}
	public String getRatimeout() {
		return ratimeout;
	}
	public void setRatimeout(String ratimeout) {
		this.ratimeout = ratimeout;
	}
	public String getRaklmout() {
		return raklmout;
	}
	public void setRaklmout(String raklmout) {
		this.raklmout = raklmout;
	}
	public String getExcessinsu() {
		return excessinsu;
	}
	public void setExcessinsu(String excessinsu) {
		this.excessinsu = excessinsu;
	}
	public String getRadaily() {
		return radaily;
	}
	public void setRadaily(String radaily) {
		this.radaily = radaily;
	}
	public String getRaweakly() {
		return raweakly;
	}
	public void setRaweakly(String raweakly) {
		this.raweakly = raweakly;
	}
	public String getRamonthly() {
		return ramonthly;
	}
	public void setRamonthly(String ramonthly) {
		this.ramonthly = ramonthly;
	}
	public String getTariff() {
		return tariff;
	}
	public void setTariff(String tariff) {
		this.tariff = tariff;
	}
	public String getRacdwscdw() {
		return racdwscdw;
	}
	public void setRacdwscdw(String racdwscdw) {
		this.racdwscdw = racdwscdw;
	}
	public String getRaaccessory() {
		return raaccessory;
	}
	public void setRaaccessory(String raaccessory) {
		this.raaccessory = raaccessory;
	}
	public String getRarentserdue() {
		return rarentserdue;
	}
	public void setRarentserdue(String rarentserdue) {
		this.rarentserdue = rarentserdue;
	}
	public String getRaadditionalcge() {
		return raadditionalcge;
	}
	public void setRaadditionalcge(String raadditionalcge) {
		this.raadditionalcge = raadditionalcge;
	}
	public String getInkm() {
		return inkm;
	}
	public void setInkm(String inkm) {
		this.inkm = inkm;
	}
	public String getInfuel() {
		return infuel;
	}
	public void setInfuel(String infuel) {
		this.infuel = infuel;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getIntime() {
		return intime;
	}
	public void setIntime(String intime) {
		this.intime = intime;
	}
	public String getRastatus() {
		return rastatus;
	}
	public void setRastatus(String rastatus) {
		this.rastatus = rastatus;
	}
	public String getTotalpaid() {
		return totalpaid;
	}
	public void setTotalpaid(String totalpaid) {
		this.totalpaid = totalpaid;
	}
	public String getInvamount() {
		return invamount;
	}
	public void setInvamount(String invamount) {
		this.invamount = invamount;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobileno() {
		return mobileno;
	}
	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDeldates() {
		return deldates;
	}
	public void setDeldates(String deldates) {
		this.deldates = deldates;
	}
	public String getDeltimes() {
		return deltimes;
	}
	public void setDeltimes(String deltimes) {
		this.deltimes = deltimes;
	}
	public String getDelkmins() {
		return delkmins;
	}
	public void setDelkmins(String delkmins) {
		this.delkmins = delkmins;
	}
	public String getDelfuels() {
		return delfuels;
	}
	public void setDelfuels(String delfuels) {
		this.delfuels = delfuels;
	}
	public String getBranchname() {
		return branchname;
	}
	public void setBranchname(String branchname) {
		this.branchname = branchname;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLblfleetno() {
		return lblfleetno;
	}
	public void setLblfleetno(String lblfleetno) {
		this.lblfleetno = lblfleetno;
	}
	public String getLbldateout() {
		return lbldateout;
	}
	public void setLbldateout(String lbldateout) {
		this.lbldateout = lbldateout;
	}
	public String getLbltimeout() {
		return lbltimeout;
	}
	public void setLbltimeout(String lbltimeout) {
		this.lbltimeout = lbltimeout;
	}
	public String getLblfuelout() {
		return lblfuelout;
	}
	public void setLblfuelout(String lblfuelout) {
		this.lblfuelout = lblfuelout;
	}
	public String getLbldatein() {
		return lbldatein;
	}
	public void setLbldatein(String lbldatein) {
		this.lbldatein = lbldatein;
	}
	public String getLbltimein() {
		return lbltimein;
	}
	public void setLbltimein(String lbltimein) {
		this.lbltimein = lbltimein;
	}
	public String getLblkmin() {
		return lblkmin;
	}
	public void setLblkmin(String lblkmin) {
		this.lblkmin = lblkmin;
	}
	public String getLblfuelin() {
		return lblfuelin;
	}
	public void setLblfuelin(String lblfuelin) {
		this.lblfuelin = lblfuelin;
	}
	public String getLblsumotherdebit() {
		return lblsumotherdebit;
	}
	public void setLblsumotherdebit(String lblsumotherdebit) {
		this.lblsumotherdebit = lblsumotherdebit;
	}
	public String getLblsumothercredit() {
		return lblsumothercredit;
	}
	public void setLblsumothercredit(String lblsumothercredit) {
		this.lblsumothercredit = lblsumothercredit;
	}
	public String getLblsumcrvdebit() {
		return lblsumcrvdebit;
	}
	public void setLblsumcrvdebit(String lblsumcrvdebit) {
		this.lblsumcrvdebit = lblsumcrvdebit;
	}
	public String getLblsumcrvcredit() {
		return lblsumcrvcredit;
	}
	public void setLblsumcrvcredit(String lblsumcrvcredit) {
		this.lblsumcrvcredit = lblsumcrvcredit;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	public String getColdates() {
		return coldates;
	}
	public void setColdates(String coldates) {
		this.coldates = coldates;
	}
	public String getColtimes() {
		return coltimes;
	}
	public void setColtimes(String coltimes) {
		this.coltimes = coltimes;
	}
	public String getColkmins() {
		return colkmins;
	}
	public void setColkmins(String colkmins) {
		this.colkmins = colkmins;
	}
	public String getColfuels() {
		return colfuels;
	}
	public void setColfuels(String colfuels) {
		this.colfuels = colfuels;
	}
	public String getOutdetails() {
		return outdetails;
	}
	public void setOutdetails(String outdetails) {
		this.outdetails = outdetails;
	}
	public String getDeldetailss() {
		return deldetailss;
	}
	public void setDeldetailss(String deldetailss) {
		this.deldetailss = deldetailss;
	}
	public String getIndetails() {
		return indetails;
	}
	public void setIndetails(String indetails) {
		this.indetails = indetails;
	}
	public String getColdetails() {
		return coldetails;
	}
	public void setColdetails(String coldetails) {
		this.coldetails = coldetails;
	}
	public String getLblclname() {
		return lblclname;
	}
	public void setLblclname(String lblclname) {
		this.lblclname = lblclname;
	}
	public String getLblcladdress() {
		return lblcladdress;
	}
	public void setLblcladdress(String lblcladdress) {
		this.lblcladdress = lblcladdress;
	}
	public String getLblpertel() {
		return lblpertel;
	}
	public void setLblpertel(String lblpertel) {
		this.lblpertel = lblpertel;
	}
	public String getLblfaxno() {
		return lblfaxno;
	}
	public void setLblfaxno(String lblfaxno) {
		this.lblfaxno = lblfaxno;
	}
	public String getLblclmobno() {
		return lblclmobno;
	}
	public void setLblclmobno(String lblclmobno) {
		this.lblclmobno = lblclmobno;
	}
	public String getLblclemail() {
		return lblclemail;
	}
	public void setLblclemail(String lblclemail) {
		this.lblclemail = lblclemail;
	}
	public String getLbldobdate() {
		return lbldobdate;
	}
	public void setLbldobdate(String lbldobdate) {
		this.lbldobdate = lbldobdate;
	}
	public String getLblradlno() {
		return lblradlno;
	}
	public void setLblradlno(String lblradlno) {
		this.lblradlno = lblradlno;
	}
	public String getLbcardno() {
		return lbcardno;
	}
	public void setLbcardno(String lbcardno) {
		this.lbcardno = lbcardno;
	}
	public String getLbexpcarddate() {
		return lbexpcarddate;
	}
	public void setLbexpcarddate(String lbexpcarddate) {
		this.lbexpcarddate = lbexpcarddate;
	}
	public String getDrivravehregno() {
		return drivravehregno;
	}
	public void setDrivravehregno(String drivravehregno) {
		this.drivravehregno = drivravehregno;
	}
	public String getLdllandno() {
		return ldllandno;
	}
	public void setLdllandno(String ldllandno) {
		this.ldllandno = ldllandno;
	}
	public String getLblpai() {
		return lblpai;
	}
	public void setLblpai(String lblpai) {
		this.lblpai = lblpai;
	}
	public String getLaldelcharge() {
		return laldelcharge;
	}
	public void setLaldelcharge(String laldelcharge) {
		this.laldelcharge = laldelcharge;
	}
	public String getLblchafcharge() {
		return lblchafcharge;
	}
	public void setLblchafcharge(String lblchafcharge) {
		this.lblchafcharge = lblchafcharge;
	}
	public String getSecuritycardno() {
		return securitycardno;
	}
	public void setSecuritycardno(String securitycardno) {
		this.securitycardno = securitycardno;
	}
	public String getSecurityexpdate() {
		return securityexpdate;
	}
	public void setSecurityexpdate(String securityexpdate) {
		this.securityexpdate = securityexpdate;
	}
	public String getSecuritypreauthno() {
		return securitypreauthno;
	}
	public void setSecuritypreauthno(String securitypreauthno) {
		this.securitypreauthno = securitypreauthno;
	}
	public String getSecuritypreauthamt() {
		return securitypreauthamt;
	}
	public void setSecuritypreauthamt(String securitypreauthamt) {
		this.securitypreauthamt = securitypreauthamt;
	}
	public String getTarifftotal() {
		return tarifftotal;
	}
	public void setTarifftotal(String tarifftotal) {
		this.tarifftotal = tarifftotal;
	}
	public String getRacdwscdwtotal() {
		return racdwscdwtotal;
	}
	public void setRacdwscdwtotal(String racdwscdwtotal) {
		this.racdwscdwtotal = racdwscdwtotal;
	}
	public String getRaaccessorytotal() {
		return raaccessorytotal;
	}
	public void setRaaccessorytotal(String raaccessorytotal) {
		this.raaccessorytotal = raaccessorytotal;
	}
	public String getLaldelchargetotal() {
		return laldelchargetotal;
	}
	public void setLaldelchargetotal(String laldelchargetotal) {
		this.laldelchargetotal = laldelchargetotal;
	}
	public String getAdvtotalamont() {
		return advtotalamont;
	}
	public void setAdvtotalamont(String advtotalamont) {
		this.advtotalamont = advtotalamont;
	}
	public String getAdvpaidamount() {
		return advpaidamount;
	}
	public void setAdvpaidamount(String advpaidamount) {
		this.advpaidamount = advpaidamount;
	}
	public String getAdvbalance() {
		return advbalance;
	}
	public void setAdvbalance(String advbalance) {
		this.advbalance = advbalance;
	}
	public String getLblcosmofleetno() {
		return lblcosmofleetno;
	}
	public void setLblcosmofleetno(String lblcosmofleetno) {
		this.lblcosmofleetno = lblcosmofleetno;
	}
	public String getLblcosmofleetbrand() {
		return lblcosmofleetbrand;
	}
	public void setLblcosmofleetbrand(String lblcosmofleetbrand) {
		this.lblcosmofleetbrand = lblcosmofleetbrand;
	}
	public String getLblcosmoissuedat() {
		return lblcosmoissuedat;
	}
	public void setLblcosmoissuedat(String lblcosmoissuedat) {
		this.lblcosmoissuedat = lblcosmoissuedat;
	}
	public String getLblcosmocheckin() {
		return lblcosmocheckin;
	}
	public void setLblcosmocheckin(String lblcosmocheckin) {
		this.lblcosmocheckin = lblcosmocheckin;
	}
	public String getLblcosmocheckout() {
		return lblcosmocheckout;
	}
	public void setLblcosmocheckout(String lblcosmocheckout) {
		this.lblcosmocheckout = lblcosmocheckout;
	}
	public String getLblcosmokmin() {
		return lblcosmokmin;
	}
	public void setLblcosmokmin(String lblcosmokmin) {
		this.lblcosmokmin = lblcosmokmin;
	}
	public String getLblcosmofuelin() {
		return lblcosmofuelin;
	}
	public void setLblcosmofuelin(String lblcosmofuelin) {
		this.lblcosmofuelin = lblcosmofuelin;
	}
	public String getLblcosmocreditcardno() {
		return lblcosmocreditcardno;
	}
	public void setLblcosmocreditcardno(String lblcosmocreditcardno) {
		this.lblcosmocreditcardno = lblcosmocreditcardno;
	}
	public String getLblcosmocreditvaliddate() {
		return lblcosmocreditvaliddate;
	}
	public void setLblcosmocreditvaliddate(String lblcosmocreditvaliddate) {
		this.lblcosmocreditvaliddate = lblcosmocreditvaliddate;
	}
	public String getLblcosmosecurity() {
		return lblcosmosecurity;
	}
	public void setLblcosmosecurity(String lblcosmosecurity) {
		this.lblcosmosecurity = lblcosmosecurity;
	}
	public String getLblcosmoexcessamt() {
		return lblcosmoexcessamt;
	}
	public void setLblcosmoexcessamt(String lblcosmoexcessamt) {
		this.lblcosmoexcessamt = lblcosmoexcessamt;
	}
	public String getLblcosmogps() {
		return lblcosmogps;
	}
	public void setLblcosmogps(String lblcosmogps) {
		this.lblcosmogps = lblcosmogps;
	}
	public String getLblcosmobabyseater() {
		return lblcosmobabyseater;
	}
	public void setLblcosmobabyseater(String lblcosmobabyseater) {
		this.lblcosmobabyseater = lblcosmobabyseater;
	}
	public String getLblcosmocollectchg() {
		return lblcosmocollectchg;
	}
	public void setLblcosmocollectchg(String lblcosmocollectchg) {
		this.lblcosmocollectchg = lblcosmocollectchg;
	}
	public String getLblcosmodamagechg() {
		return lblcosmodamagechg;
	}
	public void setLblcosmodamagechg(String lblcosmodamagechg) {
		this.lblcosmodamagechg = lblcosmodamagechg;
	}
	public String getLblcosmofuelchg() {
		return lblcosmofuelchg;
	}
	public void setLblcosmofuelchg(String lblcosmofuelchg) {
		this.lblcosmofuelchg = lblcosmofuelchg;
	}
	public String getLblcosmototal() {
		return lblcosmototal;
	}
	public void setLblcosmototal(String lblcosmototal) {
		this.lblcosmototal = lblcosmototal;
	}
	public String getLblcosmoadvance() {
		return lblcosmoadvance;
	}
	public void setLblcosmoadvance(String lblcosmoadvance) {
		this.lblcosmoadvance = lblcosmoadvance;
	}
	public String getLblcosmokmrestrictdaily() {
		return lblcosmokmrestrictdaily;
	}
	public void setLblcosmokmrestrictdaily(String lblcosmokmrestrictdaily) {
		this.lblcosmokmrestrictdaily = lblcosmokmrestrictdaily;
	}
	public String getLblcosmokmrestrictweekly() {
		return lblcosmokmrestrictweekly;
	}
	public void setLblcosmokmrestrictweekly(String lblcosmokmrestrictweekly) {
		this.lblcosmokmrestrictweekly = lblcosmokmrestrictweekly;
	}
	public String getLblcosmokmrestrictmonthly() {
		return lblcosmokmrestrictmonthly;
	}
	public void setLblcosmokmrestrictmonthly(String lblcosmokmrestrictmonthly) {
		this.lblcosmokmrestrictmonthly = lblcosmokmrestrictmonthly;
	}
	public String getLblcosmoexkmratedaily() {
		return lblcosmoexkmratedaily;
	}
	public void setLblcosmoexkmratedaily(String lblcosmoexkmratedaily) {
		this.lblcosmoexkmratedaily = lblcosmoexkmratedaily;
	}
	public String getLblcosmoexkmrateweekly() {
		return lblcosmoexkmrateweekly;
	}
	public void setLblcosmoexkmrateweekly(String lblcosmoexkmrateweekly) {
		this.lblcosmoexkmrateweekly = lblcosmoexkmrateweekly;
	}
	public String getLblcosmoexkmratemonthly() {
		return lblcosmoexkmratemonthly;
	}
	public void setLblcosmoexkmratemonthly(String lblcosmoexkmratemonthly) {
		this.lblcosmoexkmratemonthly = lblcosmoexkmratemonthly;
	}
	public String getLblcosmodrivername() {
		return lblcosmodrivername;
	}
	public void setLblcosmodrivername(String lblcosmodrivername) {
		this.lblcosmodrivername = lblcosmodrivername;
	}
	public String getLblcosmodriverlicense() {
		return lblcosmodriverlicense;
	}
	public void setLblcosmodriverlicense(String lblcosmodriverlicense) {
		this.lblcosmodriverlicense = lblcosmodriverlicense;
	}
	public String getLblcosmodrivervalidupto() {
		return lblcosmodrivervalidupto;
	}
	public void setLblcosmodrivervalidupto(String lblcosmodrivervalidupto) {
		this.lblcosmodrivervalidupto = lblcosmodrivervalidupto;
	}
	public String getLblcosmodrivermobile() {
		return lblcosmodrivermobile;
	}
	public void setLblcosmodrivermobile(String lblcosmodrivermobile) {
		this.lblcosmodrivermobile = lblcosmodrivermobile;
	}
	public String getLblcosmodriverpassport() {
		return lblcosmodriverpassport;
	}
	public void setLblcosmodriverpassport(String lblcosmodriverpassport) {
		this.lblcosmodriverpassport = lblcosmodriverpassport;
	}
	public String getLblcosmocooler() {
		return lblcosmocooler;
	}
	public void setLblcosmocooler(String lblcosmocooler) {
		this.lblcosmocooler = lblcosmocooler;
	}
	public String getKmclient() {
		return kmclient;
	}
	public void setKmclient(String kmclient) {
		this.kmclient = kmclient;
	}
	public String getKmdriver() {
		return kmdriver;
	}
	public void setKmdriver(String kmdriver) {
		this.kmdriver = kmdriver;
	}
	public String getKmvehicle() {
		return kmvehicle;
	}
	public void setKmvehicle(String kmvehicle) {
		this.kmvehicle = kmvehicle;
	}
	public String getKmagmtno() {
		return kmagmtno;
	}
	public void setKmagmtno(String kmagmtno) {
		this.kmagmtno = kmagmtno;
	}
	public String getKmmrano() {
		return kmmrano;
	}
	public void setKmmrano(String kmmrano) {
		this.kmmrano = kmmrano;
	}
	public String getKmdate() {
		return kmdate;
	}
	public void setKmdate(String kmdate) {
		this.kmdate = kmdate;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getLbltotalallowedkm() {
		return lbltotalallowedkm;
	}
	public void setLbltotalallowedkm(String lbltotalallowedkm) {
		this.lbltotalallowedkm = lbltotalallowedkm;
	}
	public String getLblrateperkm() {
		return lblrateperkm;
	}
	public void setLblrateperkm(String lblrateperkm) {
		this.lblrateperkm = lblrateperkm;
	}
	public String getLbltotalusedkm() {
		return lbltotalusedkm;
	}
	public void setLbltotalusedkm(String lbltotalusedkm) {
		this.lbltotalusedkm = lbltotalusedkm;
	}
	public String getLbltotalexcesskmrate() {
		return lbltotalexcesskmrate;
	}
	public void setLbltotalexcesskmrate(String lbltotalexcesskmrate) {
		this.lbltotalexcesskmrate = lbltotalexcesskmrate;
	}
	public String getLbltotalexcesskm() {
		return lbltotalexcesskm;
	}
	public void setLbltotalexcesskm(String lbltotalexcesskm) {
		this.lbltotalexcesskm = lbltotalexcesskm;
	}
	public String getLbltotalexcesskmratewords() {
		return lbltotalexcesskmratewords;
	}
	public void setLbltotalexcesskmratewords(String lbltotalexcesskmratewords) {
		this.lbltotalexcesskmratewords = lbltotalexcesskmratewords;
	}
	public String getLblclstatus() {
		return lblclstatus;
	}
	public void setLblclstatus(String lblclstatus) {
		this.lblclstatus = lblclstatus;
	}
	public String getLblindigobranchtel() {
		return lblindigobranchtel;
	}
	public void setLblindigobranchtel(String lblindigobranchtel) {
		this.lblindigobranchtel = lblindigobranchtel;
	}
	public String getLblindigobranchmobile() {
		return lblindigobranchmobile;
	}
	public void setLblindigobranchmobile(String lblindigobranchmobile) {
		this.lblindigobranchmobile = lblindigobranchmobile;
	}
	public String getLblindigocldocno() {
		return lblindigocldocno;
	}
	public void setLblindigocldocno(String lblindigocldocno) {
		this.lblindigocldocno = lblindigocldocno;
	}
	public String getLblindigonationality() {
		return lblindigonationality;
	}
	public void setLblindigonationality(String lblindigonationality) {
		this.lblindigonationality = lblindigonationality;
	}
	public String getLblindigodiscount() {
		return lblindigodiscount;
	}
	public void setLblindigodiscount(String lblindigodiscount) {
		this.lblindigodiscount = lblindigodiscount;
	}
	public String getLblindigonettotal() {
		return lblindigonettotal;
	}
	public void setLblindigonettotal(String lblindigonettotal) {
		this.lblindigonettotal = lblindigonettotal;
	}
	public String getLblindigorate() {
		return lblindigorate;
	}
	public void setLblindigorate(String lblindigorate) {
		this.lblindigorate = lblindigorate;
	}
	public String getLblindigorentalagent() {
		return lblindigorentalagent;
	}
	public void setLblindigorentalagent(String lblindigorentalagent) {
		this.lblindigorentalagent = lblindigorentalagent;
	}
	public String getLblindigorenttype() {
		return lblindigorenttype;
	}
	public void setLblindigorenttype(String lblindigorenttype) {
		this.lblindigorenttype = lblindigorenttype;
	}
	public String getLblindigoaddmobile() {
		return lblindigoaddmobile;
	}
	public void setLblindigoaddmobile(String lblindigoaddmobile) {
		this.lblindigoaddmobile = lblindigoaddmobile;
	}
	public String getLblindigoaddnationality() {
		return lblindigoaddnationality;
	}
	public void setLblindigoaddnationality(String lblindigoaddnationality) {
		this.lblindigoaddnationality = lblindigoaddnationality;
	}
	public String getDrivermobno() {
		return drivermobno;
	}
	public void setDrivermobno(String drivermobno) {
		this.drivermobno = drivermobno;
	}
	public String getDrivercountry() {
		return drivercountry;
	}
	public void setDrivercountry(String drivercountry) {
		this.drivercountry = drivercountry;
	}
	public String getVehiclechasisno() {
		return vehiclechasisno;
	}
	public void setVehiclechasisno(String vehiclechasisno) {
		this.vehiclechasisno = vehiclechasisno;
	}
	public String getRentaldetcdw() {
		return rentaldetcdw;
	}
	public void setRentaldetcdw(String rentaldetcdw) {
		this.rentaldetcdw = rentaldetcdw;
	}
	public String getRdsecuritydeposit() {
		return rdsecuritydeposit;
	}
	public void setRdsecuritydeposit(String rdsecuritydeposit) {
		this.rdsecuritydeposit = rdsecuritydeposit;
	}


	private String lblcosmofuelchg;
	private String lblcosmototal;
	private String lblcosmoadvance;
	private String lblcosmokmrestrictdaily;
	private String lblcosmokmrestrictweekly;
	private String lblcosmokmrestrictmonthly;
	private String lblcosmoexkmratedaily;
	private String lblcosmoexkmrateweekly;
	private String lblcosmoexkmratemonthly;
	private String lblcosmodrivername;
	private String lblcosmodriverlicense;
	private String lblcosmodrivervalidupto;
	private String lblcosmodrivermobile;
	private String lblcosmodriverpassport;
	private String lblcosmocooler;
	private String kmclient;
	private String kmdriver;
	private String kmvehicle;
	private String kmagmtno;
	private String kmmrano;
	private String kmdate;
	private String lbllocation;
	private String lbltotalallowedkm;
	private String lblrateperkm;
	private String lbltotalusedkm;
	private String lbltotalexcesskmrate;
	private String lbltotalexcesskm;
	private String lbltotalexcesskmratewords;
	private String lblclstatus;
	private String lblindigobranchtel;
	private String lblindigobranchmobile;
	private String lblindigocldocno;
	private String lblindigonationality;
	private String lblindigodiscount;
	private String lblindigonettotal;
	private String lblindigorate;
	private String lblindigorentalagent;
	private String lblindigorenttype;
	private String lblindigoaddmobile;
	private String lblindigoaddnationality;
	private String drivermobno;
	private String drivercountry;
	private String vehiclechasisno;
	private String rentaldetcdw;
	private String rdsecuritydeposit;
	public String claddress2;

	public String clsiclpo,clcreditcard,cladvance,cldesc;
	public String gpsprint,babyseaterprint;
	
	
	
	
	public Map<String, Object> getPar() {
		return par;
	}
	public void setPar(Map<String, Object> par) {
		this.par = par;
	}
	public String getVehauth() {
		return vehauth;
	}
	public void setVehauth(String vehauth) {
		this.vehauth = vehauth;
	}
	public String getRentalproject() {
		return rentalproject;
	}
	public void setRentalproject(String rentalproject) {
		this.rentalproject = rentalproject;
	}
	public String getHidrentalproject() {
		return hidrentalproject;
	}
	public void setHidrentalproject(String hidrentalproject) {
		this.hidrentalproject = hidrentalproject;
	}
	public String getLbldesc() {
		return lbldesc;
	}
	public void setLbldesc(String lbldesc) {
		this.lbldesc = lbldesc;
	}
	public String getLblauthority() {
		return lblauthority;
	}
	public void setLblauthority(String lblauthority) {
		this.lblauthority = lblauthority;
	}
	public String getRamobile() {
		return ramobile;
	}
	public void setRamobile(String ramobile) {
		this.ramobile = ramobile;
	}
	public double getTotaltot() {
		return totaltot;
	}
	public void setTotaltot(double totaltot) {
		this.totaltot = totaltot;
	}
	public double getRentaltotals() {
		return rentaltotals;
	}
	public void setRentaltotals(double rentaltotals) {
		this.rentaltotals = rentaltotals;
	}
	public String getLbldeldate() {
		return lbldeldate;
	}
	public void setLbldeldate(String lbldeldate) {
		this.lbldeldate = lbldeldate;
	}
	public String getLbldeltime() {
		return lbldeltime;
	}
	public void setLbldeltime(String lbldeltime) {
		this.lbldeltime = lbldeltime;
	}
	public String getLbldelkm() {
		return lbldelkm;
	}
	public void setLbldelkm(String lbldelkm) {
		this.lbldelkm = lbldelkm;
	}
	public String getLbldelfuel() {
		return lbldelfuel;
	}
	public void setLbldelfuel(String lbldelfuel) {
		this.lbldelfuel = lbldelfuel;
	}
	public String getLblcollectdate() {
		return lblcollectdate;
	}
	public void setLblcollectdate(String lblcollectdate) {
		this.lblcollectdate = lblcollectdate;
	}
	public String getLblcollecttime() {
		return lblcollecttime;
	}
	public void setLblcollecttime(String lblcollecttime) {
		this.lblcollecttime = lblcollecttime;
	}
	public String getLblcollectkm() {
		return lblcollectkm;
	}
	public void setLblcollectkm(String lblcollectkm) {
		this.lblcollectkm = lblcollectkm;
	}
	public String getLblcollectfuel() {
		return lblcollectfuel;
	}
	public void setLblcollectfuel(String lblcollectfuel) {
		this.lblcollectfuel = lblcollectfuel;
	}
	public String getLblpassissdate() {
		return lblpassissdate;
	}
	public void setLblpassissdate(String lblpassissdate) {
		this.lblpassissdate = lblpassissdate;
	}
	public String getLblvisaexp() {
		return lblvisaexp;
	}
	public void setLblvisaexp(String lblvisaexp) {
		this.lblvisaexp = lblvisaexp;
	}
	public String getLblvisaissdate() {
		return lblvisaissdate;
	}
	public void setLblvisaissdate(String lblvisaissdate) {
		this.lblvisaissdate = lblvisaissdate;
	}
	public String getLblclientrn() {
		return lblclientrn;
	}
	public void setLblclientrn(String lblclientrn) {
		this.lblclientrn = lblclientrn;
	}
	public String getRayear() {
		return rayear;
	}
	public void setRayear(String rayear) {
		this.rayear = rayear;
	}
	public String getInspdoc() {
		return inspdoc;
	}
	public void setInspdoc(String inspdoc) {
		this.inspdoc = inspdoc;
	}
	public String getSal_docno() {
		return sal_docno;
	}
	public void setSal_docno(String sal_docno) {
		this.sal_docno = sal_docno;
	}
	public String getSal_id() {
		return sal_id;
	}
	public void setSal_id(String sal_id) {
		this.sal_id = sal_id;
	}
	public String getSal_name() {
		return sal_name;
	}
	public void setSal_name(String sal_name) {
		this.sal_name = sal_name;
	}
	public String getCardtype() {
		return cardtype;
	}
	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	public String getAcode() {
		return acode;
	}
	public void setAcode(String acode) {
		this.acode = acode;
	}
	public String getCardno() {
		return cardno;
	}
	public void setCardno(String cardno) {
		this.cardno = cardno;
	}
	public String getExdate() {
		return exdate;
	}
	public void setExdate(String exdate) {
		this.exdate = exdate;
	}
	public String getRecieptno() {
		return recieptno;
	}
	public void setRecieptno(String recieptno) {
		this.recieptno = recieptno;
	}
	public String getDelcharges() {
		return delcharges;
	}
	public void setDelcharges(String delcharges) {
		this.delcharges = delcharges;
	}
	public String getRasupercdw() {
		return rasupercdw;
	}
	public void setRasupercdw(String rasupercdw) {
		this.rasupercdw = rasupercdw;
	}
	public String getRavmd() {
		return ravmd;
	}
	public void setRavmd(String ravmd) {
		this.ravmd = ravmd;
	}
	public int getDelchkvalue() {
		return delchkvalue;
	}
	public void setDelchkvalue(int delchkvalue) {
		this.delchkvalue = delchkvalue;
	}
	public int getAdvance_chkval() {
		return advance_chkval;
	}
	public void setAdvance_chkval(int advance_chkval) {
		this.advance_chkval = advance_chkval;
	}
	public int getAdvance_chk() {
		return advance_chk;
	}
	public void setAdvance_chk(int advance_chk) {
		this.advance_chk = advance_chk;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getCh_no() {
		return ch_no;
	}
	public void setCh_no(String ch_no) {
		this.ch_no = ch_no;
	}
	public String getRavehplate() {
		return ravehplate;
	}
	public void setRavehplate(String ravehplate) {
		this.ravehplate = ravehplate;
	}
	public String getLblnofdays() {
		return lblnofdays;
	}
	public void setLblnofdays(String lblnofdays) {
		this.lblnofdays = lblnofdays;
	}
	public String getLbltraficfine() {
		return lbltraficfine;
	}
	public void setLbltraficfine(String lbltraficfine) {
		this.lbltraficfine = lbltraficfine;
	}
	public String getLblsalik() {
		return lblsalik;
	}
	public void setLblsalik(String lblsalik) {
		this.lblsalik = lblsalik;
	}
	public String getLblrentaldesc() {
		return lblrentaldesc;
	}
	public void setLblrentaldesc(String lblrentaldesc) {
		this.lblrentaldesc = lblrentaldesc;
	}
	public String getLblrentaltype() {
		return lblrentaltype;
	}
	public void setLblrentaltype(String lblrentaltype) {
		this.lblrentaltype = lblrentaltype;
	}
	public String getLblrentalrate() {
		return lblrentalrate;
	}
	public void setLblrentalrate(String lblrentalrate) {
		this.lblrentalrate = lblrentalrate;
	}
	public String getLblcldocno() {
		return lblcldocno;
	}
	public void setLblcldocno(String lblcldocno) {
		this.lblcldocno = lblcldocno;
	}
	public String getLbluser() {
		return lbluser;
	}
	public void setLbluser(String lbluser) {
		this.lbluser = lbluser;
	}
	public String getRavehauthregno() {
		return ravehauthregno;
	}
	public void setRavehauthregno(String ravehauthregno) {
		this.ravehauthregno = ravehauthregno;
	}
	public int getWeekendval() {
		return weekendval;
	}
	public void setWeekendval(int weekendval) {
		this.weekendval = weekendval;
	}
	public int getWeekend() {
		return weekend;
	}
	public void setWeekend(int weekend) {
		this.weekend = weekend;
	}
	public String getLblnation() {
		return lblnation;
	}
	public void setLblnation(String lblnation) {
		this.lblnation = lblnation;
	}
	public String getLblissfromdate() {
		return lblissfromdate;
	}
	public void setLblissfromdate(String lblissfromdate) {
		this.lblissfromdate = lblissfromdate;
	}
	public String getLblissby() {
		return lblissby;
	}
	public void setLblissby(String lblissby) {
		this.lblissby = lblissby;
	}
	public String getLblidno() {
		return lblidno;
	}
	public void setLblidno(String lblidno) {
		this.lblidno = lblidno;
	}
	public String getLblpassissued() {
		return lblpassissued;
	}
	public void setLblpassissued(String lblpassissued) {
		this.lblpassissued = lblpassissued;
	}
	public String getLbladdpassno1() {
		return lbladdpassno1;
	}
	public void setLbladdpassno1(String lbladdpassno1) {
		this.lbladdpassno1 = lbladdpassno1;
	}
	public String getLbladdpassexp1() {
		return lbladdpassexp1;
	}
	public void setLbladdpassexp1(String lbladdpassexp1) {
		this.lbladdpassexp1 = lbladdpassexp1;
	}
	public String getLbladdnation1() {
		return lbladdnation1;
	}
	public void setLbladdnation1(String lbladdnation1) {
		this.lbladdnation1 = lbladdnation1;
	}
	public String getLbladdissby1() {
		return lbladdissby1;
	}
	public void setLbladdissby1(String lbladdissby1) {
		this.lbladdissby1 = lbladdissby1;
	}
	public String getLbladdissfrom1() {
		return lbladdissfrom1;
	}
	public void setLbladdissfrom1(String lbladdissfrom1) {
		this.lbladdissfrom1 = lbladdissfrom1;
	}
	public String getLbladdid1() {
		return lbladdid1;
	}
	public void setLbladdid1(String lbladdid1) {
		this.lbladdid1 = lbladdid1;
	}
	public String getLbladdpassissued1() {
		return lbladdpassissued1;
	}
	public void setLbladdpassissued1(String lbladdpassissued1) {
		this.lbladdpassissued1 = lbladdpassissued1;
	}
	public String getLblcompwebsite() {
		return lblcompwebsite;
	}
	public void setLblcompwebsite(String lblcompwebsite) {
		this.lblcompwebsite = lblcompwebsite;
	}
	public String getLblcompmail() {
		return lblcompmail;
	}
	public void setLblcompmail(String lblcompmail) {
		this.lblcompmail = lblcompmail;
	}
	public String getLbltel1() {
		return lbltel1;
	}
	public void setLbltel1(String lbltel1) {
		this.lbltel1 = lbltel1;
	}
	public String getLbltel2() {
		return lbltel2;
	}
	public void setLbltel2(String lbltel2) {
		this.lbltel2 = lbltel2;
	}
	public String getDuedate() {
		return duedate;
	}
	public void setDuedate(String duedate) {
		this.duedate = duedate;
	}
	public String getSalagent() {
		return salagent;
	}
	public void setSalagent(String salagent) {
		this.salagent = salagent;
	}
	public String getRaagent() {
		return raagent;
	}
	public void setRaagent(String raagent) {
		this.raagent = raagent;
	}
	public String getSalname() {
		return salname;
	}
	public void setSalname(String salname) {
		this.salname = salname;
	}
	public String getDuetime() {
		return duetime;
	}
	public void setDuetime(String duetime) {
		this.duetime = duetime;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getJqxRentalDate() {
		return jqxRentalDate;
	}
	public void setJqxRentalDate(String jqxRentalDate) {
		this.jqxRentalDate = jqxRentalDate;
	}
	public String getHidjqxRentalDate() {
		return hidjqxRentalDate;
	}
	public void setHidjqxRentalDate(String hidjqxRentalDate) {
		this.hidjqxRentalDate = hidjqxRentalDate;
	}
	public String getTxtfleetno() {
		return txtfleetno;
	}
	public void setTxtfleetno(String txtfleetno) {
		this.txtfleetno = txtfleetno;
	}
	public String getVehlocation() {
		return vehlocation;
	}
	public void setVehlocation(String vehlocation) {
		this.vehlocation = vehlocation;
	}
	public String getTxtcusid() {
		return txtcusid;
	}
	public void setTxtcusid(String txtcusid) {
		this.txtcusid = txtcusid;
	}
	public int getRe_salmanid() {
		return re_salmanid;
	}
	public void setRe_salmanid(int re_salmanid) {
		this.re_salmanid = re_salmanid;
	}
	public String getRe_clcodeno() {
		return re_clcodeno;
	}
	public void setRe_clcodeno(String re_clcodeno) {
		this.re_clcodeno = re_clcodeno;
	}
	public String getRe_clacno() {
		return re_clacno;
	}
	public void setRe_clacno(String re_clacno) {
		this.re_clacno = re_clacno;
	}
	public String getRentaldesc() {
		return rentaldesc;
	}
	public void setRentaldesc(String rentaldesc) {
		this.rentaldesc = rentaldesc;
	}
	public int getAdditional_driver() {
		return additional_driver;
	}
	public void setAdditional_driver(int additional_driver) {
		this.additional_driver = additional_driver;
	}
	public String getAdidrvcharges() {
		return adidrvcharges;
	}
	public void setAdidrvcharges(String adidrvcharges) {
		this.adidrvcharges = adidrvcharges;
	}
	public int getDelivery_chk() {
		return delivery_chk;
	}
	public void setDelivery_chk(int delivery_chk) {
		this.delivery_chk = delivery_chk;
	}
	public int getRadrivercheck() {
		return radrivercheck;
	}
	public void setRadrivercheck(int radrivercheck) {
		this.radrivercheck = radrivercheck;
	}
	public int getDel_chaufferid() {
		return del_chaufferid;
	}
	public void setDel_chaufferid(int del_chaufferid) {
		this.del_chaufferid = del_chaufferid;
	}
	public String getClient_driverid() {
		return client_driverid;
	}
	public void setClient_driverid(String client_driverid) {
		this.client_driverid = client_driverid;
	}
	public String getRatariffsystem() {
		return ratariffsystem;
	}
	public void setRatariffsystem(String ratariffsystem) {
		this.ratariffsystem = ratariffsystem;
	}
	public String getRatariffdocno1() {
		return ratariffdocno1;
	}
	public void setRatariffdocno1(String ratariffdocno1) {
		this.ratariffdocno1 = ratariffdocno1;
	}
	public String getInvoice() {
		return invoice;
	}
	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}
	public String getExcessinsur() {
		return excessinsur;
	}
	public void setExcessinsur(String excessinsur) {
		this.excessinsur = excessinsur;
	}
	public String getVeh_fleetgrouptariff() {
		return veh_fleetgrouptariff;
	}
	public void setVeh_fleetgrouptariff(String veh_fleetgrouptariff) {
		this.veh_fleetgrouptariff = veh_fleetgrouptariff;
	}
	public String getRe_Km() {
		return re_Km;
	}
	public void setRe_Km(String re_Km) {
		this.re_Km = re_Km;
	}
	public String getRatariff_fuel() {
		return ratariff_fuel;
	}
	public void setRatariff_fuel(String ratariff_fuel) {
		this.ratariff_fuel = ratariff_fuel;
	}
	public int getTariffsales_Agentid() {
		return tariffsales_Agentid;
	}
	public void setTariffsales_Agentid(int tariffsales_Agentid) {
		this.tariffsales_Agentid = tariffsales_Agentid;
	}
	public int getTariffrenral_Agentid() {
		return tariffrenral_Agentid;
	}
	public void setTariffrenral_Agentid(int tariffrenral_Agentid) {
		this.tariffrenral_Agentid = tariffrenral_Agentid;
	}
	public String getJqxDateOut() {
		return jqxDateOut;
	}
	public void setJqxDateOut(String jqxDateOut) {
		this.jqxDateOut = jqxDateOut;
	}
	public String getHidjqxDateOut() {
		return hidjqxDateOut;
	}
	public void setHidjqxDateOut(String hidjqxDateOut) {
		this.hidjqxDateOut = hidjqxDateOut;
	}
	public String getJqxTimeOut() {
		return jqxTimeOut;
	}
	public void setJqxTimeOut(String jqxTimeOut) {
		this.jqxTimeOut = jqxTimeOut;
	}
	public String getHidjqxTimeOut() {
		return hidjqxTimeOut;
	}
	public void setHidjqxTimeOut(String hidjqxTimeOut) {
		this.hidjqxTimeOut = hidjqxTimeOut;
	}
	
	private String brwithcompany,vrano,mtime,pfleetno,pfuel,popened,pclient,clientacno,agmt,pdocno,pdate,pregno,vradate,dtimes,replaced,reptype,pkm,poutdate,pdelivery;

	//------------------------------------------------------------------------------------
		
		
		//---------------------------------------------------------------------
		private String inbrwithcompany,invehdate,invehtime,invehkm,invehfuel,invehreason;
		
		private String newbrwithcompany,newvehoutdate,newvehouttime,newvehfleet,newvehregno,newvehkm,newvehfuel;
		
		
		
		private String delbrwithcompany,deldate,deltime,delfleet,delregno,delkm,delfuel;
		
		
		private String colbrwithcompany,coldate,coltime,colfleet,colregno,colkm,colfuel;
		
		private String lbldelivery,lblcollection,lblrlocation;
		private String lblinfleetname,lbloutfleetname,lbldelfleetname,lblcolfleetname;
		private String lblinlocation,lbloutlocation,lbldeldriver,lblcoldriver,lbldescription,lbldrivenby;
		
		private String internaldelkm,internalcollectkm;
		private String lblinimg,sigpath;
		private String lbloutimg;

		
		private String repcompanyname,repaddress,repmobileno,repfax,replocation,repbarnchval;
	
	
	public String getBrwithcompany() {
			return brwithcompany;
		}
		public void setBrwithcompany(String brwithcompany) {
			this.brwithcompany = brwithcompany;
		}
		public String getVrano() {
			return vrano;
		}
		public void setVrano(String vrano) {
			this.vrano = vrano;
		}
		public String getMtime() {
			return mtime;
		}
		public void setMtime(String mtime) {
			this.mtime = mtime;
		}
		public String getPfleetno() {
			return pfleetno;
		}
		public void setPfleetno(String pfleetno) {
			this.pfleetno = pfleetno;
		}
		public String getPfuel() {
			return pfuel;
		}
		public void setPfuel(String pfuel) {
			this.pfuel = pfuel;
		}
		public String getPopened() {
			return popened;
		}
		public void setPopened(String popened) {
			this.popened = popened;
		}
		public String getPclient() {
			return pclient;
		}
		public void setPclient(String pclient) {
			this.pclient = pclient;
		}
		public String getClientacno() {
			return clientacno;
		}
		public void setClientacno(String clientacno) {
			this.clientacno = clientacno;
		}
		public String getAgmt() {
			return agmt;
		}
		public void setAgmt(String agmt) {
			this.agmt = agmt;
		}
		public String getPdocno() {
			return pdocno;
		}
		public void setPdocno(String pdocno) {
			this.pdocno = pdocno;
		}
		public String getPdate() {
			return pdate;
		}
		public void setPdate(String pdate) {
			this.pdate = pdate;
		}
		public String getPregno() {
			return pregno;
		}
		public void setPregno(String pregno) {
			this.pregno = pregno;
		}
		public String getVradate() {
			return vradate;
		}
		public void setVradate(String vradate) {
			this.vradate = vradate;
		}
		public String getDtimes() {
			return dtimes;
		}
		public void setDtimes(String dtimes) {
			this.dtimes = dtimes;
		}
		public String getReplaced() {
			return replaced;
		}
		public void setReplaced(String replaced) {
			this.replaced = replaced;
		}
		public String getReptype() {
			return reptype;
		}
		public void setReptype(String reptype) {
			this.reptype = reptype;
		}
		public String getPkm() {
			return pkm;
		}
		public void setPkm(String pkm) {
			this.pkm = pkm;
		}
		public String getPoutdate() {
			return poutdate;
		}
		public void setPoutdate(String poutdate) {
			this.poutdate = poutdate;
		}
		public String getPdelivery() {
			return pdelivery;
		}
		public void setPdelivery(String pdelivery) {
			this.pdelivery = pdelivery;
		}
		public String getInbrwithcompany() {
			return inbrwithcompany;
		}
		public void setInbrwithcompany(String inbrwithcompany) {
			this.inbrwithcompany = inbrwithcompany;
		}
		public String getInvehdate() {
			return invehdate;
		}
		public void setInvehdate(String invehdate) {
			this.invehdate = invehdate;
		}
		public String getInvehtime() {
			return invehtime;
		}
		public void setInvehtime(String invehtime) {
			this.invehtime = invehtime;
		}
		public String getInvehkm() {
			return invehkm;
		}
		public void setInvehkm(String invehkm) {
			this.invehkm = invehkm;
		}
		public String getInvehfuel() {
			return invehfuel;
		}
		public void setInvehfuel(String invehfuel) {
			this.invehfuel = invehfuel;
		}
		public String getInvehreason() {
			return invehreason;
		}
		public void setInvehreason(String invehreason) {
			this.invehreason = invehreason;
		}
		public String getNewbrwithcompany() {
			return newbrwithcompany;
		}
		public void setNewbrwithcompany(String newbrwithcompany) {
			this.newbrwithcompany = newbrwithcompany;
		}
		public String getNewvehoutdate() {
			return newvehoutdate;
		}
		public void setNewvehoutdate(String newvehoutdate) {
			this.newvehoutdate = newvehoutdate;
		}
		public String getNewvehouttime() {
			return newvehouttime;
		}
		public void setNewvehouttime(String newvehouttime) {
			this.newvehouttime = newvehouttime;
		}
		public String getNewvehfleet() {
			return newvehfleet;
		}
		public void setNewvehfleet(String newvehfleet) {
			this.newvehfleet = newvehfleet;
		}
		public String getNewvehregno() {
			return newvehregno;
		}
		public void setNewvehregno(String newvehregno) {
			this.newvehregno = newvehregno;
		}
		public String getNewvehkm() {
			return newvehkm;
		}
		public void setNewvehkm(String newvehkm) {
			this.newvehkm = newvehkm;
		}
		public String getNewvehfuel() {
			return newvehfuel;
		}
		public void setNewvehfuel(String newvehfuel) {
			this.newvehfuel = newvehfuel;
		}
		public String getDelbrwithcompany() {
			return delbrwithcompany;
		}
		public void setDelbrwithcompany(String delbrwithcompany) {
			this.delbrwithcompany = delbrwithcompany;
		}
		public String getDeldate() {
			return deldate;
		}
		public void setDeldate(String deldate) {
			this.deldate = deldate;
		}
		public String getDeltime() {
			return deltime;
		}
		public void setDeltime(String deltime) {
			this.deltime = deltime;
		}
		public String getDelfleet() {
			return delfleet;
		}
		public void setDelfleet(String delfleet) {
			this.delfleet = delfleet;
		}
		public String getDelregno() {
			return delregno;
		}
		public void setDelregno(String delregno) {
			this.delregno = delregno;
		}
		public String getDelkm() {
			return delkm;
		}
		public void setDelkm(String delkm) {
			this.delkm = delkm;
		}
		public String getDelfuel() {
			return delfuel;
		}
		public void setDelfuel(String delfuel) {
			this.delfuel = delfuel;
		}
		public String getColbrwithcompany() {
			return colbrwithcompany;
		}
		public void setColbrwithcompany(String colbrwithcompany) {
			this.colbrwithcompany = colbrwithcompany;
		}
		public String getColdate() {
			return coldate;
		}
		public void setColdate(String coldate) {
			this.coldate = coldate;
		}
		public String getColtime() {
			return coltime;
		}
		public void setColtime(String coltime) {
			this.coltime = coltime;
		}
		public String getColfleet() {
			return colfleet;
		}
		public void setColfleet(String colfleet) {
			this.colfleet = colfleet;
		}
		public String getColregno() {
			return colregno;
		}
		public void setColregno(String colregno) {
			this.colregno = colregno;
		}
		public String getColkm() {
			return colkm;
		}
		public void setColkm(String colkm) {
			this.colkm = colkm;
		}
		public String getColfuel() {
			return colfuel;
		}
		public void setColfuel(String colfuel) {
			this.colfuel = colfuel;
		}
		public String getLbldelivery() {
			return lbldelivery;
		}
		public void setLbldelivery(String lbldelivery) {
			this.lbldelivery = lbldelivery;
		}
		public String getLblcollection() {
			return lblcollection;
		}
		public void setLblcollection(String lblcollection) {
			this.lblcollection = lblcollection;
		}
		public String getLblrlocation() {
			return lblrlocation;
		}
		public void setLblrlocation(String lblrlocation) {
			this.lblrlocation = lblrlocation;
		}
		public String getLblinfleetname() {
			return lblinfleetname;
		}
		public void setLblinfleetname(String lblinfleetname) {
			this.lblinfleetname = lblinfleetname;
		}
		public String getLbloutfleetname() {
			return lbloutfleetname;
		}
		public void setLbloutfleetname(String lbloutfleetname) {
			this.lbloutfleetname = lbloutfleetname;
		}
		public String getLbldelfleetname() {
			return lbldelfleetname;
		}
		public void setLbldelfleetname(String lbldelfleetname) {
			this.lbldelfleetname = lbldelfleetname;
		}
		public String getLblcolfleetname() {
			return lblcolfleetname;
		}
		public void setLblcolfleetname(String lblcolfleetname) {
			this.lblcolfleetname = lblcolfleetname;
		}
		public String getLblinlocation() {
			return lblinlocation;
		}
		public void setLblinlocation(String lblinlocation) {
			this.lblinlocation = lblinlocation;
		}
		public String getLbloutlocation() {
			return lbloutlocation;
		}
		public void setLbloutlocation(String lbloutlocation) {
			this.lbloutlocation = lbloutlocation;
		}
		public String getLbldeldriver() {
			return lbldeldriver;
		}
		public void setLbldeldriver(String lbldeldriver) {
			this.lbldeldriver = lbldeldriver;
		}
		public String getLblcoldriver() {
			return lblcoldriver;
		}
		public void setLblcoldriver(String lblcoldriver) {
			this.lblcoldriver = lblcoldriver;
		}
		public String getLbldescription() {
			return lbldescription;
		}
		public void setLbldescription(String lbldescription) {
			this.lbldescription = lbldescription;
		}
		public String getLbldrivenby() {
			return lbldrivenby;
		}
		public void setLbldrivenby(String lbldrivenby) {
			this.lbldrivenby = lbldrivenby;
		}
		public String getInternaldelkm() {
			return internaldelkm;
		}
		public void setInternaldelkm(String internaldelkm) {
			this.internaldelkm = internaldelkm;
		}
		public String getInternalcollectkm() {
			return internalcollectkm;
		}
		public void setInternalcollectkm(String internalcollectkm) {
			this.internalcollectkm = internalcollectkm;
		}
		public String getLblinimg() {
			return lblinimg;
		}
		public void setLblinimg(String lblinimg) {
			this.lblinimg = lblinimg;
		}
		public String getSigpath() {
			return sigpath;
		}
		public void setSigpath(String sigpath) {
			this.sigpath = sigpath;
		}
		public String getLbloutimg() {
			return lbloutimg;
		}
		public void setLbloutimg(String lbloutimg) {
			this.lbloutimg = lbloutimg;
		}
		public String getRepcompanyname() {
			return repcompanyname;
		}
		public void setRepcompanyname(String repcompanyname) {
			this.repcompanyname = repcompanyname;
		}
		public String getRepaddress() {
			return repaddress;
		}
		public void setRepaddress(String repaddress) {
			this.repaddress = repaddress;
		}
		public String getRepmobileno() {
			return repmobileno;
		}
		public void setRepmobileno(String repmobileno) {
			this.repmobileno = repmobileno;
		}
		public String getRepfax() {
			return repfax;
		}
		public void setRepfax(String repfax) {
			this.repfax = repfax;
		}
		public String getReplocation() {
			return replocation;
		}
		public void setReplocation(String replocation) {
			this.replocation = replocation;
		}
		public String getRepbarnchval() {
			return repbarnchval;
		}
		public void setRepbarnchval(String repbarnchval) {
			this.repbarnchval = repbarnchval;
		}
	
		public String getLblagmtbrhid() {
			return lblagmtbrhid;
		}
		public void setLblagmtbrhid(String lblagmtbrhid) {
			this.lblagmtbrhid = lblagmtbrhid;
		}
		
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
		Map<String, String[]> requestParams = request.getParameterMap();
		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		java.sql.Date date = null;
		java.sql.Date accdate=null ;
		java.sql.Date collectdate=null;
		
	if((mode.equalsIgnoreCase("A"))||mode.equalsIgnoreCase("D")){
		date = objcommon.changeStringtoSqlDate(getDate());
		if(getAccdate()!=null){
			accdate = objcommon.changeStringtoSqlDate(getAccdate());	
		}
		if(getCollectdate()!=null){
			collectdate = objcommon.changeStringtoSqlDate(getCollectdate());	
		}
		
		
	}
		
		if(mode.equalsIgnoreCase("A")){
//			System.out.println("Insert Mode");
			ArrayList<String> damagearray= new ArrayList<>();
			ArrayList<String> maintenancearray= new ArrayList<>();
			ArrayList<String> existdamagearray= new ArrayList<>();
			for(int i=0;i<getDamagegridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				damagearray.add(temp);
//				System.out.println(damagearray.get(i));
			}
			for(int i=0;i<getMaintenancegridlength();i++){
				String temp=requestParams.get("testmaint"+i)[0];
				maintenancearray.add(temp);
				//System.out.println(damagearray.get(i));
			}
			for(int i=0;i<getExistdamagegridlength();i++){
				String temp=requestParams.get("testexistdamage"+i)[0];
				existdamagearray.add(temp);
				//System.out.println(damagearray.get(i));
			}
//			System.out.println("Inside Action Mode A");
						int val=inspectionDAO.insert(date,getCmbtype(),getCmbreftype(),getRdocno(),accdate,getPrcs(),collectdate,getAccplace()==null?"":getAccplace(),getAccfines()==null?"0":getAccfines(),
								getCmbclaim()==null?"0":getCmbclaim(),getAmount()==null?"0":getAmount(),getFormdetailcode(),getHidaccidents(),getAccremarks(),
										session,getMode(),getRfleet(),damagearray,maintenancearray,existdamagearray,getTime(),getRefvoucherno(),getBrchName(),getCmbagmtbranch());
						if(val>0.0){
//							System.out.println(val);
							setHidcmbagmtbranch(getCmbagmtbranch());
							setHiddate(date.toString());
							setHidcmbtype(getCmbtype());
							setHidcmbreftype(getCmbreftype());
							setRdocno(getRdocno());
							setHidaccidents(getHidaccidents());
							if(getHidaccidents().equalsIgnoreCase("1")){
								setHidaccdate(accdate.toString());
								setPrcs(getPrcs());
								setHidcollectdate(collectdate.toString());
								setAccplace(getAccplace());
								setAccfines(getAccfines());
								setHidcmbclaim(getCmbclaim());
								setAmount(getAmount());	
								setAccremarks(getAccremarks());
							}
							
							setRfleet(getRfleet());
							setMode(getMode());
							setHidtime(getTime());
							setDocno(val);
							setRefvoucherno(getRefvoucherno());
							setClient(getClient());
							setRegno(getRegno());
							setMsg("Successfully Saved");

							return "success";
						}
						else{
							setHidcmbagmtbranch(getCmbagmtbranch());
							setHiddate(date.toString());
							setHidcmbtype(getCmbtype());
							setHidcmbreftype(getCmbreftype());
							setRdocno(getRdocno());
							setHidaccidents(getHidaccidents());
							if(getHidaccidents().equalsIgnoreCase("1")){
								setHidaccdate(accdate.toString());
								setPrcs(getPrcs());
								setHidcollectdate(collectdate.toString());
								setAccplace(getAccplace());
								setAccfines(getAccfines());
								setHidcmbclaim(getCmbclaim());
								setAmount(getAmount());	
								setAccremarks(getAccremarks());
							}
							setRfleet(getRfleet());
							setMode(getMode());
							setDocno(val);
							setClient(getClient());
							setRegno(getRegno());
							setMsg("Not Saved");

							return "fail";
						}	
		}
else if(mode.equalsIgnoreCase("View")){
			
	        bean=inspectionDAO.getViewDetails(getDocno());
			setHidcmbagmtbranch(bean.getHidcmbagmtbranch());
			setDate(bean.getDate());
			setHidcmbtype(bean.getHidcmbtype());
			setHidcmbreftype(bean.getHidcmbreftype());
			setRdocno(bean.getRdocno());
			setAccdate(bean.getAccdate());
			setPrcs(bean.getPrcs());
			setCollectdate(bean.getCollectdate());
			setAccplace(bean.getAccplace());
			setAccfines(bean.getAccfines());
			setHidcmbclaim(bean.getHidcmbclaim());
			setAmount(bean.getAmount());
			setHidaccidents(bean.getHidaccidents());
			setAccremarks(bean.getAccremarks());
			setRfleet(bean.getRfleet());
			setClient(bean.getClient());
			setRegno(bean.getRegno());
			return "success";
		}
		else if(mode.equalsIgnoreCase("D")){
//			System.out.println("Delete Mode");
			boolean value=inspectionDAO.delete(date,getCmbtype(),getCmbreftype(),getRdocno(),accdate,getPrcs(),collectdate,getAccplace(),getAccfines(),
					getCmbclaim(),getAmount(),getFormdetailcode(),getHidaccidents(),getAccremarks(),session,getMode(),getRfleet(),getDocno(),getTime());
		if(value){
			setHidcmbagmtbranch(getCmbagmtbranch());
			if(date!=null){
				setHiddate(date.toString());	
			}
			
			setHidcmbtype(getCmbtype());
			setHidcmbreftype(getCmbreftype());
			setRdocno(getRdocno());
			if(accdate!=null){
				setHidaccdate(accdate.toString());	
			}
			
			setPrcs(getPrcs());
			if(collectdate!=null){
				setHidcollectdate(collectdate.toString());	
			}
			
			setAccplace(getAccplace());
			setAccfines(getAccfines());
			setHidcmbclaim(getCmbclaim());
			setAmount(getAmount());
			setHidaccidents(getHidaccidents());
			setAccremarks(getAccremarks());
			setRfleet(getRfleet());
			setMode(getMode());
			setDocno(getDocno());
			setHidtime(getTime());
			setClient(getClient());
							setRegno(getRegno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
			
		}
		else{
			setHidcmbagmtbranch(getCmbagmtbranch());
			setHiddate(date.toString());
			setHidcmbtype(getCmbtype());
			setHidcmbreftype(getCmbreftype());
			setRdocno(getRdocno());
			setHidaccdate(accdate.toString());
			setPrcs(getPrcs());
			setHidcollectdate(collectdate.toString());
			setAccplace(getAccplace());
			setAccfines(getAccfines());
			setHidcmbclaim(getCmbclaim());
			setAmount(getAmount());
			setHidaccidents(getHidaccidents());
			setAccremarks(getAccremarks());
			setRfleet(getRfleet());
			setMode(getMode());
			setDocno(getDocno());
			setClient(getClient());
							setRegno(getRegno());
			setMsg("Not Deleted");
			return "fail";

		}
		}
	
		return "fail";
	}
	  public String saveFile() throws Exception { 
	    	
	    	HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
//			System.out.println(" = =========== "+requestParams);
			//session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
	    	String code=request.getParameter("formdetailcode");
	    	String doc=request.getParameter("doc");
	    	String srno=request.getParameter("srno");
	    	String fname=code+'-'+doc+'-'+srno;
	    	String fname2=fname;
//	    	System.out.println("CODE==="+code);
		//	System.out.println("Code"+getFormdetailcode());
			String dirname =getFormdetailcode()==null?"Default":getFormdetailcode();
//	    	System.out.println(dirname);
	    	String path ="";
	    	Connection conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
//			System.out.println(strSql);
			ResultSet rs = stmt.executeQuery(strSql);
			String path1="";
			while(rs.next ()) {
				path1=rs.getString("imgPath");
//				System.out.println("IMGPATH:"+path);
			}
			path=path1.replace("\\", "/");
	    	ServletContext context = ((HttpSession) request).getServletContext();
	    	//String path = context.getRealPath("/");
	    	
	    	File dir = new File(path+ "/attachment/"+dirname);
	   	 	dir.mkdirs();
	        //
	   	 	
//	        System.out.println("path==============="+path);
	        try {  
	            File f = this.getFile();
//	            System.out.println("File///////////"+getFile());
//	            System.out.println("FILE==="+getFileFileName());
	            if(this.getFileFileName().endsWith(".exe")){  
	                message="not done";  
	                return ERROR;  
	            } 
	          /*  String aa[]=getFileFileName().split(".");
	            System.out.println(aa);*/
	            int dotindex=getFileFileName().lastIndexOf(".");
	            String efile=getFileFileName().substring(dotindex+1);
//	            System.out.println("EEEE"+efile);
	            fname=fname+'.'+efile;
	            FileInputStream inputStream = new FileInputStream(f);  
	            
	            FileOutputStream outputStream = new FileOutputStream(path + "/attachment/"+dirname+ "/"+ fname);
//	            System.out.println("path==============="+path+"========="+outputStream);
	            byte[] buf = new byte[1024];  
	            int length = 0;  
	            while ((length = inputStream.read(buf)) != -1) {  
	                outputStream.write(buf, 0, length);  
	            }  
	            Statement stmtupdate=conn.createStatement();
	            String strupdate="update gl_vinspd set attach='"+fname+"',path='"+path + "/attachment/"+dirname+ "/"+ fname+"' where rdocno="+doc+" and srno="+srno ;
	            int val=stmtupdate.executeUpdate(strupdate);
	            if(val<=0){
	            	return ERROR;
	            }
	            inputStream.close();  
	            outputStream.flush();  
	            this.setMessage(path+fname);
	            stmt.close();
	            stmtupdate.close();
	            conn.close();
	        } catch (Exception e) {  
	            e.printStackTrace();  
	            message = "!!!!";
	            conn.close();
	            
	        }  
	        return SUCCESS;  
	    }
	  
	  
	  public String printAction() throws ParseException, SQLException{
//			System.out.println("Inside print Action");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			String fleetno=request.getParameter("fleetno");
			bean=inspectionDAO.getPrint(getDocno());
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblbranch(bean.getLblbranch());
			setLbldocno(bean.getLbldocno());
			setLbldate(bean.getLbldate());
			setLbltime(bean.getLbltime());
			setLbltype(bean.getLbltype());
			setLblreftype(bean.getLblreftype());
			setLblrefdocno(bean.getLblrefdocno());
			setLblreffleetno(bean.getLblreffleetno());
			setLblaccident(bean.getLblaccident());
			setLblaccdate(bean.getLblaccdate());
			setLblprcs(bean.getLblprcs());
			setLblcoldate(bean.getLblcoldate());
			setLblplace(bean.getLblplace());
			setLblfines(bean.getLblfines());
			setLblclaim(bean.getLblclaim());
			setLblcoldate(bean.getLblcoldate());
			setLblremarks(bean.getLblremarks());
			setLblamount(bean.getLblamount());
			setLblfleetname(bean.getLblfleetname());
			setLblregno(bean.getLblregno());
			setLblprintname("Vehicle Inspection");
			ArrayList<String> existingdamageprint=inspectionDAO.getExistingDamagePrint(getDocno(),fleetno);
			request.setAttribute("EXISTINGDAMAGEPRINT", existingdamageprint);
				if(existingdamageprint.size()>0){
				setLblhidexisting("1");
			}
			else{
				setLblhidexisting("0");
			}
			ArrayList<String> newdamageprint=inspectionDAO.getNewDamagePrint(getDocno(),fleetno);
			request.setAttribute("NEWDAMAGEPRINT", newdamageprint);
			if(newdamageprint.size()>0){
				setLblhidnew("1");
			}
			else{
				setLblhidnew("0");
			}
			ArrayList<String> damagepics=inspectionDAO.getNewDamagePrintPics(getDocno(),fleetno,request.getParameter("lblurl"));
			request.setAttribute("NEWDAMAGEPRINTPICS", damagepics);
			
			ArrayList<String> insppics=inspectionDAO.getInspectionPrintPics(getDocno(), request.getParameter("lblurl"));
			request.setAttribute("NEWINSPPRINTPICS", insppics);
			
			return "print";
		}
	  
	  public String mobilePrintAction() throws ParseException, SQLException{
		  System.out.println("mobileprint=");
		  Connection conn=null;
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response = ServletActionContext.getResponse();
		  int insp=0;
		  
		  try {
		    String front="1",left="1",right="1",back="1",interior="1",chkagmtype="",chkrplno="",chkrplbrhid="";
			String fleetno="";//request.getParameter("fleetno");
			String agmtype=request.getParameter("agmtype");
			String agmtno=request.getParameter("agmtno");
			int inspdoc=Integer.parseInt(request.getParameter("insp").trim().toString());
			int repdoc=Integer.parseInt(request.getParameter("agmtno").trim().toString());
			insp = inspdoc;
			chkrplno=agmtno;
			String remail="",bccemail="",print="1",subject="Vehicle Inspection Sheet";
			String rfleetno="0",ofleetno="0";
			
			bean=inspectionDAO.getPrint(inspdoc);
			
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String strgetfleetno="SELECT rfleet FROM gl_vinspm WHERE doc_no="+agmtno;
			ResultSet rsgetfleeno=stmt.executeQuery(strgetfleetno);
			while(rsgetfleeno.next()) {
				fleetno=rsgetfleeno.getString("rfleet");
			}
			
			System.out.println("=agmtype="+agmtype);
			if(agmtype.equalsIgnoreCase("RPL") || agmtype.equalsIgnoreCase("REP")) {
				chkagmtype=agmtype;
				
				String strSql = "select rtype,rdocno,rfleetno,ofleetno,obrhid from gl_vehreplace where doc_no="+repdoc;
 				System.out.println("===="+strSql);
				ResultSet rs = stmt.executeQuery(strSql);
				String path1="";
				while(rs.next ()) {
					//chkrplno=rs.getString("rdocno");
					chkrplbrhid=rs.getString("obrhid");
					rfleetno=rs.getString("rfleetno");
					ofleetno=rs.getString("ofleetno");
//					System.out.println("IMGPATH:"+path);
				}
				
				rplbean=inspectionDAO.getRepPrint(repdoc,rfleetno,ofleetno);
				
				 setBrwithcompany(rplbean.getBrwithcompany());
				 setVrano(rplbean.getVrano());
				 //setVrano(bean.getVrano());
				 setMtime(rplbean.getMtime());
				 setPfleetno(rplbean.getPfleetno());
				
				 setPfuel(rplbean.getPfuel());
				 setPopened(rplbean.getPopened());
				 setPclient(rplbean.getPclient());
				 setClientacno(rplbean.getClientacno());
				 setBrwithcompany(bean.getBrwithcompany());
				    
				 setAgmt(rplbean.getAgmt());
				 setAgmt(bean.getAgmt());
				 setPdocno(rplbean.getPdocno());
				 setPdate(rplbean.getPdate());
				 setPregno(rplbean.getPregno());
				 setVradate(rplbean.getVradate());
				 setDtimes(rplbean.getDtimes());
				 setReplaced(rplbean.getReplaced());
				 setReptype(rplbean.getReptype());
				 
				 setPkm(rplbean.getPkm());
				 setPoutdate(rplbean.getPoutdate());
				 setPdelivery(rplbean.getPdelivery());
				 setLblrlocation(rplbean.getLblrlocation());
				 setLblrlocation(bean.getLblrlocation());
				 
				 setLblinlocation(rplbean.getLblinlocation());
				 setLbloutlocation(rplbean.getLbloutlocation());
				 
				 
				 //in 
				 
				 setInbrwithcompany(rplbean.getInbrwithcompany());
				  setInvehdate(rplbean.getInvehdate());
				  setInvehtime(rplbean.getInvehtime());
				  setInvehkm(rplbean.getInvehkm());
				   setInvehfuel(rplbean.getInvehfuel());
				   setInvehreason(rplbean.getInvehreason());
				   setLblinfleetname(rplbean.getLblinfleetname());
				   String[] path={"",""};
			      setLblinimg(rplbean.getLblinimg());
			    //  System.out.println("sigpath==before="+rplbean.getSigpath());
			      String imgpath=rplbean.getSigpath();
			      if(!imgpath.equalsIgnoreCase("")) {
			    	  path=imgpath.split("/attachment"); 
			    	 	System.out.println("../../../../attachment"+path[1]);
			    	      setSigpath("../../../../attachment"+path[1]);
			      }
			     
			   //   System.out.println("imgg==="+rplbean.getLblinimg());
				   
				   
				// out 
				   
				   
				   
				   setNewbrwithcompany(rplbean.getNewbrwithcompany());
				   setNewvehoutdate(rplbean.getNewvehoutdate());
				   
				   setNewvehouttime(rplbean.getNewvehouttime());
				   setNewvehfleet(rplbean.getNewvehfleet());
				   setNewvehregno(rplbean.getNewvehregno());
				   
				   setNewvehkm(rplbean.getNewvehkm());
				   setNewvehfuel(rplbean.getNewvehfuel());
				 setLbloutfleetname(rplbean.getLbloutfleetname());
				 setLbloutimg(rplbean.getLbloutimg());
				// System.out.println("outimggg"+rplbean.getLbloutimg());
				 
				   // del
				   
				   setDelbrwithcompany(rplbean.getDelbrwithcompany());
				   setDeldate(rplbean.getDeldate());
				   setDeltime(rplbean.getDeltime());
				   setDelfleet(rplbean.getDelfleet());
				   setDelregno(rplbean.getDelregno());
				  setDelkm(rplbean.getDelkm());
				   setDelfuel(rplbean.getDelfuel());
				   setLbldelivery(rplbean.getLbldelivery());
				   setLbldelfleetname(rplbean.getLbldelfleetname());
				   // col
				   
				   
				   setColbrwithcompany(rplbean.getColbrwithcompany());
				//   System.out.println("comp----"+rplbean.getColbrwithcompany());
				   setColdate(rplbean.getColdate());
				   setColtime(rplbean.getColtime());
				   setColfleet(rplbean.getColfleet());
				   setColregno(rplbean.getColregno());
				   setColkm(rplbean.getColkm());
				   setColfuel(rplbean.getColfuel());
				   setLblcollection(rplbean.getLblcollection());
				   setLblcolfleetname(rplbean.getLblcolfleetname());
				   
				   setLbldeldriver(rplbean.getLbldeldriver());
				   setLblcoldriver(rplbean.getLblcoldriver());
				   
				   setLbldescription(rplbean.getLbldescription());
				   setLbldrivenby(rplbean.getLbldrivenby());
				 // company
				     setRepbarnchval(rplbean.getBarnchval());
				   setRepcompanyname(rplbean.getCompanyname());
				 	  
				   setRepaddress(rplbean.getAddress());
				 
				   setRepmobileno(rplbean.getMobileno());
				  
				   setRepfax(rplbean.getFax());
				   setReplocation(rplbean.getLocation());
			}
			// System.out.println("chkagmtype====="+chkagmtype);
			
			if(agmtype.equalsIgnoreCase("RAG")) {
			rentalbean=inspectionDAO.getRentalPrint(agmtno);
			setLblagmtbrhid(rentalbean.getLblagmtbrhid());
			 setRentaltotals(rentalbean.getRentaltotals());
			  setTotaltot(rentalbean.getTotaltot());
			  setLblauthority(rentalbean.getLblauthority());
			 
			  setVehauth(rentalbean.getVehauth());
			  setLbldesc(rentalbean.getLbldesc());
			  
			   setLblcompmail(rentalbean.getLblcompmail());
			  setLblcompwebsite(rentalbean.getLblcompwebsite());
			  setLbltel1(rentalbean.getLbltel1());
			  setLbltel2(rentalbean.getLbltel2());
			 
			  setLblclientrn(rentalbean.getLblclientrn());
			  //del details
//			  System.out.println("dateaaaa:"+rentalbean.getHidjqxDateOut());
			  
			  //----------cp----------//
			  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			  
			  
			 
			  
			  setLblnofdays(rentalbean.getLblnofdays());
			  setLblrentaldesc(rentalbean.getLblrentaldesc());
			  setLbluser(rentalbean.getLbluser());
			  setRavehauthregno(rentalbean.getRavehauthregno());
			  //----------cp----------//
	  
	    	    
	    	    
	    	  //  salikcharge
	    	    
	    	   setTrafficcharge(rentalbean.getTrafficcharge());
	    	    setTotalsalikandtraffic(rentalbean.getTotalsalikandtraffic());
/*			  setDeldates setDeltimes setDelkmins setDelfuels*/
			  
			  setDeldates(rentalbean.getDeldates());
			  setDeltimes(rentalbean.getDeltimes());
			  setDelkmins(rentalbean.getDelkmins());
			  setDelfuels(rentalbean.getDelfuels());
			  
			  
	    	   setOutdetails(rentalbean.getOutdetails());
	    	  setDeldetailss(rentalbean.getDeldetailss());
			  
			  //col
	
	    	   setColdates(rentalbean.getColdates());
	    	   setColtimes(rentalbean.getColtimes());
	    	   setColkmins(rentalbean.getColkmins());
	    	   setColfuels(rentalbean.getColfuels());
				  
	     	    setIndetails(rentalbean.getIndetails());
			    
		    	 setColdetails(rentalbean.getColdetails());
		    	    
		    	     
	    	   
			  
			  //cl details
			  setClname(rentalbean.getClname());
			  setCladdress(rentalbean.getCladdress());
			  setClemail(rentalbean.getClemail());
//			  System.out.println("emaillll"+rentalbean.getClemail());
			  setClmobno(rentalbean.getClmobno());
			  setLblcldocno(rentalbean.getLblcldocno());
	    	   setLdllandno(rentalbean.getLdllandno());
//	    	   System.out.println("clienttelno"+rentalbean.getLdllandno());
			  
			  // main upper
			  setMrano(rentalbean.getMrano());
			  setRentaldoc(rentalbean.getRentaldoc());
		
	    	    
	    	    // dr details
			  
			  setRadrname(rentalbean.getRadrname());
			  setRadlno(rentalbean.getRadlno());
			  setPassno(rentalbean.getPassno());
			  setLicexpdate(rentalbean.getLicexpdate());
			  setPassexpdate(rentalbean.getPassexpdate());
//			  System.out.println("exp"+getPassexpdate());
			  setLblpassissued(rentalbean.getLblpassissued());
			  setDobdate(rentalbean.getDobdate()); 
			  setLblnation(rentalbean.getLblnation());
			  setLblissby(rentalbean.getLblissby());
			  setLblissfromdate(rentalbean.getLblissfromdate());
			  setLblidno(rentalbean.getLblidno());
			  // veh details
			  setRayear(rentalbean.getRayear());
			  setRavehname(rentalbean.getRavehname());
			  setRavehgroup(rentalbean.getRavehgroup());
			  setRavehmodel(rentalbean.getRavehmodel());
			  setRavehregno(rentalbean.getRavehregno());
			  setRadateout(rentalbean.getRadateout());
			  setRatimeout(rentalbean.getRatimeout());
			  setRaklmout(rentalbean.getRaklmout());
			  setRavehplate(rentalbean.getRavehplate());
			  setLblrentaltype(rentalbean.getLblrentaltype());
//			  System.out.println("get"+getLblrentaltype());
			
			  //out
			  setRe_Km(rentalbean.getRe_Km());
			  setHidjqxDateOut(rentalbean.getHidjqxDateOut());
			  setHidjqxTimeOut(rentalbean.getHidjqxTimeOut());
			  setRatariff_fuel(rentalbean.getRatariff_fuel());
//			  System.out.println("dateee"+rentalbean.getHidjqxDateOut());
			  
			setRamonthly(rentalbean.getRamonthly());
			setRaweakly(rentalbean.getRaweakly());
			setRadaily(rentalbean.getRadaily());
			  
			 setLblcosmokmrestrictdaily(rentalbean.getLblcosmokmrestrictdaily());
	           setLblcosmokmrestrictweekly(rentalbean.getLblcosmokmrestrictweekly());
	           setLblcosmokmrestrictmonthly(rentalbean.getLblcosmokmrestrictmonthly());
	           setLblcosmoexkmratedaily(rentalbean.getLblcosmoexkmratedaily());
	           setLblcosmoexkmrateweekly(rentalbean.getLblcosmoexkmrateweekly());
	           setLblcosmoexkmratemonthly(rentalbean.getLblcosmoexkmratemonthly());
			
			  
			  //rental type
//			  System.out.println("===== "+rentalbean.getRadaily()+"===== "+rentalbean.getRaweakly()+"======= "+rentalbean.getRamonthly()); 
			if(rentalbean.getLblrentaltype().equalsIgnoreCase("Monthly")){
				setRamonthly(rentalbean.getLblrentalrate());
				setLblcosmokmrestrictmonthly(rentalbean.getRaextrakm());
				setLblcosmoexkmratemonthly(rentalbean.getRaexxtakmchg());
			}
			else if(rentalbean.getLblrentaltype().equalsIgnoreCase("Daily")){
				setRadaily(rentalbean.getLblrentalrate());
				setLblcosmokmrestrictdaily(rentalbean.getRaextrakm());
				setLblcosmoexkmratedaily(rentalbean.getRaexxtakmchg());
			}
			else if(rentalbean.getLblrentaltype().equalsIgnoreCase("Weekly")){
				setRaweakly(rentalbean.getLblrentalrate());
				setLblcosmokmrestrictweekly(rentalbean.getRaextrakm());
				setLblcosmoexkmrateweekly(rentalbean.getRaexxtakmchg());
			}
			
			
		//	System.out.println("===== after == "+rentalbean.getRadaily()+"===== "+rentalbean.getRaweakly()+"======= "+rentalbean.getRamonthly());
			
			
			  setTariff(rentalbean.getTariff());
			  setRacdwscdw(rentalbean.getRacdwscdw());
			  setRaaccessory(rentalbean.getRaaccessory());
			  setRaadditionalcge(rentalbean.getRaadditionalcge());
			  
			  
			  setInkm(rentalbean.getInkm());
			  setInfuel(rentalbean.getInfuel());
			  setIndate(rentalbean.getIndate());
			  setIntime(rentalbean.getIntime());
			  setRastatus(rentalbean.getRastatus());
//			  System.out.println("getInkm::"+rentalbean.getInkm()+"::"+rentalbean.getInfuel()+"::"+rentalbean.getIndate()+"::"+rentalbean.getIntime()+"::"+rentalbean.getRastatus());
			  
			  setRafuelout(rentalbean.getRafuelout());

			  setRayom(rentalbean.getRayom());
	    	  setRacolor(rentalbean.getRacolor()) ;  
	    	   setAdddrname1(rentalbean.getAdddrname1());
	    	  setAdddrname2(rentalbean.getAdddrname2());
	    	   setAddlicno1(rentalbean.getAddlicno1());
	    	  setAddlicno2(rentalbean.getAddlicno2());
	    	   setExpdate1(rentalbean.getExpdate1());
	    	  setExpdate2(rentalbean.getExpdate2());
	    	  setAdddob1(rentalbean.getAdddob1());
	    	  setAdddob2(rentalbean.getAdddob2());
	    	  
			  setLblvisaexp(rentalbean.getLblvisaexp());
			  setLblvisaissdate(rentalbean.getLblvisaissdate());
	    	  
			   //Extras added in fancy
	    	  
	    	 setLbladdpassno1(rentalbean.getLbladdpassno1());
	    	 setLbladdpassexp1(rentalbean.getLbladdpassexp1());
	    	 setLbladdnation1(rentalbean.getLbladdnation1());
	    	 setLbladdissby1(rentalbean.getLbladdissby1());
	    	 setLbladdpassissued1(rentalbean.getLbladdpassissued1());
	    	 setLbladdissfrom1(rentalbean.getLbladdissfrom1());
	    	 setLbladdid1(rentalbean.getLbladdid1());
	    	  
	    	   setRaextrakm( rentalbean.getRaextrakm());
	    	   setRaexxtakmchg( rentalbean.getRaexxtakmchg());
	    	   setRarenttypes(rentalbean.getRarenttypes());
			 
	    	   setExcessinsu(rentalbean.getExcessinsu()); 
	    	   
	    	   setCompanyname(rentalbean.getCompanyname());
	    	   setBarnchval(rentalbean.getBarnchval());
	    	   setAddress(rentalbean.getAddress());
	    	   setMobileno(rentalbean.getMobileno());
	    	   setFax(rentalbean.getFax());
	    	   setLocation(rentalbean.getLocation());
	    	 // total  
	    	  setVisano(rentalbean.getVisano());
	    	  setVisaexp(rentalbean.getVisaexp());
	    	  setUserid(rentalbean.getUserid());
	    	   //System.out.println("=======BRANCH========"+rentalbean.getBarnchval()); 
	    	   //System.out.println("=======VISA========"+rentalbean.getVisano());
	    	  // System.out.println("=========EXPDATE======"+rentalbean.getVisaexp());
	    	    setInvamount(rentalbean.getInvamount());
	    	   setBalance(rentalbean.getBalance());
	    	   
	    	   
	    	   
	    	   
	    	   //dr
	    	    setLblclname(rentalbean.getLblclname());
	    	    setLblcladdress(rentalbean.getLblcladdress());
	    	    setLblclemail(rentalbean.getLblclemail());
	    	    setLblclmobno(rentalbean.getLblclmobno());   
		    	   
	    	     setDrivravehregno(rentalbean.getDrivravehregno());    
	    	     setLblpertel(rentalbean.getLblpertel());
		    	 setLblfaxno(rentalbean.getLblfaxno());
		    	 
		    	 
		    	 setLbldobdate(rentalbean.getLbldobdate());   
		    	 setLblradlno(rentalbean.getLblradlno());
		    	 setLbcardno(rentalbean.getLbcardno());
		    	 setCardtype(rentalbean.getCardtype());
		    	 setLbexpcarddate(rentalbean.getLbexpcarddate());
		    	 
		    	// setLbldobdate    setLblradlno   setLbcardno setLbexpcarddate 	    	   
		    	// System.out.println("=====asdasdas=========="+rentalbean.getLaldelcharge());
		    	 
		    	   setLblpai(rentalbean.getLblpai());
		    	   setLaldelcharge(rentalbean.getLaldelcharge());
		    	   setLblchafcharge(rentalbean.getLblchafcharge());
		    	   
	    	   
		    	    
		    	   setRasupercdw(rentalbean.getRasupercdw());
		    	    setRavmd(rentalbean.getRasupercdw());
		    	    
		    	    setLblpassissdate(rentalbean.getLblpassissdate());
		    	    
		    	    
			    	   
			    	  setDuedate(rentalbean.getDuedate());
			    	  
			    	  setCreatedate(rentalbean.getCreatedate());

				//mm
					setDuetime(rentalbean.getDuetime());

			    	    setRaagent(rentalbean.getRaagent());
			    	   setSalagent(rentalbean.getSalagent());
		    	    //mm
				setSalname(rentalbean.getSalname());
			    	   
			    	   //yetiprint
			    	     //security
			    	   setSecuritycardno(rentalbean.getSecuritycardno());
			    	   setSecurityexpdate(rentalbean.getSecurityexpdate());
			    	   setSecuritypreauthno(rentalbean.getSecuritypreauthno());
			    	   setSecuritypreauthamt(rentalbean.getSecuritypreauthamt()); 
			    	   //totals
			    	   
			    	   setTarifftotal(rentalbean.getTarifftotal());
			    	   setRacdwscdwtotal(rentalbean.getRacdwscdwtotal());
			    	   setRaaccessorytotal(rentalbean.getRaaccessorytotal());
			    	   setLaldelchargetotal(rentalbean.getLaldelchargetotal());
			    	   setAdvtotalamont(rentalbean.getAdvtotalamont());
			    	   setAdvpaidamount(rentalbean.getAdvpaidamount());
			    	   setAdvbalance(rentalbean.getAdvbalance());
			    	   
	    	   
	    	   
	          
//			   System.out.println("print page="+getUrl());
			   //For Cosmo Print
	           
	           
	           setLblcosmofleetbrand(rentalbean.getLblcosmofleetbrand());
	           setLblcosmofleetno(rentalbean.getLblcosmofleetno());
	           setLblcosmoissuedat(rentalbean.getLblcosmoissuedat());
	           setLblcosmocheckin(rentalbean.getLblcosmocheckin());
	           setLblcosmocheckout(rentalbean.getLblcosmocheckout());
	           setLblcosmokmin(rentalbean.getLblcosmokmin());
	           setLblcosmofuelin(rentalbean.getLblcosmofuelin());
	           setLblcosmocreditcardno(rentalbean.getLblcosmocreditcardno());
	           setLblcosmocreditvaliddate(rentalbean.getLblcosmocreditvaliddate());
	           setLblcosmosecurity(rentalbean.getLblcosmosecurity());
	           setLblcosmoexcessamt(rentalbean.getLblcosmoexcessamt());
	           setLblcosmogps(rentalbean.getLblcosmogps());
	           setLblcosmocollectchg(rentalbean.getLblcosmocollectchg());
	           setLblcosmodamagechg(rentalbean.getLblcosmodamagechg());
	           setLblcosmofuelchg(rentalbean.getLblcosmofuelchg());
	           setLblcosmototal(rentalbean.getLblcosmototal());
	           setLblcosmoadvance(rentalbean.getLblcosmoadvance());
	          
	           setLblcosmobabyseater(rentalbean.getLblcosmobabyseater());
			   setLblcosmodriverlicense(rentalbean.getLblcosmodriverlicense());
	           setLblcosmodrivermobile(rentalbean.getLblcosmodrivermobile());
	           setLblcosmodrivername(rentalbean.getLblcosmodrivername());
	           setLblcosmodrivervalidupto(rentalbean.getLblcosmodrivervalidupto());
	           setLblcosmodriverpassport(rentalbean.getLblcosmodriverpassport());
	           setLblcosmocooler(rentalbean.getLblcosmocooler());
	    	//   System.out.println("=========="+getUrl()+"============"+getFormdetailcode());


			///yessur print
	           
	            setDrivermobno(rentalbean.getDrivermobno());
	            setDrivercountry(rentalbean.getLblnation());
	            setVehiclechasisno(rentalbean.getCh_no());
	            setRdsecuritydeposit(rentalbean.getSecuritypreauthamt());
	            setRentaldetcdw(rentalbean.getRacdwscdw());
	           
	           //yessur print
			
			//For Selcar
	           
	           
	           
	           
	           // yes sure
	           
	           setCh_no(rentalbean.getCh_no());
			
			}
			if(agmtype.equalsIgnoreCase("LAG")) {
			leasebean=inspectionDAO.getLeasePrint(agmtno);
			setLblagmtbrhid(leasebean.getLblagmtbrhid());
			 setRentaltotals(leasebean.getRentaltotals());
			  setTotaltot(leasebean.getTotaltot());
			  setLblauthority(leasebean.getLblauthority());
			 
			  setVehauth(leasebean.getVehauth());
			  setLbldesc(leasebean.getLbldesc());
			  
			   setLblcompmail(leasebean.getLblcompmail());
			  setLblcompwebsite(leasebean.getLblcompwebsite());
			  setLbltel1(leasebean.getLbltel1());
			  setLbltel2(leasebean.getLbltel2());
			 
			  setLblclientrn(leasebean.getLblclientrn());
			  //del details
//			  System.out.println("dateaaaa:"+leasebean.getHidjqxDateOut());
			  
			  //----------cp----------//
			  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			  
			  
			 
			  
			  setLblnofdays(leasebean.getLblnofdays());
			  setLblrentaldesc(leasebean.getLblrentaldesc());
			  setLbluser(leasebean.getLbluser());
			  setRavehauthregno(leasebean.getRavehauthregno());
			  //----------cp----------//
	  
	    	    
	    	    
	    	  //  salikcharge
	    	    
	    	   setTrafficcharge(leasebean.getTrafficcharge());
	    	    setTotalsalikandtraffic(leasebean.getTotalsalikandtraffic());
/*			  setDeldates setDeltimes setDelkmins setDelfuels*/
			  
			  setDeldates(leasebean.getDeldates());
			  setDeltimes(leasebean.getDeltimes());
			  setDelkmins(leasebean.getDelkmins());
			  setDelfuels(leasebean.getDelfuels());
			  
			  
	    	   setOutdetails(leasebean.getOutdetails());
	    	  setDeldetailss(leasebean.getDeldetailss());
			  
			  //col
	
	    	   setColdates(leasebean.getColdates());
	    	   setColtimes(leasebean.getColtimes());
	    	   setColkmins(leasebean.getColkmins());
	    	   setColfuels(leasebean.getColfuels());
				  
	     	    setIndetails(leasebean.getIndetails());
			    
		    	 setColdetails(leasebean.getColdetails());
		    	    
		    	     
	    	   
			  
			  //cl details
			  setClname(leasebean.getClname());
			  setCladdress(leasebean.getCladdress());
			  setClemail(leasebean.getClemail());
//			  System.out.println("emaillll"+leasebean.getClemail());
			  setClmobno(leasebean.getClmobno());
			  setLblcldocno(leasebean.getLblcldocno());
	    	   setLdllandno(leasebean.getLdllandno());
//	    	   System.out.println("clienttelno"+leasebean.getLdllandno());
			  
			  // main upper
			  setBarnchval(leasebean.getBarnchval());
			  setMrano(leasebean.getMrano());
			  setRentaldoc(leasebean.getRentaldoc());
		
	    	    
	    	    // dr details
			  
			  setRadrname(leasebean.getRadrname());
			  setRadlno(leasebean.getRadlno());
			  setPassno(leasebean.getPassno());
			  setLicexpdate(leasebean.getLicexpdate());
			  setPassexpdate(leasebean.getPassexpdate());
//			  System.out.println("exp"+getPassexpdate());
			  setLblpassissued(leasebean.getLblpassissued());
			  setDobdate(leasebean.getDobdate()); 
			  setLblnation(leasebean.getLblnation());
			  setLblissby(leasebean.getLblissby());
			  setLblissfromdate(leasebean.getLblissfromdate());
			  setLblidno(leasebean.getLblidno());
			  // veh details
			  setRayear(leasebean.getRayear());
			  setRavehname(leasebean.getRavehname());
			  setRavehgroup(leasebean.getRavehgroup());
			  setRavehmodel(leasebean.getRavehmodel());
			  setRavehregno(leasebean.getRavehregno());
			  setRadateout(leasebean.getRadateout());
			  setRatimeout(leasebean.getRatimeout());
			  setRaklmout(leasebean.getRaklmout());
			  setRavehplate(leasebean.getRavehplate());
			  setLblrentaltype(leasebean.getLblrentaltype());
//			  System.out.println("get"+getLblrentaltype());
			
			  //out
			  setRe_Km(leasebean.getRe_Km());
			  setHidjqxDateOut(leasebean.getHidjqxDateOut());
			  setHidjqxTimeOut(leasebean.getHidjqxTimeOut());
			  setRatariff_fuel(leasebean.getRatariff_fuel());
//			  System.out.println("dateee"+leasebean.getHidjqxDateOut());
			  
			setRamonthly(leasebean.getRamonthly());
			setRaweakly(leasebean.getRaweakly());
			setRadaily(leasebean.getRadaily());
			  
			 setLblcosmokmrestrictdaily(leasebean.getLblcosmokmrestrictdaily());
	           setLblcosmokmrestrictweekly(leasebean.getLblcosmokmrestrictweekly());
	           setLblcosmokmrestrictmonthly(leasebean.getLblcosmokmrestrictmonthly());
	           setLblcosmoexkmratedaily(leasebean.getLblcosmoexkmratedaily());
	           setLblcosmoexkmrateweekly(leasebean.getLblcosmoexkmrateweekly());
	           setLblcosmoexkmratemonthly(leasebean.getLblcosmoexkmratemonthly());
			
			  
			  //rental type
//			  System.out.println("===== "+leasebean.getRadaily()+"===== "+leasebean.getRaweakly()+"======= "+leasebean.getRamonthly()); 
				/*
				 * if(leasebean.getLblrentaltype().equalsIgnoreCase("Monthly")){
				 * setRamonthly(leasebean.getLblrentalrate());
				 * setLblcosmokmrestrictmonthly(leasebean.getRaextrakm());
				 * setLblcosmoexkmratemonthly(leasebean.getRaexxtakmchg()); } else
				 * if(leasebean.getLblrentaltype().equalsIgnoreCase("Daily")){
				 * setRadaily(leasebean.getLblrentalrate());
				 * setLblcosmokmrestrictdaily(leasebean.getRaextrakm());
				 * setLblcosmoexkmratedaily(leasebean.getRaexxtakmchg()); } else
				 * if(leasebean.getLblrentaltype().equalsIgnoreCase("Weekly")){
				 * setRaweakly(leasebean.getLblrentalrate());
				 * setLblcosmokmrestrictweekly(leasebean.getRaextrakm());
				 * setLblcosmoexkmrateweekly(leasebean.getRaexxtakmchg()); }
				 */
			
			
		//	System.out.println("===== after == "+leasebean.getRadaily()+"===== "+leasebean.getRaweakly()+"======= "+leasebean.getRamonthly());
			
			
			  setTariff(leasebean.getTariff());
			  setRacdwscdw(leasebean.getRacdwscdw());
			  setRaaccessory(leasebean.getRaaccessory());
			  setRaadditionalcge(leasebean.getRaadditionalcge());
			  
			  
			  setInkm(leasebean.getInkm());
			  setInfuel(leasebean.getInfuel());
			  setIndate(leasebean.getIndate());
			  setIntime(leasebean.getIntime());
			  setRastatus(leasebean.getRastatus());
//			  System.out.println("getInkm::"+leasebean.getInkm()+"::"+leasebean.getInfuel()+"::"+leasebean.getIndate()+"::"+leasebean.getIntime()+"::"+leasebean.getRastatus());
			  
			  setRafuelout(leasebean.getRafuelout());

			  setRayom(leasebean.getRayom());
	    	  setRacolor(leasebean.getRacolor()) ;  
	    	   setAdddrname1(leasebean.getAdddrname1());
	    	  setAdddrname2(leasebean.getAdddrname2());
	    	   setAddlicno1(leasebean.getAddlicno1());
	    	  setAddlicno2(leasebean.getAddlicno2());
	    	   setExpdate1(leasebean.getExpdate1());
	    	  setExpdate2(leasebean.getExpdate2());
	    	  setAdddob1(leasebean.getAdddob1());
	    	  setAdddob2(leasebean.getAdddob2());
	    	  
			  setLblvisaexp(leasebean.getLblvisaexp());
			  setLblvisaissdate(leasebean.getLblvisaissdate());
	    	  
			   //Extras added in fancy
	    	  
	    	 setLbladdpassno1(leasebean.getLbladdpassno1());
	    	 setLbladdpassexp1(leasebean.getLbladdpassexp1());
	    	 setLbladdnation1(leasebean.getLbladdnation1());
	    	 setLbladdissby1(leasebean.getLbladdissby1());
	    	 setLbladdpassissued1(leasebean.getLbladdpassissued1());
	    	 setLbladdissfrom1(leasebean.getLbladdissfrom1());
	    	 setLbladdid1(leasebean.getLbladdid1());
	    	  
	    	   setRaextrakm( leasebean.getRaextrakm());
	    	   setRaexxtakmchg( leasebean.getRaexxtakmchg());
	    	   setRarenttypes(leasebean.getRarenttypes());
			 
	    	   setExcessinsu(leasebean.getExcessinsu()); 
	    	   
	    	   setCompanyname(leasebean.getCompanyname());
	    	 	  
	    	   setAddress(leasebean.getAddress());
	    	 
	    	   setMobileno(leasebean.getMobileno());
	    	  
	    	   setFax(leasebean.getFax());
	    	   setLocation(leasebean.getLocation());
	    	   setBarnchval(leasebean.getBarnchval());
	    	   setVisano(leasebean.getVisano());
		      setVisaexp(leasebean.getVisaexp());
		      setUserid(leasebean.getUserid());
	    	 // total  
	    	   //System.out.println("=======BRANCH========"+rentalbean.getBarnchval());   
		    	  
	    	  
	    	    setInvamount(leasebean.getInvamount());
	    	   setBalance(leasebean.getBalance());
	    	   
	    	   
	    	   
	    	   
	    	   //dr
	    	    setLblclname(leasebean.getLblclname());
	    	    setLblcladdress(leasebean.getLblcladdress());
	    	    setLblclemail(leasebean.getLblclemail());
	    	    setLblclmobno(leasebean.getLblclmobno());   
		    	   
	    	     setDrivravehregno(leasebean.getDrivravehregno());    
	    	     setLblpertel(leasebean.getLblpertel());
		    	 setLblfaxno(leasebean.getLblfaxno());
		    	 
		    	 
		    	 setLbldobdate(leasebean.getLbldobdate());   
		    	 setLblradlno(leasebean.getLblradlno());
		    	 setLbcardno(leasebean.getLbcardno());
		    	 setCardtype(leasebean.getCardtype());
		    	 setLbexpcarddate(leasebean.getLbexpcarddate());
		    	 
		    	// setLbldobdate    setLblradlno   setLbcardno setLbexpcarddate 	    	   
		    	// System.out.println("=====asdasdas=========="+leasebean.getLaldelcharge());
		    	 
		    	   setLblpai(leasebean.getLblpai());
		    	   setLaldelcharge(leasebean.getLaldelcharge());
		    	   setLblchafcharge(leasebean.getLblchafcharge());
		    	   
	    	   
		    	    
		    	   setRasupercdw(leasebean.getRasupercdw());
		    	    setRavmd(leasebean.getRasupercdw());
		    	    
		    	    setLblpassissdate(leasebean.getLblpassissdate());
		    	    
		    	    
			    	   
			    	  setDuedate(leasebean.getDuedate());
			    	  
			    	  setCreatedate(leasebean.getCreatedate());

				//mm
					setDuetime(leasebean.getDuetime());

			    	    setRaagent(leasebean.getRaagent());
			    	   setSalagent(leasebean.getSalagent());
		    	    //mm
				setSalname(leasebean.getSalname());
			    	   
			    	   //yetiprint
			    	     //security
			    	   setSecuritycardno(leasebean.getSecuritycardno());
			    	   setSecurityexpdate(leasebean.getSecurityexpdate());
			    	   setSecuritypreauthno(leasebean.getSecuritypreauthno());
			    	   setSecuritypreauthamt(leasebean.getSecuritypreauthamt()); 
			    	   //totals
			    	   
			    	   setTarifftotal(leasebean.getTarifftotal());
			    	   setRacdwscdwtotal(leasebean.getRacdwscdwtotal());
			    	   setRaaccessorytotal(leasebean.getRaaccessorytotal());
			    	   setLaldelchargetotal(leasebean.getLaldelchargetotal());
			    	   setAdvtotalamont(leasebean.getAdvtotalamont());
			    	   setAdvpaidamount(leasebean.getAdvpaidamount());
			    	   setAdvbalance(leasebean.getAdvbalance());
			    	   
	    	   
	    	   
	          
//			   System.out.println("print page="+getUrl());
			   //For Cosmo Print
	           
	           
	           setLblcosmofleetbrand(leasebean.getLblcosmofleetbrand());
	           setLblcosmofleetno(leasebean.getLblcosmofleetno());
	           setLblcosmoissuedat(leasebean.getLblcosmoissuedat());
	           setLblcosmocheckin(leasebean.getLblcosmocheckin());
	           setLblcosmocheckout(leasebean.getLblcosmocheckout());
	           setLblcosmokmin(leasebean.getLblcosmokmin());
	           setLblcosmofuelin(leasebean.getLblcosmofuelin());
	           setLblcosmocreditcardno(leasebean.getLblcosmocreditcardno());
	           setLblcosmocreditvaliddate(leasebean.getLblcosmocreditvaliddate());
	           setLblcosmosecurity(leasebean.getLblcosmosecurity());
	           setLblcosmoexcessamt(leasebean.getLblcosmoexcessamt());
	           setLblcosmogps(leasebean.getLblcosmogps());
	           setLblcosmocollectchg(leasebean.getLblcosmocollectchg());
	           setLblcosmodamagechg(leasebean.getLblcosmodamagechg());
	           setLblcosmofuelchg(leasebean.getLblcosmofuelchg());
	           setLblcosmototal(leasebean.getLblcosmototal());
	           setLblcosmoadvance(leasebean.getLblcosmoadvance());
	          
	           setLblcosmobabyseater(leasebean.getLblcosmobabyseater());
			   setLblcosmodriverlicense(leasebean.getLblcosmodriverlicense());
	           setLblcosmodrivermobile(leasebean.getLblcosmodrivermobile());
	           setLblcosmodrivername(leasebean.getLblcosmodrivername());
	           setLblcosmodrivervalidupto(leasebean.getLblcosmodrivervalidupto());
	           setLblcosmodriverpassport(leasebean.getLblcosmodriverpassport());
	           setLblcosmocooler(leasebean.getLblcosmocooler());
	    	//   System.out.println("=========="+getUrl()+"============"+getFormdetailcode());


			///yessur print
	           
	            setDrivermobno(leasebean.getDrivermobno());
	            setDrivercountry(leasebean.getLblnation());
	            setVehiclechasisno(leasebean.getCh_no());
	            setRdsecuritydeposit(leasebean.getSecuritypreauthamt());
	            setRentaldetcdw(leasebean.getRacdwscdw());
	           
	           //yessur print
			
			//For Selcar
	           
	           
	           
	           
	           // yes sure
	           
	           setCh_no(leasebean.getCh_no());
			
			}
			/*beannew=inspectionDAO.getUser(inspdoc);*/
			


		 //classic print
				
//				System.out.println("RentalAgreementBean.getClsiclpo()=="+rentalbean.getClsiclpo());
				
			beansign=inspectionDAO.getSignature(inspdoc);
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblbranch(bean.getLblbranch());
			setLbldocno(bean.getLbldocno());
			setLbldate(bean.getLbldate());
			setLbltime(bean.getLbltime());
			setLbltype(bean.getLbltype());
			setLblreftype(bean.getLblreftype());
			setLblrefdocno(bean.getLblrefdocno());
			setLblreffleetno(bean.getLblreffleetno());
			setLblaccident(bean.getLblaccident());
			setLblaccdate(bean.getLblaccdate());
			setLblprcs(bean.getLblprcs());
			setLblcoldate(bean.getLblcoldate());
			setLblplace(bean.getLblplace());
			setLblfines(bean.getLblfines());
			setLblclaim(bean.getLblclaim());
			setLblcoldate(bean.getLblcoldate());
			setLblremarks(bean.getLblremarks());
			setLblamount(bean.getLblamount());
			setLblfleetname(bean.getLblfleetname());
			setLblregno(bean.getLblregno());
			setLblprintname("Vehicle Inspection");
			remail=bean.getClientmail();
			
		     System.out.println("agmtdocno==="+agmtno);
			 par = new HashMap();
			// Connection conn = null;
			 par.put("agmtdocno",agmtno);
			 par.put("agmttype",agmtype);
			 if (rentalbean != null && rentalbean.getLblcosmofuelin() != null) {
				    par.put("fuelin", rentalbean.getLblcosmofuelin());
				} else {
				     par.put("fuelin", "0");    
				}
		          
             	// conn = objconn.getMyConnection();
			 
			 String imgvehicleout = "", imgvehiclein = "";
			 String repimgsql = "SELECT CONCAT(i.doc_no,',',i1.doc_no) att, COALESCE(f.path,'') outimg, COALESCE(f1.path,'') inimg FROM gl_vinspm i "
			 		+ "LEFT JOIN gl_vinspm i1 ON i.refdocno=i1.refdocno AND i.reftype=i1.reftype AND i1.type='in' LEFT JOIN my_fileattach f ON f.doc_no=i.doc_no AND f.dtype='vip' AND f.sr_no=1 "
			 		+ "LEFT JOIN my_fileattach f1 ON f1.doc_no=i1.doc_no AND f1.dtype='vip' AND f1.sr_no=1 WHERE i.doc_no='"+inspdoc+"'";
	         ResultSet rsimg = stmt.executeQuery(repimgsql);
	         while(rsimg.next()) {
	        	 imgvehicleout = rsimg.getString("outimg");
	        	 imgvehiclein = rsimg.getString("inimg");   
	         }
			 
	         par.put("imgvehicleout", imgvehicleout);
        	 par.put("imgvehiclein", imgvehiclein);
			 
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	        	 imgpath=imgpath.replace("\\", "\\\\");   
	        	 
	        	  String imgpath2=request.getSession().getServletContext().getRealPath("/icons/replacevehiclenew.jpg");
		        	 imgpath2=imgpath2.replace("\\", "\\\\");    
		        	 
		        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/replacevehiclenew.jpg");
			        	 imgpath3=imgpath3.replace("\\", "\\\\");    
	        	 
			        	 par.put("pic1", imgpath2);
			        	 par.put("pic2", imgpath3);
			      
			     String imgpathhorizontal = request.getSession().getServletContext().getRealPath("/icons/replacevehicle.jpg");
			     imgpathhorizontal=imgpathhorizontal.replace("\\", "\\\\");    
			     par.put("imgpathhorizontal", imgpathhorizontal);
			     if (agmtype.equalsIgnoreCase("RAG") || agmtype.equalsIgnoreCase("LAG")) {   
			     String imgagreementterms=request.getSession().getServletContext().getRealPath("/icons/agreementterms.png");
			     imgagreementterms=imgagreementterms.replace("\\", "\\\\");   
			     par.put("imgagreementterms", imgagreementterms);
			     }
			     
	             //System.out.println("cmplogo====="+imgpath);
	             //System.out.println("lbldocno====="+bean.getLbldocno());
	             //System.out.println("lbldate====="+bean.getLbldate());
	             //System.out.println("lbltime====="+bean.getLbltime());
	             //System.out.println("lbltype====="+bean.getLbltype());
	             //System.out.println("lblreftype====="+bean.getLblreftype());
	             //System.out.println("lblrefdocno====="+bean.getLblrefdocno());
	             //System.out.println("lblreffleetno====="+bean.getLblreffleetno());
	             //System.out.println("lblregno====="+ bean.getLblregno());
	             //System.out.println("lblfleetname====="+bean.getLblfleetname());
	             //System.out.println("lblamount====="+bean.getLblamount());
	             //System.out.println("username====="+  beannew.getUsername());
	             
	            
	             //System.out.println("right====="+beannew.getRight());
	             //System.out.println("imgpath====="+imgpath);
	             String doc=bean.getLbldocno();
	        	 par.put("imgheader", imgpath);
	        	/* par.put("lbldocno",doc );	
				 par.put("lbldate", bean.getLbldate());		        
		         par.put("lbltime", bean.getLbltime());
		         par.put("lbltype", bean.getLbltype());			       
		         par.put("lblreftype", bean.getLblreftype());
		         par.put("lblrefdocno", bean.getLblrefdocno());
		         par.put("lblreffleetno", bean.getLblreffleetno());
		         par.put("lblregno", bean.getLblregno());
		         par.put("lblfleetname", bean.getLblfleetname());
		         
		         par.put("lblamount",bean.getLblamount());
		         par.put("date", bean.getLbldate());
		         par.put("time", bean.getLbltime());*/
		         par.put("orderno", doc);
		         par.put("clientid", bean.getLblclientid());
		         par.put("client", bean.getLblrefdocno());
		         par.put("mob", bean.getLblclntmob());
		         par.put("email", bean.getClientmail());
		         par.put("driver", bean.getLbldriver());
		         par.put("address", bean.getLblcompaddress());
		         par.put("drivmob", bean.getLbldrivermob());
		         par.put("drivdob", bean.getLbldriverdob());
		         par.put("drivdlno", bean.getLbldriverdlno());
		         par.put("regno", bean.getLblregno());
		         par.put("pltcode", bean.getLblpltcode());
		         par.put("outdate", bean.getLbldout());
		         par.put("outtime", bean.getLbltout());
		         par.put("outkm", bean.getLblkmout());
		         par.put("outfuel", bean.getLblfout());
		         par.put("outby", bean.getLbloutby());
		         par.put("custname", bean.getLblrefdocno());
		        
		         par.put("brwithcompany", bean.getBrwithcompany());
		         par.put("rlocation", bean.getLblrlocation());
		         par.put("agmt", bean.getAgmt());
		         par.put("vrano", bean.getVrano());
		         //par.put("vradate", bean.getVradate());
		         par.put("clientacno", bean.getClientacno());
		         par.put("pclient", bean.getPclient());
		         par.put("reptype",bean.getReptype());
		         
	
	        	 par.put("brwithcompany", bean.getBrwithcompany());
		         par.put("vrano", bean.getVrano());
		         par.put("mtime", bean.getMtime());
		         par.put("pfleetno", bean.getPfleetno());
		         par.put("pfuel", bean.getPfuel());
		         par.put("popened", bean.getPopened());
		         par.put("pclient", bean.getPclient());
		         par.put("clientacno", bean.getClientacno());
		         par.put("agmt", bean.getAgmt());
		         par.put("pdocno", bean.getPdocno());
		         par.put("pdate", bean.getPdate());
		         par.put("pregno", bean.getPregno());
		         par.put("vradate", bean.getVradate()); //bean.getVradate()
		         
		         System.out.println("vradate========"+bean.getVradate());
		         
		         par.put("dtimes", bean.getDtimes());
		         par.put("replaced", bean.getReplaced());
		         par.put("reptype",bean.getReptype());
		         par.put("pkm", bean.getPkm());
		         par.put("poutdate", bean.getPoutdate());

		         par.put("pdelivery", bean.getPdelivery());
		         par.put("rlocation", bean.getLblrlocation());
		      
		         
		         par.put("inlocation", bean.getLblinlocation());
		         par.put("outlocation", bean.getLbloutlocation());
		         par.put("inbrwithcompany", bean.getInbrwithcompany());
		         par.put("invehdate", bean.getInvehdate());
		         par.put("invehtime", bean.getInvehtime());
		         par.put("invehkm", bean.getInvehkm());
		         par.put("invehfuel", bean.getInvehfuel());
		         par.put("invehreason", bean.getInvehreason());
		         par.put("infleetname", bean.getLblinfleetname());			         
		         par.put("inimg", bean.getLblinimg());
		         par.put("sigpath", bean.getSigpath());
		         par.put("newbrwithcompany", bean.getNewbrwithcompany());
		         par.put("newvehoutdate", bean.getNewvehoutdate());
		         par.put("newvehouttime", bean.getNewvehouttime());
		         par.put("newvehfleet",bean.getNewvehfleet());
		         par.put("newvehregno", bean.getNewvehregno());
		         par.put("newvehkm", bean.getNewvehkm());
		         
		         par.put("newvehfuel", bean.getNewvehfuel());
		         par.put("outfleetname", bean.getLbloutfleetname());
		         par.put("outimg", bean.getLbloutimg());
		         par.put("delbrwithcompany", bean.getDelbrwithcompany());
		         par.put("deldate", bean.getDeldate());
		         par.put("deltime", bean.getDeltime());
		         par.put("delfleet", bean.getDelfleet());
		         par.put("delregno", bean.getDelregno());
		         par.put("delkm", bean.getDelkm());
		         par.put("delfuel", bean.getDelfuel());
		         par.put("delivery", bean.getLbldelivery());			         
		         par.put("delfleetname", bean.getLbldelfleetname());			         
		         par.put("colbrwithcompany", bean.getColbrwithcompany());
		         par.put("coldate", bean.getColdate());
		         par.put("coltime", bean.getColtime());
		         par.put("colfleet", bean.getColfleet());
		         par.put("colregno",bean.getColregno());
		         par.put("colkm", bean.getColkm());
		         par.put("colfuel", bean.getColfuel());
		         
		         par.put("collection", bean.getLblcollection());
		         par.put("colfleetname", bean.getLblcolfleetname());
		         par.put("deldriver", bean.getLbldeldriver());
		         par.put("coldriver", bean.getLblcoldriver());
		         par.put("description", bean.getLbldescription());
		         par.put("drivenby", bean.getLbldrivenby());
		         par.put("repbarnchval", bean.getRepbarnchval());
		         par.put("repcompanyname", bean.getRepcompanyname());
		         par.put("repaddress", bean.getRepaddress());
		         par.put("repmobileno", bean.getRepmobileno());
		         par.put("repfax", bean.getRepfax());			         
		         par.put("replocation", bean.getReplocation());	
		      			  
		         System.out.println("agmtype-"+agmtype);
		         if(agmtype.equalsIgnoreCase("RPL") || agmtype.equalsIgnoreCase("REP")) {
		        	 par.put("showbnd","2");
		        	 par.put("chkprinthead","Vehicle Replacement");
		        	 par.put("brwithcompany", rplbean.getBrwithcompany());
			         par.put("vrano", rplbean.getVrano());
			         par.put("mtime", rplbean.getMtime());
			         par.put("pfleetno", rplbean.getPfleetno());
			         par.put("pfuel", rplbean.getPfuel());
			         par.put("popened", rplbean.getPopened());
			         par.put("pclient", rplbean.getPclient());
			         par.put("clientacno", rplbean.getClientacno());
			         par.put("agmt", rplbean.getAgmt());
			         par.put("pdocno", rplbean.getPdocno());
			         par.put("pdate", rplbean.getPdate());
			         par.put("pregno", rplbean.getPregno());
			         par.put("vradate", rplbean.getVradate()); //rplbean.getVradate()
			         
			         System.out.println("==vradate=RPL="+rplbean.getVradate());  
			         
			         par.put("dtimes", rplbean.getDtimes());
			         par.put("replaced", rplbean.getReplaced());
			         par.put("reptype",rplbean.getReptype());
			         par.put("pkm", rplbean.getPkm());
			         par.put("poutdate", rplbean.getPoutdate());

			         par.put("pdelivery", rplbean.getPdelivery());
			         par.put("rlocation", rplbean.getLblrlocation());
			      
			         System.out.println("IN agmtype-"+agmtype);
			         
			         par.put("inlocation", rplbean.getLblinlocation());
			         par.put("outlocation", rplbean.getLbloutlocation());
			         par.put("inbrwithcompany", rplbean.getInbrwithcompany());
			         par.put("invehdate", rplbean.getInvehdate());
			         par.put("invehtime", rplbean.getInvehtime());
			         par.put("invehkm", rplbean.getInvehkm());
			         par.put("invehfuel", rplbean.getInvehfuel());
			         par.put("invehreason", rplbean.getInvehreason());
			         par.put("infleetname", rplbean.getLblinfleetname());			         
			         par.put("inimg", rplbean.getLblinimg());
			         par.put("sigpath", rplbean.getSigpath());
			         par.put("newbrwithcompany", rplbean.getNewbrwithcompany());
			         par.put("newvehoutdate", rplbean.getNewvehoutdate());
			         par.put("newvehouttime", rplbean.getNewvehouttime());
			         par.put("newvehfleet",rplbean.getNewvehfleet());
			         par.put("newvehregno", rplbean.getNewvehregno());
			         par.put("newvehkm", rplbean.getNewvehkm());
			         
			         par.put("newvehfuel", rplbean.getNewvehfuel());
			         par.put("outfleetname", rplbean.getLbloutfleetname());
			         par.put("outimg", rplbean.getLbloutimg());
			         par.put("delbrwithcompany", rplbean.getDelbrwithcompany());
			         par.put("deldate", rplbean.getDeldate());
			         par.put("deltime", rplbean.getDeltime());
			         par.put("delfleet", rplbean.getDelfleet());
			         par.put("delregno", rplbean.getDelregno());
			         par.put("delkm", rplbean.getDelkm());
			         par.put("delfuel", rplbean.getDelfuel());
			         par.put("delivery", rplbean.getLbldelivery());			         
			         par.put("delfleetname", rplbean.getLbldelfleetname());			         
			         par.put("colbrwithcompany", rplbean.getColbrwithcompany());
			         par.put("coldate", rplbean.getColdate());
			         par.put("coltime", rplbean.getColtime());
			         par.put("colfleet", rplbean.getColfleet());
			         par.put("colregno",rplbean.getColregno());
			         par.put("colkm", rplbean.getColkm());
			         par.put("colfuel", rplbean.getColfuel());
			         
			         par.put("collection", rplbean.getLblcollection());
			         par.put("colfleetname", rplbean.getLblcolfleetname());
			         par.put("deldriver", rplbean.getLbldeldriver());
			         par.put("coldriver", rplbean.getLblcoldriver());
			         par.put("description", rplbean.getLbldescription());
			         par.put("drivenby", rplbean.getLbldrivenby());
			         par.put("repbarnchval", rplbean.getRepbarnchval());
			         par.put("repcompanyname", rplbean.getRepcompanyname());
			         par.put("repaddress", rplbean.getRepaddress());
			         par.put("repmobileno", rplbean.getRepmobileno());
			         par.put("repfax", rplbean.getRepfax());			         
			         par.put("replocation", rplbean.getReplocation());			         
			      			         
		         }
		         
		         
		         if(agmtype.equalsIgnoreCase("RAG")) {
		        	
		        	 par.put("showbnd","1");
		        par.put("testparam","RENTAL AGREEMENT");
		        par.put("cardno",rentalbean.getLblcosmocreditcardno());
		        par.put("formdesc",rentalbean.getLbldesc());
		        par.put("insex",rentalbean.getExcessinsu());
		         par.put("rentaldoc",rentalbean.getRentaldoc());
		         par.put("barnchal",rentalbean.getBarnchval());
		         par.put("lblindigocldocno",rentalbean.getLblindigocldocno());
		         par.put("clname",rentalbean.getClname());
		         par.put("lblindigonationality",rentalbean.getLblindigonationality());
		         par.put("claddress",rentalbean.getCladdress());
		         par.put("clmobno",rentalbean.getClmobno());
		         par.put("clemail",rentalbean.getClemail());
		         par.put("radrname",rentalbean.getRadrname());
		         par.put("radlno",rentalbean.getRadlno());
		         par.put("lblaccount","0");
		         par.put("passno",rentalbean.getPassno());
		         par.put("passexpdate",rentalbean.getPassexpdate());
		         par.put("dobdate",rentalbean.getDobdate());
		         par.put("lblidno",rentalbean.getLblidno());
		         par.put("lblvisaexp",rentalbean.getLblvisaexp());
		         par.put("adddrname1",rentalbean.getAdddrname1());
		         par.put("lblindigoaddnationality",rentalbean.getLblindigoaddnationality());
		         par.put("addlicno1",rentalbean.getAddlicno1());
		         par.put("lblindigoaddmobile",rentalbean.getLblindigoaddmobile());
		         par.put("expdate1",rentalbean.getExpdate1());
		         par.put("adddob1",rentalbean.getAdddob1());
		         par.put("cardtype",rentalbean.getCardtype());
		         par.put("preauthamt","0");
		         par.put("ravehname",rentalbean.getRavehname());
		         par.put("racolor",rentalbean.getRacolor());
		         par.put("lblcosmofleetno",rentalbean.getLblcosmofleetno());
		         par.put("ravehregno",rentalbean.getRavehregno());
		         par.put("rayom",rentalbean.getRayom());
		         par.put("ravehgroup",rentalbean.getRavehgroup());
		         par.put("outdetails",rentalbean.getOutdetails());
		         par.put("radateout",rentalbean.getRadateout());
		         par.put("ratimeout",rentalbean.getRatimeout());
		         par.put("raklmout",rentalbean.getRaklmout());
		         par.put("rafuelout",rentalbean.getRafuelout());
		         par.put("deldates",rentalbean.getDeldates());
		         par.put("deltimes",rentalbean.getDeltimes());
		         par.put("delkmins",rentalbean.getDelkmins());
		         par.put("delfuels",rentalbean.getDelfuels());
		         par.put("lblindigonettotal",rentalbean.getLblindigonettotal());
		         par.put("racdwscdw",rentalbean.getRacdwscdw());
		         par.put("lblpai",rentalbean.getLblpai());
		         par.put("raaccessory",rentalbean.getRaaccessory());
		         par.put("rasupercdw",rentalbean.getRasupercdw());
		         par.put("lblchafcharge",rentalbean.getLblchafcharge());
		         par.put("raextrakm",rentalbean.getRaextrakm());
		         par.put("raextrakmchg",rentalbean.getRaexxtakmchg());
		         par.put("securitypreauthamount",rentalbean.getSecuritypreauthamt());
		         par.put("lblindigorenttype",rentalbean.getLblindigorenttype());
		         par.put("lblindigorate",rentalbean.getLblindigorate());
		         par.put("lblindigodiscount",rentalbean.getLblindigodiscount());
		        
		         par.put("companyname",rentalbean.getCompanyname());
		         par.put("address",rentalbean.getAddress());
		         par.put("lbltel1",rentalbean.getMobileno());
		         par.put("Fax",rentalbean.getFax());
		         par.put("barnchval",rentalbean.getBarnchval());   
		         par.put("location",rentalbean.getLocation());
		         par.put("visano",rentalbean.getVisano());
		         par.put("visaexp",rentalbean.getVisaexp());
		         par.put("openuser",rentalbean.getUserid());
		         
		         }
		         if(agmtype.equalsIgnoreCase("LAG")) {
		        
		        	 par.put("showbnd","1");
		        	 par.put("testparam","LEASE AGREEMENT");
		        	 par.put("cardno",leasebean.getLblcosmocreditcardno());
				     par.put("formdesc",leasebean.getLbldesc());
				     par.put("insex",leasebean.getExcessinsu());
		        	 par.put("rentaldoc",leasebean.getRentaldoc());
			         par.put("barnchal",leasebean.getBarnchval());
			         par.put("lblindigocldocno",leasebean.getLblindigocldocno());
			         par.put("clname",leasebean.getClname());
			         par.put("lblindigonationality",leasebean.getLblindigonationality());
			         par.put("claddress",leasebean.getCladdress());
			         par.put("clmobno",leasebean.getClmobno());
			         par.put("clemail",leasebean.getClemail());
			         par.put("radrname",leasebean.getRadrname());
			         par.put("radlno",leasebean.getRadlno());
			         par.put("lblaccount","0");
			         par.put("passno",leasebean.getPassno());
			         par.put("passexpdate",leasebean.getPassexpdate());
			         par.put("dobdate",leasebean.getDobdate());
			         par.put("lblidno",leasebean.getLblidno());
			         par.put("lblvisaexp",leasebean.getLblvisaexp());
			         par.put("adddrname1",leasebean.getAdddrname1());
			         par.put("lblindigoaddnationality",leasebean.getLblindigoaddnationality());
			         par.put("addlicno1",leasebean.getAddlicno1());
			         par.put("lblindigoaddmobile",leasebean.getLblindigoaddmobile());
			         par.put("expdate1",leasebean.getExpdate1());
			         par.put("adddob1",leasebean.getAdddob1());
			         par.put("cardtype",leasebean.getCardtype());
			         par.put("preauthamt","0");
			         par.put("ravehname",leasebean.getRavehname());
			         par.put("racolor",leasebean.getRacolor());
			         par.put("lblcosmofleetno",leasebean.getLblcosmofleetno());
			         par.put("ravehregno",leasebean.getRavehregno());
			         par.put("rayom",leasebean.getRayom());
			         par.put("ravehgroup",leasebean.getRavehgroup());
			         par.put("outdetails",leasebean.getOutdetails());
			         par.put("radateout",leasebean.getRadateout());
			         par.put("ratimeout",leasebean.getRatimeout());
			         par.put("raklmout",leasebean.getRaklmout());
			         par.put("rafuelout",leasebean.getRafuelout());
			         par.put("deldates",leasebean.getDeldates());
			         par.put("deltimes",leasebean.getDeltimes());
			         par.put("delkmins",leasebean.getDelkmins());
			         par.put("delfuels",leasebean.getDelfuels());
			         par.put("lblindigonettotal",leasebean.getLblindigonettotal());
			         par.put("racdwscdw",leasebean.getRacdwscdw());
			         par.put("lblpai",leasebean.getLblpai());
			         par.put("raaccessory",leasebean.getRaaccessory());
			         par.put("rasupercdw",leasebean.getRasupercdw());
			         par.put("lblchafcharge",leasebean.getLblchafcharge());
			         par.put("raextrakm",leasebean.getRaextrakm());
			         par.put("raextrakmchg",leasebean.getRaexxtakmchg());
			         par.put("securitypreauthamount",leasebean.getSecuritypreauthamt());
			         par.put("lblindigorenttype",leasebean.getLblindigorenttype());
			         par.put("lblindigorate",leasebean.getLblindigorate());
			         par.put("lblindigodiscount",leasebean.getLblindigodiscount());
			         
			         par.put("companyname",leasebean.getCompanyname());
			         par.put("address",leasebean.getAddress());
			         par.put("lbltel1",leasebean.getMobileno());
			         par.put("Fax",leasebean.getFax());
			         par.put("barnchval",leasebean.getBarnchval());   
			         par.put("location",leasebean.getLocation());
			         par.put("visano",leasebean.getVisano());
			         par.put("visaexp",leasebean.getVisaexp());
			         par.put("openuser",leasebean.getUserid());
		         }
		         
		         int appPrintConfig=0;
		         String strprintconfig="select method from gl_config where field_nme='AppPrintRA'";
		         ResultSet rsprintconfig=stmt.executeQuery(strprintconfig);
		         while(rsprintconfig.next()) {
		        	 appPrintConfig=rsprintconfig.getInt("method");
		         }
		         
		         if(appPrintConfig==0) {
		        	 par.put("showbnd","0");
		         }
		         else if(appPrintConfig>0) {
		        	 if(agmtype.trim().equalsIgnoreCase("RAG") || agmtype.trim().equalsIgnoreCase("LAG")) {
		        		 par.put("showbnd","1");
		        	 }
		        	 else if(agmtype.trim().equalsIgnoreCase("REP") ||  agmtype.equalsIgnoreCase("RPL")) {
		        		 par.put("showbnd","2");
		        	 }
		         }
		         
		        /* interior=beannew.getInterior();
		         if(interior!=null){
		         interior=interior.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotintr",interior);
		         
		         back=beannew.getBack();
		         if(back!=null){
		         back=back.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotbck",back);
		         
		         front=beannew.getFront();
		         if(front!=null){
		         front=front.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotfrnt",front);
		         left=beannew.getLeft();
		         if(left!=null){
		         left=left.replace("\\", "\\\\");
		         }
		         //System.out.println("left====="+ left);
		         par.put("refimgscrnshotleft", left);
		         right=beannew.getRight();
		         if(right!=null){
		         right=right.replace("\\", "\\\\");
		         }
		         //System.out.println("right====="+ right);
		         par.put("refimgscrnshotright",right );*/
		     	
		         par.put("signdate",bean.getLbldate());
		         String sign=beansign.getSignature();
		         if(sign!=null){
		          sign=sign.replace("\\", "\\\\"); 
		         }
		        System.out.println("signature====="+ sign);
		         par.put("signature",sign);
		         ArrayList<String> appPicsArray=inspectionDAO.getAppInspectionPrintPics(inspdoc, request.getParameter("lblurl"),agmtno,agmtype);
		         if(appPicsArray.size()>0) {
		        	 par.put("showdet1","1");
		         }
		         for(int i=0,j=0;i<appPicsArray.size();i++,j++){
		        	String temp=appPicsArray.get(i);
		        	//System.out.println("Array Pic:"+temp);
		        	if(temp!=null){
						temp=temp.replace("\\", "\\\\");
		        	}
					if(i==0 || i==4 || i==8 || i==12 || i==16){
						j=0;
					}
		        		// System.out.println("refimg"+(i+1)+temp);
			        if(i<4){
			        	
						par.put("refimgleft"+(j+1),temp);
			        }
					else if(i>=4 && i<8){
						par.put("refimgright"+(j+1),temp);
					}
					else if(i>=8 && i<12){
						par.put("refimgfrnt"+(j+1),temp);
					}
					else if(i>=8 && i<12){
						par.put("showdet2","1");
						par.put("refimgbck"+(j+1),temp);
					}
					else if(i>=12 && i<16){
						par.put("showdet3","1");
						par.put("refimgintr"+(j+1),temp);
					}	
					else if(i>=16 && i<20){
						par.put("refimgid"+(j+1),temp);
					}	
		         }
		         //String path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
		         //setUrl(path[1]);
		         String printurl=objcommon.getPrintPath("VIP");
		         System.out.println("vradate========"+bean.getVradate());
		         System.out.println("printurl======>"+printurl);
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/vehicletransactions/vehicleinspection/"+printurl));
     	 
     	         JasperReport jasperReport = JasperCompileManager.compileReport(design);
                 //generateReportPDF(response, par, jasperReport, conn);
     	        generateReportPDF(response, par, jasperReport, conn);
     	       //if(agmtype.equalsIgnoreCase("RPL")) {
     	    	  //generateReportEmail(par,jasperReport, conn,remail,bccemail,print,subject,insp+"",agmtype,chkrplno,chkrplbrhid);
    	        //}
    	        //else {
    	        	//generateReportEmail(par,jasperReport, conn,remail,bccemail,print,subject,insp+"",agmtype,agmtno,getLblagmtbrhid());
    	        //}
             } catch (Exception e) {
                 e.printStackTrace();
             }
             finally{
            	conn.close();
             }	  	 
		  
		  return "print"; 
	  }
	  
	  public String mobilePrintAction2() throws ParseException, SQLException{
		 // System.out.println("mobileprint=====");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
		  String front="1",left="1",right="1",back="1",interior="1";
			String insp=request.getParameter("insp");
			String agmtno=request.getParameter("agmtno");
			String agmtype=request.getParameter("agmtype");
			int inspdoc=Integer.parseInt(insp);
			String remail="",bccemail="",print="1",subject="Vehicle Inspection Sheet";
			bean=inspectionDAO.getPrint(inspdoc);
			/*beannew=inspectionDAO.getUser(inspdoc);*/
			beansign=inspectionDAO.getSignature(inspdoc);
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblbranch(bean.getLblbranch());
			setLbldocno(bean.getLbldocno());
			setLbldate(bean.getLbldate());
			setLbltime(bean.getLbltime());
			setLbltype(bean.getLbltype());
			setLblreftype(bean.getLblreftype());
			setLblrefdocno(bean.getLblrefdocno());
			setLblreffleetno(bean.getLblreffleetno());
			setLblaccident(bean.getLblaccident());
			setLblaccdate(bean.getLblaccdate());
			setLblprcs(bean.getLblprcs());
			setLblcoldate(bean.getLblcoldate());
			setLblplace(bean.getLblplace());
			setLblfines(bean.getLblfines());
			setLblclaim(bean.getLblclaim());
			setLblcoldate(bean.getLblcoldate());
			setLblremarks(bean.getLblremarks());
			setLblamount(bean.getLblamount());
			setLblfleetname(bean.getLblfleetname());
			setLblregno(bean.getLblregno());
			setLblprintname("Vehicle Inspection");
			remail=bean.getClientmail();
			
			// System.out.println("client mail addresss======="+remail);
			 HttpServletResponse response = ServletActionContext.getResponse();
			 par = new HashMap();
			 
			 Connection conn = null;
			 
			 try {
		          
             	 conn = objconn.getMyConnection();
               	
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/yessureheader.png");
	        	 imgpath=imgpath.replace("\\", "\\\\");    
	             //System.out.println("cmplogo====="+imgpath);
	             //System.out.println("lbldocno====="+bean.getLbldocno());
	             //System.out.println("lbldate====="+bean.getLbldate());
	             //System.out.println("lbltime====="+bean.getLbltime());
	             //System.out.println("lbltype====="+bean.getLbltype());
	             //System.out.println("lblreftype====="+bean.getLblreftype());
	             //System.out.println("lblrefdocno====="+bean.getLblrefdocno());
	             //System.out.println("lblreffleetno====="+bean.getLblreffleetno());
	             //System.out.println("lblregno====="+ bean.getLblregno());
	             //System.out.println("lblfleetname====="+bean.getLblfleetname());
	             //System.out.println("lblamount====="+bean.getLblamount());
	             //System.out.println("username====="+  beannew.getUsername());
	             
	            
	             //System.out.println("right====="+beannew.getRight());
	             //System.out.println("imgpath====="+imgpath);
	             String doc=bean.getLbldocno();
	        	 par.put("imgheader", imgpath);
	        	/* par.put("lbldocno",doc );	
				 par.put("lbldate", bean.getLbldate());		        
		         par.put("lbltime", bean.getLbltime());
		         par.put("lbltype", bean.getLbltype());			       
		         par.put("lblreftype", bean.getLblreftype());
		         par.put("lblrefdocno", bean.getLblrefdocno());
		         par.put("lblreffleetno", bean.getLblreffleetno());
		         par.put("lblregno", bean.getLblregno());
		         par.put("lblfleetname", bean.getLblfleetname());
		         
		         par.put("lblamount",bean.getLblamount());
		         par.put("date", bean.getLbldate());
		         par.put("time", bean.getLbltime());*/
		         par.put("orderno", doc);
		         par.put("clientid", bean.getLblclientid());
		         par.put("client", bean.getLblrefdocno());
		         par.put("mob", bean.getLblclntmob());
		         par.put("email", bean.getClientmail());
		         par.put("address", bean.getLblcompaddress());
		         par.put("driver", bean.getLbldriver());
		         par.put("address", bean.getLblcompaddress());
		         par.put("driver", bean.getLbldriver());
		         par.put("drivmob", bean.getLbldrivermob());
		         par.put("drivdob", bean.getLbldriverdob());
		         par.put("drivdlno", bean.getLbldriverdlno());
		         par.put("regno", bean.getLblregno());
		         par.put("pltcode", bean.getLblpltcode());
		         par.put("outdate", bean.getLbldout());
		         par.put("outtime", bean.getLbltout());
		         par.put("outkm", bean.getLblkmout());
		         par.put("outfuel", bean.getLblfout());
		         par.put("outby", bean.getLbloutby());
		         par.put("custname", bean.getLblrefdocno());
		        
		         
		        /* interior=beannew.getInterior();
		         if(interior!=null){
		         interior=interior.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotintr",interior);
		         
		         back=beannew.getBack();
		         if(back!=null){
		         back=back.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotbck",back);
		         
		         front=beannew.getFront();
		         if(front!=null){
		         front=front.replace("\\", "\\\\");
		         }
		         //System.out.println("base====="+base);
		         par.put("refimgscrnshotfrnt",front);
		         left=beannew.getLeft();
		         if(left!=null){
		         left=left.replace("\\", "\\\\");
		         }
		         //System.out.println("left====="+ left);
		         par.put("refimgscrnshotleft", left);
		         right=beannew.getRight();
		         if(right!=null){
		         right=right.replace("\\", "\\\\");
		         }
		         //System.out.println("right====="+ right);
		         par.put("refimgscrnshotright",right );*/
		     	
		         par.put("signdate",bean.getLbldate());
		         String sign=beansign.getSignature();
		         if(sign!=null){
		          sign=sign.replace("\\", "\\\\"); 
		         }
		         //System.out.println("signature====="+ sign);
		         par.put("signature",sign);
				 
				 ArrayList<String> appPicsArray=inspectionDAO.getAppInspectionPrintPics(inspdoc, request.getParameter("lblurl"),agmtno,agmtype);
		         for(int i=0,j=0;i<appPicsArray.size();i++,j++){
		        	String temp=appPicsArray.get(i);
		        	if(temp!=null){
						temp=temp.replace("\\", "\\\\");
		        	}
					if(i==0 || i==4 || i==8 || i==12 || i==16){
						j=0;
					}
		        		 //System.out.println("refimg"+(i+1)+temp);
			        if(i<4){
						par.put("refimgleft"+(j+1),temp);
			        }
					else if(i>=4 && i<8){
						par.put("refimgright"+(j+1),temp);
					}
					else if(i>=8 && i<12){
						par.put("refimgfrnt"+(j+1),temp);
					}
					else if(i>=8 && i<12){
						par.put("showdet2","1");
						par.put("refimgbck"+(j+1),temp);
					}
					else if(i>=12 && i<16){
						par.put("showdet3","1");
						par.put("refimgintr"+(j+1),temp);
					}	
					else if(i>=16 && i<20){
						par.put("refimgid"+(j+1),temp);
					}	
		         }
		         //String path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
		         //setUrl(path[1]);
	    
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/vehicletransactions/vehicleinspection/YessureAppPrint.jrxml"));
     	 
     	         JasperReport jasperReport = JasperCompileManager.compileReport(design);
                 generateReportPDF(response, par, jasperReport, conn);
     	        //generateReportEmail(par,jasperReport, conn,remail,bccemail,print,subject,insp);
      
             } catch (Exception e) {
                 e.printStackTrace();
             }
             finally{
            	conn.close();
             }	  	 
		  
		  
		  return "print"; 
	  }
	  
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
		  bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
			resp.reset();
		  resp.resetBuffer();
		  System.out.println("in generate");
		  resp.setContentType("application/pdf");
		  resp.setContentLength(bytes.length);
		  ServletOutputStream ouputStream = resp.getOutputStream();
		  ouputStream.write(bytes, 0, bytes.length);
		 
		  ouputStream.flush();
		  ouputStream.close();
		                   
	}
	
	
	
	  private void generateReportEmail (Map parameters, JasperReport jasperReport, Connection conn, String remail,String bccemail, String print, String subject,String insp,String agmtype,String agmtno,String agmtbrhid)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  byte[] bytes = null;
        bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
        EmailProcess ep=new EmailProcess();
    	Statement stmtrr=conn.createStatement();
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
    	String fileName="",path="", formcode="VIP",filepath="",path1="",inspbrhid="1"; 
    	String host="", port="", userName="", password="", recipient="", message="please find the attached inspection sheet",docnos="1";
    	
		String inspsql="select brhid from gl_vinspm where doc_no="+insp+"";
  	//	System.out.println("==sqlbrhidinspm=="+inspsql);
  		ResultSet rstst = stmtrr.executeQuery(inspsql);
  		while(rstst.next()) {
  			inspbrhid=rstst.getString("brhid");
  		}
		
		String strSql1 = "select imgPath from my_comp";

  		ResultSet rs1 = stmtrr.executeQuery(strSql1);
  		while(rs1.next ()) {
  			path1=rs1.getString("imgPath");
  		}
  		path=path1.replace("\\", "/");
  		String strSql3 = "select mail,mailpass,smtpserver,smtphostport from my_user where user_id='super'";
		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		while(rs3.next ()) {
			userName=rs3.getString("mail");
			port=rs3.getString("smtphostport");
			host=rs3.getString("smtpserver");
			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
		}
  		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
		
		DateFormat dateFormat2 = new SimpleDateFormat("dd_MM_yyyy");
		java.util.Date date2 = new java.util.Date();
		String currdate2=dateFormat2.format(date2);
		//subject="Fleet status Epic Rent a car "+currdate2+" 8:00";
		subject=subject+"  "+currdate2;
  		fileName = "VehicleInspection"+currdate+".pdf";
  		filepath=path+ "/attachment/"+formcode+"/"+fileName;

  		File dir = new File(path+ "/attachment/"+formcode); 
  		dir.mkdirs();
  		
  		CallableStatement stmtAttach = conn.prepareCall("{ CALL fileAttachApp(?,?,?,?,?,?,?,?,?)}");
  		
  		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
  		
  		System.out.println("CALL fileAttach");
  		stmtAttach.setString(1,"VIP");
  		stmtAttach.setString(2,insp);
  		stmtAttach.setString(3,inspbrhid);
  		stmtAttach.setString(4,"1");
  		stmtAttach.setString(5,path+ "/attachment/"+formcode+"/"+fileName);
  		stmtAttach.setString(6,fileName);
  		stmtAttach.setString(7,"print");
  		stmtAttach.setString(8,"1");
  		
  		int no=stmtAttach.executeUpdate();
  		//no=stmtAttach.getInt(1);
  		
        CallableStatement stmtAttachagmt = conn.prepareCall("{CALL fileAttachApp(?,?,?,?,?,?,?,?,?)}");
  		
        stmtAttachagmt.registerOutParameter(9, java.sql.Types.INTEGER);
       
  		System.out.println("CALL fileAttach Agmt");
  		
  		stmtAttachagmt.setString(1,agmtype);
  		stmtAttachagmt.setString(2,agmtno);
  		stmtAttachagmt.setString(3,agmtbrhid);
  		stmtAttachagmt.setString(4,"1");
  		stmtAttachagmt.setString(5,path+ "/attachment/"+formcode+"/"+fileName);
  		stmtAttachagmt.setString(6,fileName);
  		stmtAttachagmt.setString(7,"print");
  		stmtAttachagmt.setString(8,"1");
  		
  		int nonw=stmtAttachagmt.executeUpdate();
  		//nonw=stmtAttachagmt.getInt(1);
  		
  		FileOutputStream fos = new FileOutputStream(filepath);
    	fos.write(bytes);
    	fos.flush();  
    	fos.close();
    	
    	File saveFile=new File(filepath);
		SendEmailAction sendmail= new SendEmailAction();
		//String[] remails=remail.split(",");
		if(remail!=null || !remail.equalsIgnoreCase("")) {
		String strinsurexcess="insert into my_appemaillog(doc_no,brhId,dtype,edate,userId,refid,email)values("+insp+",'"+session.getAttribute("BRANCHID").toString()+"','VIP',curdate(),"+session.getAttribute("USERID").toString()+",0,'"+remail+"')";
		System.out.println("==my_appemaillog==insert=="+strinsurexcess);
		int insurval=stmtrr.executeUpdate(strinsurexcess);
		if(insurval<=0){
			conn.close();
		
		}
		}
		ep.sendEmailwithpdfBCC(host, port, userName, password,remail, "",bccemail,subject, message, saveFile,docnos);
           
  }
	
}
	
		
	

