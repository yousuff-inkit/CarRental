<%@page import="com.dashboard.marketing.ClsMarketingDAO"%>
<%
    // Get the parameters sent by the JavaScript AJAX call
    String rdocno = request.getParameter("rdocno") == null ? "" : request.getParameter("rdocno").trim();
    String branchids = request.getParameter("branchids") == null ? "" : request.getParameter("branchids").trim();

    if (!rdocno.equals("")) {
        ClsMarketingDAO cmd = new ClsMarketingDAO();
        // Call the new Java method we just created
        String result = cmd.confirmBooking(rdocno, branchids);
        
        // Send the result back to the frontend
        out.print(result);
    } else {
        out.print("FAIL - No Document Number Provided");
    }
%>