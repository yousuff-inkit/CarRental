<%@ page import="java.util.List" %>
<%@ page import="com.dashboard.dto.TileBean" %>
<%@ page import="com.dashboard.ClsDashBoardDAO" %>

<%
    // 1. Get current module from URL (Default to Finance)
    String selectedModule = request.getParameter("module");
    if(selectedModule == null || selectedModule.trim().isEmpty()){
        selectedModule = "Finance";
    }

    // 2. Fetch data using the Generic DAO
    ClsDashBoardDAO tileDao = new ClsDashBoardDAO();
    String cPath = request.getContextPath();
    List<TileBean> tiles = tileDao.getDashboardTiles(cPath, selectedModule);
%>

<style>
    /* Styling for Nav and Tiles */
    .tile-nav-container { display: flex; justify-content: space-between; align-items: center; background-color: #f5f5f5; padding: 10px 20px; border-bottom: 1px solid #ddd; margin-bottom: 10px; font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; }
    .tile-nav-links a { text-decoration: none; color: #555; font-weight: bold; padding: 8px 15px; margin-right: 5px; border-radius: 4px; font-size: 14px; transition: all 0.3s; }
    .tile-nav-links a:hover { background-color: #e0e0e0; color: #000; }
    .tile-nav-links a.active { background-color: #007bff; color: white; }
    .tile-search-box { position: relative; }
    .tile-search-box input { padding: 8px 10px 8px 30px; border: 1px solid #ccc; border-radius: 20px; outline: none; width: 250px; font-size: 13px; }
    .tile-search-box i { position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #888; }
    
    /* SCROLLABLE CONTAINER: Adjusted height to show exactly 4 rows */
    .dashboard-tile-container { 
        display: flex; 
        flex-wrap: wrap; 
        gap: 15px; 
        padding: 10px 15px; 
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        max-height: 360px; /* REDUCED from 450px to 360px to show exactly 4 rows */
        overflow-y: auto;  
        border-bottom: 1px solid #eee;
    }
    
    /* Custom Scrollbar */
    .dashboard-tile-container::-webkit-scrollbar { width: 8px; }
    .dashboard-tile-container::-webkit-scrollbar-track { background: #f1f1f1; }
    .dashboard-tile-container::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
    .dashboard-tile-container::-webkit-scrollbar-thumb:hover { background: #aaa; }

    .dashboard-tile { background: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 15px 20px; display: flex; align-items: center; width: calc(25% - 15px); min-width: 220px; box-sizing: border-box; cursor: pointer; border: 1px solid #e0e0e0; transition: all 0.2s; text-decoration: none !important; margin-bottom: 10px; }
    .dashboard-tile:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-color: #ccc; }
    .tile-icon-box { width: 45px; height: 45px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 20px; margin-right: 15px; color: #fff; flex-shrink: 0; }
    .tile-green { background-color: #10b981; } .tile-red { background-color: #ef4444; } .tile-blue { background-color: #3b82f6; }
    .tile-orange { background-color: #f59e0b; } .tile-purple { background-color: #7c3aed; } .tile-teal { background-color: #008080; } .tile-indigo { background-color: #4b0082; }
    .tile-content { flex: 1; }
    .tile-title { font-size: 14px; font-weight: 600; color: #333; margin-bottom: 2px; }
    .tile-desc { font-size: 11px; color: #999; }
    .tile-arrow { color: #ccc; font-size: 12px; }
    @media (max-width: 1000px) { .dashboard-tile { width: calc(50% - 15px); } }
    @media (max-width: 600px) { .dashboard-tile { width: 100%; } }
</style>

<div class="tile-nav-container">
    <div class="tile-nav-links">
        <a href="?module=Finance"    class="<%= selectedModule.contains("Finance") ? "active" : "" %>">Finance</a>
        <a href="?module=Operation"  class="<%= selectedModule.contains("Operation") ? "active" : "" %>">Operations</a>
        <a href="?module=Fleet"      class="<%= selectedModule.contains("Fleet") ? "active" : "" %>">Fleet Mgmt</a>
        <a href="?module=Asset"      class="<%= selectedModule.contains("Asset") ? "active" : "" %>">Fixed Assets</a>
        <a href="?module=Human"      class="<%= selectedModule.contains("Human") ? "active" : "" %>">Human Resource</a>
        <a href="?module=Control"    class="<%= selectedModule.contains("Control") ? "active" : "" %>">Control Centre</a>
    </div>
    <div class="tile-search-box">
        <i class="fa fa-search"></i>
        <input type="text" id="tileSearchInput" onkeyup="filterTilesLocal()" placeholder="Search modules...">
    </div>
</div>

<div style="padding: 0 15px;">
    <div class="dashboard-tile-container">
        <% if(tiles != null && !tiles.isEmpty()) {
            for(TileBean t : tiles) { %>
            <a href="javascript:void(0);" onclick="openTabLocal('<%= t.getTitle() %>', '<%= t.getUrl() %>')" class="dashboard-tile">
                <div class="tile-icon-box <%= t.getColorClass() %>"><i class="<%= t.getIcon() %>"></i></div>
                <div class="tile-content">
                    <div class="tile-title"><%= t.getTitle() %></div>
                    <div class="tile-desc">Click to Open</div>
                </div>
                <div class="tile-arrow"><i class="fa fa-chevron-right"></i></div>
            </a>
        <% } } else { %>
            <div style="color: #888; padding: 10px;">
                No forms found for <b><%= selectedModule %></b>.<br>
                <small style="color:#aaa;">(Check your DB for links containing keywords for this module)</small>
            </div>
        <% } %>
    </div>
</div>

<script type="text/javascript">
    function filterTilesLocal() {
        var input = document.getElementById("tileSearchInput");
        var filter = input.value.toUpperCase();
        var tiles = document.getElementsByClassName("dashboard-tile");
        for (var i = 0; i < tiles.length; i++) {
            var titleDiv = tiles[i].querySelector(".tile-title");
            if (titleDiv) {
                var txtValue = titleDiv.textContent || titleDiv.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tiles[i].style.display = "flex";
                } else {
                    tiles[i].style.display = "none";
                }
            }
        }
    }
    function openTabLocal(title, url) {
        var tabContainer = window.parent.$('#tt');
        if (tabContainer.length > 0) {
            if (tabContainer.tabs('exists', title)) {
                tabContainer.tabs('select', title);
            } else {
                var content = '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>';
                tabContainer.tabs('add', { title: title, content: content, closable: true });
            }
        } else {
            window.parent.location.href = url;
        }
    }
</script>