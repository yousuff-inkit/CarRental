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
import com.operations.agreement.rentalclose.ClsRentalCloseDAO;
import com.operations.agreement.rentalagreement.ClsRentalAgreementDAO;
import com.operations.agreement.rentalagreement.ClsRentalAgreementAction;


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
    
 // Variables for Collection (Check-In) Form
    private String agreementno, clientid, hidchkcollection, collectkm, cmbcollectfuel;
    private String sqlCollectDate, collecttime, cmbcheckin, inkm, cmbinfuel;
    private String sqlInDate, intime, cmbrentalagent, useddays, usedhours, totalkm, excesskm;
    private String sqlCloseDate, chaufferid, sqlOutDate, clientacno, hidfleet, creditnotesum;
    private String collectchg, brchname, branchsearch, closelocation, description, hidchkorgregcardcollect;

    // Arrays for Collection Tariffs and Calculations
    private List<String> closearray = new ArrayList<>();
    private List<String> calcarray = new ArrayList<>();
    
    
 // ==========================================
 // VARIABLES FOR DELIVERY (DISPATCH) API
 // ==========================================
 private String sqlrentalDate, fleetNO, clientId, clcodeno, adddrvcharges;
 private String sqloutDate, outTime, sqldueDate, dueTime;
 private String tasystem, tadocno, invoice, exessinsu, paymentMra, paymentPo;
 private String origFleetno, Vehlocationid, fleetgroup, rentalType;
 private String delcharge, rentaldesc, hidchkorgregcard, hidchkigst, hidrentalproject;
 private int salesmanid, addrvchk, delchk, chfchk, deldriverid, salesagentid;
 private int rentalagentid, checkoutid, advancechk, weekend;

 private List<String> deliveryDriverArray = new ArrayList<>();
 private List<String> deliveryTariffArray = new ArrayList<>();
 private List<String> deliveryPaymentArray = new ArrayList<>();

 // GETTERS AND SETTERS
 public String getSqlrentalDate() { return sqlrentalDate; }
 public void setSqlrentalDate(String sqlrentalDate) { this.sqlrentalDate = sqlrentalDate; }
 public String getFleetNO() { return fleetNO; }
 public void setFleetNO(String fleetNO) { this.fleetNO = fleetNO; }
 public String getClientId() { return clientId; }
 public void setClientId(String clientId) { this.clientId = clientId; }
 public String getClcodeno() { return clcodeno; }
 public void setClcodeno(String clcodeno) { this.clcodeno = clcodeno; }
 public String getAdddrvcharges() { return adddrvcharges; }
 public void setAdddrvcharges(String adddrvcharges) { this.adddrvcharges = adddrvcharges; }
 public String getSqloutDate() { return sqloutDate; }
 public void setSqloutDate(String sqloutDate) { this.sqloutDate = sqloutDate; }
 public String getOutTime() { return outTime; }
 public void setOutTime(String outTime) { this.outTime = outTime; }
 public String getSqldueDate() { return sqldueDate; }
 public void setSqldueDate(String sqldueDate) { this.sqldueDate = sqldueDate; }
 public String getDueTime() { return dueTime; }
 public void setDueTime(String dueTime) { this.dueTime = dueTime; }
 public String getTasystem() { return tasystem; }
 public void setTasystem(String tasystem) { this.tasystem = tasystem; }
 public String getTadocno() { return tadocno; }
 public void setTadocno(String tadocno) { this.tadocno = tadocno; }
 public String getInvoice() { return invoice; }
 public void setInvoice(String invoice) { this.invoice = invoice; }
 public String getExessinsu() { return exessinsu; }
 public void setExessinsu(String exessinsu) { this.exessinsu = exessinsu; }
 public String getPaymentMra() { return paymentMra; }
 public void setPaymentMra(String paymentMra) { this.paymentMra = paymentMra; }
 public String getPaymentPo() { return paymentPo; }
 public void setPaymentPo(String paymentPo) { this.paymentPo = paymentPo; }
 public String getOrigFleetno() { return origFleetno; }
 public void setOrigFleetno(String origFleetno) { this.origFleetno = origFleetno; }
 public String getVehlocationid() { return Vehlocationid; }
 public void setVehlocationid(String Vehlocationid) { this.Vehlocationid = Vehlocationid; }
 public String getFleetgroup() { return fleetgroup; }
 public void setFleetgroup(String fleetgroup) { this.fleetgroup = fleetgroup; }
 public String getRentalType() { return rentalType; }
 public void setRentalType(String rentalType) { this.rentalType = rentalType; }
 public String getDelcharge() { return delcharge; }
 public void setDelcharge(String delcharge) { this.delcharge = delcharge; }
 public String getRentaldesc() { return rentaldesc; }
 public void setRentaldesc(String rentaldesc) { this.rentaldesc = rentaldesc; }
 public String getHidchkorgregcard() { return hidchkorgregcard; }
 public void setHidchkorgregcard(String hidchkorgregcard) { this.hidchkorgregcard = hidchkorgregcard; }
 public String getHidchkigst() { return hidchkigst; }
 public void setHidchkigst(String hidchkigst) { this.hidchkigst = hidchkigst; }
 public String getHidrentalproject() { return hidrentalproject; }
 public void setHidrentalproject(String hidrentalproject) { this.hidrentalproject = hidrentalproject; }
 public int getSalesmanid() { return salesmanid; }
 public void setSalesmanid(int salesmanid) { this.salesmanid = salesmanid; }
 public int getAddrvchk() { return addrvchk; }
 public void setAddrvchk(int addrvchk) { this.addrvchk = addrvchk; }
 public int getDelchk() { return delchk; }
 public void setDelchk(int delchk) { this.delchk = delchk; }
 public int getChfchk() { return chfchk; }
 public void setChfchk(int chfchk) { this.chfchk = chfchk; }
 public int getDeldriverid() { return deldriverid; }
 public void setDeldriverid(int deldriverid) { this.deldriverid = deldriverid; }
 public int getSalesagentid() { return salesagentid; }
 public void setSalesagentid(int salesagentid) { this.salesagentid = salesagentid; }
 public int getRentalagentid() { return rentalagentid; }
 public void setRentalagentid(int rentalagentid) { this.rentalagentid = rentalagentid; }
 public int getCheckoutid() { return checkoutid; }
 public void setCheckoutid(int checkoutid) { this.checkoutid = checkoutid; }
 public int getAdvancechk() { return advancechk; }
 public void setAdvancechk(int advancechk) { this.advancechk = advancechk; }
 public int getWeekend() { return weekend; }
 public void setWeekend(int weekend) { this.weekend = weekend; }
 public List<String> getDeliveryDriverArray() { return deliveryDriverArray; }
 public void setDeliveryDriverArray(List<String> deliveryDriverArray) { this.deliveryDriverArray = deliveryDriverArray; }
 public List<String> getDeliveryTariffArray() { return deliveryTariffArray; }
 public void setDeliveryTariffArray(List<String> deliveryTariffArray) { this.deliveryTariffArray = deliveryTariffArray; }
 public List<String> getDeliveryPaymentArray() { return deliveryPaymentArray; }
 public void setDeliveryPaymentArray(List<String> deliveryPaymentArray) { this.deliveryPaymentArray = deliveryPaymentArray; }
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

//==========================================
//ENDPOINT 7: Submit Collection (Vehicle Check-in)
//==========================================
public String submitCollection() {
 try {
     HttpServletRequest request = ServletActionContext.getRequest();
     HttpSession session = request.getSession();

     // Security Check
     if (session.getAttribute("USERID") == null || session.getAttribute("BRANCHID") == null) {
         status = "error: Unauthorized. Mobile app must send a valid session cookie.";
         return SUCCESS;
     }

     // Convert Dates
     java.sql.Date collectDt = (sqlCollectDate != null && !sqlCollectDate.isEmpty()) ? java.sql.Date.valueOf(sqlCollectDate) : null;
     java.sql.Date inDt = (sqlInDate != null && !sqlInDate.isEmpty()) ? java.sql.Date.valueOf(sqlInDate) : null;
     java.sql.Date closeDt = (sqlCloseDate != null && !sqlCloseDate.isEmpty()) ? java.sql.Date.valueOf(sqlCloseDate) : null;
     java.sql.Date outDt = (sqlOutDate != null && !sqlOutDate.isEmpty()) ? java.sql.Date.valueOf(sqlOutDate) : null;

     // Force mode to "A" (Add) if mobile app forgets to send it
     if(mode == null || mode.isEmpty()) mode = "A";

     ClsRentalCloseDAO closeDAO = new ClsRentalCloseDAO();

     // Feed the beast
     int result = closeDAO.insert(
         agreementno, clientid, hidchkcollection, collectkm, cmbcollectfuel, collectDt, collecttime, 
         cmbcheckin, inkm, cmbinfuel, inDt, intime, cmbrentalagent, useddays, usedhours, totalkm, excesskm, 
         session, (ArrayList<String>) closearray, closeDt, mode, chaufferid, (ArrayList<String>) calcarray, 
         outDt, clientacno, hidfleet, creditnotesum, request, collectchg, brchname, branchsearch, 
         closelocation, description, hidchkorgregcardcollect
     );

     if (result > 0) {
         status = "success";
         dashboardData = new HashMap<>();
         dashboardData.put("closedDocumentNo", String.valueOf(result)); 
     } else {
         status = "error: Database rejected the Collection check-in.";
     }

 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 return SUCCESS;
}

//==========================================
//ENDPOINT 8: Submit Delivery (Vehicle Dispatch)
//==========================================
public String submitDelivery() {
 try {
     HttpServletRequest request = ServletActionContext.getRequest();
     HttpSession session = request.getSession();

     if (session.getAttribute("USERID") == null) {
         status = "error: Unauthorized. Missing JSESSIONID.";
         return SUCCESS;
     }

     // Convert Dates
     java.sql.Date rentalDt = (sqlrentalDate != null && !sqlrentalDate.isEmpty()) ? java.sql.Date.valueOf(sqlrentalDate) : null;
     java.sql.Date outDt = (sqloutDate != null && !sqloutDate.isEmpty()) ? java.sql.Date.valueOf(sqloutDate) : null;
     java.sql.Date dueDt = (sqldueDate != null && !sqldueDate.isEmpty()) ? java.sql.Date.valueOf(sqldueDate) : null;

     if(mode == null || mode.isEmpty()) mode = "A"; // Default to Add
     if(tasystem == null || tasystem.isEmpty()) tasystem = "Manual"; 

     // Create a dummy action object to prevent NullPointerExceptions in the DAO
     ClsRentalAgreementAction dummyAction = new ClsRentalAgreementAction();
     dummyAction.setHidchkinsurcomp("0");
     dummyAction.setCmbinsurcomp("0");
     dummyAction.setInsurcompdays("0");
     dummyAction.setCmbenqtype("0");
     dummyAction.setRacrate("0");
     dummyAction.setActualcldocno("0");

     ClsRentalAgreementDAO deliveryDAO = new ClsRentalAgreementDAO();

     int result = deliveryDAO.insert(
         rentalDt, fleetNO, clientId, salesmanid, clcodeno, clacno, addrvchk, adddrvcharges, 
         delchk, chfchk, deldriverid, (ArrayList<String>) driverarray, inkm, infuel, outDt, 
         outTime, salesagentid, rentalagentid, checkoutid, dueDt, dueTime, 
         (ArrayList<String>) ragmttariffarray, tasystem, tadocno, invoice, exessinsu, 
         (ArrayList<String>) paymentarray, paymentMra, paymentPo, origFleetno, Vehlocationid, 
         fleetgroup, rentalType, advancechk, mode, session, formcode, request, clientname, 
         delcharge, rentaldesc, weekend, hidchkorgregcard, hidchkigst, hidrentalproject, dummyAction
     );

     if (result > 0) {
         status = "success";
         dashboardData = new HashMap<>();
         dashboardData.put("newRentalAgreementNo", String.valueOf(result)); 
     } else {
         status = "error: Database rejected the Delivery dispatch. Check duplicate constraints.";
     }

 } catch (Exception e) {
     status = "error: " + e.getMessage();
     e.printStackTrace();
 }
 return SUCCESS;
}
//==========================================
// DROPDOWN LOOKUP APIS (Matching your message to the mobile team)
// ==========================================

public String getClientList() { 
    try {
        dropdownData = new ClsRentalAgreementDAO().getActualclientSearch(null, clname, mob, "", "", "", "", "1", ""); 
        status="success"; 
    } catch (Exception e) { e.printStackTrace(); status = "error"; }
    return SUCCESS; 
}

public String getFleetList() { 
    try {
        dropdownData = new ClsRentalAgreementDAO().vehSearch(ServletActionContext.getRequest().getSession(), "", "", "", "", "", "yes"); 
        status="success"; 
    } catch (Exception e) { e.printStackTrace(); status = "error"; }
    return SUCCESS; 
}

public String getSalesAgentList() { 
    try {
        dropdownData = new ClsRentalAgreementDAO().SalesgentSearch();
        status = "success";
    } catch (Exception e) { e.printStackTrace(); status = "error"; }
    return SUCCESS; 
}

public String getDriverList() { 
    try {
        dropdownData = new ClsRentalAgreementDAO().chufferinfo(); 
        status="success"; 
    } catch (Exception e) { e.printStackTrace(); status = "error"; }
    return SUCCESS; 
}

public String getLocationList() {
    try {
        // Simple direct JDBC call to fetch active locations for the dropdown
        List<Map<String, String>> locs = new ArrayList<>();
        Connection conn = new ClsConnection().getMyConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT doc_no, loc_name FROM my_locm WHERE status=3");
        while(rs.next()){
            Map<String, String> map = new HashMap<>();
            map.put("doc_no", rs.getString("doc_no"));
            map.put("loc_name", rs.getString("loc_name"));
            locs.add(map);
        }
        rs.close(); stmt.close(); conn.close();
        dropdownData = locs;
        status = "success";
    } catch (Exception e) { e.printStackTrace(); status = "error"; }
    return SUCCESS;
}
}