<%@page import="com.common.ClsExeFolio" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="com.connection.ClsConnection" %>

<%
    ClsExeFolio cef = new ClsExeFolio(); 
    
    Map<String, int[]> docStats = new TreeMap<String, int[]>();
    Connection conn = null; 
    PreparedStatement ps = null; 
    ResultSet rs = null;

    try {
        Object uidObj = session.getAttribute("USERID");
        String userId = (uidObj != null) ? uidObj.toString() : "0"; 

        ClsConnection clsCon = new ClsConnection();
        conn = clsCon.getMyConnection();
        
        // ✅ FIX: Query BOTH my_exdet (history) 
        //        AND my_exeb (pending inbox)
        String sql = 
            // Part 1: History from my_exdet
            "SELECT dtype, apprStatus, COUNT(*) as cnt " +
            "FROM my_exdet " +
            "WHERE userId = ? " +
            "AND apprStatus NOT IN (8,9) " +
            "GROUP BY dtype, apprStatus " +
            
            "UNION ALL " +
            
            // Part 2: Pending inbox from my_exeb
            // These are Level 2+ items waiting for this user
            "SELECT dtype, 0 as apprStatus, COUNT(*) as cnt " +
            "FROM my_exeb " +
            "WHERE userId = ? " +
            "AND approved = 0 " +
            "AND apprlevel != 0 " +
            "GROUP BY dtype";
        
        ps = conn.prepareStatement(sql);
        ps.setString(1, userId);  // for my_exdet
        ps.setString(2, userId);  // for my_exeb
        rs = ps.executeQuery();
        
        while(rs.next()){
            String rawType = rs.getString("dtype");
            int status = rs.getInt("apprStatus");
            int count = rs.getInt("cnt");
            
            if(rawType != null) {
                String docType = rawType.trim().toUpperCase();
                
                if(!docStats.containsKey(docType)) {
                    docStats.put(docType, new int[]{0, 0, 0}); 
                }
                
                int[] counts = docStats.get(docType);
                
                // status=1 → Pending (submitted)
                // status=0 → Pending inbox (my_exeb items)
                // status=3 → Approved
                // others   → Rejected/Returned
                if (status == 1 || status == 0) {
                    counts[0] += count;  // Pending
                } else if (status == 3) {
                    counts[1] += count;  // Approved
                } else {
                    counts[2] += count;  // Rejected/Others
                }
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs!=null) try{ rs.close(); } catch(Exception e){}
        if(ps!=null) try{ ps.close(); } catch(Exception e){}
        if(conn!=null) try{ conn.close(); } catch(Exception e){}
    }
%>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    
    <jsp:include page="../../includes.jsp"></jsp:include>
    <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

    <style>
        /* MAIN LAYOUT */
        html, body { height: 100%; margin: 0; padding: 0; background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; overflow: hidden; }
        .main-container { height: 100vh; display: flex; flex-direction: column; padding: 5px; gap: 5px; box-sizing: border-box; }

        /* HEADER */
        .page-header { flex: 0 0 auto; display: flex; align-items: center; justify-content: space-between; background-color: #fff; padding: 5px 15px; border-radius: 4px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); border-left: 4px solid #007bff; }
        .page-header h2 { margin: 0; font-size: 16px; color: #2c3e50; font-weight: 700; text-transform: uppercase; }

        /* TOP SECTION */
        .top-section { display: flex; gap: 5px; height: 180px; flex-shrink: 0; }

        /* LEFT PANE: Stats Table */
        .stats-pane { 
            flex: 0 0 350px; 
            background: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
            overflow-y: auto; /* Scrollbar for left pane */
            border-top: 3px solid #007bff; 
        }

        /* RIGHT PANE: Grid Container */
        .grid-pane { 
            flex: 1; 
            background: #fff; 
            border-radius: 4px; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
            padding: 0; 
            
            /* UPDATED: Changed from hidden to auto to force scrollbars if content is large */
            overflow: auto; 
            position: relative; /* Helps grid calculate size relative to this container */
            
            border-top: 3px solid #28a745; 
        }

        /* BOTTOM PANE: Form */
        .form-pane { flex: 1; background: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); padding: 0; border: 1px solid #e0e0e0; overflow: hidden; }

        /* TABLE STYLING */
        .stats-table { width: 100%; border-collapse: collapse; font-size: 11px; text-align: center; }
        
        .stats-table th { 
            height: 30px; 
            background-color: #f1f3f4; 
            color: #444; 
            padding: 0 10px; 
            border-bottom: 1px solid #ccc; 
            border-right: 1px solid #ddd;
            position: sticky; top: 0; 
            font-weight: bold; 
            z-index: 1; 
            vertical-align: middle;
        }
        
        .stats-table td { padding: 4px 2px; border-bottom: 1px solid #f1f1f1; color: #555; }
        .stats-table th:first-child, .stats-table td:first-child { text-align: left; padding-left: 10px; }

        /* Badges */
        .badge { padding: 2px 6px; border-radius: 4px; font-weight: bold; font-size: 10px; display: inline-block; min-width: 15px; }
        .badge-pend { background: #fff3cd; color: #856404; } 
        .badge-appr { background: #d4edda; color: #155724; } 
        .badge-rej { background: #f8d7da; color: #721c24; } 
        .badge-zero { color: #ccc; }

        /* UTILITY */
        #folio { width: 100%; height: 100%; border: none; display: block; }
        /* Ensure the included grid div takes full height */
        #approvalData { width: 100%; height: 100%; min-height: 100%; } 
        #btnReload { background-color: #f8f9fa; border: 1px solid #ddd; border-radius: 4px; padding: 3px 6px; cursor: pointer; }
        #overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.3); z-index: 999; }
        #PleaseWait { position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; }
        
        
        /* Update the TOP SECTION to fill the remaining screen height */
.top-section { 
    display: flex; 
    gap: 5px; 
    flex: 1; 
    min-height: 0; 
}
.form-pane { 
    display: none; 
}
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("body").prepend('<div id="overlay" style="display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../icons/31load.gif' alt='Loading...'/></div>");
        });

        function funload(){
            $("#overlay, #PleaseWait").show();
            $("#folio").attr("src", "");
            $("#approvalDataGrid").load("approvalDataGridNew.jsp", function() {
                 location.reload(); 
            });
        }
    </script>
</head>
<body>

    <div class="main-container">
        
        <header class="page-header">
            <div class="header-left">
                <h2>Executive Management Folio</h2>
            </div>
            <div class="header-right">
                <button id="btnReload" title="Reload Data" onclick="funload();">
                    <img src="<%=contextPath%>/icons/icon-reload.png" style="width: 14px; height: 14px; vertical-align: middle;">
              		<span style="padding: 6px; font-weight: bold;">REFRESH</span>  
                </button>
            </div>
        </header>

        <div class="top-section">
            
            <div class="stats-pane">
                <table class="stats-table">
                    <thead>
                        <tr>
                            <th width="25%">Type</th>
                            <th width="25%">Pending</th>
                            <th width="25%">Approved</th>
                            <th width="25%">Rejected</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                           for(Map.Entry<String, int[]> entry : docStats.entrySet()) { 
                               String typeName = entry.getKey();
                               int[] counts = entry.getValue(); 
                        %>
                        <tr>
                            <td><strong><%= typeName %></strong></td>
                            
                            <td><span class="<%= counts[0] > 0 ? "badge badge-pend" : "badge-zero" %>"><%= counts[0] %></span></td>
                            <td><span class="<%= counts[1] > 0 ? "badge badge-appr" : "badge-zero" %>"><%= counts[1] %></span></td>
                            <td><span class="<%= counts[2] > 0 ? "badge badge-rej" : "badge-zero" %>"><%= counts[2] %></span></td>
                        </tr>
                        <% } 
                           if(docStats.isEmpty()) { 
                        %>
                            <tr><td colspan="4" style="padding:10px;">No Data Found</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="grid-pane" id="approvalData">
                <jsp:include page="approvalDataNew.jsp"></jsp:include>
            </div>
        </div>

        <div class="form-pane">
            <iframe id="folio" name="folio" scrolling="yes" src=""></iframe>
        </div>

        <div style="display:none;">
            <input type="hidden" id="formData" />
            <input type="hidden" id="branchid" />
            <input type="hidden" id="mode" />
            <input type="hidden" id="backdateallowed" name="backdateallowed" value='<s:property value="backdateallowed"/>' />
            <input type="hidden" id="pdcascdcdateallowed" name="pdcascdcdateallowed" value='<s:property value="pdcascdcdateallowed"/>' />
            <input type="hidden" id="monthclosed" name="monthclosed" value='<s:property value="monthclosed"/>' />
            <input type="hidden" id="taxdateval" name="taxdateval" value='<s:property value="taxdateval"/>' />
            <input type="hidden" name="formcurrencytype" id="formcurrencytype" value='<s:property value="formcurrencytype"/>' />
            <input type="hidden" id="curdec" name="curdec" value='<s:property value="curdec"/>' />
            <input type="hidden" id="amtdec" name="amtdec" value='<s:property value="amtdec"/>' />
            <input type="hidden" id="chkexportdata" name="chkexportdata" value='<s:property value="chkexportdata"/>' />
        </div>

    </div>

</body>
</html>