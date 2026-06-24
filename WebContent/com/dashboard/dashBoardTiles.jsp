<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="com.connection.ClsConnection" %>
<%@ page import="com.dashboard.ClsDashBoardDAO,com.dashboard.ClsDashBoardBean" %>

<%
    String svgBank      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M11.5 1L2 6v2h19V6l-9.5-5zM4 8v10h3V8H4zm5 0v10h3V8H9zm5 0v10h3V8h-3zM2 20v2h19v-2H2z'/></svg>";
    String svgCard      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z'/></svg>";
    String svgCash      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M11.8 10.9c-2.27-.59-3-1.2-3-2.15 0-1.09 1.01-1.85 2.7-1.85 1.78 0 2.44.85 2.5 2.1h2.21c-.07-1.72-1.12-3.3-3.21-3.81V3h-3v2.16c-1.94.42-3.5 1.68-3.5 3.61 0 2.31 1.91 3.46 4.7 4.13 2.5.6 3 1.48 3 2.41 0 .69-.49 1.79-2.7 1.79-2.06 0-2.87-.92-2.98-2.1h-2.2c.12 2.19 1.76 3.42 3.68 3.83V21h3v-2.15c1.95-.37 3.5-1.5 3.5-3.55 0-2.84-2.43-3.81-4.7-4.4z'/></svg>";
    String svgFile      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z'/></svg>";
    String svgCar       = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.5 16c-.83 0-1.5-.67-1.5-1.5S5.67 13 6.5 13s1.5.67 1.5 1.5S7.33 16 6.5 16zm11 0c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zM5 11l1.5-4.5h11L19 11H5z'/></svg>";
    String svgUser      = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z'/></svg>";
    String svgHandshake = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M15.42 8.78l-3.23-2.91c-.48-.43-1.22-.38-1.65.11L10.3 6.22 8.5 4.6c-.39-.35-1-.35-1.39 0l-5.66 5.1c-.39.35-.39.91 0 1.26l.99.89-1.87 1.68c-.39.35-.39.91 0 1.26l2.83 2.55c.39.35 1.01.35 1.4 0l1.87-1.68.99.89c.39.35 1.01.35 1.4 0l6.36-5.72c.43-.49.38-1.23-.11-1.65z'/></svg>";
    String svgCalendar  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z'/></svg>";
    String svgWrench    = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M22.7 19l-9.1-9.1c.9-2.3.4-5-1.5-6.9-2-2-5-2.4-7.4-1.3L9 6 6 9 1.6 4.7C.4 7.1.9 10.1 2.9 12.1c1.9 1.9 4.6 2.4 6.9 1.5l9.1 9.1c.4.4 1 .4 1.4 0l2.3-2.3c.5-.4.5-1.1.1-1.4z'/></svg>";
    String svgBuilding  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z'/></svg>";
    String svgSettings  = "<svg viewBox='0 0 24 24'><path fill='currentColor' d='M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58c.18-.14.23-.41.12-.61l-1.92-3.32c-.12-.22-.37-.29-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54c-.04-.24-.24-.41-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.12.21-.08.47.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.07.94l-2.03 1.58c-.18.14-.23.41-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.57 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.12-.22.07-.47-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z'/></svg>";

    Map<String, String> iconMap = new HashMap<String, String>();
    iconMap.put("Accounts Master", svgBuilding);
    iconMap.put("Bank Payments", svgCard);
    iconMap.put("Bank Receipts", svgBank);
    iconMap.put("Cash Payments", svgCash);
    iconMap.put("IB Bank Payment", svgCard);
    iconMap.put("IB Bank Receipt", svgBank);
    iconMap.put("Booking", svgCalendar);
    iconMap.put("Client", svgUser);
    iconMap.put("Movement", svgCar);
    iconMap.put("Maintenance Update", svgWrench);
    iconMap.put("Rental Agreement Create", svgHandshake);

    String cPath = request.getContextPath();
    String roleId = (session.getAttribute("ROLEID") != null) ? session.getAttribute("ROLEID").toString() : "0";

    // [displayName, searchTerm, paramKey, accentColor, bgColor, iconVar, description]
    String[][] moduleDefs = {
        {"Finance",          "Fin",     "Finance",   "#0056b3", "#e8f0fe", "bank",     "Manage accounts, payments, receipts and financial transactions"},
        {"Operations",       "Oper",    "Operation", "#1a7340", "#e8f5e9", "car",      "Handle bookings, movements, agreements and client workflows"},
        {"Fleet Management", "Fleet",   "Fleet",     "#b75d00", "#fff3e0", "car",      "Track vehicle assignments, maintenance and fleet utilization"},
        {"Fixed Assets",     "Asset",   "Asset",     "#4a148c", "#f3e5f5", "building", "Manage company assets, depreciation and asset tracking"},
        {"Human Resource",   "Hum",     "Human",     "#00695c", "#e0f2f1", "user",     "Employee management, attendance and payroll operations"},
        {"Control Centre",   "Control", "Control",   "#b71c1c", "#fce4ec", "settings", "System configuration, user roles and administrative controls"}
    };

    // Determine active module
    String selectedParam = request.getParameter("module");
    if (selectedParam == null || selectedParam.trim().isEmpty()) selectedParam = "Finance";
    int activeIdx = 0;
    for (int i = 0; i < moduleDefs.length; i++) {
        if (moduleDefs[i][2].equalsIgnoreCase(selectedParam)) { activeIdx = i; break; }
    }

    // Fetch tiles for ALL modules
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
                "  SELECT m2.menu_name, m2.func FROM my_menu m1 " +
                "  JOIN my_menu m2 ON m2.pmenu = m1.mno " +
                "  LEFT JOIN my_powr p ON p.mno = m2.mno " +
                "  WHERE (m1.menu_name LIKE '%" + st + "%' OR m1.doc_type LIKE '%" + st + "%') " +
                "  AND m2.GATE != 'N' AND m2.func IS NOT NULL AND m2.func <> '' " +
                "  AND p.roleid = '" + roleId + "' AND (p.add1<>0 OR p.edit<>0 OR p.del<>0 OR p.print<>0 OR p.attach<>0 OR p.excel<>0 OR p.view<>0) " +
                "  UNION " +
                "  SELECT m3.menu_name, m3.func FROM my_menu m1 " +
                "  JOIN my_menu m2 ON m2.pmenu = m1.mno " +
                "  JOIN my_menu m3 ON m3.pmenu = m2.mno " +
                "  LEFT JOIN my_powr p ON p.mno = m3.mno " +
                "  WHERE (m1.menu_name LIKE '%" + st + "%' OR m1.doc_type LIKE '%" + st + "%') " +
                "  AND m3.GATE != 'N' AND m3.func IS NOT NULL AND m3.func <> '' " +
                "  AND p.roleid = '" + roleId + "' AND (p.add1<>0 OR p.edit<>0 OR p.del<>0 OR p.print<>0 OR p.attach<>0 OR p.excel<>0 OR p.view<>0) " +
                "  UNION " +
                "  SELECT m4.menu_name, m4.func FROM my_menu m1 " +
                "  JOIN my_menu m2 ON m2.pmenu = m1.mno " +
                "  JOIN my_menu m3 ON m3.pmenu = m2.mno " +
                "  JOIN my_menu m4 ON m4.pmenu = m3.mno " +
                "  LEFT JOIN my_powr p ON p.mno = m4.mno " +
                "  WHERE (m1.menu_name LIKE '%" + st + "%' OR m1.doc_type LIKE '%" + st + "%') " +
                "  AND m4.GATE != 'N' AND m4.func IS NOT NULL AND m4.func <> '' " +
                "  AND p.roleid = '" + roleId + "' AND (p.add1<>0 OR p.edit<>0 OR p.del<>0 OR p.print<>0 OR p.attach<>0 OR p.excel<>0 OR p.view<>0) " +
                ") all_menus ORDER BY menu_name";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String title = rs.getString("menu_name");
                String dbLink = rs.getString("func");
                String fullUrl = "#";
                if (dbLink != null && !dbLink.trim().isEmpty()) {
                    fullUrl = (!dbLink.startsWith("/") ? cPath + "/" : cPath) + dbLink;
                    fullUrl += (fullUrl.contains("?") ? "&" : "?") + "menuname=" + title.replace(" ", "%20");
                }
                String icon = iconMap.get(title.trim());
                if (icon == null) icon = svgFile;
                ClsDashBoardBean bean = new ClsDashBoardBean();
                bean.setTxttitle(title); bean.setTxtdescription(fullUrl); bean.setMsg(icon);
                allTilesList.get(mi).add(bean);
            }
            rs.close(); stmt.close();
        }
    } catch (Exception e) { e.printStackTrace(); }
    finally { if (conn != null) conn.close(); }
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
    ::-webkit-scrollbar-thumb:hover { background: #aaa; }

    /* ── Banner ── */
    .banner {
        height: 115px; background-image: url("<%= cPath %>/icons/banner_image.png");
        background-size: cover; background-position: center; margin: 10px 15px 0;
        border-radius: 8px; position: relative; display: flex; align-items: center;
        padding: 0 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .banner::before { content: ""; position: absolute; inset: 0; background: rgba(0,0,0,0.22); border-radius: 8px; }
    .banner-inner { z-index: 2; color: #fff; display: flex; align-items: center; width: 100%; justify-content: space-between; }
    .banner-title { font-size: 22px; font-weight: 700; text-shadow: 1px 1px 4px rgba(0,0,0,0.4); }
    .banner-sub   { font-size: 13px; opacity: 0.9; margin-top: 2px; }

    /* Switch Dashboard dropdown */
    .home-dropdown { position: relative; display: inline-block; z-index: 100; }
    .dropbtn { background: rgba(255,255,255,0.18); color: #fff; padding: 7px 14px; font-size: 12px; font-weight: 600; border: 1px solid rgba(255,255,255,0.35); border-radius: 5px; cursor: pointer; display: flex; align-items: center; gap: 7px; transition: background 0.2s; }
    .dropbtn:hover { background: rgba(255,255,255,0.28); }
    .dropdown-content { display: none; position: absolute; right: 0; background: #fff; min-width: 200px; box-shadow: 0 6px 20px rgba(0,0,0,0.15); border-radius: 6px; top: 38px; overflow: hidden; }
    .dropdown-content a { color: #333; padding: 11px 15px; text-decoration: none; display: block; font-size: 12px; border-bottom: 1px solid #f0f0f0; transition: background 0.15s; }
    .dropdown-content a:last-child { border-bottom: none; }
    .dropdown-content a:hover { background: #f5f7ff; color: #0056b3; }
    .home-dropdown:hover .dropdown-content { display: block; }

    /* ── Main layout ── */
    .app-body {
        display: flex; gap: 0;
        margin: 10px 15px 10px;
        height: calc(100vh - 148px);
        background: #fff;
        border-radius: 8px;
        border: 1px solid #e0e4ea;
        box-shadow: 0 1px 4px rgba(0,0,0,0.06);
        overflow: hidden;
    }

    /* ── Left Navigation ── */
    .left-nav {
        width: 240px; min-width: 240px;
        border-right: 1px solid #e8eaed;
        display: flex; flex-direction: column;
        background: #fafbfc;
    }
    .left-nav-header {
        padding: 14px 16px 10px;
        font-size: 10px; font-weight: 700; color: #999;
        letter-spacing: 1px; text-transform: uppercase;
        border-bottom: 1px solid #eee;
        flex: 0 0 auto;
    }
    .nav-list { flex: 1; overflow-y: auto; }

    .module-item { border-bottom: 1px solid #eef0f3; }
    .module-header {
        display: flex; align-items: center; gap: 10px;
        padding: 11px 14px; cursor: pointer;
        transition: background 0.15s;
        user-select: none;
    }
    .module-header:hover { background: #f0f4ff; }
    .module-item.active > .module-header { background: #e8f0fe; }

    .module-icon-wrap {
        width: 30px; height: 30px; border-radius: 7px;
        display: flex; align-items: center; justify-content: center;
        flex: 0 0 30px;
    }
    .module-icon-wrap svg { width: 16px; height: 16px; }

    .module-label { flex: 1; font-size: 13px; font-weight: 600; color: #3c3c3c; }
    .module-item.active > .module-header .module-label { color: #0056b3; }

    .module-count {
        font-size: 10px; font-weight: 700; padding: 2px 7px;
        border-radius: 10px; margin-right: 4px;
    }
    .module-arrow { font-size: 9px; color: #aaa; transition: transform 0.2s; line-height: 1; }
    .module-item.active > .module-header .module-arrow { transform: rotate(90deg); color: #0056b3; }

    .submenu { display: none; background: #fff; border-top: 1px solid #f0f0f0; }
    .module-item.active .submenu { display: block; }
    .submenu-link {
        display: flex; align-items: center; gap: 8px;
        padding: 8px 14px 8px 22px; font-size: 12px; color: #555;
        text-decoration: none; cursor: pointer;
        transition: background 0.12s, color 0.12s;
        border: none; background: none; width: 100%; text-align: left;
    }
    .submenu-link::before { content: "·"; color: #bbb; font-size: 16px; line-height: 1; }
    .submenu-link:hover { background: #f5f7ff; color: #0056b3; }
    .submenu-link:hover::before { color: #0056b3; }
    .submenu-empty { padding: 10px 22px; font-size: 12px; color: #bbb; font-style: italic; }

    /* ── Right Content Panel ── */
    .right-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; }

    .module-panel { display: none; flex-direction: column; height: 100%; }
    .module-panel.active { display: flex; }

    .panel-header {
        flex: 0 0 auto; padding: 16px 20px 14px;
        border-bottom: 1px solid #eef0f3;
        display: flex; align-items: center; justify-content: space-between;
        gap: 14px;
    }
    .panel-header-left { display: flex; align-items: center; gap: 14px; }
    .panel-module-icon {
        width: 42px; height: 42px; border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
        flex: 0 0 42px;
    }
    .panel-module-icon svg { width: 22px; height: 22px; }
    .panel-module-name { font-size: 17px; font-weight: 700; color: #222; line-height: 1.2; }
    .panel-module-desc { font-size: 12px; color: #888; margin-top: 2px; }
    .panel-meta { display: flex; align-items: center; gap: 10px; }
    .badge-count {
        font-size: 11px; font-weight: 700; padding: 4px 10px;
        border-radius: 12px; white-space: nowrap;
    }
    .panel-search input {
        padding: 6px 14px; border: 1px solid #dde; border-radius: 16px;
        font-size: 12px; outline: none; width: 150px; background: #f8f9fb;
        transition: border-color 0.2s, box-shadow 0.2s, width 0.3s;
    }
    .panel-search input:focus { border-color: #0056b3; box-shadow: 0 0 0 3px rgba(0,86,179,0.1); width: 200px; background: #fff; }

    .tiles-area { flex: 1; overflow-y: auto; padding: 16px 20px; }
    .tiles-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
        gap: 12px;
    }
    .tile-card {
        background: #fff; border: 1px solid #eaecf0; border-radius: 9px;
        padding: 14px 10px 12px; display: flex; flex-direction: column;
        align-items: center; justify-content: center; min-height: 90px;
        cursor: pointer; text-decoration: none; transition: transform 0.18s, box-shadow 0.18s, border-color 0.18s;
        text-align: center;
    }
    .tile-card:hover { transform: translateY(-3px); box-shadow: 0 6px 16px rgba(0,0,0,0.08); border-color: #c0cfe8; }
    .tile-icon { width: 26px; height: 26px; margin-bottom: 8px; }
    .tile-icon svg { width: 100%; height: 100%; }
    .tile-name { font-size: 11px; font-weight: 600; color: #4a4a5a; line-height: 1.3; }

    .empty-state { display: flex; flex-direction: column; align-items: center; justify-content: center; height: 200px; color: #bbb; }
    .empty-state svg { width: 48px; height: 48px; margin-bottom: 10px; opacity: 0.4; }
    .empty-state p { font-size: 13px; margin: 0; }
</style>
</head>
<body>

<!-- Banner -->
<div class="banner">
    <div class="banner-inner">
        <div>
            <div class="banner-title">Welcome, ${sessionScope.USERNAME}</div>
            <div class="banner-sub" id="greeting"></div>
        </div>
        <div class="home-dropdown">
            <button class="dropbtn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                Switch Dashboard
                <span style="font-size:9px;">&#9660;</span>
            </button>
            <div class="dropdown-content">
                <a href="<%= cPath %>/com/dashboard/dashBoardTiles.jsp">
                    <div style="display:flex;align-items:center;gap:10px;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                        <div><strong>Standard View</strong><br><small style="color:#888;">Module Tiles</small></div>
                    </div>
                </a>
                <a href="<%= cPath %>/com/v2/dashBoardnew.jsp">
                    <div style="display:flex;align-items:center;gap:10px;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0056b3" stroke-width="2"><path d="M3 3h18v18H3z"/><path d="M21 9H3"/><path d="M21 15H3"/><path d="M12 3v18"/></svg>
                        <div><strong>My Dashboard</strong><br><small style="color:#888;">Analytics View</small></div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Main app body -->
<div class="app-body">

    <!-- ── Left Navigation ── -->
    <div class="left-nav">
        <div class="left-nav-header">Modules</div>
        <div class="nav-list">
        <%
            // SVG icons per module type for nav icons
            String[] navIcons = {svgBank, svgCar, svgCar, svgBuilding, svgUser, svgSettings};
            String[] navColors = {"#0056b3","#1a7340","#b75d00","#4a148c","#00695c","#b71c1c"};
            String[] navBgs    = {"#e8f0fe","#e8f5e9","#fff3e0","#f3e5f5","#e0f2f1","#fce4ec"};

            for (int mi = 0; mi < moduleDefs.length; mi++) {
                String modName = moduleDefs[mi][0];
                boolean isActive = (mi == activeIdx);
                int tileCount = allTilesList.get(mi).size();
                String color = navColors[mi];
                String bg    = navBgs[mi];
                String navIcon = navIcons[mi];
        %>
            <div class="module-item <%= isActive ? "active" : "" %>" data-idx="<%= mi %>">
                <div class="module-header" onclick="selectModule(<%= mi %>)">
                    <div class="module-icon-wrap" style="background:<%= bg %>; color:<%= color %>;">
                        <%= navIcon %>
                    </div>
                    <span class="module-label"><%= modName %></span>
                    <% if (tileCount > 0) { %>
                    <span class="module-count" style="background:<%= bg %>; color:<%= color %>;"><%= tileCount %></span>
                    <% } %>
                    <span class="module-arrow">&#9654;</span>
                </div>
                <div class="submenu">
                    <% if (tileCount == 0) { %>
                        <div class="submenu-empty">No forms available</div>
                    <% } else { for (ClsDashBoardBean t : allTilesList.get(mi)) { %>
                        <button class="submenu-link" onclick="openParentMenu('<%= t.getTxttitle().replace("'", "\\'") %>')"><%= t.getTxttitle() %></button>
                    <% } } %>
                </div>
            </div>
        <% } %>
        </div>
    </div>

    <!-- ── Right Content Panels ── -->
    <div class="right-content">
    <%
        for (int mi = 0; mi < moduleDefs.length; mi++) {
            String modName   = moduleDefs[mi][0];
            String modDesc   = moduleDefs[mi][6];
            boolean isActive = (mi == activeIdx);
            int tileCount    = allTilesList.get(mi).size();
            String color     = navColors[mi];
            String bg        = navBgs[mi];
            String navIcon   = navIcons[mi];
            String safeId    = "panel_" + mi;
    %>
        <div class="module-panel <%= isActive ? "active" : "" %>" id="<%= safeId %>">
            <div class="panel-header">
                <div class="panel-header-left">
                    <div class="panel-module-icon" style="background:<%= bg %>; color:<%= color %>;">
                        <%= navIcon %>
                    </div>
                    <div>
                        <div class="panel-module-name" style="color:<%= color %>;"><%= modName %></div>
                        <div class="panel-module-desc"><%= modDesc %></div>
                    </div>
                </div>
                <div class="panel-meta">
                    <span class="badge-count" style="background:<%= bg %>; color:<%= color %>;">
                        <%= tileCount %> <%= tileCount == 1 ? "Form" : "Forms" %>
                    </span>
                    <div class="panel-search">
                        <input type="text" placeholder="Search forms..." oninput="filterPanel(this, '<%= safeId %>')">
                    </div>
                </div>
            </div>
            <div class="tiles-area">
                <% if (tileCount == 0) { %>
                    <div class="empty-state">
                        <svg viewBox="0 0 24 24"><path fill="currentColor" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>
                        <p>No forms available for this module</p>
                    </div>
                <% } else { %>
                    <div class="tiles-grid" id="grid_<%= mi %>">
                    <% for (ClsDashBoardBean t : allTilesList.get(mi)) { %>
                        <div class="tile-card" onclick="openParentMenu('<%= t.getTxttitle().replace("'", "\\'") %>')" title="<%= t.getTxttitle() %>">
                            <div class="tile-icon" style="color:<%= color %>;"><%= t.getMsg() %></div>
                            <div class="tile-name"><%= t.getTxttitle() %></div>
                        </div>
                    <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    <% } %>
    </div>

</div>

<script>
    $(function() {
        var h = new Date().getHours();
        $('#greeting').text(h < 12 ? 'Good Morning' : h < 18 ? 'Good Afternoon' : 'Good Evening');
    });

    function selectModule(idx) {
        var clicked = document.querySelector('.module-item[data-idx="' + idx + '"]');
        var isAlreadyActive = clicked.classList.contains('active');

        // Collapse all
        document.querySelectorAll('.module-item').forEach(function(el) { el.classList.remove('active'); });
        document.querySelectorAll('.module-panel').forEach(function(el) { el.classList.remove('active'); });

        // If it wasn't active before, expand it
        if (!isAlreadyActive) {
            clicked.classList.add('active');
            document.getElementById('panel_' + idx).classList.add('active');

            // Clear search on panel switch
            document.querySelectorAll('.panel-search input').forEach(function(el) { el.value = ''; });
            document.querySelectorAll('.tile-card').forEach(function(el) { el.style.display = ''; });
        }
    }

    function filterPanel(input, panelId) {
        var val = input.value.toUpperCase().replace(/\s+/g, '');
        var panel = document.getElementById(panelId);
        panel.querySelectorAll('.tile-card').forEach(function(card) {
            var name = card.querySelector('.tile-name').textContent.toUpperCase().replace(/\s+/g, '');
            card.style.display = (name.indexOf(val) > -1) ? '' : 'none';
        });
    }

    function openParentMenu(title) {
        if (window.parent && window.parent.geturl) window.parent.geturl(title);
    }
</script>
</body>
</html>
