<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />

<style>
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
    $("#nonrevenuedate").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString:"dd.MM.yyyy"
    });
});

function funreload(event) {
    var barchval = document.getElementById("cmbbranch").value;
    var exdate = $('#nonrevenuedate').val();
    $("#nondiv").load("nonrevenueGrid.jsp?barchval="+barchval+'&exdate='+exdate);
}

function funExportBtn(){
    $("#nondiv").excelexportjs({
        containerid: "nondiv", 
        datatype: 'json', 
        dataset: null, 
        gridId: "nonmovement", 
        columns: getColumns("nonmovement"),   
        worksheetName:"Non Revenue Movement"
    });
}
</script>

</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <div class="sidebar-scroll-content">

                <!-- Date Filter -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div style="display:flex; align-items:center; gap:6px;">

                                    <div id="nonrevenuedate"
                                         name="nonrevenuedate"
                                         value='<s:property value="nonrevenuedate"/>'>
                                    </div>

                                    <!-- Visible Calendar Icon -->
                                   

                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Pie Chart -->
                <div class="filter-card">
                    <div id="pieChart1" style="width:100%; height:170px;"></div>
                </div>

            </div>
        </div>
    </div>
</td>

<!-- ================= RIGHT CONTENT ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="nondiv">
                    <jsp:include page="nonrevenueGrid.jsp"></jsp:include>
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