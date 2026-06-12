package com.api;

import com.opensymphony.xwork2.ActionSupport;
import java.sql.*;
import java.util.*;
import com.connection.ClsConnection;
import java.util.UUID;

public class MobileApiAction extends ActionSupport {

    // --- INPUTS FROM MOBILE APP ---
    private String userid;
    private String password;
    private String company; // Company ID from dropdown

    public void setUserid(String userid) { this.userid = userid; }
    public void setPassword(String password) { this.password = password; }
    public void setCompany(String company) { this.company = company; }

    // --- OUTPUTS TO MOBILE APP (Converted to JSON) ---
    private String status;
    private String token;
    private List<Map<String, String>> companyList;
    private Map<String, Object> dashboardData;

    public String getStatus() { return status; }
    public String getToken() { return token; }
    public List<Map<String, String>> getCompanyList() { return companyList; }
    public Map<String, Object> getDashboardData() { return dashboardData; }

    // ==========================================
    // ENDPOINT 1: Fetch Companies
    // ==========================================
    public String fetchCompanies() {
        companyList = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            ClsConnection clsConn = new ClsConnection();
            conn = clsConn.getMyConnection();
            stmt = conn.createStatement();
            
            String strSql = "select company, comp_id, COALESCE(if(projectstatus=2 and DATEDIFF(era,CURDATE())=0,'AMC Expires Today',if(projectstatus=2 and (DATEDIFF(era,CURDATE()) between 1 and 10),CONCAT('AMC Expires in ',DATEDIFF(era,CURDATE()),' Day(s)'),if(projectstatus=2 and (DATEDIFF(era,CURDATE())<0),CONCAT('AMC Renewal Pending ',DATEDIFF(CURDATE(),era),' Day(s)'),''))),'') amcRenewalMsg from my_comp";
            rs = stmt.executeQuery(strSql);
            
            while(rs.next()) {
                Map<String, String> compMap = new HashMap<>();
                compMap.put("id", rs.getString("comp_id"));
                compMap.put("name", rs.getString("company"));
                compMap.put("warning", rs.getString("amcRenewalMsg"));
                companyList.add(compMap);
            }
            status = "success";
        } catch (Exception e) {
            status = "error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception ex) {}
        }
        return SUCCESS;
    }

    // ==========================================
    // ENDPOINT 2: Process Login
    // ==========================================
    

 public String processLogin() {
     Connection conn = null;
     Statement stmt = null;
     ResultSet rs = null;

     try {
         // --- 1. BULLETPROOF SAFETY NET ---
         // Check if the variables are null OR if they are just empty spaces
         if (userid == null || userid.trim().isEmpty() || password == null || password.trim().isEmpty()) {
             status = "error: The userid or password was blank or not received.";
             token = "";
             return SUCCESS; 
         }

         // --- 2. THE CORRECT ENCRYPTION CALL ---
         // Using getInstance() to match your ClsLogin.java exactly
         String encryptedPassword = com.common.ClsEncrypt.getInstance().encrypt(password);

         ClsConnection clsConn = new ClsConnection();
         conn = clsConn.getMyConnection();
         stmt = conn.createStatement();

         String strSql = "select * from my_user where user_id='" + userid + "' and pass='" + encryptedPassword + "' and block=0";
         rs = stmt.executeQuery(strSql);

         if (rs.next()) {
             // LOGIN SUCCESS
             status = "success";
             int loggedInUserId = rs.getInt("doc_no");
             token = UUID.randomUUID().toString() + "-" + loggedInUserId;
         } else {
             // LOGIN FAILED
             status = "login_failed";
             token = "";
         }

     } catch (Exception e) {
         status = "error: " + e.toString(); 
         e.printStackTrace(); 
     } finally {
         try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception ex) {}
     }
     
     return SUCCESS;
 }
    // ==========================================
    // ENDPOINT 3: Dashboard
    // ==========================================
//==========================================
//ENDPOINT 3: Dashboard Data (Bookings & Deliveries)
//==========================================
public String fetchDashboard() {
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  
  // Initialize the maps and lists to hold our JSON data
  dashboardData = new HashMap<>();
  List<Map<String, String>> bookingsList = new ArrayList<>();
  List<Map<String, String>> deliveriesList = new ArrayList<>();

  try {
      ClsConnection clsConn = new ClsConnection();
      conn = clsConn.getMyConnection();
      stmt = conn.createStatement();

      // --- 1. GET ALL ACTIVE BOOKINGS ---
      // Joining gl_bookingm with my_acbook to grab the client's actual name
      String bookingSql = "SELECT b.voc_no, a.refname, b.frmDate, b.contactno " +
                          "FROM gl_bookingm b " +
                          "LEFT JOIN my_acbook a ON a.cldocno = b.cldocno AND a.dtype = 'CRM' " +
                          "WHERE b.status = 3"; 
      
      rs = stmt.executeQuery(bookingSql);
      
      int bCount = 0;
      while (rs.next()) {
          bCount++;
          Map<String, String> booking = new HashMap<>();
          booking.put("id", rs.getString("voc_no"));
          booking.put("client", rs.getString("refname"));
          booking.put("date", rs.getString("frmDate"));
          booking.put("contact", rs.getString("contactno"));
          bookingsList.add(booking);
      }
      rs.close(); // Close before reusing the ResultSet

      // --- 2. GET ACTIVE DELIVERIES ---
      // Filtering the exact same table, but looking for the delivery=1 flag
      String deliverySql = "SELECT b.voc_no, a.refname, b.delloc, b.frmDate " +
                           "FROM gl_bookingm b " +
                           "LEFT JOIN my_acbook a ON a.cldocno = b.cldocno AND a.dtype = 'CRM' " +
                           "WHERE b.status = 3 AND b.delivery = 1";
                           
      rs = stmt.executeQuery(deliverySql);
      
      int dCount = 0;
      while (rs.next()) {
          dCount++;
          Map<String, String> delivery = new HashMap<>();
          delivery.put("id", rs.getString("voc_no"));
          delivery.put("client", rs.getString("refname"));
          delivery.put("location", rs.getString("delloc"));
          delivery.put("date", rs.getString("frmDate"));
          deliveriesList.add(delivery);
      }

      // --- 3. PACK IT ALL INTO THE DASHBOARD VARIABLE ---
      dashboardData.put("bookingCount", bCount);
      dashboardData.put("deliveryCount", dCount);
      dashboardData.put("bookings", bookingsList);
      dashboardData.put("deliveries", deliveriesList);

      status = "success";

  } catch (Exception e) {
      status = "error: " + e.toString();
      e.printStackTrace(); // Prints the exact line number to Eclipse if it crashes
  } finally {
      // Always close database connections to prevent memory leaks
      try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception ex) {}
  }
  
  return SUCCESS;
}
}