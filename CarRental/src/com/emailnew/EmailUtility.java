package com.emailnew;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
 

public class EmailUtility {   
	public  String sendEmailpdf(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC,File attachfile){  
		
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");                  
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
       
        String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }      
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	} 
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }
        MimeBodyPart attachPart = new MimeBodyPart();    
		if(attachfile!=null){
        	attachPart.attachFile(attachfile);     
    		multipart.addBodyPart(attachPart);  
        }
		
        msg.setContent(multipart);
        Transport.send(msg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	return "fail";
        }
        return "success";        
    }
	
	public  String sendEmail(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC){  
		
	    //System.out.println(userName+"=USER NAME & PASSWORD="+password);
	    System.out.println("step 1-------Email");
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");                  
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        System.out.println("step 2-------Email");
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
        //InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        String[] to = null;
        if(recipient.length()!=0) {
        	to = recipient.trim().split(",");
        }
        int j=0;
        InternetAddress[] toAddresses = new InternetAddress[to.length];    
        if(!(recipient.equals(""))) {
        	 for(int i = 0; i < to.length; i++) {
        	     System.out.println(to[i]);
                 if(!to[i].isEmpty())
                     //msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to[i]));
                     toAddresses[j++]=new InternetAddress(to[i]);
             }
        }
        
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
       
        String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }      
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	}        
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }   
        
        msg.setContent(multipart);
        Transport.send(msg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	return "fail";
        }
        return "success";        
    }


	   public  String sendEmailpdfHR(String host, String port,  
	            final String userName, final String password,
	            String recipient, String CC ,String subject, String message,String Filepath,String BCC,File attachfile, String signaturePath){  
	        
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
	        //java.net.preferIPv4Stack=true;
	        // creates a new session with an authenticator
	        Authenticator auth = new Authenticator() {
	            public PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(userName, password);
	            }
	        };
	        Session session = Session.getInstance(properties, auth);
	 
	        // creates a new e-mail message
	        Message msg = new MimeMessage(session);
//	              System.out.println("====recipient======"+recipient);
//	              System.out.println("====CC======"+CC);
//	              System.out.println("====BCC======"+BCC);
//	              System.out.println("==userName===="+userName); 
	        try{        
	        msg.setFrom(new InternetAddress(userName));
	        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
	        msg.setRecipients(Message.RecipientType.TO, toAddresses);
	       
	        String[] cc = null;
	        String[] bcc = null;
	        if(CC.length() != 0){
	            cc = CC.trim().split(",");
	        } 
	        if(BCC.length() != 0){
	            bcc = BCC.trim().split(",");
	        }


	        if(!(CC.equals(""))){
	        for(int i = 0; i < cc.length; i++) {
	            if(!cc[i].isEmpty())
	                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
	        }
	        }
	        
	        if(!(BCC.equals(""))){
	        for(int i = 0; i < bcc.length; i++) {
	            if(!bcc[i].isEmpty())
	                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
	        }
	        }      
	        if(!(subject.equals(""))){                        
	        msg.setSubject(subject);
	        }
	        msg.setSentDate(new Date());
	        // creates message part
	        MimeBodyPart messageBodyPart = new MimeBodyPart();
	        messageBodyPart.setContent(message, "text/html");
	        // creates multi-part
	        Multipart multipart = new MimeMultipart();
	        multipart.addBodyPart(messageBodyPart);
	        // adds attachments
	        int i=0;  
	        //System.out.println("Filepath===="+Filepath);  
	        if(!Filepath.equalsIgnoreCase("")){                   
	        java.util.List<java.io.File> files = new ArrayList<>();                      
	        String[] urlarray = Filepath.split(",");          
	        File saveFile = null;
	        for (i = 0; i < urlarray.length; i++) {     
	            String tranno=urlarray[i];               
	            if(!(tranno.equalsIgnoreCase(""))){   
	                //System.out.println("tranno===="+tranno);            
	                saveFile=new File(tranno);       
	                files.add(saveFile);
	                //System.out.println("out test===="+files);  
	            }
	        } 
	        for(File s:files){      
	            //System.out.println("out test===="+s);  
	            MimeBodyPart attachPart = new MimeBodyPart();    
	            attachPart.attachFile(s); 
	            multipart.addBodyPart(attachPart); 
	        }         
	        }
	        MimeBodyPart attachPart = new MimeBodyPart();    
	        if(attachfile!=null){
	            attachPart.attachFile(attachfile);     
	            multipart.addBodyPart(attachPart);  
	        }
	        
	        MimeBodyPart imagePart = new MimeBodyPart();
	        DataSource fds = new FileDataSource(signaturePath); 
	        imagePart.setDataHandler(new DataHandler(fds));
	        imagePart.setHeader("Content-ID", "<signatureImage>");
	        multipart.addBodyPart(imagePart);  
	        
	        
	        msg.setContent(multipart);
	        Transport.send(msg);
	        }catch (Exception ex) {
	            ex.printStackTrace();
	            return "fail";
	        }
	        return "success";        
	    }

	
}