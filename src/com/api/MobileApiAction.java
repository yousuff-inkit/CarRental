package com.api;

import com.opensymphony.xwork2.ActionSupport;

import java.sql.*;
import java.util.*;
import com.connection.ClsConnection;
import java.util.UUID;
import org.apache.struts2.ServletActionContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.operations.marketing.booking.ClsbookingDAO;


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
    
    private String bookingId;

    public String getBookingId() {
        return bookingId;
    }
    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }
 // String parameters for the Booking Form
    private String sqlStartDate, vehfromdate, vehtodate, cmbreftype, bookrefno, bookclientno;
    private String bookcontactno, bookattention, bookremark, renttype, jqxVehicleToTime, jqxVehicleFromTime;
    private String dellocation, guestremark, email, bookslno, mode, formcode, clientname, clacno;
    private String delchg, invex, invtype, vehloc, codeno, refclientdet;

    // Integer parameters for the Booking Form
    private int bookbrandid, bookmodelid, bookcolorid, bookgroupid, delivery_chkval;
    private int chauffeur_chkval, salagtid, tdocno, fleetno, advchk;

    // Arrays for Tariffs and Payments
    private List<String> qtarifarray = new ArrayList<>();
    private List<String> paymentarray = new ArrayList<>();
    
 // Variables for Dropdown Searches
    private String brandval;
    private String clname;
    private String mob;

    // Output variable for the dropdown lists
    private Object dropdownData; 

    public Object getDropdownData() { return dropdownData; }
    public void setDropdownData(Object dropdownData) { this.dropdownData = dropdownData; }
 // Getters and Setters so Struts can inject the URL data
    public String getBrandval() {
        return brandval;
    }
    public void setBrandval(String brandval) {
        this.brandval = brandval;
    }

    public String getClname() {
        return clname;
    }
    public void setClname(String clname) {
        this.clname = clname;
    }

    public String getMob() {
        return mob;
    }
    public void setMob(String mob) {
        this.mob = mob;
    }
    
    
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
    
//ENDPOINT 3: Dashboard Data (Deliveries & Collections)
//==========================================
public String fetchDashboard() {
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  
  dashboardData = new HashMap<>();
  List<Map<String, String>> deliveriesList = new ArrayList<>();
  List<Map<String, String>> collectionsList = new ArrayList<>();

  try {
      ClsConnection clsConn = new ClsConnection();
      conn = clsConn.getMyConnection();
      stmt = conn.createStatement();

      // --- 1. GET ACTIVE DELIVERIES ---
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
          delivery.put("date", rs.getString("frmDate")); // frmDate = Delivery Date
          deliveriesList.add(delivery);
      }
      rs.close(); 

      // --- 2. GET ACTIVE COLLECTIONS ---
      // NOTE: We are using 'todate' (Return Date) for collections. 
      String collectionSql = "SELECT b.voc_no, a.refname, b.todate, b.contactno " +
                             "FROM gl_bookingm b " +
                             "LEFT JOIN my_acbook a ON a.cldocno = b.cldocno AND a.dtype = 'CRM' " +
                             "WHERE b.status = 3"; 
      
      rs = stmt.executeQuery(collectionSql);
      
      int cCount = 0;
      while (rs.next()) {
          cCount++;
          Map<String, String> collection = new HashMap<>();
          collection.put("id", rs.getString("voc_no"));
          collection.put("client", rs.getString("refname"));
          collection.put("date", rs.getString("todate")); // todate = Collection Date
          collection.put("contact", rs.getString("contactno"));
          collectionsList.add(collection);
      }

      // --- 3. PACK IT ALL INTO THE DASHBOARD VARIABLE ---
      dashboardData.put("deliveryCount", dCount);
      dashboardData.put("collectionCount", cCount);
      dashboardData.put("deliveries", deliveriesList);
      dashboardData.put("collections", collectionsList);

      status = "success";

  } catch (Exception e) {
      status = "error: " + e.toString();
      e.printStackTrace(); 
  } finally {
      try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception ex) {}
  }
  
  return SUCCESS;
}

//==========================================
//ENDPOINT 4: Form Submission (Delivery to Collection)
//==========================================
public String updateStateToCollection() {
 Connection conn = null;
 PreparedStatement pstmt = null;

 try {
     // Safety check: Make sure the mobile app sent an ID
     if (bookingId == null || bookingId.trim().isEmpty()) {
         status = "error: bookingId is required.";
         return SUCCESS;
     }

     ClsConnection clsConn = new ClsConnection();
     conn = clsConn.getMyConnection();

     // Flip the delivery flag from 1 to 0. 
     // This moves it off the Delivery list and leaves it on the Collection list.
     String sql = "UPDATE gl_bookingm SET delivery = 0 WHERE voc_no = ?";

     pstmt = conn.prepareStatement(sql);
     pstmt.setString(1, bookingId); 

     // Execute the update
     int rowsAffected = pstmt.executeUpdate();

     if (rowsAffected > 0) {
         status = "success";
     } else {
         status = "error: No booking found with that ID.";
     }

 } catch (Exception e) {
     status = "error: " + e.toString();
     e.printStackTrace(); 
 } finally {
     try { if(pstmt != null) pstmt.close(); if(conn != null) conn.close(); } catch(Exception ex) {}
 }
 
 return SUCCESS;
}

//==========================================
//ENDPOINT 5: Submit New Booking Form
//==========================================
public String submitBooking() {
 try {
     // We need the Request and Session because your DAO specifically asks for them
     HttpServletRequest request = ServletActionContext.getRequest();
     HttpSession session = request.getSession();

     // Security/Session Check: The DAO requires USERID and BRANCHID to be in the session
     if (session.getAttribute("USERID") == null || session.getAttribute("BRANCHID") == null) {
         status = "error: Unauthorized. Mobile app must send a valid session cookie.";
         return SUCCESS;
     }

     // Convert the date strings sent by the mobile app (e.g., "2026-06-15") into SQL Dates
     java.sql.Date startDt = java.sql.Date.valueOf(sqlStartDate);
     java.sql.Date fromDt = java.sql.Date.valueOf(vehfromdate);
     java.sql.Date toDt = java.sql.Date.valueOf(vehtodate);

     ClsbookingDAO bookingDAO = new ClsbookingDAO();

     // Call your massive DAO insert method with the 40 variables
     int newDocNo = bookingDAO.insert(
         startDt, fromDt, toDt, cmbreftype, bookrefno, bookclientno, bookcontactno,
         bookattention, bookremark, bookbrandid, bookmodelid, bookcolorid, bookgroupid,
         renttype, jqxVehicleToTime, jqxVehicleFromTime, delivery_chkval, chauffeur_chkval,
         dellocation, guestremark, salagtid, email, (ArrayList<String>) qtarifarray,
         (ArrayList<String>) paymentarray, bookslno, mode, session, formcode, request,
         clientname, clacno, tdocno, fleetno, delchg, invex, advchk, invtype, vehloc,
         codeno, refclientdet
     );

     if (newDocNo > 0) {
         status = "success";
         // Send the newly created database ID back to the mobile app
         dashboardData = new HashMap<>();
         dashboardData.put("newBookingId", String.valueOf(newDocNo)); 
     } else {
         status = "error: Database rejected the insertion. Check your parameters.";
     }

 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 
 return SUCCESS;
}

//==========================================
//ENDPOINT SET 6: Form Dropdown Data
//==========================================

public String fetchBrands() {
 try {
     ClsbookingDAO dao = new ClsbookingDAO();
     // Grabs the full list of vehicle brands directly from your DAO
     dropdownData = dao.searchBrand(); 
     status = "success";
 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 return SUCCESS;
}

public String fetchModels() {
 try {
     if (brandval == null || brandval.trim().isEmpty()) {
         status = "error: brandval is required to fetch models.";
         return SUCCESS;
     }
     ClsbookingDAO dao = new ClsbookingDAO();
     // Grabs models specific to the brand ID sent by the mobile app
     dropdownData = dao.searchModel(brandval); 
     status = "success";
 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 return SUCCESS;
}

public String fetchClients() {
 try {
     HttpServletRequest request = ServletActionContext.getRequest();
     HttpSession session = request.getSession();
     
     // Prevent null pointer exceptions if mobile app sends empty searches
     String searchName = (clname == null) ? "" : clname;
     String searchMob = (mob == null) ? "" : mob;

     ClsbookingDAO dao = new ClsbookingDAO();
     // Searches for clients based on name or mobile number
     dropdownData = dao.searchClient(session, searchName, searchMob);
     status = "success";
 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 return SUCCESS;
}
}