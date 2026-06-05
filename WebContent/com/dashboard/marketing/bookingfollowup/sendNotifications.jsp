<%@ page import="java.sql.*, java.util.*, java.io.*, java.net.*, javax.mail.*, javax.mail.internet.*" %>
<%
    // =========================================================================
    // TESTING CONFIGURATION - FILL IN YOUR DETAILS HERE
    // =========================================================================
    
    // 1. Meta WhatsApp Cloud API Credentials
    final String META_ACCESS_TOKEN = "";
    final String META_PHONE_ID = "";
    final String META_API_VERSION = "v25.0"; 
    
    // 2. Gmail SMTP Credentials
    final String GMAIL_USER = "@gmail.com"; 
    final String GMAIL_APP_PASS = ""; // 16-character Google App Password

    // 3. Testing Contact Info (Overrides Database for testing)
    String email = "@example.com"; 
    String whatsappNo = ""; // Your verified personal number
    // =========================================================================

    String rdocno = request.getParameter("rdocno");
    if (rdocno == null || rdocno.isEmpty()) { rdocno = "TEST-123"; }
    
    String messageBody = "Hello Test User, your booking (" + rdocno + ") has been confirmed! Thank you for choosing GatewayERP.";

    // --- SEND GMAIL NOTIFICATION ---
    if (email != null && !email.trim().isEmpty()) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(GMAIL_USER, GMAIL_APP_PASS);
                }
            });

            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(GMAIL_USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email.trim()));
            message.setSubject("Test Booking Confirmed: " + rdocno);
            message.setText(messageBody);

            Transport.send(message);
            System.out.println("SUCCESS: Email sent to: " + email);
        } catch (Exception e) {
            System.err.println("ERROR: Failed to send Email.");
            e.printStackTrace();
        }
    }

    // --- SEND WHATSAPP NOTIFICATION ---
    if (whatsappNo != null && !whatsappNo.trim().isEmpty()) {
        try {
            String cleanWhatsappNo = whatsappNo.replaceAll("[^0-9]", "");
            String metaUrl = "https://graph.facebook.com/" + META_API_VERSION + "/" + META_PHONE_ID + "/messages";

            String jsonPayload = "{"
                + "\"messaging_product\": \"whatsapp\","
                + "\"to\": \"" + cleanWhatsappNo + "\","
                + "\"type\": \"text\","
                + "\"text\": {\"body\": \"" + messageBody + "\"}"
                + "}";

            URL url = new URL(metaUrl);
            HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
            httpConn.setRequestMethod("POST");
            httpConn.setRequestProperty("Authorization", "Bearer " + META_ACCESS_TOKEN);
            httpConn.setRequestProperty("Content-Type", "application/json");
            httpConn.setDoOutput(true);

            // FIXED: Using traditional try-finally for OutputStream
            OutputStream os = null;
            try {
                os = httpConn.getOutputStream();
                byte[] input = jsonPayload.getBytes("utf-8");
                os.write(input, 0, input.length);
            } finally {
                if (os != null) {
                    try { os.close(); } catch (Exception ex) {}
                }
            }

            int responseCode = httpConn.getResponseCode();
            if (responseCode == 200) {
                System.out.println("SUCCESS: WhatsApp sent to: " + cleanWhatsappNo);
            } else {
                System.err.println("ERROR: WhatsApp failed. HTTP Code: " + responseCode);
                
                // FIXED: Using traditional try-finally for BufferedReader
                BufferedReader br = null;
                try {
                    br = new BufferedReader(new InputStreamReader(httpConn.getErrorStream()));
                    String line;
                    while ((line = br.readLine()) != null) { 
                        System.err.println(line); 
                    }
                } finally {
                    if (br != null) {
                        try { br.close(); } catch (Exception ex) {}
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("ERROR: Failed WhatsApp API call.");
            e.printStackTrace();
        }
    }
%>