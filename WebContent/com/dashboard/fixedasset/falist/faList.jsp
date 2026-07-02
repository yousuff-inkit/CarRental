<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
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

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
}

/* Readonly / disabled look */
input[readonly], input:disabled, 
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="periodupto"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
    margin-top: 15px;
}

.btn-submit:hover { background: #1d4ed8; }
.btn-submit:disabled {
    background: #cbd5e1 !important;
    cursor: not-allowed;
    color: #64748b !important;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
    $(document).ready(function() {
        // Standardized height to 24px and width to 100%
        $("#periodupto").jqxDateTimeInput({
            width : '100%',
            height : '24px',
            formatString : "dd.MM.yyyy"
        });
        
        // Note: jqxWindow requires TWO nested divs to function correctly
        $('#assetwindow').jqxWindow({
            width : '40%',
            height : '60%',
            maxHeight : '60%',
            maxWidth : '40%',
            title : 'Asset Group Search',
            position : { x : 250, y : 60 },
            keyboardCloseKey : 27,
            theme: 'energyblue'
        });
        $('#assetwindow').jqxWindow('close');

        $('#assetgrp').dblclick(function() {
            $('#assetwindow').jqxWindow('open');
            $('#assetwindow').jqxWindow('focus');
            assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
        });
    });
    
    function getAssetGroup(event) {
        var x = event.keyCode;
        if (x == 114) {
            $('#assetwindow').jqxWindow('open');
            $('#assetwindow').jqxWindow('focus');
            assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
        } 
    }
    
    function assetSearchContent(url) {
        $.get(url).done(function(data) {
            $('#assetwindow').jqxWindow('setContent', data);
        });
    }
    
    function funreload(event) {
        $("#falistdiv").load("faListGrid.jsp?branch=" + document.getElementById("cmbbranch").value + "&assetgroup=" + document.getElementById("hidassetgrp").value + '&check=1');
    }

    function setValues() {
        if ($('#msg').val() != "") {
            $.messager.alert('Message', $('#msg').val());
        }
    }
    
    function funExportBtn() {
        JSONToCSVCon(exportdata, 'Fixed Asset List', true);
    }
</script>
</head>

<body onload="getBranch();setValues();">
    <form id="frmFAList" action="frmFAList" method="post">

        <div id="mainBG" class="homeContent" data-type="background">

            <div class="master-container">

                <div class="sidebar-filters">
                    <div class="sidebar-scroll-content">

                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Period Upto</td>
                                    <td>
                                        <div id="periodupto"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Asset Group</td>
                                    <td>
                                        <input type="text" name="assetgrp" id="assetgrp"
                                            readonly
                                            placeholder="Press F3 to Search"
                                            onkeydown="getAssetGroup(event);"> 
                                            
                                        <input type="hidden" name="hidassetgrp" id="hidassetgrp">
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </div>
                </div>

                <div class="main-content-area">
                    
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="falistdiv">
                            <jsp:include page="faListGrid.jsp"></jsp:include>
                        </div>
                        
                        <div style="display:none;">
                            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                        </div>
                    </div>

                </div>

            </div>

            <div id="assetwindow">
                <div></div><div></div>
            </div>

        </div>
    </form>
</body>

</html>