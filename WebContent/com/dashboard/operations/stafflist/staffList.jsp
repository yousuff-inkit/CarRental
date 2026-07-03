<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
}

/* Force layout tables to white, but avoid targeting pure divs to protect color boxes */
.master-layout-table, 
.master-layout-table > tbody > tr, 
.master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #ffffff !important; 
    margin: 0 !important;
    padding: 0 !important;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #ffffff !important;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}

/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}

.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== LEGEND STYLING ===== */
legend {
    font-size: 11px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 5px;
    text-transform: uppercase;
    border-bottom: 1px solid #e3e8ee;
    padding-bottom: 4px;
    display: block;
    width: 100%;
    background: transparent !important;
}

.legend-label {
    text-align: left;
    padding-left: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.color-box {
    width: 16px; 
    height: 16px; 
    border-radius: 3px; 
    border: 1px solid #d1d9e2;
    display: inline-block;
    vertical-align: middle;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    });

    function funreload(event){
        var branchval = document.getElementById("cmbbranch").value;
        var type = document.getElementById("cmbtype").value;
        var check=1;
        $("#overlay, #PleaseWait").show();
        $("#staffListDiv").load("staffListGrid.jsp?branchval="+branchval+'&type='+type+'&check='+check);
    }
    
    function funExportBtn(){
        if(parseInt(window.parent.chkexportdata.value)=="1") {
            JSONToCSVCon(data1, 'StaffList', true);
        } else {
             $("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
        }
     }
</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-scroll-content">
        
        <div class="filter-card">
            <table class="filter-table">
                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="cmbtype" name="cmbtype" onchange="funreload(event);">
                            <option value="">--Select--</option>
                            <option value="SLM">Sales Man</option>
                            <option value="SLA">Sales Agent</option>
                            <option value="RLA">Rental Agent</option>
                            <option value="DRV">Driver</option>
                            <option value="CHK">Check In</option>
                            <option value="STF">Staff</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>

        <div class="filter-card">
            <legend>Legend</legend>
            <table class="filter-table" style="margin-top: 10px;">
                <tr>
                    <td style="width: 20px; text-align: center;"><div class="color-box" style="background:#FFEBEB !important;"></div></td>
                    <td class="legend-label">Sales Man</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><div class="color-box" style="background:#FFFFD1 !important;"></div></td>
                    <td class="legend-label">Sales Agent</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><div class="color-box" style="background:#FFFAFA !important;"></div></td>
                    <td class="legend-label">Rental Agent</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><div class="color-box" style="background:#F0FFFF !important;"></div></td>
                    <td class="legend-label">Driver</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><div class="color-box" style="background:#F8E0F7 !important;"></div></td>
                    <td class="legend-label">Staff</td>
                </tr>
                <tr>
                    <td style="text-align: center;"><div class="color-box" style="background:#F7F2E0 !important;"></div></td>
                    <td class="legend-label">Check In</td>
                </tr>
            </table>
        </div>

    </div>

</div>
</div>
</td>

<td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important;">

    <div style="width: 100%; margin-bottom: 10px;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
        <tr>
             <td valign="top" style="background: transparent !important;">
                 <div id="staffListDiv">
                     <jsp:include page="staffListGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

</body>
</html>