<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>

<%
ClsConnection ClsConnection = new ClsConnection();
ClsCommon ClsCommon = new ClsCommon();

Connection conn = null;
Statement stmt1 = null;
Statement stmt2 = null;
Statement stmt3 = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;

String agmtype = (request.getParameter("agmtype") == null || request.getParameter("agmtype").equals("")) ? "" : request.getParameter("agmtype");
String drvid = request.getParameter("drvid") == null ? "0" : request.getParameter("drvid");
String agmdocno = request.getParameter("agmdocno") == null ? "0" : request.getParameter("agmdocno");

int val1 = 0, val2 = 0, val3 = 0;

try {
    conn = ClsConnection.getMyConnection();
    conn.setAutoCommit(false);

    // First query
    stmt1 = conn.createStatement();
    String sql1 = "SELECT * FROM gl_invm WHERE rano = " + agmdocno + " AND RATYPE = '" + agmtype+"' ";
    //System.out.println("1st-----"+sql1);
    rs1 = stmt1.executeQuery(sql1);
    if (rs1.next()) {
        val1 = 1;
    }

    // Second query
    stmt2 = conn.createStatement();
    String sql2 = "SELECT * FROM gl_vehreplace WHERE rdocno = " + agmdocno + " AND RTYPE = '" + agmtype+"' ";
    //System.out.println("2nd-----"+sql2);
    
    rs2 = stmt2.executeQuery(sql2);
    if (rs2.next()) {
        val2 = 1;
    }

    // Third query
    stmt3 = conn.createStatement();
    String sql3 = "SELECT * FROM gl_vehcustody WHERE rdocno = " + agmdocno + " AND RTYPE = '" + agmtype+"' ";
  // System.out.println("3rd-----"+sql3);
     rs3 = stmt3.executeQuery(sql3);
    if (rs3.next()) {
        val3 = 1;
    }

    conn.commit();
    response.getWriter().print(val1+"####"+val2+"####"+val3);

} catch (Exception e) {
    e.printStackTrace();
    if (conn != null) conn.rollback();
} finally {
    if (rs1 != null) rs1.close();
    if (rs2 != null) rs2.close();
    if (rs3 != null) rs3.close();
    if (stmt1 != null) stmt1.close();
    if (stmt2 != null) stmt2.close();
    if (stmt3 != null) stmt3.close();
    if (conn != null) conn.close();
}
%>
