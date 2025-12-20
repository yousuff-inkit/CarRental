<%@ page import="java.util.List" %>
<%@ page import="com.dashboard.dto.TileBean" %>
<%@ page import="com.dashboard.ClsDashBoardDAO" %>

<%
    /* FETCH DYNAMIC DATA */
    ClsDashBoardDAO tileDao = new ClsDashBoardDAO();
    String cPath = request.getContextPath();
    List<TileBean> financeTiles = tileDao.getFinanceTiles(cPath);
%>

<style>
    .dashboard-tile-container { display: flex; flex-wrap: wrap; gap: 15px; padding: 10px 15px; font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; }
    .dashboard-tile { background: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 15px 20px; display: flex; align-items: center; width: calc(25% - 15px); min-width: 220px; box-sizing: border-box; cursor: pointer; border: 1px solid #e0e0e0; transition: all 0.2s; text-decoration: none !important; margin-bottom: 10px; }
    .dashboard-tile:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-color: #ccc; }
    .tile-icon-box { width: 45px; height: 45px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 20px; margin-right: 15px; color: #fff; flex-shrink: 0; }
    .tile-green { background-color: #10b981; } .tile-red { background-color: #ef4444; } .tile-blue { background-color: #3b82f6; } .tile-orange { background-color: #f59e0b; } .tile-purple { background-color: #7c3aed; } .tile-teal { background-color: #008080; } .tile-indigo { background-color: #4b0082; }
    .tile-content { flex: 1; }
    .tile-title { font-size: 14px; font-weight: 600; color: #333; margin-bottom: 2px; }
    .tile-desc { font-size: 11px; color: #999; }
    .tile-arrow { color: #ccc; font-size: 12px; }
    @media (max-width: 1000px) { .dashboard-tile { width: calc(50% - 15px); } }
    @media (max-width: 600px) { .dashboard-tile { width: 100%; } }
</style>

<div style="padding: 0 15px;">
    <h3 style="margin: 15px 0 15px 0px; color:#333; font-weight:normal; font-size: 18px;">Finance Operations</h3>
    
    <div class="dashboard-tile-container">
        <% 
        if(financeTiles != null && !financeTiles.isEmpty()) {
            for(TileBean t : financeTiles) { 
        %>
            <a href="javascript:void(0);" 
               onclick="openTabLocal('<%= t.getTitle() %>', '<%= t.getUrl() %>')" 
               class="dashboard-tile">
               
                <div class="tile-icon-box <%= t.getColorClass() %>">
                    <i class="<%= t.getIcon() %>"></i>
                </div>
                <div class="tile-content">
                    <div class="tile-title"><%= t.getTitle() %></div>
                    <div class="tile-desc">Click to Open</div>
                </div>
                <div class="tile-arrow">
                    <i class="fa fa-chevron-right"></i>
                </div>
            </a>
        <% 
            } 
        } else {
        %>
            <div style="color: #888; padding: 10px;">No Finance Modules found in Database.</div>
        <% } %>
    </div>
</div>

<script type="text/javascript">
    function openTabLocal(title, url) {
        console.log("Tile Clicked: " + title);
        
        // 1. Access the Parent Window's jQuery ($) and Tab Container (#tt)
        // We use window.parent because this tile is inside an iframe
        var tabContainer = window.parent.$('#tt');

        if (tabContainer.length > 0) {
            // 2. Check if Tab Exists
            if (tabContainer.tabs('exists', title)) {
                tabContainer.tabs('select', title);
            } else {
                // 3. Create New Tab
                var content = '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>';
                tabContainer.tabs('add', {
                    title: title,
                    content: content,
                    closable: true
                });
            }
        } else {
            console.error("Tab container #tt not found in parent.");
            // Fallback: Open in same window if tabs fail
            window.parent.location.href = url;
        }
    }
</script>