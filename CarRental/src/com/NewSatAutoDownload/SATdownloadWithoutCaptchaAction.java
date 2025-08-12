package com.NewSatAutoDownload;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import javax.imageio.ImageIO;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.NewSatDownload.SATdownloadDAO;
import com.common.ClsCommon;
import com.connection.ClsConnection;


public class SATdownloadWithoutCaptchaAction  extends TimerTask {
    
	private static final Logger log = Logger.getLogger( SATdownloadWithoutCaptchaAction.class.getName() );
	ClsCommon objcommon=new ClsCommon();
	SATdownloadDAO dao=new SATdownloadDAO();
	private static final String JAVASCRIPT_SRC = 
			" var impl = { " +
					"     run: function() { " +
					"         println ('Hello, World!'); " +
					"     } " +
					" }; ";
 
	private String category="";
	private String hiddencategory="";
	private String chck_salikautomatic="";
	private String cmbsaliksite="";
	private String hidcmbsaliksite="";
	private String cmbtype="ldays";
	private String hidcmbtype="";
	private String jqxStartDate="";
	private String jqxEndDate="";
	private String hidjqxStartDate="";
	private String hidjqxEndDate="";
	private String txtusername="";
	private String txtsalikfleetno="";
	private String txtsalikregno="";
	private String txtsaliktagno="";
	private String docs="0";
	private String captcha="";
	//private boolean radio_traffic=false;
	private String chck_trafficautomatic="";
	private String cmbtrafficsite="";
	private String hidcmbtrafficsite="";
	private String chck_trafficfileno="";
	private String txttrafficplateno="";
	private String txtsalikplatecode="";
	private String txttrafficcategory="";
	private String txttrafficauthority="";
	private String captchapath="";
	private int captchacount=0;
	private int iscaptcha=0;
	private String txtdescription="";
	private String captchatxt;
	private String msg;
	private int iscaptchaloaded=0;
	private String hidChck_trafficfileno="";
	private String txttrafficpsource;
	private String txttrafficpsourceid;
	private String txttrafficpcolor;
	private String txttrafficpcolorid;
	private String txttrafficptype;
	private String txttrafficptypeid;
	private String txttrafficpno;
	private int chck_salikpdata;
	private String cmbyear;
	
	
	public String getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(String cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getChck_salikpdata() {
		return chck_salikpdata;
	}
	public void setChck_salikpdata(int chck_salikpdata) {
		this.chck_salikpdata = chck_salikpdata;
	}
	public String getTxttrafficpno() {
		return txttrafficpno;
	}
	public void setTxttrafficpno(String txttrafficpno) {
		this.txttrafficpno = txttrafficpno;
	}
	public String getTxttrafficpsource() {
		return txttrafficpsource;
	}
	public void setTxttrafficpsource(String txttrafficpsource) {
		this.txttrafficpsource = txttrafficpsource;
	}
	public String getTxttrafficpsourceid() {
		return txttrafficpsourceid;
	}
	public void setTxttrafficpsourceid(String txttrafficpsourceid) {
		this.txttrafficpsourceid = txttrafficpsourceid;
	}
	public String getTxttrafficpcolor() {
		return txttrafficpcolor;
	}
	public void setTxttrafficpcolor(String txttrafficpcolor) {
		this.txttrafficpcolor = txttrafficpcolor;
	}
	public String getTxttrafficpcolorid() {
		return txttrafficpcolorid;
	}
	public void setTxttrafficpcolorid(String txttrafficpcolorid) {
		this.txttrafficpcolorid = txttrafficpcolorid;
	}
	public String getTxttrafficptype() {
		return txttrafficptype;
	}
	public void setTxttrafficptype(String txttrafficptype) {
		this.txttrafficptype = txttrafficptype;
	}
	public String getTxttrafficptypeid() {
		return txttrafficptypeid;
	}
	public void setTxttrafficptypeid(String txttrafficptypeid) {
		this.txttrafficptypeid = txttrafficptypeid;
	}
	public String getHidChck_trafficfileno() {
		return hidChck_trafficfileno;
	}
	public void setHidChck_trafficfileno(String hidChck_trafficfileno) {
		this.hidChck_trafficfileno = hidChck_trafficfileno;
	}
	public int getIscaptchaloaded() {
		return iscaptchaloaded;
	}
	public void setIscaptchaloaded(int iscaptchaloaded) {
		this.iscaptchaloaded = iscaptchaloaded;
	}
	public String getTxtsalikregno() {
		return txtsalikregno;
	}
	public void setTxtsalikregno(String txtsalikregno) {
		this.txtsalikregno = txtsalikregno;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getIscaptcha() {
		return iscaptcha;
	}
	public void setIscaptcha(int iscaptcha) {
		this.iscaptcha = iscaptcha;
	}
	public int getCaptchacount() {
		return captchacount;
	}
	public void setCaptchacount(int captchacount) {
		this.captchacount = captchacount;
	}
	public String getCaptchapath() {
		return captchapath;
	}
	public void setCaptchapath(String captchapath) {
		this.captchapath = captchapath;
	}
	public String getCaptchatxt() {
		return captchatxt;
	}
	public void setCaptchatxt(String captchatxt) {
		this.captchatxt = captchatxt;
	}
	public String getCaptcha() {
		return captcha;
	}
	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}
	public String getHiddencategory() {
		return hiddencategory;
	}
	public void setHiddencategory(String hiddencategory) {
		this.hiddencategory = hiddencategory;
	}
	public String getDocs() {
		return docs;
	}
	public void setDocs(String docs) {
		this.docs = docs;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	//	public boolean isCategory() {
	//		return category;
	//	}
	//	public void setCategory(boolean category) {
	//		this.category = category;
	//	}

	public String getChck_salikautomatic() {
		return chck_salikautomatic;
	}
	public void setChck_salikautomatic(String chck_salikautomatic) {
		this.chck_salikautomatic = chck_salikautomatic;
	}
	public String getCmbsaliksite() {
		return cmbsaliksite;
	}
	public void setCmbsaliksite(String cmbsaliksite) {
		this.cmbsaliksite = cmbsaliksite;
	}
	public String getHidcmbsaliksite() {
		return hidcmbsaliksite;
	}
	public void setHidcmbsaliksite(String hidcmbsaliksite) {
		this.hidcmbsaliksite = hidcmbsaliksite;
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
	public String getJqxStartDate() {
		return jqxStartDate;
	}
	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}
	public String getJqxEndDate() {
		return jqxEndDate;
	}
	public void setJqxEndDate(String jqxEndDate) {
		this.jqxEndDate = jqxEndDate;
	}
	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}
	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}
	public String getHidjqxEndDate() {
		return hidjqxEndDate;
	}
	public void setHidjqxEndDate(String hidjqxEndDate) {
		this.hidjqxEndDate = hidjqxEndDate;
	}
	public String getTxtusername() {
		return txtusername;
	}
	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}
	public String getTxtsalikfleetno() {
		return txtsalikfleetno;
	}
	public void setTxtsalikfleetno(String txtsalikfleetno) {
		this.txtsalikfleetno = txtsalikfleetno;
	}
	public String getTxtsaliktagno() {
		return txtsaliktagno;
	}
	public void setTxtsaliktagno(String txtsaliktagno) {
		this.txtsaliktagno = txtsaliktagno;
	}
	public void setChck_trafficautomatic(String chck_trafficautomatic) {
		this.chck_trafficautomatic = chck_trafficautomatic;
	}
	private String getChck_trafficautomatic() {
		// TODO Auto-generated method stub
		return  chck_trafficautomatic;
	}
	public String getCmbtrafficsite() {
		return cmbtrafficsite;
	}
	public void setCmbtrafficsite(String cmbtrafficsite) {
		this.cmbtrafficsite = cmbtrafficsite;
	}
	public String getHidcmbtrafficsite() {
		return hidcmbtrafficsite;
	}
	public void setHidcmbtrafficsite(String hidcmbtrafficsite) {
		this.hidcmbtrafficsite = hidcmbtrafficsite;
	}
	public String getChck_trafficfileno() {
		return chck_trafficfileno;
	}
	public void setChck_trafficfileno(String chck_trafficfileno) {
		this.chck_trafficfileno = chck_trafficfileno;
	}
	public String getTxttrafficplateno() {
		return txttrafficplateno;
	}
	public void setTxttrafficplateno(String txttrafficplateno) {
		this.txttrafficplateno = txttrafficplateno;
	}
	public String getTxtsalikplatecode() {
		return txtsalikplatecode;
	}
	public void setTxtsalikplatecode(String txtsalikplatecode) {
		this.txtsalikplatecode = txtsalikplatecode;
	}
	public String getTxttrafficcategory() {
		return txttrafficcategory;
	}
	public void setTxttrafficcategory(String txttrafficcategory) {
		this.txttrafficcategory = txttrafficcategory;
	}
	public String getTxttrafficauthority() {
		return txttrafficauthority;
	}
	public void setTxttrafficauthority(String txttrafficauthority) {
		this.txttrafficauthority = txttrafficauthority;
	}


	static String url="",urldet="",tcno1="";
	static int qudraconfig=0;//For Downloading all saliks irrespective of amount
	String ts="",pass="";
	static String browser="chrome";
	WebDriver driver=null;
	private static ChromeDriverService service;
	String defaultwindow = "";
	String popupwindow = "";
	Document docDet,doc;
	boolean flag=false;
	String fineno="",dat="0",time="",curPage="0",timeappend="",salik_fdate="" ;
	String [] tformat=new String[10];
	int txtStPage=1;
	int rollno=1;
    int srno=0,xsasrno,xsadoc=0,serno=0,xdoc=0;
	int dno=0,excaptcha=0,rtalogin=0;
	String xdocs="0";
	String branch="";
	String SATEXCELCONFIG="0",SATEXCEL="";
	long startTime=0,endTime=0;
	ClsConnection connobj=new  ClsConnection();
	
	ClsCommon com= new ClsCommon();

	public String downloadProcess(Connection conn) throws ParseException, SQLException{
	   // System.out.println("Inside WithoutCaptcha Process");
		boolean result=false;
		try{
			HttpServletRequest request=null;
			HttpSession session=null;
			
			try {
				request=ServletActionContext.getRequest();
				session=request.getSession();
			}
			catch(NullPointerException e) {
				//e.printStackTrace();
				System.out.println("Session not available on Auto Download");
			}
		    String curdownload="";
		    if(getCategory().trim().equalsIgnoreCase("traffic")){
		        curdownload="Traffic - "+getCmbtrafficsite()+" - "+getTxttrafficplateno();
		    }
		    else if(getCategory().trim().equalsIgnoreCase("salik")){
		        curdownload="Salik - "+getCmbsaliksite()+" - "+getTxtusername();
		    }

		    if(session!=null) {
		    	session.setAttribute("CURDOWNLOAD", curdownload);
		    }
		    
		    ResultSet rsqudraconfig=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
		    while(rsqudraconfig.next()){
		    	qudraconfig=rsqudraconfig.getInt("method");
		    }
		    String qryapnd="";

			//System.out.println("===== "+getCategory());
			if(getCategory().equalsIgnoreCase("salik")){
				if(cmbsaliksite.equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("salik")){
					setHidcmbsaliksite(getCmbsaliksite());
					if(txtusername==null ||txtusername.equalsIgnoreCase(""))
					{
						qryapnd="and 1=1" ;
					}
					else
					{
						qryapnd="and t.username='"+txtusername+"'";
					}
					ResultSet rssalik;
					try {
						rssalik = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' "+qryapnd+"");							
						while(rssalik.next())
						{	
							ts=rssalik.getString("username");
							pass=rssalik.getString("password");
							excaptcha=rssalik.getInt("iscaptcha");
							setIscaptcha(excaptcha);
							rtalogin=rssalik.getInt("rta");
							url="https://customers.salik.ae/connect/login?lang=en";
						}
						try {

							Statement stmt1 = conn.createStatement();
							
							String strSql1 = "select captchaPath from my_comp where comp_id='1'";
							ResultSet rs1 = stmt1.executeQuery(strSql1);
							
							while(rs1.next ()) {
								setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");
							}

							result=loadfresh(conn,session);
							if(result==true)
							{
							    driver.quit();
							}
							setHiddencategory(getCategory());
						} catch (IOException e) {
							e.printStackTrace();
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}



				}
				if(getCmbsaliksite().equalsIgnoreCase("AUH")){
					if(txtusername!=null && !txtusername.equalsIgnoreCase("")){
						qryapnd="and t.username='"+txtusername+"'";
					}
					
					ResultSet rssalikuser = conn.createStatement().executeQuery("Select * from gl_webid t where t.TYPE='U' and t.Desc1='Salik' and t.site='AUH' "+qryapnd+"");
					
					while(rssalikuser.next())
					{	
						ts=rssalikuser.getString("username");
						pass=rssalikuser.getString("password");
						excaptcha=rssalikuser.getInt("iscaptcha");
						setIscaptcha(excaptcha);
						rtalogin=rssalikuser.getInt("rta");
						url="https://darb.itc.gov.ae?lang=en";

					}
					try {

						Statement stmtsalikcaptcha = conn.createStatement();
						
						String strsalikcaptcha = "select captchaPath from my_comp where comp_id=1";
						ResultSet rssalikcaptcha = stmtsalikcaptcha.executeQuery(strsalikcaptcha);
						
						while(rssalikcaptcha.next ()) {
							setCaptchapath(rssalikcaptcha.getString("captchaPath")+"/captcha.png");
						}

						
						result=loadfresh(conn,session);
						if(result==true)
						{
						    driver.quit();
						}
						setHiddencategory(getCategory());
					}
					catch(Exception e){
						e.printStackTrace();
					}
				}



			}
			else if(getCategory().equalsIgnoreCase("traffic"))
			{
				
				int evmconfig=1;
				if(evmconfig==1 && getCmbtrafficsite().equalsIgnoreCase("AUH")){
					String stramountconfig="select method from gl_config where field_nme='trafficdownloadupdated'";
					ResultSet rsamountconfig=conn.createStatement().executeQuery(stramountconfig);
					int amountconfig=0;
					while(rsamountconfig.next()){
						amountconfig=rsamountconfig.getInt("method");
					}
					url="https://evg.ae/default.aspx?ReturnUrl=%2f";
					java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
					java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
				
					String chromepath="";
					ResultSet rsgetchromepath=conn.createStatement().executeQuery("select chromedriverpath from my_comp where doc_no=1");
					while(rsgetchromepath.next()){
						chromepath=rsgetchromepath.getString("chromedriverpath");
					}
					System.setProperty("webdriver.chrome.driver",chromepath);  
					ChromeOptions options=new ChromeOptions();
					options.addArguments("--ignore-certificate-error");
					options.addArguments("--ignore-ssl-errors");
				    driver=new ChromeDriver(options);
					Thread.sleep(1000);
					driver.get(url);
					defaultwindow = driver.getWindowHandle();
					driver.manage().window().maximize();
					Thread.sleep(5000);
					
					//Checking login is enabled for corresponding user
					String strevglogin="select rta,actype,coalesce(reptcn,'') reptcn,password from gl_webid where username='"+getTxttrafficplateno()+"' and (remarks='Traffic Fines' or desc1='Traffic Fines') and site='AUH'";
					int evglogin=0,actype=0;
					String reptcn="",evgpassword="";
					ResultSet rsevglogin=conn.createStatement().executeQuery(strevglogin);
					while(rsevglogin.next()) {
						evglogin=rsevglogin.getInt("rta");
						actype=rsevglogin.getInt("actype");
						reptcn=rsevglogin.getString("reptcn");
						evgpassword=rsevglogin.getString("password");
					}
					ArrayList<String> evmtrafficarray=new ArrayList<>();
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");
					if(rs.next())
					{	
						dno=rs.getInt("max");
						xdoc=dno;
						xdocs=xdocs+","+xdoc;

						if(session!=null) {
							String trafficdocno=session.getAttribute("TRAFFICDOCNO")==null?"":session.getAttribute("TRAFFICDOCNO").toString();
		                    if(!trafficdocno.contains(dno+"")){
		                        if(trafficdocno.trim().equalsIgnoreCase("")){
		                            trafficdocno+=dno;
		                        }
		                        else{
		                            trafficdocno+=","+dno;
		                        }
		                    }
		                    session.setAttribute("TRAFFICDOCNO", trafficdocno);
						}
						
					}
					
					if(evglogin==1) {
						
						try {
							
							driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderSiteName_cphHeader_g_1065475f_c098_4adf_adc8_f9c844bdb3b9_ctl00_btnLogin']/a")).click();
							Thread.sleep(3000);
							
							if(actype==1) {
								WebElement elmactype=driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_rbtnIndividual']"));
								JavascriptExecutor executor = (JavascriptExecutor) driver;
							    executor.executeScript("arguments[0].click();", elmactype); 
								Thread.sleep(2000);
								
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_txtLogin']")).sendKeys(getTxttrafficplateno());
								Thread.sleep(1000);
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_txtPassword']")).sendKeys(evgpassword.trim());
								Thread.sleep(1000);
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_btnLogin']")).click();
								Thread.sleep(3000);
							}
							else if(actype==2) {
								WebElement elmactype=driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_rbtnCompany']"));
								JavascriptExecutor executor = (JavascriptExecutor) driver;
							    executor.executeScript("arguments[0].click();", elmactype);
								Thread.sleep(2000);
								
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_txtCompnayTCF']")).sendKeys(getTxttrafficplateno());
								Thread.sleep(1000);
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_txtLogin']")).sendKeys(reptcn);
								Thread.sleep(1000);
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_txtPassword']")).sendKeys(evgpassword);
								Thread.sleep(1000);
								driver.findElement(By.xpath("//*[@id='ctl00_cphScrollMenu_btnLogin']")).click();
								Thread.sleep(3000);
							}
							
							driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderHeader_header1_liTrafficProfile']/a")).click();
							Thread.sleep(2500);
							
							driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderLeftContent_LeftFile1_lmenuTrafficProfilesFines']/a")).click();
							Thread.sleep(3000);
							
							int tablesize=driver.findElements(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr")).size();
							setDocs(String.valueOf(xdocs));
							
							for(int i=tablesize,j=1;i>=2;i--,j++) {
								System.out.println("i="+i);
								WebElement elmdet=driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr["+i+"]/td[11]/img"));
								String modaltarget=elmdet.getAttribute("data-target");
								
								String amount="";
								if(amountconfig==1){
									amount=driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr["+i+"]/td[6]/span")).getText();
								}
								else{
									amount=driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr["+i+"]/td[8]/span")).getText();
								}
								String baseticketno=driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr["+i+"]/td[2]/span")).getText();
								/*String trafficdate=driver.findElement(By.xpath("//*[@id='ctl00_PlaceHolderRightContent1_TrafficProfileFines1_ctl00_gvTickets']/tbody/tr["+i+"]/td[3]/span")).getText();
								SimpleDateFormat datedisplayFormat = new SimpleDateFormat("dd-MM-yyyy");
                                java.util.Date date = datedisplayFormat.parse(trafficdate);
                                java.sql.Date sqltrafficdate = new java.sql.Date(date.getTime());
                                java.sql.Date onemonthbeforedate=getOneMonthBeforeDate(conn);
                                */
                                
								boolean ticketpresent=dao.checkTrafficExist(conn,amount,baseticketno);
								/*if(sqltrafficdate.compareTo(onemonthbeforedate)<0 && ticketpresent==true) {
									System.out.println("Dropping Download Browser ,Traffics are 1 month old");
									//driver.quit();
									break;
								}*/
								if(ticketpresent==false){
								    modaltarget=modaltarget.replace("#","");
	                                WebElement elmmodal=driver.findElement(By.id(modaltarget));
	                                JavascriptExecutor executor = (JavascriptExecutor) driver;
	                                executor.executeScript("arguments[0].click();", elmdet);
	                                Thread.sleep(2000);
	                                driver.switchTo().frame(driver.findElement(By.id("iframeModalPopup")));
	                                Thread.sleep(2000);
	                                WebDriverWait wait = new WebDriverWait(driver,90);
			                        wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblFineNumber']")));
//	                                Thread.sleep(30000);
	                                String ticketno=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblFineNumber']")).getText();
	                                String trafficdate=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblDate']")).getText();
	                                String traffictime=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblTime']")).getText();
	                                String location=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblLocation']")).getText();
	                                String regno=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblPlateNo']")).getText();
	                                String finesource=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblSource']")).getText();
	                                String platesource=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblPlateSource']")).getText();
	                                String platecolor=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_lblPlateColor']")).getText();
	                                String description=driver.findElement(By.xpath("//*[@id='TrafficFinesArchiveDetails1_ctl00_gvMaterialList']/tbody/tr[2]/td[1]")).getText();
	                                //System.out.println(j+":"+ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
	                                evmtrafficarray.add(ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+finesource+"::"+finesource+"::"+platecolor+"::"+amount+"::"+description);
	                                SimpleDateFormat datedisplayFormat = new SimpleDateFormat("dd-MM-yyyy");
									java.util.Date date = datedisplayFormat.parse(trafficdate);
									java.sql.Date sqltrafficdate = new java.sql.Date(date.getTime());
								
	                                
	                                SimpleDateFormat timedisplayFormat = new SimpleDateFormat("HH:mm");
	                                SimpleDateFormat timeparseFormat = new SimpleDateFormat("hh:mm:ss a");
	                                Date strtime = timeparseFormat.parse(traffictime);
	                                @SuppressWarnings("deprecation")
	                                String strhour=(strtime.getHours()<10?"0"+strtime.getHours():strtime.getHours())+"";
	                                String strminutes=(strtime.getMinutes()<10?"0"+strtime.getMinutes():strtime.getMinutes())+"";
	                                String time=strhour+":"+strminutes;
	                                tcno1=getTxttrafficplateno();
	                                
	                                dao.trafficInsert(ticketno,sqltrafficdate,time+"",finesource,regno,"",platecolor,"","","",
	                                        Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,j,tcno1,xdoc,sqltrafficdate,branch,platesource,
	                                        getCmbtrafficsite(),"",xdocs,"");
	                                
	                                driver.switchTo().defaultContent();
	                                
	                                WebElement elmclose=driver.findElement(By.xpath("//*[@id='myModalPopup']/div/div/div[1]/button"));
	                                JavascriptExecutor closeexecutor = (JavascriptExecutor) driver;
	                                closeexecutor.executeScript("arguments[0].click();", elmclose);
	                             
	                                Thread.sleep(1000);
								}
								
							    
							}
						}
						catch(Exception e) {
							e.printStackTrace();
						}
						
					}
					else {
						driver.findElement(By.xpath("//*[@id='popservices-menu-div']/ul/a[2]")).click();
						Thread.sleep(5000);
						JavascriptExecutor js = (JavascriptExecutor) driver;
						js.executeScript("window.scrollBy(0,150)");
						driver.findElement(By.id("ctl00_cphScrollMenu_ctl00_ctl00_txtSearchTcfNo")).sendKeys(getTxttrafficplateno());
						driver.findElement(By.id("ctl00_cphScrollMenu_ctl00_ctl00_btnSearchTCF")).click();
						
						Thread.sleep(5000);
						Document doc=Jsoup.parse(driver.getPageSource());
						Elements finerows=doc.select("table[id=ctl00_cphScrollMenu_gettickets1_ctl00_gvTickets]").select("tbody").get(0).select("tr");

						setDocs(String.valueOf(xdocs));

						for(int i=finerows.size()-1,j=1;i>0;i--,j++){
							String tickethtml=finerows.get(i).select("td").get(1).select("a").first().outerHtml();
							String ticketno=tickethtml.split("TicketNo=")[1].split("'")[0];
							
							String amount="";
							if(amountconfig==1){
								amount=finerows.get(i).select("td").get(5).select("span").first().text();
							}
							else{
								amount=finerows.get(i).select("td").get(7).select("span").first().text();
							}
							driver.get("https://evg.ae/_layouts/EVG/ticketdetails.aspx?language=en&Type=Tickets&Page=0&TicketNo="+ticketno);
							Thread.sleep(5000);
							while(!(driver.getPageSource().contains("maroonTable"))){
//								System.out.println("Inside Extra Wait");
								Thread.sleep(5000);
							}
							Document subdoc=Jsoup.parse(driver.getPageSource());
							
							String trafficdate=subdoc.select("table[class=maroonTable]").first().select("tr").get(2).select("td").get(1).select("span").first().text();
							String traffictime=subdoc.select("table[class=maroonTable]").first().select("tr").get(3).select("td").get(1).select("span").first().text();
							String location=subdoc.select("table[class=maroonTable]").first().select("tr").get(7).select("td").get(1).select("span").first().text();
//							System.out.println("Location:"+location);
							String regno=subdoc.select("table[class=maroonTable]").first().select("tr").get(8).select("td").get(1).select("span").first().text();
							String source=subdoc.select("table[class=maroonTable]").first().select("tr").get(10).select("td").get(1).select("span").first().text();
							String platecolor=subdoc.select("table[class=maroonTable]").first().select("tr").get(11).select("td").get(1).select("span").first().text();
							String description=subdoc.select("table[id=ticketdetails1_ctl00_gvMaterialList]").first().select("tr").get(1).select("td").get(0).text();
//							System.out.println("1:"+ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
							evmtrafficarray.add(ticketno+"::"+trafficdate+"::"+traffictime+"::"+location+"::"+regno+"::"+source+"::"+platecolor+"::"+amount+"::"+description);
							SimpleDateFormat datedisplayFormat = new SimpleDateFormat("dd-MM-yyyy");
							java.util.Date date = datedisplayFormat.parse(trafficdate);
							java.sql.Date sqltrafficdate = new java.sql.Date(date.getTime());
							
							SimpleDateFormat timedisplayFormat = new SimpleDateFormat("HH:mm");
						    SimpleDateFormat timeparseFormat = new SimpleDateFormat("hh:mm:ss a");
						    Date strtime = timeparseFormat.parse(traffictime);
						    @SuppressWarnings("deprecation")
						    String strhour=(strtime.getHours()<10?"0"+strtime.getHours():strtime.getHours())+"";
						    String strminutes=(strtime.getMinutes()<10?"0"+strtime.getMinutes():strtime.getMinutes())+"";
							String time=strhour+":"+strminutes;
						    tcno1=getTxttrafficplateno();
						     //Fine Source was inserted same as plate source,cuz fine source is not available in EVG site.So inserting as "" on 03-08-2019 onwards(Progress Request)
						    dao.trafficInsert(ticketno,sqltrafficdate,time+"","",regno,"",platecolor,"","","",
									Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,j,tcno1,xdoc,sqltrafficdate,branch,source,
									getCmbtrafficsite(),"",xdocs,"");
						
						}
					}

					driver.quit();
					return "success";
				}
				
				
				
				
				
				
				if(!(getChck_trafficfileno()==null))
				{
					setHidChck_trafficfileno(getChck_trafficfileno());
					if(getChck_trafficfileno().equalsIgnoreCase("trafficfileno")){
						//						System.out.println("==getCmbtrafficsite()==="+getCmbtrafficsite());
						if(getCmbtrafficsite().equalsIgnoreCase("DXB")&&getCategory().equalsIgnoreCase("traffic")){
							try{
								String fileno="";

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}
								if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
								
								}
								
								int umsconfig=0;
								String strumsconfig="select method from gl_config where field_nme='UMSConfig'";
								ResultSet rsumsconfig=conn.createStatement().executeQuery(strumsconfig);
								while(rsumsconfig.next()){
									umsconfig=rsumsconfig.getInt("method");
								}
								
								// url="https://www.rta.ae/wps/portal/rta/ae/home?lang=en";
								if(umsconfig==1){
									url="https://ums.rta.ae/violations/public-fines/fines-search";
								}
								else{
									url="https://www.rta.ae/wps/myportal/rta/ae/home/dashboard?lang=en";
								}
								
								
								try{
									//	MyApp.frmMain.descriptionPane.setText(MyApp.frmMain.descriptionPane.getText()+"\n"+"Loading...\n\nURL:"+url+"\n");
									loadfresh(conn,session);
								}catch (Exception ec) {
									ec.printStackTrace();
									}					   

							}catch(Exception ex){
								ex.printStackTrace();
							}

						}
						else if(getCmbtrafficsite().equalsIgnoreCase("AUH")&&getCategory().equalsIgnoreCase("traffic")){

							try{
								String fileno="";

								if(!(getTxttrafficplateno().equals(""))){
									fileno="and t.username='"+getTxttrafficplateno()+"'";
								}
								else{
									fileno="and 1=1";

								}

								ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								//								System.out.println("Select * from gl_webid t where t.site='AUH' "+fileno+"");

								while(rstraffic.next())
								{
									ts=rstraffic.getString("username");
									
									excaptcha=rstraffic.getInt("iscaptcha");
									setIscaptcha(excaptcha);
									
									url="https://es.adpolice.gov.ae/TrafficServices/FinesPublic/Inquiry.aspx?Culture=en";
									
									if(getTxttrafficpno()!=null && Integer.parseInt(getTxttrafficpno())>0){
										url="https://es.adpolice.gov.ae/trafficservices/FinesPublic/InquiryResult.aspx?TS="+rstraffic.getString("username")+"&PN="+getTxttrafficpno()+"&PS="+getTxttrafficpsourceid()+"&PC="+getTxttrafficpcolorid()+"&PK=1&IT=PI&Culture=en";
									}

									try{
										loadfresh(conn,session);
									}catch (Exception ec) {
										ec.printStackTrace();										
									}					   

								}
								rstraffic.close();
								
							}catch(Exception ex){
								ex.printStackTrace();
							}

						}

					}}


			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			reloaddata();
			setCmbsaliksite(getCmbsaliksite());
			setCmbtype(getCmbtype());
			String  path="";
			Statement stmt1 = conn.createStatement();
			String strSql1 = "select captchaPath from my_comp where comp_id='1'";
			//System.out.println("==strSql1===="+strSql1);
			ResultSet rs1 = stmt1.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("captchaPath");

			}

			String imgPath = path+"/captcha.png";

			try
			{
				File temp=new File(imgPath);
				if (temp.exists()){


					temp.delete();

				}
			}
			catch(Exception e){
				e.printStackTrace();

			}
			//driver.quit();
		}

		return "success";
	}



	public boolean loadfresh(Connection conn,HttpSession session) throws IOException, InterruptedException, SQLException
	{
		boolean result=false;
		try{
			String chromepath="";
			java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
			java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);

			ResultSet resultSET = conn.createStatement().executeQuery("select method from gl_config where field_nme='SATSALIKEXCELDOWNLOAD'");

			while(resultSET.next()) {
				SATEXCELCONFIG=resultSET.getString("method");
			}
			if(SATEXCELCONFIG.equalsIgnoreCase("2") && getCategory().equalsIgnoreCase("salik")){
				
				ResultSet rsconfig = conn.createStatement().executeQuery("Select sitecheck from gl_webid t where t.username='"+getTxtusername()+"' ");
				while(rsconfig.next()){
					SATEXCELCONFIG=rsconfig.getString("sitecheck");
				}
			}
			
			ResultSet rsgetchromepath=conn.createStatement().executeQuery("select chromedriverpath from my_comp where doc_no=1");
			while(rsgetchromepath.next()){
				chromepath=rsgetchromepath.getString("chromedriverpath");
			}
			if(driver!=null) driver.quit();
			ResultSet resultSET1 = conn.createStatement().executeQuery("Select captchapath from my_comp");
		    
            while(resultSET1.next()) {
                SATEXCEL=(resultSET1.getString("captchapath")+"\\SATEXCEL");
            }
			if(SATEXCELCONFIG.equalsIgnoreCase("1") && getCategory().equalsIgnoreCase("salik")) {
				
			
				HashMap<String, Object> chromePrefs = new HashMap<String, Object>();
				chromePrefs.put("profile.default_content_settings.popups", 0);
				chromePrefs.put("download.default_directory", SATEXCEL);
				
				ChromeOptions options = new ChromeOptions();
                options.addArguments("--ignore-certificate-error");
                options.addArguments("--ignore-ssl-errors");
				options.setExperimentalOption("prefs", chromePrefs);
				DesiredCapabilities cap = DesiredCapabilities.chrome();
				cap.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
				cap.setCapability(ChromeOptions.CAPABILITY, options);
				System.setProperty("webdriver.chrome.driver",chromepath); 
				driver = new ChromeDriver(cap);
			}
			else {			
				
				System.setProperty("webdriver.chrome.driver",chromepath);  
	            // Instantiate a ChromeDriver class.  
				ChromeOptions options=new ChromeOptions();
                options.addArguments("--ignore-certificate-error");
                options.addArguments("--ignore-ssl-errors");
			    driver=new ChromeDriver(options);		
			}
			
			
			driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
			driver.get(url);
			driver.manage().window().maximize();
			defaultwindow = driver.getWindowHandle();
			doc= Jsoup.parse(driver.getPageSource());

			if(!(getCmbtrafficsite().equalsIgnoreCase("AUH")))
			{
				result=jsoupGetTableData(1,conn,session);
			}
			
			if(getCategory().equalsIgnoreCase("traffic"))
			{

				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{

					driver.findElement(By.id("ctl00_ContentPlaceHolder1_txtByTcf")).sendKeys(ts);
					inputCaptchaTrafficAUH("Captcha",conn);
					
					int rowsize=1500;
					String rowsizes=driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblNoTickets")).getText();

					/*Vishakh*/
					if(rowsizes.contains("-")) {
						rowsizes=rowsizes.substring(9, rowsizes.indexOf("-"));
						rowsizes=(Integer.parseInt(rowsizes)/50)+1+"";
						rowsize=Integer.parseInt(rowsizes);
					} else {
						driver.quit();
						return false;
					}
					
					for(int i=1;i<=rowsize;i++)
					{
						
						if (driver instanceof JavascriptExecutor) {
							//Thread.sleep(5000);
							((JavascriptExecutor)driver).executeScript("__doPostBack('ctl00$ContentPlaceHolder1$gvTickets','Page$"+i+"');");
						}
							


						WebElement we=null;
						int cnt=0;
						do
						{  
							/*Thread.sleep(10000);*///commented by krish
							
							we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_UpdateProgress1"));
							String style = we.getAttribute("style").trim();

							if (!style.equalsIgnoreCase("display: none;"))
								we=null;
							cnt++;
						}while(we==null && cnt<10);

						url=driver.getCurrentUrl();

						doc= Jsoup.parse(driver.getPageSource());
						if(getCategory().equalsIgnoreCase("traffic"))
							
							result=jsoupGetTableData(i,conn,session);
					}
				}

				if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
				{

					String data="",disc="",Fees="",remark="";
					String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="",location="";
					String [] dateformat=null;
					java.sql.Date traffic_date=null;
					/*
					 * Overridden on 13-04-2019
					 * */
					
					int umsconfig=0;
					String strumsconfig="select method from gl_config where field_nme='UMSConfig'";
					ResultSet rsumsconfig=conn.createStatement().executeQuery(strumsconfig);
					while(rsumsconfig.next()){
						umsconfig=rsumsconfig.getInt("method");
					}
				
					String fileno="";
					if(!(getTxttrafficplateno().equals(""))){
						fileno="and t.username='"+getTxttrafficplateno()+"'";
					}
					else{
						fileno="and 1=1";

					}

					ResultSet rstraffic = conn.createStatement().executeQuery("Select * from gl_webid t where t.site='DXB' and type='F' "+fileno+" ");

					while(rstraffic.next())
					{
						//driver.findElement(By.id("userID")).sendKeys(rstraffic.getString("username"));
						if(umsconfig==0){
							driver.findElement(By.id("username")).sendKeys(rstraffic.getString("username"));
							driver.findElement(By.id("password")).sendKeys(rstraffic.getString("password"));
						}
						
						//Overridden on 03-07-2018
						//driver.findElement(By.id("trafficFileNoId")).sendKeys(rstraffic.getString("tcno"));
						tcno1=rstraffic.getString("tcno");
						//System.out.println("After TCNO");
						excaptcha=rstraffic.getInt("iscaptcha");
						setIscaptcha(excaptcha);

					}
					
					Statement stmt1 = conn.createStatement();
					/*HttpServletRequest request=ServletActionContext.getRequest();
					HttpSession session=request.getSession();*/
					
					String strSql1 = "select captchapath from my_comp where comp_id=1";
					ResultSet rs1 = stmt1.executeQuery(strSql1);
					
					while(rs1.next ()) {
						setCaptchapath(rs1.getString("captchaPath")+"/captcha.png");
					}
					
					String imgPath = getCaptchapath();

					try
					{
						File temp=new File(imgPath);
						if (temp.exists()){


							temp.delete();

						}
					}
					catch(Exception e){
						e.printStackTrace();

					}
					
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");
					if(rs.next())
					{	
						dno=rs.getInt("max");
						xdoc=dno;
						xdocs=xdocs+","+xdoc;

						if(session!=null) {
							String trafficdocno=session.getAttribute("TRAFFICDOCNO")==null?"":session.getAttribute("TRAFFICDOCNO").toString();
		                    if(!trafficdocno.contains(dno+"")){
		                        if(trafficdocno.trim().equalsIgnoreCase("")){
		                            trafficdocno+=dno;
		                        }
		                        else{
		                            trafficdocno+=","+dno;
		                        }
		                    }
		                    session.setAttribute("TRAFFICDOCNO", trafficdocno);
						}
						
					}
					if(umsconfig==1){
						try{
							
							WebDriverWait wait = new WebDriverWait(driver,30);
							wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[1]/div/div/div[4]/div/div")));
							
							driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[1]/div/div/div[4]/div/div")).click();
							driver.findElement(By.xpath("//*[@id='Id_trafficFileNumber']")).sendKeys(tcno1);
							
							driver.findElement(By.xpath("//*[@id='Id_searchBTN']")).click();
							
							int count=0;
							setDocs(String.valueOf(xdocs));
		                    
							boolean downloadProcess=true;
							do {
								int rowsize=0;
								//*[@id="root"]/div/div/div[3]/div/div/div/div/div[2]
		                        boolean emptyclass=driver.findElements(By.className("fines-violation-empty")).size()>0;
		                        
		                        if(emptyclass){
		                            downloadProcess=false;
		                        }
		                        else{
		                            wait=new WebDriverWait(driver, 30);
		                            wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr[1]")));
		                            rowsize=driver.findElements(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr")).size();
		                        };
								System.out.println("Inside Do While, Row Size:"+rowsize);
								Thread.sleep(2000);
								for(int i=0,j=1;i<rowsize;i++,j++) {
									System.out.println("Inside Loop :"+i);
									
									WebElement elmtr = driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]"));
									((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", elmtr);
									Thread.sleep(500); 
		                            String blackpoints="",ticketno="",trafficdate="",regno="",finesource="",platesource="",platecolor="",description="",amount="";

									if(driver.findElements(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]/span[2]")).size()>0){
										WebElement elmimpound=driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]/span[2]"));
										if(elmimpound.getAttribute("class").contains("impound-badge")){
											System.out.println("Vehicle Impounded");
											blackpoints="Impounded";
											//continue;
										}
									}
									count++;
									((JavascriptExecutor) driver).executeScript("arguments[0].click();", elmtr);
									if(blackpoints.trim().equalsIgnoreCase("Impounded")){
									    Thread.sleep(3000);
									    ticketno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[4]/p")).getText();
                                        trafficdate=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[5]/p")).getText();
                                        amount=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[3]/p")).getText();
                                        platesource="Dubai";
									}
									else{
									     ticketno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[7]/p")).getText();
	                                     trafficdate=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[1]/p")).getText();
	                                    location=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[2]/p")).getText();
	                                    if(!driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[1]")).getAttribute("innerHTML").contains("Traffic File No")) {
	                                        regno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div")).getText();
	                                        platecolor=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/span")).getText();
	                                    } 
	                                    //regno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div")).getText();
	                                     finesource=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[3]/p")).getText();
	                                     platesource="Dubai";
	                                     //platecolor=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/span")).getText();
	                                     if(driver.findElements(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]")).size()>0) {
	                                         blackpoints=driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]")).getText().replace("Black points", "");
	                                     }
									}
									//driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]")).click();
									
									WebElement uldesc=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/ul"));
									List<WebElement> lilist=uldesc.findElements(By.tagName("li"));
									for(WebElement li:lilist) {
										description+=" "+li.getText();
									}
									description=description.trim();
									 amount=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[4]/p")).getText();
									amount=amount.replace("AED", "");
									amount=amount.replace(",","");
                                    amount=amount.trim();
                                    amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
                                    location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
                                    description=description.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
									SimpleDateFormat inputFormat=new SimpleDateFormat("dd MMM yyyy, h:mm a");
									Date date=inputFormat.parse(trafficdate);
									
									java.sql.Date sqltrafficdate=new java.sql.Date(date.getTime());
									java.sql.Time sqltraffictime=new java.sql.Time(date.getTime());
									
									SimpleDateFormat outputTimeFormat=new SimpleDateFormat("HH:mm");
									time=outputTimeFormat.format(date);
									
									
								    tcno1=getTxttrafficplateno();
									dao.trafficInsert(ticketno,sqltrafficdate,time+"",finesource,regno,"",platecolor,"","","",
											Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,j,tcno1,xdoc,sqltrafficdate,branch,platesource,
											getCmbtrafficsite(),description,xdocs,blackpoints);
								}
								
								if(rowsize==0){
		                        	downloadProcess=false;
		                        }
		                        else{
		                        	String nextbtn=driver.findElement(By.className("p-paginator-next")).getAttribute("class");
			                        System.out.println("Next Btn:"+nextbtn);
			                        if(nextbtn.contains("p-disabled")) {
			                            downloadProcess=false;
			                        }
			                        else {
			                            wait=new WebDriverWait(driver, 30);
			                            wait.until(ExpectedConditions.elementToBeClickable(By.className("p-paginator-next")));
			                            driver.findElement(By.className("p-paginator-next")).click();
			                        }
		                        }
							}while(downloadProcess==true);
							
							WebElement elmnonpayable=driver.findElement(By.xpath("//*[@id='Id_ViolationsTab']"));
							JavascriptExecutor js2 = (JavascriptExecutor) driver;
							js2.executeScript("arguments[0].scrollIntoView(true);", elmnonpayable);
							js2.executeScript("arguments[0].click();", elmnonpayable);
							Thread.sleep(3000);
							downloadProcess=true;
		                    do {//*[@id="Id_FinesResultTable"]/div[1]/table/tbody/tr[1]
		                        int rowsize=0;
		                        boolean emptyclass=driver.findElements(By.className("fines-violation-empty")).size()>0;
		                        
		                        if(emptyclass){
		                            downloadProcess=false;
		                        }
		                        else{
		                            wait=new WebDriverWait(driver, 30);
		                            wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='Id_ViolationsResultTable']/div[1]/table/tbody/tr[1]")));
		                            rowsize=driver.findElements(By.xpath("//*[@id='Id_ViolationsResultTable']/div[1]/table/tbody/tr")).size();
		                        }
		                        
		                        //System.out.println("Inside Non Payable Do While, Row Size:"+rowsize);
		                        Thread.sleep(2000);
		                        for(int i=0,j=1;i<rowsize;i++,j++) {
		                            //System.out.println("Inside Loop :"+i);
		                            wait=new WebDriverWait(driver, 30);
		                            wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='Id_ViolationsResultTable']/div[1]/table/tbody/tr["+j+"]")));
		                            
		                            WebElement elmtr = driver.findElement(By.xpath("//*[@id='Id_ViolationsResultTable']/div[1]/table/tbody/tr["+j+"]"));
		                            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", elmtr);
		                            Thread.sleep(500); 
		                            String blackpoints="",ticketno="",trafficdate="",regno="",finesource="",platesource="",platecolor="",description="",amount="";
	                                
		                            if(driver.findElements(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]/span[2]")).size()>0){
										WebElement elmimpound=driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]/span[2]"));
										if(elmimpound.getAttribute("class").contains("impound-badge")){
											blackpoints="Impounded";
											//continue;
										}
									}
		                            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", elmtr);
		                            if(blackpoints.trim().equalsIgnoreCase("Impounded")){
                                        Thread.sleep(3000);
                                        ticketno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[4]/p")).getText();
                                        trafficdate=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[5]/p")).getText();
                                        amount=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div[3]/p")).getText();
                                        platesource="Dubai";
                                    }
		                            else{
		                                 ticketno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[7]/p")).getText();
	                                     trafficdate=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[1]/p")).getText();
	                                    location=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[2]/p")).getText();
	                                     //regno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div")).getText();
	                                     finesource=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[3]/p")).getText();
	                                     platesource="Dubai";
	                                     //platecolor=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/span")).getText();
	                                     if(!driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[1]")).getAttribute("innerHTML").contains("Traffic File No")) {
	                                         regno=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div")).getText();
	                                         platecolor=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/span")).getText();
	                                     }
	                                     if(driver.findElements(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]")).size()>0) {
	                                         blackpoints=driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]/td[2]/div/div[5]")).getText().replace("Black points", "");
	                                     }
		                            }
		                            count++;
		                            //driver.findElement(By.xpath("//*[@id='Id_FinesResultTable']/div[1]/table/tbody/tr["+j+"]")).click();
		                            WebElement uldesc=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/ul"));
		                            List<WebElement> lilist=uldesc.findElements(By.tagName("li"));
		                            for(WebElement li:lilist) {
		                                description+=" "+li.getText();
		                            }
		                            description=description.trim();
		                            amount=driver.findElement(By.xpath("//*[@id='root']/div/div/div[3]/div/div/div/div/div[2]/div[2]/div[3]/div[3]/div[4]/p")).getText();
		                            amount=amount.replace("AED", "");
		                            amount=amount.replace(",","");
                                    amount=amount.trim();
                                    amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
                                    location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
                                    description=description.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
		                            SimpleDateFormat inputFormat=new SimpleDateFormat("dd MMM yyyy, h:mm a");
		                            Date date=inputFormat.parse(trafficdate);
		                            
		                            java.sql.Date sqltrafficdate=new java.sql.Date(date.getTime());
		                            java.sql.Time sqltraffictime=new java.sql.Time(date.getTime());
		                            
		                            SimpleDateFormat outputTimeFormat=new SimpleDateFormat("HH:mm");
		                            time=outputTimeFormat.format(date);
		                            
		                            
		                            tcno1=getTxttrafficplateno();
		                            dao.trafficInsert(ticketno,sqltrafficdate,time+"",finesource,regno,"",platecolor,"","","",
		                                    Double.parseDouble(amount),location,amount,description,sqltrafficdate,"TRF",category,j,tcno1,xdoc,sqltrafficdate,branch,platesource,
		                                    getCmbtrafficsite(),"",xdocs,blackpoints);
		                        }
		                        if(rowsize==0){
		                        	downloadProcess=false;
		                        }
		                        else{
		                        	String nextbtn=driver.findElement(By.className("p-paginator-next")).getAttribute("class");
			                        //System.out.println("Next Btn:"+nextbtn);
			                        if(nextbtn.contains("p-disabled")) {
			                            downloadProcess=false;
			                        }
			                        else {
			                            wait=new WebDriverWait(driver, 30);
			                            wait.until(ExpectedConditions.elementToBeClickable(By.className("p-paginator-next")));
			                            driver.findElement(By.className("p-paginator-next")).click();
			                        }
		                        }
		                        
		                    }while(downloadProcess==true);
		                    driver.quit();
							
						}
						catch(Exception e){
							e.printStackTrace();
							if(driver!=null){
								driver.quit();
							}
						}
					}
					else{
						
						//Site Changes on 05-12-2021
						JavascriptExecutor firstpagescroll = (JavascriptExecutor) driver;
	                    firstpagescroll.executeScript("window.scrollBy(0,200)");
	                    
	                    //Site Changes - 05-03-2024 Fixed Bottom Navbar added.Changed by Rahis.
	                    int loginclicked=0;
	                    WebElement elmlogin=driver.findElement(By.xpath("//*[@id='btn_login']"));
	                    int firstscrollcounter=500;
	                    while(loginclicked==0) {
	                    	try {
	                    		elmlogin.click();
	                    		loginclicked++;
	                    	}
	                    	catch(WebDriverException ex) {
	                    		firstpagescroll.executeScript("window.scrollBy(0, "+firstscrollcounter+");");
	                    		firstscrollcounter=firstscrollcounter+500;
	                    	}
	                    }
						
						Thread.sleep(5000);
						

						String cururl=driver.getCurrentUrl();
						if(driver.findElements(By.xpath("//*[@id='widFines']/div/div[2]/a")).size()==0){
							driver.navigate().refresh();
							Thread.sleep(6000);
						}
						JavascriptExecutor js = (JavascriptExecutor) driver;
						js.executeScript("window.scrollBy(0,200)");
						driver.findElement(By.xpath("//*[@id='widFines']/div/div[2]/a")).click();
						
						Thread.sleep(1000);
						
						boolean islicensingPresent=driver.findElements(By.xpath("//*[@id='layoutContainers']/div/div[2]/div/div/div[2]/div/div/section/div/div[3]/div[2]/div/div/ul/li/a")).size()>0;
	                    
						if(islicensingPresent){
	                        //System.out.println("inside");
	                        try{
	                            driver.findElement(By.xpath("//*[@id='layoutContainers']/div/div[2]/div/div/div[2]/div/div/section/div/div[3]/div[2]/div/div/ul/li/a")).click();
	                        }
	                        catch(WebDriverException e){
	                        }
	                        Thread.sleep(3000);
	                    }  
	                    js.executeScript("window.scrollBy(0,450)");
						boolean isDashboardPresent=driver.findElements(By.xpath("//*[@id='returnToDashboardId']")).size()>0;
						if(isDashboardPresent){
							driver.findElement(By.xpath("//*[@id='returnToDashboardId']")).click();
							Thread.sleep(3000);
							
						}
					
						if(checkIdleErrorExist("1")) {
							System.out.println("Dropping Driver because of Midnight Idle Error");
							driver.quit();
						}
						
						driver.findElement(By.xpath("//*[@id='readMe']/div[4]/div[1]/div/div/div[2]/p[2]/a")).click();
						Thread.sleep(3000);
						
						if(checkIdleErrorExist("1")) {
							System.out.println("Dropping Driver because of Midnight Idle Error");
							driver.quit();
						}
						
						driver.findElement(By.xpath("//*[@id='readMe']/div[5]/div[2]/div[2]/h3/label/a")).click();
						Thread.sleep(3000);
						
						if(checkIdleErrorExist("1")) {
							System.out.println("Dropping Driver because of Midnight Idle Error");
							driver.quit();
						}
						
						//System.out.println("Selected Year: "+getCmbyear());
						setCmbyear((Calendar.getInstance().get(Calendar.YEAR))+"");
						JavascriptExecutor jsreg = (JavascriptExecutor) driver;
						if(!getCmbyear().equalsIgnoreCase("")){
							//System.out.println("Html:"+driver.findElement(By.xpath("//*[@id='SkiDiv1']/div")).getAttribute("innerHTML"));
							Select finedropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[1]/select")));
							finedropdown.selectByVisibleText("Fine number");
							//driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[2]/a")).click();
							//Thread.sleep(1000);
							Select yeardropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv3']/div/ul/li[3]/select")));
							yeardropdown.selectByVisibleText(getCmbyear());
							driver.findElement(By.xpath("//*[@id='SkiDiv3']/div/ul/li[4]/a")).click();
						}
						Thread.sleep(10000);
						JavascriptExecutor js3 = (JavascriptExecutor) driver;
						js3.executeScript("window.scrollBy(0,200)");
						
						if(checkIdleErrorExist("1")) {
							System.out.println("Dropping Driver because of Midnight Idle Error");
							driver.quit();
						}
						
						try{
						
							int n=0;

							Thread.sleep(5000);

						//System.out.println("Fine Count :"+count);
						String pagecountarray[]=(driver.findElement(By.xpath("//*[@class='paginationCounts']")).getText()).split(" ");
						String count= pagecountarray[pagecountarray.length-1];
						int pagenos=Integer.parseInt(count)/10;
						int qot=Integer.parseInt(count)%10;
						if(qot>0){
							pagenos=pagenos+1;
						}
						js.executeScript("goToPage("+(pagenos-1)+");");
						Thread.sleep(2000);
						int pagecounter=pagenos;
						int j=0;
						
						if(checkIdleErrorExist("1")) {
							System.out.println("Dropping Driver because of Midnight Idle Error");
							driver.quit();
						}

						int breakloop=0;
						while(pagecounter>=1){
							//System.out.println("Page Counter Check:"+pagecounter+"::"+pagenos);
//							System.out.println("===== BEFORE LOOP ==========");
							int rowlength=driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr")).size();
							//System.out.println("FineEntry Length:"+rowlength);
								int k=0;
								int scrollcounter=0;
								if(breakloop==1) {
									breakloop=0;
									break;
								}
								for(int z=rowlength-1,rowindex=rowlength;z>=1;z--,rowindex--){
									if(rowindex>=2){
										
										WebElement scrollelm=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]"));
										js.executeScript("arguments[0].scrollIntoView();", scrollelm);
										String amount=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[5]")).getText().trim();
										String finenumber=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[7]")).getText().trim();
										Ticket_No=finenumber.replaceAll("[^0-9_-_._;_: ]+", "");
										boolean ticketPresent=dao.checkTrafficExist(conn, amount, Ticket_No);
										String datetime=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[2]")).getText().trim();
										java.sql.Date onemonthbeforedate=getOneMonthBeforeDate(conn);
										
										try{
											SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
											java.util.Date date = sdf1.parse(datetime);
											traffic_date = new java.sql.Date(date.getTime());
											Time=new SimpleDateFormat("HH:mm").format(date);
											
											//System.out.println(traffic_date+"::"+onemonthbeforedate+"::"+traffic_date.compareTo(onemonthbeforedate));
											if(traffic_date.compareTo(onemonthbeforedate)<0 && ticketPresent==true) {
												System.out.println("Dropping Download Browser ,Traffics are 1 month old");
												//driver.quit();
												breakloop=1;
												break;
											}
										}catch(ParseException pe){
											pe.printStackTrace();
										}
										
										
										
										if(ticketPresent==false) {
											String regraw = (String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4)').innerHTML;");
											if(regraw.trim().equalsIgnoreCase("")){
												continue;
											}
										String strregno = (String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div').innerHTML;");
										if(strregno.trim().equalsIgnoreCase("")){
											continue;
										}
										pcolor="";
										
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div")).size()==2){
											//regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[2]")).getAttribute("innerHTML").trim();
											regNo=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(2)').innerHTML;")).trim();
											if(regNo.trim().equalsIgnoreCase("")){
												regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[2]")).getText();
											}
											pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]")).getText().trim();
											if(pcolor.trim().equalsIgnoreCase("")){
												//pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[1]")).getAttribute("innerHTML").trim();
												pcolor=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div:nth-child(1)').innerHTML;")).trim();
											}
										}
										else{
											//regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='number']")).getAttribute("innerHTML").trim();
											regNo=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div.number').innerHTML;")).trim();
											if(regNo.trim().equalsIgnoreCase("")){
												regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='number']")).getText();
											}
											pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[contains(@class, 'code')]")).getText().trim();
											if(pcolor.trim().equalsIgnoreCase("")){
												//pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]/div[1]/div[@class='code']")).getAttribute("innerHTML").trim();
												pcolor=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(4) div:nth-child(1) div.code').innerHTML;")).trim();
											}
										}
										
										fine_Source=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]")).getText().trim();
										String reasonmain="";
										JavascriptExecutor js2 = (JavascriptExecutor) driver;
										//js2.executeScript("window.scrollBy(0,200)");
										WebElement elm=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a"));
										//String onclickfunc=elm.getAttribute("onclick");
										js2.executeScript("arguments[0].click();", elm);
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										WebElement reasonhtml=driver.findElement(By.id("actions_div"+(z-1)));
										if(reasonhtml.findElement(By.xpath("li[1]/p"))!=null){
											reasonmain=((String) jsreg.executeScript("return document.querySelector('#actions_div"+(z-1)+" li:nth-child(1) p').innerHTML;")).trim();
										}
										location="";
										System.out.println("Rowindex:"+rowindex+",Z:"+z);
										if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li")).size()>=2){
											System.out.println("Ticket :"+Ticket_No+"::"+(z-1));
											location=((String) jsreg.executeScript("return document.querySelector('#actions_div"+(z-1)+" li:nth-child(2) p').innerHTML;")).trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										}
										else{
											location="";
										}
										//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
										js2.executeScript("arguments[0].click();", elm);
//										System.out.println("location === "+location);
										type="TRF";
//										System.out.println("PCOLOR:"+pcolor+"//Reg No:"+regNo+"//DateTime:"+datetime+"//Fine Number"+finenumber+"//ReasonLocation"+reasonmain+"//Amount:"+amount);
										j++;
//										System.out.println("Counter:"+j);
										
										
									      
										regNo=regNo.substring(0,regNo.length()).replaceAll("[^0-9]+", "");
										
										DESC1=reasonmain.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										//location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
										Amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
//										System.out.println("Amount2:"+Amount);
										n++;
										k++;
										if(k!=0){
		
		
											plate_source="Dubai";
		
		
											java.util.Date dates=new  java.util.Date();
		
		
											java.sql.Date date=com.getSqlDate(dates);
		
											result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
													Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
													getCmbtrafficsite(),DESC1,xdocs,"");
										}
									
										}

									}
								Thread.sleep(5000);	
								}
								
								
//								System.out.println(pagecounter+"::"+pagenos);
								if(pagecounter>1){
									List<WebElement> anchornext = driver.findElements(By.xpath("//div[@class='paging'][1]/a"));
									Iterator<WebElement> i = anchornext.iterator();
									while(i.hasNext()){
										WebElement anchor = i.next();
										//System.out.println("Paging"+anchor.getText());
										if(anchor.getText().contains("Previous")){
											//anchor.click();
											
											js.executeScript("arguments[0].click();", anchor);
											pagecounter--;
											break;
										}
									}
									
									Thread.sleep(2000);
									
								}
								
						}
						Thread.sleep(5000);
						
						WebElement elmblockfinelink=driver.findElement(By.xpath("//*[@id='readMe']/ul/li[2]/a"));
						//String onclickfunc=elm.getAttribute("onclick");
						js.executeScript("arguments[0].click();", elmblockfinelink);
						
						
						Thread.sleep(2000);
						if(!getCmbyear().equalsIgnoreCase("")){
							//System.out.println("Html:"+driver.findElement(By.xpath("//*[@id='SkiDiv1']/div")).getAttribute("innerHTML"));
							Select finedropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv11']/div/ul/li[1]/select")));
							//*[@id="SkiDiv33"]/div/ul/li[3]/select
							finedropdown.selectByVisibleText("Fine number");
							//driver.findElement(By.xpath("//*[@id='SkiDiv1']/div/ul/li[2]/a")).click();
							//Thread.sleep(1000);
							Select yeardropdown=new Select(driver.findElement(By.xpath("//*[@id='SkiDiv33']/div/ul/li[3]/select")));
							yeardropdown.selectByVisibleText(getCmbyear());
							driver.findElement(By.xpath("//*[@id='SkiDiv33']/div/ul/li[4]/a")).click();
							Thread.sleep(2000);
						}
						String blockedpagecountarray[]=(driver.findElement(By.xpath("//*[@class='paginationCounts']")).getText()).split(" ");
						count= blockedpagecountarray[blockedpagecountarray.length-1];
						pagenos=Integer.parseInt(count)/10;
						qot=Integer.parseInt(count)%10;
						if(qot>0){
							pagenos=pagenos+1;
							//js.executeScript("goToPage("+(pagenos-1)+");");
							Thread.sleep(2000);
						}
						pagecounter=1;
						j=0;
//						System.out.println("Total Pages: "+pagenos);
						
						while(pagecounter<=pagenos){
							
//							System.out.println("===== BEFORE LOOP ==========");
							int rowlength=driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr")).size();
							//System.out.println("FineEntry Length:"+rowlength);
								int k=0;
								int scrollcounter=0;
//								System.out.println("===== AFTER =========="+rowlength);
								for(int z=1,rowindex=2;z<=rowlength;z++,rowindex++){
									if(rowindex<=rowlength){
										String finenumber=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[7]")).getText().trim();
										Ticket_No=finenumber.replaceAll("[^0-9_-_._;_: ]+", "");
										String amount=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[4]")).getText().trim();
										boolean ticketPresent=dao.checkTrafficExist(conn, amount, Ticket_No);
										String datetime=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[1]")).getText().trim();
										
										try{
											SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
											java.util.Date date = sdf1.parse(datetime);
											traffic_date = new java.sql.Date(date.getTime());
											java.sql.Date onemonthbeforedate=getOneMonthBeforeDate(conn);
											if(traffic_date.compareTo(onemonthbeforedate)<0 && ticketPresent==true) {
												System.out.println("Dropping Download Browser ,Traffics are 1 month old");
												driver.quit();
											}
											Time=new SimpleDateFormat("HH:mm").format(date);
									      }catch(ParseException pe){
									         pe.printStackTrace();
									      }
										
										if(ticketPresent==false) {
											if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div")).size()==2){
												regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[2]")).getText().trim();
											}
											else if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div")).size()==3){
												regNo=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[3]")).getText().trim();
											}
											
//											System.out.println("//table[@class='regularfines']/tbody/tr["+rowindex+"]");
											pcolor="";
											WebElement elmpcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]"));
											if(((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(3)').innerHTML;")).trim().contains("div")){
												pcolor=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[3]/div[1]/div[1]")).getText().trim();
											}
											
											fine_Source=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[2]")).getText().trim();
//											System.out.println("Fine Source:"+fine_Source);
											String reasonmain="";
											JavascriptExecutor js2 = (JavascriptExecutor) driver;
											js2.executeScript("window.scrollBy(0,200)");
											WebElement elm=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a"));
											//String onclickfunc=elm.getAttribute("onclick");
											js2.executeScript("arguments[0].click();", elm);
											//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
											if(driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p"))!=null){
												reasonmain=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[1]/p")).getText().trim();
											}
											else{
												reasonmain="";
											}
//											System.out.println("Reason:"+reasonmain);
											
//											System.out.println("Amount1:"+amount);
											location="";
											if(driver.findElements(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li")).size()>=2){
												//location=driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/ul/li[2]/p")).getAttribute("innerHTML").trim();
												location=((String) jsreg.executeScript("return document.querySelector('.regularfines tbody tr:nth-child("+rowindex+") td:nth-child(8) ul li:nth-child(2) p').innerHTML;")).trim().replaceAll("[^a-zA-Z0-9 ]+", "").trim();
//												System.out.println("1 location === "+location);
											}
											else{
//												System.out.println("blank location === "+location);
												location="";
											}
											//driver.findElement(By.xpath("//table[@class='regularfines']/tbody/tr["+rowindex+"]/td[8]/a")).click();
											js2.executeScript("arguments[0].click();", elm);
//											System.out.println("location === "+location);
											type="TRF";
//											System.out.println("PCOLOR:"+pcolor+"//Reg No:"+regNo+"//DateTime:"+datetime+"//Fine Number"+finenumber+"//ReasonLocation"+reasonmain+"//Amount:"+amount);
											j++;
//											System.out.println("Counter:"+j);
											
											
										      
											regNo=regNo.substring(0,regNo.length()).replaceAll("[^0-9]+", "");
											
											DESC1=reasonmain.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
											//location=location.replaceAll("[^a-zA-Z0-9 ]+", "").trim();
//											System.out.println("after replace "+location);
											Amount=amount.replaceAll("[^0-9_-_._;_: ]+", "");
//											System.out.println("Amount2:"+Amount);
											n++;
											k++;
											if(k!=0){
			
			
												plate_source="Dubai";
			
			
												java.util.Date dates=new  java.util.Date();
			
			
												java.sql.Date date=com.getSqlDate(dates);
			
												result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
														Double.parseDouble(Amount),location,Amount,DESC1,null,type,category,srno+n,tcno1,xdoc,date,branch,plate_source,
														getCmbtrafficsite(),DESC1,xdocs,"");
											}
										
										}
										
									}
								Thread.sleep(5000);	
								}
								
								if(pagecounter>=pagenos){
									driver.quit();
									break;
								}
//								System.out.println(pagecounter+"::"+pagenos);
								if(pagecounter<pagenos){
									List<WebElement> anchornext = driver.findElements(By.xpath("//div[@class='paging'][1]/a"));
									Iterator<WebElement> i = anchornext.iterator();
									while(i.hasNext()){
										WebElement anchor = i.next();
										if(anchor.getText().contains("Next")){
											//anchor.click();
											
											js.executeScript("arguments[0].click();", anchor);
											pagecounter++;
											break;
										}
									}
									
									Thread.sleep(2000);
									
								}
								
						}
						if(pagecounter>=pagenos){
							driver.quit();
						}

						}
						catch(Exception e){
							e.printStackTrace();
						}

					}
				}
			}

			if(getCategory().equalsIgnoreCase("salik"))
			{ 
				if(getCmbsaliksite().equalsIgnoreCase("DXB"))	
				{
					if(flag)
					{
						String k="";
						int d=Integer.parseInt(dat);
						int stpage =txtStPage;
						int count=2,i;

						//int stimer=0;						

						for(i=2;i<=d;i++)
						{
							boolean getdata = true;
							k=String.valueOf((i));
							if(Integer.parseInt(k)<10) k="0"+k;
							WebElement s;
							try
							{

								//	stimer=(i%2==0?30:(i%11==0?6:15));		//15 and 30 for alternate page. for next set of pages 6 seconds.

								if ((i-1)==1){

									//inputCaptcha("Processing "+i+" of "+d+" Pages");
								}


								//Thread.sleep(15*1000);//commented by krish

								if(stpage>d)
								{
									//JOptionPane.showMessageDialog(this.getParent(),MyLib.getUID("Start Page# exceeds total no. of pages - "+d));
									driver.quit();
									return false;
								}
								else if (stpage>1 && i<stpage)
								{
									if (stpage <= (i+(10-(i%10))))
									{

										s=driver.findElement(By.partialLinkText(String.valueOf(stpage)));
										s.click();
										i=stpage;
									}
									else
									{


										s=driver.findElement(By.xpath("//*[@title='Next pages']"));
										s.click();
										i+=(10-(i%10));

										getdata=false;
									}
								}
								else
								{

									s=driver.findElement(By.linkText(String.valueOf(i)));
									//s=driver.findElement(By.partialLinkText(String.valueOf((i))));   				
									s.click();
								}
							}
							catch (Exception e)
							{
								try
								{
									e.printStackTrace();

									s=driver.findElement(By.xpath("//*[@title='Next page']"));
									s.click();
								}catch(Exception e1)
								{
									e1.printStackTrace();

									driver.quit();



									txtStPage=i-1;						             
									loadfresh(conn,session);
								}
							}
							
							doc=null;


							WebElement we=null;
							int cnt=0;
							do
							{  
								if(count==d)
								{

									Thread.sleep(1000);	
								}
								//Thread.sleep(1000);//--commented by krish
								we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
								String style = we.getAttribute("style").trim();

								if (!style.isEmpty())
									we=null;
								cnt++;
							}while(we==null && cnt<10);
							count++;
							//	 Thread.sleep(20000);


							url=driver.getCurrentUrl();




							if (getdata)
								result=jsoupGetTableData(i,conn,session);

							if(count>d)
							{
								//Thread.sleep(5000);
								//loadData();
								Thread.interrupted();
								driver.quit();
							}
							//  count++;
						}
					}
					//result=jsoupGetTableData(0,conn);
				}
			}
		}
		catch(Exception e){
			driver.quit();
			e.printStackTrace();
		}
		return result;
	}

	public boolean jsoupGetTableData(int v,Connection conn,HttpSession session) throws IOException, InterruptedException, SQLException, ParseException
	{
		ScriptEngineManager factory = new ScriptEngineManager();

	/*	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
*/
		boolean result=false;

		Elements tableElements = null;
		Elements rowItems=null;
		Elements roi=null;
		PreparedStatement prepst,iprepst;
		String textdescription="";


		//DXB//
		if(getCategory().equalsIgnoreCase("traffic"))
		{			 

			if(getCmbtrafficsite().trim().equalsIgnoreCase("DXB"))
			{
				tableElements = doc.select("table.srchrsult");//div#pnlResults

			}
			else if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
			{
				tableElements = doc.select("table#ctl00_ContentPlaceHolder1_gvTickets");
				tableElements.size();
			}
			Elements tableHeaderEles = tableElements.select("thead tr th");

			for (int i = 0; i < tableHeaderEles.size(); i++) 
			{


			}

			try{
				ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_traffic");

				if(rs.next())
				{	

					dno=rs.getInt("max");

					xdoc=dno;
					xdocs=xdocs+","+xdoc;

					if(session!=null) {
						String trafficdocno=session.getAttribute("TRAFFICDOCNO")==null?"":session.getAttribute("TRAFFICDOCNO").toString();
	                    if(!trafficdocno.contains(dno+"")){
	                        if(trafficdocno.trim().equalsIgnoreCase("")){
	                            trafficdocno+=dno;
	                        }
	                        else{
	                            trafficdocno+=","+dno;
	                        }
	                    }
	                    session.setAttribute("TRAFFICDOCNO", trafficdocno);
					}
					
				}
				/*request.setAttribute("trxdocs", xdocs);*/
				setDocs(String.valueOf(xdocs));
			}catch (Exception e2) {e2.printStackTrace();}



			Elements tableRowElements = tableElements.select(":not(thead) tr");
			String k="";
			for (int i = 0; i < tableRowElements.size(); i++) 
			{


				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					k=String.valueOf((i+1));
					if(Integer.parseInt(k)<10)
						k="0"+k;
				}



				String aid="ctl00_ContentPlaceHolder1_gvTickets_ctl"+k+"_HyperLink1";
				Element row = tableRowElements.get(i);

				if(getCmbtrafficsite().equalsIgnoreCase("AUH"))
				{
					Element r=tableRowElements.get(1);
					roi=r.select("td");


					if(row.className().equalsIgnoreCase("")||row.className().equalsIgnoreCase("gridViewFooter")
							||row.className().equalsIgnoreCase("gridViewPager"))
					{
						/* flag=true;
 				    	   dat = rowItems.get(0).text();
 				    	   System.out.println(dat+" - "+curPage+" - "+dat.substring(dat.indexOf("Displaying page")+15, dat.indexOf("of")));
 				    	   dat=dat.substring(dat.indexOf("of")+1);
 				    	   dat=dat.substring(0,dat.indexOf(','));
 				    	   dat=dat.substring(dat.indexOf(' ')+1);
						 */
						continue;
					}
				}

				rowItems = row.select("td");


				if(rowItems.size()>0)
				{
					if(getCmbtrafficsite().equalsIgnoreCase("DXB"))
					{
						rowItems = row.select("td");

					}
				}
				//
				String data="",disc="",Fees="",remark="";
				String Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Amount="",Ticket_No="",Tick_violat="",DESC1="",type="",plate_source="";
				java.sql.Date date = null,traffic_date=null;

				for (int j = 0; j < rowItems.size(); j++) 
				{	
					Elements rowItemSpan = null;
					//System.out.println("rowItems html===="+rowItems.html());
					if(rowItems.html().contains("span")){
						rowItemSpan=rowItems.select("span");
					}
						
					if(j!=rowItems.size()-1){
						data=rowItemSpan.get(j).text();
					}
					



					if(getCmbtrafficsite().equalsIgnoreCase("AUH")){

						if(j==0){
							Ticket_No=rowItems.get(j).select("input").val();
							
						}


						if(j==3){

							Fees=data;
						}
						if(j==5){

							disc=data;

						}

						if(j==4){

							remark=data;
						}

						if(rowItems.get(j).text().equalsIgnoreCase("Details.."))
						{
							new Actions(driver).moveToElement(driver.findElement(By.xpath("//a[@id='"+aid+"']")));
							driver.findElement(By.xpath("//a[@id='"+aid+"']")).click();

							popupwindow=driver.getWindowHandle();
							driver.switchTo().window(popupwindow);
							//driver.switchTo().alert().dismiss();
							

							Thread.sleep(5000);
							detailsNewlyOpenedwindow(disc,Fees,srno+i,remark,i,conn);

						}
					}  
					String vio="Black Points:";
					if(getCmbtrafficsite().equalsIgnoreCase("DXB")){


						if(j==1){

							data = rowItems.get(j).text();

							data = rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );


							DateFormat   formatter = new SimpleDateFormat("dd/MM/yyyy");

							data=(data.substring(0,2)+"/"+data.substring(3,5) +"/"+ data.substring(6,10));

							try {
								java.util.Date date1 = formatter.parse(data);
								java.sql.Date dtvalue=new java.sql.Date(date1.getTime());
								//fBrowse.cache.setData("traffic_date", dtvalue);
								traffic_date=dtvalue;

							} catch (ParseException e) {e.printStackTrace();} 

							Time=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

						}
						if(j==2){ 



							fine_Source=rowItems.get(j).text();

						}
						if(j==3){ 

							String s = rowItems.get(j).text().trim();
							//System.out.println("==s====="+s.length());
							if(s.length()>1){

								s = s.substring(s.indexOf(' ') + 1);

								//System.out.println("===sssssss====="+s);

								s = s.substring(0, s.indexOf(' ')); 
								String plc="",plcat="";
								if(s.length()>3){
									plc=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);
									plcat=s;

								}  else{
									plc=s;
									plcat=rowItems.get(j).text().substring( rowItems.get(j).text().lastIndexOf( ' ') + 1);

								}
								regNo=rowItems.get(j).text().substring(0,rowItems.get(j).text().indexOf(' ') );
								PlateCategory=plcat;

								pcolor=plc;

							}
							else{
								PlateCategory="";
								pcolor="";
							}
						}
						if(j==4){ 

							Amount=rowItems.get(j).text();

						}
						if(j==5){ 

							vio=vio+rowItems.get(j).text();

						}
						if(j==6){ 

							//Ticket_No=rowItems.get(j).text();

						}

						if(j==7){ 

							vio=vio+rowItems.get(5).text()+"  "+rowItems.get(j).text();
							Tick_violat=vio;

							DESC1=vio;

						}
						java.util.Date dates=new  java.util.Date();


						date=com.getSqlDate(dates);

						type="TRF";

						if(j==20){


						}

					}

				}

				if(rowItems!=null&&rowItems.size()>0&&getCmbtrafficsite().equalsIgnoreCase("DXB"))
				{
					plate_source="Dubai";
					SATdownloadDAO dao=new SATdownloadDAO();
					if(regNo.length()>1)
					{
						regNo=regNo.substring(1,regNo.length());
					}
					else{
						regNo="0";
					}

					result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,null,null,null,
							Double.parseDouble(Amount),null,null,DESC1,null,type,category,srno+i,tcno1,xdoc,date,branch,plate_source,
							getCmbtrafficsite(),"",xdocs,"");

					rollno++;
					//System.out.println("==rollno====="+rollno);
				}

			}
			if(getCmbtrafficsite().equals("AUH"))
			{

				if(!fineno.equalsIgnoreCase(""))
				{
					if(fineno.equalsIgnoreCase(roi.get(0).text()))
					{
						//driver.quit();
					}
					else
					{
						fineno=roi.get(0).text();


					}
				}
				else	
					if(fineno.equalsIgnoreCase(""))
					{
						fineno=roi.get(0).text();

						// driver.quit();
					}
			}
		}
		else if(getCategory().equalsIgnoreCase("salik"))	//salik
		{
			if(getCmbsaliksite().equalsIgnoreCase("AUH")){
				int qudraAllSalik=0;
				ResultSet rsallsalik=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
				while(rsallsalik.next()){
					qudraAllSalik=rsallsalik.getInt("method");
				}
				try{
				driver.findElement(By.xpath("//*[@id='language']")).click();
				Thread.sleep(1000);
				driver.findElement(By.xpath("//*[@id='language']/a[1]")).click();
				Thread.sleep(2000);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[2]/input")).sendKeys(ts);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[2]/input")).sendKeys(Keys.TAB);
				
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[4]/input")).sendKeys(pass);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[4]/input")).sendKeys(Keys.TAB);
				driver.findElement(By.xpath("//*[@id='Aber']/main/div/app-login/div/form/div[1]/div[7]/button")).click();
				
				Thread.sleep(2000);
				//Maqafi Alert
				//*[@id="Aber"]/main/app-dashboard/p-dialog/div/div
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div")).size()>0){
					WebElement tempalert=driver.findElement(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div/div[2]/div[2]/button"));
					JavascriptExecutor executor = (JavascriptExecutor)driver;
					executor.executeScript("arguments[0].click();", tempalert);
					Thread.sleep(2000);
				}
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div/div[2]/div/div[2]/button")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-dashboard/p-dialog/div/div/div[2]/div/div[2]/button")).click();
					Thread.sleep(1000);
				}
				
				if(driver.findElements(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).size()>0){
					driver.findElement(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).click();
					Thread.sleep(2000);
				}
				driver.findElement(By.xpath("//*[@id='language']")).click();
				Thread.sleep(1000);
				driver.findElement(By.xpath("//*[@id='language']/a[1]")).click();
				Thread.sleep(2000);
				
				if(driver.findElements(By.xpath("//*[@id='Aber']/app-in-activity-detector/app-vehicle-registration/p-dialog/div/div")).size()>0){
					WebElement tempalert=driver.findElement(By.xpath("//*[@id='Aber']/app-in-activity-detector/app-vehicle-registration/p-dialog/div/div/div[1]/div/a"));
					JavascriptExecutor executor = (JavascriptExecutor)driver;
					executor.executeScript("arguments[0].click();", tempalert);
					Thread.sleep(2000);
				}
				
					driver.findElement(By.xpath("//*[@id='navbarSupportedContent']/div[1]/ul/li[4]/a")).click();
					Thread.sleep(4000);
				
				if(driver.findElements(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).size()>0){
					driver.findElement(By.xpath("//*[@id='mat-menu-panel-0']/div/mat-card/mat-card-actions/button[3]")).click();
					Thread.sleep(2000);
				}
				
				if(getCmbtype().equalsIgnoreCase("lhrs")){
					//24 Hrs
				}
				else if(getCmbtype().equalsIgnoreCase("ldays")){
					//Last 7 Days
				}
				else if(getCmbtype().equalsIgnoreCase("l30d")){
					//Last 30 Days
				}
				
				else if(getCmbtype().equalsIgnoreCase("customdates")){
					//Custom Dates
					
				}
	
				Thread.sleep(15000);
				driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[1]/div[2]/form/div[4]/button[2]")).click();
				Thread.sleep(3000);
				
				//Select 100 entries per page
//				System.out.println("=====transaction");
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator/div/p-dropdown/div/div[3]")).click();
					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator/div/p-dropdown/div/div[5]/div/ul/p-dropdownitem[4]/li")).click();
					Thread.sleep(6000);
					
				}
				int tblrowcount=0;
				if(!driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr/td")).getText().equalsIgnoreCase("No Records Found")){
					tblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr")).size();
				}
				
				int tblrowindex=1;
				int saliksrno=1;
				ResultSet rssalikmax = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

				if(rssalikmax.next())
				{	
					xsadoc=0;
					xsadoc=rssalikmax.getInt("max");

					xdocs=xdocs+","+xsadoc;	
					xsasrno=0;
					
					if(session!=null) {
						String salikdocno=session.getAttribute("SALIKDOCNO")==null?"":session.getAttribute("SALIKDOCNO").toString();
						if(!salikdocno.contains(xsadoc+"")){
						    if(salikdocno.trim().equalsIgnoreCase("")){
		                        salikdocno+=xsadoc;
		                    }
		                    else{
		                        salikdocno+=","+xsadoc;
		                    }
						}
						session.setAttribute("SALIKDOCNO", salikdocno);
					}
					
				}
				setDocs(String.valueOf(xdocs));
				while(tblrowindex<=tblrowcount){
					
					String platecode=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[1]/span")).getText().trim();
					String authorityraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/small/span")).getText().trim();
					
						String authority=authorityraw;
					String regno=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[2]/vehicle-plate/div/div[2]")).getText();
					String locaton=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[3]/span[2]")).getText();
					String datetimeraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[4]/span[2]")).getText();
					String amount=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr["+tblrowindex+"]/td[5]/b")).getText();
					String strdate=datetimeraw.split(" ")[0].replace("/",".");
				
					SATdownloadDAO dao=new SATdownloadDAO();
					platecode=platecode.trim();
					authority=authority.trim();
					regno=regno.trim();
					
					String strgetsaliktag="select veh.salik_tag from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no left join "+
					" gl_vehauth auth on veh.authid=auth.doc_no where veh.reg_no="+regno+" and auth.authname='"+authority+"' and plt.code_name='"+platecode+"' and veh.statu=3";
					String saliktag="";
					Statement stmt=conn.createStatement();
					//System.out.println(strgetsaliktag);
					ResultSet rssalik=stmt.executeQuery(strgetsaliktag);
					while(rssalik.next()){
						saliktag=rssalik.getString("salik_tag");
					}
					String transaction=(regno+platecode+datetimeraw).replace("/","").replace("-","").replace(":","").replace(" ","").trim();
					if(qudraAllSalik==1){
						boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
								datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
								saliksrno, "SLK", datetimeraw, "");
						//if(salikstatus){
							tblrowindex++;
							saliksrno++;
						/*}
						else{
							System.out.println("return 1");
							//return false;
						}*/
					}
					else{
						if(Double.parseDouble(amount)>0.0){
							boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
									datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
									saliksrno, "SLK", datetimeraw, "");
							/*System.out.println(ts+"===="+ regno+"===="+  saliktag+"===="+  transaction+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  locaton+"===="+  authority+"-"+platecode+"-"+regno+"===="+ "AUH"+"===="+  Double.parseDouble(amount)+"===="+ 
									datetimeraw.split(" ")[1]+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  xsadoc+"===="+  objcommon.changeStringtoSqlDate(strdate)+"===="+ 
									saliksrno+"===="+  "SLK"+"===="+  datetimeraw);*/
						//	if(salikstatus){
								tblrowindex++;
								saliksrno++;
							/*}
							else{
								System.out.println("return 2");
								return false;
							}*/
						}
						else{
							tblrowindex++;
						}
					}
					
//					System.out.println("Table Row Index2 :"+tblrowindex);
//					System.out.println("Table Row count2 :"+tblrowcount);
					if(tblrowindex>tblrowcount){
						if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator")).size()>0){
							String pageclasses = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator/div/a[3]")).getAttribute("class");
//						    System.out.println("Next Anchor Classes:"+pageclasses);
							if(!pageclasses.contains("ui-state-disabled")){
						    	tblrowindex=1;
					        	driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/p-paginator/div/a[3]")).click();
					        	Thread.sleep(6000);
					        	tblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[3]/p-table/div/div/table/tbody/tr")).size();
						    }
						}
					}
				}
				
				//Select 100 entries per page
//				System.out.println("=====unpaid");
				if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator")).size()>0){
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator/div/p-dropdown/div/div[3]")).click();
					Thread.sleep(1000);
					driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator/div/p-dropdown/div/div[5]/div/ul/p-dropdownitem[4]/li")).click();
					Thread.sleep(6000);
					
				}
				
				int utblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr")).size();
				int utblrowindex=1;
				// int usaliksrno=1;
//				request.setAttribute("xdocs", xdocs);
//				session.setAttribute("ITEMCURRENTDOCNO",xsadoc);
				setDocs(String.valueOf(xdocs));
//				System.out.println("Row Index"+utblrowindex);
//				System.out.println("Row Count"+utblrowcount);
				while(utblrowindex<=utblrowcount){
					if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td")).size()==1) {
						//No Rows Present
						break;
					}
					String platecode=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/div[1]/span")).getText().trim();
					String authorityraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/small/span")).getText().trim();
					//System.out.println("Authority:"+authorityraw);
					//String authority=authorityraw.split("\n")[1];
						String authority=authorityraw;
					String regno=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[2]/vehicle-plate/div/div[2]")).getText();
					String locaton=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[3]/span[2]")).getText();
					String datetimeraw=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[4]/span[2]")).getText();
					String amount=driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr["+utblrowindex+"]/td[5]/b")).getText();
					String strdate=datetimeraw.split(" ")[0].replace("/",".");
					SATdownloadDAO dao=new SATdownloadDAO();
					platecode=platecode.trim();
					authority=authority.trim();
					regno=regno.trim();
					String strgetsaliktag="select veh.salik_tag from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no left join "+
					" gl_vehauth auth on veh.authid=auth.doc_no where veh.reg_no="+regno+" and auth.authname='"+authority+"' and plt.code_name='"+platecode+"' and veh.statu=3";
					String saliktag="";
					Statement stmt=conn.createStatement();
					//System.out.println(strgetsaliktag);
					ResultSet rssalik=stmt.executeQuery(strgetsaliktag);
					while(rssalik.next()){
						saliktag=rssalik.getString("salik_tag");
					}
//					System.out.println("Salik Tag:"+saliktag);
					/*
					String ts,String plno,String tag,String Trans,java.sql.Date dtripvalue,String Loc,String Dir,String src,Double Amount,
					String time,java.sql.Date dtvalue,int xsadoc,java.sql.Date sd,int xsasrno,String type,String salik_fdate,String branch*/
					String transaction=(regno+platecode+datetimeraw).replace("/","").replace("-","").replace(":","").replace(" ","").trim();
					if(qudraAllSalik==1){
						boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
								datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
								saliksrno, "SLK", datetimeraw, "");
						//if(salikstatus){
							utblrowindex++;
							saliksrno++;
						/*}
						else{
							System.out.println("return 1");
							//return false;
						}*/
					}
					else{
						if(Double.parseDouble(amount)>0.0){
							boolean salikstatus=dao.salikInsertAUH(ts, regno, saliktag, transaction,objcommon.changeStringtoSqlDate(strdate), locaton, authority+"-"+platecode+"-"+regno,"AUH", Double.parseDouble(amount),
									datetimeraw.split(" ")[1],objcommon.changeStringtoSqlDate(strdate), xsadoc, objcommon.changeStringtoSqlDate(strdate),
									saliksrno, "SLK", datetimeraw, "");
							/*System.out.println(ts+"===="+ regno+"===="+  saliktag+"===="+  transaction+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  locaton+"===="+  authority+"-"+platecode+"-"+regno+"===="+ "AUH"+"===="+  Double.parseDouble(amount)+"===="+ 
									datetimeraw.split(" ")[1]+"===="+ objcommon.changeStringtoSqlDate(strdate)+"===="+  xsadoc+"===="+  objcommon.changeStringtoSqlDate(strdate)+"===="+ 
									saliksrno+"===="+  "SLK"+"===="+  datetimeraw);*/
						//	if(salikstatus){
								utblrowindex++;
								saliksrno++;
							/*}
							else{
								System.out.println("return 2");
								return false;
							}*/
						}
						else{
							utblrowindex++;
						}
					}
					
//					System.out.println("Table Row Index2 :"+tblrowindex);
//					System.out.println("Table Row count2 :"+tblrowcount);
					if(utblrowindex>utblrowcount){
						if(driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator")).size()>0){
							String pageclasses = driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator/div/a[3]")).getAttribute("class");
						    if(!pageclasses.contains("ui-state-disabled")){
						    	tblrowindex=1;
					        	driver.findElement(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/p-paginator/div/a[3]")).click();
					        	Thread.sleep(6000);
					        	utblrowcount=driver.findElements(By.xpath("//*[@id='Aber']/main/app-transactions/div/div[2]/div[2]/div[2]/div[2]/p-table/div/div/table/tbody/tr")).size();
						    }
						}
						
					}
				}

				//driver.quit();
				return true;
				
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
			if(getCmbsaliksite().equalsIgnoreCase("DXB")){	
			System.out.println("inside getsoup");
			Elements tabEl = null;
			Elements tableRowElements=null;
			if(v<=1)
			{


				/* VISHAKH.V.P */
				if(rtalogin==1) {
					
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[7]/a")).click();
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					
					/*driver.findElement(By.xpath("//*[@id='loginControl']/div[1]/div[1]/div[1]/input")).click();*/
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("window.scrollBy(0,150)");

					//driver.findElement(By.xpath("//*[@id='signupForm']/div[4]/button")).click();
					//Checking if old button is present - Login button changed in site 07-12-2021
					if(driver.findElements(By.xpath("//*[@id='signupForm']/div[4]/button")).size()>0){
						driver.findElement(By.xpath("//*[@id='signupForm']/div[4]/button")).click();
					}
					else{
						driver.findElement(By.xpath("//*[@id='btn_login']")).click();
					}
				} else {
					
					driver.findElement(By.id("username")).sendKeys(ts);
					driver.findElement(By.id("password")).sendKeys(pass);
					driver.findElement(By.xpath("//*[@id='main']/section/div/div/div/div/form/div[4]/input")).click();
					
				}
				
				Thread.sleep(6000);
				driver.findElement(By.xpath("/html/body/div[1]/section/div/nav/ul/li[5]/a")).click();
				/*driver.findElement(By.xpath("//*[@id='main']/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/div[2]/a")).click();
				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[1]/div/div[1]")).click();*/
				Thread.sleep(2000);
				
				boolean parkingresult=downloadParking(conn);
				

				WebElement elmtrips = driver.findElement(By.xpath("//*[@id='list']"));
				((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", elmtrips);
				driver.findElement(By.xpath("//*[@id='list']")).click();
				
				
				if(!getCmbtype().equalsIgnoreCase("lhrs")){
					driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[1]/div")).click();
				}				
				if(getCmbtype().equalsIgnoreCase("lhrs")){
			
					// driver.findElement(By.xpath("//*[@id='Range_24Hours']")).click();
					 driver.findElement(By.xpath("//*[@id='Range_24Hours']")).isSelected();
					
				}
				else if(getCmbtype().equalsIgnoreCase("ldays")){
					driver.findElement(By.xpath("//*[@id='Range_7days']")).click();
					//driver.findElement(By.xpath("//*[@id='Range_7days']")).isSelected();
				}
				else if(getCmbtype().equalsIgnoreCase("l30d")){
					driver.findElement(By.xpath("//*[@id='Range_30Days']")).click();
					driver.findElement(By.xpath("//*[@id='Range_30Days']")).isSelected();
					
				}
				/* VISHAKH.V.P */
				else if(getCmbtype().equalsIgnoreCase("customdates")){
					driver.findElement(By.xpath("//*[@id='StartDate']")).click();
					driver.findElement(By.id("StartDate")).sendKeys(getJqxStartDate());
					driver.findElement(By.xpath("//*[@id='EndDate']")).click();
					driver.findElement(By.id("EndDate")).sendKeys(getJqxEndDate());
				}
				/* VISHAKH.V.P ENDS*/
				if(qudraconfig==1){
					driver.findElement(By.xpath("//*[@id='TripeType']/option[text()='All types of trips']")).click();
				}
				else{
					driver.findElement(By.xpath("//*[@id='TripeType']/option[text()='Charged trips']")).click();
				}
				
				
				if(!(getTxtsaliktagno().equalsIgnoreCase(""))){
					
					driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[3]/div[1]")).click();
					driver.findElement(By.xpath("//*[@id='ByTag']")).click();
					driver.findElement(By.id("Tag_TagNumber")).sendKeys(getTxtsaliktagno().trim());

				}
				

				driver.findElement(By.xpath("//*[@id='FormTrips']/div/div[4]/button")).click();

					/* VISHAKH.V.P */
				
					Boolean iselementpresent=true;
					int pagecount=1;
					
					do{
	
						if(SATEXCELCONFIG.equalsIgnoreCase("1") && pagecount==1){
							
							/*iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
							
							if(iselementpresent==true){
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
							}
							//*[@id="RenderBody"]/section/div/div/div/div/div[1]/div[2]/a[2]
							driver.findElement(By.xpath("//*[@id='RenderBody']/section/div/div/div/div/div[1]/div[2]/a[2]")).click();
							pagecount++;
							
							Thread.sleep(1500);
							break;
							*/
						    
						    //Commenting above code because its not checking Excel is downloaded or not, checking load more button
						    //Done by Rahis - 22-06-2023
						    driver.findElement(By.xpath("//*[@id='RenderBody']/section/div/div/div/div/div[1]/div[2]/a[2]")).click();
                            pagecount++;
						    WebDriverWait wait = new WebDriverWait(driver,120);
						    Boolean filePresent=wait.until(filepresent(driver));
						    System.out.println("File Present:"+filePresent);
						    if(filePresent==true){
						        iselementpresent=false;
						        break;
						    }
						    
						} else if(SATEXCELCONFIG.equalsIgnoreCase("0")) {
						
							iselementpresent = driver.findElements(By.xpath("//*[@id='loadMore']")).size()!= 0;
		
							if(iselementpresent==true){
								driver.findElement(By.xpath("//*[@id='loadMore']")).click();
								pagecount++;
							}
						}
	
					} while(iselementpresent==true);
					/* VISHAKH.V.P ENDS*/
				
				
				try{
					ResultSet rs = conn.createStatement().executeQuery("Select coalesce((max(doc_no)+1),1) max from gl_salik");

					if(rs.next())
					{	
						xsadoc=0;
						xsadoc=rs.getInt("max");

						xdocs=xdocs+","+xsadoc;	
						xsasrno=0;
						
						if(session!=null) {
							String salikdocno=session.getAttribute("SALIKDOCNO")==null?"":session.getAttribute("SALIKDOCNO").toString();
		                    if(!salikdocno.contains(xsadoc+"")){
		                        if(salikdocno.trim().equalsIgnoreCase("")){
		                            salikdocno+=xsadoc;
		                        }
		                        else{
		                            salikdocno+=","+xsadoc;
		                        }
		                    }
		                    session.setAttribute("SALIKDOCNO", salikdocno);
						}
						
					}
					// request.setAttribute("xdocs", xdocs);
					setDocs(String.valueOf(xdocs));

				}catch (Exception e2) {
					e2.printStackTrace();
				}
				/* VISHAKH.V.P */
				if(SATEXCELCONFIG.equalsIgnoreCase("1")){
					System.out.println("Inside Excel Method");
					try{
					    
					
					SATEXCEL = SATEXCEL.replace("\\", "//");
					
		            FileInputStream input = new FileInputStream(SATEXCEL+"//ExportTrips.xls");
		            POIFSFileSystem fs = new POIFSFileSystem( input );
		            HSSFWorkbook wb = new HSSFWorkbook(fs);
		            HSSFSheet sheet = wb.getSheetAt(0);
		            Row excelRow;
		            
		            for(int i=15; i<(sheet.getLastRowNum()); i++){
		            	
		            	String transactionID="",tagNumber="",plate="";
		            	java.sql.Date tripsDate=null;
						java.sql.Date sd = null;
						double amount=0.00;
		            	
		            	SimpleDateFormat formatDate = new SimpleDateFormat("dd MMMM yyyy");
		            	excelRow = sheet.getRow(i);
		                
		                if(excelRow.getCell(2).getCellType()==1){
		                	transactionID = excelRow.getCell(2).getStringCellValue()=="" || excelRow.getCell(2).getStringCellValue()==null?"0":excelRow.getCell(2).getStringCellValue().replace("'", " ");
		                } else {
		                	transactionID = String.valueOf((int) excelRow.getCell(2).getNumericCellValue());	
		                }
		                if(transactionID.equalsIgnoreCase("") || transactionID==null || transactionID.equalsIgnoreCase("0")){
		                	continue;
		                }
		                java.util.Date tripDate = formatDate.parse(excelRow.getCell(3).getStringCellValue()=="" || excelRow.getCell(3).getStringCellValue()==null?"0":excelRow.getCell(3).getStringCellValue());
		                tripsDate = new java.sql.Date(tripDate.getTime());
		                
		                String tripTime = excelRow.getCell(5).getStringCellValue()=="" || excelRow.getCell(5).getStringCellValue()==null?"0":excelRow.getCell(5).getStringCellValue();
		                
		                time=tripTime;
						tformat=time.split(" ");
						timeappend=tformat[0].trim().substring(2,tformat[0].length());
						time=time.substring(0,time.indexOf(' '));

						if(tformat[1].trim().equalsIgnoreCase("PM")) {
							if(!tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
								time=time+timeappend;
							}
						}

						if(tformat[1].trim().equalsIgnoreCase("AM")) {
							if(tformat[0].substring(0,2).equals("12")) { 
								time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
								time=time+timeappend;
							}
						}
						
		                String transactionPostDate = excelRow.getCell(6).getStringCellValue()=="" || excelRow.getCell(6).getStringCellValue()==null?"0":excelRow.getCell(6).getStringCellValue();
		                String tollGate = excelRow.getCell(7).getStringCellValue()==""  || excelRow.getCell(7).getStringCellValue()==null?"0":excelRow.getCell(7).getStringCellValue();
		                String direction = excelRow.getCell(9).getStringCellValue()==""  || excelRow.getCell(9).getStringCellValue()==null?"0":excelRow.getCell(9).getStringCellValue();
		                
		                if(excelRow.getCell(14).getCellType()==1){
		                	tagNumber = excelRow.getCell(14).getStringCellValue()=="" || excelRow.getCell(14).getStringCellValue()==null?"0":excelRow.getCell(14).getStringCellValue().replace("'", " ");
		                } else {
		                	tagNumber = String.valueOf((int) excelRow.getCell(14).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(15).getCellType()==1){
		                	plate = excelRow.getCell(15).getStringCellValue()=="" || excelRow.getCell(15).getStringCellValue()==null?"0":excelRow.getCell(15).getStringCellValue().replace("'", " ");
		                } else {
		                	plate = String.valueOf((int) excelRow.getCell(15).getNumericCellValue());	
		                }
		                
		                if(excelRow.getCell(16).getCellType()==1){
		                	amount = Double.parseDouble(excelRow.getCell(16).getStringCellValue()=="" || excelRow.getCell(16).getStringCellValue()==null?"0":excelRow.getCell(16).getStringCellValue().replace("'", " "));
		                } else {
		                	amount = (double) excelRow.getCell(16).getNumericCellValue();
		                }
		                
		                xsasrno++;
						SATdownloadDAO dao=new SATdownloadDAO();
						if(qudraconfig==1){
							result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,"",direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"",salik_fdate,branch);
						}
						else{
							if(amount>0){
								//System.out.println("ts==="+ts+"===plate==="+plate+"===tagNumber==="+tagNumber+"===transactionID==="+transactionID+"===tripsDate==="+tripsDate+"===direction==="+direction+"===tollGate==="+tollGate+"===amount==="+amount+"===time==="+time+"===tripsDate==="+tripsDate+"===xsadoc==="+xsadoc+"===sd==="+sd+"===xsasrno==="+xsasrno+"===salik_fdate==="+salik_fdate+"===branch==="+branch);
								result=dao.salikInsert(ts,plate,tagNumber,transactionID,tripsDate,"",direction,tollGate,amount,time,tripsDate,xsadoc,sd,xsasrno,"",salik_fdate,branch);
							}
						}
		            }
		            
		            /*File currentFile = new File(SATEXCEL,"ExportTrips.xls");
		            currentFile.delete();*/
		            
		            File currentFolder = new File(SATEXCEL);
		            FileUtils.deleteDirectory(currentFolder);
		            return true;
					}
                    catch(Exception e){
                     e.printStackTrace();   
                    }
				} else {
					
					WebElement  mytable = driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table"));
	
					List<WebElement> rows_table = mytable.findElements(By.tagName("tr"));
	
					int rows_count = rows_table.size();
	
					int i=0;
	
					String Trans="";
					String Loc="";
					String Dir="";
					Double Amount=0.0;
					java.sql.Date dtvalue=null,dtripvalue=null;
					java.sql.Date sd = null;
					String plno="",tag="",src="";
	
	
					for (int row=0; row<rows_count; row++){
	
	
						List<WebElement> Columns_row = rows_table.get(row).findElements(By.tagName("td"));
	
						int columns_count = Columns_row.size();
	
						if(row%2!=0){
						String celtext1 =driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+row+"]/th/span")).getText();
						
						SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
						try{
	
							java.util.Date date = sdf1.parse(celtext1);
							dtvalue = new java.sql.Date(date.getTime());
	
	
						}
						catch(Exception e){
							e.printStackTrace();
						}
	
	
						try {
							java.util.Date dat = sdf1.parse(celtext1);
	//						System.out.println("==== "+dat);
							dtripvalue=new java.sql.Date(dat.getTime());
	// System.out.println("==== "+dtripvalue);
						} catch (ParseException e) {
							e.printStackTrace();
						}
						
	//					System.out.println("==celtext1===="+celtext1);
						}
						
						
	
						for (int column=0; column<columns_count; column++){
	
							//Thread.sleep(5000);
							if(row>0){
	
								String celtext = Columns_row.get(column).getText();
								//System.out.println("Cell Value Of row number "+row+" and column number "+column+" Is "+celtext);
								if(row%2!=0){
									if(column==0){
										time=celtext;
	
										tformat=time.split(" ");
										timeappend=tformat[0].trim().substring(2,tformat[0].length());
	
										time=time.substring(0,time.indexOf(' '));
	
										if(tformat[1].trim().equalsIgnoreCase("PM"))
										{
	//									 System.out.println("TAKING THE FIRST TIME"+(Integer.parseInt(tformat[0].substring(0,2))+12));
											if(!tformat[0].substring(0,2).equals("12"))
											{ 
												time=(Integer.parseInt(tformat[0].trim().substring(0,2))+12)+"";
												time=time+timeappend;
	
											}
										}
	
	
										if(tformat[1].trim().equalsIgnoreCase("AM"))
										{
											//System.out.println("Time.parse(((((((((((((("+Time.parse(time)+12);
	
											if(tformat[0].substring(0,2).equals("12"))
											{ 
												time=(Integer.parseInt(tformat[0].trim().substring(0,2))-12)+"";
												time=time+timeappend;
	
											}
										}
	
	
	
	//									System.out.println("===time===="+time);
									}
									if(column==1){
									//	System.out.println("==celtext.length()===="+celtext.length());
										if(!celtext.equalsIgnoreCase("") && celtext!=null){
											plno=celtext.substring(celtext.length()-5, celtext.length());
										}
										else{
											plno="";
										}

	//									System.out.println("===plno===="+plno);
	
									}
									if(column==2){
	
										src=celtext;
	//									System.out.println("===src===="+src);
	
									}
									if(column==3){
	
										Dir=celtext;
	//									System.out.println("===Dir===="+Dir);
	
									}
									if(column==4){
	
										Amount=Double.parseDouble(celtext);
	//									System.out.println("===Amount===="+Amount);
	
									}
								}
								if(row%2==0){
	
									if(column==2){
										tag=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===tag===="+tag);
									}
									if(column==3){
										Trans=celtext.replaceAll("[^0-9]", "").trim();
	//									System.out.println("===Trans===="+Trans);
	
									}
	
	/*								if(column==4){
										String	 data = celtext;//.substring(0,rowItems.get(j).text().indexOf(' ') );
	
										SimpleDateFormat sdf1 = new SimpleDateFormat("dd MMMM yyyy");
										try{
	
											java.util.Date date = sdf1.parse(data);
											dtvalue = new java.sql.Date(date.getTime());
	
	
										}
										catch(Exception e){
											e.printStackTrace();
										}
	
	
										try {
											java.util.Date dat = sdf1.parse(data);
	
											dtripvalue=new java.sql.Date(dat.getTime());
	
										} catch (ParseException e) {e.printStackTrace();}
	
	
	
									}*/
	
								}
	
								if(column==5){
	
									if(row%2!=0){
	
										//System.out.println("//*[@id='trips-container']/div[1]/table/tbody/tr["+(row)+"]/td[6]/button");
/*										By loadingImage = By.id("//*[@id='trips-container']/div[1]/table/tbody/tr["+(row)+"]/td[6]/button");

										WebDriverWait wait = new WebDriverWait(driver, 0);

										wait.until(ExpectedConditions.invisibilityOfElementLocated(loadingImage));*/
										
										 JavascriptExecutor js = (JavascriptExecutor) driver;
										 // This  will scroll down the page by  1000 pixel vertical		
									        js.executeScript("window.scrollBy(0,1000)");
									        
										driver.findElement(By.xpath("//*[@id='trips-container']/div[1]/table/tbody/tr["+(row)+"]/td[6]/button")).click();
										Thread.sleep(5000);
	
									}
	
								}
	
	
	
	
	
							}
	
						}
	
						if(row%2==0 && row>0){
							xsasrno++;
							SATdownloadDAO dao=new SATdownloadDAO();
							if(qudraconfig==1){
								result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);
							}
							else{
								if(Amount>0){
									result=dao.salikInsert(ts,plno,tag,Trans,dtripvalue,Loc,Dir,src,Amount,time,dtvalue,xsadoc,sd,xsasrno,"",salik_fdate,branch);
								//	System.out.println("===plno=="+plno+"===src==="+src+"===Dir===="+Dir+"=====amount==="+Amount+"===tag=="+tag+"===Trans=="+Trans+"===dtripvale"+dtripvalue);
								}
							}
	
							
						}
	
	
	
					}
					
				  }
				  /* VISHAKH.V.P. ENDS*/	

			}
		}
		}
		return  result;


	}

	private void detailsNewlyOpenedwindow(String disc, String fees, int k, String remark,int srno,Connection conn) 
	{
//		System.out.println("Opened Window Parameters:"+disc+"::"+fees+"");
		//		disc="";
		//		fees="";
		String plate_source="",Time="",fine_Source="",regNo="",PlateCategory="",pcolor="",Ticket_No="",Tick_violat="",DESC1="",type="",LicenseNo="",LicenseFrom="",NotPayReason="",location="",fine="",remarks="",tcno="";
		java.sql.Date traffic_date=null,sd = null;
		Double Amount=0.0;

		try{


			Set<String> windowHandles1 = driver.getWindowHandles();
			int size = windowHandles1.size();

			for (String string : windowHandles1) 
			{
				driver.switchTo().window(string);

				if(string.equals(defaultwindow))
				{ //driver.manage().window().setPosition(new Point(0, 0));
					//System.out.println("On Main Window");
					//Reporter.log("On Main Window");

				}
				else
				{
					//	        	   org.openqa.selenium.Dimension screenResolution = new org.openqa.selenium.Dimension(-2000,-2000);
					//	        	   driver.manage().window().setSize(screenResolution);
					//	        	   driver.manage().window().setPosition(new Point(-2000, -2000));
					((JavascriptExecutor)driver).executeScript("window.resizeTo(0, 0);");
					docDet= Jsoup.parse(driver.getPageSource());
					Elements tabEl = null;
					tabEl = docDet.select("table#dtTicDetails");


					Elements tableHeaderEles = tabEl.select("thead tr th");

					for (int i = 0; i < tableHeaderEles.size(); i++) {

					}
					//System.out.println();

					Elements tableRowElements = tabEl.select("tr");

					tcno=tcno1;
					for (int j = 0; j < tableRowElements.size(); j++) {

						Element row = tableRowElements.get(j);
						Elements rowItems = row.select("span");
						String tddata="";
						int a=0;
						for (Element nextTurn : rowItems) {


							tddata=nextTurn.text();

							//System.out.println("===jjj========"+j+"====aaaaaa===="+a+"=tddatatddatatddatatddata==="+tddata);
							if((j==18)&&(a==0)){
								DESC1=tddata;
							}
							a=a+1;


						}

						//System.out.println("Data in the detail window"+j+"daaaatttaaaa"+tddata);
						if(j==0)
							//		ck      	
							//		      		  descriptionPane.setText(descriptionPane.getText()+"Fine# "+tddata);		      		
							//descriptionPane.update(descriptionPane.getGraphics());
						{
							Ticket_No=tddata;
							continue;
						}
						//System.out.println("===="+tddata);
						if(j==3){
							String tddatadate = tddata;

							traffic_date=com.getSqlDate(tddatadate);
							//System.out.println("===="+traffic_date);							
						}
						if(j==4)
						{
							Time=tddata;
						}
						if(j==2)
						{
							fine_Source=tddata;
						}
						if(j==8)
						{
							location=tddata;
						}
						if(j==9){
							//pcolor=tddata;
							regNo=tddata;
						}

						if(j==13){
							plate_source=tddata;

						}



						if(j==13){
							plate_source=tddata;

						}

						if(j==11){

							String cat="";
							try{
								//Connection conn = ClsConnection.getMyConnection();
								String z="";

							}catch (Exception e) {
								e.printStackTrace();
							}
							finally{
								cat=tddata;
							}
							PlateCategory=tddata;
							pcolor=cat;
						}


						if(j==16)
						{
							LicenseNo=tddata;
						}
						if(j==17)
						{
							LicenseFrom=tddata;
						}
						if(j==7)
						{
							NotPayReason=" ";
						}
						if(j==3)
						{
							Amount=Double.parseDouble(disc);
						}
						if(j==10){
							regNo=tddata;
						}
						if(j==12){
							pcolor=tddata;
						}
						if(j==14){
							plate_source=tddata;
						}
						fine=fees;
						remarks=remark;


						java.util.Date date=new java.util.Date();

						sd=com.getSqlDate(date);
						type="TRF";

					}

					//System.out.println("====Ticket_No====="+Ticket_No+"==DESC1======"+DESC1);
					
					if(getCmbtrafficsite().equalsIgnoreCase("AUH")&& getCategory().equalsIgnoreCase("traffic")){
						tcno=ts;
					}
					
					SATdownloadDAO dao=new SATdownloadDAO();
					boolean result=dao.trafficInsert(Ticket_No,traffic_date,Time,fine_Source,regNo,PlateCategory,pcolor,LicenseNo,
							LicenseFrom,NotPayReason,Amount,location,fine,remarks,sd,type,category,srno,tcno,xdoc,sd,branch,
							plate_source,getCmbtrafficsite(),DESC1,xdocs,"");
					setDocs(String.valueOf(xdocs));

					serno=k;
					srno=srno+k;



					driver.close();

					docDet=null;
				}

				driver.switchTo().window(defaultwindow);

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void loadData() throws IOException, InterruptedException
	{
		ArrayList list =new ArrayList();
		HashMap map =new HashMap();

		try{




/*
			ResultSet rsload = conn.createStatement().executeQuery("Select Salik_User,Trans,salik_date,salik_time,sal_date,regNo,Source,TagNo,Location,Direction,Amount,date from gl_salik where Doc_no in ("+xdocs+")");


			while(rsload.next())
			{	


			}	
*/		}catch (Exception e2) {e2.printStackTrace();}




	}

	public boolean inputCaptcha(String xPmsg,Connection conn) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";
		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			DownloadImage(By.xpath("//img[contains(@src,'CaptchaImage')]"),imgPath);

			Thread.sleep(30000);

			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("SearchCapthcaControl")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource()); 
				Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 
				Thread.sleep(5000);
				if (xSrch){

					driver.findElement(By.id("btnSearch")).click();

				}

			}while(getCaptcha()==null);

			try
			{
				WebElement we=null;
				int count=0;
				int cnt=0;
				//Thread.sleep(8000);
				do
				{  

					////--commented by krish
					we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_RadAjaxPanelPlate"));
					setCaptchacount(0);
					String style = we.getAttribute("style").trim();

					if (!style.isEmpty())
						we=null;
					cnt++;
				}while(we==null && cnt<10);
				count++;

				Thread.sleep(5000);

				we = driver.findElement(By.id("ctl00_WorkSpace_ctlCustAVIHistory_lblErrorMessage"));
				String errMsg = we.getText().trim();


				if (!(errMsg.isEmpty() || errMsg.equals("") ||errMsg=="" || errMsg==null  ))
				{	
					setCaptchacount(1);
					driver.quit();
					flag=false;
					setMsg("Captcha Entered is wrong,Please Try Again!!");
					return flag;

					/*System.out.println("errMsg.isEmpty - "+errMsg);
							inputCaptcha("The code you typed has expired after 90 seconds.");*/
					//return;
				}

			}catch(Exception e){e.printStackTrace();}



		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}

	public boolean inputCaptchaDXB(String xPmsg,Connection conn) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";
		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			DownloadImage(By.xpath("//img[contains(@src,'captchaGenerator')]"),imgPath);

			Thread.sleep(30000);


			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");

				/*WebElement txtcaptcha=driver.findElement(By.xpath("//img[contains(@src,'CaptchaImage')]"));
			 System.out.println("=====txtcaptcha==txtcaptcha==txtcaptcha=="+txtcaptcha);*/
				//setCaptchatxt(SATdownloadDAO.loadCaptchatext(getCaptchatxt()));		
				driver.findElement(By.id("securityCodeId")).sendKeys(getCaptcha().trim());
				doc= Jsoup.parse(driver.getPageSource());

				driver.findElement(By.id("btnSearchByPlate")).click();
				/*Elements tabEl = doc.select("table#WorkSpace_ctlCustAVIHistory_rgResult_ctl01");
				boolean xSrch = (tabEl.isEmpty()); 

				if (xSrch){

					driver.findElement(By.id("btnSearchByPlate")).click();

				}*/

			}while(getCaptcha()==null);





		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}
	
	//Vishakh Starts
	public boolean inputCaptchaTrafficAUH(String xPmsg,Connection conn) throws UnsupportedEncodingException, SQLException
	{


		boolean flag=true;
		HttpServletRequest request=ServletActionContext.getRequest();
		String realPath = request.getRealPath("/captcha.png");
		HttpSession session=request.getSession();
		String code="";

		String fname=code+'-'+doc+'-'+srno;
		String fname2=fname;

		String dirname =code==null?"Default":code;
		String path ="";
		Statement stmt1 = conn.createStatement();
		String strSql1 = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("captchaPath");
			setCaptchapath(path);
		}

		String imgPath = getCaptchapath()+"/captcha.png";

		try
		{
			File temp=new File(imgPath);
			if (temp.exists()){

			}
			temp.delete();

			Thread.sleep(2000);
			
			DownloadImage(By.id("ctl00_ContentPlaceHolder1_imgCaptcha"),imgPath);
			
			Thread.sleep(30000);

			do{ 

				setCaptcha(SATdownloadDAO.loadCaptcha()+"");
				
				driver.findElement(By.id("ctl00_ContentPlaceHolder1_txtCaptcha")).sendKeys(getCaptcha().trim());

			    driver.findElement(By.id("ctl00_ContentPlaceHolder1_Btn_Submit")).click();

			}while(getCaptcha()==null);

			try
			{
				WebElement we=null;
				int count=0;
				int cnt=0;
				//Thread.sleep(8000);
				do
				{  

					we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblError"));
					
					setCaptchacount(0);
					String style = we.getAttribute("style").trim();

					if (!style.isEmpty())
						we=null;
					cnt++;
				}while(we==null && cnt<10);
				count++;

				Thread.sleep(5000);
				
				we = driver.findElement(By.id("ctl00_ContentPlaceHolder1_lblError"));
				
				String errMsg = we.getText().trim();
				
				if (!(errMsg.isEmpty() || errMsg.equals("") ||errMsg=="" || errMsg==null  ))
				{	
					setCaptchacount(1);
					driver.quit();
					flag=false;
					setMsg("Captcha Entered is wrong,Please Try Again!!");
					return flag;

				}

			}catch(Exception e){e.printStackTrace();}



		}catch(Exception e){
			e.printStackTrace();
		}
		return flag;
	}
	//Vishakh Ends

	public void DownloadImage(By by,String loc)
	{
		try
		{


			HttpServletRequest request=ServletActionContext.getRequest();

			WebElement Image=driver.findElement(by);



			File screen=((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
			//File screen=driver.save_screenshot('screenie.png');

			int width=Image.getSize().getWidth();
			int height=Image.getSize().getHeight();
			BufferedImage img=ImageIO.read(screen);

			BufferedImage dest=img.getSubimage(Image.getLocation().getX(), Image.getLocation().getY(), width, height);
			ImageIO.write(dest, "png", screen);
			request.setAttribute("image",screen);
			File temp=new File(loc);
			copyFile(screen,temp);
			setIscaptchaloaded(1);


		}catch(Exception e){e.printStackTrace();}


	}

	public  void copyFile(File source, File dest)
			throws IOException {
		Files.copy(source.toPath(), dest.toPath());
	}

	public void reloaddata(){
		setCategory(getCategory());
		setChck_salikautomatic(getChck_salikautomatic());
		setChck_trafficautomatic(getChck_trafficautomatic());
		setCmbsaliksite(getCmbsaliksite());
		setHidcmbtype(getCmbtype());
		setHidcmbsaliksite(getCmbsaliksite());
		setHidcmbtrafficsite( getCmbtrafficsite());
		setCmbtrafficsite(getCmbtrafficsite());
		setHidChck_trafficfileno(getChck_trafficfileno());
	}

	public void run() {

	    System.out.println("Inside Salik Auto Method");
		String result="";
		ResultSet rsrun;
		String runquery="";
		Connection conn = null;
		
		try{
			conn=connobj.getMyConnection();
			/*stmtrun=conn.createStatement();
			runquery="Select site, time_period, category, username, url, iscaptcha, password, remarks from gl_autowebid";

			rsrun=stmtrun.executeQuery(runquery);*/
			ArrayList<String> webidarray = new ArrayList<String>();
			
			ArrayList<String> columnarray=new ArrayList<String>();
			Statement stmt=conn.createStatement();
			String strcolumns="desc gl_webid";
			ResultSet rscolumns=stmt.executeQuery(strcolumns);
			while(rscolumns.next()) {
				columnarray.add(rscolumns.getString("Field"));
			}
			boolean skipPresent=false;
			String strskip="";
			if(columnarray.contains("skip")) {
				skipPresent=true;
				strskip=" and skip=0";
			}
			
			String sql="Select site, time_period, category, username, url, iscaptcha, password, sitecheck from gl_webid where REMARKS in ('Salik','Traffic Fines') AND iscaptcha=0 "+strskip+" order by url";
			//System.out.println(sql);
			rsrun = conn.createStatement().executeQuery(sql);

			while(rsrun.next())
			{	
				
				webidarray.add(rsrun.getString("category")+" ::"+rsrun.getString("sitecheck")+" ::"+rsrun.getString("username")+" ::"+rsrun.getString("site")+" ::"+rsrun.getString("time_period"));
				
				/*setCategory(rsrun.getString("category"));
				if(rsrun.getString("category").equalsIgnoreCase("traffic")){
					
					setChck_trafficautomatic(rsrun.getString("sitecheck"));
					setChck_trafficfileno(rsrun.getString("sitecheck"));
					setTxttrafficplateno(rsrun.getString("username"));
					setCmbtrafficsite(rsrun.getString("site"));
					
					
					
				}
				else if(rsrun.getString("category").equalsIgnoreCase("salik")){
					
					setTxtusername(rsrun.getString("username"));
					setCmbsaliksite(rsrun.getString("site"));
					setCmbtype(rsrun.getString("time_period"));
				}*/

				//System.out.println("Category ="+rsrun.getString("category")+"==User Name ="+rsrun.getString("username")+"=Site ="+rsrun.getString("site"));
				//process();
			}
			
			for(int i=0;i< webidarray.size();i++){
			    //System.out.println("Inside Run Method For Loop"+i);
				String[] webids=webidarray.get(i).split("::");
				
				//setCategory(webids[0].trim());
				setCategory("");
				setCmbsaliksite("");
				setCmbtrafficsite("");
				if(webids[0].trim().equalsIgnoreCase("Traffic Fines")){
					setCategory("traffic");
					setChck_trafficautomatic(webids[1].trim());
					setChck_trafficfileno("trafficfileno");
					setTxttrafficplateno(webids[2].trim());
					setCmbtrafficsite(webids[3].trim());
					
				}
				else if(webids[0].trim().equalsIgnoreCase("salik")){
					setCategory("salik");
					setTxtusername(webids[2].trim());
					setCmbsaliksite(webids[3].trim());
					setCmbtype(webids[4].trim());
				}

//				System.out.println("Category ="+webids[0].trim()+"==User Name ="+webids[2].trim()+"=Site ="+webids[3].trim());
				// if(i>0){
				if(i<webidarray.size()){
					startTime=0;
					endTime=0;
					startTime=System.currentTimeMillis();
				    String loadstatus=downloadProcess(conn);
				    //System.out.println("Download Status:"+loadstatus);
				}
				
				// }
			}
			
			result="success";
		}
		catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		finally{
			//System.out.println("Inside Finally");
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public ExpectedCondition<Boolean> filepresent(WebDriver driver) {
        
        return new ExpectedCondition<Boolean>() {
            @Override
            public Boolean apply(WebDriver driver) {
                File f = new File(SATEXCEL+"//ExportTrips.xls"); 
                return f.exists();
            }
            @Override
            public String toString() {
              return String.format("file to be present within the time specified");
            }
            
        };
    }
	
	
	public java.sql.Date getOneMonthBeforeDate(Connection conn) {
		// TODO Auto-generated method stub
		java.sql.Date sqlbasedate=null;
		try {
			String interval="1 MONTH";
			//System.out.println("Request Check:"+ServletActionContext.getRequest());
			HttpServletRequest request=null;
			HttpSession session=null;
			
			try {
				request=ServletActionContext.getRequest();
				session=request.getSession();
				if(session.getAttribute("AUTOSALIKTYPE")!=null && session.getAttribute("AUTOSALIKTYPE").toString().trim().equalsIgnoreCase("1")) {
					interval="3 DAY";
				}
			}
			catch(NullPointerException e) {
				System.out.println("Session not available on Auto Download");
			}
			
			String stronemonthbefore="SELECT DATE_SUB(CURDATE(),INTERVAL "+interval+") basedate";
			//System.out.println(stronemonthbefore);
			
			ResultSet rsonemonthbefore=conn.createStatement().executeQuery(stronemonthbefore);
			while(rsonemonthbefore.next()) {
				sqlbasedate=rsonemonthbefore.getDate("basedate");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return sqlbasedate;
	}

	public boolean checkIdleErrorExist(String errortype) {
		try {
			if(errortype.equalsIgnoreCase("1")) {
				String searchText = "* This user can only access this page from 00:01 to 23:59";
		        boolean status=driver.findElements(By.xpath("//*[@id='readMe']/div[2]/div/div/div[1]/div/p[1][text()='" + searchText + "']")).size()>0;
		        if(status) {
		        	return status;
		        }
		        else {
		        	searchText="* 101 : Dear Customer you have no permission to open requested page";
		        	status=driver.findElements(By.xpath("/html/body/div[3]/div[2]/div/div/div/div[1]/div/p[1][text()='" + searchText + "']")).size()>0;
		        	if(status) {
		        		return status;
		        	}
		        	else {
		        		long curTime=System.currentTimeMillis();
		        		long duration=curTime-startTime;
		        		long hrs=4*60*60*1000;
		        		if(duration>hrs) {
		        			System.out.println("Dropping Driver due to long idle browser");
		        			return true;
		        		}
		        		
		        	}
		        }
			}
		}
		catch(Exception e) {
			System.out.println("Idle Error Exception");
			e.printStackTrace();
		}
		return false;
	}
	
	private boolean downloadParking(Connection conn) {
		// TODO Auto-generated method stub
		
		try{
			driver.findElement(By.xpath("//*[@id='parking']")).click();
			Thread.sleep(2000);
			JavascriptExecutor jsfilter = (JavascriptExecutor) driver;
			jsfilter.executeScript("window.scrollBy(0,200)");
			if(!getCmbtype().equalsIgnoreCase("lhrs")){
				driver.findElement(By.xpath("//*[@id='FormParkingTrips']/div/div[1]/div")).click();
				Thread.sleep(1000);
			}
			/*if(getCmbtype().equalsIgnoreCase("lhrs")){
				driver.findElement(By.xpath("//*[@id='ParkingRange_24Hours']")).click();
			}*/
			if(getCmbtype().equalsIgnoreCase("ldays")){
				driver.findElement(By.xpath("//*[@id='ParkingRange_7days']")).click();
				Thread.sleep(1000);
			}
			else if(getCmbtype().equalsIgnoreCase("l30d")){
				driver.findElement(By.xpath("//*[@id='ParkingRange_30Days']")).click();
				Thread.sleep(1000);
			}
			else if(getCmbtype().equalsIgnoreCase("customdates")){
				driver.findElement(By.xpath("//*[@id='ParkingStartDate']")).click();
				driver.findElement(By.id("ParkingStartDate")).sendKeys(getJqxStartDate());
				Thread.sleep(1000);
				driver.findElement(By.id("ParkingStartDate")).sendKeys(Keys.ENTER);
				Thread.sleep(1000);
				driver.findElement(By.xpath("//*[@id='ParkingEndDate']")).click();
				driver.findElement(By.id("ParkingEndDate")).sendKeys(getJqxEndDate());
				Thread.sleep(1000);
				driver.findElement(By.id("ParkingEndDate")).sendKeys(Keys.ENTER);
				
				Thread.sleep(2000);
			}
			int qudraAllSalik=0;
			ResultSet rsallsalik=conn.createStatement().executeQuery("select method from gl_config where field_nme='qudraAllSalik'");
			while(rsallsalik.next()){
				qudraAllSalik=rsallsalik.getInt("method");
			}
			if(qudraAllSalik!=1){
				driver.findElement(By.xpath("//*[@id='ParkingTripeType']/option[text()='Charged Parking']")).click();
			}
			
			if(!(getTxtsaliktagno().equalsIgnoreCase(""))){
				
				driver.findElement(By.xpath("//*[@id='FormParkingTrips']/div/div[3]/div[1]")).click();
				driver.findElement(By.xpath("//*[@id='ParkingByTag']")).click();
				driver.findElement(By.id("Parking_Tag_TagNumber")).sendKeys(getTxtsaliktagno().trim());
			}
			driver.findElement(By.xpath("//*[@id='FormParkingTrips']/div/div[4]/button")).click();
			Thread.sleep(2000);
			if(driver.findElements(By.xpath("//*[@id='parkingTripsTable']")).size()<=0){
				return false;
			}
			WebElement elmtable=driver.findElement(By.xpath("//*[@id='parkingTripsTable']"));
			List<WebElement> rows = elmtable.findElements(By.xpath("//tbody/tr"));
			
			
			// Iterate through each row
	        for (int i = 0,j=1; i < rows.size(); i += 2,j+=2) { // Step by 2 because there are detailed rows following each main row
	        	
	        	driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[7]/button")).click();
	        	
	            // Process main row
	            String date = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/th/span")).getText();
	            String duration = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[1]/span")).getText();
	            String plate = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[2]/span")).getText();
	            String regno="",platecode="";
	            if(plate.contains(" ")){
	            	int splitlength=plate.split(" ").length;
	            	if(splitlength>2){
	            		regno=plate.split(" ")[2];
		            	platecode=plate.split(" ")[1];
	            	}
	            	else{
	            		regno=plate.split(" ")[1];
		            	platecode=plate.split(" ")[0];
	            	}
	            }
	            else{
	            	regno=plate;
	            }
	            String location = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[3]/span")).getText();
	            String parkingZone = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[4]/span")).getText();
	            String amount = driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+j+"]/td[5]/span[2]")).getText();
	            //String pendingAmount = columns.get(5).getText().trim();
	            
	            // Convert date to SQL format (yyyy-MM-dd)
	            java.sql.Date sqldate = convertDateToSQLFormat(date);
	            
	            // Print main row details
	            System.out.print(date + "\t" + duration + "\t" + plate + "\t" + location + "\t" + parkingZone + "\t" + amount + "\t");
	            
	            // Process detailed row if exists
	            
	            String timeIn=driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+(j+1)+"]/td[2]/div/span[2]")).getText();
	            timeIn = convertTimeTo24HourFormat(timeIn);
	            String tagNumber=driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+(j+1)+"]/td[4]/div/span[2]")).getText();
	            String transactionID=driver.findElement(By.xpath("//*[@id='parkingTripsTable']/tbody/tr["+(j+1)+"]/td[5]/div/span[2]")).getText();
	            
	            boolean result=dao.salikParkingInsert(ts,regno,tagNumber,transactionID,sqldate,location,parkingZone,"Dubai",Double.parseDouble(amount),timeIn,sqldate,xsadoc,sqldate,xsasrno,"",salik_fdate,branch);
	        
	        }

	        return true;
		}
		catch(Exception ex){
			ex.printStackTrace();
			return false;
		}
		
	}
	
	

	private java.sql.Date convertDateToSQLFormat(String date) {
        try {
            SimpleDateFormat originalFormat = new SimpleDateFormat("dd MMM yyyy");
            Date parsedDate = originalFormat.parse(date);
            return new java.sql.Date(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
	
	private String convertTimeTo24HourFormat(String time) {
        try {
            SimpleDateFormat originalFormat = new SimpleDateFormat("hh:mm a");
            SimpleDateFormat targetFormat = new SimpleDateFormat("HH:mm");
            Date parsedTime = originalFormat.parse(time);
            return targetFormat.format(parsedTime);
        } catch (ParseException e) {
            e.printStackTrace();
            return time;
        }
    }
	
	
}
