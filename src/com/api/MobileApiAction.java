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
    public String fetchDashboard() {
        dashboardData = new HashMap<>();
        // TODO: Query your database for deliveries and bookings here
        
        dashboardData.put("deliveryCount", 0);
        dashboardData.put("bookingCount", 0);
        
        status = "success";
        return SUCCESS;
    }
}