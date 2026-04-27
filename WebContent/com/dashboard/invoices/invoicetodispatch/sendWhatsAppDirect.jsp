<%@page import="java.io.*,java.net.*"%>
<%@page contentType="application/json; charset=UTF-8"%><%

    // ─── META WHATSAPP CLOUD API CREDENTIALS ──────────────────────────────────
    // Get these from: https://developers.facebook.com → Your App → WhatsApp → API Setup
    final String PHONE_NUMBER_ID = "YOUR_PHONE_NUMBER_ID";   // e.g. "123456789012345"
    final String ACCESS_TOKEN    = "YOUR_ACCESS_TOKEN";       // permanent or temp token
    // ──────────────────────────────────────────────────────────────────────────

    try {
        String phone   = request.getParameter("phone")   != null ? request.getParameter("phone").trim()   : "";
        String message = request.getParameter("message") != null ? request.getParameter("message").trim() : "";

        if(phone.isEmpty() || message.isEmpty()){
            out.print("{\"success\":false,\"error\":\"Phone and message are required\"}");
            return;
        }

        // Normalize: remove spaces, dashes, dots, parentheses, leading +
        phone = phone.replaceAll("[\\s\\-().+]","");

        // Escape message for JSON
        String jsonMessage = message
            .replace("\\","\\\\")
            .replace("\"","\\\"")
            .replace("\r\n","\\n")
            .replace("\n","\\n")
            .replace("\r","\\n");

        String jsonPayload = "{"
            + "\"messaging_product\":\"whatsapp\","
            + "\"to\":\"" + phone + "\","
            + "\"type\":\"text\","
            + "\"text\":{\"preview_url\":false,\"body\":\"" + jsonMessage + "\"}"
            + "}";

        URL url = new URL("https://graph.facebook.com/v19.0/" + PHONE_NUMBER_ID + "/messages");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + ACCESS_TOKEN);
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(15000);
        conn.setDoOutput(true);

        try(OutputStream os = conn.getOutputStream()){
            os.write(jsonPayload.getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();
        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
        StringBuilder sb = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))){
            String line;
            while((line = br.readLine()) != null) sb.append(line);
        }

        if(status >= 200 && status < 300){
            out.print("{\"success\":true}");
        } else {
            // Surface the API error message directly
            out.print("{\"success\":false,\"error\":" + sb.toString() + "}");
        }

    } catch(Exception e){
        String err = e.getMessage() != null ? e.getMessage().replace("\"","'") : "Unknown error";
        out.print("{\"success\":false,\"error\":\"" + err + "\"}");
    }
%>
