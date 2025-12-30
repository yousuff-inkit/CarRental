<%@ page import="java.util.List" %>
<%@ page import="com.dashboard.dto.TileBean" %>
<%@ page import="com.dashboard.ClsDashBoardDAO" %>

<%
    // 1. Get current module
    String selectedModule = request.getParameter("module");
    if(selectedModule == null || selectedModule.trim().isEmpty()){
        selectedModule = "Finance";
    }

    // 2. Fetch data
    ClsDashBoardDAO tileDao = new ClsDashBoardDAO();
    String cPath = request.getContextPath();
    List<TileBean> tiles = tileDao.getDashboardTiles(cPath, selectedModule);
%>

<style>
    /* === GLOBAL FONTS === */
    body { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; background-color: #f4f6f9; color: #333; margin: 0; padding: 0; }

    /* === 1. BANNER === */
    .banner {
        background-image: url("<%= cPath %>/icons/banner_image.png");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        height: 140px;
        display: flex;
        align-items: center;
        padding-left: 30px;
        margin: 15px;
        border-radius: 4px;
        position: relative;
    }
    .welcome-text { color: white; font-size: 22px; font-weight: 600; text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.6); }
    .user { margin-right: 6px; }
    .user1 { color: #ffd700; }

    /* === 2. 4-BOX GRID LAYOUT === */
    .dashboard-grid {
        display: grid;
        /* Columns: Left (Empty) takes 1 part, Right (Tiles) takes 1.6 parts (Wider to fit Nav) */
        grid-template-columns: 1fr 1.6fr; 
        grid-template-rows: auto auto;    
        gap: 20px;
        padding: 0 15px 40px 15px;
    }

    /* Common Empty Box Style */
    .grid-box {
        background: #ffffff;
        border-radius: 4px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        padding: 10px;
        min-height: 350px; 
        border: 1px dashed #ccc; 
        position: relative;
    }

    /* Top Right Box (Tile Section) - Solid Border */
    .grid-box.tile-section {
        border: 1px solid #e0e0e0;
        border-style: solid;
        padding: 10px; 
        background: #fff;
        min-height: auto;
    }

    .placeholder-label {
        position: absolute;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        color: #999;
        font-weight: bold;
    }

    /* === 3. NAVIGATION BAR (FIXED FOR ONE LINE) === */
    .tile-nav-container {
        display: flex;
        justify-content: space-between; /* Links left, Search right */
        align-items: center;
        background-color: #f5f5f5;
        padding: 8px 10px;
        border-bottom: 1px solid #ddd;
        margin-bottom: 10px;
        border-radius: 4px;
        white-space: nowrap; /* Forces content to stay on one line */
        overflow-x: auto; /* Adds scroll if screen is extremely small */
    }
    
    .tile-nav-links {
        display: flex;
        gap: 4px; /* Tighter gap */
        align-items: center;
    }

    .tile-nav-links a {
        text-decoration: none;
        color: #555;
        font-weight: bold;
        padding: 6px 10px; /* Reduced padding slightly */
        margin-right: 0;
        border-radius: 4px;
        font-size: 12px; /* Smaller font ensures "Human Resource" fits */
        transition: all 0.3s;
        white-space: nowrap; 
    }
    .tile-nav-links a:hover { background-color: #e0e0e0; color: #000; }
    .tile-nav-links a.active { background-color: #007bff; color: white; }

    /* Compact Search Box */
    .tile-search-box { position: relative; margin-left: 10px; flex-shrink: 0; }
    .tile-search-box input {
        padding: 6px 10px 6px 25px;
        border: 1px solid #ccc;
        border-radius: 20px;
        outline: none;
        width: 140px; /* Reduced width to fit line */
        font-size: 12px;
    }
    .tile-search-box i {
        position: absolute; left: 8px; top: 50%; transform: translateY(-50%); color: #888; font-size: 11px;
    }

    /* === 4. TILE GRID (YOUR STYLE) === */
    .dashboard-tile-container { 
        display: flex; 
        flex-wrap: wrap; 
        gap: 12px; 
        padding: 5px; 
        max-height: 280px; 
        overflow-y: auto;  
        border-bottom: 1px solid #eee;
    }
    
    .dashboard-tile-container::-webkit-scrollbar { width: 6px; }
    .dashboard-tile-container::-webkit-scrollbar-track { background: #f1f1f1; }
    .dashboard-tile-container::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }

    /* Your Original Tile Style */
    .dashboard-tile { 
        background: #fff; 
        border-radius: 4px; 
        box-shadow: 0 1px 2px rgba(0,0,0,0.1); 
        padding: 10px 15px; 
        display: flex; 
        align-items: center; 
        /* 3 Tiles Per Row in the layout */
        width: calc(33.33% - 8px); 
        min-width: 180px; 
        box-sizing: border-box; 
        cursor: pointer; 
        border: 1px solid #e0e0e0; 
        transition: all 0.2s; 
        text-decoration: none !important; 
        margin-bottom: 5px; 
        height: 60px; 
    }
    .dashboard-tile:hover { transform: translateY(-2px); box-shadow: 0 3px 6px rgba(0,0,0,0.1); border-color: #ccc; }
    
    .tile-icon-box { width: 36px; height: 36px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 16px; margin-right: 12px; color: #fff; flex-shrink: 0; }
    .tile-green { background-color: #10b981; } .tile-red { background-color: #ef4444; } .tile-blue { background-color: #3b82f6; }
    .tile-orange { background-color: #f59e0b; } .tile-purple { background-color: #7c3aed; } .tile-teal { background-color: #008080; } .tile-indigo { background-color: #4b0082; }
    
    .tile-content { flex: 1; overflow: hidden; }
    .tile-title { font-size: 13px; font-weight: 600; color: #333; margin-bottom: 0px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .tile-desc { font-size: 10px; color: #999; }
    .tile-arrow { color: #ccc; font-size: 10px; }

    @media (max-width: 1200px) { 
        .dashboard-grid { grid-template-columns: 1fr; } /* Stack columns */
        .dashboard-tile { width: calc(50% - 8px); }
    }
</style>

<div style="padding: 0 15px;">
    <div class="banner">
        <div class="welcome-text">
            <span class="user">Welcome</span>
            <span class="user1">${sessionScope.USERNAME}</span>
            <h2 class="user" id="greeting" style="margin: 5px 0 0 0; font-size: 18px; font-weight: normal;"></h2>
            <script>
                const h = new Date().getHours();
                document.getElementById("greeting").innerText = (h<12?"Good Morning":(h<18?"Good Afternoon":"Good Evening"));
            </script>
        </div>
    </div>
</div>

<div class="dashboard-grid">

    <div class="grid-box">
        <span class="placeholder-label">Top Left Box (Empty)</span>
    </div>

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
            <div class="tile-search-box">
                <i class="fa fa-search"></i>
                <input type="text" id="tileSearchInput" onkeyup="filterTilesLocal()" placeholder="Search...">
            </div>
        </div>

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
                    No forms found for <b><%= selectedModule %></b>.
                </div>
            <% } %>
        </div>
    </div>

    <div class="grid-box">
        <span class="placeholder-label">Bottom Left Box (Empty)</span>
    </div>

    <div class="grid-box">
        <span class="placeholder-label">Bottom Right Box (Empty)</span>
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