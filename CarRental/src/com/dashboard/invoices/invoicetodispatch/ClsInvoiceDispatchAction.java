package com.dashboard.invoices.invoicetodispatch;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.finance.transactions.creditnote.ClsCreditNoteBean;
import com.finance.transactions.creditnote.ClsCreditNoteDAO;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsInvoiceDispatchAction extends ActionSupport {

	private Map<String, Object> param = null;
	public Map<String, Object> getParam() {
				return param;
			}

			public void setParam(Map<String, Object> param) {
				this.param = param;
			}
	
	public void sendDispatchMail() throws SQLException {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String mailtype=request.getParameter("mailtype")==null?"SEP":request.getParameter("mailtype");
		String strdocarray=request.getParameter("docarray")==null?"":request.getParameter("docarray");
		Connection conn=null;
		ArrayList<String> docarray=new ArrayList<String>();
		if(!strdocarray.trim().equalsIgnoreCase("")) {
			if(strdocarray.contains(",")) {
				for(int i=0;i<strdocarray.split(",").length;i++) {
					docarray.add(strdocarray.split(",")[i]);
				}
			}
			else {
				docarray.add(strdocarray);
			}
		}
		
		String strorderby="";
		if(mailtype.equalsIgnoreCase("CRM")) {
			strorderby=" order by base.cldocno";
		}
		else if(mailtype.equalsIgnoreCase("AGMT")) {
			strorderby=" order by base.agmttype,base.agmtdocno";
		}
		String strtrno="";
		for(int i=0;i<docarray.size();i++) {
			strtrno+=(strtrno.trim().equalsIgnoreCase("")?docarray.get(i).split("::")[0]:","+docarray.get(i).split("::")[0]);
		}
		
		
		ClsConnection objconn=new ClsConnection();
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int cldocno=0;
			String agmttype="";
			int agmtdocno=0;
			java.util.List<File> listfile=new ArrayList<File>();
			int docno=0,brhid=0;
			String dtype="";
			
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
			
			String strmsg = "SELECT msg,SUBJECT,coalesce(cc,'') cc FROM gl_emailmsg WHERE dtype='BIVD'";
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
			String strdocs=" SELECT * FROM (SELECT inv.voc_no vocno,inv.tr_no,inv.doc_no,inv.brhid,ac.cldocno,ac.mail1,inv.dtype,DATE_FORMAT(inv.date,'%M - %Y') monthyear,"
					+ "jvdet.rdocno agmtdocno,jvdet.rtype agmttype FROM gl_invm inv LEFT JOIN my_acbook ac ON (inv.CLDOCNO=ac.cldocno and ac.dtype='CRM') "
					+ "LEFT JOIN (SELECT rdocno,rtype,tr_no FROM my_jvtran WHERE STATUS=3 GROUP BY tr_no) jvdet ON inv.tr_no=jvdet.tr_no WHERE inv.status=3 and inv.tr_no in ("+strtrno+") "
					+ "UNION ALL SELECT cno.doc_no vocno,cno.tr_no,cno.doc_no,cno.brhid,ac.cldocno,ac.mail1,cno.dtype,DATE_FORMAT(cno.date,'%M - %Y') monthyear,"
					+ "jvdet.rdocno agmtdocno,jvdet.rtype agmttype FROM my_cnot cno LEFT JOIN my_acbook ac ON cno.acno=ac.acno LEFT JOIN (SELECT rdocno,rtype,tr_no FROM my_jvtran "
					+ "WHERE STATUS=3 GROUP BY tr_no) jvdet ON cno.tr_no=jvdet.tr_no WHERE cno.status=3 AND cno.dtype IN ('TCN','CNO') and cno.tr_no in ("+strtrno+")) base "+strorderby;
			System.out.println("print query==="+strdocs);  
			System.out.println("Mail Type:"+mailtype);
			ResultSet rsdocs=stmt.executeQuery(strdocs);
			String clientmail="",vocno="";
			String monthyear="";
			
			while(rsdocs.next()) {
				vocno=rsdocs.getString("vocno");
				docno=rsdocs.getInt("doc_no");
				brhid=rsdocs.getInt("brhid");
				dtype=rsdocs.getString("dtype");
				
				if(mailtype.equalsIgnoreCase("SEP")) {
					cldocno=0;
					listfile=new ArrayList<File>();
					cldocno=rsdocs.getInt("cldocno");
					clientmail=rsdocs.getString("mail1");
					monthyear=rsdocs.getString("monthyear");
					listfile.add(getPDFFile(conn,docno,brhid,dtype,request,session,response,vocno));
					mailcc=getExtraCC(cldocno,conn);
					sendEmailwithMultiplepdf(host, port, userName, password, clientmail, mailsubject+" "+monthyear,mailmsg, listfile, docno+"",mailcc,imgsignaturepath);
					mailedtrno=rsdocs.getString("tr_no");
					updateMailed(mailedtrno, conn, session);
				}
				else if(mailtype.equalsIgnoreCase("AGMT")) {
					if(agmtdocno==0 && agmttype.equalsIgnoreCase("")) {
						agmtdocno=rsdocs.getInt("agmtdocno");
						agmttype=rsdocs.getString("agmttype");
						monthyear=rsdocs.getString("monthyear");
						
					}
					
					if(agmtdocno!=rsdocs.getInt("agmtdocno") || !agmttype.equalsIgnoreCase(rsdocs.getString("agmttype"))) {
						//send Mail
						System.out.println("Inside Send Mail"+cldocno+"::"+rsdocs.getInt("cldocno")+"::"+listfile.size());
						mailcc=getExtraCC(cldocno,conn);
						sendEmailwithMultiplepdf(host, port, userName, password, clientmail, mailsubject+" "+monthyear,mailmsg, listfile, docno+"",mailcc,imgsignaturepath);
						cldocno=0;
						agmtdocno=0;
						agmttype="";
						clientmail="";
						listfile=new ArrayList<File>();
						updateMailed(mailedtrno, conn, session);
						mailedtrno="";
						agmtdocno=rsdocs.getInt("agmtdocno");
						agmttype=rsdocs.getString("agmttype");
						monthyear=rsdocs.getString("monthyear");
						clientmail=rsdocs.getString("mail1");
						listfile.add(getPDFFile(conn,docno,brhid,dtype,request,session,response,vocno));
						if(mailedtrno.equalsIgnoreCase("")) {
							mailedtrno=rsdocs.getString("tr_no");
						}
						else {
							mailedtrno+=","+rsdocs.getString("tr_no");
						}
					}
					else {
						listfile.add(getPDFFile(conn,docno,brhid,dtype,request,session,response,vocno));
						if(mailedtrno.equalsIgnoreCase("")) {
							mailedtrno=rsdocs.getString("tr_no");
						}
						else {
							mailedtrno+=","+rsdocs.getString("tr_no");
						}
					}
				}
				else if(mailtype.equalsIgnoreCase("CRM")) {
					if(cldocno==0) {
						cldocno=rsdocs.getInt("cldocno");
						monthyear=rsdocs.getString("monthyear");
						clientmail=rsdocs.getString("mail1");
					}
					
					if(cldocno!=rsdocs.getInt("cldocno")) {
						//send Mail
						System.out.println("Inside Send Mail"+cldocno+"::"+rsdocs.getInt("cldocno")+"::"+listfile.size());
						mailcc=getExtraCC(cldocno,conn);
						sendEmailwithMultiplepdf(host, port, userName, password, clientmail, mailsubject+" "+monthyear,mailmsg, listfile, docno+"",mailcc,imgsignaturepath);
						cldocno=0;
						listfile=new ArrayList<File>();
						updateMailed(mailedtrno, conn, session);
						mailedtrno="";
						cldocno=rsdocs.getInt("cldocno");
						monthyear=rsdocs.getString("monthyear");
						clientmail=rsdocs.getString("mail1");
						listfile.add(getPDFFile(conn,docno,brhid,dtype,request,session,response,vocno));
						if(mailedtrno.equalsIgnoreCase("")) {
							mailedtrno=rsdocs.getString("tr_no");
						}
						else {
							mailedtrno+=","+rsdocs.getString("tr_no");
						}
						
					}
					else {
						listfile.add(getPDFFile(conn,docno,brhid,dtype,request,session,response,vocno));
						if(mailedtrno.equalsIgnoreCase("")) {
							mailedtrno=rsdocs.getString("tr_no");
						}
						else {
							mailedtrno+=","+rsdocs.getString("tr_no");
						}
					}
				}
				
			}
			if(!mailtype.equalsIgnoreCase("SEP")) {
				mailcc=getExtraCC(cldocno,conn);
				sendEmailwithMultiplepdf(host, port, userName, password, clientmail, mailsubject+" "+monthyear,mailmsg, listfile, docno+"",mailcc,imgsignaturepath);
				cldocno=0;
				agmtdocno=0;
				agmttype="";
				listfile=new ArrayList<File>();
				updateMailed(mailedtrno, conn, session);
				mailedtrno="";
				
			}
			
			//return "print";		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		
		//return "print";
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

	private void updateMailed(String mailedtrno, Connection conn, HttpSession session) {
		// TODO Auto-generated method stub
		try {
			Statement stmt=conn.createStatement();
			Statement stmt1=conn.createStatement();
			
			String strupdatemail="update gl_invm set mailed=1 where tr_no in ("+mailedtrno+")";
			//System.out.println(strupdatemail);
			int updatemail=stmt.executeUpdate(strupdatemail);
			
			strupdatemail="update my_cnot set mailed=1 where tr_no in ("+mailedtrno+")";
			//System.out.println(strupdatemail);
			updatemail=stmt.executeUpdate(strupdatemail);
			
			String refid="";
			
			String strdocs = "SELECT inv.voc_no vocno, inv.brhid, inv.dtype, ac.mail1, ac.cldocno FROM gl_invm inv LEFT JOIN my_acbook ac ON (inv.CLDOCNO=ac.cldocno and ac.dtype='CRM') "
					+ "LEFT JOIN (SELECT rdocno,rtype,tr_no FROM my_jvtran WHERE STATUS=3 GROUP BY tr_no) jvdet ON inv.tr_no=jvdet.tr_no WHERE inv.status=3 and inv.tr_no in ("+mailedtrno+") "
					+ "UNION ALL SELECT cno.doc_no vocno, cno.brhid, cno.dtype, ac.mail1, ac.cldocno FROM my_cnot cno LEFT JOIN my_acbook ac ON cno.acno=ac.acno "
					+ "LEFT JOIN (SELECT rdocno,rtype,tr_no FROM my_jvtran WHERE STATUS=3 GROUP BY tr_no) jvdet ON cno.tr_no=jvdet.tr_no WHERE cno.status=3 AND cno.dtype IN ('TCN','CNO') and cno.tr_no in ("+mailedtrno+")";
            ResultSet rs = stmt.executeQuery(strdocs);    
			while(rs.next()) {
				String sqls="insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email, cldocno) values ('"+rs.getString("vocno")+"', '"+rs.getString("brhid")+"', '"+rs.getString("dtype")+"', now(), '"+session.getAttribute("USERID")+"', '"+refid+"', '"+rs.getString("mail1")+"', '"+rs.getString("cldocno")+"')";
	            //System.out.println("Email log - "+sqls);    
				stmt1.executeUpdate(sqls);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	

	public String sendEmailwithMultiplepdf(String host, String port,
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
		return "fail";
	}
	return "success";
    }
	private File getPDFFile(Connection conn, int docno, int brhid, String dtype, HttpServletRequest request, HttpSession session, HttpServletResponse response, String vocno) {
		// TODO Auto-generated method stub
		
		try {
			if(dtype.equalsIgnoreCase("INV") || dtype.equalsIgnoreCase("INT") || dtype.equalsIgnoreCase("INS")) {
				return getInvoicePDF(conn,docno,brhid,request,session,response,vocno);
			}
			else if(dtype.equalsIgnoreCase("TCN") || dtype.equalsIgnoreCase("CNO")) {
				return getCreditNotePDF(conn,docno,brhid,request,session,response,vocno);
			}
			else {
				return null;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private File getCreditNotePDF(Connection conn, int docno, int brhid, HttpServletRequest request,
			HttpSession session, HttpServletResponse response, String vocno) throws NamingException, SQLException, IOException, MessagingException {
		// TODO Auto-generated method stub
		int header=1;
		ClsCreditNoteDAO creditNoteDAO=new ClsCreditNoteDAO();
		ClsCreditNoteBean creditNoteBean=creditNoteDAO.getPrint(request,docno,brhid,header);
		param = new HashMap();
		
		String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
		imgpathheader=imgpathheader.replace("\\", "\\\\");    
		   
		String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		   	imgpathfooter=imgpathfooter.replace("\\", "\\\\");    
		   	
		   	param.put("client", creditNoteBean.getLblaccountname());
		param.put("trno", creditNoteBean.getLblclienttrno());
		param.put("description", creditNoteBean.getLbldescription());
		param.put("amtinwords", creditNoteBean.getLblnetamountwords());
		param.put("vocno", creditNoteBean.getLbldocumentno());
		param.put("vocdate", creditNoteBean.getLbldate());
		param.put("amount", creditNoteBean.getLblnetamount());
		param.put("branch", brhid);
		param.put("docno", docno);
		param.put("imgheader", imgpathheader);
		param.put("imgfooter", imgpathfooter);
		param.put("header_stat", header);
		param.put("crtotal", creditNoteBean.getLblcredittotal());
		param.put("drtotal", creditNoteBean.getLbldebittotal());
		param.put("refno", creditNoteBean.getRefno());
		param.put("tinno", creditNoteBean.getLblcomptrn());
		param.put("prepared", creditNoteBean.getLblpreparedby());
		param.put("preparedon", creditNoteBean.getLblpreparedon());
		param.put("prepareddate", creditNoteBean.getLblpreparedat());
		param.put("verified", creditNoteBean.getVerified()); 
		param.put("approved",creditNoteBean.getApproved());
		//System.out.println("total=========inside jrxml"+creditNoteBean.getLblcredittotal()+creditNoteBean.getLbldebittotal());
		
		  JasperDesign design;
			try {
				design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/creditnote/TaxCreditNote.jrxml"));
				JasperReport jasperReport = JasperCompileManager.compileReport(design);
				return saveFile(response, param, jasperReport, conn, session, docno+"", brhid+"", vocno+"", "CNO");
				
			} catch (JRException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null;
	}

	private File getInvoicePDF(Connection conn, int docno, int brhid, HttpServletRequest request, HttpSession session, HttpServletResponse response, String vocno) throws NamingException, SQLException, IOException, MessagingException {
		// TODO Auto-generated method stub
		
		ClsManualInvoiceBean bean=new ClsManualInvoiceBean();
		ClsManualInvoiceDAO invdao=new ClsManualInvoiceDAO();
		//bean=invdao.getPrint(docno+"", docno+"", brhid+"", docno+"", "1", "1", "0", "", "0");
		String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
       	imgpath=imgpath.replace("\\", "\\\\");
    	String imgdubaigov=request.getSession().getServletContext().getRealPath("/icons/dubaigovlogo.jpg");
    	imgdubaigov=imgdubaigov.replace("\\", "\\\\");
    	String imgrtalogo=request.getSession().getServletContext().getRealPath("/icons/rtalogo.jpg");
    	imgrtalogo=imgrtalogo.replace("\\", "\\\\");
    	String imgtrafficbanner=request.getSession().getServletContext().getRealPath("/icons/traffic_banner.jpg");
    	imgtrafficbanner=imgtrafficbanner.replace("\\", "\\\\");
    	
    	String strtotal="select round(sum(coalesce(total,0)),2) total,inv.doc_no from gl_invm inv left join gl_invd on doc_no=rdocno where doc_no="+docno; 
    	ResultSet rstotal=conn.createStatement().executeQuery(strtotal); 
    	String invtotal="0.0";
    	while(rstotal.next()){
    		invtotal=rstotal.getString("total");
    	}
    	
    	ClsAmountToWords objamt=new ClsAmountToWords();
    	String amtwords=objamt.convertAmountToWords(invtotal);
    	
    	String reportFileName = "invoicetobedispatchDamage";
    	param = new HashMap();
    	param.put("printname", "INVOICE");
    	param.put("fromno", docno+"");
    	param.put("tono", docno+"");
    	param.put("imgpath", imgpath);
    	param.put("imgdubaigov", imgdubaigov);
    	param.put("imgrtalogo", imgrtalogo);
    	param.put("imgtrafficbanner", imgtrafficbanner);
    	param.put("compname", bean.getLblcompname());
    	param.put("compaddress", bean.getLblcompaddress());
    
    	param.put("comptel", bean.getLblcomptel());
    	param.put("compfax", bean.getLblcompfax());
    	param.put("compbranch", bean.getLblbranch());
    	param.put("location", bean.getLbllocation());
   
         param.put("custname", bean.getLblclient());
         param.put("custcode", bean.getLblaccount());
         param.put("custaddress", bean.getLbladdress1());
         param.put("custaddress2", bean.getLbladdress2());
         param.put("mob", bean.getLblmobile());
    	 param.put("phone", bean.getLblphone());
    	 param.put("driven", bean.getLbldriven());
         param.put("invno", bean.getLblinvno());
         param.put("custdate", bean.getLbldate());
         param.put("rano", bean.getLblrano());
    	 param.put("lpono", bean.getLbllpono());
    	 param.put("mrano", bean.getLblmrano());
         param.put("type", bean.getLblratype());
         param.put("contstart", bean.getLblcontractstart());
         param.put("invfromdate", bean.getLblinvfrom());
         param.put("invtodate", bean.getLblinvto());
         param.put("invfromtime", bean.getLblinvfromtime());
    	 param.put("invtotime", bean.getLblinvtotime());
    	 param.put("contveh", bean.getLblcontractvehicle());
         param.put("curveh", bean.getLblcurrentvehicle());
         param.put("processby", bean.getLblcheckedby());
         param.put("recvby", bean.getLblrecievedby());
         param.put("processdate", bean.getLblfinaldate());
    	 param.put("total", bean.getJasptotal());
         param.put("netamount", bean.getJaspnetamount());
         param.put("amountwords", amtwords);
         param.put("printby", session.getAttribute("USERNAME"));
	
         param.put("printdetailsql", bean.getPrintdetailsql());
    	 param.put("otherfleetsql", bean.getOtherfleetsql());
         param.put("saliksql", bean.getSaliksql());
         param.put("trafficdubaisql", bean.getTrafficdubaisql());
         param.put("trafficabudhabisql", bean.getTrafficabudhabusql());
         param.put("showfees", new Integer(bean.getLblshowfees()));
         
         JasperDesign design;
		try {
			design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/invoices/invoicetodispatch/" + reportFileName + ".jrxml"));
			JasperReport jasperReport = JasperCompileManager.compileReport(design);
			return saveFile(response, param, jasperReport, conn, session, docno+"", brhid+"", vocno+"", "INV");
			
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
	               
		return null;
	}
	
	private File saveFile(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,HttpSession session,String printdoc,String brhid,String refid,String dtype)throws JRException, NamingException, SQLException, IOException, MessagingException , javax.mail.MessagingException {
		
		byte[] bytes = null;
        bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
        resp.reset();
        resp.resetBuffer();
        
        resp.setContentType("application/pdf");
        resp.setContentLength(bytes.length);
        ServletOutputStream ouputStream = resp.getOutputStream();
       
      	Statement stmtleaseapp =conn.createStatement();
      	  
      	String fileName="",path="", formcode="BIVD",filepath=""; 
      	String strSql1 = "select imgPath from my_comp";

    	ResultSet rs1 = stmtleaseapp.executeQuery(strSql1);
    	while(rs1.next ()) {
    		path=rs1.getString("imgPath");
    	}

    	DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
  		java.util.Date date = new java.util.Date();
  		String currdate=dateFormat.format(date);
  		
  		String reportname="";
  		if(dtype.trim().equalsIgnoreCase("INV") || dtype.trim().equalsIgnoreCase("INS") || dtype.trim().equalsIgnoreCase("INT")) {
  			reportname="Invoice#"+refid;
  		}
  		else if(dtype.trim().equalsIgnoreCase("CNO") || dtype.trim().equalsIgnoreCase("TCN")) {
  			reportname="CreditNote#"+refid;
  		}
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
}
