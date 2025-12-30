<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dashboard.dto.TileBean" %>
<%@ page import="com.dashboard.ClsDashBoardDAO" %>
<%@ page import="net.sf.json.JSONArray" %>

<%
    // --- 1. AJAX LISTENER (Background Server) ---
    String ajaxId = request.getParameter("ajaxId");
    
    if(ajaxId != null && !ajaxId.trim().isEmpty()) {
        out.clear(); 
        try {
            ClsDashBoardDAO dao = new ClsDashBoardDAO();
            JSONArray jsonResult = dao.detailSearch(ajaxId, session);
            
            if(jsonResult == null || jsonResult.isEmpty()) {
                out.print("[]");
            } else {
                out.print(jsonResult.toString());
            }
        } catch (Exception e) {
            out.print("[]");
        }
        return; 
    }

    // --- 2. NORMAL PAGE LOAD ---
    String selectedModule = request.getParameter("module");
    if(selectedModule == null || selectedModule.trim().isEmpty()){
        selectedModule = "Finance";
    }

    ClsDashBoardDAO tileDao = new ClsDashBoardDAO();
    String cPath = request.getContextPath();
    List<TileBean> tiles = tileDao.getDashboardTiles(cPath, selectedModule);
    
    // Bottom Lists
    JSONArray jsonArray = tileDao.masterSearch(session);
    String gridData = (jsonArray != null) ? jsonArray.toString() : "[]";

    JSONArray detailArray = tileDao.detail(session);
    String detailData = (detailArray != null) ? detailArray.toString() : "[]";
%>

<script type="text/javascript" src="<%= cPath %>/scripts/jquery-1.11.1.min.js"></script>

<style>
    /* === GLOBAL STYLES === */
    body { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; background-color: #f4f6f9; color: #333; margin: 0; padding: 0; }
    
    /* === BANNER STYLES (FIXED) === */
    .banner { 
        background-image: url("<%= cPath %>/icons/banner_image.png"); 
        background-size: cover; 
        background-position: center; 
        height: 130px; 
        display: flex; 
        align-items: center; /* Vertically Centers content */
        padding: 0 40px; 
        margin: 15px; 
        border-radius: 6px; 
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        position: relative;
    }
    
    /* Dark overlay to make text readable on any image */
    .banner::before {
        content: ""; position: absolute; top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(0, 0, 0, 0.2); /* Slight dark tint */
        border-radius: 6px;
    }

    .banner-content { z-index: 2; position: relative; }

    .welcome-main { 
        font-size: 26px; 
        font-weight: 700; 
        color: #ffffff; 
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); 
        margin-bottom: 4px;
        letter-spacing: 0.5px;
    }
    
    .user-highlight { color: #ffd700; } /* Gold Color for Name */

    .greeting-sub { 
        font-size: 16px; 
        color: #f0f0f0; 
        font-weight: 500; 
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5); 
        opacity: 0.95;
    }

    /* === LAYOUT === */
    .dashboard-grid { display: grid; grid-template-columns: 1fr 1.6fr; grid-template-rows: auto auto; gap: 20px; padding: 0 15px 40px 15px; }
    .grid-box { background: #ffffff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 10px; min-height: 350px; border: 1px solid #e0e0e0; position: relative; }

    /* === TILES === */
    .grid-box.tile-section { padding: 10px; background: #fff; min-height: auto; }
    .tile-nav-container { display: flex; justify-content: space-between; align-items: center; background-color: #f5f5f5; padding: 8px 10px; border-bottom: 1px solid #ddd; margin-bottom: 10px; border-radius: 4px; overflow-x: auto; }
    .tile-nav-links a { text-decoration: none; color: #555; font-weight: bold; padding: 6px 10px; border-radius: 4px; font-size: 12px; margin-right: 5px; transition: all 0.2s; }
    .tile-nav-links a:hover { background-color: #e0e0e0; color: #000; }
    .tile-nav-links a.active { background-color: #007bff; color: white; }
    .tile-search-box input { padding: 6px 10px 6px 25px; border: 1px solid #ccc; border-radius: 20px; outline: none; width: 140px; font-size: 12px; }
    .tile-search-box i { position: absolute; left: 8px; top: 50%; transform: translateY(-50%); color: #888; font-size: 11px; }

    .dashboard-tile-container { display: flex; flex-wrap: wrap; gap: 12px; padding: 5px; max-height: 280px; overflow-y: auto; border-bottom: 1px solid #eee; }
    .dashboard-tile { background: #fff; border-radius: 4px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); padding: 10px 15px; display: flex; align-items: center; width: calc(33.33% - 8px); min-width: 180px; cursor: pointer; border: 1px solid #e0e0e0; margin-bottom: 5px; height: 60px; text-decoration: none !important; }
    .dashboard-tile:hover { transform: translateY(-2px); box-shadow: 0 3px 6px rgba(0,0,0,0.1); border-color: #ccc; }
    .tile-icon-box { width: 36px; height: 36px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 16px; margin-right: 12px; color: #fff; }
    
    /* Colors */
    .tile-green { background-color: #10b981; } .tile-red { background-color: #ef4444; } .tile-blue { background-color: #3b82f6; } 
    .tile-orange { background-color: #f59e0b; } .tile-purple { background-color: #7c3aed; } .tile-teal { background-color: #008080; } .tile-indigo { background-color: #4b0082; }
    
    .tile-title { font-size: 13px; font-weight: 600; color: #333; margin-bottom: 0px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .tile-desc { font-size: 10px; color: #999; }
    .tile-arrow { color: #ccc; font-size: 10px; margin-left: auto; }

    /* === LISTS === */
    .app-list-container { display: flex; flex-wrap: wrap; gap: 10px; padding: 10px; max-height: 320px; overflow-y: auto; }
    .app-tile { background: #fff; border: 1px solid #e5e7eb; border-left: 4px solid #3b82f6; border-radius: 4px; padding: 12px; width: calc(50% - 6px); cursor: pointer; display: flex; align-items: center; justify-content: space-between; }
    .app-tile:hover { transform: translateY(-2px); box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    .app-tile.active-selection { background-color: #eff6ff; border-color: #3b82f6; box-shadow: inset 0 0 0 1px #3b82f6; }
    .app-name { font-size: 12px; font-weight: 600; color: #444; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
    .app-icon { color: #ccc; font-size: 10px; }
    .app-tile.flagged { border-left-color: #ef4444; } .app-tile.flagged .app-name { color: #b91c1c; }
    .placeholder-label { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); color: #999; font-weight: bold; }
</style>

<div style="padding: 0 15px;">
    <div class="banner">
        <div class="banner-content">
            <div class="welcome-main">
                Welcome <span class="user-highlight">${sessionScope.USERNAME}</span>
            </div>
            <div class="greeting-sub" id="greeting"></div>
        </div>
    </div>
    
    <script>
        var h = new Date().getHours();
        var g = "";
        if (h < 12) { g = "Good Morning"; }
        else if (h < 18) { g = "Good Afternoon"; }
        else { g = "Good Evening"; }
        document.getElementById("greeting").innerText = g;
    </script>
</div>

<div class="dashboard-grid">
    <div class="grid-box"><span class="placeholder-label">Top Left Box (Empty)</span></div>

    <div class="grid-box tile-section">
        <div class="tile-nav-container">
            <div class="tile-nav-links">
                <a href="?module=Finance" class="<%= selectedModule.contains("Finance") ? "active" : "" %>">Finance</a>
                <a href="?module=Operation" class="<%= selectedModule.contains("Operation") ? "active" : "" %>">Operations</a>
                <a href="?module=Fleet" class="<%= selectedModule.contains("Fleet") ? "active" : "" %>">Fleet Mgmt</a>
                <a href="?module=Asset" class="<%= selectedModule.contains("Asset") ? "active" : "" %>">Fixed Assets</a>
                <a href="?module=Human" class="<%= selectedModule.contains("Human") ? "active" : "" %>">Human Resource</a>
                <a href="?module=Control" class="<%= selectedModule.contains("Control") ? "active" : "" %>">Control Centre</a>
            </div>
            <div class="tile-search-box"><i class="fa fa-search"></i><input type="text" id="tileSearchInput" onkeyup="filterTilesLocal()" placeholder="Search..."></div>
        </div>

        <div class="dashboard-tile-container">
            <% if(tiles != null && !tiles.isEmpty()) { for(TileBean t : tiles) { %>
                <a href="javascript:void(0);" onclick="openTabLocal('<%= t.getTitle() %>', '<%= t.getUrl() %>')" class="dashboard-tile">
                    <div class="tile-icon-box <%= t.getColorClass() %>"><i class="<%= t.getIcon() %>"></i></div>
                    <div class="tile-content"><div class="tile-title"><%= t.getTitle() %></div><div class="tile-desc">Click to Open</div></div>
                    <div class="tile-arrow"><i class="fa fa-chevron-right"></i></div>
                </a>
            <% } } else { %> <div style="color: #888; padding: 10px;">No forms found for <b><%= selectedModule %></b>.</div> <% } %>
        </div>
    </div>

    <div class="grid-box" style="padding: 0;">
        <div style="padding:10px 15px; font-weight:bold; color:#555; background:#f9f9f9; border-bottom:1px solid #eee;">Application List</div>
        <div id="appListContainer" class="app-list-container"></div>
    </div>

    <div class="grid-box" style="padding: 0;">
        <div style="padding:10px 15px; font-weight:bold; color:#555; background:#f9f9f9; border-bottom:1px solid #eee;">Status & Updates</div>
        <div id="detailListContainer" class="app-list-container"></div>
    </div>
</div>

<script type="text/javascript">
    var appData = <%= gridData %>; 
    var initialDetails = <%= detailData %>; 

    $(document).ready(function () {
        $("#tileSearchInput").on("keyup", filterTilesLocal);

        var leftContainer = $("#appListContainer");
        if (!appData || appData.length === 0) {
            leftContainer.html("<div style='padding:10px; color:#999;'>No applications found.</div>");
        } else {
            $.each(appData, function(index, item) {
                var isFlagged = (item.flag == 1) ? "flagged" : "";
                var html = '<div class="app-tile ' + isFlagged + '" onclick="openAppDetail(' + index + ', this)">';
                html += '   <div class="app-name">' + item.description + '</div>';
                html += '   <div class="app-icon"><i class="fa fa-chevron-right"></i></div>';
                html += '</div>';
                leftContainer.append(html);
            });
        }
        renderRightPanel(initialDetails);
    });

    function openAppDetail(index, element) {
        var item = appData[index];
        $(".app-tile").removeClass("active-selection");
        $(element).addClass("active-selection");
        $("#detailListContainer").html("<div style='padding:20px; color:#666;'>Loading options...</div>");

        $.ajax({
            url: window.location.href, type: "POST", data: { ajaxId: item.doc_no }, dataType: "json",
            success: function(data) { renderRightPanel(data); },
            error: function(xhr) { 
                try { renderRightPanel($.parseJSON(xhr.responseText.trim())); } 
                catch(e) { $("#detailListContainer").html("<div style='color:red; padding:10px;'>Error loading data.</div>"); }
            }
        });
    }

    function renderRightPanel(data) {
        var rightContainer = $("#detailListContainer");
        rightContainer.empty();
        if (!data || data.length === 0) { rightContainer.html("<div style='padding:10px; color:#999;'>No options available.</div>"); return; }
        $.each(data, function(index, item) {
            var desc = (item.description || "").replace(/'/g, "\\'");
            var path = (item.path || "").replace(/'/g, "\\'");
            var html = '<div class="app-tile" onclick="openDetailLink(\'' + desc + '\', \'' + path + '\', \'' + (item.doc_no||0) + '\', \'' + (item.value||0) + '\')">';
            html += '   <div class="app-name">' + (item.description||"") + '</div>';
            html += '   <div class="app-icon"><i class="fa fa-arrow-right"></i></div></div>';
            rightContainer.append(html);
        });
    }

    function openDetailLink(title, path, docno, value) {
        if (title && title.trim() === 'Movement UpdateNew') { path = "MovementUpdateView.jsp"; }
        var fullUrl = "<%= cPath %>/" + path + "?name=" + title + "&docno=" + docno + "&value=" + value;
        openTabLocal(title, fullUrl);
    }

    function filterTilesLocal() {
        var input = document.getElementById("tileSearchInput").value.toUpperCase();
        var tiles = document.getElementsByClassName("dashboard-tile");
        for (var i = 0; i < tiles.length; i++) {
            var titleDiv = tiles[i].querySelector(".tile-title");
            if(titleDiv) tiles[i].style.display = (titleDiv.innerText.toUpperCase().indexOf(input) > -1) ? "flex" : "none";
        }
    }
    
    function openTabLocal(title, url) {
        var tabContainer = window.parent.$('#tt');
        if (tabContainer.length > 0) {
            if (tabContainer.tabs('exists', title)) { tabContainer.tabs('select', title); } 
            else { tabContainer.tabs('add', { title: title, content: '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>', closable: true }); }
        } else { window.parent.location.href = url; }
    }
</script>