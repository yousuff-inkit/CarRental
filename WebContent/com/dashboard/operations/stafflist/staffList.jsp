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
<style>
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
</style>


<script type="text/javascript">

	$(document).ready(function () {
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
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

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="cmbtype"
                            name="cmbtype">
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

        <!-- LEGEND (MASTER STYLE – NO GREEN BG) -->
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td style="width:12px;background:#FFEBEB;"></td>
                <td class="label-cell">Sales Man</td>
            </tr>

            <tr>
                <td style="background:#FFFFD1;"></td>
                <td class="label-cell">Sales Agent</td>
            </tr>

            <tr>
                <td style="background:#FFFAFA;"></td>
                <td class="label-cell">Rental Agent</td>
            </tr>

            <tr>
                <td style="background:#F0FFFF;"></td>
                <td class="label-cell">Driver</td>
            </tr>

            <tr>
                <td style="background:#F8E0F7;"></td>
                <td class="label-cell">Staff</td>
            </tr>

            <tr>
                <td style="background:#F7F2E0;"></td>
                <td class="label-cell">Check In</td>
            </tr>

        </table>
        </div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
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