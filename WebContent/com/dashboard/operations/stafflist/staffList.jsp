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
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
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

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

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
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            
            <!-- Filter Options -->
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

            <!-- Modernized Legend -->
            <div class="filter-card">
                <legend>Legend</legend>
                <table class="filter-table" style="margin-top: 10px;">
                    <tr>
                        <td style="width: 20px; text-align: center;"><div class="color-box" style="background:#FFEBEB;"></div></td>
                        <td class="legend-label">Sales Man</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;"><div class="color-box" style="background:#FFFFD1;"></div></td>
                        <td class="legend-label">Sales Agent</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;"><div class="color-box" style="background:#FFFAFA;"></div></td>
                        <td class="legend-label">Rental Agent</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;"><div class="color-box" style="background:#F0FFFF;"></div></td>
                        <td class="legend-label">Driver</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;"><div class="color-box" style="background:#F8E0F7;"></div></td>
                        <td class="legend-label">Staff</td>
                    </tr>
                    <tr>
                        <td style="text-align: center;"><div class="color-box" style="background:#F7F2E0;"></div></td>
                        <td class="legend-label">Check In</td>
                    </tr>
                </table>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="staffListDiv">
                <jsp:include page="staffListGrid.jsp"></jsp:include>
            </div>
            
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>
</div>

</body>
</html>