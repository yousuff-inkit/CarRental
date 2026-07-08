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
    <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

    <style type="text/css">
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

    /* Tables inside Cards */
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
        width: 80px;
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
        background-color: #ffffff;
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

    /* Readonly / disabled look */
    input[readonly], input:disabled, 
    .filter-table input[readonly], 
    .filter-table input:disabled {
        background-color: #f3f6f9 !important;
        color: #555;
        border-color: #e1e8ed !important;
        cursor: default;
    }

    /* Checkbox styling */
    input[type="checkbox"] {
        margin: 0;
        cursor: pointer;
        width: 14px;
        height: 14px;
        vertical-align: middle;
    }

    .checkbox-wrap {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 12px;
        font-weight: 600;
        color: #4e5e71;
        cursor: pointer;
    }

    /* jqx date/time containers */
    #fromdate, #todate {
        width: 100%;
    }

    /* ===== BUTTONS ===== */
    .btn-submit {
        flex: 1;
        height: 30px !important;            
        padding: 0 5px !important;          
        background: #2563eb !important;
        color: #fff !important;
        border: none !important;
        border-radius: 4px !important;      
        font-size: 12px !important;
        font-weight: 600 !important;
        cursor: pointer;
        line-height: 30px !important;        
        transition: background 0.2s;
        text-align: center;
        width: 100%;
    }

    .btn-submit:hover {
        background: #1d4ed8 !important;
    }

    .btn-submit:disabled {
        background: #9ca3af !important;
        cursor: not-allowed;
    }

    .action-buttons {
        display: flex;
        gap: 8px;
        justify-content: center;
        margin-top: 15px;
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

    .grid-content-container {
        flex: 1;
        padding: 15px;
        overflow: auto;
        box-sizing: border-box;
        position: relative;
    }

    /* Loader Positioning */
    #PleaseWait {
        position: absolute !important;
        z-index: 1002;
        top: 50% !important;
        left: 50% !important;
        transform: translate(-50%, -50%);
    }
    </style>

    <script type="text/javascript">
    $(document).ready(function () {
        $('#attachmaintwindow').jqxWindow({ autoOpen: false,width: '55%', height: '50%',  maxHeight: '70%' ,maxWidth: '78%' , title: '' ,position: { x: 280, y: 120 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide', theme: 'energyblue'});   

        // Standardize jqxDateTimeInputs
        $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var onemonth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));
        $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonth));
        
        $('#todate').on('change',function(event) {
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 

            if (fromdates > todates) {
                $.messager.alert('Message','To Date Less Than From Date  ','warning');
                return false;
            }
        });
    });

    function funreload(event) {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate = $("#fromdate").val();
        var todate = $("#todate").val();

        $("#damagediv").load("damagereportedgrid.jsp?barchval="+barchval+ "&froms="+ fromdate + "&tos=" + todate);
        document.getElementById("fleetno").value="";
        document.getElementById("docno").value="";
        $('#attachbtn').attr("disabled",true);  
    }
        
    function funExportBtn(){
        $("#damagediv").excelexportjs({  
            containerid: "damagediv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "damageGrid", 
            columns: getColumns("damageGrid") , 
            worksheetName:"Damage Reported"
        }); 
    }
        
    function funattachss(){
        var fleetno=document.getElementById("fleetno").value;
        var docno=document.getElementById("docno").value;
        $("#attachmaintwindow").jqxWindow('setTitle',"VIP - "+document.getElementById("docno").value);
        $('#attachmaintwindow').jqxWindow('setContent', '');
        $('#attachmaintwindow').jqxWindow('open');  
        inspSearchContent("newgrid.jsp?fleetno="+fleetno+"&docno="+docno);
    }

    function inspSearchContent(url) {
        $('#attachmaintwindow').jqxWindow('focus'); 
        $.get(url).done(function (data) {
            $('#attachmaintwindow').jqxWindow('setContent', data);
        }); 
    }

    function findis() {
        document.getElementById("fleetno").value="";
        document.getElementById("docno").value="";
        $('#attachbtn').attr("disabled",true);  
    }
    </script>
</head>

<body onload="getBranch();findis()">

    <div id="mainBG" class="homeContent">
        <div class="master-container">

            <!-- ================= LEFT SIDEBAR ================= -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    
                    <!-- Date Filter Card -->
                    <div class="filter-card">
                        <table class="filter-table">
                            <tr>
                                <td class="label-cell">From</td>
                                <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To</td>
                                <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                            </tr>
                        </table>

                        <!-- Buttons -->
                        <div class="action-buttons">
                            <input type="button" name="attachbtn" id="attachbtn" class="btn-submit" value="Attach" onclick="funattachss()">
                        </div>

                        <!-- Chart Placeholder -->
                        <div id="paychaaaaa" style="width:100%; height:170px; margin-top:20px;"></div>
                    </div>
                    
                </div>
            </div>

            <!-- ================= RIGHT SIDE (GRID) ================= -->
            <div class="main-content-area">
                
                <!-- Toolbar/Heading (Moved from Sidebar) -->
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
                
                <div class="grid-content-container">
                    <div id="damagediv">
                        <jsp:include page="damagereportedgrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>

        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" id="fleetno" name="fleetno">
            <input type="hidden" id="docno" name="docno">
        </div>

        <!-- Attach Window -->
        <div id="attachmaintwindow"><div></div></div> 

    </div>

</body>
</html>