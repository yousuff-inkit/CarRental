<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="com.connection.ClsConnection" %>
<%@ page import="com.dashboard.ClsDashBoardDAO,com.dashboard.ClsDashBoardBean" %>
<%@ page import="net.sf.json.JSONArray, net.sf.json.JSONObject" %>

<%
    System.out.println("KPI_DEBUG: dashBoardTiles.jsp loaded");
    String cPath = request.getContextPath();
    String roleId = (session.getAttribute("ROLEID") != null) ? session.getAttribute("ROLEID").toString() : "0";
    String userId = (session.getAttribute("USERID") != null) ? session.getAttribute("USERID").toString() : "";

    // =========================================================================
    // 1. AJAX HANDLER FOR DAO RIGHT PANEL (SUB-MENU LOADING)
    // =========================================================================
    ClsDashBoardDAO tileDao = new ClsDashBoardDAO();
    String ajaxId = request.getParameter("ajaxId");
    if(ajaxId != null && !ajaxId.trim().isEmpty()) {
        out.clear(); 
        try {
            JSONArray jsonResult = tileDao.detailSearch(ajaxId, session);
            out.print((jsonResult == null || jsonResult.isEmpty()) ? "[]" : jsonResult.toString());
        } catch (Exception e) { out.print("[]"); }
        return; 
    }

    // =========================================================================
    // 2. FETCH DAO LEFT NAV MODULES (APPLICATION LIST)
    // =========================================================================
    JSONArray appDataArray = tileDao.masterSearch(session);
    if(appDataArray == null) appDataArray = new JSONArray();

    // =========================================================================
    // 3. SVG DECLARATIONS (MATCHING YOUR SCREENSHOTS)
    // =========================================================================
    String svgBank      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M11.5 1L2 6v2h19V6l-9.5-5zM4 8v10h3V8H4zm5 0v10h3V8H9zm5 0v10h3V8h-3zM2 20v2h19v-2H2z'/></svg>";
    String svgCar       = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.5 16c-.83 0-1.5-.67-1.5-1.5S5.67 13 6.5 13s1.5.67 1.5 1.5S7.33 16 6.5 16zm11 0c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zM5 11l1.5-4.5h11L19 11H5z'/></svg>";
    String svgUser      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z'/></svg>";
    String svgBuilding  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z'/></svg>";
    String svgSettings  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58c.18-.14.23-.41.12-.61l-1.92-3.32c-.12-.22-.37-.29-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54c-.04-.24-.24-.41-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.12.21-.08.47.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.07.94l-2.03 1.58c-.18.14-.23.41-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.57 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.12-.22.07-.47-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z'/></svg>";
    
    // Custom KPI specific icons
    String svgGarage    = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 9h-2V7h-2v5H6v-2H4v6h16v-6h-2v2h-2v-5h-2v5z'/></svg>";
    String svgClipboard = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19 3h-4.18C14.4 1.84 13.3 1 12 1c-1.3 0-2.4.84-2.82 2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 0c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm-2 14l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z'/></svg>";
    String svgWrench    = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M22.7 19l-9.1-9.1c.9-2.3.4-5-1.5-6.9-2-2-5-2.4-7.4-1.3L9 6 6 9 1.6 4.7C.4 7.1.9 10.1 2.9 12.1c1.9 1.9 4.6 2.4 6.9 1.5l9.1 9.1c.4.4 1 .4 1.4 0l2.3-2.3c.5-.4.5-1.1.1-1.4z'/></svg>";
    String svgCheck     = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z'/></svg>";
    String svgClock     = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z'/></svg>";
    String svgCalendar  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z'/></svg>";
    String svgTruck     = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.66 1.34 3 3 3s3-1.34 3-3h6c0 1.66 1.34 3 3 3s3-1.34 3-3h2v-5l-3-4zM6 18.5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm13.5-9l1.96 2.5H17V9.5h2.5zm-1.5 9c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z'/></svg>";
    String svgId        = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M3 5v14h18V5H3zm8 4c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm6 8H5v-1c0-2 4-3.1 7-3.1 3 0 7 1.1 7 3.1v1z'/></svg>";
    String svgPin       = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z'/></svg>";
    String svgSwap      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M6.99 11L3 15l3.99 4v-3H14v-2H6.99v-3zM21 9l-3.99-4v3H10v2h7.01v3L21 9z'/></svg>";
    String svgRoad      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M11 4h2v4h-2zm0 6h2v4h-2zm0 6h2v4h-2z'/></svg>";
    String svgAlert     = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z'/></svg>";

    // =========================================================================
    // 4. PRE-FETCH ALL DAO REPORTS TO BUILD DYNAMIC TILES
    // =========================================================================
    JSONArray allDaoReportsForTiles = new JSONArray();
    System.out.println("KPI_DEBUG: appDataArray (masterSearch) size=" + appDataArray.size());
    for (int i = 0; i < appDataArray.size(); i++) {
        JSONObject appObj = appDataArray.getJSONObject(i);
        String docNo = appObj.optString("doc_no", "");
        String parentDesc = appObj.optString("description", "Unknown");
        String catCode = parentDesc.replaceAll("\\s+", "").toUpperCase();

        try {
            JSONArray subItems = tileDao.detailSearch(docNo, session);
            System.out.println("KPI_DEBUG: detailSearch(parentDocNo=" + docNo + ") returned " + (subItems == null ? "null" : subItems.size() + " row(s)"));
            if (subItems != null && !subItems.isEmpty()) {
                for (int j = 0; j < subItems.size(); j++) {
                    JSONObject sub = subItems.getJSONObject(j);
                    System.out.println("KPI_DEBUG: detailSearch row -> parentDocNo=" + docNo + " doc_no=" + sub.optString("doc_no", "") + " description=" + sub.optString("description", ""));
                    sub.put("category", catCode);
                    sub.put("parentDesc", parentDesc);
                    sub.put("parentDocNo", docNo);
                    allDaoReportsForTiles.add(sub);
                }
            }
        } catch (Exception e) { System.out.println("KPI_DEBUG: detailSearch(parentDocNo=" + docNo + ") threw: " + e); }
    }

    // =========================================================================
    // 5. LIVE KPI COUNTS (fetched from DAO, keyed by real gl_bibd doc_no)
    // =========================================================================
    Map<String, Integer> liveCounts = tileDao.getKpiCounts();

    // =========================================================================
    // 6. FETCH ORIGINAL CORE MODULES (LEGACY SQL MENUS - FOR LEFT NAV ONLY)
    // =========================================================================
    String[][] moduleDefs = {
        {"Finance",          "FIN"},
        {"Operations",       "OPER"},
        {"Fleet Management", "FLEET"},
        {"Fixed Assets",     "ASSET"},
        {"Human Resource",   "HUM"},
        {"Control Centre",   "CONTROL"}
    };

    List<List<ClsDashBoardBean>> allTilesList = new ArrayList<List<ClsDashBoardBean>>();
    for (int i = 0; i < moduleDefs.length; i++) allTilesList.add(new ArrayList<ClsDashBoardBean>());

    Connection conn = null; Statement stmt = null; ResultSet rs = null;
    try {
        conn = new ClsConnection().getMyConnection();
        for (int mi = 0; mi < moduleDefs.length; mi++) {
            String st = moduleDefs[mi][1];
            stmt = conn.createStatement();
            String sql =
                "SELECT DISTINCT menu_name, func FROM ( " +
                "  SELECT m2.menu_name, m2.func FROM my_menu m1 JOIN my_menu m2 ON m2.pmenu = m1.mno LEFT JOIN my_powr p ON p.mno = m2.mno " +
                "  WHERE (m1.menu_name LIKE '%" + st + "%' OR m1.doc_type LIKE '%" + st + "%') AND m2.GATE != 'N' AND m2.func IS NOT NULL AND m2.func <> '' AND p.roleid = '" + roleId + "' AND (p.add1<>0 OR p.view<>0) " +
                "  UNION SELECT m3.menu_name, m3.func FROM my_menu m1 JOIN my_menu m2 ON m2.pmenu = m1.mno JOIN my_menu m3 ON m3.pmenu = m2.mno LEFT JOIN my_powr p ON p.mno = m3.mno " +
                "  WHERE (m1.menu_name LIKE '%" + st + "%' OR m1.doc_type LIKE '%" + st + "%') AND m3.GATE != 'N' AND m3.func IS NOT NULL AND m3.func <> '' AND p.roleid = '" + roleId + "' AND (p.add1<>0 OR p.view<>0) " +
                ") all_menus ORDER BY menu_name";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String title = rs.getString("menu_name");
                String dbLink = rs.getString("func");
                String fullUrl = (!dbLink.startsWith("/") ? cPath + "/" : cPath) + dbLink + (dbLink.contains("?") ? "&" : "?") + "menuname=" + title.replace(" ", "%20");
                ClsDashBoardBean bean = new ClsDashBoardBean();
                bean.setTxttitle(title); bean.setTxtdescription(fullUrl);
                allTilesList.get(mi).add(bean);
            }
            rs.close(); stmt.close();
        }
    } catch (Exception e) {} finally { if (conn != null) try { conn.close(); } catch(Exception e){} }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<%= cPath %>/scripts/jquery-1.11.1.min.js"></script>
<style>
    * { box-sizing: border-box; }
    body, html { margin: 0; padding: 0; font-family: "Segoe UI", Roboto, sans-serif; background: #f0f2f5; height: 100%; overflow: hidden; }
    ::-webkit-scrollbar { width: 4px; height: 4px; }
    ::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }

    .banner { height: 80px; background: linear-gradient(135deg, #1e293b, #334155); margin: 10px 15px 0; border-radius: 8px; display: flex; align-items: center; padding: 0 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); flex-shrink: 0; color: #fff; }
    .banner-title { font-size: 20px; font-weight: 700; }
    .banner-sub   { font-size: 13px; opacity: 0.9; margin-top: 4px; }

    .app-body { display: flex; gap: 0; margin: 15px; height: calc(100vh - 120px); background: #fff; border-radius: 8px; border: 1px solid #e0e4ea; box-shadow: 0 1px 4px rgba(0,0,0,0.06); overflow: hidden; }

    .left-nav { width: 280px; min-width: 280px; border-right: 1px solid #e8eaed; background: #fafbfc; height: 100%; overflow-y: auto; display: block; }
    .accordion-header { flex: 0 0 auto; padding: 14px 16px 10px; font-size: 11px; font-weight: 700; color: #777; letter-spacing: 1px; text-transform: uppercase; border-bottom: 1px solid #eee; background: #f4f6f9; cursor: pointer; display: flex; justify-content: space-between; align-items: center; user-select: none; }
    .accordion-header:hover { background: #eef1f6; color: #333; }
    .acc-arrow { font-size: 10px; transition: transform 0.2s; color: #888; }
    .accordion-header.collapsed .acc-arrow { transform: rotate(-90deg); }
    
    .nav-section-content { display: block; height: auto; }
    .nav-section-content.collapsed { display: none; }
    
    .module-item { border-bottom: 1px solid #eef0f3; cursor: pointer; transition: background 0.15s; }
    .module-item:hover { background: #f0f4ff; }
    .module-item.active { background: #e8f0fe; border-left: 3px solid #3b82f6; }
    
    .module-header { display: flex; align-items: center; gap: 10px; padding: 12px 14px; user-select: none; }
    .module-icon-wrap { width: 30px; height: 30px; border-radius: 7px; display: flex; align-items: center; justify-content: center; flex: 0 0 30px; }
    .module-icon-wrap svg { width: 16px; height: 16px; }
    
    .module-label { flex: 1; font-size: 13px; font-weight: 600; color: #3c3c3c; }
    .module-item.active .module-label { color: #1d4ed8; }
    
    .submenu { display: none; background: #fff; border-top: 1px solid #f0f0f0; cursor: default; }
    .module-item.active .submenu { display: block; }
    .submenu-link { display: flex; align-items: center; gap: 8px; padding: 8px 14px 8px 22px; font-size: 12px; color: #555; text-decoration: none; cursor: pointer; transition: background 0.12s, color 0.12s; border: none; background: none; width: 100%; text-align: left; }
    .submenu-link::before { content: "·"; color: #bbb; font-size: 16px; line-height: 1; }
    .submenu-link:hover { background: #f5f7ff; color: #3b82f6; }
    .submenu-empty { padding: 10px 22px; font-size: 12px; color: #bbb; font-style: italic; }

    .right-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; background: #fff;}
    .panel-header { flex: 0 0 auto; padding: 16px 24px; border-bottom: 1px solid #eef0f3; display: flex; justify-content: space-between; align-items: center; }
    .panel-title { font-size: 18px; font-weight: 700; color: #0f172a; }
    
    .kpi-area { flex: 1; overflow-y: auto; padding: 24px; background: #f8fafc; }
    .kpi-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 16px; }
    
    .kpi-card { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 16px; display: flex; flex-direction: column; transition: box-shadow 0.2s, transform 0.2s; cursor: pointer; min-height: 130px; }
    .kpi-card:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.06); }
    
    .kpi-icon-wrap { width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px; }
    .kpi-icon-wrap svg { width: 18px; height: 18px; fill: currentColor; }
    
    .kpi-value { font-size: 24px; font-weight: 700; color: #0f172a; line-height: 1.2; margin-bottom: 4px; }
    .kpi-title { font-size: 13px; color: #334155; font-weight: 500; margin-bottom: 2px; }
    .kpi-subtitle { font-size: 11.5px; color: #64748b; text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }
    
    .empty-kpi { grid-column: 1 / -1; text-align: center; padding: 40px; color: #94a3b8; font-size: 14px; }
</style>
</head>
<body>

<div class="banner">
    <div>
        <div class="banner-title">Welcome, ${sessionScope.USERNAME}</div>
        <div class="banner-sub">Dashboard Overview</div>
    </div>
</div>

<!-- ======================================================================= -->
<!-- HIDDEN KPI DEFINITIONS - DYNAMICALLY MAPPED FROM DAO -->
<!-- ======================================================================= -->
<div id="kpiMasterTemplate" style="display: none;">
<%
    // 1. ICON/COLOR CYCLE - the DB doesn't hold styling info, so style is assigned by position, not by doc_no
    String[] kpiIconCycle  = { svgClipboard, svgCar, svgGarage, svgWrench, svgCheck, svgClock, svgCalendar, svgTruck, svgId, svgPin, svgSwap, svgAlert };
    String[] kpiColorCycle = { "#0284c7","#16a34a","#d97706","#db2777","#9333ea","#dc2626","#0056b3","#1a7340","#b75d00","#4a148c","#00695c","#b71c1c" };
    String[] kpiBgCycle    = { "#e0f2fe","#dcfce7","#fef3c7","#fce7f3","#f3e8ff","#fee2e2","#e8f0fe","#e8f5e9","#fff3e0","#f3e5f5","#e0f2f1","#fce4ec" };

    // 2. DYNAMICALLY LOOP EVERY DAO REPORT ROW INTO A TILE - no curated doc_no allow-list
    if (allDaoReportsForTiles != null) {
        for (int i = 0; i < allDaoReportsForTiles.size(); i++) {
            JSONObject reportObj = allDaoReportsForTiles.getJSONObject(i);
            String formName = reportObj.optString("description", "");
            String docNo = reportObj.optString("doc_no", "");
            String parentDocNo = reportObj.optString("parentDocNo", "");
            String exactPath = reportObj.optString("path", "");
            String val = reportObj.optString("value", "");
            String parentName = reportObj.optString("parentDesc", "");

            String iconSvg = kpiIconCycle[i % kpiIconCycle.length];
            String textColor = kpiColorCycle[i % kpiColorCycle.length];
            String bgColor = kpiBgCycle[i % kpiBgCycle.length];

            System.out.println("KPI_DEBUG: pre-lookup docNo=" + docNo + " containsKey=" + liveCounts.containsKey(docNo) + " liveCounts.keySet()=" + liveCounts.keySet());
            // Live SQL count from the DAO (defaults to 0 only when this doc_no has no count mapped)
            String liveValue = liveCounts.containsKey(docNo) ? String.valueOf(liveCounts.get(docNo)) : "0";
            System.out.println("KPI_DEBUG: tile docNo=" + docNo + " formName=" + formName + " containsKey=" + liveCounts.containsKey(docNo) + " liveValue=" + liveValue);

            String clickAction = "openDetailLink('" + formName.replace("'", "\\'") + "', '" + exactPath + "', '" + docNo + "', '" + parentName.replace("'", "\\'") + "', '" + val + "')";
%>
            <!-- DYNAMIC TILE GENERATION -->
            <div class="kpi-card kpi-cat-ALL kpi-cat-DOC<%= parentDocNo %>" onclick="<%= clickAction %>">
                <div class="kpi-icon-wrap" style="background-color: <%= bgColor %>; color: <%= textColor %>;">
                    <%= iconSvg %>
                </div>
                <div class="kpi-value"><%= liveValue %></div>
                <div class="kpi-title" title="<%= formName %>"><%= formName %></div>
                <div class="kpi-subtitle"><%= parentName %></div>
            </div>
<%
        }
    }
%>
</div>
<!-- ======================================================================= -->

<div class="app-body">
    <!-- LEFT NAVIGATION -->
    <div class="left-nav">
        
        <!-- CORE MODULES ACCORDION -->
        <div class="accordion-header" onclick="toggleAccordion('coreModulesContent', this)">
            <span>Modules Overview</span>
            <span class="acc-arrow">&#9660;</span>
        </div>
        
        <div class="nav-section-content collapsed" id="coreModulesContent">
            <%
                String[] navIcons = {svgBank, svgCar, svgCar, svgBuilding, svgUser, svgSettings};
                String[] navColors = {"#0056b3","#1a7340","#b75d00","#4a148c","#00695c","#b71c1c"};
                String[] navBgs    = {"#e8f0fe","#e8f5e9","#fff3e0","#f3e5f5","#e0f2f1","#fce4ec"};

                for (int mi = 0; mi < moduleDefs.length; mi++) {
                    String modName = moduleDefs[mi][0];
                    String catCode = moduleDefs[mi][1]; 
                    int tileCount = allTilesList.get(mi).size();
            %>
                <div class="module-item sql-module" data-idx="<%= mi %>" data-category="<%= catCode %>">
                    <div class="module-header" onclick="selectSqlModule(this)">
                        <div class="module-icon-wrap" style="background:<%= navBgs[mi] %>; color:<%= navColors[mi] %>;">
                            <%= navIcons[mi] %>
                        </div>
                        <span class="module-label"><%= modName %></span>
                    </div>
                    <div class="submenu">
                        <% if (tileCount == 0) { %>
                            <div class="submenu-empty">No forms available</div>
                        <% } else { for (ClsDashBoardBean t : allTilesList.get(mi)) { %>
                            <button type="button" class="submenu-link" onclick="event.stopPropagation(); routeKpiLikeMenu('<%= t.getTxttitle().replace("'", "\\'") %>')"><%= t.getTxttitle() %></button>
                        <% } } %>
                    </div>
                </div>
            <% } %>
        </div> 
        
        <!-- APPLICATIONS ACCORDION -->
        <div class="accordion-header" onclick="toggleAccordion('applicationsContent', this)">
            <span>Applications (Reports)</span>
            <span class="acc-arrow">&#9660;</span>
        </div>
        
        <div class="nav-section-content" id="applicationsContent">
            <div class="module-item active" onclick="filterKpiCategory('ALL', this)">
                <div class="module-header">
                    <div class="module-icon-wrap" style="background:#fef3c7; color:#d97706;">
                        <%= svgGarage %>
                    </div>
                    <span class="module-label">All KPI Tiles</span>
                </div>
            </div>
            <%
                String[] appColors = {"#0056b3", "#1a7340", "#b75d00", "#4a148c", "#00695c", "#b71c1c", "#d35400", "#2980b9", "#8e44ad", "#27ae60"};
                String[] appBgs    = {"#e8f0fe", "#e8f5e9", "#fff3e0", "#f3e5f5", "#e0f2f1", "#fce4ec", "#fbeee6", "#ebf5fb", "#f5eef8", "#e9f7ef"};

                for (int i = 0; i < appDataArray.size(); i++) {
                    JSONObject item = appDataArray.getJSONObject(i);
                    String docNo = item.optString("doc_no", "");
                    String description = item.optString("description", "Unknown");
            %>
                <div class="module-item dao-module" data-docno="<%= docNo %>" data-desc="<%= description %>">
                    <div class="module-header" onclick="triggerDaoModuleSelect(this)">
                        <div class="module-icon-wrap" style="background:<%= appBgs[i % appBgs.length] %>; color:<%= appColors[i % appColors.length] %>;">
                            <%= svgCar %>
                        </div>
                        <span class="module-label"><%= description %></span>
                    </div>
                    <div class="submenu"></div>
                </div>
            <% } %>
        </div> 
    </div>

    <!-- RIGHT KPI PANEL -->
    <div class="right-content">
        <div class="panel-header">
            <div class="panel-title" id="kpiPanelTitle">All KPI Tiles</div>
        </div>
        <div class="kpi-area">
            <div class="kpi-grid" id="kpiGridContainer">
                <!-- INJECTED DYNAMICALLY BY JS -->
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Initialize dashboard showing every KPI tile across all report categories
        filterKpiCategory('ALL', $('.module-item.active').first());
    });

    function toggleAccordion(contentId, headerElement) {
        $(headerElement).find('.acc-arrow').css('transform', $('#' + contentId).hasClass('collapsed') ? 'rotate(0deg)' : 'rotate(-90deg)');
        $('#' + contentId).toggleClass('collapsed');
    }

    function injectKpisIntoGrid(categoryStr) {
        var $targetGrid = $('#kpiGridContainer');
        $targetGrid.empty(); 
        
        var $matchedKpis = $('#kpiMasterTemplate .kpi-cat-' + categoryStr).clone();

        if ($matchedKpis.length > 0) {
            $targetGrid.append($matchedKpis);
        } else {
            $targetGrid.html('<div class="empty-kpi">Select a sub-menu item from the left to load its report tab.</div>');
        }
    }

    function filterKpiCategory(category, activeElem) {
        if(activeElem) {
            $('.module-item').removeClass('active');
            $(activeElem).addClass('active');
        }
        $('#kpiPanelTitle').text("All KPI Tiles");
        injectKpisIntoGrid(category);
    }

    function selectSqlModule(headerElement) {
        var $parentItem = $(headerElement).closest('.module-item');
        if($parentItem.hasClass('active')) {
            $parentItem.removeClass('active');
            filterKpiCategory('ALL', $('.module-item').first());
            return;
        }
        $('.module-item').removeClass('active');
        $parentItem.addClass('active');
        
        $('#kpiPanelTitle').text($parentItem.find('.module-label').text());
        injectKpisIntoGrid('NONE'); 
    }

    function triggerDaoModuleSelect(headerElement) {
        var $parentItem = $(headerElement).closest('.module-item');
        if($parentItem.hasClass('active')) {
            $parentItem.removeClass('active');
            filterKpiCategory('ALL', $('.module-item').first());
            return;
        }

        $('.module-item').removeClass('active');
        $parentItem.addClass('active');

        var docNo = $parentItem.data('docno');
        var desc = $parentItem.data('desc');

        $('#kpiPanelTitle').text(desc);
        injectKpisIntoGrid('DOC' + docNo);

        $parentItem.find('.submenu').html('<div class="submenu-empty">Loading...</div>'); 
        $.ajax({
            url: window.location.href,
            type: "POST",
            data: { ajaxId: docNo },
            dataType: "json",
            success: function(response) {
                var $submenu = $parentItem.find('.submenu').empty(); 
                if (!response || response.length === 0) {
                    $submenu.html('<div class="submenu-empty">No forms available</div>');
                    return;
                }
                $.each(response, function(i, item) {
                    var cleanDesc = item.description.replace(/'/g, "\\'");
                    var exactPath = item.path;
                    var itemDocNo = item.doc_no;
                    var itemVal = item.value;
                    var cleanMainDesc = desc.replace(/'/g, "\\'");
                    
                    var clickAction = "openDetailLink('" + cleanDesc + "', '" + exactPath + "', '" + itemDocNo + "', '" + cleanMainDesc + "', '" + itemVal + "')";
                    var btn = '<button type="button" class="submenu-link" onclick="event.stopPropagation(); ' + clickAction + '">' + item.description + '</button>';
                    $submenu.append(btn);
                });
            },
            error: function() {
                $parentItem.find('.submenu').html('<div class="submenu-empty">Failed to load data</div>');
            }
        });
    }

    // =========================================================================
    // NATIVE ROUTING FUNCTION FOR CORE MENUS (SQL) & MANUAL TILES
    // =========================================================================
    function routeKpiLikeMenu(formName) {
        if (window.parent && typeof window.parent.geturl === 'function') {
            window.parent.geturl(formName);
        } else if (typeof top.geturl === 'function') {
            top.geturl(formName);
        } else {
            alert("Routing error: Could not load " + formName);
        }
    }

    // =========================================================================
    // SPECIFIC ROUTING FUNCTION FOR DAO REPORTS (TILES & SUBMENUS)
    // =========================================================================
    function openDetailLink(detName, path, docno, mainDesc, val) {
        // Build the correct full URL to avoid 404 errors by adding context path
        var cPath = window.location.href.split("com/")[0];
        // Ensure path formatting doesn't double-slash
        if(path.charAt(0) === '/') { path = path.substring(1); }
        
        var fullUrl = cPath + path + "?name=" + encodeURIComponent(detName) + "&main=" + encodeURIComponent(mainDesc) + "&docno=" + docno + "&value=" + val;
        
        // Push this directly into Struts framework tab generation
        if (typeof top.addTab === 'function') {
            top.addTab(detName, fullUrl);
        } else if (window.parent && typeof window.parent.addTab === 'function') {
            window.parent.addTab(detName, fullUrl);
        } else if (window.parent && typeof window.parent.geturl === 'function') {
            window.parent.geturl(detName); 
        } else {
            window.location.href = fullUrl;
        }
    }
</script>
</body>
</html>