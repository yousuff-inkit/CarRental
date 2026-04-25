<%@page import="com.dashboard.analysis.utilization.ClsVehUtilizationDAO"%>
<%@page contentType="application/json; charset=UTF-8"%><%
    try {
        String branch   = request.getParameter("branch")   != null ? request.getParameter("branch").trim()  : "";
        String fromdate = request.getParameter("fromdate")  != null ? request.getParameter("fromdate").trim() : "";
        String todate   = request.getParameter("todate")    != null ? request.getParameter("todate").trim()   : "";
        String fleet    = request.getParameter("fleet")     != null ? request.getParameter("fleet").trim()    : "";
        String duration = request.getParameter("duration")  != null ? request.getParameter("duration").trim() : "days";
        String hidbrand = request.getParameter("hidbrand")  != null ? request.getParameter("hidbrand")        : "";
        String hidmodel = request.getParameter("hidmodel")  != null ? request.getParameter("hidmodel")        : "";
        String hidgroup = request.getParameter("hidgroup")  != null ? request.getParameter("hidgroup")        : "";
        String hidyom   = request.getParameter("hidyom")    != null ? request.getParameter("hidyom")          : "";
        String grpby1   = request.getParameter("grpby1")    != null ? request.getParameter("grpby1").trim()   : "";
        ClsVehUtilizationDAO dao = new ClsVehUtilizationDAO();
        Object result = dao.getVehUtilize(branch, fromdate, todate, fleet, "1", duration, grpby1, hidbrand, hidmodel, hidgroup, hidyom);
        out.print(result != null ? result.toString() : "[]");
    } catch(Exception e) {
        out.print("[]");
    }
%>
